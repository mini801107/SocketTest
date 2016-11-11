//
//  SecondViewController.swift
//  SocketTest
//
//  Created by 蔡佳旅 on 2016/11/11.
//  Copyright © 2016年 蔡佳旅. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class SecondViewController: UIViewController {

    @IBOutlet weak var ipTF: UITextField!
    @IBOutlet weak var portTF: UITextField!
    @IBOutlet weak var msgTF: UITextField!
    @IBOutlet weak var infoTV: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var socket: GCDAsyncSocket?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addText(text:String) {
        infoTV.text = infoTV.text.stringByAppendingFormat("%@\n", text)
    }

    //connecting
    @IBAction func connectionAct(sender: AnyObject) {
        socket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        
        do {
            try socket?.connectToHost(ipTF.text, onPort: UInt16(portTF.text!)!)
            addText("Successfully connect")
        }catch _ {
            addText("Failed to connect")
        }
    }
    
    //disconnecting
    @IBAction func disconnectAct(sender: AnyObject) {
        socket?.disconnect()
        addText("Disconnected")
    }
    
    //Sending
    @IBAction func sendMsgAct(sender: AnyObject) {
        socket?.writeData(msgTF.text?.dataUsingEncoding(NSUTF8StringEncoding), withTimeout: -1, tag: 0)
    }

}

extension SecondViewController: GCDAsyncSocketDelegate {
    func socket(sock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        addText("connected to: " + host)
        self.socket?.readDataWithTimeout(-1, tag: 0)
    }
    
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let message = String(data: data, encoding: NSUTF8StringEncoding)
        addText(message!)
        
        //Prepare to read next data
        sock.readDataWithTimeout(-1, tag: 0)
    }
}












