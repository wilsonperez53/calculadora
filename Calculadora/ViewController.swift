//
//  ViewController.swift
//  Calculadora
//
//  Created by OTSI on 13/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    
    var currentOperation: Operations?
    
    enum Operations {
        case add, sustract, multiply, divide, equals, negative, percentage
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Arial", size: 36)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupNumberPad()
    }
    
    private func setupNumberPad(){
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        
        
        let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 1), width: buttonSize * 2, height: buttonSize))
                                        
        zeroButton.backgroundColor = .blue
        zeroButton.setTitleColor(.white, for: .normal)
        zeroButton.setTitle("0", for: .normal)
        zeroButton.tag = 0
        holder.addSubview(zeroButton)
        zeroButton.addTarget(self, action: #selector(zeroPressed), for: .touchUpInside)
        
        let dotButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - (buttonSize * 1), width: buttonSize, height: buttonSize))
                                        
        dotButton.backgroundColor = .blue
        dotButton.setTitleColor(.white, for: .normal)
        dotButton.setTitle(".", for: .normal)
        holder.addSubview(dotButton)
        
        for x in 0..<3 {
            let row1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 2), width: buttonSize, height: buttonSize))
                                            
            row1.backgroundColor = .blue
            row1.setTitleColor(.white, for: .normal)
            row1.setTitle("\(x+1)", for: .normal)
            row1.tag = x + 2
            row1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                holder.addSubview(row1)
        }
        for x in 0..<3 {
            let row2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize * 3), width: buttonSize, height: buttonSize))
                                            
            row2.backgroundColor = .blue
            row2.setTitleColor(.white, for: .normal)
            row2.setTitle("\(x+4)", for: .normal)
            row2.tag = x + 5
            row2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(row2)
            
        }
        for x in 0..<3 {
            let row3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height - (buttonSize*4), width: buttonSize, height: buttonSize))
                                            
            row3.backgroundColor = .blue
            row3.setTitleColor(.white, for: .normal)
            row3.setTitle("\(x+7)", for: .normal)
            row3.tag = x + 8
            
            row3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
            holder.addSubview(row3)
        }
        
        let operations = ["=","+", "-", "x" , "/", "-", "%"]
        
        for x in 0..<5 {
            let col4 = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height - (buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
                                            
            col4.backgroundColor = .orange
            col4.setTitleColor(.white, for: .normal)
            col4.setTitle(operations[x], for: .normal)
            col4.addTarget(self, action: #selector(operationPressed(_ :)), for: .touchUpInside)
            col4.tag = x + 1
            holder.addSubview(col4)
        }
        

        let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
                                        
        clearButton.backgroundColor = .gray
        clearButton.setTitleColor(.white, for: .normal)
        clearButton.setTitle("AC", for: .normal)
        holder.addSubview(clearButton)

        let percButton = UIButton(frame: CGRect(x: buttonSize * 2, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
                                        
        percButton.backgroundColor = .gray
        percButton.setTitleColor(.white, for: .normal)
        percButton.setTitle("%", for: .normal)
        holder.addSubview(percButton)
        
        let negButton = UIButton(frame: CGRect(x: buttonSize, y: holder.frame.size.height - (buttonSize * 5), width: buttonSize, height: buttonSize))
                                        
        negButton.backgroundColor = .gray
        negButton.setTitleColor(.white, for: .normal)
        negButton.setTitle("+/-", for: .normal)
        holder.addSubview(negButton)

        
    //Results
        resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 100.0, width: view.frame.size.width - 40, height: 100)
        holder.addSubview(resultLabel)
        
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
    }

    @objc func clearResult (){
        resultLabel.text = "0"
        currentOperation = nil
        firstNumber = 0
        
    }
    
    @objc func zeroPressed(_ sender: UIButton){
        if resultLabel.text != "0" {
            if let text = resultLabel.text{
                resultLabel.text = "\(text)\(0)"
            }
        }
    }
    
    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text{
            resultLabel.text = "\(text)\(tag)"
        }
    }
    
    @objc func operationPressed(_ sender: UIButton){
        let tag = sender.tag
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0{
            firstNumber = value
            resultLabel.text = "0"
        }
        if tag == 1 {
            if let operation = currentOperation {
                var secondNumber = 0
                var result = 0
                if let text = resultLabel.text, let value = Int(text){
                    secondNumber = value
                }
                switch operation {
                case .add:
                    result = firstNumber + secondNumber
                    break
                case .sustract:
                    result = firstNumber - secondNumber
                    break
                case .multiply:
                    result = firstNumber * secondNumber
                    break
                case .divide:
                    result = firstNumber / secondNumber
                    break
                case .negative:
                    result = firstNumber * -1
                    break
                case .percentage:
                    result = firstNumber * secondNumber / 100
                    break
                default:
                    break
                }
                resultLabel.text = "\(result)"
            }
        }
        else if tag == 2 {
            currentOperation = .add
        }
        else if tag == 3 {
            currentOperation = .sustract
        }
        else if tag == 4 {
            currentOperation = .multiply
        }
        else if tag == 5 {
            currentOperation = .divide
        }
        else if tag == 6 {
            currentOperation = .negative
        }
        else if tag == 7 {
            currentOperation = .percentage
        }
    }
}

