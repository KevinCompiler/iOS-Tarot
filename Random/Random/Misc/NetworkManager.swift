//
//  NetworkManager.swift
//  Random
//
//  Created by GeekyEntity on 8/24/20.
//  Copyright © 2020 None. All rights reserved.
//

import Foundation
import Foundation
class JsonDeserializer {
    class func getJsonArrayFromFile<T: Decodable>(fromFile urlObject:URL, completion:@escaping (T)->Void) {
        URLSession.shared.dataTask(with: urlObject) {(data, response, error) in
            do {
                guard let data = data else{return}
                let jsonArray = try JSONDecoder().decode(T.self, from: data)
                completion(jsonArray);

            } catch {
                print("Error in Fetching Data: \(error)")
            }
            print("Network Request Is Completed")
            }.resume()
    }
}
