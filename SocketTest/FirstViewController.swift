//
//  FirstViewController.swift
//  SocketTest
//
//  Created by 蔡佳旅 on 2016/11/11.
//  Copyright © 2016年 蔡佳旅. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class FirstViewController: UIViewController {

    @IBOutlet weak var portTF: UITextField!
    @IBOutlet weak var msgTF: UITextField!
    @IBOutlet weak var infoTV: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var serverSocket: GCDAsyncSocket?
    var clientSocket: GCDAsyncSocket?
    
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
    
    //Listening
    @IBAction func listeningAct(sender: AnyObject) {
        serverSocket = GCDAsyncSocket(delegate: self, delegateQueue: dispatch_get_main_queue())
        
        do {
            try serverSocket?.acceptOnPort(UInt16(portTF.text!)!)
            addText("Successfully listening")
        }catch _ {
            addText("Failed to listen")
        }
    
    }
    
    //Sending
    @IBAction func sendAct(sender: AnyObject) {
        let data = msgTF.text?.dataUsingEncoding(NSUTF8StringEncoding)
        clientSocket?.writeData(imgData, withTimeout: -1, tag: 0)
        addText("Send Data")
    }
    
}

extension FirstViewController: GCDAsyncSocketDelegate {
    //When receiving new socket connection
    func socket(sock: GCDAsyncSocket!, didAcceptNewSocket newSocket: GCDAsyncSocket!) {
        addText("Successfully connect")
        addText("connected address: " + newSocket.connectedHost)
        addText("port number: " + String(newSocket.connectedPort))
        clientSocket = newSocket
        
        //First time to start reading data
        clientSocket!.readDataWithTimeout(-1, tag: 0)
    }
    
    func socket(sock: GCDAsyncSocket!, didReadData data: NSData!, withTag tag: Int) {
        let message = String(data: data, encoding: NSUTF8StringEncoding)
        addText(message!)
        //Prepare to read next data
        sock.readDataWithTimeout(-1, tag: 0)
    }
    
}
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    



