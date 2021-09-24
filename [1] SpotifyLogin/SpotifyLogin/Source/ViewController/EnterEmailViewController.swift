//
//  EnterEmailViewController.swift
//  SpotifyLogin
//
//  Created by 김승찬 on 2021/09/25.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    
    // MARK: @IBOutlet Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
        attributeButton()
        firstResponderTextField()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initNavigationBar()
    }
    
    // MARK: Functions
        // Navigation 보이기
    private func initNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    private func assignDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
        // 뷰 로드 후, 커서를 이메일 텍스트필드로 이동
    private func firstResponderTextField() {
        emailTextField.becomeFirstResponder()
    }
    
    private func attributeButton() {
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
    }
        // 로그인 완료 시 -> 메인
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
        // 이미 가입한 사람 확인
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self]
            _, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
    // MARK: @IBAction
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        // Firebase 이메일 / 비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self]AuthResult, error in
            guard let self = self else { return }
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: // 이미 가입한 계정
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else {
                self.showMainViewController()
            }
        }
    }
}

    // MARK: Extension
extension EnterEmailViewController: UITextFieldDelegate {
        // 텍스트필드 입력 후 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
        // 이메일, 비밀번호 입력 -> 로그인 버튼 활성화
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
