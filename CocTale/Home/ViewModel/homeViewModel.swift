//
//  homeViewModel.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import Foundation

class homeViewModel
{
    lazy var itemDict = [String : [simpleCocktail]]()
}


extension homeViewModel
{
    func requestData(callBack:@escaping ()->())
    {
        let disGroup = DispatchGroup()
        
        //request popular data
        disGroup.enter()
        NetworkTools.requestData(URLString: kPopularURL) { (data) in
            guard data != nil else {return }
            do
            {
                let res  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                let cocktails = res["drinks"] as! [Dictionary<String,Any>]
                var cocktailList : [simpleCocktail] = [simpleCocktail]()
                for i in 1...4
                {
                    let dict = cocktails[i-1]
                    let cocktail = simpleCocktail(dict: dict)
                    cocktailList.append(cocktail)
                }
                self.itemDict["Popular"] = cocktailList
            }
            catch
            {
                print("Decoding JSON Data Failed")
            }
            disGroup.leave()
        }
        
        //request random data
        disGroup.enter()
        NetworkTools.requestData(URLString: kRandomURL) { (data) in
            guard data != nil else {return }
            do
            {
                let res  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                let cocktails = res["drinks"] as! [Dictionary<String,Any>]
                var cocktailList : [simpleCocktail] = [simpleCocktail]()
                for i in 1...4
                {
                    let dict = cocktails[i-1]
                    let cocktail = simpleCocktail(dict: dict)
                    cocktailList.append(cocktail)
                }
                self.itemDict["Random"] = cocktailList

            }
            catch
            {
                print("Decoding JSON Data Failed")
            }
            disGroup.leave()
        }
        
        //request latest data
        disGroup.enter()
        NetworkTools.requestData(URLString: kLatestURL) { (data) in
            guard data != nil else {return }
            do
            {
                let res  = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                 let cocktails = res["drinks"] as! [Dictionary<String,Any>]
                var cocktailList : [simpleCocktail] = [simpleCocktail]()
                for i in 1...4
                {
                    let dict = cocktails[i-1]
                    let cocktail = simpleCocktail(dict: dict)
                    cocktailList.append(cocktail)
                }
                self.itemDict["Latest"] = cocktailList
            }
            catch
            {
                print("Decoding JSON Data Failed")
            }
            disGroup.leave()
        }
        
        disGroup.notify(queue: DispatchQueue.main) {

            callBack()
        }
        
        
    }
}
