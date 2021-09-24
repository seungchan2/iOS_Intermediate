//
//  MainViewController.swift
//  SpotifyLogin
//
//  Created by 김승찬 on 2021/09/25.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    // MARK: @IBOutlet Property
    @IBOutlet weak var welcomeLabel: UILabel!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactiveNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNavigationBar()
        initWelcomeLabel()
    }
    
    // MARK: Functions
        // 뒤로가기 처리
    private func interactiveNavigationBar() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
        // 네비게이션바 숨기기
    private func hiddenNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initWelcomeLabel() {
        let email = Auth.auth().currentUser?.email ?? "고객"
        welcomeLabel.text = """
        환영합니다
        \(email)님
        """
    }
    
    // MARK: @IBAction
    
    @IBAction func tapLogoutButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            // 에러가 발생하지 않으면
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            // 에러가 발생하면
            print ("Error signing out: %@", signOutError)
        }
    }
}
