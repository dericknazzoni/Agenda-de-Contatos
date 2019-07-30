# Agenda-de-Contatos

###https://marvelapp.com/c8c9a6b/screen/59836305
import Foundation

class NetworkManager {
    static let shared = NetworkManager(baseURL: "https://tomadainteligenteserver.herokuapp.com")
    // MARK: - Properties
    
    let baseURL: String
    var token: Token?
    var currentUser: User?
    
    
    // Initialization
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    static func makeGetListRequest<T:DataObject>(to endpoint:String, objectType: [T].Type, completionHandler: @escaping ([DataObject]?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("cache-control", forHTTPHeaderField: "no-cache")
        if let token = NetworkManager.shared.token {
            urlRequest.addValue(token.token, forHTTPHeaderField: "x-access-token")
        }
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                print(String.init(data: responseData, encoding: String.Encoding.utf8)!)
                let dataObjects = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObjects, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    static func makeGetRequest<T:DataObject>(to endpoint:String, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        
        if let token = NetworkManager.shared.token {
            urlRequest.addValue(token.token, forHTTPHeaderField: "x-access-token")
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                print(String.init(data: responseData, encoding: String.Encoding.utf8)!)
                let dataObject = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObject, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    static func makePostRequest<T:DataObject, U:DataObject>(to endpoint:String, dataObject: U, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            let error = BackendError.urlError(reason: "Could not create URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = NetworkManager.shared.token {
            urlRequest.addValue(token.token, forHTTPHeaderField: "x-access-token")
        }
        urlRequest.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let newJSON = try encoder.encode(dataObject)
            print(String.init(data: newJSON, encoding: String.Encoding.utf8)!)
            urlRequest.httpBody = newJSON
        } catch {
            print(error)
            completionHandler(nil, error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                print(String.init(data: responseData, encoding: String.Encoding.utf8)!)
                let dataObject = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObject, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    static func makePutRequest<T:DataObject, U:DataObject>(to endpoint:String, dataObject: U, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            let error = BackendError.urlError(reason: "Could not create URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = NetworkManager.shared.token {
            urlRequest.addValue(token.token, forHTTPHeaderField: "x-access-token")
        }
        urlRequest.httpMethod = "PUT"
        
        let encoder = JSONEncoder()
        do {
            let newJSON = try encoder.encode(dataObject)
            urlRequest.httpBody = newJSON
        } catch {
            print(error)
            completionHandler(nil, error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dataObject = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObject, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    static func makeDeleteRequest<T:DataObject>(to endpoint:String, objectType: T.Type, completionHandler: @escaping (DataObject?, Error?) -> Void) {
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            let error = BackendError.urlError(reason: "Could not construct URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        if let token = NetworkManager.shared.token {
            urlRequest.addValue(token.token, forHTTPHeaderField: "x-access-token")
        }
        urlRequest.httpMethod = "DELETE"
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dataObject = try decoder.decode(objectType, from: responseData)
                completionHandler(dataObject, nil)
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    func authenticate(with usuario:String, and senha:String, completionHandler: @escaping (Token?, Error?) -> Void){
        guard let url = URL(string: NetworkManager.shared.baseURL + "/authenticate") else {
            let error = BackendError.urlError(reason: "Could not create URL")
            completionHandler(nil, error)
            return
        }
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let newJSON = try encoder.encode(User(_id: nil, username: usuario, password: senha, sensors: nil))
            urlRequest.httpBody = newJSON
        } catch {
            print(error)
            completionHandler(nil, error)
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let responseData = data else {
                print("Error: did not receive data")
                completionHandler(nil, error)
                return
            }
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let dataObject = try decoder.decode(Token.self, from: responseData)
                NetworkManager.shared.token = dataObject
                
                UserDAO.get(from: usuario, completionHandler: { (user, error) in
                    if error == nil{
                        NetworkManager.shared.currentUser = (user as! User)
                        let defaults = UserDefaults.standard
                        let array:[String] = [usuario, senha]
                        defaults.set(array, forKey: "login")
                    }
                    
                    completionHandler(dataObject, nil)
                })
            } catch {
                print("error trying to convert data to JSON")
                print(error)
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    
}

protocol DataObject: Codable {}


enum BackendError: Error {
    case urlError(reason: String)
}
