//
//  ViewController.swift
//  Albums
//
//  Created by Użytkownik Gość on 13.10.2016.
//  Copyright © 2016 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK Properties
    
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var genereTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var ratingValueShow: UILabel!
    @IBOutlet weak var RatingChange: UIStepper!
    @IBOutlet weak var BtnSave: UIButton!
    @IBOutlet weak var BtnDelete: UIButton!
    @IBOutlet weak var BtnNew: UIButton!
    @IBOutlet weak var allRecordsCount: UILabel!
    @IBOutlet weak var currentRecordCount: UILabel!
    
    @IBOutlet weak var changeRecordLeft: UIButton!
    @IBOutlet weak var changeRecordRight: UIButton!
    
    var currentRecord = 0;
    var pListLength = 5;
    var albums: NSArray?;
    
    override func viewDidLoad() {
        RatingChange.minimumValue = 0;
        RatingChange.maximumValue = 5;
        let plistCatPath = NSBundle.mainBundle().pathForResource("Albums", ofType: "plist");
        albums = NSArray(contentsOfFile:plistCatPath!);
        artistTextField.text = albums?[currentRecord]["artist"] as? String;
        titleTextField.text = albums?[currentRecord]["title"] as? String;
        genereTextField.text = albums?[currentRecord]["genre"] as? String;
        ratingValueShow.text = String((albums?[currentRecord]["rating"]!)!);
        yearTextField.text = String((albums?[currentRecord]["date"]!)!);
        RatingChange.value = (albums?[currentRecord]["rating"] as! Double);
        pListLength = (albums?.count)!;
        pListLength--;
        allRecordsCount.text = String(pListLength++);
        currentRecordCount.text = String(currentRecord);
        BtnSave.enabled = false;
        changeRecordLeft.enabled = false;
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeRecordLeft(sender: UIButton) {
        if (currentRecord == 0){
            currentRecord = 0;
            changeRecordLeft.enabled = false;
        } else {
            currentRecord--;
        };
        
        artistTextField.text = albums?[currentRecord]["artist"] as? String;
        titleTextField.text = albums?[currentRecord]["title"] as? String;
        genereTextField.text = albums?[currentRecord]["genre"] as? String;
        ratingValueShow.text = String((albums?[currentRecord]["rating"]!)!);
        yearTextField.text = String((albums?[currentRecord]["date"]!)!);
        currentRecordCount.text = String(currentRecord);
    }
    

    @IBAction func changeRecordRight(sender: UIButton) {
        if (currentRecord == pListLength) {
            currentRecord = pListLength;
            changeRecordRight.enabled = false;
        } else {
            currentRecord++;
        };
        artistTextField.text = albums?[currentRecord]["artist"] as? String;
        titleTextField.text = albums?[currentRecord]["title"] as? String;
        genereTextField.text = albums?[currentRecord]["genre"] as? String;
        ratingValueShow.text = String((albums?[currentRecord]["rating"]!)!);
        yearTextField.text = String((albums?[currentRecord]["date"]!)!);
        currentRecordCount.text = String(currentRecord);
    }
    
    @IBAction func changeStepper(sender: UIStepper) {
        let StepperValue = RatingChange.value;
        ratingValueShow.text = String(Int(StepperValue));
    }
}