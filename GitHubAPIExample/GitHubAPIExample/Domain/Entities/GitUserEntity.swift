//
//  GitUserEntity.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

struct GitUserEntity: Decodable {
    
    let login: String
    let avatarUrl: String
    
    var repoList: [GitRepoEntity]
    var repoUpdateDone: Bool
}
