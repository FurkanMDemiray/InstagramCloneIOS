//
//  ViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 5.11.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        
    }

    @IBAction func signInBtn(_ sender: Any) {

        if mailField.text != "" && passwordField.text != "" {

            Auth.auth().signIn(withEmail: mailField.text!, password: passwordField.text!) { authData, error in
                if error != nil {

                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")

                } else {
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }


        } else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }
    }

    @IBAction func signUpBtn(_ sender: Any) {


        if let mail = mailField.text, let password = passwordField.text {

            Auth.auth().createUser(withEmail: mail, password: password) { authData, error in

                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")
                } else {
                    self.performSegue(withIdentifier: "toTabBarVC", sender: nil)
                }
            }

        }
        else {
            makeAlert(titleInput: "Error!", messageInput: "Username/Password?")
        }


    }

    func makeAlert(titleInput: String, messageInput: String) {

        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)

    }
}

