//
//  LoginViewController.swift
//  CinePlay
//
//  Created by wesley on 28/08/17.
//  Copyright © 2017 wesley. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    final let USER_URL = "https://my-json-server.typicode.com/wesleymuniz/mediaapi/users/"
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func validateLogin(){
        let username:String = self.usernameTextField.text!
        let password:String = self.passwordTextField.text!
        let USER_URL_ID = "\(self.USER_URL)\(username)"
        Alamofire.request(USER_URL_ID).responseJSON { (responseData) -> Void in
            let result = responseData.result
            if((result.value) != nil) {
                let userDict = JSON(result.value!)
                let remotePassword = userDict["password"].string!
                if password == remotePassword {
                    self.storeLoginDataInUserDefaults(username, password)
                    self.presentMovieListScreen()
                }
            }
        }
    }
    
    func presentMovieListScreen() {
        let navigationController = self.storyboard?.instantiateViewController(withIdentifier:"NavigationController") as! UINavigationController
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func storeLoginDataInUserDefaults(_ username: String, _ password: String){
        let defaults = UserDefaults.standard
        defaults.set(username, forKey: "username")
        defaults.set(password, forKey: "password")
    }
    
    func loadLoginDataFromUserDefaults() {
        let defaults = UserDefaults.standard
        self.usernameTextField.text = defaults.object(forKey: "username") as? String
        self.passwordTextField.text = defaults.object(forKey: "password")  as? String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        self.loadLoginDataFromUserDefaults()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        self.validateLogin()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
