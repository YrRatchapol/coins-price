//
//  CoinListViewController.swift
//  CoinPrice
//
//  Created by Ratchapol Pattarakanoksiri on 9/3/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CoinListDisplayLogic: AnyObject {
    func displayCoinList(viewModel: CoinList.GetCoinList.ViewModel)
    func displaySelectCoin(viewModel: CoinList.SelectCoin.ViewModel)
    func displaySelectCoinTopRank(viewModel: CoinList.SelectCoinTopRank.ViewModel)
}

class CoinListViewController: UIViewController, CoinListDisplayLogic {
    var interactor: CoinListBusinessLogic?
    var router: (NSObjectProtocol & CoinListRoutingLogic & CoinListDataPassing)?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = CoinListInteractor()
        let presenter = CoinListPresenter()
        let router = CoinListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchTextField()
        regisNib()
        addPullToRefresh()
        getCoinList()
    }

    @objc func refreshData(_ sender: Any) {
        getCoinList(isPullToRefresh: true)
    }

    func regisNib() {
        let coinViewCellNib = UINib(nibName: "CoinViewCell", bundle: nil)
        tableView.register(coinViewCellNib, forCellReuseIdentifier: "CoinViewCell")

        let loadingViewCellNib = UINib(nibName: "LoadingViewCell", bundle: nil)
        tableView.register(loadingViewCellNib, forCellReuseIdentifier: "LoadingViewCell")

        let loadFailViewNib = UINib(nibName: "LoadFailViewCell", bundle: nil)
        tableView.register(loadFailViewNib, forCellReuseIdentifier: "LoadFailViewCell")

        let inviteViewCellNib = UINib(nibName: "InviteViewCell", bundle: nil)
        tableView.register(inviteViewCellNib, forCellReuseIdentifier: "InviteViewCell")

        let topRankViewCellNib = UINib(nibName: "TopRankViewCell", bundle: nil)
        tableView.register(topRankViewCellNib, forCellReuseIdentifier: "TopRankViewCell")
    }

    func setSearchTextField() {
        clearButton.isHidden = true
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextField.iq.toolbar.doneBarButton.setTarget(self, action: #selector(doneButtonClicked))

    }

    func addPullToRefresh() {
        refreshControlView = CustomPullToRefreshView.fromNib()
        refreshControlView.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)

        tableView.refreshControl = refreshControlView
        refreshControlView.start()
    }

    // MARK: Do something
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchNotFoundView: UIView!

    var refreshControlView: CustomPullToRefreshView!

    var coinListDisplay: [CoinList.GetCoinList.ViewModel.CoinDisplay] = []
    var coinTopRankListDisplay: [CoinList.GetCoinList.ViewModel.CoinDisplay] = []

    func getCoinList(searchText: String? = nil, isLoadMore: Bool = false, isPullToRefresh: Bool = false) {
        tableView.isHidden = false
        searchNotFoundView.isHidden = true

        let request = CoinList.GetCoinList.Request(searchText: searchText, isPullToRefresh: isPullToRefresh, isLoadMore: isLoadMore)
        interactor?.doGetCoinList(request: request)
    }

    func selectCoin(index: Int) {
        if coinListDisplay[index].isForAdv {
            shareInvite()
        } else {
            interactor?.doSelectCoin(request: CoinList.SelectCoin.Request(index: index))
        }
    }

    func selectCoinTopRank(index: Int) {
        interactor?.doSelectCoinTopRank(request: CoinList.SelectCoinTopRank.Request(index: index))
    }

    func displayCoinList(viewModel: CoinList.GetCoinList.ViewModel) {
        coinListDisplay = viewModel.displayedCoinList
        coinTopRankListDisplay = viewModel.displayedCoinTopRankList
        tableView.reloadData()
        refreshControlView.endRefreshing()
        if interactor?.isLoadFail ?? false || interactor?.isLoading ?? false {
            let lastSection = tableView.numberOfSections - 1
            let lastRow = tableView!.numberOfRows(inSection: lastSection) - 1
            let lastRowIndexPath = IndexPath(row: lastRow, section: lastSection)
            tableView.scrollToRow(at: lastRowIndexPath, at: .bottom, animated: true)
        } else if interactor?.isSearching ?? false{
            tableView.isHidden = coinListDisplay.isEmpty
            searchNotFoundView.isHidden = !coinListDisplay.isEmpty
        }
    }

    func displaySelectCoin(viewModel: CoinList.SelectCoin.ViewModel) {
        router?.routeToCoinDetail()
    }

    func displaySelectCoinTopRank(viewModel: CoinList.SelectCoinTopRank.ViewModel) {
        router?.routeToCoinDetail()
    }

    func shareInvite() {
        let text = "Can you join us"

        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }

    @IBAction func onTapClearButton() {
        clearButton.isHidden = true
        searchTextField.text = ""
        getCoinList(searchText: "")
    }
}

