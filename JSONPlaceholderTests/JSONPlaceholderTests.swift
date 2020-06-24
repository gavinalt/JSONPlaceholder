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
  let urlTranslator: DataTypeToURLTranslator = DataTypeToMockURLTranslator()

  func testUserViewModelFetchData() throws {
    let usersViewModel = UsersViewModel(urlTranslator)
    let expt = expectation(description: "Correctly fetched users")
    usersViewModel.bind {
      expt.fulfill()
    }
    usersViewModel.fetchData()
    let waitResult = XCTWaiter.wait(for: [expt], timeout: 3)
    XCTAssertEqual(waitResult, .completed)

    XCTAssertEqual(usersViewModel.numOfRows(in: 0), 10)
    XCTAssertEqual(usersViewModel.name(for: IndexPath(row: 3, section: 0)), "Patricia Lebsack")
  }

  func testUserViewModelFilterData() throws {
    let usersViewModel = UsersViewModel(urlTranslator)
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
    let albumsViewModel = AlbumsViewModel(with: 0, urlTranslator)
  }

  func testPhotosViewModelFetchData() throws {
    let photosViewModel = PhotosViewModel(with: 0, urlTranslator)
  }
}
