//
//  GitUserRepositoryDelegate.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

protocol GitUserRepositoryDelegate {
    func searchGitUser(username: String, page: Int, perPage: Int) -> Single<[GitUserEntity]>
}
