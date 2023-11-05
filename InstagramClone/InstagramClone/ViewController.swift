//
//  ViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 5.11.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signInBtn(_ sender: Any) {
        
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }

    @IBAction func signUpBtn(_ sender: Any) {
    }
}

