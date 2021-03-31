//
//  SearchGitUserView.swift
//  GitHubAPIExample
//
//  Created by 백순열 on 2021/03/31.
//

import UIKit

import SnapKit
import Then

final class SearchGitUserView: BaseSnapKitContainerUIView {
  
    public let searchBar = UISearchBar().then {
        $0.searchBarStyle = UISearchBar.Style.prominent
        $0.placeholder = "Please enter here"
    }
    
    public let noListLabel = UILabel().then{
        $0.text = "No such user.."
        $0.textAlignment = .center
        $0.textColor = .darkGray
        $0.sizeToFit()
    }
    
    public let tableView = UITableView().then{
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = UIColor.white()
        $0.separatorStyle = .none
        $0.bounces = false
        $0.register(SearchGitUserCell.self, forCellReuseIdentifier: SearchGitUserCell.identifier)
        $0.estimatedRowHeight = 80
        $0.rowHeight = 80
    }
    
    override func initViews() {
        noListLabel.isHidden = false
        tableView.isHidden = true
    }

    override func addSubViews() {
        addSubview(tableView)
        addSubview(noListLabel)
    }

    override func addConstraints(_ superViewWidth: CGFloat, _ superViewHeight: CGFloat){
        tableView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        noListLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
  
}
