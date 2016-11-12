//
//  LibraryAPI.swift
//  Test157
//
//  Created by Andrey on 08.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class LibraryAPI: NSObject {
    
    class var sharedInstance: LibraryAPI {
        struct Singleton {
            static let instance = LibraryAPI()
        }
        return Singleton.instance
    }
    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    
    override init() {
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()

        super.init()
    }
    
    func saveOrder() {
        persistencyManager.saveOrder()
    }
    
    func getOrder () -> Order {
        return persistencyManager.getOrder()
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    func cities(completion: @escaping ([ListObject], Error?) -> Void) {
        httpClient.cities() { data,error in completion(data,error) }
    }
    
    func classes(completion: @escaping ([ListObject], Error?) -> Void) {
        httpClient.classes() { data,error in completion(data,error) }
    }
    
    func showRooms (for cityId: Int, completion: @escaping ([ListObject], Error?) -> Void) {
        httpClient.showRooms(for: cityId) { data,error in completion(data,error) }
    }
    
    func workSheets(with order: Order, completion: @escaping (URLResponse?, Error?) -> Void)
    {
        httpClient.workSheets(with: order) { response,error in
            completion(response,error)
        }
    }
}
