//
//  Copyright (c) 2014 Jan Gorman. All rights reserved.
//

import UIKit
import Trie

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var resultTextView: UITextView!

    private var trie: Trie! = Trie()

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        input.addTarget(self, action: "editChanged:", forControlEvents: .EditingChanged)

        for word in ["alpaca", "antelope", "ape", "armadillo", "baboon", "badger", "bat", "bear", "yak", "zebra"] {
            trie.insert(word)
        }
    }

    func editChanged(textField: UITextField!) {
        let words = trie.wordsForPrefix(textField.text)

        if let matchedWords = words {
            resultTextView.text = "\n".join(matchedWords.map({ "\($0)" }))
        } else {
            resultTextView.text = ""
        }
    }

}

