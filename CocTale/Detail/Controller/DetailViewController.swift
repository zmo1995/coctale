//
//  DetailViewController.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/17/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit

//MARK:- Constants
private let detailHeaderID = "detailHeaderID"
private let descriptionCellID = "descriptionCellID"
private let titleHeaderID = "titleHeaderID"
private let ingredientTableID = "ingredientTableID"
private let kItemMargin : CGFloat = 30
private let kBigHeaderHeight : CGFloat = 446
private let kSmallHeaderHeight : CGFloat = 60
private let kCellWidth : CGFloat = kScreenW - (2 * kItemMargin)
class DetailViewController: UIViewController {
    var cocktail : simpleCocktail?
    
//MARK:- CollectionView SETUP
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        let collection = UICollectionView(frame: self.view.bounds , collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
        collection.autoresizingMask = [.flexibleHeight,
                                           .flexibleWidth]
        collection.register(UINib(nibName: "DetailHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: detailHeaderID)
        collection.register(UINib(nibName: "DescriptionCell", bundle: nil), forCellWithReuseIdentifier: descriptionCellID)
        collection.register(UINib(nibName: "TitleHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: titleHeaderID)
        collection.register(UINib(nibName: "IngredientTable", bundle: nil), forCellWithReuseIdentifier: ingredientTableID)
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       
        setupUI()
    }

}



//MARK:- UISETUP
extension DetailViewController
{
    func setupUI()
    {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .white
        let transparentbg = UIImage()
        transparentbg.draw(in: CGRect(x: 0, y: 0, width: kScreenW, height: 100)); self.navigationController?.navigationBar.setBackgroundImage(transparentbg, for: .default)
        self.view.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
        self.view.addSubview(collectionView)
    }
}

//MARK:- CollectionView DataSource
extension DetailViewController : UICollectionViewDataSource , UICollectionViewDelegate
{
    //MARK:- Header Setup
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
             let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailHeaderID, for: indexPath) as! DetailHeader
                   header.titileLabel.text = self.cocktail?.strDrink
                       header.cocktailImg!.sd_setImage(with:
                        URL.init(string: self.cocktail!.strDrinkThumb))
                       header.cocktailImg.layer.cornerRadius = 10
                       header.cocktailImg.layer.borderColor = UIColor.white.cgColor
                       header.cocktailImg.layer.borderWidth = 5
                   return header
        case 1:
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: titleHeaderID, for: indexPath) as! TitleHeader
            header.titleLabel.text = "Ingredients"
            return header
            
        case 2:
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: titleHeaderID, for: indexPath) as! TitleHeader
            header.titleLabel.text = "Preparation"
            return header
            
        default:
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: titleHeaderID, for: indexPath) as! TitleHeader
            header.titleLabel.text = "default"
            return header
        }

    }
    //MARK:- IndexPath Setup
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.cocktail != nil ? 3 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.cocktail?.strTags.count ?? 0
        case 1:
            return 1
        case 2:
            return self.cocktail?.strInstructions.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellID, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = self.cocktail?.strTags[indexPath.row] ?? "???"
            cell.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            return cell
            
        case 1:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: ingredientTableID, for: indexPath) as! IngredientTable
            cell.Ingredients = self.cocktail?.Ingredients
            cell.Measures = self.cocktail?.Measures
            cell.table.frame = CGRect(x: 0, y: 35, width: 354, height: (self.cocktail?.Ingredients.count)! * 30 )
            return cell
        case 2:
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: descriptionCellID, for: indexPath) as! DescriptionCell
            cell.descriptionLabel.text = self.cocktail?.strInstructions[indexPath.row] ?? "???"
            cell.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.borderWidth = 2
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            return cell
            
            
        default:
            return UICollectionViewCell()
        }
        
    }
    
    
    
    
}

//MARK:- Cell/Header Size
extension DetailViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: kScreenW, height: kBigHeaderHeight)
        default:
            return CGSize(width: kScreenW, height: kSmallHeaderHeight)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0:
            return CGSize(width: (self.cocktail?.strTags[indexPath.item].size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)]).width)! + 30, height: 30)
        case 1:
            return CGSize(width: kScreenW - 2 * kItemMargin, height: CGFloat( 35 + (self.cocktail?.Ingredients.count)! * 30))
        case 2:
            let width = (self.cocktail?.strInstructions[indexPath.item].size(withAttributes: nil).width)!
            return  CGSize(width: kCellWidth, height: (width / kCellWidth) * 30 + 30)

        default:
            return CGSize.zero
        }
        
        
    }
}
