//
//  ViewController.swift
//  Ios_Final_Minesweeper
//
//  Created by William Komer, JD Ryder on 12/15/16.
//  Copyright © 2016 wkomer. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let BOARD_SIZE:Int = 10
    var board:Board
    var squareButtons:[SquareButton] = []
    
    var moves:Int = 0 {
        didSet {
            self.movesLabel.text = "Moves: \(moves)"
            self.movesLabel.sizeToFit()
        }
    }
    var timeTaken:Int = 0  {
        didSet {
            self.timeLabel.text = "Time: \(timeTaken)"
            self.timeLabel.sizeToFit()
        }
    }
    var oneSecondTimer:NSTimer?
    
    //MARK: Initialization
    
    required init?(coder aDecoder: (NSCoder!))
    {
        self.board = Board(size: BOARD_SIZE)
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.initializeBoard()
        self.startNewGame()
    }
    
    
    func initializeBoard() {
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                
                let square = board.squares[row][col]
                
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(BOARD_SIZE);
                
                let squareButton = SquareButton(squareModel: square, squareSize: squareSize);
                squareButton.setTitle("[x]", forState: .Normal)
                squareButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
                squareButton.addTarget(self, action: #selector(ViewController.squareButtonPressed(_:)), forControlEvents: .TouchUpInside)
                self.boardView.addSubview(squareButton)
                
                self.squareButtons.append(squareButton)
            }
        }
    }
    
    func resetBoard() {
        // resets the board with new mine locations & sets isRevealed to false for each square
        self.board.resetBoard()
        // iterates through each button and resets the text to the default value
        for squareButton in self.squareButtons {
            squareButton.setTitle("[x]", forState: .Normal)
        }
    }
    
    func startNewGame() {
        //start new game
        self.resetBoard()
        self.timeTaken = 0
        self.moves = 0
        self.oneSecondTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.oneSecond), userInfo: nil, repeats: true)
    }
    
    func oneSecond() {
        self.timeTaken += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Actions
    
    @IBAction func newGamePressed() {
        print("new game")
        self.endCurrentGame()
        self.startNewGame()
    }
    
    func squareButtonPressed(sender: SquareButton) {
        //        println("Pressed row:\(sender.square.row), col:\(sender.square.col)")
        //        sender.setTitle("", forState: .Normal)
        
        if !sender.square.isRevealed {
            sender.square.isRevealed = true
            sender.setTitle("\(sender.getLabelText())", forState: .Normal)
            self.moves += 1
        }
        
        if sender.square.isMineLocation {
            self.minePressed()
        }
    }
    
    func minePressed() {
        self.endCurrentGame()
        // show an alert when you tap on a mine
        let alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "GAME OVER!"
        alertView.message = "You Hit a mine."
        alertView.show()
        alertView.delegate = self
    }
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }
    
    func endCurrentGame() {
        self.oneSecondTimer!.invalidate()
        self.oneSecondTimer = nil
    }
    
    
}

