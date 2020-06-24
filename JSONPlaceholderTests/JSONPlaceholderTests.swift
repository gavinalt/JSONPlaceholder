//
//  JSONPlaceholderTests.swift
//  JSONPlaceholderTests
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import XCTest
@testable import JSONPlaceholder

class JSONPlaceholderTests: XCTestCase {
  func testParsingUsers() throws {
    let data = try mockData(for: "users")

    let networkService = NetworkService()
    let expt = expectation(description: "Correctly parsed users")
    var result: Result<[User], NetworkError>?
    networkService.parseJSON(type: [User].self, data: data) {
      result = $0
      expt.fulfill()
    }
    wait(for: [expt], timeout: 1)

    let users = try result?.get()
    XCTAssertEqual(users?.count, 10)
    XCTAssertEqual(users?[2].name, "Clementine Bauch")
  }

  func testParsingAlbums() throws {
    let data = try mockData(for: "albums")

    let networkService = NetworkService()
    let expt = expectation(description: "Correctly parsed albums")
    var result: Result<[Album], NetworkError>?
    networkService.parseJSON(type: [Album].self, data: data) {
      result = $0
      expt.fulfill()
    }
    wait(for: [expt], timeout: 1)

    let albums = try result?.get()
    XCTAssertEqual(albums?.count, 10)
    XCTAssertEqual(albums?[2].title, "ab rerum non rerum consequatur ut ea unde")
  }

  func testParsingPhotos() throws {
    let data = try mockData(for: "photos")

    let networkService = NetworkService()
    let expt = expectation(description: "Correctly parsed photos")
    var result: Result<[Photo], NetworkError>?
    networkService.parseJSON(type: [Photo].self, data: data) {
      result = $0
      expt.fulfill()
    }
    wait(for: [expt], timeout: 1)

    let photos = try result?.get()
    XCTAssertEqual(photos?.count, 50)
    XCTAssertEqual(photos?[2].title, "officiis voluptates nihil illo aut rerum blanditiis est")
  }

  func mockData(for fileName: String) throws -> Data {
    let bundle = Bundle(for: JSONPlaceholderTests.self)
    guard let path = bundle.path(forResource: fileName, ofType: "json") else {
      fatalError("users.json not found during testing")
    }
    let url = URL(fileURLWithPath: path)
    let data = try Data(contentsOf: url)
    return data
  }

  func testUsersViewModelFetchData() throws {
    let usersViewModel = UsersViewModel(urlTranslator: MockDataTypeToURLTranslator(),
                                        networkService: MockNetworkService())
    let expt = expectation(description: "Correctly fetched users")
    usersViewModel.bind {
      expt.fulfill()
    }
    usersViewModel.fetchData()
    let waitResult = XCTWaiter.wait(for: [expt], timeout: 3)
    XCTAssertEqual(waitResult, .completed)

    XCTAssertEqual(usersViewModel.numOfRows(in: 0), 10)
    XCTAssertEqual(usersViewModel.numOfSection, 1)
    XCTAssertEqual(usersViewModel.name(for: IndexPath(row: 3, section: 0)), "Patricia Lebsack")
    XCTAssertEqual(usersViewModel.userName(for: IndexPath(row: 3, section: 0)), "Karianne")
    XCTAssertEqual(usersViewModel.email(for: IndexPath(row: 3, section: 0)), "Julianne.OConner@kory.org")
    XCTAssertEqual(usersViewModel.userId(for: IndexPath(row: 3, section: 0)), 4)
  }

  func testUsersViewModelFilterData() throws {
    let usersViewModel = UsersViewModel(urlTranslator: MockDataTypeToURLTranslator(),
                                        networkService: MockNetworkService())
    let expt = expectation(description: "Correctly fetched users for filtering")
    usersViewModel.bind {
      expt.fulfill()
    }
    usersViewModel.fetchData()
    let waitResult = XCTWaiter.wait(for: [expt], timeout: 3)
    usersViewModel.unbind()
    XCTAssertEqual(waitResult, .completed)

    usersViewModel.filterDataForSearchQuery("Ervin Howell")
    XCTAssertEqual(usersViewModel.numOfRows(in: 0), 1)
    XCTAssertEqual(usersViewModel.name(for: IndexPath(row: 0, section: 0)), "Ervin Howell")
  }

  func testAlbumsViewModelFetchData() throws {
    let albumsViewModel = AlbumsViewModel(with: 0,
                                          urlTranslator: MockDataTypeToURLTranslator(),
                                          networkService: MockNetworkService())
    let expt = expectation(description: "Correctly fetched users")
    albumsViewModel.bind {
      expt.fulfill()
    }
    albumsViewModel.fetchData()
    let waitResult = XCTWaiter.wait(for: [expt], timeout: 3)
    albumsViewModel.unbind()
    XCTAssertEqual(waitResult, .completed)

    XCTAssertEqual(albumsViewModel.numOfRows(in: 0), 10)
    XCTAssertEqual(albumsViewModel.numOfSection, 1)
    XCTAssertEqual(albumsViewModel.title(for: IndexPath(row: 3, section: 0)), "ducimus molestias eos animi atque nihil")
    XCTAssertEqual(albumsViewModel.userId(for: IndexPath(row: 3, section: 0)), 2)
    XCTAssertEqual(albumsViewModel.albumId(for: IndexPath(row: 3, section: 0)), 14)
  }

  func testPhotosViewModelFetchData() throws {
    let photosViewModel = PhotosViewModel(with: 0,
                                          urlTranslator: MockDataTypeToURLTranslator(),
                                          networkService: MockNetworkService())
    let expt = expectation(description: "Correctly fetched users")
    photosViewModel.bind {
      expt.fulfill()
    }
    photosViewModel.fetchData()
    let waitResult = XCTWaiter.wait(for: [expt], timeout: 3)
    photosViewModel.unbind()
    XCTAssertEqual(waitResult, .completed)

    XCTAssertEqual(photosViewModel.numOfRows(in: 0), 50)
    XCTAssertEqual(photosViewModel.numOfSection, 1)
    XCTAssertEqual(photosViewModel.title(for: IndexPath(row: 3, section: 0)), "necessitatibus et fuga similique ut vel")
    XCTAssertEqual(photosViewModel.id(for: IndexPath(row: 3, section: 0)), 1304)
    XCTAssertEqual(photosViewModel.url(for: IndexPath(row: 3, section: 0)), "https://via.placeholder.com/600/865668")
    XCTAssertEqual(photosViewModel.thumbnailUrl(for: IndexPath(row: 3, section: 0)), "https://via.placeholder.com/150/865668")
  }
}
