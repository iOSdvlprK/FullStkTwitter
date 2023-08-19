//
//  RequestServices.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/15.
//

import Foundation

public class RequestServices {
    public static var requestDomain = ""
    
    public static func postTweet(text: String, user: String, username: String, userId: String, completion: @escaping ([String: Any]?) -> Void) {
        let params = ["text": text, "userId": userId, "user": user, "username": username] as [String: Any]
        let url = URL(string: requestDomain)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        catch {
            print(error)
        }
        
        // Authentication Part in the HTTP Request
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else { return }
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else { return }
            guard let data = data else { return }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    completion(json)
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    static func fetchTweets(completion: @escaping (Result<Data?, NetworkError>) -> Void) {
        let url = URL(string: requestDomain)!
        let session = URLSession.shared
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request) { data, res, err in
            guard err == nil else {
                completion(.failure(.noData))
                return
            }
            
            guard let data = data else { return }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
