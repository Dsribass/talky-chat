import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'module_localizations_en.dart';
import 'module_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of ModuleLocalizations
/// returned by `ModuleLocalizations.of(context)`.
///
/// Applications need to include `ModuleLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/module_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: ModuleLocalizations.localizationsDelegates,
///   supportedLocales: ModuleLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the ModuleLocalizations.supportedLocales
/// property.
abstract class ModuleLocalizations {
  ModuleLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static ModuleLocalizations of(BuildContext context) {
    return Localizations.of<ModuleLocalizations>(context, ModuleLocalizations)!;
  }

  static const LocalizationsDelegate<ModuleLocalizations> delegate = _ModuleLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @chatListPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Conversations'**
  String get chatListPageTitle;

  /// No description provided for @chatListPageDeleteChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete chat'**
  String get chatListPageDeleteChatTitle;

  /// No description provided for @chatListPageDeleteChatContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this chat?'**
  String get chatListPageDeleteChatContent;

  /// No description provided for @chatListPageDeleteChatCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get chatListPageDeleteChatCancel;

  /// No description provided for @chatListPageDeleteChatDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get chatListPageDeleteChatDelete;
}

class _ModuleLocalizationsDelegate extends LocalizationsDelegate<ModuleLocalizations> {
  const _ModuleLocalizationsDelegate();

  @override
  Future<ModuleLocalizations> load(Locale locale) {
    return SynchronousFuture<ModuleLocalizations>(lookupModuleLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_ModuleLocalizationsDelegate old) => false;
}

ModuleLocalizations lookupModuleLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return ModuleLocalizationsEn();
    case 'pt': return ModuleLocalizationsPt();
  }

  throw FlutterError(
    'ModuleLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
