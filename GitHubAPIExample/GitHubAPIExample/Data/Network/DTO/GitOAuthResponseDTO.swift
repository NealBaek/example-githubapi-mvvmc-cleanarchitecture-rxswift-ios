//
//  GitOAuthResponseDTO.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

struct GitOAuthResponseDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
    }
    
    let accessToken: String
    let tokenType: String
    let scope: String
    
}

extension GitOAuthResponseDTO{
    func toEntity() -> GitOAuthEntity{
        return .init(accessToken: accessToken, tokenType: tokenType)
    }
}
