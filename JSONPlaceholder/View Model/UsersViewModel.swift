//
//  UsersViewModel.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import Foundation

typealias ViewModelHandler = () -> Void

class UsersViewModel {
  private let networkService: NetworkServiceProtocol
  private let urlTranslator: DataTypeToURLTranslatorProtocol

  private var handler: ViewModelHandler?

  private var searchQuery: String = ""
  private var users: [User] = [] {
    didSet { filterDataForSearchQuery("") }
  }
  private var filteredUsers: [User] = [] {
    didSet { handler?() }
  }

  init(urlTranslator: DataTypeToURLTranslatorProtocol = DataTypeToURLTranslator(),
       networkService: NetworkServiceProtocol = NetworkService()) {
    self.urlTranslator = urlTranslator
    self.networkService = networkService
  }

  func bind(_ handler: @escaping ViewModelHandler) {
    self.handler = handler
  }

  func unbind() {
    handler = nil
  }

  func fetchData() {
    networkService.loadJSONData(type: [User].self,
                                url: urlTranslator.url(for: .users),
                                params: nil) { result in
      switch result {
      case .success(let users):
        self.users = users
      case .failure(let error):
        print(error.localizedDescription)
       }
    }
  }

  func filterDataForSearchQuery(_ query: String) {
    let whitespaceCharacterSet = CharacterSet.whitespaces
    let strippedString = query.trimmingCharacters(in: whitespaceCharacterSet)
    searchQuery = strippedString
    if strippedString == "" {
      filteredUsers = users
    } else {
      filteredUsers = users.filter {
        $0.name.range(of: strippedString, options: .caseInsensitive) != nil ||
        $0.userName.range(of: strippedString, options: .caseInsensitive) != nil ||
        $0.email.range(of: strippedString, options: .caseInsensitive) != nil
      }
    }
  }
}

extension UsersViewModel {
  var numOfSection: Int {
    1
  }

  func numOfRows(in section: Int) -> Int {
    filteredUsers.count
  }

  func name(for indexPath: IndexPath) -> String {
    filteredUsers[indexPath.row].name
  }

  func userName(for indexPath: IndexPath) -> String {
    filteredUsers[indexPath.row].userName
  }

  func email(for indexPath: IndexPath) -> String {
    filteredUsers[indexPath.row].email
  }

  func userId(for indexPath: IndexPath) -> Int {
    filteredUsers[indexPath.row].id
  }
}
