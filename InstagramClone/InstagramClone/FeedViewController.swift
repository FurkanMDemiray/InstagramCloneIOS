//
//  FeedViewController.swift
//  InstagramClone
//
//  Created by Melik Demiray on 6.11.2023.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var feedTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()


        feedTableView.delegate = self
        feedTableView.dataSource = self

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell

        cell.commentLabel.text = "comment"
        cell.likeLabel.text = "0"
        cell.userImageView.image = UIImage(named: "Homer.png")
        cell.userMail.text = "deneme@gmail.com"

        return cell
    }

}
