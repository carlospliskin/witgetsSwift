//
//  ViewController.swift
//  nuevo
//
//  Created by carlos paredes on 03/08/21.
//

import UIKit

class ViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myPicketV: UIPickerView!
    @IBOutlet weak var myPageControl: UIPageControl!
    @IBOutlet weak var mySegmentedControl: UISegmentedControl!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var miStepper: UIStepper!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myProgressViwe: UIProgressView!
    @IBOutlet weak var myStepperLabel: UILabel!
    @IBOutlet weak var mySwitchLabel: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    
    //Variables
    
    private let myPickerViewValues = ["uno","dos","tres","cuatro","cinco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // button
        
        myButton.setTitle("mi boton", for: .normal)
        myButton.backgroundColor = .blue
        myButton.setTitleColor(.white, for: .normal)
        
        //Pickers
        
        myPicketV.backgroundColor = .lightGray
        myPicketV.dataSource = self
        myPicketV.delegate = self
        myPicketV.isHidden = true
        //pageControl
        
        myPageControl.numberOfPages = myPickerViewValues.count
        myPageControl.currentPageIndicatorTintColor = .blue
        myPageControl.pageIndicatorTintColor = .lightGray
        
        //segmented control
        
        mySegmentedControl.removeAllSegments()
        for (index, value) in myPickerViewValues.enumerated(){
            mySegmentedControl.insertSegment(withTitle: value, at: index, animated: true)
        }
        
        //Slider
        
        mySlider.minimumTrackTintColor = .red
        mySlider.minimumValue = 0
        mySlider.maximumValue = Float(myPickerViewValues.count)
        mySlider.value = 1
        
       //stepper
        
        miStepper.minimumValue = 0
        miStepper.maximumValue = Double(myPickerViewValues.count)
        
        //Switch
        
        mySwitch.onTintColor = .purple
        mySwitch.isOn = false
        
        //progress indicators
        
        myProgressViwe.progress = 0
        
        //Activity view
        
        myActivityIndicator.color = .orange
        myActivityIndicator.startAnimating()
        myActivityIndicator.hidesWhenStopped = true
        
        //labels
        myStepperLabel.textColor = .darkGray
        myStepperLabel.font = UIFont.boldSystemFont(ofSize: 26)
        myStepperLabel.text = "1"
        
        mySwitchLabel.text = "esta apagado"
        
        //TextField
        
        myTextField.textColor = .brown
        myTextField.placeholder = "escribe algo"
        myTextField.delegate = self
    }
    
    

    //actions
    
    @IBAction func myButtonAction(_ sender: Any) {
        if myButton.backgroundColor == .blue{
            myButton.backgroundColor = .green
        }else {
            myButton.backgroundColor = .blue
        }
    }
    
    @IBAction func myPageControlAction(_ sender: Any) {
        myPicketV.selectRow(myPageControl.currentPage, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues [myPageControl.currentPage]
        myButton.setTitle(myString, for: .normal)
    }
    @IBAction func mySegmentedControlAction(_ sender: Any) {
        
        myPicketV.selectRow(mySegmentedControl.selectedSegmentIndex, inComponent: 0, animated: true)
        
        let myString = myPickerViewValues[mySegmentedControl.selectedSegmentIndex]
        myButton.setTitle(myString, for: .normal)
        
        mySegmentedControl.selectedSegmentIndex = myPageControl.currentPage
    }
    @IBAction func mySliderAction(_ sender: Any) {
        
        print(mySlider.value)
        
        var progresss: Float = 0
        
        switch mySlider.value {
        case 1..<2:
            mySegmentedControl.selectedSegmentIndex = 0
            progresss = 0.2
        case 2..<3:
            mySegmentedControl.selectedSegmentIndex = 1
            progresss = 0.4
        case 3..<4:
            mySegmentedControl.selectedSegmentIndex = 2
            progresss = 0.6
        case 4..<5:
            mySegmentedControl.selectedSegmentIndex = 3
            progresss = 0.8
        default:
            mySegmentedControl.selectedSegmentIndex = 4
            progresss = 1
        }
        myProgressViwe.progress = progresss
    }
    @IBAction func myStepperAction(_ sender: Any) {
        
        let value = miStepper.value
        mySlider.value = Float(value)
        
        myStepperLabel.text = "\(value)"
    }
    @IBAction func mySwitchAction(_ sender: Any) {
        if mySwitch.isOn{
            myPicketV.isHidden = false
            myActivityIndicator.stopAnimating()
            
            mySwitchLabel.text = "Esta encendido"
        }else {
            myPicketV.isHidden = true
            myActivityIndicator.startAnimating()
            
            mySwitchLabel.text = "Esta apagado"
        }
    
    }
}


//extension PickerView

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerViewValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerViewValues[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let myString = myPickerViewValues[row]
        myButton.setTitle(myString, for: .normal)
        
        myPageControl.currentPage = row
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            myButton.setTitle(text, for: .normal)
        }
    }
}

