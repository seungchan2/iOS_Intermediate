//
//  LoginViewController.swift
//  SpotifyLogin
//
//  Created by 김승찬 on 2021/09/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: @IBOutlet Properties
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        attributeButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    // MARK: Functions
    
    // forEach 를 써서 버튼 속성 부여
    private func attributeButton() {
        [emailLoginButton,googleLoginButton,appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    private func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: @IBAction
    @IBAction func tapGoogleButton(_ sender: Any) {
        // Firebase 인증
    }
    @IBAction func tapAppleButton(_ sender: Any) {
        // Firebase 인증
    }
}
