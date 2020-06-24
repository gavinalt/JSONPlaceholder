//
//  PhotosCollectionViewController.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/24/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
  private let collectionViewCellIdentifier = "photosCollectionViewCell"
  private let photosViewModel: PhotosViewModel

  private let itemsPerRow: CGFloat = 3
  private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
  
  init(viewModel: PhotosViewModel) {
    photosViewModel = viewModel
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    photosViewModel.bind {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView!.register(PhotosCollectionViewCell.self,
                                  forCellWithReuseIdentifier: collectionViewCellIdentifier)
    title = "Photos of Album \(photosViewModel.albumId)"
    collectionView.backgroundColor = .systemBackground

    photosViewModel.fetchData()
  }

  // MARK: UICollectionViewDataSource

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return photosViewModel.numOfSection
  }


  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return photosViewModel.numOfRows(in: section)
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellIdentifier, for: indexPath) as! PhotosCollectionViewCell
    cell.setCellTitle(title: photosViewModel.title(for: indexPath))
    photosViewModel.image(for: indexPath) { data in
      guard let data = data,
        let image = UIImage(data: data) else { return }
      DispatchQueue.main.async {
        cell.setCellImage(image: image)
      }
    }
    
    return cell
  }

  // MARK: UICollectionViewDelegate

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let webViewController = WebViewController(url: photosViewModel.url(for: indexPath))
    navigationController?.pushViewController(webViewController, animated: true)
    collectionView.deselectItem(at: indexPath, animated: true)
  }
}

// MARK: - Collection View Flow Layout Delegate
extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.layoutMarginsGuide.layoutFrame.width - paddingSpace
    let widthPerItem = availableWidth / itemsPerRow

    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
