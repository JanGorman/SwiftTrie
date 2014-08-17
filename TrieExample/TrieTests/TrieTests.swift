//
//  TrieTests.swift
//  TrieTests
//
//  Created by Jan Gorman on 16/08/14.
//  Copyright (c) 2014 Jan Gorman. All rights reserved.
//

import UIKit
import XCTest
import Trie

class TrieTests: XCTestCase {

    var trie: Trie! = nil

    override func setUp() {
        trie = Trie()
        super.setUp()
    }

    func addWords(words: [String]) {
        for word in words {
            trie.insert(word)
        }
    }

    func assertFirstWordEqualTo(word: String, inArray array: [String]?) {
        if let firstWord = array?.first {
            XCTAssertEqual(firstWord, "word")
        } else {
            XCTAssertFalse(true, "Word not found")
        }
    }

    func test_whenAddingAWordToTrie_itMatches() {
        addWords(["word"])

        let array = trie.wordsForPrefix("word")

        assertFirstWordEqualTo("word", inArray: array)
    }

    func test_whenAddingMultipleWordsToTrie_oneCanBeFoundByPrefix() {
        addWords(["something", "word"])

        let array = trie.wordsForPrefix("wo")

        assertFirstWordEqualTo("word", inArray: array)
    }

    func test_whenAddingWorsWithSamePrefix_theyBothCanBeFound() {
        addWords(["word", "words"])
        let array = trie.wordsForPrefix("wo")
        XCTAssertTrue(array?.count == 2)
    }

    func test_whenAddingAndRemovingAWord_itIsRemoved() {
        addWords(["word"])
        trie.remove("word")

        let array = trie.wordsForPrefix("word")

        XCTAssertNil(array)
    }

    func test_whenAddingTwoWordsAndRemovingOne_oneWordRemains() {
        addWords(["word", "words"])
        trie.remove("word")

        let array = trie.wordsForPrefix("word")

        assertFirstWordEqualTo("words", inArray: array)
    }

}
