//
//  Button.swift
//  miniGame
//
//  Created by Sasha on 10.12.24.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        var configure = UIButton.Configuration.filled()
        configure.baseBackgroundColor = .systemGray4
        configure.baseForegroundColor = .white
        configure.cornerStyle = .large
        configure.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        configure.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 40, weight: .light, scale: .large)
        configure.imagePadding = 10

        self.configuration = configure
        self.translatesAutoresizingMaskIntoConstraints = false

    }

}

#Preview {
    let view = ViewController()
    view
}
