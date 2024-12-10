//
//  ViewController.swift
//  miniGame
//
//  Created by Sasha on 10.12.24.
//

import UIKit

class ViewController: UIViewController {

    let squareSize: CGFloat = 45

    let upButton = Button()
    let downButton = Button()
    let leftButton = Button()
    let rightButton = Button()

    let safeViewSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        return view
    }()

    let buttonArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()

    }

    func configureUI() {

        view.addSubview(safeViewSquare)
        constraintsSafeView()

        view.addSubview(buttonArea)
        constraintsButtonAreaView()

        configureButtons()
        constraintsButtons()

        safeViewSquare.addSubview(squareView)
        configureSquareConstraints()
    }

    func configureButtons() {
        upButton.setImage(UIImage(systemName: "arrowshape.up.fill"), for: .normal)
        downButton.setImage(UIImage(systemName: "arrowshape.down.fill"), for: .normal)
        leftButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        rightButton.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)

        upButton.tag = 0
        downButton.tag = 1
        leftButton.tag = 2
        rightButton.tag = 3

        view.addSubview(upButton)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(downButton)

        upButton.addTarget(self, action: #selector(movingSquare), for: .touchUpInside)
        downButton.addTarget(self, action: #selector(movingSquare), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(movingSquare), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(movingSquare), for: .touchUpInside)
    }

    @objc func movingSquare(_ sender: UIButton) {
        let safeAreaWight = safeViewSquare.bounds.width
        let safeAreaHeight = safeViewSquare.bounds.height

        var newX = squareView.frame.origin.x
        var newY = squareView.frame.origin.y

        switch sender.tag {
            case 0: newY -= squareSize // up
            case 1: newY += squareSize // down
            case 2: newX -= squareSize // left
            default: newX += squareSize // right
        }

        if newX >= 0 && newX <= safeAreaWight - squareSize && newY >= 0 && newY <= safeAreaHeight - squareSize {
                    squareView.frame.origin.x = newX
                    squareView.frame.origin.y = newY
                }
    }

    func constraintsSafeView() {
        NSLayoutConstraint.activate([
            safeViewSquare.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            safeViewSquare.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            safeViewSquare.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            safeViewSquare.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300)
        ])
    }

    func constraintsButtonAreaView() {
        NSLayoutConstraint.activate([
            buttonArea.topAnchor.constraint(equalTo: safeViewSquare.bottomAnchor, constant: 30),
            buttonArea.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonArea.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonArea.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }

    func constraintsButtons() {
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: buttonArea.leadingAnchor),
            leftButton.centerYAnchor.constraint(equalTo: buttonArea.centerYAnchor),
            upButton.centerXAnchor.constraint(equalTo: buttonArea.centerXAnchor),
            upButton.topAnchor.constraint(equalTo: buttonArea.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: buttonArea.trailingAnchor),
            rightButton.centerYAnchor.constraint(equalTo: buttonArea.centerYAnchor),
            downButton.centerXAnchor.constraint(equalTo: buttonArea.centerXAnchor),
            downButton.bottomAnchor.constraint(equalTo: buttonArea.bottomAnchor),
        ])
    }

    func configureSquareConstraints() {
        NSLayoutConstraint.activate([
            squareView.centerXAnchor.constraint(equalTo: safeViewSquare.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: safeViewSquare.centerYAnchor),
            squareView.heightAnchor.constraint(equalToConstant: squareSize),
            squareView.widthAnchor.constraint(equalToConstant: squareSize)
        ])
    }
}

#Preview {
    let view = ViewController()
    view
}
