//
//  ViewController.swift
//  HW2
//
//  Created by Damir Agadilov  on 01.04.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        return scroll
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 200)
    }
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = contentSize
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 20
        return stack
    }()
    
    private let firstStackView = UIStackView()
    private let firstLabel = UILabel()
    private let firstImage = UIImageView()

    
    private let secondStackView = UIStackView()
    private let secondLabel = UILabel()
    private let secondImage = UIImageView()
    
    private let thirdStackView = UIStackView()
    private let thirdLabel = UILabel()
    private let thirdImage = UIImageView()
    
    private let fourthStackView = UIStackView()
    private let fourthLabel = UILabel()
    private let fourthImage = UIImageView()
    
    private let fifthStackView = UIStackView()
    private let fifthLabel = UILabel()
    private let fifthImage = UIImageView()
    
    private let sixthStackView = UIStackView()
    private let sixthLabel = UILabel()
    private let sixthImage = UIImageView()
    
    private let seventhStackView = UIStackView()
    private let seventhLabel = UILabel()
    private let seventhImage = UIImageView()
    
    private let eightStackView = UIStackView()
    private let eightLabel = UILabel()
    private let eightImage = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        stackViewSetUp()
        constraintsSetUp()
        
    }
    
    private func stackViewSetUp() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        let stackArray = [firstStackView, secondStackView, thirdStackView, fourthStackView, fifthStackView, sixthStackView, seventhStackView, eightStackView]
        let labelArray = [firstLabel, secondLabel, thirdLabel, fourthLabel, fifthLabel, sixthLabel, seventhLabel, eightLabel]
        let imageArray = [firstImage, secondImage, thirdImage, fourthImage, fifthImage, sixthImage, seventhImage, eightImage]
        let labelAndImageNames = ["iCloud", "Google", "Microsoft Exchange", "yahoo!", "YouTube", "Github", "Microsoft Outlook", "Safari"]
        
        for i in stackArray.indices {
            stackView.addArrangedSubview(stackArray[i])
            stackArray[i].axis = .horizontal
            stackArray[i].distribution = .fill
            stackArray[i].alignment = .fill
            stackArray[i].spacing = 10
            
            stackArray[i].addArrangedSubview(imageArray[i])
            stackArray[i].addArrangedSubview(labelArray[i])
        }
        
        for i in labelArray.indices {
            labelArray[i].text = labelAndImageNames[i]
            labelArray[i].font = UIFont.systemFont(ofSize: 30)
            labelArray[i].textColor = .black
        }
        
        for i in imageArray.indices {
            let lowercased = labelAndImageNames[i].lowercased()
            imageArray[i].image = UIImage(named: lowercased)
            imageArray[i].contentMode = .scaleAspectFit
        }
        
    }
    
    private func constraintsSetUp() {
        let imageArray = [firstImage, secondImage, thirdImage, fourthImage, fifthImage, sixthImage, seventhImage, eightImage]
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
      
        for i in imageArray {
            i.snp.makeConstraints { make in
                make.width.height.equalTo(50)
            }
        }
    }

}





