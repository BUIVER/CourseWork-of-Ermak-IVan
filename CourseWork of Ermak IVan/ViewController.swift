//
//  ViewController.swift
//  CourseWork of Ermak IVan
//
//  Created by Ivan Ermak on 10/26/18.
//  Copyright © 2018 Ivan Ermak. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
 
 
    

    @IBOutlet weak var optimizeView: UIView!
    @IBOutlet weak var optimizeViews: UIButton!

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }

   
     @IBAction func OptimizeViews(_ sender: Any) {
       
    
        let smsclassic = SMSclassic()
        let smsAllAsOne = SMSAllAsOne()
        let smsBalancedHelp = SMSBalancedHelp()
       smsclassic.multiLineSMService(Cost: 3, AFKcost: 70, money: 40)
        smsAllAsOne.multiLineSMService(Cost: 3, AFKcost: 70, money: 40)
        smsBalancedHelp.multiLineSMService(Cost: 3, AFKcost: 70, money: 40)
     }
    
    
    
    
}
class Math
{
    func factorial(numeral: Int) -> Double
    {
        var result : Double = 1
        if (numeral == 0) {return 1}
        else{
            for k in 1...numeral
            {
                result *= Double(k)
            }
            return result
        }
    }
}
class SMSAllAsOne
{
    let math = Math()
    func multiLineSMService(Cost: Double, AFKcost : Double, money: Double)
    {
        var amountOfWorkPlaces: Int = 1
        
        var minimalSpends: Double
        var min : Double
        var moneyBag = money
        let intensive: Double = 4
        let Produce: Double = 5
        let cost = Cost
        let traffic: Double = intensive/Produce
        let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
        minimalSpends = inQueue(amount: 1, trafficForOne: trafficOnOne)
        while(moneyBag - cost > 0)
        {
            moneyBag -= cost
            
            amountOfWorkPlaces += 1
            let traffic: Double = intensive/Produce
            let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
            min = (inQueue(amount: amountOfWorkPlaces, trafficForOne: trafficOnOne) * AFKcost) + (money - moneyBag)
            if (minimalSpends < min)
            {
                minimalSpends = min
                
            }
        }
    }
    func inQueue(amount: Int, trafficForOne: Double) -> Double
    {
        return pow(trafficForOne, 2) / (1-trafficForOne)
    }
    
}
class SMSclassic
{
    
let math = Math()
func multiLineSMService(Cost: Double, AFKcost : Double, money: Double)
{
    var amountOfWorkPlaces: Int = 1
    
    var minimalSpends: Double
    var min : Double
    var moneyBag = money
    let intensive: Double = 4
    let Produce: Double = 5
    let cost = Cost
    let traffic: Double = intensive/Produce
    let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
    minimalSpends = inQueue(amount: 2, trafficForOne: trafficOnOne)
    while(moneyBag - cost > 0)
    {
        moneyBag -= cost
        
        amountOfWorkPlaces += 1
        let traffic: Double = intensive/Produce
        let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
        min = (inQueue(amount: amountOfWorkPlaces, trafficForOne: trafficOnOne) * AFKcost) + (money - moneyBag)
        if (minimalSpends < min)
        {
            minimalSpends = min
            
        }
    }
}
func inQueue(amount: Int, trafficForOne: Double) -> Double
{
    return pow(Double(amount), Double(amount))/Double(math.factorial(numeral: amount)) * (pow(trafficForOne, Double(amount+1)) / pow(1 - trafficForOne, 2)) * probabilityAllFree(amount: amount, trafficForOne: trafficForOne)
}
func probabilityAllFree(amount: Int, trafficForOne: Double) -> Double
{
    var sum: Double = 0
    for k in 0...amount
    {
        sum += pow(Double(amount), Double(k))/Double(math.factorial(numeral: k)) * pow(trafficForOne, Double(k))
    }
    sum += (pow(Double(amount), Double(amount))/Double(math.factorial(numeral: amount)) * (pow(trafficForOne, Double(amount+1)) / (1 - trafficForOne)))
    return 1/sum
}
}
class SMSBalancedHelp
{
    let math = Math()
    func multiLineSMService(Cost: Double, AFKcost : Double, money: Double)
    {
        var amountOfWorkPlaces: Int = 1
        
        var minimalSpends: Double
        var min : Double
        var moneyBag = money
        let intensive: Double = 4
        let Produce: Double = 5
        let cost = Cost
        let traffic: Double = intensive/Produce
        let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
        minimalSpends = inQueue(amount: 1, trafficForOne: trafficOnOne)
        while(moneyBag - cost > 0)
        {
            moneyBag -= cost
            
            amountOfWorkPlaces += 1
            let traffic: Double = intensive/Produce
            let trafficOnOne: Double = traffic / Double(amountOfWorkPlaces)
            min = (inQueue(amount: amountOfWorkPlaces, trafficForOne: trafficOnOne) * AFKcost) + (money - moneyBag)
            if (minimalSpends < min)
            {
                minimalSpends = min
                
            }
        }
    }
    func inQueue(amount: Int, trafficForOne: Double) -> Double
    {
        return pow(trafficForOne, Double(amount+1)) / (1-trafficForOne)
    }
    
}
