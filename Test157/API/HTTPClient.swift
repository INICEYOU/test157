//
//  HTTPClient.swift
//  Test157
//
//  Created by Andrey on 10.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class HTTPClient {
    
    private struct API {
        
        static let baseURL = "http://3plus-authless.test.intravision.ru/api"
        static let host = "3plus-authless.test.intravision.ru"
        static let suffixAPI = "/api"
        static let scheme = "http"
        
        struct GET {
            static let classes = "/Classes"
            static let cities = "/Cities"
            static let showRooms = "/ShowRooms"
        }
        struct POST {
            static let workSheets = "/WorkSheets"
        }
        
        struct Parameters {
            static let cityId = "CityId"
        }
        
        static let headers: [String : Any] = [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
    
    private let session: URLSession // shared session for interacting with the web service
    
    init()
    {
        let config = URLSessionConfiguration.default // Session Configuration
        config.httpAdditionalHeaders = API.headers
        session = URLSession(configuration: config) // Load configuration into Session
    }
    
    func workSheets (with order: Order, completion: @escaping (URLResponse?, Error?) -> Void )
    {
        guard let jsonData = order.jsonObject else {
            return
        }
        
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = API.suffixAPI + API.POST.workSheets
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        request.timeoutInterval = 10.0
        
        session.dataTask(with: request , completionHandler: { (_, response, error) in
        
            completion(response,error)
            
        }).resume()
    }
    
    func showRooms (for cityId: Int , completion: @escaping ([ListObject], Error?) -> Void) 
    {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = API.host
        urlComponents.path = API.suffixAPI + API.GET.showRooms
        urlComponents.queryItems = [URLQueryItem(name: API.Parameters.cityId, value: String(cityId) )]
        let url = urlComponents.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10.0
 
        session.dataTask(with: request , completionHandler: { (data, response, error) in
            
            var classes: [ListObject] = []
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                        
                        
                        for array in json
                        {
                            let listObject = ListObject()
                            for (key, value) in array
                            {
                                // access all key / value pairs in dictionary
                                if key == "Name" {
                                    listObject.name = value as! String
                                }
                                else if key == "Id" {
                                    listObject.id = value as! Int
                                }
//                                else if key == "CityId" {
//                                    listObject.cityId = value as! Int
//                                }
                            }
                            classes.append(listObject)
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            completion(classes,error)
        }).resume()
    }
    
    func classes (completion: @escaping ([ListObject], Error?) -> Void) //
    {
        let url = URL(string: API.baseURL + API.GET.classes)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10.0
        
        session.dataTask(with: request , completionHandler: { (data, response, error) in
            
            var classes: [ListObject] = []
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                        
                        
                        for array in json
                        {
                            let listObject = ListObject()
                            for (key, value) in array
                            {
                                // access all key / value pairs in dictionary
                                if key == "Name" {
                                    listObject.name = value as! String
                                }
                                else if key == "Id" {
                                    listObject.id = value as! Int
                                }
                            }
                            classes.append(listObject)
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            completion(classes,error)
        }).resume()
    }
    
    func cities (completion: @escaping ([ListObject], Error?) -> Void) //
    {
        let url = URL(string: API.baseURL + API.GET.cities)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10.0
        
        session.dataTask(with: request , completionHandler: { (data, response, error) in
            
            var cities: [ListObject] = []
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let data = data,
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                        
                        for array in json
                        {
                            let listObject = ListObject()
                            
                            for (key, value) in array
                            {
                                // access all key / value pairs in dictionary
                                if key == "Name" {
                                    listObject.name = value as! String
                                }
                                else if key == "Id" {
                                    listObject.id = value as! Int
                                }
                            }
                            cities.append(listObject)
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
            completion(cities,error)
        }).resume()
    }
}
