//
//  CustomTableViewCell.swift
//  AppApiNetwork
//
//  Created by admin on 25/02/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let identifier: String = "CustomTableViewCell"
    
    lazy var screen: CustomTableViewCellScreen = {
        let view = CustomTableViewCellScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(screen)
        
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            screen.topAnchor.constraint(equalTo: contentView.topAnchor),
            screen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            screen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            screen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
    
    public func setupHomeCell(data: Person) {
        screen.nameLabel.text = "Nome: \(data.name)"
        screen.surnameLabel.text = "Sobrenome: \(data.lastName)"
        screen.phoneLabel.text = "Telefone: \(data.phone)"
        
    }
    
}
