//
//  GitUserSceneCoordinator.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

protocol GitUserSceneCoordinatorDependency {
    func createSearchGitUserViewController() -> SearchGitUserViewController
}

final class GitUserSceneCoordinator{
    
    private let dependencies: GitUserSceneCoordinatorDependency
    
    init(dependencies: GitUserSceneCoordinatorDependency) {
        self.dependencies = dependencies
    }
    
}

extension GitUserSceneCoordinator{
    
    func start(window: UIWindow){

        window.rootViewController = BaseUINavigationController(rootViewController: dependencies.createSearchGitUserViewController())
        window.makeKeyAndVisible()
        
    }
    
}
