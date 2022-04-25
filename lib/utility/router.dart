import 'package:get/get.dart';
import 'package:sislam_car/view/about_us_view.dart';
import 'package:sislam_car/view/blog_view.dart';
import 'package:sislam_car/view/book_now_view.dart';
import 'package:sislam_car/view/buy/buy_cars_view.dart';
import 'package:sislam_car/view/car_details_view.dart';
import 'package:sislam_car/view/contact_us_view.dart';
import 'package:sislam_car/view/exchange/exchange_car_details_view.dart';
import 'package:sislam_car/view/exchange/exchange_cars_view.dart';
import 'package:sislam_car/view/exchange/exchange_search_view.dart';
import 'package:sislam_car/view/exchange/exchange_submit_view.dart';
import 'package:sislam_car/view/help_center_view.dart';

import 'package:sislam_car/view/home_view.dart';
import 'package:sislam_car/view/inbox_view.dart';
import 'package:sislam_car/view/search_view.dart';
import 'package:sislam_car/view/sell/sell_submit_view.dart';
import 'package:sislam_car/view/splash_view.dart';
import 'package:sislam_car/view/watch_channel_view.dart';

class RouterRoute {
  static final route = [
    GetPage(
      name: '/splashView',
      page: () => const SplashView(),
    ),
    GetPage(
      name: '/homeView',
      page: () => const HomeView(),
    ),
    GetPage(
        name: '/carDetailsView',
        page: () => const CarDetailsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/bookNowView',
        page: () => const BookNowView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/sellSubmitView',
        page: () => const SellSubmitView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/buyCarsView',
        page: () => const BuyCarsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/exchangeCarsView',
        page: () => const ExchangeCarsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/exchangeCarDetailsView',
        page: () => const ExchangeCarDetailsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/exchangeSubmitView',
        page: () => const ExchangeSubmitView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/inboxView',
        page: () => const InboxView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/watchChannelView',
        page: () => const WatchChannelView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/contactUsView',
        page: () => const ContactUsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/aboutUsView',
        page: () => const AboutUsView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/blogView',
        page: () => const BlogView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/searchView',
        page: () => const SearchView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/exchangeSearchView',
        page: () => const ExchangeSearchView(),
        transition: Transition.circularReveal),
    GetPage(
        name: '/helpCenterView',
        page: () => const HelpCenterView(),
        transition: Transition.circularReveal),
  ];
}
