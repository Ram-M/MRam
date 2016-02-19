//
//  Products.swift
//  MRam
//

import UIKit
import SwiftyJSON

class Products
{
    var prod_id:String
    var prod_title:String
    var prod_type:String
    var prod_url:String
    var prod_cost:String
    
    init(fromDict product : JSON)
    {
        prod_id = ""
        prod_title = ""
        prod_type = ""
        prod_url = ""
        prod_cost = ""
        
        prod_id = product["id"].stringValue
        prod_title = product["title"].stringValue
        prod_url  = product["url"].stringValue
        prod_cost = product["cost"].stringValue
        
        
    }
}
