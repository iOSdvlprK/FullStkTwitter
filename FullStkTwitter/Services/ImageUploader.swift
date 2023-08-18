//
//  ImageUploader.swift
//  FullStkTwitter
//
//  Created by joe on 2023/08/18.
//

import SwiftUI

struct ImageUploader {
    static func uploadImage(paramName: String, filename: String, image: UIImage, urlPath: String) {
        let url = URL(string: "http://localhost:3000\(urlPath)")!
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        // authentication
        guard let token = UserDefaults.standard.string(forKey: "jsonwebtoken") else { return }
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data) { responseData, response, error in
            if error == nil && (responseData != nil) {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                
                if let json = jsonData as? [String: Any] {
                    print(json)
                }
            }
        }.resume()
    }
}
