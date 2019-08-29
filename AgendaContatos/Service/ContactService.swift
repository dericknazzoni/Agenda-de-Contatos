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
    
    
    class func loadContacts(completionHandler: @escaping ([Contato?]?, ContactErr?) -> Void){
        guard let myUrl = URL(string: baseUrl) else {
            print("Erro de URL")
            return completionHandler(nil, .url)
        }
        
        var request = URLRequest(url: myUrl)
        request.addValue("no-cache", forHTTPHeaderField: "cache-control")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, err) in
            if err == nil{
                
                guard let response = response as? HTTPURLResponse else {
                    return completionHandler(nil, .noResponse)
                }
                print(response)
                
                if response.statusCode == HtppResponse.success.rawValue{
                    guard let data = data else {
                        print("Erro de dado vazio")
                        return completionHandler(nil, .noData)
                        
                    }
                    do{
                        
                        let contact = try JSONDecoder().decode([Contato?].self, from: data )
                        print("Sucesso")
                        let contatos = contact.filter({$0 != nil})
                        completionHandler(contatos, nil)
                    }catch{
                        print("Erro de Json")
                        completionHandler(nil, .invalidJson)
                    }
                    
                }else{
                    print("Status code erro")
                    completionHandler(nil, .responseStatuaCode(code: response.statusCode))
                }
            }else{
                print("Erro de conexão")
                return completionHandler(nil, .taskError(error: err!))
            }
        }
        task.resume()
        
    }
    
    class func deleteContact(entryID: Int, completionHandler: @escaping (ContactErr?) -> Void){
        
        guard let myUrl = URL(string: "http://192.168.0.109:8080/users/del/\(entryID)") else {
            completionHandler(ContactErr.url)
            return
        }
        var urlRequest = URLRequest(url: myUrl)
        urlRequest.httpMethod = "DELETE"
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: { (_, _, error) in
            guard error == nil else {
                print(error.debugDescription)
                completionHandler(ContactErr.taskError(error: error!))
                return
            }
            print("deletado com sucesso")
            completionHandler(nil)
        })
        task.resume()
        
    }
    
    class func putContact(contato: Contato, completionHandler: @escaping (ContactErr?) -> Void){
        guard let myUrl = URL(string: "http://192.168.0.109:8080/users/mod") else {
            completionHandler(ContactErr.url)
            return 
        }
        var urlRequest = URLRequest(url: myUrl)
        urlRequest.httpMethod = "PUT"
        let session = URLSession.shared
        do {
            let data = try JSONEncoder().encode(contato)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("no-cache", forHTTPHeaderField: "cache-control")

            let task = session.dataTask(with: urlRequest) { (_, _, error) in
                if let error = error {
                    completionHandler(ContactErr.taskError(error: error))
                }
                completionHandler(nil)
            }
            task.resume()
        }catch {
            completionHandler(ContactErr.invalidJson)
        }

        
    }
    
    class func postContact(contato: Contato, completionHandler: @escaping (ContactErr?) -> Void){
        guard let myUrl = URL(string: "http://192.168.0.109:8080/users/add") else {
            completionHandler(ContactErr.url)
            return
        }
        var urlRequest = URLRequest(url: myUrl)
        urlRequest.httpMethod = "POST"
        let session = URLSession.shared
        do {
            let data = try JSONEncoder().encode(contato)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let jsonData = try JSONSerialization.data(withJSONObject: json)
            urlRequest.httpBody = jsonData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("no-cache", forHTTPHeaderField: "cache-control")
            
            let task = session.dataTask(with: urlRequest) { (_, _, error) in
                if let error = error {
                    completionHandler(ContactErr.taskError(error: error))
                }
                completionHandler(nil)
            }
            task.resume()
        }catch {
            completionHandler(ContactErr.invalidJson)
        }

    }
    
    
    
}


