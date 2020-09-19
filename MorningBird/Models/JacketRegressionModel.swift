//
//  JacketRegressionModel.swift
//  MorningBird
//
//  The idea with the linear regression is to get the X data (avgTemp) and Y data
//  (ordinal values, 0 == No, 1 == Yes for jacketWorn), and then make a basic equation.
//  If the result of plugging the new estimate into the equation is > 0.5 rounded down,
//  the recommendation to wear a jacket will be "No". If result < 0.5, the recommendation
//  will be "Yes".
//
//
//  Created by Janessa Tran on 9/5/20.
//  Copyright © 2020 Janessa Tran. All rights reserved.
//

import Foundation
import CoreData

class JacketRegressionModel {

    //  The typealias allows us to use '$X.day' and '$X.mW',
    //  instead of '$X.0' and '$X.1' in the following closures.
    typealias PointTuple = (jacketWorn: Double, temperature: Double)

    //  The days are the values on the x-axis.
    //  mW is the value on the y-axis.
    var points: [PointTuple] = []

    init() {
    }

    func getRecommendation() -> String {
        var dataPoints: [UserJacketData] = []
        do {
            let r = NSFetchRequest<NSFetchRequestResult>(entityName: "UserJacketData")
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let f = try context.fetch(r)
            dataPoints = f as! [UserJacketData]
        } catch let error as NSError {
            print("\(error)")
        }
        if dataPoints.count < 2 {
            return "Not enough data points to give a recommendation"
        } else {
            let lastDataPoint = dataPoints.remove(at: dataPoints.endIndex - 1)
            var newDataPoint:Double
            if lastDataPoint.jacketWorn == true {
                newDataPoint = 1.0
            } else {
                newDataPoint = 0.0
            }
            for data: UserJacketData in dataPoints {
                if data.jacketWorn == true {
                    points.append((1.0, data.averageTemperature))
                } else {
                    points.append((0.0, data.averageTemperature))
                }
            }
            let result:Double = bG(jacketWorn: newDataPoint)
            if result > 50.0 {
                return "Yes"
            } else {
                return "No"
            }
        }

    }

    func bG(jacketWorn: Double) -> Double {
        // When using reduce, $0 is the current total.
        let meanJacketWorn = points.reduce(0) { $0 + $1.jacketWorn } / Double(points.count)
        let meanTemperature   = points.reduce(0) { $0 + $1.temperature  } / Double(points.count)

        let a = points.reduce(0) { $0 + ($1.jacketWorn - meanJacketWorn) * ($1.temperature - meanTemperature) }
        let b = points.reduce(0) { $0 + pow($1.jacketWorn - meanJacketWorn, 2) }

        // The equation of a straight line is: y = mx + c
        // Where m is the gradient and c is the y intercept.
        let m = a / b
        let c = meanTemperature - m * meanJacketWorn

        return m * jacketWorn + c
    }

    // use it like bg(3)

}
