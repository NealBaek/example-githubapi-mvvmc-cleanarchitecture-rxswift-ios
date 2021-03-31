//
//  GitOAuthRepositoryDelegate.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import RxSwift

protocol GitOAuthRepositoryDelegate {
    func fetchOAuth(clientId: String, clientSecret: String, code: String) -> Single<GitOAuthEntity>
}
