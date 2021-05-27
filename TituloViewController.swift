//
//  TituloViewController.swift
//  APPa
//
//  Created by user189869 on 5/14/21.
//

import UIKit

class TituloViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferredContentSize = CGSize(width: 375, height: 150)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return UIInterfaceOrientationMask.landscape
    }
    
    override var shouldAutorotate: Bool {
            return false
    }
}
