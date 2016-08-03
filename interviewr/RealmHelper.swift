//
//  RealmHelper.swift
//  interviewr
//
//  Created by Jackie Ennis on 8/3/16.
//  Copyright © 2016 Jackie Ennis. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {
    //static methods will go here
    
    static func addQuestion(question: Question) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(question)
        }
    }
    
    //helper method
    static func deleteQuestion(question: Question) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(question)
        }
        
    }
    
    //helper method
    static func retrieveNotes() -> [Question] {
        let realm = try! Realm()
        return realm.objects()
    }

}