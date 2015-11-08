//
//  MailboxViewController.swift
//  Mailbox
//
//  Created by Alex Nako on 11/4/15.
//  Copyright © 2015 Alex Nako. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var helpImage: UIImageView!
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var singleMessageImage: UIImageView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var rescheduleImage: UIImageView!
    @IBOutlet weak var listImage: UIImageView!
    
    var messageInitialX: CGFloat = 0
    var messageDirection: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        scrollView.contentSize.height = helpImage.image!.size.height + searchImage.image!.size.height + singleMessageImage.image!.size.height + feedImage.image!.size.height
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
        singleMessageImage.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "onCustomTap:")
        rescheduleImage.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizerList = UITapGestureRecognizer(target: self, action: "onCustomTapList:")
        listImage.addGestureRecognizer(tapGestureRecognizerList)

        messageView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        self.deleteIcon.hidden = true
        self.listIcon.hidden = true
        
        rescheduleImage.hidden = true
        rescheduleImage.alpha = 0
        
        listImage.hidden = true
        listImage.alpha = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // DRAGGING MESSAGE
    func onCustomPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let point = panGestureRecognizer.locationInView(view)
        let translation = panGestureRecognizer.translationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)

        
        
        // COLOUR CHANGE
        if singleMessageImage.center.x > 215 && singleMessageImage.center.x <= 415 {
            //green
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageView.backgroundColor = UIColor(red: 98/255, green: 217/255, blue: 98/255, alpha: 1)
            })
        
        } else if singleMessageImage.center.x > 415 {
            // red
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageView.backgroundColor = UIColor(red: 239/255, green: 84/255, blue: 13/255, alpha: 1)
            })

        } else if singleMessageImage.center.x < 100 && singleMessageImage.center.x >= -95 {
            //yellow
            //print ("yellow")
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageView.backgroundColor = UIColor(red: 255/255, green: 210/255, blue: 40/255, alpha: 1)
            })

        } else if singleMessageImage.center.x < -95 {
            // salmon
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageView.backgroundColor = UIColor(red: 216/255, green: 116/255, blue: 117/255, alpha: 1)
            })

        } else {
            //gray
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                self.messageView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
            })
        }
        
        
        // ICON MOVE
        if singleMessageImage.center.x >= 105 && singleMessageImage.center.x < 160 {
            self.laterIcon.center.x = 292
            self.laterIcon.hidden = false
            self.laterIcon.alpha = translation.x/50 * -1
        
        }   else if singleMessageImage.center.x < 105 && singleMessageImage.center.x >= -95 {
            self.laterIcon.hidden = false
            self.laterIcon.center.x = singleMessageImage.center.x + 186
            self.listIcon.hidden = true
        
        }   else if singleMessageImage.center.x < -95 {
            self.laterIcon.hidden = true
            self.listIcon.hidden = false
            self.listIcon.center.x = singleMessageImage.center.x + 186
            self.archiveIcon.hidden = true
            
        }   else if singleMessageImage.center.x <= 215 {
            self.archiveIcon.hidden = false
            self.archiveIcon.center.x = 27
            self.archiveIcon.alpha = translation.x/50
            
        }   else if singleMessageImage.center.x > 215 && singleMessageImage.center.x <= 415 {
            self.archiveIcon.center.x = self.singleMessageImage.center.x - 186
            self.archiveIcon.hidden = false
            self.deleteIcon.hidden = true
            print("archive")
            
        }   else if singleMessageImage.center.x > 415 {
            self.archiveIcon.hidden = true
            self.deleteIcon.center.x = singleMessageImage.center.x - 186
            self.deleteIcon.hidden = false
            self.laterIcon.hidden = true
            
        }   else {
            self.archiveIcon.center.x = 27
            self.laterIcon.center.x = 292
            self.archiveIcon.hidden = false
            self.laterIcon.hidden = false
            self.laterIcon.alpha = 1
            self.archiveIcon.alpha = 1
            self.listIcon.hidden = true
            self.deleteIcon.hidden = true
        }

        
        // MESSAGE DRAG
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
            messageInitialX = point.x
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
            messageDirection = velocity.x
            singleMessageImage.center.x = point.x + 160 - messageInitialX
            print(singleMessageImage.center.x)
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
            
            
            // ARCHIVE ACTION
            if messageDirection > 550 && self.singleMessageImage.center.x > 200 && self.singleMessageImage.center.x <= 415 {
                self.archiveIcon.hidden = true
                self.deleteIcon.hidden = true
                self.laterIcon.hidden = true
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.singleMessageImage.center.x = 480
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedImage.frame.origin.y = 82
                            
                            }, completion: { (Bool) -> Void in
                                self.singleMessageImage.center.x = 160
                                self.listIcon.hidden = true
                                self.deleteIcon.hidden = true
                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    self.feedImage.frame.origin.y = 167
                                    self.archiveIcon.hidden = false
                                })
                        })

                
                })
                
            // DELETE ACTION
            } else if messageDirection > 50 && self.singleMessageImage.center.x > 415 {
                self.deleteIcon.hidden = true
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.singleMessageImage.center.x = 480
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedImage.frame.origin.y = 82
                            
                            }, completion: { (Bool) -> Void in
                                self.singleMessageImage.center.x = 160
                                self.listIcon.hidden = true
                                self.deleteIcon.hidden = true

                                UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    self.feedImage.frame.origin.y = 167
                                    self.archiveIcon.hidden = false
                                })
                        })
                        
                        
                })

                
                
            //RESCHEDULE ACTION
            } else if messageDirection < -250 && self.singleMessageImage.center.x < 120 && self.singleMessageImage.center.x >= -95 {
                self.laterIcon.hidden = true
                self.listIcon.hidden = true
                self.archiveIcon.hidden = true
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.singleMessageImage.center.x = -160
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleImage.hidden = false
                            self.rescheduleImage.alpha = 1
                        })
                        
                })
                
            //LIST ACTION
            } else if self.singleMessageImage.center.x < -95  {
                self.laterIcon.hidden = true
                self.listIcon.hidden = true
                self.archiveIcon.hidden = true
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.singleMessageImage.center.x = -160
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listImage.hidden = false
                            self.listImage.alpha = 1
                        })
                        
                })

            } else {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.singleMessageImage.center.x = 160
                    self.listIcon.hidden = true
                    self.deleteIcon.hidden = true

                })
            }
            
        }
    }
    
    
    
    
    //DISMISSING RESCHEDULE
    func onCustomTap(tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.rescheduleImage.alpha = 0
            
            }) { (Bool) -> Void in
                self.rescheduleImage.hidden = true
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.feedImage.frame.origin.y = 82
                    
                    }, completion: { (Bool) -> Void in
                        self.singleMessageImage.center.x = 160
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedImage.frame.origin.y = 167
                            self.laterIcon.hidden = false
                        })
                })
                
        }
        
    }


    //DISMISSING LIST
    func onCustomTapList(tapGestureRecognizerList: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.listImage.alpha = 0
            
            }) { (Bool) -> Void in
                self.listImage.hidden = true
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.feedImage.frame.origin.y = 82
                    
                    }, completion: { (Bool) -> Void in
                        self.singleMessageImage.center.x = 160
                        UIView.animateWithDuration(0.5, animations: { () -> Void in
                            self.feedImage.frame.origin.y = 167
                            self.listIcon.hidden = false
                        })
                })
                
        }
        
    }
    

    

}
