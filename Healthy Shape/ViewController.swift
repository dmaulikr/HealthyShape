//
//  ViewController.swift
//  Healthy Shape
//
//  Created by Ольга Клюшкина on 12.03.17.
//  Copyright © 2017 klyushkina. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet var getWeight: UITextField!
    @IBOutlet var getHeight: UITextField!
    @IBOutlet weak var genderSwitcher: UISegmentedControl!
    @IBOutlet weak var calculate: UIButton!
    
    var myBMI: Float = 0.0
    var resume: String = ""
    var gender: UInt8 = 2 // default value which is Man
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeight.delegate = self
        self.getHeight.delegate = self
        
        //make the keyboard remember the values, set to the txt fields while coming back to the screen
        func textFieldShouldReturn(_ getWeight: UITextField) -> Bool {
            getWeight.resignFirstResponder()
            return false
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet.decimalDigits // text fields will allow to set only decimal digits, no special symbols or letters
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if getWeight.text!.isEmpty || getHeight.text!.isEmpty {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Please fill all the fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        } else if getWeight.text! == "0" || getWeight.text! == "0.0" || getWeight.text! == "0,0" || getHeight.text! == "0" || getWeight.text! == "," || getWeight.text! == "." {
            // create the alert about 0 values and separator
            let alert = UIAlertController(title: "Error", message: "Height or Weight cannot be equal to 0 or only separator. Please enter valid values.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert about 0 values
            self.present(alert, animated: true, completion: nil)
        } else {
        var DestViewController: ViewTwo = segue.destination as! ViewTwo
            
        // counting BodyMassIndex
        func countBMI(userWeight: Float?, userHeight: Float?){
            if userWeight != nil && userHeight != nil && userWeight != 0 && userHeight != 0 {
                
            myBMI = userWeight!/(userHeight! * userHeight!)
            } else if userWeight == 0 || userWeight == nil || userHeight == 0 || userHeight == nil {
                print ("Some value is equal to nil")
            }
        }
        
            // creating resume text about BMI according to gender
        func getResume(myBMI: Float) {
            if gender == 2 { // When gender is Man
                switch(myBMI) {
                    case 0..<1:
                        resume = " . It seems that your data is wrong. Please check the entered values."
                    case 1.0..<16.0:
                            resume = ". You are dangerously underweighted."
                    case 16..<18.5:
                            resume = ". You are underweighted."
                    case 18.5..<25.0:
                            resume = ". You have a healthy weight."
                    case 25.0..<30:
                            resume = ". You are overweighted."
                    case 30.0..<35.0:
                            resume = ". You have an obese (Class I)."
                    case 35.0..<40.0:
                            resume = ". You have an obese (Class II)."
                    case 40.0...9999999999999999999999999999:
                            resume = ". You have a morbid obese (Class III)."
                    default: break
                }
            } else { // When gender is Woman
                    switch(myBMI) {
                    case 0..<1:
                        resume = " . It seems that your data is wrong. Please check the entered values."
                    case 1.0..<16.0:
                        resume = ". You are dangerously underweighted."
                    case 16.0..<18.0:
                        resume = ". You are underweighted."
                    case 18.0..<25.0:
                        resume = ". You have a healthy weight."
                    case 25.0..<30:
                        resume = ". You are overweighted."
                    case 30.0..<35.0:
                        resume = ". You have an obese (Class I)."
                    case 35.0..<40.0:
                        resume = ". You have an obese (Class II)."
                    case 40.0...9999999999999999999999999999:
                        resume = ". You have a morbid obese (Class III)."
                    default: break
                }
            }
        }

        var weight: Float = 1.0
        // validating the separator. If the separator is ",", it will be converted into "."to avoid crash
        if (getWeight.text?.contains(","))! {
            weight = Float(getWeight.text!.replacingOccurrences(of: ",", with: "."))!
        } else {
            weight = Float(getWeight.text!)!
        }
        
        let height = (Float(getHeight.text!)!)/100
        
        countBMI(userWeight: weight, userHeight: height)
        getResume(myBMI: myBMI)
        
        DestViewController.BodyMassText = "Your BodyMassIndex is " + String(format: "%.1f", myBMI) + resume
        }
    }
    
    @IBAction func calculate(_ sender: UIButton) {
    }
    
    @IBAction func genderSwitchButton(_ sender: UISegmentedControl) {
        switch genderSwitcher.selectedSegmentIndex {
        case 0:
            gender = 2 // this is Man
        case 1:
            gender = 3 // this is Woman
        default: break
        }
    }
}
