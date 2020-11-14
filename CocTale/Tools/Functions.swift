//
//  Functions.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 10/6/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import Foundation

func changeMeasure(string:String , multiplier : Int)->String
{
var temp : String = ""
var res : String = ""
for s in string
    {
        if s.isNumber
        {
            temp.append(s)
        }
        else
        {
            if temp != ""
            {
                temp = String(Int.init(temp)! * multiplier)
                res.append(temp)
                temp = ""
            }
            res.append(s)
        }
        
    }
    return res
}
