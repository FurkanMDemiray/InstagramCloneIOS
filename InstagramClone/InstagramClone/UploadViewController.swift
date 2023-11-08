//
//  UploadViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 6.11.2023.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var uploadBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()


        imageView.isUserInteractionEnabled = true


        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(imageGesture)


    }

    func makeAlert(title: String, message: String) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }


    @IBAction func uploadBtnAction(_ sender: Any) {


        let name = UUID().uuidString

        let storage = Storage.storage()
        let storageRef = storage.reference()

        let mediaFolder = storageRef.child("media")

        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {

            let imageReference = mediaFolder.child("\(name).jpg")
            imageReference.putData(data) { metaData, error in

                if let err = error {
                    self.makeAlert(title: "Error", message: err.localizedDescription)
                } else {
                    imageReference.downloadURL { url, error in

                        if error == nil {
                            if let imageUrl = url?.absoluteString {
                                print(imageUrl)
                            }


                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference: DocumentReference? = nil

                            let firestorePost = ["imageUrl": url?.absoluteString, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.nameField.text!, "date": FieldValue.serverTimestamp(), "likes": 0] as [String: Any]

                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in

                                if let err = error {

                                    self.makeAlert(title: "Error", message: err.localizedDescription)
                                }
                                else {

                                    self.tabBarController?.selectedIndex = 0
                                    print("Success")

                                }
                            })


                        }
                    }
                }

            }
        }


    }
    @objc func chooseImage() {

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)

    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}
