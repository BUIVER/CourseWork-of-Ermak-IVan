//
//  ViewController.swift
//  CourseWork of Ermak IVan
//
//  Created by Ivan Ermak on 10/26/18.
//  Copyright © 2018 Ivan Ermak. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
 
 
    

    @IBOutlet weak var optimizeView: UIView!
    @IBOutlet weak var optimizeViews: UIBarButtonItem!
    @IBOutlet weak var swapViews: UIBarButtonItem!
    @IBOutlet weak var theoryView: UIView!
    @IBOutlet weak var graphView: GraphMultiView!
    @IBOutlet weak var theoryTable: UITableView!
    
    var definitionList: [Int: String]! = [0: "Число каналов обслуживания", 1: " Максимальная длина очереди(Максимальное число мест в очереди"]
    var valueList: [Int: String]! = [0: "n ≧ 1", 1: "m = +∞"]
    
    func tableView(_ theoryTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return definitionList.count
    }
    
     func tableView(_ theoryTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        debugPrint("trigger")
        guard let cell = theoryTable.dequeueReusableCell(withIdentifier: "TheoryTableViewCell", for: indexPath) as? TheoryTableViewCell else {fatalError("error of init cell")}
        cell.definitionCell.text = definitionList![indexPath.row]
        cell.valueCell.text = valueList![indexPath.row]
        cell.definitionCell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        cell.definitionCell.layer.borderWidth = 3
        cell.valueCell.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        cell.valueCell.layer.borderWidth = 3
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        theoryTable.dataSource = self
        theoryTable.delegate = self
        graphView.isHidden = true
        optimizeView.isHidden = true
        //theoryButton.image = UIImage(named: "bookImage")
        
       
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

     @IBAction func SwapViews(_ sender: Any) {
        theoryView.isHidden = !theoryView.isHidden
        graphView.isHidden = !graphView.isHidden
        optimizeView.isHidden = true
     }
    
     @IBAction func OptimizeViews(_ sender: Any) {
        theoryView.isHidden = true
        optimizeView.isHidden = !optimizeView.isHidden
        graphView.isHidden = true
        multiLineSMService(Cost: 3, AFKcost: 70, money: 40)
     }
    
    
    
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func multiLineSMService(Cost: Double, AFKcost : Double, money: Double)
    {
        var amountOfWorkPlaces: Int = 1
        
        var minimalSpends: Double
        var min : Double
        var moneyBag = money
        let intensive: Double = 4
        let Produce: Double = 4
        var cost = Cost
        let traffic: Double = intensive/Produce
        let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
        minimalSpends = inQueue(amount: 1, trafficForOne: trafficOnOne)
        while(money - cost > 0)
        {
            moneyBag -= cost
            cost *= 1.2
            amountOfWorkPlaces += 1
            let traffic: Double = intensive/Produce
            let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
            debugPrint(inQueue(amount: amountOfWorkPlaces, trafficForOne: trafficOnOne))
            debugPrint("")
            min = (inQueue(amount: amountOfWorkPlaces, trafficForOne: trafficOnOne) * AFKcost) + (money - moneyBag)
            debugPrint(min.description)
            if (minimalSpends < min)
            {
                minimalSpends = min
                
            }
          //  if(min < )
        }
    }
    func inQueue(amount: Int, trafficForOne: Double) -> Double
    {
       return pow(Double(amount), Double(amount))/Double(factorial(numeral: amount)) * (pow(trafficForOne, Double(amount+1)) / pow(1 - trafficForOne, 2)) * probabilityAllFree(amount: amount, trafficForOne: trafficForOne)
    }
    func probabilityAllFree(amount: Int, trafficForOne: Double) -> Double
    {
        var sum: Double = 0
        for k in 0...amount
        {
            sum += pow(Double(amount), Double(k))/Double(factorial(numeral: k)) * pow(trafficForOne, Double(k))
        }
        sum += (pow(Double(amount), Double(amount))/Double(factorial(numeral: amount)) * (pow(trafficForOne, Double(amount+1)) / 1 - trafficForOne))
        return 1/sum
    }
    func factorial(numeral: Int) -> Int
    {
        var result : Int = 1
        if (numeral == 0) {return 1}
        else{
        for k in 1...numeral
        {
            result *= k
        }
        return result
        }
    }
}
