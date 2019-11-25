//
//  LevelViewController.swift
//  Memory Game
//
//  Created by Andrii Pyvovarov on 3/28/19.
//  Copyright © 2019 AndriiPp. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {

    @IBOutlet weak var selectLevel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        selectLevelSetup()
    }
    @IBAction func level1(_ sender: Any) {
        loadGame()
    }
    @IBAction func level2(_ sender: Any) {
        secondLoadGame()
    }
    func selectLevelSetup(){
        selectLevel.layer.borderColor = UIColor.black.cgColor
        selectLevel.layer.borderWidth = 1
        selectLevel.layer.cornerRadius = 7
    }
    private func loadGame(){
        weak var gameVC = (VSBuilder.createGameVC() as! GameViewController)
        self.present(gameVC!, animated: true, completion: nil)
    }
    private func secondLoadGame(){
        weak var secondGameVC = (VSBuilder.createSecondGameVC() as! SecondGameViewController)
        self.present(secondGameVC!, animated: true, completion: nil)
    }
}
