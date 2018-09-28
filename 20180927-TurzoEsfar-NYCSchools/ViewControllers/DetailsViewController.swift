//
//  DetailsViewController.swift
//  20180927-TurzoEsfar-NYCSchools
//
//  Created by AM Esfar-E-Alam on 9/27/18.
//  Copyright © 2018 AM Esfar-E-Alam. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var labelCriticalReadingAvg: UILabel!
    @IBOutlet weak var labelNumberofTestTakers: UILabel!
    @IBOutlet weak var labelDbn: UILabel!
    @IBOutlet weak var labelMathAvg: UILabel!
    @IBOutlet weak var labelWritingAvg: UILabel!
    
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelTotalStudents: UILabel!
    @IBOutlet weak var labelinfo1: UILabel!
    @IBOutlet weak var labelInfo2: UILabel!
    @IBOutlet weak var webStieButton: UIButton!
    
    var nycSchool:NYcSchoolModel?
    let viewModel = DetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "NYC Schools"
        loadSATData()
        loadAdditionalInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func webSiteAction(_ sender: Any) {
        if let url = URL(string: "https://\(webStieButton.title(for: .normal)!)") {
            UIApplication.shared.open(url, options: [:])
        }
        
    }
 
    //get data for SAT results
    func loadSATData() {
        
        if ReachabilityChecker.isConnectedToNetwork() {
            let sv = UIViewController.displaySpinner(onView: self.view)
            if nycSchool != nil {
                viewModel.getDetailsSATViewData(dbn:nycSchool?.dbn ?? "") { [unowned self] (data, error) in
                    guard let desiredResult = data else {
                        UIViewController.removeSpinner(spinner: sv)
                        self.alert(message: "Sorry SAT Data For the school Not Available")
                        return
                    }
                    DispatchQueue.main.async {

                   self.viewModel.satData = desiredResult
                    self.updateUI()
                    UIViewController.removeSpinner(spinner: sv)
                    }
                }
            }
        }else{
           self.alert(message: "Internet Connection Problem")
        }
    }

    func updateUI() {
    
        self.labelDbn.text = "DBN: \(viewModel.satData.dbn)"
        self.labelCriticalReadingAvg.text = "Critical reading avg: \(viewModel.satData.sat_critical_reading_avg_score)"
        self.labelMathAvg.text = "Math Avg: \(viewModel.satData.sat_math_avg_score)"
        self.labelWritingAvg.text = "Writing Avg: \(viewModel.satData.sat_writing_avg_score)"
        self.labelNumberofTestTakers.text = "Total Test Takers: \(viewModel.satData.num_of_sat_test_takers)"
    }
    
    //set the additional info of a school
    func loadAdditionalInfo(){
        guard let nycSchoolObject = nycSchool else {
            return
        }
        self.title = nycSchoolObject.school_name
        labelEmail.text = "Email: \(nycSchoolObject.school_email)"
        labelTotalStudents.text = "Total Student: \(nycSchoolObject.total_students)"
        webStieButton.setTitle(nycSchoolObject.website, for: .normal)
        labelinfo1.text = "Phone:\(nycSchoolObject.phone_number)"
        labelInfo2.text = "Neighborhood:\(nycSchoolObject.neighborhood)"
    }
}
