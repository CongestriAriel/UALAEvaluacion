//
//  CollectionViewCell.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import UIKit
import Kingfisher

struct BookListConfigutarion {
    var name: String?
    var author: String?
    var isAvailable: Bool?
    var popularityIndex: Int?
    var image: String?
}

class BookListCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var availability: UILabel!
    @IBOutlet weak var popularity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(With object: BookListConfigutarion) {

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
        guard let url = object.image else { image.image = nil; return }
        let imageURL = URL(string: url)
        image.kf.setImage(with: imageURL)
    }

}
