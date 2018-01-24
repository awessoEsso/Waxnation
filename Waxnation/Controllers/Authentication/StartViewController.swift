//
//  StartViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 21/01/2018.
//  Copyright © 2018 Esso AWESSO. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        switch destination {
        case is SignUpViewController:
            if let signUpViewController = destination as? SignUpViewController {
                signUpViewController.delegate = self
            }
            break
        case is SignInViewController:
            if let signInViewController = destination as? SignInViewController {
                signInViewController.delegate = self
            }
            break
        default:
            print("unknown")
        }
    }
 

}


extension StartViewController: SignInViewControllerDelegate {
    func signInViewControllerDelegate(_ signInViewControllerDelegate: SignInViewControllerDelegate, didSignIn user: User) {
        
    }
    
    func signInViewControllerDelegateDidDismiss() {
        
    }
    
    func signInViewControllerDelegateDidTapSignUp() {
        dismiss(animated: false, completion: nil)
        let signUpViewController = UIStoryboard.signUpViewController()
        signUpViewController.delegate = self
        present(signUpViewController, animated: true, completion: nil)
    }
    
    
}

extension StartViewController: SignUpViewControllerDelegate {
    func signUpViewControllerDelegate(_ signUpViewController: SignUpViewController, didSignUp user: User) {
        
    }
    
    func signUpViewControllerDelegateDidDismiss() {
        dismiss(animated: false, completion: nil)
    }
    
    func signUpViewControllerDelegateDidTapSignIn() {
        dismiss(animated: false, completion: nil)
        let signInViewController = UIStoryboard.signInViewController()
        signInViewController.delegate = self
        present(signInViewController, animated: true, completion: nil)
    }
    
    
}
