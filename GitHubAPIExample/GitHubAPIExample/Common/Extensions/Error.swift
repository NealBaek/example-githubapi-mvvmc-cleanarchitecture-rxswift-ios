//
//  Error.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Foundation

extension Error{
  func asNSError() -> NSError {
    self as NSError
  }
}
