//
//  UpcomingCell.swift
//  Netflix
//
//  Created by Amirkhouzam on 18/02/2022.
//

import UIKit

class UpcomingCell: UITableViewCell {

    @IBOutlet weak var filmname: UILabel!
    @IBOutlet weak var filmimg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .black
        self.filmname.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
