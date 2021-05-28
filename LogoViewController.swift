//
//  LogoViewController.swift
//  APPa
//
//  Created by user189869 on 5/27/21.
//

import UIKit

class LogoViewController: UIViewController {

    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view, typically from a nib.
        let timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timeToMoveOn), userInfo: nil, repeats: false)
       }

       @objc func timeToMoveOn() {
           self.performSegue(withIdentifier: "logo", sender: self)
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
