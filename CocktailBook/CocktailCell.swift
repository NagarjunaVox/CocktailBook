//
//  CocktailCell.swift
//  CocktailBook
//
//  Created by Nagarjuna on 3/1/24.
//

import UIKit

class CocktailCell: UITableViewCell {
    
    @IBOutlet weak var titleLable:UILabel!
    @IBOutlet weak  var shortDescriptionLbl:UILabel!
    @IBOutlet weak  var favImage:UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
