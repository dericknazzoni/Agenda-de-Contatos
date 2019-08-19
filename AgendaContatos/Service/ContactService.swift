//
//  ContactService.swift
//  AgendaContatos
//
//  Created by Derick Willians Plens Nazzoni on 15/08/19.
//  Copyright © 2019 Derick Willians Plens Nazzoni. All rights reserved.
//

import Foundation

enum ContactErr{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatuaCode(code: Int)
    case invalidJson
}
enum HtppResponse: Int{
    case success = 200
    case erro = 404
}


class ContactService{
    
    private static let baseUrl: String = "http://192.168.0.109:8080/users"
    
    
    class func loadContacts(completionHandler: @escaping ([Contato]?, ContactErr?) -> Void){
        guard let myUrl = URL(string: baseUrl) else {
            print("oi1")
            return completionHandler(nil, .url)
        }
        let task = URLSession.shared.dataTask(with: myUrl) { (data, response, err) in
            if err == nil{
                
                guard let response = response as? HTTPURLResponse else {
                    return completionHandler(nil, .noResponse)
                    }
                print(response)
                if response.statusCode == HtppResponse.success.rawValue{
                    guard let data = data else {
                        print("oi3")
                        return completionHandler(nil, .noData)
                    
                    }
                    do{
                        
                        let contact = try JSONDecoder().decode([Contato]?.self, from: data )
                        print("oi4")
                        completionHandler(contact, nil)
                    }catch{
                        print("response")
                        completionHandler(nil, .invalidJson)
                    }
                    
                }else{
                    print("oi6")
                    completionHandler(nil, .responseStatuaCode(code: response.statusCode))
                }
            }else{
                print("096")
                return completionHandler(nil, .taskError(error: err!))
            }
        }
        task.resume()
        
    }
    
    
    
    
}
