//
//  cocktailCell.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit
import SDWebImage
class cocktailCell: UICollectionViewCell {

    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cocktailNameLabel: UILabel!
    
    var cocktail : simpleCocktail = simpleCocktail()
    {
        didSet{
            cocktailNameLabel.text = cocktail.strDrink
            cocktailImage.sd_setImage(with: URL.init(string: cocktail.strDrinkThumb) )
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
