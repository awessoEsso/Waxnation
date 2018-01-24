//
//  SignInViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 21/01/2018.
//  Copyright © 2018 Esso AWESSO. All rights reserved.
//

import UIKit

protocol SignInViewControllerDelegate: NSObjectProtocol {
    func signInViewControllerDelegate(_ signInViewControllerDelegate: SignInViewControllerDelegate, didSignIn user: User)
    func signInViewControllerDelegateDidDismiss()
    func signInViewControllerDelegateDidTapSignUp()
    
}

class SignInViewController: UIViewController {
    
    var delegate: SignInViewControllerDelegate?

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    deinit {
        print("SignInViewController deinited")
    }
    
    
    // MARK: - Navigation
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        switch destination {
        case is SignUpViewController:
            dismiss(animated: true, completion: nil)
        default:
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func didTapSignUp(_ sender: UIButton) {
        delegate?.signInViewControllerDelegateDidTapSignUp()
    }
    
    @IBAction func signInAction(_ sender: UIButton) {
        
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            displayAlertMessage(messageToDisplay: "Some informations are missing")
            return
        }
        
        FirebaseManager.shared.loginUser(withEmail: email, password: password) { [weak weakSelf = self](status) in
            DispatchQueue.main.async {
                
                if status == true {
                    weakSelf?.pushToHomeView()
                } else {
                    weakSelf?.displayAlertMessage(messageToDisplay: "Error login user ")
                }
                weakSelf = nil
            }
            
        }
    }
    
    func pushToHomeView() {
        
    }
        
        func displayAlertMessage(messageToDisplay: String)
        {
            let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                
                // Code in this block will trigger when OK button tapped.
                print("Ok button tapped");
                
            }
            
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
        }
    
}
