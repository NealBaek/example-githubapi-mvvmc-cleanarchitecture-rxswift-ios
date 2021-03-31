//
//  GitHubAPI.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import Moya
import Alamofire

enum GitHubAPI {
    case oauth(clientId: String, clientSecret: String, code: String)
    case searchUser(username: String, page: Int, perPage: Int)
    case repoList(username: String, page: Int, perPage: Int)
}

extension GitHubAPI: TargetType {
    
    var baseURL: URL {
        switch self {
        case .oauth:
            return try! AppConfigs.gitHubUrl.rawValue.asURL()
        case .searchUser, .repoList:
            return try! AppConfigs.gitHubAPIUrl.rawValue.asURL()
        }
    }

    var path: String {
        switch self {
        case .oauth:
            return "/login/oauth/access_token"
        case .searchUser:
            return "/search/users"
        case .repoList(let username, _, _): return "/users/\(username)/repos"
        }
    }

    var method: Moya.Method {
        switch self {
        case .oauth: return .post
        case .searchUser, .repoList: return .get
        }
    }

    var headers: [String: String]? {
        return [
            "accept": "application/vnd.github.v3+json",
            "Authorization": UserDefaults.getValue(defaultValue: "", key: .accessToken)
        ]
    }

    var parameters: [String: Any]? {
        switch self {
        case .oauth(let clientId, let clientSecret, let code):
            return [
                "client_id": clientId,
                "client_secret": clientSecret,
                "code": code
            ]
        case .searchUser(let username, let pageNum, let perPage):
            return [
                "q": username,
                "page": pageNum,
                "per_page": perPage
            ]
        case .repoList(_, let pageNum, let perPage):
            return [
                "page": pageNum,
                "per_page": perPage
            ]
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        default:
          if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
          }
          return .requestPlain
        }
    }
    
    var sampleData: Data { return Data() }
}
