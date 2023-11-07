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


    @IBAction func uploadBtnAction(_ sender: Any) {

        print("tıklandı upload button")
        let storage = Storage.storage()
        let storageRef = storage.reference()

        let mediaFolder = storageRef.child("media")

        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {

            let imageReference = mediaFolder.child("image.jpg")
            imageReference.putData(data) { metaData, error in

                if let err = error {
                    print(err.localizedDescription)
                } else {
                    imageReference.downloadURL { url, error in

                        if error == nil {
                            if let imageUrl = url?.absoluteString {
                                print(imageUrl)
                            }

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
