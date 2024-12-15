    //
    //  ViewController.swift
    //  miniGame
    //
    //  Created by Sasha on 10.12.24.
    //

import UIKit

enum Moving {
    case left
    case right
    case up
    case down
}

final class ViewController: UIViewController {

    //MARK: UI
    private let upButton = Button()
    private let downButton = Button()
    private let leftButton = Button()
    private let rightButton = Button()

    private let safeViewSquare = UIView()
    private let buttonArea: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let squareView = UIView()

    //MARK: Properties
    private let squareSize: CGFloat = 40

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()

        swipeMove(.left)
        swipeMove(.right)
        swipeMove(.up)
        swipeMove(.down)
    }
}

//MARK: Extension ViewController
private extension ViewController {

//MARK: Configure UI
    func configureUI() {

        configureSafeArea()

        view.addSubview(buttonArea)
        constraintsButtonAreaView()

        configureButtons()
        constraintsButtons()

        configureSquare()
    }

    func configureSafeArea() {
        safeViewSquare.translatesAutoresizingMaskIntoConstraints = false
        safeViewSquare.layer.cornerRadius = 30
        safeViewSquare.backgroundColor = .systemGray6

        view.addSubview(safeViewSquare)
        constraintsSafeView()
    }

    func configureSquare() {
        squareView.backgroundColor = .blue
        squareView.translatesAutoresizingMaskIntoConstraints = false
        squareView.layer.cornerRadius = squareSize / 2

        view.addSubview(squareView)
        constraintsSquare()
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


//MARK: Configure Actions
    func move(_ move: Moving) {

        switch move {
            case .left:
                if squareView.frame.origin.x > safeViewSquare.frame.origin.x + squareSize {
                    squareView.frame.origin.x -= squareSize
                }
            case .right:
                if squareView.frame.maxX < safeViewSquare.frame.width - squareSize {
                    squareView.frame.origin.x += squareSize
                }
            case .up:
                if squareView.frame.origin.y > safeViewSquare.frame.origin.y + squareSize  {
                    squareView.frame.origin.y -= squareSize
                }
            case .down:
                if squareView.frame.maxY < safeViewSquare.frame.height + squareSize {
                    squareView.frame.origin.y += squareSize
                }
        }

    }

    func swipeMove(_ move: Moving) {
        switch move {
            case .left:
                swipeCirleOnLeft()
            case .right:
                swipeCirleOnRight()
            case .up:
                swipeCirleOnUP()
            case .down:
                swipeCirleOnDown()
        }
    }

    func swipeCirleOnLeft() {
        let leftSwipeRecognaizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeLeft)
        )

        leftSwipeRecognaizer.direction = .left
        self.squareView.addGestureRecognizer(leftSwipeRecognaizer)
    }

    func swipeCirleOnRight() {
        let rightSwipeRecognaizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeRight)
        )

        rightSwipeRecognaizer.direction = .right
        self.squareView.addGestureRecognizer(rightSwipeRecognaizer)
    }

    func swipeCirleOnUP() {
        let upSwipeRecognaizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeUP)
        )

        upSwipeRecognaizer.direction = .up
        self.squareView.addGestureRecognizer(upSwipeRecognaizer)
    }

    func swipeCirleOnDown() {
        let downSwipeRecognaizer = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipeDown)
        )

        downSwipeRecognaizer.direction = .down
        self.squareView.addGestureRecognizer(downSwipeRecognaizer)
    }


//MARK: Actions
    @objc func movingSquare(_ sender: UIButton) {

        switch sender.tag {
            case 0: move(.up)  // up
            case 1: move(.down)  // down
            case 2: move(.left)  // left
            default: move(.right)  // right
        }
    }

    @objc func swipeLeft() {
        if squareView.frame.origin.x > safeViewSquare.frame.origin.x + squareSize {
            squareView.frame.origin.x = safeViewSquare.frame.origin.x
        }
    }

    @objc func swipeRight() {
        if squareView.frame.maxX < safeViewSquare.frame.width {
            squareView.frame.origin.x = safeViewSquare.frame.width
        }
    }

    @objc func swipeUP() {
        if squareView.frame.origin.y > safeViewSquare.frame.origin.y + squareSize  {
            squareView.frame.origin.y = safeViewSquare.frame.origin.y
        }
    }

    @objc func swipeDown() {
        if squareView.frame.maxY < safeViewSquare.frame.height + squareSize {
            squareView.frame.origin.y = safeViewSquare.frame.height + squareSize
        }
    }


//MARK: Constraints
    func constraintsSafeView() {
        NSLayoutConstraint.activate([
            safeViewSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            safeViewSquare.topAnchor
                .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            safeViewSquare.leadingAnchor
                .constraint(equalTo: view.leadingAnchor, constant: 30),
            safeViewSquare.trailingAnchor
                .constraint(equalTo: view.trailingAnchor, constant: -30),
            safeViewSquare.heightAnchor.constraint(equalToConstant: 450),
        ])
    }

    func constraintsButtonAreaView() {
        NSLayoutConstraint.activate([
            buttonArea.topAnchor.constraint(
                equalTo: safeViewSquare.bottomAnchor, constant: 30),
            buttonArea.leadingAnchor.constraint(
                equalTo: view.leadingAnchor, constant: 40),
            buttonArea.trailingAnchor.constraint(
                equalTo: view.trailingAnchor, constant: -40),
            buttonArea.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
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

    func constraintsSquare() {
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
