//
//  ProfileChangeViewController.swift
//  guru3
//
//  Created by dm13 on 2018. 1. 24..
//  Copyright © 2018년 Jeongwon Na. All rights reserved.
//

import UIKit

class ProfileChangeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func changeButton(_ sender: UIButton) {
        UserDefaults.standard.set(passwordTextField.text, forKey:"userPassword")
        UserDefaults.standard.set(nickNameTextField.text, forKey:"userNickname")
        UserDefaults.standard.synchronize()
        self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeProfilePhoto(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        profilePhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        if let userNameStored = UserDefaults.standard.string(forKey: "userName"){
            userNameLabel.text = userNameStored
        }
        if let userNicknameStored = UserDefaults.standard.string(forKey: "userNickname"){
            nickNameTextField.text = userNicknameStored
        }
        if let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword"){
            passwordTextField.text = userPasswordStored
        }
        
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
