//
//  ViewController.swift
//  TicTacToe
//
//  Created by Николай Никитин on 17.11.2021.
//

import UIKit

class ViewController: UIViewController {

  // MARK: - Properties
 private  enum Turn {
    case Nought
    case Cross
  }
  private var firstTurn = Turn.Cross
  private var currentTirn = Turn.Cross
  private var nought = "O"
  private var cross = "X"
  private var board = [UIButton]()
  private var noughtsScore = 0
  private var crossesScore = 0

// MARK: - Outlets
  @IBOutlet var turnLabel: UILabel!
  @IBOutlet var a1: UIButton!
  @IBOutlet var a2: UIButton!
  @IBOutlet var a3: UIButton!
  @IBOutlet var b1: UIButton!
  @IBOutlet var b2: UIButton!
  @IBOutlet var b3: UIButton!
  @IBOutlet var c1: UIButton!
  @IBOutlet var c2: UIButton!
  @IBOutlet var c3: UIButton!

// MARK: - View Controller LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    initBoard()
  }


  // MARK: - Methods

  /// Initialases game board
  private func initBoard(){
    board.append(a1)
    board.append(a2)
    board.append(a3)
    board.append(b1)
    board.append(b2)
    board.append(b3)
    board.append(c1)
    board.append(c2)
    board.append(c3)
  }

  /// Checks all victory positions on board.
  /// - Parameter s: name of setted for button symbol (X of O)
  /// - Returns: True if is any kind of victory positions was reached.
  private func checkForVictory(_ s: String) -> Bool {
    // Horizontal Victory
    if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) { return true }
    if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) { return true }
    if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) { return true }
    // Vertical victory
    if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) { return true }
    if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) { return true }
    if thisSymbol(a3, s) && thisSymbol(b3, s) && thisSymbol(c3, s) { return true }
    //  Diagonal Victory
    if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) { return true }
    if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) { return true }
    return false
  }

  /// Checks whos turn was by checking what kint of mark did set (cross or nought) and returns title
  /// - Parameters:
  ///   - button: current button been tapped
  ///   - symbol: what symbol in resives
  /// - Returns: bool value
  private func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
    return button.title(for: .normal ) == symbol
  }

  /// Alert message that notise when someone wints and also presents reset button to reset game board and present score statement
  /// - Parameter title: title of alert
  private func resultAlert(title: String) {
    let message = "\nNoughts " + String(noughtsScore) + "\n\nCrosses " + String(crossesScore)
    let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
      self.resetBoard()
    }))
    self.present(ac, animated: true)
  }

  /// Resets board statement (statement of all buttons) on board and turns
  private func resetBoard(){
    for button in board {
      button.setTitle(nil, for: .normal)
      button.isEnabled = true
    }
    if firstTurn == Turn.Nought {
      firstTurn = Turn.Cross
      turnLabel.text = cross
    } else {
      if firstTurn == Turn.Cross {
        firstTurn = Turn.Nought
        turnLabel.text = nought
      }
      currentTirn = firstTurn
    }
  }

  /// Checks is board if full or not
  /// - Returns: Bool value: true if full.
  private func fullBoard() -> Bool{
    for button in board {
      if button.title(for: .normal) == nil {
        return false
      }
    }
    return true
  }

  /// Changes button title after users tap
  /// - Parameter sender: UIButton
  private func addToBoard(_ sender: UIButton) {
    if (sender.title(for: .normal) == nil) {
      if (currentTirn == Turn.Nought){
        sender.setTitle(nought, for: .normal)
        currentTirn = Turn.Cross
        turnLabel.text = cross
      } else {
        if (currentTirn == Turn.Cross) {
          sender.setTitle(cross, for: .normal)
          currentTirn = Turn.Nought
          turnLabel.text = nought
        }
        sender.isEnabled = false
      }
    }
  }

  // MARK: - Actions
  @IBAction func boardTapAction(_ sender: UIButton) {
    addToBoard(sender)
    if checkForVictory(cross){
      crossesScore += 1
      resultAlert(title: "Crosses Win!")
    }
    if checkForVictory(nought){
      noughtsScore += 1
      resultAlert(title: "Noughts Win!")
    }
    if (fullBoard()) {
      resultAlert(title: "Draw")
    }
  }
}
