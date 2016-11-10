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
    var plistCatPath = "";
    
    var albums: NSMutableArray = [];
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.saveDataToFile), name: UIApplicationWillResignActiveNotification, object: nil)
        RatingChange.minimumValue = 0;
        RatingChange.maximumValue = 5;
        plistCatPath = NSBundle.mainBundle().pathForResource("Albums", ofType: "plist")!;
        albums = NSMutableArray(contentsOfFile:plistCatPath)!;
        artistTextField.text = albums[currentRecord]["artist"] as? String;
        titleTextField.text = albums[currentRecord]["title"] as? String;
        genereTextField.text = albums[currentRecord]["genre"] as? String;
        ratingValueShow.text = String((albums[currentRecord]["rating"]!)!);
        yearTextField.text = String((albums[currentRecord]["date"]!)!);
        RatingChange.value = (albums[currentRecord]["rating"] as! Double);
        pListLength = (albums.count);
        pListLength = pListLength - 2;
        allRecordsCount.text = String(pListLength++);
        currentRecordCount.text = String(currentRecord);
        BtnSave.enabled = false;
        changeRecordLeft.enabled = false;
        artistTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
        titleTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
        genereTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
        RatingChange.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
        yearTextField.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidChange(textField: UITextField) {
        BtnSave.enabled = true;
    }
    @IBAction func changeRecordLeft(sender: UIButton) {
        if (currentRecord == 0){
            currentRecord = 0;
            changeRecordLeft.enabled = false;
        } else {
            currentRecord -= 1;
            changeRecordLeft.enabled = true;
        };
        changeRecordRight.enabled = true;
        BtnNew.enabled = true;
        BtnDelete.enabled = true;
        artistTextField.text = albums[currentRecord]["artist"] as? String;
        titleTextField.text = albums[currentRecord]["title"] as? String;
        genereTextField.text = albums[currentRecord]["genre"] as? String;
        ratingValueShow.text = String((albums[currentRecord]["rating"]!)!);
        yearTextField.text = String((albums[currentRecord]["date"]!)!);
        currentRecordCount.text = String(currentRecord);
    }
    

    @IBAction func changeRecordRight(sender: UIButton) {
        if (currentRecord == pListLength) {
            currentRecord = pListLength;
            changeRecordRight.enabled = false;
            RatingChange.value = 3;
            artistTextField.text = "";
            titleTextField.text = "";
            genereTextField.text = "";
            ratingValueShow.text = "";
            yearTextField.text = "";
            BtnSave.enabled = true;
            BtnDelete.enabled = false;
            BtnNew.enabled = false;
            
        } else {
            currentRecord += 1;
            changeRecordLeft.enabled = true;
            BtnNew.enabled = true;
            BtnDelete.enabled = true;
        
            artistTextField.text = albums[currentRecord]["artist"] as? String;
            titleTextField.text = albums[currentRecord]["title"] as? String;
            genereTextField.text = albums[currentRecord]["genre"] as? String;
            ratingValueShow.text = String((albums[currentRecord]["rating"]!)!);
            yearTextField.text = String((albums[currentRecord]["date"]!)!);
            currentRecordCount.text = String(currentRecord);
        }
    }
    
    @IBAction func changeStepper(sender: UIStepper) {
        let StepperValue = RatingChange.value;
        ratingValueShow.text = String(Int(StepperValue));
    }
    
    
    @IBAction func btnSaveAction(sender: UIButton) {
        if(currentRecord >= pListLength) {
            let newRecord = NSMutableDictionary(dictionary:
                [
                    "artist": artistTextField.text!,
                    "date": yearTextField.text!,
                    "genre": genereTextField.text!,
                    "rating": ratingValueShow.text!,
                    "title": titleTextField.text!
                ]
            )
            print(newRecord);
            albums.addObject(newRecord);
            pListLength += 1;
            currentRecord += 1;
            //recordCount.text = "Record \(currentRecord + 1) of \((albums.count))"
            
            
        } else {
            let updatedRecord:NSMutableDictionary = albums[currentRecord] as! NSMutableDictionary
            updatedRecord.setValue(artistTextField.text!, forKey: "artist")
            updatedRecord.setValue(yearTextField.text, forKey: "date")
            updatedRecord.setValue(genereTextField.text, forKey: "genre")
            updatedRecord.setValue(ratingValueShow.text, forKey: "rating")
            updatedRecord.setValue(titleTextField.text, forKey: "title")
        }
        
        
        changeRecordLeft.enabled = true;
        changeRecordRight.enabled = true;
        BtnSave.enabled = false
        BtnDelete.enabled = true
        BtnNew.enabled = true
        if (currentRecord > 0) {
            changeRecordLeft.enabled = true
        }
    }
    @IBAction func btnNewAction(sender: UIButton) {
        RatingChange.value = 3;
        changeRecordLeft.enabled = false;
        changeRecordRight.enabled = false;
        artistTextField.text = "";
        titleTextField.text = "";
        genereTextField.text = "";
        ratingValueShow.text = "";
        yearTextField.text = "";
        BtnSave.enabled = true;
        BtnDelete.enabled = false;
        BtnNew.enabled = false;
    }
    
    @IBAction func btnDeleteAction(sender: UIButton) {
        let newRecord = NSMutableDictionary(dictionary:
            [
                "artist": artistTextField.text!,
                "date": yearTextField.text!,
                "genre": genereTextField.text!,
                "rating": ratingValueShow.text!,
                "title": titleTextField.text!
            ]
        )
        albums.removeObject(newRecord);
    }
    
    func saveDataToFile(){
        albums.writeToFile(plistCatPath, atomically: true);
    }
    
    
}
