//
//  IngredientCell.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 10/2/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import UIKit
//MARK:- Constants
private let IngredientCellID = "IngredientCellID"
private let ServingNumber = ["1" , "2" , "3" , "4"]

//MARK:- IngredientTable Class
class IngredientTable: UICollectionViewCell {
    
    var Serving : Int = 1
    
    var Ingredients : [String]? {
        didSet{
            self.table.reloadData()
        }
    }
    
    lazy var fixedLabel : UILabel =
    {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        label.text = "Serving "
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var segment : UISegmentedControl =
    {
        let segment = UISegmentedControl(items: ServingNumber)
        segment.frame = CGRect(x: 105, y: 0, width: 249, height: 30)
        let normalTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segment.setTitleTextAttributes(normalTextAttributes, for: .normal)
        segment.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segment.selectedSegmentIndex = 0 
        segment.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        return segment
    }()
    
    lazy var table : UITableView =
    {
        let tableview = UITableView(frame:CGRect(x: 0, y: 35, width: 354, height: 300 ))
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: IngredientCellID)
        return tableview
    }()
    
    var Measures : [String]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

}

//MARK:- Setup UI
extension IngredientTable
{
  func setupUI()
  {
    self.addSubview(self.fixedLabel)
    self.addSubview(self.segment)
    self.addSubview(self.table)
    
    }
}
 




//MARK:- TableViewDataSource

extension IngredientTable : UITableViewDataSource , UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.Ingredients?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: IngredientCellID, for: indexPath)
        let str = (Measures != nil ?(indexPath.row < Measures!.count ?  Measures![indexPath.row] : "" ) : "" ) + " " + Ingredients![indexPath.row]
        cell.textLabel?.text = changeMeasure(string: str, multiplier: self.Serving)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

//MARK:- Segment Action
extension IngredientTable
{
    @objc func segmentChanged()
    {
        self.Serving = self.segment.selectedSegmentIndex + 1
        self.table.reloadData()
    }
    
    
}




