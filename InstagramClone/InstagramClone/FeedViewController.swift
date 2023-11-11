//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 6.11.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import SDWebImage


class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!

    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var userImageArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()



        feedTableView.delegate = self
        feedTableView.dataSource = self

        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    func getData() {

        let firebaseStorage = Firestore.firestore()


        firebaseStorage.collection("Posts").addSnapshotListener { snapShot, error in

            if let err = error {

                self.makeAlert(title: "Error", error: err.localizedDescription)
            }
            else {

                if snapShot?.isEmpty == false {

                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.userImageArray.removeAll(keepingCapacity: false)

                    for document in snapShot!.documents {

                        //let id = document.documentID

                        if let postedBy = document.get("postedBy") as? String {
                            print(postedBy)
                            self.userEmailArray.append(postedBy)
                        }
                        if let postComment = document.get("postComment") as? String {
                            print(postComment)
                            self.userCommentArray.append(postComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            print(likes)
                            self.likeArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            print(imageUrl)
                            self.userImageArray.append(imageUrl)
                        }
                    }
                }
                self.feedTableView.reloadData()

            }
        }

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Array index : ", userEmailArray.count)
        return userEmailArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell

        cell.userMail.text = userEmailArray[indexPath.row]
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))


        return cell
    }


    func makeAlert(title: String, error: String) {

        let alert = UIAlertController(title: title, message: error, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)

        alert.addAction(okButton)

        self.present(alert, animated: true, completion: nil)

    }

}
