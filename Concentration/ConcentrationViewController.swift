//
//  ViewController.swift
//  Concentration
//
//  Created by Sneh Patel on 3/23/20.
//  Copyright © 2020 Sneh Patel. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    private(set) var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else {
            print("chosen card not present")
        }
        
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        emojiChoices = theme ?? ""
        
        flipCount = 0
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        resetCardButtons()
    }
    
    private func resetCardButtons(){
        for cardButton in cardButtons{
            cardButton.setTitle("", for: UIControl.State.normal)
            cardButton.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        }
    }
    
    
    private func updateViewFromModel() {
        if cardButtons != nil{
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    UIView.transition(with: button,
                                      duration: 0.6,
                                      options: .transitionFlipFromLeft,
                                      animations: {
                                        button.setTitle(self.emoji(for: card), for: UIControl.State.normal)
                                        button.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                    }
                        //                                      completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>
                    )
                    
                    
                    
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                }
                
            }
        }
    }
    
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "🥨🍕🥪🌮🍩🍫🍪🧁"
    
    private var emoji = [Card: String] ()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.randomNumber)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    
 
}

extension Int{
    var randomNumber: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}

