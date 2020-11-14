//
//  HomeViewController.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit

//MARK:- Constants
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenW - 3 * kItemMargin) / 2
private let kCocktailItemH = kItemW * 4/3
private let kIngredientItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let sectionTitles : [String] = ["Popular" , "Latest"  , "Random"]

private let cocktailCellID = "cocktailCell"
private let ingredientCellID = "ingredientCell"
private let firstHeaderID = "firstHeader"

//MARK:- HomeViewController
class HomeViewController: UIViewController {

    //MARK:- CollectionView Setup
    private lazy var collectionView : UICollectionView =
    {
       [weak self] in
        //layout Setup
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kCocktailItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        //collectionView Setup
        let collectionView = UICollectionView(frame: self!.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
        collectionView.autoresizingMask = [.flexibleHeight,
                                           .flexibleWidth]
        
        collectionView.register(UINib(nibName: "cocktailCell", bundle: nil), forCellWithReuseIdentifier: cocktailCellID)
        
       collectionView.register(UINib(nibName: "FirstCocktailHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: firstHeaderID)
        collectionView.frame = CGRect(x: 0, y: 30 , width: kScreenW, height: kScreenH - 80)
        return collectionView
    }()
    
    //MARK:- ViewModel
    private lazy var VM : homeViewModel = homeViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.requestData {
            self.collectionView.reloadData()
        }
        
    }

}

//MARK:- UI SETUP
extension HomeViewController
{
    func setupUI()
    {
        self.view.backgroundColor = UIColor.init(r: kBackGroundRGB.0, g: kBackGroundRGB.1, b: kBackGroundRGB.2)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(collectionView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
        {
        return .lightContent
    }
    
    
}


//MARK:- CollectionView Data Source
extension HomeViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.VM.itemDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.VM.itemDict["Popular"]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: cocktailCellID, for: indexPath) as! cocktailCell
        let sectionName = sectionTitles[ indexPath.section]
        cell.cocktail = self.VM.itemDict[sectionName]![indexPath.row % 4]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = self.collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: firstHeaderID, for: indexPath) as! FirstCocktailHeader
        header.headerSetup(isFirstSection: indexPath.section == 0 , sectionTitle: sectionTitles[indexPath.section])
            return header
        
    }
    
}

//MARK:- DidSelectItemAt
extension HomeViewController
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController()
        detail.cocktail = self.VM.itemDict[sectionTitles[indexPath.section]]![indexPath.row]
        self.navigationController?.show(detail, sender: self)
    }
}


//MARK:- CollectionView Delegate Flow Layout
extension HomeViewController : UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section == 0)
        {
            return CGSize(width: 414, height: 165)
        }
        return CGSize(width: 414, height: 80)
    }
    
}
//MARK:- Network Request
extension HomeViewController
{
    func requestData(callBack: @escaping ()->())
    {
        self.VM.requestData(callBack: callBack)
    }
}
