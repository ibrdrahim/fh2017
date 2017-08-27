//
//  BCAService.swift
//  IosBlueprint
//
//  Created by Ibrahim Indosystem on 8/26/17.
//  Copyright © 2017 Indosytem. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Rates {
    let currency:String
    let buy:String
    let sell:String
    
    init(currency:String,buy:String,sell:String) {
        self.currency = currency
        self.buy = buy
        self.sell = sell
    }
}

class BCAService{
    
    class func getSymbolForCurrencyCode(code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
    
    class func getUserData(callback : @escaping (User) -> Void){
        
        APIHandler.request(url: "http://182.16.165.76/api/user/1", requestMethod: .get, requestParam: nil){
            resp in
            
            let userJson = resp["message"]
            
            callback(User(userName: userJson["name"].string ?? "", email: userJson["email"].string ?? "", phone: userJson["phone"].string ?? "", balance: userJson["balance"].string ?? ""))
            
        }
    }
    
    class func transfer(amount:Float,callhack : @escaping () -> Void){
        
        let param : postParam = [
            "user_id" : "1",
            "wallet_id" : "1",
            "amount" : amount
        ]
        
        APIHandler.request(url: "http://182.16.165.76/api/fire/transfer", requestMethod: .post, requestParam: param){
            resp in
            
            print(resp)
            
        }
        
    }
    
    class func topup(amount:Float,callhack : @escaping () -> Void){
        
        let param : postParam = [
            "user_id" : "1",
            "wallet_id" : "1",
            "amount" : amount
        ]
        
        APIHandler.request(url: "http://182.16.165.76/api/fire/topup", requestMethod: .post, requestParam: param){
            resp in
            
            print(resp)
            
        }
        
    }
    
    class func getRates(callback : @escaping ([Rates]) -> Void){
        
        APIHandler.request(url: "http://182.16.165.76/api/rate", requestMethod: .get, requestParam: nil){
            resp in
            
            var rates = [Rates]()
            
            if resp["Currencies"].array!.count > 0 {
                
                for (_,curr):(String, JSON) in resp["Currencies"] {
                    print(curr["CurrencyCode"].string ?? "")
                    
                    for (_,rate):(String, JSON) in curr["RateDetail"] {
                        
                        if rate["RateType"] == "erate"  {
                            rates.append(Rates(currency: curr["CurrencyCode"].string ?? "", buy: rate["buy"].string ?? "", sell: rate["sell"].string ?? ""))
                        }
                        
                    }
                }
            }
            
            callback(rates)
        }

    }
    
}
