//
//  FirstViewController.swift
//  FXSwiftDemo
//
//  Created by FeoniX on 2019/4/16.
//  Copyright © 2019 FX. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("hello,swift");
        
        let optionalName: String? = "John Appleseed"
        var greeting = "Hello!"
        if let name = optionalName {
            greeting = "Hello, \(name)"
        }
        print(greeting);
        
        
        let nickName: String? = nil
        let fullName: String = "John"
        let informalGreeting = "Hi \(nickName ?? fullName)";
        
        print(informalGreeting);
        
        print(greet("bob", day: "Tuesday"))
        
        
        let result = calculate(scores: [5,3,100,2,1])
        
        print("\(result.min),\(result.max),\(result.sum)")
        
        returnFifteen()
    }
    
    func greet(_ person:String, day:String) -> String {
        return "hello \(person), today is \(day)."
    }
    
    func calculate(scores :[Int]) -> (min:Int,max:Int,sum:Int) {
        var min = scores[0]
        var max = scores[0]
        var sum = 0
        
        for score in scores {
            if score > max {
                max = score
            } else if score < min{
                min = score
            }
            sum = score + sum;
        }
        
        return (min,max,sum)

    }
    
    /// 嵌套函数
    ///
    /// - Returns:
    func returnFifteen() -> Int {
        var y = 10
        func add() {
            y += 5
        }
        add()
        return y
    }
    
    

}

