//
//  UserDefaults.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Foundation

extension UserDefaults{
  
  public enum Key: String{
    case accessToken
  }
  
  
  // MARK: Set
  public static func setValue<T: Codable>(data: T, key: Key){
    do {
      try UserDefaults.standard.set(JSONEncoder.init().encode(data), forKey: key.rawValue)
    } catch{
      print("UserDefaults saving \(key) Error: \(error)")
    }
  }
  
  // MARK: Get
  public static func getValue<T: Codable>(defaultValue: T, key: Key) -> T{
    guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {
      return defaultValue
    }
    
    do {
      return try JSONDecoder.init().decode(T.self, from: data)
    } catch {
      print("UserDefaults saving \(key) Error: \(error)")
    }
    
    return UserDefaults.standard.object(forKey: key.rawValue) as! T
  }
  
}
