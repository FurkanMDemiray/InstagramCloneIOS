//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Melik Demiray on 11.11.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

class FeedCell: UITableViewCell {


    @IBOutlet weak var userMail: UILabel!

    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var userImageView: UIImageView!

    @IBOutlet weak var likeLabel: UILabel!

    @IBOutlet weak var idLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeButtonClicked(_ sender: Any) {

        
        // update firestore database
        let fireStoreDatabase = Firestore.firestore()

        if let likesCount = Int(likeLabel.text!) {

            fireStoreDatabase.collection("Posts").document(idLabel.text!).setData(["likes": likesCount + 1], merge: true)

        }

    }
}
