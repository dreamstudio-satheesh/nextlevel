-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 03, 2024 at 11:45 AM
-- Server version: 8.0.40-0ubuntu0.22.04.1
-- PHP Version: 8.1.2-1ubuntu2.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `empty_flixy`
--

-- --------------------------------------------------------

--
-- Table structure for table `actors`
--

CREATE TABLE `actors` (
  `id` int NOT NULL,
  `fullname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `bio` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `profile_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_user`
--

CREATE TABLE `admin_user` (
  `id` int NOT NULL,
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_type` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_user`
--

INSERT INTO `admin_user` (`id`, `user_name`, `user_password`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin123', 1, '2024-01-08 07:58:21', '2024-06-06 07:29:02'),
(3, 'tester', 'tester@123', 0, '2024-01-08 07:58:21', '2024-01-08 07:58:21');

-- --------------------------------------------------------

--
-- Table structure for table `admob`
--

CREATE TABLE `admob` (
  `id` int NOT NULL,
  `banner_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `intersial_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `rewarded_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admob`
--

INSERT INTO `admob` (`id`, `banner_id`, `intersial_id`, `rewarded_id`, `type`, `created_at`, `updated_at`) VALUES
(1, 'banner_id', 'intersial_id', 'rewarded_id', 1, '2023-11-08 15:00:45', '2024-07-29 01:27:43'),
(2, 'banner_id', 'intersial_id', 'rewarded_id', 2, '2023-11-08 15:00:45', '2024-07-24 02:37:20');

-- --------------------------------------------------------

--
-- Table structure for table `contents`
--

CREATE TABLE `contents` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT '1 = movie / 2 = series',
  `duration` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `release_year` int NOT NULL,
  `ratings` float NOT NULL DEFAULT '0',
  `language_id` int NOT NULL,
  `trailer_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `vertical_poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `horizontal_poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `genre_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = unfeatured / 1 = featured',
  `is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0 = Hide content / 1 = Show Content',
  `total_view` int NOT NULL DEFAULT '0',
  `total_download` int NOT NULL DEFAULT '0',
  `total_share` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content_cast`
--

CREATE TABLE `content_cast` (
  `id` int NOT NULL,
  `content_id` bigint NOT NULL,
  `actor_id` int NOT NULL,
  `character_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `content_sources`
--

CREATE TABLE `content_sources` (
  `id` int NOT NULL,
  `content_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quality` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `size` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_download` int NOT NULL DEFAULT '0' COMMENT '0 = no/ 1 = yes',
  `access_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Free / 2 = Paid/ 3 = Unlock With Video Ads',
  `type` int NOT NULL DEFAULT '0' COMMENT '1 for Youtube URL, 2 for M3u8 Url, 3 for Mov Url, 4 for Mp4 Url, 5 for Mkv Url, 6 for Webm Url, 7 for File Upload (Mp4, Mov, Mp4, Mkv, Webm)',
  `source` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_ads`
--

CREATE TABLE `custom_ads` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `brand_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `brand_logo` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `button_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_android` int DEFAULT NULL COMMENT '1=yes 0=no',
  `android_link` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_ios` tinyint(1) DEFAULT NULL COMMENT '1=yes 0=no',
  `ios_link` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=off 1=on',
  `views` int NOT NULL DEFAULT '0',
  `clicks` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_ad_sources`
--

CREATE TABLE `custom_ad_sources` (
  `id` int NOT NULL,
  `custom_ad_id` int NOT NULL,
  `type` int NOT NULL DEFAULT '0' COMMENT '0 = Image / 1 = Video',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `headline` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `show_time` int DEFAULT NULL,
  `is_skippable` int DEFAULT NULL COMMENT '0 = Must Watch / 1 = Skippable',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `episodes`
--

CREATE TABLE `episodes` (
  `id` int NOT NULL,
  `season_id` bigint NOT NULL,
  `number` int NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `duration` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `total_view` int DEFAULT '0',
  `total_download` int NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `episode_sources`
--

CREATE TABLE `episode_sources` (
  `id` int NOT NULL,
  `episode_id` int NOT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `size` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_download` int NOT NULL DEFAULT '0' COMMENT '0 = no / 1 = yes',
  `access_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Free/ 2 = Paid / 3 = Unlock With Video Ads',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '1 for Youtube URL, 2 for M3u8 Url, 3 for Mov Url, 4 for Mp4 Url, 5 for Mkv Url, 6 for Webm Url, 7 for File Upload (Mp4, Mov, Mp4, Mkv, Webm)',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `episode_subtitles`
--

CREATE TABLE `episode_subtitles` (
  `id` int NOT NULL,
  `episode_id` int NOT NULL,
  `language_id` int NOT NULL,
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `genres`
--

CREATE TABLE `genres` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `global_settings`
--

CREATE TABLE `global_settings` (
  `id` int NOT NULL,
  `app_name` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_live_tv_enable` tinyint(1) NOT NULL,
  `is_admob_android` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=on 0=off',
  `is_admob_ios` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=on 0=off',
  `is_custom_android` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=on 0=off',
  `is_custom_ios` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=on 0=off',
  `videoad_skip_time` int NOT NULL DEFAULT '8',
  `storage_type` int NOT NULL DEFAULT '0' COMMENT '0 = Local / 1 = AWS S3 / 2 = DigitaoOcean Space',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `global_settings`
--

INSERT INTO `global_settings` (`id`, `app_name`, `is_live_tv_enable`, `is_admob_android`, `is_admob_ios`, `is_custom_android`, `is_custom_ios`, `videoad_skip_time`, `storage_type`, `created_at`, `updated_at`) VALUES
(1, 'Flixy', 1, 0, 0, 1, 1, 4, 0, '2021-08-20 09:39:49', '2024-07-30 05:12:15');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_gallery`
--

CREATE TABLE `media_gallery` (
  `id` int NOT NULL,
  `title` varchar(55) COLLATE utf8mb4_general_ci NOT NULL,
  `file` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(6, '2016_06_01_000004_create_oauth_clients_table', 1),
(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(8, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `seasons`
--

CREATE TABLE `seasons` (
  `id` int NOT NULL,
  `content_id` bigint NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `trailer_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subtitles`
--

CREATE TABLE `subtitles` (
  `id` int NOT NULL,
  `content_id` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_id` int NOT NULL,
  `file` varchar(555) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pages`
--

CREATE TABLE `tbl_pages` (
  `id` int NOT NULL,
  `privacy` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `termsofuse` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_pages`
--

INSERT INTO `tbl_pages` (`id`, `privacy`, `termsofuse`, `created_at`, `updated_at`) VALUES
(1, '<p><span style=\"background-color: rgb(0, 0, 0); --darkreader-inline-bgcolor: #000000;\" data-darkreader-inline-bgcolor=\"\">11 Welcome to the Terms of Use for the application. By using the&nbsp;application, you agree to be bound by these terms and conditions. Please read them carefully before using the application.</span></p><p>License Grant:</p><p>The&nbsp;application grants you a limited, non-exclusive, non-transferable, revocable license to use the application for your personal or commercial purposes.</p><p><br></p><p>User Conduct:</p><p>You agree to use the&nbsp;application for lawful purposes only and not to engage in any conduct that may impair or disrupt the functioning of the application. You agree not to use the application to upload or distribute any content that is illegal, harmful, threatening, abusive, harassing, defamatory, obscene, vulgar, or offensive.</p><p><br></p><p>User Accounts:</p><p>You may need to create an account to use certain features of the&nbsp;application. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.</p><p><br></p><p>Intellectual Property:</p><p>The&nbsp;application and all of its content, including but not limited to text, graphics, logos, images, and software, are the property of the application owner and are protected by copyright and other intellectual property laws. You may not use or reproduce any of the content without the prior written consent of the application owner.</p><p><br></p><p>Disclaimers:</p><p>The&nbsp;application is provided on an \"as is\" and \"as available\" basis. The application owner makes no warranties, express or implied, regarding the application\'s reliability, accuracy, or availability.</p><p><br></p><p>Limitation of Liability:</p><p>In no event shall the application owner be liable for any damages arising out of the use or inability to use the&nbsp;application, including but not limited to direct, indirect, incidental, special, or consequential damages.</p><p><br></p><p>Indemnification:</p><p>You agree to indemnify and hold the application owner harmless from any claims, damages, losses, or expenses arising out of your use of the&nbsp;application, your violation of these terms and conditions, or your violation of any rights of another person or entity.</p><p><br></p><p>Termination:</p><p>The application owner may terminate your access to the&nbsp;application at any time and for any reason without notice.</p><p><br></p><p>Governing Law:</p><p>These terms and conditions shall be governed by and construed in accordance with the laws of the jurisdiction where the application owner is located.</p><p><br></p><p>Changes to Terms and Conditions:</p><p>The application owner reserves the right to modify these terms and conditions at any time without notice. Your continued use of the&nbsp;application following any such modifications constitutes your agreement to be bound by the revised terms and conditions.</p><p><br></p><h3>By using the&nbsp;application, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.</h3>', '<p>Terms &amp; Conditions</p><p>Welcome to Flixy, an OTT platform offering movies, series, live TV, and much more. By using our services, you agree to the following terms and conditions.</p><h5>1. Acceptance of Terms</h5><p>By accessing and using Flixy, you accept and agree to be bound by these terms. If you do not agree with any part of these terms, you must not use our services.</p><p>2. Changes to Terms</p><p>We reserve the right to modify these terms at any time. We will notify you of any changes by posting the new terms on our platform. Your continued use of Flixy after the changes are posted constitutes your acceptance of the new terms.</p><p>3. User Accounts</p><p>To access certain features of Flixy, you may need to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.</p><p>4. Content</p><p>Flixy provides a platform for streaming movies, series, live TV, and other content. The content is provided for your personal, non-commercial use only. You may not copy, reproduce, distribute, or create derivative works from any content obtained from Flixy without our prior written consent.</p><p>5. Subscription and Billing</p><p>Access to certain content on Flixy may require a subscription. Subscription fees are billed in advance and are non-refundable. We reserve the right to change our subscription plans and pricing at any time.</p><p>6. Termination</p><p>We reserve the right to terminate or suspend your account and access to Flixy at our discretion, without notice, for conduct that we believe violates these terms or is harmful to other users of Flixy, us, or third parties, or for any other reason.</p><p>7. Disclaimer of Warranties</p><p>Flixy is provided \"as is\" and \"as available\" without warranties of any kind, either express or implied. We do not warrant that Flixy will be uninterrupted or error-free.</p><p>8. Limitation of Liability</p><p>In no event shall Flixy, its affiliates, or its licensors be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of or inability to use Flixy.</p><p>9. Governing Law</p><p>These terms shall be governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.</p><p>10. Contact Us</p><p>If you have any questions about these terms, please contact us at [Your Contact Information].</p>', '2023-03-22 10:37:41', '2024-06-19 06:24:48');

-- --------------------------------------------------------

--
-- Table structure for table `top_contents`
--

CREATE TABLE `top_contents` (
  `id` int NOT NULL,
  `content_index` int NOT NULL,
  `content_id` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tv_categories`
--

CREATE TABLE `tv_categories` (
  `id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tv_channels`
--

CREATE TABLE `tv_channels` (
  `id` int NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Free / 2 = Paid / 3 = Unlock With Video Ads',
  `category_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '1 = Youtube URL, 2 = M3u8 Url',
  `source` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(55) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login_type` tinyint(1) DEFAULT '0' COMMENT '1 = Google / 2 = Apple / 3 = Email',
  `identity` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `profile_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `watchlist_content_ids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `device_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 = Andriod, 1 = iOS',
  `device_token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `actors`
--
ALTER TABLE `actors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_user`
--
ALTER TABLE `admin_user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admob`
--
ALTER TABLE `admob`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contents`
--
ALTER TABLE `contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `content_cast`
--
ALTER TABLE `content_cast`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `content_sources`
--
ALTER TABLE `content_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_ads`
--
ALTER TABLE `custom_ads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_ad_sources`
--
ALTER TABLE `custom_ad_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `episodes`
--
ALTER TABLE `episodes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `episode_sources`
--
ALTER TABLE `episode_sources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `episode_subtitles`
--
ALTER TABLE `episode_subtitles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genres`
--
ALTER TABLE `genres`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `global_settings`
--
ALTER TABLE `global_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media_gallery`
--
ALTER TABLE `media_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `seasons`
--
ALTER TABLE `seasons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subtitles`
--
ALTER TABLE `subtitles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pages`
--
ALTER TABLE `tbl_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `top_contents`
--
ALTER TABLE `top_contents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tv_categories`
--
ALTER TABLE `tv_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tv_channels`
--
ALTER TABLE `tv_channels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `actors`
--
ALTER TABLE `actors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_user`
--
ALTER TABLE `admin_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admob`
--
ALTER TABLE `admob`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `contents`
--
ALTER TABLE `contents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content_cast`
--
ALTER TABLE `content_cast`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `content_sources`
--
ALTER TABLE `content_sources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_ads`
--
ALTER TABLE `custom_ads`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_ad_sources`
--
ALTER TABLE `custom_ad_sources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `episodes`
--
ALTER TABLE `episodes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `episode_sources`
--
ALTER TABLE `episode_sources`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `episode_subtitles`
--
ALTER TABLE `episode_subtitles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `genres`
--
ALTER TABLE `genres`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `global_settings`
--
ALTER TABLE `global_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `media_gallery`
--
ALTER TABLE `media_gallery`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `seasons`
--
ALTER TABLE `seasons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subtitles`
--
ALTER TABLE `subtitles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_pages`
--
ALTER TABLE `tbl_pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `top_contents`
--
ALTER TABLE `top_contents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tv_categories`
--
ALTER TABLE `tv_categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tv_channels`
--
ALTER TABLE `tv_channels`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
