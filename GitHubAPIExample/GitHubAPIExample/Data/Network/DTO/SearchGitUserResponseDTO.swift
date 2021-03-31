//
//  SearchGitUserResponseDTO.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

struct SearchGitUserResponseDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResult = "incomplete_results"
        case items
    }
    
    let totalCount: Int
    let incompleteResult: Bool
    let items: [ItemDTO]
    
    
    struct ItemDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
        }
        let login: String
        let avatarUrl: String
    }
}

extension SearchGitUserResponseDTO{
    func toEntity() -> [GitUserEntity]{
        return items.map{ GitUserEntity.init(login: $0.login, avatarUrl: $0.avatarUrl, repoList: [], repoUpdateDone: false) }
    }
}
