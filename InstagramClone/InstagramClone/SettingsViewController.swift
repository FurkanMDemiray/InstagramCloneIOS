//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 6.11.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }



    @IBAction func logoutBtn(_ sender: Any) {


        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toMainVC", sender: nil)
        } catch {
            print("error!")
        }


    }
}