// MARK: SearchTextField Delegate
extension CoinListViewController {
    @objc func textFieldDidChange(_ textField: UITextField) {
        clearButton.isHidden = textField.text?.isEmpty ?? true
    }

    @objc func doneButtonClicked(_ sender: Any) {
        getCoinList(searchText: searchTextField.text ?? "")
    }
}

// MARK: TableView Delegate and DataSource
extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if interactor?.isSearching ?? false { // 1 section
            if coinListDisplay.count > indexPath.row {
                return 92
            } else {
                return interactor?.isLoadFail ?? false ? 60 : 40
            }
        } else { // 2 section
            if indexPath.section == 0 {
                return 180
            } else {
                if coinListDisplay.count > indexPath.row {
                    return 92
                } else {
                    return interactor?.isLoadFail ?? false ? 60 : 40
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCoin(index: indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if interactor?.isSearching ?? false { // 1 section
            return 40
        } else { // 2 section
            if section == 0 {
                return coinTopRankListDisplay.count == 3 ? 40 : 0
            } else {
                return 40
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

        if maximumOffset - currentOffset <= 0 && !(interactor?.isLoadFail ?? false) && !(interactor?.isLoading ?? false) {
            getCoinList(isLoadMore: true)
        }
    }
}

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if interactor?.isSearching ?? false { // 1 section
            return getCoinHeaderView()
        } else { // 2 section
            if section == 0 {
                return getCoinTopRankHeaderView()
            } else {
                return getCoinHeaderView()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor?.isSearching ?? false ? 1 : 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if interactor?.isSearching ?? false { // 1 section
            let loadingView = interactor?.isLoading == true ? 1 : 0
            let loadingFail = interactor?.isLoadFail == true ? 1 : 0
            return coinListDisplay.count + loadingView + loadingFail
        } else { // 2 section
            if section == 0 {
                return coinTopRankListDisplay.count == 3 ? 1 : 0
            } else {
                let loadingView = interactor?.isLoading == true ? 1 : 0
                let loadingFail = interactor?.isLoadFail == true ? 1 : 0
                return coinListDisplay.count + loadingView + loadingFail
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !(interactor?.isSearching ?? false) { // 2 section
            if indexPath.section == 0 {
                return getCoinTopRankViewCell(indexPath: indexPath)
            } else {
                return getCoinViewCell(indexPath: indexPath)
            }
        } else { // 1 section
            return getCoinViewCell(indexPath: indexPath)
        }
    }

    func getCoinTopRankViewCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopRankViewCell", for: indexPath) as! TopRankViewCell
        let firstData = coinTopRankListDisplay[0]
        let secondData = coinTopRankListDisplay[1]
        let thirdData = coinTopRankListDisplay[2]
        cell.bindData(firstIconImageString: firstData.iconImageUrlString,
                      firstName: firstData.name,
                      firstSymbol: firstData.symbol,
                      firstChangeImage: firstData.change == .up
                      ? UIImage(named: "arrow_up")
                      : UIImage(named: "arrow_down"),
                      firstChange: firstData.changeRate,
                      firstChangeColor: firstData.change == .up
                      ? UIColor(named: "forceGreenColor")
                      : UIColor(named: "forceRedColor"),
                      secondIconImageString: secondData.iconImageUrlString,
                      secondName: secondData.name,
                      secondSymbol: secondData.symbol,
                      secondChangeImage: secondData.change == .up
                      ? UIImage(named: "arrow_up")
                      : UIImage(named: "arrow_down"),
                      secondChange: secondData.changeRate,
                      secondChangeColor: secondData.change == .up
                      ? UIColor(named: "forceGreenColor")
                      : UIColor(named: "forceRedColor"),
                      thirdIconImageString: thirdData.iconImageUrlString,
                      thirdName: thirdData.name,
                      thirdSymbol: thirdData.symbol,
                      thirdChangeImage: thirdData.change == .up
                      ? UIImage(named: "arrow_up")
                      : UIImage(named: "arrow_down"),
                      thirdChange: thirdData.changeRate,
                      thirdChangeColor: thirdData.change == .up
                      ? UIColor(named: "forceGreenColor")
                      : UIColor(named: "forceRedColor"))

        cell.onTapFirst = { [weak self] in
            self?.selectCoinTopRank(index: 0)
        }

        cell.onTapSecond = { [weak self] in
            self?.selectCoinTopRank(index: 1)
        }

        cell.onTapThird = { [weak self] in
            self?.selectCoinTopRank(index: 2)
        }
        return cell
    }

    func getCoinViewCell(indexPath: IndexPath) -> UITableViewCell {
        if coinListDisplay.count > indexPath.row {
            let data = coinListDisplay[indexPath.row]
            if data.isForAdv {
                // MARK: Bind Adv Invite
                let cell = tableView.dequeueReusableCell(withIdentifier: "InviteViewCell", for: indexPath) as! InviteViewCell
                return cell
            } else {
                // MARK: Bind CoinViewCell
                let cell = tableView.dequeueReusableCell(withIdentifier: "CoinViewCell", for: indexPath) as! CoinViewCell
                cell.bindData(iconImageString: data.iconImageUrlString,
                              name: data.name,
                              symbol: data.symbol,
                              price: data.price,
                              changeImage: data.change == .up
                                            ? UIImage(named: "arrow_up")
                                            : UIImage(named: "arrow_down"),
                              change: data.changeRate,
                              changeColor: data.change == .up
                                            ? UIColor(named: "forceGreenColor")
                                            : UIColor(named: "forceRedColor"))
                return cell
            }
        } else if interactor?.isLoadFail ?? false {
            // MARK: Bind LoadFailViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadFailViewCell", for: indexPath) as! LoadFailViewCell
            cell.tryAgain = { [weak self] in
                self?.getCoinList()
            }
            return cell
        } else {
            // MARK: Bind LoadingViewCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingViewCell", for: indexPath) as! LoadingViewCell
            return cell
        }
    }

    func getCoinTopRankHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        headerView.backgroundColor = UIColor.white

        let label = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.width - 30, height: 20))
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)

        let labelText = "Top 3 rank crypto"
        let attributedString = NSMutableAttributedString(string: labelText)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .regular),
                                      range: NSRange(location: 4, length: 1))
        attributedString.addAttribute(.foregroundColor, value: UIColor.red,
                                      range: NSRange(location: 4, length: 1))
        label.attributedText = attributedString
        headerView.addSubview(label)

        return headerView
    }

    func getCoinHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        headerView.backgroundColor = UIColor.white

        let label = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.width - 30, height: 20))
        label.text = "Buy, sell and hold crypto"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        headerView.addSubview(label)

        return headerView
    }
}
