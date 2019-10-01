//
//  BookDetailViewController.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import UIKit
import Kingfisher

struct BookDetailConfiguration {
    var id: Int?
    var name: String?
    var author: String?
    var isAvailable: Bool?
    var popularityIndex: Int?
    var imageURL: String?
}


class BookDetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var id: UILabel!
    var object: BookDetailConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        guard let object = object else { return }
        name.text = object.name
        author.text = object.author
        // == true avoid optional warnig TODO :- guard
        if object.isAvailable == true {
            availability.text = "available"
        } else {
            availability.text = "not available"
        }
        if let popularity = object.popularityIndex {
            self.popularity.text = "\(popularity)"
        } else {
            self.popularity.text = ""
        }
        id.text = "\(object.id)"
        guard let url = object.imageURL else { image.image = nil; return }
        let imageURL = URL(string: url)
        image.kf.setImage(with: imageURL)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
