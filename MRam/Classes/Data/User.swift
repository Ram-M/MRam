//
//  LoginUser.swift
//  Sample
//
//

import UIKit

class CardDetails
{
    var firstName : String {
        get {
            if let firstName = NSUserDefaults.standardUserDefaults().valueForKey("FIRST_NAME") as? String {
                return firstName
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "FIRST_NAME")
            defaults.synchronize()
        }
    }
    
    var lastName : String {
        get {
            if let lastName = NSUserDefaults.standardUserDefaults().valueForKey("LAST_NAME") as? String {
                return lastName
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "LAST_NAME")
            defaults.synchronize()
        }
    }
    
    var cardNumber : String {
        get {
            if let cardNumber = NSUserDefaults.standardUserDefaults().valueForKey("CARD_NUMBER") as? String {
                return cardNumber
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "CARD_NUMBER")
            defaults.synchronize()
        }
    }
    
    var cvv : String {
        get {
            if let cvv = NSUserDefaults.standardUserDefaults().valueForKey("CVV") as? String {
                return cvv
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "CVV")
            defaults.synchronize()
        }
    }
    
    var month : String {
        get {
            if let month = NSUserDefaults.standardUserDefaults().valueForKey("MONTH") as? String {
                return month
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "MONTH")
            defaults.synchronize()
        }
    }
    
    var year : String {
        get {
            if let year = NSUserDefaults.standardUserDefaults().valueForKey("YEAR") as? String {
                return year
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "YEAR")
            defaults.synchronize()
        }
    }
    
    var address1 : String {
        get {
            if let address1 = NSUserDefaults.standardUserDefaults().valueForKey("ADDRESS1") as? String {
                return address1
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "ADDRESS1")
            defaults.synchronize()
        }
    }
    
    var address2 : String {
        get {
            if let address2 = NSUserDefaults.standardUserDefaults().valueForKey("ADDRESS2") as? String {
                return address2
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "ADDRESS2")
            defaults.synchronize()
        }
    }
    
    
    var city : String {
        get {
            if let city = NSUserDefaults.standardUserDefaults().valueForKey("CITY") as? String {
                return city
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "CITY")
            defaults.synchronize()
        }
    }
    
    var street : String {
        get {
            if let street = NSUserDefaults.standardUserDefaults().valueForKey("STREET") as? String {
                return street
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "STREET")
            defaults.synchronize()
        }
    }
    
    var zipcode : String {
        get {
            if let zipcode = NSUserDefaults.standardUserDefaults().valueForKey("ZIP_CODE") as? String {
                return zipcode
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "ZIP_CODE")
            defaults.synchronize()
        }
    }
    
    var country : String {
        get {
            if let country = NSUserDefaults.standardUserDefaults().valueForKey("COUNTRY") as? String {
                return country
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "COUNTRY")
            defaults.synchronize()
        }
    }
    
    var comment : String {
        get {
            if let comment = NSUserDefaults.standardUserDefaults().valueForKey("COMMENT") as? String {
                return comment
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "COMMENT")
            defaults.synchronize()
        }
    }
}

class User: NSObject
{
    var id : String? {
        get {
            if let username = NSUserDefaults.standardUserDefaults().valueForKey("ID") as? String {
                return username
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "ID")
            defaults.synchronize()
        }
    }
    
    var userName : String? {
        get {
            if let username = NSUserDefaults.standardUserDefaults().valueForKey("USER_NAME") as? String {
                return username
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "USER_NAME")
            defaults.synchronize()
        }
    }
    
     var email : String? {
        get {
            if let email = NSUserDefaults.standardUserDefaults().valueForKey("EMAIL") as? String {
                return email
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "EMAIL")
            defaults.synchronize()
        }
    }
    
    var accessToken : String? {
        get {
            if let accessToken = NSUserDefaults.standardUserDefaults().valueForKey("ACCESS_TOKEN") as? String {
                return accessToken
            }else {
                return ""
            }
        }set (newVal){
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(newVal, forKey: "ACCESS_TOKEN")
            defaults.synchronize()
        }
    }
    
}
