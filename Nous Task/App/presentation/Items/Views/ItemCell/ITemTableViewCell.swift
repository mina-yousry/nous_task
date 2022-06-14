//
//  ITemTableViewCell.swift
//  Nous Task
//
//  Created by Mina Yousry on 6/14/22.
//  Copyright © 2022 Mina Yousry. All rights reserved.
//

import UIKit
import Kingfisher

class ITemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(item: Item) {
        itemImage.kf.setImage(with: URL(string: item.imageURL))
        title.text = item.title
        descriptionLbl.text = item.itemDescription
    }
    
    override func prepareForReuse() {
        title.text = ""
        descriptionLbl.text = ""
        itemImage.image = nil
    }
    
}
