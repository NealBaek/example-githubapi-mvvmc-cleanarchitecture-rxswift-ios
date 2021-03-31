//
//  GitRepoListResponseDTO.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

struct GitRepoListResponseDTO: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    let id: Int
    
}

extension GitRepoListResponseDTO{
    func toEntity() -> GitRepoEntity{
        return GitRepoEntity.init(id: id)
    }
}
