//
//  ViewController.swift
//  CountryStateCityPicker
//
//  Created by Aijaz Ali on 8/21/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    let storyboardName = UIStoryboard(name: "Main", bundle: nil)
    var countryID: String?
    var stateID: String?
    var cityID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func countryPickerButtonTapped(_ sender: UIButton) {
        self.presentCountryPicker(isCountry: true)
    }

    @IBAction func statePickerButtonTapped(_ sender: UIButton) {
        self.presentCountryPicker(isState: true)
    }

    @IBAction func cityUIButton(_ sender: UIButton) {
        self.presentCountryPicker(isCity: true)
    }

    private func presentCountryPicker(isCountry: Bool = false, isState: Bool = false, isCity: Bool = false) {
        guard let countryPicker = storyboardName.instantiateViewController(withIdentifier: "CountryPickerVC") as? CountryPickerVC  else { return }
        countryPicker.isCountry = isCountry
        countryPicker.isState = isState
        countryPicker.isCity = isCity
        countryPicker.viewModel.countryId = self.countryID ?? ""
        countryPicker.viewModel.stateId = self.stateID ?? ""
        countryPicker.delegate = self
        self.navigationController?.present(countryPicker, animated: true)
    }
}

extension ViewController: CountryPickerVCDelegate {
    func getCountry(countryID: String?, countryName: String?) {
        self.countryID = countryID
        self.countryLabel.text = countryName
    }

    func getState(stateID: String?, stateName: String?) {
        self.stateID = stateID
        self.stateLabel.text = stateName
    }

    func getCity(cityID: String?, cityName: String?) {
        self.cityID = cityID
        self.cityLabel.text = cityName
    }
}
