//
//  HighlightedGridLayout.swift
//  WeatherApp
//
//  Created by Vidhyadharan Mohanram on 23/09/17.
//  Copyright © 2017 Vidhyadharan. All rights reserved.
//

import UIKit

class HighlightedGridLayout: UICollectionViewLayout {

    fileprivate var selectedIndexPath: IndexPath! = IndexPath(row: 0, section: 0)
    fileprivate var numberOfColumns: CGFloat = 2.0

    convenience init(indexPath: IndexPath) {
        self.init()
        selectedIndexPath = indexPath
    }

    //3. Array to keep a cache of attributes.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    //4. Content height and size
    fileprivate var contentHeight: CGFloat = 0

    override var collectionViewContentSize: CGSize {
        let size = CGSize(width: collectionView?.frame.width ?? 0, height: contentHeight)
        return size
    }

    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        var xOffset: CGFloat = 0.0
        var yOffset: CGFloat = 0.0

        let primaryCellHeight = collectionView.frame.width * (666 / 640)
        let secondaryCellHeight = collectionView.frame.height - primaryCellHeight

        for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let nextIndexPath = IndexPath(item: item + 1, section: 0)

            if nextIndexPath == selectedIndexPath {
                if nextIndexPath.row % 2 != 0 {
                    xOffset = 0

                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    let frame = CGRect(x: xOffset, y: yOffset + primaryCellHeight, width: collectionView.frame.width / numberOfColumns, height: secondaryCellHeight)
                    attributes.frame = frame
                    cache.append(attributes)
                } else {
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    let frame = CGRect(x: xOffset, y: yOffset, width: collectionView.frame.width / numberOfColumns, height: secondaryCellHeight)
                    attributes.frame = frame
                    cache.append(attributes)

                    xOffset = 0
                    yOffset = yOffset + secondaryCellHeight
                }
            } else if indexPath == selectedIndexPath {
                if indexPath.row % 2 != 0 {
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    let frame = CGRect(x: xOffset, y: yOffset, width: collectionView.frame.width, height: primaryCellHeight)
                    attributes.frame = frame
                    cache.append(attributes)

                    xOffset = collectionView.frame.width / numberOfColumns
                    yOffset = yOffset + primaryCellHeight
                } else {
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                    let frame = CGRect(x: xOffset, y: yOffset, width: collectionView.frame.width, height: primaryCellHeight)
                    attributes.frame = frame
                    cache.append(attributes)

                    xOffset = 0
                    yOffset = yOffset + primaryCellHeight
                }
            } else if indexPath != selectedIndexPath {
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let frame = CGRect(x: xOffset, y: yOffset, width: collectionView.frame.width / numberOfColumns, height: secondaryCellHeight)
                attributes.frame = frame
                cache.append(attributes)

                xOffset = xOffset == 0 ? collectionView.frame.width / numberOfColumns : 0

                if xOffset == 0 {
                    yOffset = yOffset + secondaryCellHeight
                }
            }
        }
        contentHeight = yOffset
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()

        // Loop through the cache and look for items in the rect
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

}
