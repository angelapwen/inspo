/**
 * Copyright 2019 Google ML Kit team
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import MaterialComponents
import PINRemoteImage

//* Layout values.
private let kHorizontalPadding: CGFloat = 16.0
private let kVerticalPadding: CGFloat = 16.0
private let kVerticalPaddingSmall: CGFloat = 6.0
private let kThumbnailSize: CGFloat = 80.0

//* Cell that shows `Product` details from a search result.
class ProductResultCell: MDCBaseCell {
  //* Thumbnail of the career.
  private(set) var thumbnailImage = UIImageView()
  //* Label showing the name of the career.
  private(set) var nameLabel = UILabel()
  //* Label showing the description of the product.
  private(set) var descriptionLabel = UILabel()

  /**
   * Populates the content of the cell with a `Product` model.
   *
   * @param product The product info to populate the cell with.
   * @return YES if product is not nil, otherwise, NO.
   */
  func isCellPopulated(with product: Product?) -> Bool {
    guard let product = product else { return false }
    if let imageURL = product.careerImageURL, !imageURL.isEmpty {
      thumbnailImage.pin_setImage(from: URL(string: imageURL))
    }
    nameLabel.text = product.careerName
    descriptionLabel.text = product.description
    return true
  }

  // MARK: - Public
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(thumbnailImage)

    nameLabel.numberOfLines = 0
    nameLabel.font = MDCBasicFontScheme().subtitle1
    addSubview(nameLabel)

    descriptionLabel.numberOfLines = 0
    descriptionLabel.font = MDCBasicFontScheme().body2
    descriptionLabel.textColor = MDCPalette.grey.tint700
    addSubview(descriptionLabel)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
    /// Dismisses the current view and moves to the next Environmentalist view 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches)
        super.touchesBegan(touches, with: event)
        
        let storyboard = UIStoryboard(name: "MainViews", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EnvironmentalistViewController")
        controller.modalPresentationStyle = .fullScreen 
                
        self.window?.rootViewController?.presentedViewController?.dismiss(animated: true)
        
        self.window?.rootViewController?.present(controller, animated: true)
    }

  // MARK: - UICollectionReusableView
  override func prepareForReuse() {
    super.prepareForReuse()
    thumbnailImage.image = nil
    nameLabel.text = nil
    descriptionLabel.text = nil
  }

  // MARK: - UIView
  override func layoutSubviews() {
    super.layoutSubviews()
    let _ = layoutSubviews(forWidth: frame.size.width, shouldSetFrame: true)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let width = frame.size.width
    let height = layoutSubviews(forWidth: width, shouldSetFrame: false)
    return CGSize(width: width, height: height)
  }

  // MARK: - Private

  /**
   * Calculates the height that best fits the specified width for subviews.
   *
   * @param width The available width for the view.
   * @param shouldSetFrame Whether to set frames for subviews.
   *    If it is set to NO, this function will simply measure the space without affecting subviews,
   *    otherwise, subviews will be laid out accordingly.
   * @return The best height of the view that fits the width.
   */
  func layoutSubviews(forWidth width: CGFloat, shouldSetFrame: Bool) -> CGFloat {
    var contentWidth = width - 2 * kHorizontalPadding

    var currentHeight = kVerticalPadding
    var startX = kHorizontalPadding

    if shouldSetFrame {
      thumbnailImage.frame = CGRect(x: startX, y: currentHeight, width: kThumbnailSize, height: kThumbnailSize)
    }

    startX += kThumbnailSize + kHorizontalPadding

    contentWidth -= kThumbnailSize + kHorizontalPadding

    let nameLabelSize = nameLabel.sizeThatFits(CGSize(width: contentWidth, height: CGFloat.greatestFiniteMagnitude))
    if shouldSetFrame {
      nameLabel.frame = CGRect(x: startX, y: currentHeight, width: contentWidth, height: nameLabelSize.height)
    }
    currentHeight += nameLabelSize.height + kVerticalPaddingSmall

    let categoryLabelSize = descriptionLabel.sizeThatFits(CGSize(width: contentWidth,
                                                               height: CGFloat.greatestFiniteMagnitude))
    if shouldSetFrame {
      descriptionLabel.frame = CGRect(x: startX, y: currentHeight, width: contentWidth,
                                    height: categoryLabelSize.height)
    }

    currentHeight += categoryLabelSize.height + kVerticalPadding

    return max(currentHeight, kThumbnailSize + 2 * kVerticalPadding)
  }
}
