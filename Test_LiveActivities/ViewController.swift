//
//  ViewController.swift
//  Test_LiveActivities
//
//  Created by Mr.C on 2022/11/8.
//

import UIKit
import ActivityKit
import SwiftUI
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func live_Start(_ sender: Any) {
        startDeliveryPizza()
    }
    
    @IBAction func live_Update(_ sender: Any) {
        updateDeliveryPizza()
    }
    
    
    @IBAction func live_End(_ sender: Any) {
        stopDeliveryPizza()
    }
    
    
    func startDeliveryPizza() {
        //初始化静态数据
        let pizzaDeliveryAttributes = PizzaDeliveryAttributes(numberOfPizzas: 5, totalAmount:"￥99", orderNumber: "23456")
        //初始化动态数据
        let initialContentState = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "快递小哥 🚴🏻", deliveryTimer: Date()...Date().addingTimeInterval(15 * 60))
                                                  
        do {
            let deliveryActivity = try Activity<PizzaDeliveryAttributes>.request(
                attributes: pizzaDeliveryAttributes,
                contentState: initialContentState,
                pushType: nil)
            let pushToken = deliveryActivity.pushToken  //推送令牌 ，发送给服务器，用于推送Live Activities更新
            print("Requested a pizza delivery Live Activity \(deliveryActivity.id)")
        } catch (let error) {
            print("Error requesting pizza delivery Live Activity \(error.localizedDescription)")
        }
    }
    func updateDeliveryPizza() {
        Task {
            let updatedDeliveryStatus = PizzaDeliveryAttributes.PizzaDeliveryStatus(driverName: "快递小哥 🚴🏻", deliveryTimer: Date()...Date().addingTimeInterval(60 * 60))
            
            for activity in Activity<PizzaDeliveryAttributes>.activities{
                await activity.update(using: updatedDeliveryStatus)
            }
        }
    }
    func stopDeliveryPizza() {
        Task {
            for activity in Activity<PizzaDeliveryAttributes>.activities{
                await activity.end(dismissalPolicy: .immediate)
            }
        }
    }
    func showAllDeliveries() {
        Task {
            for activity in Activity<PizzaDeliveryAttributes>.activities {
                print("Pizza delivery details: \(activity.id) -> \(activity.attributes)")
            }
        }
    }
}
