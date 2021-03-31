//
//  UIColor.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

enum AssetsColor {
    case whiteTwo
    case black
    case lightGray
}

extension UIColor {
  
    public static func white()->UIColor{
        return UIColor.appColor(.whiteTwo)
    }
    public static func black()->UIColor{
        return UIColor.appColor(.black)
    }
    public static func lightGray()->UIColor{
        return UIColor.appColor(.lightGray)
    }

    private static func appColor(_ name: AssetsColor) -> UIColor {
        switch name {
            case .whiteTwo:
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            case .black:
                return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            case .lightGray:
                return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}


