//
//  cocktailModel.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import Foundation
import RealmSwift


class simpleCocktail
{
    var idDrink : String = ""
    var strDrink : String = ""
    var strDrinkThumb : String = ""
    var strTags : [String] = [String]()
    var strCategory : String = ""
    var strAlcoholic : String = ""
    var strGlass : String = ""
    var strInstructions : [String] = [String]()
    var Ingredients : [String] = [String]()
    var Measures : [String] = [String]()
    var dateModified : String = ""
    
    required init() {
    }
    

    init(dict : Dictionary<String, Any>)
    {
        if let id = dict["idDrink"] as? String
        {
            self.idDrink = id
        }
        
        if let name = dict["strDrink"] as? String
        {
            self.strDrink = name
        }
        
        if let url = dict["strDrinkThumb"] as? String
        {
            self.strDrinkThumb = url
        }
        
        if let tags = dict["strTags"] as? String
        {
            self.strTags = tags.components(separatedBy: ",")
        }
        
        if let category = dict["strCategory"] as? String
        {
            self.strCategory = category
        }
        
        if let alcoholic = dict["strAlcoholic"] as? String
        {
            self.strAlcoholic = alcoholic
        }
        
        if let glass = dict["strGlass"] as? String
        {
            self.strGlass = glass
        }
        
        if let instructions = dict["strInstructions"] as? String
        {
            var newinstrSet = [String]()
            for instr in instructions.components(separatedBy: ".")
            {
                if instr == ""
                {
                    continue
                }
                let newStr = instr.trimmingCharacters(in: .whitespacesAndNewlines)
                newinstrSet.append(newStr)
            }
            
            self.strInstructions = newinstrSet
        }
        
        if let date = dict["dateModified"] as? String
        {
            self.dateModified = date
        }
        
        let ingredient = "strIngredient"
        let measure = "strMeasure"
        for i in 1...15
        {
            let curIngr = dict[ingredient + String(i)] as? String
            if curIngr != nil && curIngr != ""
            {
                let curMeas = dict[measure + String(i)] as? String
                if curMeas != nil
                {
                    self.Measures.append( curMeas!)
                }
                self.Ingredients.append(curIngr!)
            }
            else
            {
                break
            }
        }
        
        
    }
    
    
    
    
    
    
}

