//
//  ViewController.swift
//  ProjectTwo
//
//  Created by admin on 22/11/22.
//
import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var countryTitle: UILabel! // label dos titulos
    @IBOutlet var questionNamber: UILabel!
    
    var countries = [String]() //Array dos paises
    var score = 0
    var correctAnswer = 0
    var questionNumber = 1
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    @objc func temporizador() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(temporizador), userInfo: nil, repeats: false)
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        
        countries.shuffle() //embaralha o array
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        countryTitle.text = countries[correctAnswer].uppercased()
        questionNamber.text = "Question number: \(questionNumber)"
        
        temporizador()
    }

    @objc func activateTimer(){
        
        if score > 0 {
            score -= 1
        }
        questionNumber += 1
        
        let ac = UIAlertController(title: countryTitle.text, message: "Time expired! You score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) //askQuestion funciona como clousure,
        present(ac, animated: true)
        
        timer.invalidate()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if sender.tag == correctAnswer{
            countryTitle.text = "Correto"
            score += 1
        } else {
            countryTitle.text = "Incorreto! O pais selecionado foi \(countries[sender.tag].uppercased())"
            if score > 0 {
                score -= 1
            }
        }
        questionNumber += 1
        
        let ac = UIAlertController(title: countryTitle.text, message: "You score is \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion)) //askQuestion funciona como clousure,
        
        present(ac, animated: true)
        
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(activateTimer), userInfo: nil, repeats: false)
    }
    
}
