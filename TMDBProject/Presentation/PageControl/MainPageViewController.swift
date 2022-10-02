//
//  MainPageViewController.swift
//  TMDBProject
//
//  Created by Seokjune Hong on 2022/08/16.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    var pageViewControllerList: [UIViewController]  = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        createPageViewController()
        configurePageViewController()
    }
    
    func createPageViewController() {
        let listSb = UIStoryboard(name: StoryboardName.List.rawValue, bundle: nil)
//        let theaterSb = UIStoryboard(name: StoryboardName.Theater.rawValue, bundle: nil)
        let recommandSb = UIStoryboard(name: StoryboardName.Recommand.rawValue, bundle: nil)
        
        guard let listVC = listSb.instantiateViewController(withIdentifier: ListViewController.reuseIdentifier) as? ListViewController else { return }
//        guard let theaterVC = theaterSb.instantiateViewController(withIdentifier: TheaterViewController.reuseIdentifier) as? TheaterViewController else { return }
        guard let recommandVC = recommandSb.instantiateViewController(withIdentifier: RecommandViewController.reuseIdentifier) as? RecommandViewController else { return }
        
        pageViewControllerList = [listVC, recommandVC]
    }
    
    func configurePageViewController() {
        delegate = self
        dataSource = self
        
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

extension MainPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex > pageViewControllerList.count - 1 ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = pageViewControllerList.firstIndex(of: first) else { return 0 }
        
        return index
    }
    
}
