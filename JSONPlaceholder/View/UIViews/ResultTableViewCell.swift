//
//  ResultTableViewCell.swift
//  JSONPlaceholder
//
//  Created by Gavin Li on 6/23/20.
//  Copyright © 2020 Gavin Li. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

  var name: TableCellLabel
  var userName: TableCellLabel
  var email: TableCellLabel

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    name = TableCellLabel.init(frame: .zero)
    userName = TableCellLabel.init(frame: .zero)
    email = TableCellLabel.init(frame: .zero)
    name.setPrefix("Name: ")
    userName.setPrefix("UserName: ")
    email.setPrefix("Email: ")

    super.init(style: style, reuseIdentifier: reuseIdentifier)
    backgroundColor = .systemBackground
    setupSubview()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    name.setText("")
    userName.setText("")
    email.setText("")
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  private func setupSubview() {
    self.contentView.addSubview(name)
    self.contentView.addSubview(userName)
    self.contentView.addSubview(email)

    NSLayoutConstraint.activate([
      name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),

      email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4),
      email.leadingAnchor.constraint(equalTo: name.leadingAnchor),
      email.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),

      userName.leadingAnchor.constraint(greaterThanOrEqualTo: name.trailingAnchor, constant: 16),
      userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
      userName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
    userName.setContentCompressionResistancePriority(.required, for: .horizontal)
  }

  func configureCell(basedOnName name: String, userName: String, email: String) {
    self.name.setText(name)
    self.userName.setText(userName)
    self.email.setText(email)
  }
}
