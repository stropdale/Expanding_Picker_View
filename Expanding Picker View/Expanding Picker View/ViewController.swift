//
//  ViewController.swift
//  Expanding Picker View
//
//  Created by Richard Stockdale on 30/04/2018.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var picker: ExpandingPickerView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options = ["Option1", "Option2", "Option3", "Option4"]
        
        picker.setup(openHeight: 160, ibHeightConstraint: heightConstraint, titleText: "Title", options: options)
        
        picker.valueText = "Initial Text"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

