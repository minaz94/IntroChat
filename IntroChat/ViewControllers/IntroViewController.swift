//
//  IntroViewController.swift
//  IntroChat
//
//  Created by Mina on 1/27/24.
//

import UIKit

class IntroViewController: UIViewController {
    
    
    //MARK: - Oulets
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    
    @IBOutlet weak var schoolYearSegmentedControl: UISegmentedControl!
    @IBOutlet weak var petCountLabel: UILabel!
    @IBOutlet weak var petCountStepper: UIStepper!
    @IBOutlet weak var additionalPetSwitch: UISwitch!
    @IBOutlet weak var introduceButton: UIButton!
    
    
    //MARK: - Properties
    
    var petCount: Int = 0
    var schoolYear: String = "first"
    var additionalPet: Bool = true
    
    var alertPresenter: AlertPresenter?
    
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        addDependencies()
    }
    
    
    //MARK: Events
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: Actions
    
    @IBAction func schoolYearSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        guard let title = sender.titleForSegment(at: sender.selectedSegmentIndex) else { return }
        schoolYear = title.lowercased()
    }
    

    @IBAction func petStepperValueChanged(_ sender: UIStepper) {
        petCountLabel.text = "\(Int(sender.value))"
        petCount = Int(sender.value)
    }
    
    
    @IBAction func additionalPetSwitchValueChanged(_ sender: UISwitch) {
        additionalPet = sender.isOn ? true : false
    }
    
    @IBAction func primaryActionTriggered(_ sender: UITextField) {
        if firstNameTextField.isFirstResponder {
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField.isFirstResponder {
            schoolNameTextField.becomeFirstResponder()
        } else if schoolNameTextField.isFirstResponder {
            self.view.endEditing(true)
        }
    }
    
    @IBAction func introduceButtonPressed(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertPresenter?.showAlert(title: "Missing First Name", message: "Please write your name", style: .alert, actions: [UIAlertAction(title: "OK", style: .cancel)])
            return
        }
        
        guard let lastName = lastNameTextField.text, !lastName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertPresenter?.showAlert(title: "Missing Last Name", message: "Please write your last name", style: .alert, actions: [UIAlertAction(title: "OK", style: .cancel)])
            return
        }
        
        guard let schoolName = schoolNameTextField.text, !schoolName.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertPresenter?.showAlert(title: "Missing School Name", message: "Please provide your school name", style: .alert, actions: [UIAlertAction(title: "OK", style: .cancel)])
            return
        }
        
        let additionalPets = additionalPet ? "I want more pets" : "I do not want any more pets"
        
        let introduction = "My name is \(firstName) \(lastName). I attend \(schoolName) and I am currently in my \(schoolYear) year. I have \(petCount) pet\(petCount == 1 ? "" : "s") and \(additionalPets)."
        
        
        alertPresenter?.showAlert(title: "Hello!", message: introduction, style: .alert, actions: [
            UIAlertAction(title: "Nice to meet you!", style: .cancel) { [weak self] action in
                guard let self else { return }
                resetViewState()
                UserStore.shared.save(introduction: introduction)
            }])
        
        
    }
    
    
    //MARK: - View Setup
    
    func setUpViews() {
        setupIntroduceButton()
        setupSchoolYearSegmentedControl()
        setupPetSwitch()
        setupNavigationBar()
    }
    
    func setupIntroduceButton() {
        introduceButton.backgroundColor = .black
        introduceButton.tintColor = .white
        introduceButton.layer.cornerRadius = 8
    }
    
    func setupSchoolYearSegmentedControl() {
        schoolYearSegmentedControl.selectedSegmentTintColor = .black
        schoolYearSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    func setupPetSwitch() {
        additionalPetSwitch.onTintColor = .black
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func resetViewState() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        schoolNameTextField.text = ""
        schoolYearSegmentedControl.selectedSegmentIndex = 0
        petCountStepper.value = 0
        petCountLabel.text = "0"
        additionalPetSwitch.setOn(true, animated: false)
        additionalPet = true
    }
    
    
    //MARK: Dependencies
    
    func addDependencies() {
        alertPresenter = AlertPresenter(navigationController: navigationController)
    }
}

