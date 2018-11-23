//
//  ViewController.swift
//  Hangman
//
//  Created by Alex Paul on 11/19/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userInputText: UITextField!
    @IBOutlet weak var chosenWord: UILabel!
    @IBOutlet weak var user2InputText: UITextField!
    @IBOutlet weak var Image: UIImageView!
    @IBOutlet weak var correct: UILabel!
    @IBOutlet var wrong: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var mainScreen: UIView!
    @IBOutlet weak var mainScreenText: UILabel!
    @IBOutlet weak var winnerScreen: UILabel!
    
  
    override func viewDidLoad() {
    super.viewDidLoad()
    userInputText.delegate = self
    user2InputText.delegate = self
    restartGame()
    
  }
    private func restartGame() {
        correct.text = "Correct: "
        wrong.text = "Wrong: "
        chosenWord.text = ""
        userInputText.isHidden = false
        userInputText.text = ""
        HangmanBrain.allowedStrikes = 0
        HangmanBrain.correct = 0
        HangmanBrain.rightLetter = String()
        HangmanBrain.alreadyChosen = [String]()
        Image.image = UIImage (named: "Default Image")
        restartButton.isHidden = true
        winnerScreen.isHidden = true
        mainScreenText.text = "Choose a word"
        label.text = ""
    }
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        restartGame()
    }
    
    
    
    
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        HangmanBrain.userWordInput = userInputText.text!.lowercased()
        HangmanBrain.userWordGuess = user2InputText.text!.lowercased()
//        var replacedString = String()
        var word = String()
        
        
        for _ in 0..<HangmanBrain.userWordInput.count {
            word += " _ "
        }
        chosenWord.text = word
        userInputText.isHidden = true
        mainScreen.isHidden = true
        
        if textField == user2InputText {
            
            if !HangmanBrain.alreadyChosen.contains(HangmanBrain.userWordGuess){
            
            if HangmanBrain.userWordInput.contains(HangmanBrain.userWordGuess){
                label.text = "Correct!"
                let captureChar = Character(HangmanBrain.userWordGuess)
                for character in HangmanBrain.userWordInput {
                    switch character {
                    case captureChar:
                        HangmanBrain.correct += 1
                        HangmanBrain.rightLetter.append(HangmanBrain.userWordGuess)
                        HangmanBrain.alreadyChosen.append(HangmanBrain.userWordGuess)
                    default:
                        continue
                    }
                }
            } else {
                HangmanBrain.alreadyChosen.append(HangmanBrain.userWordGuess)
                label.text = "Incorrect"
                HangmanBrain.allowedStrikes += 1
        }
            } else {
                label.text = "Letter already Chosen"
                textField.text = ""
            }
            
        textField.text = ""
            
            switch HangmanBrain.allowedStrikes {
            case 1:
                Image.image = UIImage(named: "hang1")
                
            case 2:
                Image.image = UIImage(named: "hang2")
                
            case 3:
                Image.image = UIImage(named: "hang3")
                
            case 4:
                Image.image = UIImage(named: "hang4")
                
            case 5:
                Image.image = UIImage(named: "hang5")
                
            case 6:
                Image.image = UIImage(named: "hang6")
                
            case 7:
                Image.image = UIImage(named: "hang7")
                
            default:
                print("nothing")
                
            }
            
            
//            for letter in HangmanBrain.userWordInput {
//                if HangmanBrain.rightLetter.contains(letter) {
//                    replacedString += String(letter)
//                } else {
//                    replacedString += "_"
//                }
//                replacedString += " "
//            }
            chosenWord.text =  HangmanBrain.transformWord(word: HangmanBrain.userWordInput)
        }
        
        correct.text = "Correct: \(HangmanBrain.correct)"
        wrong.text = "Wrong: \(HangmanBrain.allowedStrikes)"
        
        if HangmanBrain.correct == HangmanBrain.userWordInput.count {
            chosenWord.text = "\(HangmanBrain.userWordInput)"
            restartButton.isHidden = false
            mainScreen.isHidden = false
            winnerScreen.isHidden = false
            mainScreenText.text = "The Correct Word Is: \(HangmanBrain.userWordInput)"
            winnerScreen.text = "Won!"
//            wrong.text = ""

            
        }
        if HangmanBrain.allowedStrikes == 7 {
           chosenWord.text = "\(HangmanBrain.userWordInput)"
            restartButton.isHidden = false
            mainScreen.isHidden = false
            winnerScreen.isHidden = false
            mainScreenText.text = "The Correct Word Is: \(HangmanBrain.userWordInput)"
            winnerScreen.text = "Lost!"
//            wrong.text = ""
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var boolToReturn = Bool()
        print(HangmanBrain.alreadyChosen)
        if user2InputText.text!.count > 1 {
            boolToReturn = false
        } else  if user2InputText.text!.count < 1{
            boolToReturn = true
        }
        let allowCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        boolToReturn = allowCharacters.isSuperset(of: characterSet)
        return boolToReturn
        
    }
    
    
}


