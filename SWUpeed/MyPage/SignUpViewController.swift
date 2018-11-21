//
//  SignUpViewController.swift
//  guru3
//
//  Created by dm13 on 2018. 1. 24..
//  Copyright © 2018년 Jeongwon Na. All rights reserved.
//

import UIKit
import NotificationCenter

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{

   
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var profilePhotoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let userId = idField.text
        let userPassword = passwordField.text
        let userName = nameField.text
        let userNickname = nicknameField.text
        
        if((userId?.isEmpty)! || (userPassword?.isEmpty)! || (userName?.isEmpty)! || (userNickname?.isEmpty)!)
        {
            displayMyAlertMessage(userMessage: "모든 항목을 채워주세요.")
            return
        }
    
        UserDefaults.standard.set(userId, forKey:"userId")
        UserDefaults.standard.set(userPassword, forKey:"userPassword")
        UserDefaults.standard.set(userName, forKey:"userName")
        UserDefaults.standard.set(userNickname, forKey:"userNickname")
        UserDefaults.standard.synchronize()
        
        let myAlert = UIAlertController(title:"축하합니다!", message: userName! + "님 회원가입이 완료되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){ action in
            self.dismiss(animated: true, completion: nil)
        }
        
        myAlert.addAction(okAction)
        self.present(myAlert, animated:true, completion:nil)
    }
    
    
    func displayMyAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title:"회원가입", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title:"확인", style: UIAlertActionStyle.default, handler:nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated:true, completion:nil)
    }
    
    @IBAction func selectProfilePhoto(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        profilePhotoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        /*UserDefaults.standard.set(profilePhotoImageView.image, forKey:"savedImage")*/
        
        /*let path = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
        let newPath = path.URLByAppendingPathComponent(profilePhotoImageView.image)
        if let data = UIImagePNGRepresentation(profilePhotoImageView.image!) {
         let filename = getDocumentsDirectory().appendingPathComponent("copy.png")
         try? data.write(to: filename)
         }*/
        
       /* let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("copy")
        //get the image we took with camera
        let image = profilePhotoImageView.image!
        //get the PNG data for this image
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)*/
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
