//
//  SignUpViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 21/01/2018.
//  Copyright © 2018 Esso AWESSO. All rights reserved.
//

import UIKit
import Photos

protocol SignUpViewControllerDelegate: NSObjectProtocol {
    func signUpViewControllerDelegate(_ signUpViewController: SignUpViewController, didSignUp user: User)
    func signUpViewControllerDelegateDidDismiss()
    func signUpViewControllerDelegateDidTapSignIn()
    
}

class SignUpViewController: UIViewController {
    
    var delegate: SignUpViewControllerDelegate?
    
    @IBOutlet weak var imageButton: UIButton!
    
    

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("SignUpViewController deinited")
    }
    
     // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        
        switch destination {
        case is SignInViewController:
            dismiss(animated: true, completion: nil)
        default:
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func pickImageAction(_ sender: UIButton) {
        
        let sheet = UIAlertController(title: nil, message: "Select the source", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .camera)
        })
        let photoAction = UIAlertAction(title: "Gallery", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.openPhotoPickerWith(source: .library)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cameraAction)
        sheet.addAction(photoAction)
        sheet.addAction(cancelAction)
        self.present(sheet, animated: true, completion: nil)
    }
    
    func openPhotoPickerWith(source: PhotoSource) {
        switch source {
        case .camera:
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        case .library:
            let status = PHPhotoLibrary.authorizationStatus()
            if (status == .authorized || status == .notDetermined) {
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = true
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
    }
    
 
    @IBAction func didSignIn(_ sender: UIButton) {
        delegate?.signUpViewControllerDelegateDidTapSignIn()
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        guard let email = emailTextfield.text, let password = passwordTextField.text, let profileImage = imageButton.image(for: .normal) else {
            displayAlertMessage(messageToDisplay: "Some informations are missing")
            return
        }
        
        
        FirebaseManager.shared.registerUser(email: email, password: password, profilePic: profileImage) { [weak weakSelf = self] (status) in
            
            DispatchQueue.main.async {
                weakSelf?.emailTextfield.text = ""
                weakSelf?.passwordTextField.text = ""
                if status == true {
                    weakSelf?.pushToHomeView()
                    weakSelf?.imageButton.setImage(UIImage.init(named: "add photo"), for: .normal)
                } else {
                    weakSelf?.displayAlertMessage(messageToDisplay: "Error saving data")
                }
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imageButton.setImage(pickedImage, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

enum PhotoSource {
    case library
    case camera
}
