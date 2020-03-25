//
//  ViewController.swift
//  Concentration
//
//  Created by Sneh Patel on 3/23/20.
//  Copyright © 2020 Sneh Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    var flipCount = 0{
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            
        } else {
            print("chosen card not present")
        }
        
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        emojiChoices = [ "🗽", "🐉" ,"🦁", "🧲", "🤯", "🥶", "😡", "🤮", "💀", "🐣", "🐥" ,"🐠","🌎","🔥", "🍩", "🎱", "🏀", "🎲", "🎉","♠️","♦️" , "😬","👻","🧠" ]
        
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
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
                
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :  #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
            
        }
    }
    
    var emojiChoices: Array<String> = [ "🗽", "🐉" ,"🦁", "🧲", "🤯", "🥶", "😡", "🤮", "💀", "🐣", "🐥" ,"🐠","🌎","🔥", "🍩", "🎱", "🏀", "🎲", "🎉","♠️","♦️" , "😬","👻","🧠" ]
    
    var emoji = [Int: String] ()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int( arc4random_uniform(UInt32(emojiChoices.count)) )
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
        
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

