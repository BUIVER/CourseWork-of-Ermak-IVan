//
//  AppDelegate.swift
//  CourseWork of Ermak IVan
//
//  Created by Ivan Ermak on 11/13/18.
//  Copyright © 2018 Ivan Ermak. All rights reserved.
//


import UIKit

@IBDesignable class GraphMultiView: UIView {
    
    //Weekly sample data
    var graphPoints1 = [1.1,
                       1.2075726849406938,
                       1.3232467529321588,
                       1.4475846894078246,
                       1.5811848836227609,
                       1.724683867510655,
                       1.8787586849073512,
                       2.044129399433965,
                       2.2215617496772095,
                       2.411869960700323,
                       2.6159197213595102,
                       2.8346313373848626,
                       3.0689830707093804,
                       3.32001467609422,
                       3.58883114670257,
                       3.8766066809191098,
                       4.1845888833978515,
                       4.514103214049596,
                       4.866557699452917,
                       5.243447921991415,
                       ]
    var graphPoints2 = [1.1,
                        1.2075726849406938,
                        1.3232467529321588,
                        1.4475846894078246,
                        1.5811848836227609,
                        1.724683867510655,
                        1.8787586849073512,
                        2.044129399433965,
                        2.2215617496772095,
                        2.411869960700323,
                        2.6159197213595102,
                        2.8346313373848626,
                        3.0689830707093804,
                        3.32001467609422,
                        3.58883114670257,
                        3.8766066809191098,
                        4.1845888833978515,
                        4.514103214049596,
                        4.866557699452917,
                        5.243447921991415,
                        ]
    var graphPoints3 = [1.1,
                        1.2075726849406938,
                        1.3232467529321588,
                        1.4475846894078246,
                        1.5811848836227609,
                        1.724683867510655,
                        1.8787586849073512,
                        2.044129399433965,
                        2.2215617496772095,
                        2.411869960700323,
                        2.6159197213595102,
                        2.8346313373848626,
                        3.0689830707093804,
                        3.32001467609422,
                        3.58883114670257,
                        3.8766066809191098,
                        4.1845888833978515,
                        4.514103214049596,
                        4.866557699452917,
                        5.243447921991415,
                        ]
    private struct Constants {
        static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
        static let margin: CGFloat = 20.0
        static let topBorder: CGFloat = 60
        static let bottomBorder: CGFloat = 50
        static let colorAlpha: CGFloat = 0.3
        static let circleDiameter: CGFloat = 5.0
    }
    // 1
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
     /*   let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        */
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
       /* context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: []) */
        //calculate the x point
        
        let margin = Constants.margin
        let graphWidth = width - margin * 2 - 4
        let columnXPoint = { (column: Int) -> CGFloat in
            //Calculate the gap between points
            let spacing = graphWidth / CGFloat(self.graphPoints1.count - 1)
            return CGFloat(column) * spacing + margin + 2
        }
        // calculate the y point
        
        let topBorder = Constants.topBorder
        let bottomBorder = Constants.bottomBorder
        let graphHeight = height - topBorder - bottomBorder
        let maxValue = graphPoints1.max()!
        let columnYPoint = { (graphPoint: Double) -> CGFloat in
            let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + topBorder - y // Flip the graph
        }
        // draw the line graph
        
        UIColor.red.setFill()
        UIColor.red.setStroke()
        
        // set up the points line
        let graphPath = UIBezierPath()
        
        // go to start of line
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint((graphPoints1[0]))))
        
        // add points for each item in the graphPoints array
        // at the correct (x, y) for the point
        for i in 1..<graphPoints1.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint((graphPoints1[i])))
            graphPath.addLine(to: nextPoint)
            
        }
        
        //Create the clipping path for the graph gradient
        
        //1 - save the state of the context (commented out for now)
        context.saveGState()
        
        //2 - make a copy of the path
        let clippingPath = graphPath.copy() as! UIBezierPath
        
        //3 - add lines to the copied path to complete the clip area
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints1.count - 1), y:height))
        clippingPath.addLine(to: CGPoint(x:columnXPoint(0), y:height))
        clippingPath.close()
        
        //4 - add the clipping path to the context
        clippingPath.addClip()
        
        //5 - check clipping path - temporary code
        let highestYPoint = columnYPoint((maxValue))
        let graphStartPoint = CGPoint(x: margin, y: highestYPoint)
        let graphEndPoint = CGPoint(x: margin, y: bounds.height)
        
       // context.drawLinearGradient(gradient, start: graphStartPoint, end: graphEndPoint, options: [])
        context.restoreGState()
        //draw the line on top of the clipped gradient
        graphPath.lineWidth = 2.0
        graphPath.stroke()
        //Draw the circles on top of the graph stroke
        for i in 0..<graphPoints1.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint((graphPoints1[i])))
            point.x -= Constants.circleDiameter / 2
            point.y -= Constants.circleDiameter / 2
            
            let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: Constants.circleDiameter, height: Constants.circleDiameter)))
            circle.fill()
        }
        //Draw horizontal graph lines on the top of everything
        let linePath = UIBezierPath()
        
        //top line
        linePath.move(to: CGPoint(x: margin, y: topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: topBorder))
        
        //center line
        linePath.move(to: CGPoint(x: margin, y: graphHeight/2 + topBorder))
        linePath.addLine(to: CGPoint(x: width - margin, y: graphHeight/2 + topBorder))
        
        //bottom line
        linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
        linePath.addLine(to: CGPoint(x:  width - margin, y: height - bottomBorder))
        let color = UIColor(white: 1.0, alpha: Constants.colorAlpha)
        color.setStroke()
        
        linePath.lineWidth = 1.0
        linePath.stroke()
        //end temporary code
    }
}
