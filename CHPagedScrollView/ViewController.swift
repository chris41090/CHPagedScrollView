//
//  ViewController.swift
//  CHPagedScrollView
//
//  Created by Christos Hadjikyriacos on 19/10/16.
//  Copyright © 2016 Christos Hadjikyriacos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pagedScrollView: CHPagedScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagedScrollView.pageViews = (0...10).map { (i) -> UIView in
            let view = UIView(frame:pagedScrollView.bounds)
            view.backgroundColor = getRandomColor()
            return view
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }


}

