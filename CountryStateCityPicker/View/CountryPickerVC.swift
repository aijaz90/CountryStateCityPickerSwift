//
//  CountryPickerVC.swift
//  CountryStateCityPicker
//
//  Created by Aijaz Ali on 8/11/21.
//

import UIKit

protocol CountryPickerVCDelegate: AnyObject {
    func getCountry(countryID: String?, countryName: String?)
    func getState(stateID: String?, stateName: String?)
    func getCity(cityID: String?, cityName: String?)
}

class CountryPickerVC: UIViewController {

    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet private weak var countryPickerTitleLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    weak var delegate: CountryPickerVCDelegate?
    var viewModel = CountryPickerViewModel()
    var isCountry = false
    var isState = false
    var isCity = false
    var countryId = ""
    var stateId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func prepareView() {
        self.tableViewSetup()
        if isCountry {
            countryPickerTitleLabel.text = .select + .countryPicker
        } else if isState {
            countryPickerTitleLabel.text = .select + .statePicker
        } else {
            countryPickerTitleLabel.text = .select + .cityPicker
        }
    }

    private func tableViewSetup() {
        // self.emptyCardLabel.isHidden = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 20, right: 0)
        tableView.register(UINib(nibName:"CountryPickerTVCell", bundle: nil), forCellReuseIdentifier: "CountryPickerTVCell")
        tableView.separatorStyle = .none
    }

    
    private func noRecordFound(isNotFound: Bool) {
        if isNotFound {
            self.tableView.isHidden = true
            self.emptyDataLabel.text = "No " + (self.isCountry ? .countryPicker : self.isState ? .statePicker : .cityPicker) + " Found"
        } else {
            self.tableView.isHidden = false
        }
    }
}

extension CountryPickerVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isCountry {
            self.noRecordFound(isNotFound: self.viewModel.countries.count == 0)
            return self.viewModel.countries.count
        } else if isState {
            self.noRecordFound(isNotFound: self.viewModel.states.count == 0)
            return self.viewModel.states.count
        } else {
            self.noRecordFound(isNotFound: self.viewModel.cities.count == 0)
            return self.viewModel.cities.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryPickerTVCell", for: indexPath) as? CountryPickerTVCell
        if isCountry {
            cell?.titleLabel.text = self.viewModel.countries[indexPath.row].name
        } else if isState {
            cell?.titleLabel.text = self.viewModel.states[indexPath.row].name
        } else {
            cell?.titleLabel.text = self.viewModel.cities[indexPath.row].name
        }
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Selected Cell: ")
        self.dismiss(animated: true)
        if isCountry {
            self.delegate?.getCountry(countryID: self.viewModel.countries[indexPath.row].id, countryName: self.viewModel.countries[indexPath.row].name)
        } else if isState {
            self.delegate?.getState(stateID: self.viewModel.states[indexPath.row].id, stateName: self.viewModel.states[indexPath.row].name)
        } else {
            self.delegate?.getCity(cityID: self.viewModel.cities[indexPath.row].id, cityName: self.viewModel.cities[indexPath.row].name)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
