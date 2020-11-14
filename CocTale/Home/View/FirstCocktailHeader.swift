//
//  FirstCocktailHeader.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/10/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit

class FirstCocktailHeader: UICollectionReusableView {

    @IBOutlet weak var largeTitleLabel: UILabel!
    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func headerSetup(isFirstSection:Bool , sectionTitle : String)
    {
        self.largeTitleLabel.isHidden = !isFirstSection
        self.sectionTitleLabel.text = sectionTitle
    }
}
