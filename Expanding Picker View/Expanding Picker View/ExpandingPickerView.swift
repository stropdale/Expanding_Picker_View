//
//  ExpandingPickerView.swift
//  Expanding Picker View
//
//  Created by Richard Stockdale on 30/04/2018.
//  Copyright © 2018 Virtuosys. All rights reserved.
//

import UIKit

class ExpandingPickerView: UIView {
    
    private let headerView = UIView()
    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let spinner = UIPickerView()
    
    private var closedHeight: CGFloat = 40.0
    private var openHeight :CGFloat?
    
    private var heightConstraint: NSLayoutConstraint?
    
    private var pickerOptions: [String]?
    
    public var valueText: String = "" {
        didSet {
            valueLabel.text = valueText
        }
    }
    
    /// Set up the UI
    ///
    /// - Parameters:
    ///   - openHeight: The height the view should animate to when open
    ///   - ibHeightConstraint: the height constraint that should be manipulated
    ///   - titleText: The text that appears at the top left
    ///   - options: The options that appear in the picker
    func setup(openHeight :CGFloat, ibHeightConstraint :NSLayoutConstraint, titleText :String, options: [String]) {
        clipsToBounds = true
        pickerOptions = options
        self.closedHeight = ibHeightConstraint.constant
        self.openHeight = openHeight
        self.heightConstraint = ibHeightConstraint
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(valueLabel)
        addSubview(spinner)
        
        // Header View
        headerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: closedHeight).isActive = true
        
        // Title
        titleLabel.text = titleText
        titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8.0).isActive = true
        
        // Value
        valueLabel.text = ""
        valueLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8.0).isActive = true
        valueLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -8.0).isActive = true
        
        // Spinner
        spinner.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spinner.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        spinner.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        spinner.heightAnchor.constraint(equalToConstant: (openHeight - closedHeight) + 8).isActive = true
        
        spinner.delegate = self
        spinner.dataSource = self
        
        // Tap Behaivour
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapped(_:)))
        headerView.addGestureRecognizer(gesture)
    }
    
    public func setSpinnerOptions(options :[String]) {
        
    }
    
    public func selectOption(option :String) {
        
    }
    
    @objc private func tapped(_ sender: UITapGestureRecognizer) {
        if heightConstraint?.constant == closedHeight {
            showPicker()
        }
        else {
            hidePicker()
        }
    }
    
    private func showPicker() {
        guard let h = openHeight else {
            return
        }
        
        self.superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint?.constant = h
            self.superview?.layoutIfNeeded()
        }
    }
    
    private func hidePicker() {
        self.superview?.layoutIfNeeded()
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint?.constant = self.closedHeight
            self.superview?.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension ExpandingPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let count = pickerOptions?.count else {
            return 0
        }
        
        return count
    }
}

extension ExpandingPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let options = pickerOptions else {
            return
        }
        
        let selected = options[row]
        valueText = selected
        hidePicker()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let options = pickerOptions else {
            return ""
        }
        
        return options[row]
    }
}
