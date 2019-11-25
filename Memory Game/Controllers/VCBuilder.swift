//
//  VCBuilder.swift
//  Memory Game
//
//  Created by AndriiPp on 2/26/19.
//  Copyright © 2019 AndriiPp. All rights reserved.
//
import UIKit
class VSBuilder {
    class func createGameVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameVCStoryIdent")
        return controller
    }
    class func createSecondGameVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "SecondGame", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GameVCStoryIdent")
        return controller
    }
    class func createLevelVC() -> UIViewController {
        let storyboard = UIStoryboard(name: "levelStory", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "levelStoryboard")
        return controller
    }
}
