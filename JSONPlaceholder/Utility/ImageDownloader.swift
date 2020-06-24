//
//  ImageDownloader.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

final class ImageDownloader {
  private let cache: LocalCache<String, Data>
  private let session: URLSession

  init() {
    cache = LocalCache()
    session = URLSession(configuration: .default)
  }

  func getImageFrom(_ urlString: String, completion: @escaping (Data?) -> Void) {
    if let cachedData = cache[urlString] {
      completion(cachedData)
    } else {
      guard let url = URL(string: urlString) else { return completion(nil) }

      let task = session.dataTask(with: url) { [weak self] (data, _, _) in
        guard let data = data else {
          return completion(nil)
        }

        self?.cache[urlString] = data
        completion(data)
      }
      task.resume()
    }
  }
}
