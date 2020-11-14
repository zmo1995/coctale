//
//  NetworkTools.swift
//  CocTale
//
//  Created by ZHI XUAN MO on 9/9/20.
//  Copyright © 2020 zhixuan mo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkTools
{
    class func requestData(URLString: String , Callback : @escaping (_ result : Data?) -> ())
    {
        AF.request(URLString).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                //print("API Response: \(value)")
                Callback(response.data)
            case .failure:
                print("error")
             }

        }
        
        
    }
    
    
}
