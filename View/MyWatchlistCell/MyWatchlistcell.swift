//
//  MyWatchlistcell.swift
//  Netflix
//
//  Created by Amirkhouzam on 21/02/2022.
//

import UIKit

class MyWatchlistcell: UICollectionViewCell {

    @IBOutlet weak var filmimage: UIImageView!
    @IBOutlet weak var filmname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        filmimage.backgroundColor = .clear
        filmname.textColor = .white
    }

}
