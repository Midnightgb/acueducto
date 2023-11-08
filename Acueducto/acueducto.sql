-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-11-2023 a las 12:52:44
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `acueducto`
--
CREATE DATABASE IF NOT EXISTS `acueducto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `acueducto`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_variables`
--

CREATE TABLE `datos_variables` (
  `id_empresa` int(10) UNSIGNED NOT NULL,
  `id_variable` int(10) UNSIGNED NOT NULL,
  `respuesta` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documentos`
--

CREATE TABLE `documentos` (
  `id_doc` int(11) NOT NULL,
  `id_usuario` char(30) DEFAULT NULL,
  `nom_doc` varchar(80) DEFAULT NULL,
  `id_servicio` int(10) UNSIGNED DEFAULT NULL,
  `tipo` enum('pdf','docx','xlsx') DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `url` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `documentos`
--

INSERT INTO `documentos` (`id_doc`, `id_usuario`, `nom_doc`, `id_servicio`, `tipo`, `create_at`, `update_at`, `url`) VALUES
(118, 'Ldk1mrcr2204gx2x9SeM5jv5DdHa1K', 'P01-F-03_Estatutos_Asociación_Suscriptores12345678', 1, 'pdf', '2023-10-26 15:56:01', '2023-10-26 15:56:01', 'ArchivosDescarga/Generados/P01-F-03_Estatutos_Asociación_Suscriptores12345678.pdf'),
(119, 'Ldk1mrcr2204gx2x9SeM5jv5DdHa1K', 'P01-F-02_Formato_Contrato_Condiciones_Uniformes12345678', 2, 'pdf', '2023-10-26 15:56:09', '2023-10-26 15:56:09', 'ArchivosDescarga/Generados/P01-F-02_Formato_Contrato_Condiciones_Uniformes12345678.pdf'),
(120, 'Ldk1mrcr2204gx2x9SeM5jv5DdHa1K', 'P01-F-06_ActaConstitución12345678', 3, 'pdf', '2023-10-26 15:56:14', '2023-10-26 15:56:14', 'ArchivosDescarga/Generados/P01-F-06_ActaConstitución12345678.pdf'),
(124, 'zrfGXKmHGTSK6DRnu65LWXdEP8wZSR', 'P01-F-03_Estatutos_Asociación_Suscriptores101', 1, 'pdf', '2023-10-31 22:11:32', '2023-10-31 22:11:32', 'ArchivosDescarga/Generados/P01-F-03_Estatutos_Asociación_Suscriptores101.pdf'),
(125, 'zrfGXKmHGTSK6DRnu65LWXdEP8wZSR', 'P01-F-02_Formato_Contrato_Condiciones_Uniformes101', 2, 'pdf', '2023-10-31 22:11:39', '2023-10-31 22:11:39', 'ArchivosDescarga/Generados/P01-F-02_Formato_Contrato_Condiciones_Uniformes101.pdf'),
(126, 'zrfGXKmHGTSK6DRnu65LWXdEP8wZSR', 'P01-F-06_ActaConstitución101', 3, 'pdf', '2023-10-31 22:11:40', '2023-10-31 22:11:40', 'ArchivosDescarga/Generados/P01-F-06_ActaConstitución101.pdf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(10) UNSIGNED NOT NULL,
  `nom_empresa` varchar(50) DEFAULT NULL,
  `direccion_empresa` varchar(100) DEFAULT NULL,
  `tel_fijo` char(10) DEFAULT NULL,
  `tel_cel` char(10) DEFAULT NULL,
  `email` varchar(90) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `nom_empresa`, `direccion_empresa`, `tel_fijo`, `tel_cel`, `email`, `estado`, `create_at`, `update_at`) VALUES
(1, 'Empresa Prueba', 'Centro', '3201234567', '3201234567', 'empresa@gmail.com', 'Activo', '2023-09-16 00:09:33', '2023-10-26 15:41:16'),
(2, 'Emprese Adso', 'Carrera 8va calle 26', '3322889900', '3322889900', 'empresaAdso@gmail.com', 'Inactivo', '2023-09-17 00:12:18', '2023-10-31 17:48:12'),
(34, 'Apple', '123 Apple St, Cupertino, CA', '1234567890', '1234567890', 'info@apple.com', 'Activo', '2023-09-27 01:22:18', '2023-10-24 22:43:10'),
(35, 'Microsoft', '456 Microsoft Ave, Redmond, WA', '9876543210', '1234567890', 'info@microsoft.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(36, 'Google', '789 Google Blvd, Mountain View, CA', '5551234567', '5559876543', 'info@google.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(37, 'Amazon', '101 Amazon Dr, Seattle, WA', '121221221', '121221221', 'info@amazon.com', 'Activo', '2023-09-27 01:22:18', '2023-10-19 08:22:20'),
(38, 'Facebook', '246 Facebook Ln, Menlo Park, CA', '4445556666', '8889990000', 'info@facebook.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(39, 'Samsung', '321 Samsung Rd, Seoul, South Korea', '1110001111', '2220002222', 'info@samsung.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(40, 'Intel', '654 Intel Blvd, Santa Clara, CA', '3334445555', '6667778888', 'info@intel.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(41, 'AWS', '789 Adobe Ave, San Jose, CA', '22233344', '2223334444', 'info@adobe.com', 'Activo', '2023-09-27 01:22:18', '2023-10-30 21:52:42'),
(42, 'Sony', '789 Sony Ave, Tokyo, Japan', '1112223333', '4445556666', 'info@sony.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(43, 'HP', '456 HP Rd, Palo Alto, CA', '7778889999', '1112223333', 'info@hp.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(44, 'Dell', '123 Dell Ln, Round Rock, TX', '5556667777', '8889990000', 'info@dell.com', 'Inactivo', '2023-09-27 01:22:57', '2023-09-27 01:27:30'),
(45, 'IBM', '789 IBM Dr, Armonk, NY', '3334445555', '6667778888', 'info@ibm.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(46, 'Oracle', '101 Oracle Ave, Redwood City, CA', '1234567890', '9876543210', 'info@oracle.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(47, 'Cisco', '246 Cisco Rd, San Jose, CA', '2223334444', '2223334444', 'info@cisco.com', 'Inactivo', '2023-09-27 01:22:57', '2023-10-26 15:16:00'),
(48, 'Tesla', '789 Tesla Blvd, Palo Alto, CA', '5556667777', '1112223333', 'info@tesla.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(49, 'NVIDIA', '654 NVIDIA Ln, Santa Clara, CA', '7778889999', '4445556666', 'info@nvidia.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(50, 'Netflix', '123 Netflix Ave, Los Gatos, CA', '1112223333', '8889990000', 'info@netflix.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(51, 'Uber', '456 Uber Blvd, San Francisco, CA', '3334445555', '7778889999', 'info@uber.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(52, 'Spotify', '101 Spotify Ln, Stockholm, Sweden', '5556667777', '8889990000', 'info@spotify.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(53, 'Airbnb', '246 Airbnb Rd, San Francisco, CA', '1234567890', '1234567890', 'info@airbnb.com', 'Activo', '2023-09-27 01:22:57', '2023-09-28 04:49:49'),
(54, 'Snap Inc.', '789 Snap Ave, Santa Monica, CA', '2223334444', '5556667777', 'info@snap.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(55, 'PayPal', '654 PayPal Dr, San Jose, CA', '4445556666', '7778889999', 'info@paypal.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(56, 'Adobe', '321 Adobe Blvd, San Jose, CA', '5556667777', '5556667777', 'info@adobe.com', 'Activo', '2023-09-27 01:22:57', '2023-09-29 02:23:16'),
(57, 'Qualcomm', '987 Qualcomm Ave, San Diego, CA', '1234567890', '4445556666', 'info@qualcomm.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(58, 'SpaceX', '456 SpaceX Rd, Hawthorne, CA', '9876543210', '2223334444', 'info@spacex.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(59, 'Zoom Video', '101 Zoom Ln, San Jose, CA', '5556667777', '1234567890', 'info@zoom.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(60, 'Pinterest', '789 Pinterest Ave, San Francisco, CA', '3334445555', '9876543210', 'info@pinterest.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(61, 'Reddit', '246 Reddit Rd, San Francisco, CA', '4445556666', '5556667777', 'info@reddit.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(63, 'q-vision', 'q-vision cr18', '3000444', '3054548778', 'qvison@mail.com', 'Activo', '2023-09-29 00:57:49', '2023-09-29 00:57:49'),
(64, 'labesAcum', 'calle 21 cerrritos ', '312456789', '23453', 'labes@hotmail.com', 'Activo', '2023-09-29 02:24:08', '2023-09-29 02:24:08'),
(65, 'Vergaras', 'calle 22 cerrritos ', '312456789', '23453', 'Vergaras@hotmail.com', 'Activo', '2023-09-29 02:42:07', '2023-09-29 02:42:07'),
(66, 'Acuamelon', 'Acua roomero valle', '3457664', '3457664', 'acuamarina@gmail.com', 'Activo', '2023-09-29 02:47:39', '2023-09-29 19:09:57'),
(67, 'dominio', 'dominio roomero valle', '78575874', '74784', 'dominio@gmail.com', 'Activo', '2023-09-29 02:52:32', '2023-09-29 02:52:32'),
(68, 'ceras', 'dominio roomero valle', '78575874', '74784', 'ceras@gmail.com', 'Activo', '2023-09-29 02:56:18', '2023-09-29 02:56:18'),
(69, 'ceraspecas', 'dominio roomero valle', '78575874', '74784', 'ceraspwcas@gmail.com', 'Activo', '2023-09-29 02:56:41', '2023-09-29 02:56:41'),
(80, 'Aguas de pereira', 'Transversal 3 #5A51', '3022592002', '234234234', 'papaniel2145@gmail.com', 'Activo', '2023-09-29 04:31:20', '2023-09-29 04:31:20'),
(81, 'asdfsdf', 'Transversal 3 #5A51', '3022592002', '234234', 'papaniel214aaaa5@gmail.com', 'Activo', '2023-09-29 04:34:25', '2023-09-29 04:34:25'),
(82, 'otraempresa222', 'Transversal 3 #5A51', '3022592002', '3022592002', 'papaniel2sss145@gmail.com', 'Activo', '2023-09-29 04:34:55', '2023-09-29 18:32:15'),
(83, 'Logitech', 'San Andresito', '12212', '323', 'logitech@mail.com', 'Activo', '2023-09-29 18:00:44', '2023-09-29 18:00:44'),
(84, 'Lg', 'Avenida Zur', '2121', '232', 'lg@mial.com', 'Activo', '2023-09-29 18:10:07', '2023-09-29 18:10:07'),
(85, 'ASUS', 'asobhb', '1212', '2122323', 'asus@gmail.com', 'Activo', '2023-09-29 18:11:28', '2023-09-29 18:11:28'),
(86, 'a', 'a', 'a', 'a', 'papaniel2145212@gmail.com', 'Activo', '2023-10-01 19:52:16', '2023-10-01 19:52:16'),
(87, 'DAMAEZ AGUA ', 'damaez sin agua ', '3125647', '78367653', 'damaez@gamil.com', 'Activo', '2023-10-19 00:52:08', '2023-10-19 00:52:08'),
(88, 'Ubisoft', 'Silicon Valley', '3230045', '232004567', 'ubisoft@gmail.com', 'Activo', '2023-10-19 05:06:37', '2023-10-19 05:06:37'),
(89, 'OnlyFans', 'chupelupe', '123123231', '12312312', 'only@gmail.com', 'Activo', '2023-10-19 05:22:34', '2023-10-19 05:22:34'),
(90, 'adso', 'adso', '3333', '3333', 'adso@gmail.com', 'Activo', '2023-10-22 19:22:35', '2023-10-22 19:22:35'),
(91, 'Acueducto Prueba Correo', 'Centro', '3201234567', '3201234567', 'acu@gmail.com', 'Activo', '2023-10-23 20:46:55', '2023-10-23 20:46:55'),
(92, 'ACUASEO', 'Dosquebradas', '32012345', '3201234567', 'acuaseo@gmail.com', 'Activo', '2023-10-23 21:36:28', '2023-10-23 21:36:28'),
(93, 'la rama', 'dsa', '32131', '321312', 'julianvaskes12@hotmail.com', 'Activo', '2023-10-25 22:57:41', '2023-10-25 22:57:41'),
(94, 'Aguas Pereira ', 'calle 21 mz 26 cs 26', '3127678030', '536353', 'Pereira@gamil.com', 'Activo', '2023-10-27 22:25:57', '2023-10-27 22:25:57'),
(95, 'Adobe aaaaaa', 'q-vision cr18', '3000444', '3054548778', 'manolo@mail.com', 'Activo', '2023-10-30 23:01:01', '2023-10-30 23:01:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmuebles_suscritor`
--

CREATE TABLE `inmuebles_suscritor` (
  `id_inmueble` int(10) UNSIGNED NOT NULL,
  `id_usuario` char(30) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `estrato` enum('1','2','3','4','5','6') DEFAULT NULL,
  `uso` enum('Doméstico','Industrial','Institucional','Comercial','Agropecuario') DEFAULT NULL,
  `numero_residentes` int(10) UNSIGNED DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inmuebles_suscritor`
--

INSERT INTO `inmuebles_suscritor` (`id_inmueble`, `id_usuario`, `direccion`, `estrato`, `uso`, `numero_residentes`, `create_at`, `update_at`) VALUES
(3, 'ek1t2Ga9jAKnwthvl2fFPQ3WqnVFiZ', 'Transversal 3 #5A51', '1', 'Doméstico', 2, '2023-10-04 02:49:09', '2023-10-04 02:49:09'),
(32, 'Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Transversal 3 #5A51', '1', 'Doméstico', 1, '2023-10-04 04:37:36', '2023-10-04 07:41:06'),
(33, 'Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Mirador jajaj', '3', 'Doméstico', 1, '2023-10-04 04:41:52', '2023-10-25 16:10:51'),
(67, 'XU8z2R0foWHrVQDg8pY28aaNwtZnRs', 'charli mks', '1', 'Doméstico', 1, '2023-10-04 07:43:54', '2023-10-04 07:47:50'),
(68, 'ez0TpDirNOaeHPuzqG1b8FK2jQmxpL', 'casa de diegueline', '4', 'Doméstico', 0, '2023-10-04 07:59:02', '2023-10-26 15:18:37'),
(70, '2Jb9V1A65wluc086jWwWbmEu8KgiQD', 'casa de charli', '1', 'Industrial', 0, '2023-10-04 09:58:15', '2023-10-19 05:25:50'),
(73, 'vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'via armenia', '1', 'Doméstico', 4, '2023-10-04 09:59:53', '2023-10-04 09:59:53'),
(74, 'vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'dasd', '1', 'Doméstico', 5, '2023-10-04 10:01:39', '2023-10-04 10:01:39'),
(75, 'qioeH01FqLon0p0iLdFEO0vXIa07EY', 'casa sena', '4', 'Doméstico', 4, '2023-10-12 14:37:28', '2023-10-12 14:37:28'),
(76, 'qioeH01FqLon0p0iLdFEO0vXIa07EY', 'casa adso', '4', 'Doméstico', 3, '2023-10-12 14:42:04', '2023-10-25 16:01:29'),
(77, 'glr6EEGdQemCloeSlFHOmAXj5DTgE9', 'casa adso', '4', 'Doméstico', 0, '2023-10-12 14:42:15', '2023-10-19 05:14:44'),
(78, 'F3biYMf5Tj9PDH3AhaHJLUxK7eye4d', 'via armenia', '5', 'Doméstico', 3, '2023-10-25 21:49:51', '2023-10-25 21:49:51'),
(79, NULL, 'via armenia', '5', 'Doméstico', 0, '2023-10-25 21:53:23', '2023-10-25 21:53:27'),
(80, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'dsadasda', '6', 'Agropecuario', 2147483647, '2023-10-25 21:53:58', '2023-10-28 02:04:43'),
(81, 'ek1t2Ga9jAKnwthvl2fFPQ3WqnVFiZ', 'Las brisas', '6', 'Doméstico', 3, '2023-10-26 15:13:59', '2023-10-26 15:13:59'),
(82, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'rrtyg', '4', 'Industrial', 34, '2023-10-28 00:17:40', '2023-10-28 00:17:40'),
(83, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'rrtyg', '4', 'Industrial', 34, '2023-10-28 00:20:02', '2023-10-28 00:20:02'),
(84, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'rrtyg', '4', 'Industrial', 340, '2023-10-28 00:20:28', '2023-10-28 03:01:55'),
(85, NULL, 'rrtygg', '3', 'Doméstico', 0, '2023-10-28 00:20:40', '2023-10-31 17:49:01'),
(86, NULL, 'rrtyg', '4', 'Industrial', 0, '2023-10-28 00:20:55', '2023-10-28 00:21:13'),
(87, NULL, 'rrtyg', '4', 'Industrial', 0, '2023-10-28 00:21:03', '2023-10-28 00:21:09'),
(88, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '3', 'Doméstico', 4, '2023-10-28 00:37:36', '2023-10-31 17:49:35'),
(89, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '2', 'Industrial', 4, '2023-10-28 00:57:50', '2023-10-28 00:57:50'),
(90, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '2', 'Industrial', 4, '2023-10-28 00:59:41', '2023-10-28 00:59:41'),
(91, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '4', 'Doméstico', 4, '2023-10-28 01:04:59', '2023-10-28 01:12:00'),
(92, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'dsa', '1', 'Doméstico', 3124, '2023-10-28 01:08:06', '2023-10-28 01:08:06'),
(93, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '4', 'Doméstico', 455667, '2023-10-28 01:09:17', '2023-10-28 01:09:17'),
(94, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '4', 'Doméstico', 455667, '2023-10-28 01:10:13', '2023-10-28 01:10:13'),
(95, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '4', 'Doméstico', 455667, '2023-10-28 01:10:27', '2023-10-28 01:10:27'),
(96, 'MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'hola', '4', 'Doméstico', 455667, '2023-10-28 01:12:10', '2023-10-28 01:12:10'),
(97, 'JT5g1gR66RjpCmXjZvflLkuybu8u3k', 'via armenia', '1', 'Doméstico', 3, '2023-10-30 21:44:00', '2023-10-30 21:44:00'),
(98, 'JT5g1gR66RjpCmXjZvflLkuybu8u3k', 'via armenia dsada', '2', 'Institucional', 5, '2023-10-30 21:44:14', '2023-10-30 22:04:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_asistencia`
--

CREATE TABLE `lista_asistencia` (
  `id_asistencia` int(10) UNSIGNED NOT NULL,
  `id_usuario` char(30) DEFAULT NULL,
  `id_reunion` int(10) UNSIGNED DEFAULT NULL,
  `asistencia` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `lista_asistencia`
--

INSERT INTO `lista_asistencia` (`id_asistencia`, `id_usuario`, `id_reunion`, `asistencia`) VALUES
(7, '524GkWjhM36hwC76sKBAYJQLlCmRUX', 128, 1),
(8, 'JT5g1gR66RjpCmXjZvflLkuybu8u3k', 128, 1),
(9, 'vyUkBOCPCao5GMHUmuBjYwNBvDzLcR', 128, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reuniones`
--

CREATE TABLE `reuniones` (
  `id_reunion` int(10) UNSIGNED NOT NULL,
  `id_empresa` int(10) UNSIGNED NOT NULL,
  `nom_reunion` varchar(120) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time NOT NULL,
  `lugar` varchar(255) DEFAULT NULL,
  `url_asistencia` varchar(200) DEFAULT NULL,
  `cuorum` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `reuniones`
--

INSERT INTO `reuniones` (`id_reunion`, `id_empresa`, `nom_reunion`, `fecha`, `hora`, `lugar`, `url_asistencia`, `cuorum`) VALUES
(87, 1, 'Prueba1', '2023-10-30', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(88, 1, 'Prueba2', '2023-11-05', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(89, 1, 'Prueba3', '2023-10-20', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(90, 1, 'Reunión4', '2023-10-28', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(91, 1, 'Reunión6', '2023-10-20', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(92, 1, 'Reunión7', '2023-10-26', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(93, 1, 'Reunión8', '2023-10-22', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(94, 1, 'Reunión con la JAC', '2023-10-27', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(95, 1, 'Reunión Prueba', '2023-10-25', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(96, 1, 'Nueva reunión', '2023-10-24', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(97, 1, 'Otra reunion', '2023-10-24', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(98, 1, 'Reunion Urgente', '2023-10-24', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(99, 1, 'Reunion Asamblea', '2023-10-24', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(100, 1, 'Mi reunion', '2023-10-31', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(101, 1, 'Reunión extraordinaria', '2023-10-27', '00:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(102, 1, 'Otra reunion más', '2023-10-27', '15:40:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(103, 1, 'Votación de representante', '2023-10-25', '12:00:00', NULL, 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(104, 1, 'Contitución de asamble', '2023-10-30', '14:00:00', 'Oficinas Centro', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(105, 1, 'Reunioncita', '2023-10-24', '07:00:00', 'Sena Centro', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(106, 1, 'Elección Representante', '2023-10-26', '11:00:00', 'Sena Sector Agropecuario', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(107, 91, 'hdgh', '2023-10-26', '04:05:00', 'dhdhf', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(108, 92, 'Reunión de Lideres', '2023-10-26', '17:40:00', 'Casa de Carlitos', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(109, 35, 'reunion microsoft', '2023-10-25', '11:00:00', 'Sena Comercio', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(110, 35, 'reunion senas', '2023-10-31', '16:10:00', 'sena coliseum', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(111, 35, 'discord', '2023-10-28', '15:30:00', 'Virtual', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(112, 35, 'reu', '2023-10-27', '13:00:00', 'aqui', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(113, 35, 'solosena', '2023-10-28', '13:01:00', 'Sena Comercio', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(114, 35, 'Reunion Discord 25/10', '2023-10-31', '23:40:00', 'Casa blanca', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(115, 35, 'Otra pa probar', '2023-10-26', '23:29:00', 'Sena calle 20', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(116, 35, 'Otra pa probarv1', '2023-11-01', '16:35:00', 'Sena calle 27', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(117, 35, 'dsadsad', '2023-10-27', '02:40:00', 'cerca', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(118, 35, 'Hola mundoo', '2023-10-30', '10:29:00', 'Allí', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(119, 35, 'maurio', '2023-10-28', '07:35:00', 'alla', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(120, 52, 'erick primera reunion', '2023-10-30', '07:39:00', 'sena', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(121, 52, 'el diavlo', '2023-10-31', '07:43:00', 'senita', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(122, 52, 'prueba erick', '2023-10-30', '07:46:00', 'auola', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(123, 35, '3212', '2023-10-27', '09:09:00', 'micasa', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(124, 35, 'vocero', '2023-10-20', '09:59:00', 'sena', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(125, 52, 'antes', '2023-10-31', '09:58:00', 'sena', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(126, 52, 'Asamblea', '2023-10-31', '15:00:00', 'Sena Centro', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(127, 91, 'dsadas', '0002-03-23', '03:21:00', 'fsdfdsf', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL),
(128, 35, 'POR LA NOCHE', '2023-10-31', '22:28:00', 'SENA galicia', 'public/dist/ArchivoDescarga/P01-F-05_Listado de asistencia.xlsx - Hoja1.pdf', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios`
--

CREATE TABLE `servicios` (
  `id_servicio` int(10) UNSIGNED NOT NULL,
  `nom_servicio` varchar(80) DEFAULT NULL,
  `paso` float(3,1) DEFAULT NULL,
  `modulo` tinyint(3) UNSIGNED DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `servicios`
--

INSERT INTO `servicios` (`id_servicio`, `nom_servicio`, `paso`, `modulo`, `create_at`, `update_at`) VALUES
(1, 'estatutos', 1.1, 1, '2023-10-18 15:04:43', '2023-10-25 16:17:05'),
(2, 'Contrato de condiciones Uniformes', 1.1, 1, '2023-10-25 16:18:55', '2023-10-25 16:18:55'),
(3, 'asamblea de constitucion', 1.1, 1, '2023-10-25 16:18:55', '2023-10-25 16:18:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tokens`
--

CREATE TABLE `tokens` (
  `id_token` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tokens`
--

INSERT INTO `tokens` (`id_token`, `token`) VALUES
(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNDk3NDF9.0Na8EoyyvQQ2IKNW8nfkAV5AjO4D354S5ZnQwp7jEbc'),
(6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNDk5NDV9.snoVr-P85i8H5seihreAYYm_uVDgYwmJJNyEI_bDvNg'),
(7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTAwMjl9.4p1XQKQ0PUNqVTWihPyoh0ioYR1c8kuIrlsNOsPRvIk'),
(8, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTAwODJ9.l0NeCDql_qBFDy4wUjrZ3bomGrL_bl3ne9SUDIRcPQw'),
(9, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTAxMzR9.BLU31tkWh_AKlfQzYLyfeDx94NKvXxO2VS_bLphWnxA'),
(18, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTM4Mzh9.Gjdj5iddFFAV8rbWjXYIZ2YEV6hh7htI-EOUAgQfn6M'),
(25, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTUwNDl9.iv1q9BLR2guNkhCOLYNc0Hid0GrdkBW-kjFv7j4SBJw'),
(27, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTgyNTU0NTF9.4IrtX3aqb9y6RtNSC3G6px6vqNWohe7uncOqBAeKr94'),
(36, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNTk1MjB9.bKrsWJACsHkJZfN4EVFKMiRRV1Wa-qSmetjlFLLU5pc'),
(44, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjE5OTl9.9nStbPQL6tRtEUgjCB10vYutE8paKhNHnxyz9Ga7kMk'),
(45, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjIxMzZ9.gBRN6Fsmf_SMKSxUiYqSVSw2wxU27pOVYfetBEhDEUI'),
(48, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjI5NTd9.jrKNnHKtAHtuMl98YSRkub9ua02FSthBlsVCkynJRws'),
(50, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjQwMDd9.PY7qUS7yWbiCJwKv_HM3nk-9RlBlNxUXjz23zEsez1o'),
(52, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjQzNzN9.ucDKzAaYpypfB3Etu_M7ztQPc9R7ZsitoSxsVT8rplY'),
(53, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjQ3MjJ9.vz-3WcAJ_1aOiSigvndXGpVOxwb6V5lN8qM4BOcUu4k'),
(59, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjUxMzF9.yJPmzT2AlDkpRNYX0vFq_tfJqBtoBaWGCuh9Okz-dUg'),
(65, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNDUzMTF9.YnViMNbDBqxmE0aS2F2NTFoj6MCC9VtkpgRI8uuAxPk'),
(70, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjgwNjB9.aGnHPKe1o5lBUtNQ5nYjCiH5ke7EGnopdNZEMN8orw4'),
(75, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjg0Mjh9.qtIvqkRKzYdHRey5bC8K9lQCtK8MWM_VOpqyQi-pJQY'),
(76, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjg0MzJ9.TeHbj0KRYi0odl8PybRlcth8HWmUWxen4J1np-O3hPg'),
(77, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjg3OTV9.rS-kAAFWhzFYaAScjSHe6_V7rh5PwthFan9eli4ETXQ'),
(80, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjkzMTl9.f5S5zrHmy1tTuIhUbklNAPtWp-wYeVy-8P6G8Y2LNks'),
(84, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNjk4NzZ9.FF4fgEH5e8AZmYUodlIZ8rix6f9i-F19Mp_jZpeBf6Q'),
(86, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzA1MjR9.pkfuHVadYdIf8Hks1euG1lYAWbtJbgZ0tLXf1dUcZAU'),
(92, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuNlJRZUp5S1I2ZFlYZzlzNWN5dmFxVExJcTBQU3YiLCJleHAiOjE2OTgyNzEwNzd9.j7XuSVnW6ypXZU4pWC4EdG3TdWTpmlewF47sqj5eC0g'),
(94, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTgyNzEyMTN9.n3HSdFzcqjXazBhxHw_J9DtjZUdylCFogDPoB27gB8w'),
(96, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyNzE2MTh9.QP6MEYW-2V00_f54I5C-dbj61LCLLMCvm_1sG4XTvYc'),
(97, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuNlJRZUp5S1I2ZFlYZzlzNWN5dmFxVExJcTBQU3YiLCJleHAiOjE2OTgyNzE4ODd9.FyMKYM2xIdSxuRpXskm7hlda2kQgv0Q1K2_Moh8O28s'),
(102, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzM2NDh9.qJzLkB-9VClIqspFQPpYWSrNkExA6QDBNpbTr6iuWb4'),
(104, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyNTI1MTd9.sOKoGXQWxf5ID1hQDA_9hHv8vJSVV0G65ZgT89FdLsM'),
(105, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzQyNjF9.4v3j_H0xMpO9BYDY-zMYBD-XroBrYPHMMPGMHL9FaUI'),
(106, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzQ2NjN9.-JDl2wJHihkm95BeyTxmInosx3B-G84gOzo7PxlukSE'),
(107, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzU1MjB9.VGGxU0ZdnKDWGJq8j0IzkhV5CjYEHvE2QqCYrQUBoBA'),
(108, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzU1ODl9.85T5iId4ZkRH68HSkdzfKaS0hTCu_floVpVdNtZbwuM'),
(110, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTgyNzYyNzR9.xH_xYiV40fkncvcw5wwPxeWERb1jCIQDBJ8ybc4InbA'),
(113, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJvclltUUlPeDllSmppcnFwSHZBWTJZRXBIcXowakIiLCJleHAiOjE2OTgyNTQ4MTd9.pXHng3GLhmdWUU4OqzTGLil-vfSJU1VgAv0VW_eT_QA'),
(115, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzcxODV9.j0hkVN7VJA8FESZMUhJbruFiCGYR7N5Jo0-YqMv8fkA'),
(116, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzc4Nzl9.klW6d-w_paUdJCWejuglXvnOmBNeUx9Gj9seplTqw_A'),
(117, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzgwMjJ9.ZVddA3PusNlwBOU6afpNHUQiHQ7bUCWqhdVeEUOHqdY'),
(118, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzgyMjl9.Cm1StU1uP6RmbVS_zjqd4uoaGuInOQSVeu5F0rVs840'),
(119, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzg0MDF9.mUm64MlOvNdvclQFnr2zxA-riRM9pjOmEKcpdZzMwlI'),
(120, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgyNzg3MDl9.ac1mKMXqRy2CraW5kpn_W-FBl0W4u-OVS5wq4WShgHI'),
(121, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyNTkyMjB9.NscDZ-MfM-DSPgrdPqnT1QBfDsvq_UU1N43-sbF6BEE'),
(123, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJvclltUUlPeDllSmppcnFwSHZBWTJZRXBIcXowakIiLCJleHAiOjE2OTgyODM5NTd9.zLK-QRjh5mBWsDAZRCwJk-P0MR1TdvXZbbEdI7luA-c'),
(124, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyODk2ODd9.M4N5xPQyobUJy_HCslzmx9UMcetEHDvp1w0WxYGjxMU'),
(128, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyOTA4MjN9.jCG4xJ0e1gud5ijZuSFbowlMW6UXghaEFWpqzxXqhmI'),
(129, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyOTEzMDJ9.555t8N_gVt-SnRNNu9Zwe4LJHRMON_dZc2ZLtRtw8-Q'),
(130, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyOTI0NDh9.uYuisRMj7ttMm_MDuHbFSH3tfvY6W5EVnaC9X7q3sQM'),
(131, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyOTI4MDF9.kpowLH8TIQuKGksROukjTq12-QcrP85geashP6RFMx4'),
(134, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyNzM4MTF9.YnH_6JqjzqJIHsDs7RpTNwgJGbtP1AXarRCRHTzUrb4'),
(135, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgyOTc3NTR9.xyND0lqY09Oz0nc7ijR1g1webeiTnfqJ5vmrVA7k2H4'),
(136, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMjY5MTd9.OXDFDlCwFpd6TIo4faHGWe1eaaLx4fUmi1rltKnBBIw'),
(139, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJMZGsxbXJjcjIyMDRneDJ4OVNlTTVqdjVEZEhhMUsiLCJleHAiOjE2OTgzMjc1NjJ9.dGy9BHBK_CfCAih9kjilguJRftJENK2HJPnGe-ciG_k'),
(141, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJMZGsxbXJjcjIyMDRneDJ4OVNlTTVqdjVEZEhhMUsiLCJleHAiOjE2OTgzMjc5OTd9.ALsUvOMLp0GoOY9N1JoCQa52GGXVqYmU6tSsXzP0Rwo'),
(142, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzMjg0MTR9.L-TWYPl70Ymhg0tH34J5WTb8TFLDn6RF3UrgL1zTu0g'),
(144, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMjg3MTB9.QBRD8_MlRd6FummDXg5648aRlLJMu_dChHTGtpGsDb8'),
(145, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMjkzMzJ9.QGBlyBvQzpmbp1lJN49XfZmUOIDWJWegyBhu7e8NdME'),
(146, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMjk0NjF9.4vs5eTLWatp-XQBm0KZ3BkpcfUnLsXo_zs0jk9vv1MU'),
(147, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzMjk4MjV9.xJ9h7qpdBdTcWhrBinxgI4Lgkj9iy6NOucc031-EXKs'),
(151, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMzI1NDR9.4vIkFHtKlXGdVeNSbe3MhrMnunAn6h6-q1QQQbsQgK0'),
(152, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzMzMyNzl9.oKcadrcVU4X5QM7WTFF9nxrFDSmq2EwE9QGI5Agsbq4'),
(153, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMzM4MzV9.JHEkQmZfnbvNqcFQmms8OiFFeHfVhk8FjXK3HCyKRUA'),
(154, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMzQwODB9.pCgng_tL6Tm8YLuaCFDAfbSdX0DJwK8yox1BLif9NmE'),
(159, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzMzY2NDd9.qcAveciqygFZTZXjPSoxfomM4VH4ZRPVSDpgDDdLY64'),
(164, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJXQXF2WjV2eDcyTjM2QzZ6YzRMd01rb1BsdlJPdEUiLCJleHAiOjE2OTgzMzg1NTB9.UC-9yxCHVCQ4IxgwSW6relRrMMQuqhtCwUNQFgfEByY'),
(165, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTgzMzg4MTR9.6i-J08l_PV42RPAs-jImBp3TdpKia8bVNEXS1fIaY1Q'),
(166, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzNDA0NjB9.OIzkcPbVYCuHjJY3HhriRrIHibvii49ylrAmo05ezCY'),
(167, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzNDExNjJ9.ipDuFHOEShttS4lRAIxQWzd6VoApaB_dIq1SIGfA6iw'),
(168, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuNlJRZUp5S1I2ZFlYZzlzNWN5dmFxVExJcTBQU3YiLCJleHAiOjE2OTgzNjY4MTJ9.zFJ5lfy8tRwuFmAq2pH3EJntL4VnLUTPK5akW9_Pg4g'),
(169, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgzNzUxNzl9.VtQVfViz0cIrNjykWbfaPfqDDQSH1MB0aI-gdYG5Ufs'),
(174, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTg0NTM2MjZ9.Bue6gCtEztcZ8vIOR0VzXXXiTQD-DDw-dgJy5bKWVuI'),
(178, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg0NjA0ODh9.xd42P2MRMCIK7Q6NidHiKdYbCZWyHv8y17pQv2syGTY'),
(180, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg0NjI4NzN9.Y6a5QwVaFRWBiYWkqmihUN66vBEY_anTycWojotmlnA'),
(181, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg0NjU4MTh9.tVhUf5loNc0Gb5p6ZevYI8myJy0tLg7Rq2xO7y0U5_w'),
(186, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3MDkyMjd9.r3qOPWzRlCk_Q6infkDGlYNYUE8vo-xqlNKw0iTbI8s'),
(187, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTg3MDkzNjl9.sY3JrYvEJcGwWyX8plnpLJbWejbWRSmQxrZWhWJI9bY'),
(190, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3MTA3MjN9.9xmMTmCLJuvxgMFtI9EGoNLi9rI7DoRIX_5UdXmiDac'),
(191, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJLNXRaOU1PRFNNUlZrZ1ZNWHJYczZxa0x6bU5ma1giLCJleHAiOjE2OTg3MTE4MTR9.sg5oApSGFF8C2sLbDbZr6xFcAqmlzrIdLBt6X8xrmEw'),
(192, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3MTI5MjJ9.hTRA3NLvbD6mnaUKuwI-dXjjQ6KpgYid2L3vftSaBWs'),
(193, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3MTMwNzd9.jZjpHuNA7NGPjZD1xNJvXoFxgUc0xiFZQ520c1Rj10w'),
(194, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3MTM3MTR9.Vum-AhDTXV4AbrABLVrXyhDeyO8sq1CqmYdN8RgJ1kc'),
(201, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3NjU3MDd9.hPFqv_zdD86ewjau5eXRVPk9w4XAVnC2gaNlFjea678'),
(202, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg4MzQ3ODB9.D2mCmaNx0BRTI20Kl1P2AGjIzJuMFXtZHGUdjMu3NnI'),
(207, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg3OTExNzF9.5O1apc-0HJqw638Aaz7OXPgLb1qHS37Vv3lOJIhXgu4'),
(211, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg4Mzg3NTV9.twTdCDEiwtrOC66KG-4MHiUKxHHsD8qc1BBofVXhK-k'),
(213, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg3OTMzOTR9.yQM2myXsrACYYjmqzQC_8bQTRYahbIP9z_vH42suaXo'),
(219, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg3OTc1MDB9.d0eZjA6gtbg64u2SKczcKJKGFjEoVwTHtLdBQ6OaWAA'),
(222, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg4NTAyNTh9.3-dNc6fhDwgHu0Ig3ph0MMG9yumikIT6vPTAl5yOPcY'),
(224, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg4NTIyNDd9.Ela5yFITdm-C54wj-Eei_ZR6ObhsgmStPmNWRgbKI7c'),
(225, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg4NDQ4NjB9.r0D7PmGvB4U0fQI70xnK69js-jM4mPTh6U27v4bdo2I'),
(226, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTg4NDQ4NjF9.uNdv_itbcpGLffFABYqUJoROw2KNgD6V629qZHzl4uk'),
(227, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJ6cmZHWEttSEdUU0s2RFJudTY1TFdYZEVQOHdaU1IiLCJleHAiOjE2OTg5MTQxMzV9.VIOB3OTmN2LY7CMTzteyLVs2OFg03cyk8B37RUxn9B4'),
(228, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTk1MTYyNzV9.cfXwjBep1SpqualBusAGLHu29_jpdFlf0i8kAbNSpwM');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trazabilidad`
--

CREATE TABLE `trazabilidad` (
  `id_trazabilidad` int(10) UNSIGNED NOT NULL,
  `id_empresa` int(10) UNSIGNED DEFAULT NULL,
  `id_servicio` int(10) UNSIGNED DEFAULT NULL,
  `estado` enum('Pendiente','En proceso','Finalizado') DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` char(30) NOT NULL,
  `rol` enum('SuperAdmin','Admin','Tecnico','Suscriptor') DEFAULT NULL,
  `empresa` int(10) UNSIGNED DEFAULT NULL,
  `nom_usuario` varchar(50) DEFAULT NULL,
  `apellido_usuario` varchar(50) DEFAULT NULL,
  `correo` varchar(90) DEFAULT NULL,
  `tipo_doc` enum('CC','CE','DNI','NIT') DEFAULT NULL,
  `num_doc` char(12) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `municipio` varchar(50) DEFAULT NULL,
  `contrasenia` varchar(180) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `rol`, `empresa`, `nom_usuario`, `apellido_usuario`, `correo`, `tipo_doc`, `num_doc`, `direccion`, `municipio`, `contrasenia`, `estado`, `create_at`, `update_at`) VALUES
('1IE18brsaiyX3kS4oOADhyJhQvKTTg', 'Admin', 80, 'ads', 'asdadad', 'aabb@gmail.com', 'CC', '101230', 'asd', 'ada', '$2b$12$4liWNdqAD3M9Ebvw.XzXWeV.SWJL0cZamuCkZ4Tza6o8WVF3gcv62', 'Activo', '2023-10-11 23:35:55', '2023-10-11 23:35:55'),
('1lYphPC4n361EI5p5Jvwsuw7bBzwOy', 'Suscriptor', 92, 'Camilo', 'Suarez', 'camilo@gmail.com', 'CC', '1234567654', 'Armenia', 'Armenia', '$2b$12$r0rkDqcuhp0zuPCjqetQ6Ou6CqOzPPdcBs4tSjE593dvhtvzCmHte', 'Activo', '2023-10-25 01:59:59', '2023-10-25 01:59:59'),
('2Jb9V1A65wluc086jWwWbmEu8KgiQD', 'Suscriptor', 48, 'alfredo', 'marin', 'alfredo@gmail.com', 'CC', '12354', 'pereira', 'risaralda', '$2b$12$lR9Y6Sx1qdK2eJF5zo3wzecXrAp3rO9U5S74Mk7VaM9ZdLPWuEJMu', 'Activo', '2023-10-12 14:30:38', '2023-10-12 14:30:38'),
('3hpWrRlZyvAWBfGluyuPu667f4Lxn1', 'Admin', 36, 'Diego', 'Legarda', 'diego@gmail.com', 'CC', '108797', 'Pereira', 'Pereira', '$2b$12$982im0ymcyJh3VN.X/n1MOm7RCbkCLSb7pC9s9mDqrPmoGoF9VtiW', 'Activo', '2023-10-11 15:18:17', '2023-10-11 15:18:17'),
('4tXE9mHQMNLaI9ouP9K57M0m5tJzv5', 'Admin', 35, 'Erick', 'Mejia', 'erick@gmail.com', 'CC', '108803', 'Pereira', 'Pereira', '$2b$12$/YxX/rbMiD3jN8TB3RXkwe.vatJTnRyfsvBa7LKknJ2F/esjMN0JW', 'Activo', '2023-10-11 15:24:09', '2023-10-11 15:26:24'),
('524GkWjhM36hwC76sKBAYJQLlCmRUX', 'Suscriptor', 35, 'tom', 'jerry', 'tom@gmail.com', 'CC', '10777', 'Calle 04', 'Peree', '$2b$12$hyjQ0bQ/WrrX1gqJQKwnhep9f/TxM4X2k/p63tnFeLsVP2KiS7t9q', 'Activo', '2023-11-01 01:23:36', '2023-11-01 01:23:36'),
('5zSsJpTynaBntgLArNyk9U5khb5qcN', 'Admin', 53, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comdsadas', 'CC', '13213141598', 'km 7 via armenia - potro rojo', '1241', '$2b$12$Y5lhXnXlbMuwZnRb4OsyBe5pRLQMh0Res4hmS01Ka/u2hEyozocXi', 'Activo', '2023-10-25 23:35:49', '2023-10-25 23:35:49'),
('8poaMthdKY32GE7xnu6rnMoWy8UHaq', 'Tecnico', 91, 'fabio ', 'andres', 'fabio@gmail.com', 'CC', '12345', 'calle 00', 'Pereira', '$2b$12$cxxxflC0WaCK3GkExEeJm.EAEKpWtzqK2OPXfpeihbeWGhKz/Gata', 'Activo', '2023-10-25 18:24:35', '2023-10-25 18:24:35'),
('9OcoHEmJ2bT7O3LScMEYUY5FZYqlaZ', 'Tecnico', 36, 'dghdfh', 'dfhf', 'user@gmail.com', 'CC', '2353245', 'Pereira', 'Pereira', '$2b$12$gFix2GDHuJLlqUZg5M.hmOc5qxiogfCT/vF83WH0QW905DNf9VUo6', 'Activo', '2023-10-12 02:09:29', '2023-10-12 02:09:29'),
('9vO1nWUZ0bYuaaamLozCObo5fiHpwV', 'Admin', 34, 'dsa', 'dsa', 'asdasdsadsd@das.com', 'CC', '321213', 'dasdsa', 'dsa', '$2b$12$z6jy4FOZfARf/cVOPpqCyO64JG/knLupyrD1lEMd6c6Y4hOmc1/TK', 'Activo', '2023-10-25 23:05:20', '2023-10-25 23:05:20'),
('AbmAnw9dqhuwJ7f8tSXX1V7NypLhWe', 'Tecnico', 50, 'andres', 'gomez veltran', 'veltran@gmail.com', 'CC', '106745346', 'calle 21 # 23', 'Pereira', '$2b$12$IGV1R1WZn.LawePCuhqFXuIUcs/OIDW.7DXRnzNvdn9SBuccodNoi', 'Inactivo', '2023-10-04 02:02:08', '2023-10-04 08:41:01'),
('CsUAcd58oR9J78TPOsZZ8k5mF0Pflh', 'Tecnico', 35, 'fff      ', 'fff', 'braulio@gmail.com', 'CC', '151454', 'm5', 'Pereira', '$2b$12$IVq8j6boBbSoGV/07HCczeu9zzxXbE.M40dyIWVSjUbcx1m.3gS9m', 'Activo', '2023-10-11 15:32:11', '2023-10-26 14:02:01'),
('CwofYEpdpqG9elm14Ph3DkfeRpzQ3h', 'Suscriptor', 1, 'Esteban    ', 'Rodriguez', 'papaniel21asdasdasd5@sgmail.com', 'CC', '234234423423', 'Transversal 3 #5A51', 'Quinchia', '$2b$12$sPCRSpyLbV7LbLyFJ6oSnOI6TPOoUqRneK8G8OIuAdlFTKAmnz56C', 'Inactivo', '2023-10-04 02:45:42', '2023-10-26 15:37:12'),
('DeeMeNbrzGWgsJaTYfFAXkxCy0WWrK', 'Suscriptor', 80, 'diego    ', 'legarda', 'diego@legarda.comm', 'CC', '216489', 'pereira', 'pereira', '$2b$12$NtZ/9wd5KUX4pTtZAU8ZJOk5RSf2UvV/s2an4ig91IvOeYqmR1NJ6', 'Activo', '2023-10-03 20:35:56', '2023-10-04 08:01:08'),
('dlcjr49dr8waCamD1ihVwjmv1YflUT', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.como', 'CC', '16467', 'km 7 via armenia - potro rojo', 'pereira', '$2b$12$KFVxdLsvVASJCB4QBev/gO9nr/f2hLNPQyjNI.ItwDRHvte8w0cH.', 'Activo', '2023-10-25 23:15:27', '2023-10-25 23:15:27'),
('DsrGpJyjk4Fsbk8zjFSBj5F9M6ftwq', 'Suscriptor', 52, 'dz', 'Mejia', 'kikenet68@gmail.com', 'CC', '828247474', 'fuera', 'pei', '$2b$12$GV25k0zIIgNOQeu8uglA7OodVXzDyjUo8/naXS/HUc7aalgXBU4Y.', 'Activo', '2023-10-26 12:42:50', '2023-10-26 12:42:50'),
('DXjdYWWug0rRiOXLGXLG2eFYMgrfDr', 'Suscriptor', 91, 'Kevin', 'Mejia', 'kmma407@gmail.com', 'CC', '9876543', 'Centro', 'Dosquebradas', '$2b$12$fcTfBVH7QVwdk4KZWnyAouf8iCG.pp8BdMYg.BfADsxO13nx.EXHW', 'Activo', '2023-10-23 20:59:46', '2023-10-23 20:59:46'),
('ek1t2Ga9jAKnwthvl2fFPQ3WqnVFiZ', 'Suscriptor', 1, 'Esteban  ', 'Mesa', 'papaniel3434342145@gmail.com', 'CC', '34234234', 'Transversal 3 #5A51', 'Quinchia', '$2b$12$n9.NEO/yflrjBVdFB7bPCeraafE5MGX2pPQgsoz7znsfKzXHYAVIi', 'Activo', '2023-10-04 02:49:09', '2023-10-26 15:14:48'),
('ez0TpDirNOaeHPuzqG1b8FK2jQmxpL', 'Admin', 91, 'Samuel', 'Mejia', 'pruebacorreo@gmail.com', 'CC', '1088789056', 'Dosquebradas', 'Dosquebradas', '$2b$12$6yHZdokHcH18XA2u9jhMIe1SveMcIC8RctUs5qqEJWu.vCHTTZ7rW', 'Activo', '2023-10-23 20:48:28', '2023-10-23 20:48:28'),
('F3biYMf5Tj9PDH3AhaHJLUxK7eye4d', 'Suscriptor', 91, 'Carlos  ', 'Valderrama', 'rivermiddel@gmail.com', 'CC', '3578563', 'Carrera 12', 'Pereira', '$2b$12$hXrOfQCZgUH0mUIGn4PVZOdCvi.cKX8/iN6OGFp3TJTKCmo5KhIzy', 'Activo', '2023-10-23 21:42:52', '2023-10-30 21:54:25'),
('Fb5Azl0eFhcdBN1esvORajUHdls3iT', 'Suscriptor', 1, 'mcndm', 'scscsc', 'vdcdsvscasmvdsnvsmc@mail.com', 'CC', '788825', 'Llano Grande', 'Pereira ', '$2b$12$9H1PrQlT7OJ/xUC../shRuj0QYnK4ujTrPVLDGBREnThq8dSNpYuG', 'Activo', '2023-10-30 23:42:35', '2023-10-30 23:42:35'),
('fVPfAR5mwm3FLouircuVhLtveSrw7N', 'Admin', 53, 'asd', 'asd', 'mateo@gmail.com', 'CC', '123', 'Si', 'Si', '$2b$12$9G4u.EWKtUUlL9ulTk1lkO/K8Qcn8EdlPMRhcGecLsRZSHvg7FtdS', 'Activo', '2023-10-12 13:39:41', '2023-10-12 13:39:41'),
('fxuYErW7mf3AhXRnz24G8Tt0FlBkYy', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotm312ail.com', 'CC', '411566789', 'km 7 via armenia - potro rojo', 'das', '$2b$12$BYvLaMdZcgUe6stWo3yJ4u/zibSYPVeFPevjT/5PihpRIrWH0Q.R6', 'Activo', '2023-10-25 23:39:37', '2023-10-25 23:39:37'),
('Gg0UIBQMrUzt4FesGJUxXfq0nJSXhY', 'Admin', 89, 'manolo', 'herrera', 'manolo@mail.com', 'CC', '108800', 'Calle 04', 'Pereira ', '$2b$12$0Eb8oPvfzBCaxdzP90zxUegOiHEFZPTBaq9WVcMosOO0TRz9vGJ9G', 'Activo', '2023-10-25 15:10:57', '2023-10-25 15:10:57'),
('glr6EEGdQemCloeSlFHOmAXj5DTgE9', 'Tecnico', 41, 'Santiago', 'Ramirez', 'rama@gmail.com', 'CC', '1089598', 'Calle 9', 'Dosquebradas', '$2b$12$/H7pQrWuXLeJdashHWwaGOPomWHCxP8il4GQ63WnovNEXDZkqVU0K', 'Activo', '2023-09-29 00:58:05', '2023-09-29 00:58:05'),
('h3k4eJBkki8GQ8pqIReVdnFlXHhZO6', 'Tecnico', 34, 'mcndm', 'henao', 'mcndm@mail.com', 'CC', '1088001244', 'Llano Grande', 'dosquebradas', '$2b$12$M8zTlEUa9zUhtotFxcbiKOpinxIPYM/DjErONTxAbCEGYdWu00KA2', 'Activo', '2023-10-25 22:12:41', '2023-10-25 22:12:41'),
('hg9fapcAlGtzIy9EPUFQtq7OM1QyTt', 'Admin', 34, 'dsa', 'dsa', 'asdasdsadsd@das.com', 'CC', '321213', 'dasdsa', 'dsa', '$2b$12$e5GSnukD83jzoZPqMqe48uE/HtHcIhSCmI3zGS8brzHruAN2DNKCm', 'Activo', '2023-10-25 23:05:21', '2023-10-25 23:05:21'),
('hpz6p1DbUTgarSIn1moHtgTHUYz5Kp', 'Admin', 1, 'gvfdvdf', 'dvvfv', 'yuca@mail.com', 'CC', '4555555', 'mnnb', 'dosquebradas', '$2b$12$AAYau.Jr5ayiFwaxSNnCfeFOwp7zPYs6RwTNDbX2OatOq7KYKeGBm', 'Activo', '2023-10-31 23:30:02', '2023-10-31 23:30:02'),
('HSpq5iCvWchaDMt5pJORROVnCJwYEe', 'Tecnico', 2, 'gafas   ', 'henao', 'adminxxx@gmail.com', 'CC', '1234564567', 'calle 4', 'Pereira', '$2b$12$juHJM/rPMFgp/Q1mJokPWuX8cYpyCHla01UZCGaRQAVGVTQnvurxO', 'Activo', '2023-09-28 03:24:58', '2023-09-28 13:09:31'),
('IcP9YnF4oqIXsZnsD4FeDXk8UO0LSF', 'Suscriptor', 43, 'patricio', 'Calamar', 'ramon2@gmail.com', 'CC', '10787878', 'Calle 04', 'Madrid', '$2b$12$jV8NlIDolCAF.7lUSaa3F.ifkxVwJ97hHd12GrfEcV6IvuelrKc7G', 'Activo', '2023-10-11 22:28:19', '2023-10-11 22:28:19'),
('j0vmiCeZEvdFzRxVFZCjwVvvaRmDqD', 'Tecnico', 55, 'juanito  ', 'gomez', 'juanito@mail.com', 'CC', '121021', 'Llano ', 'quinchia', '$2b$12$Ol.PQs1wd5AmabXjegRu9OIFdiTmcwPo0Jkz9F.iVcvjuMGjHJsBK', 'Activo', '2023-09-29 01:10:28', '2023-10-03 22:08:15'),
('JT5g1gR66RjpCmXjZvflLkuybu8u3k', 'Suscriptor', 35, 'Braulio', 'Osorio', 'Br@gmail.com', 'CC', '123412455', 'no found', 'Pereiranos', '$2b$12$UFWDVCmFjMWGf1hZqtpGWOskZDTZg.jMaDwzP5DnNsRekAjnV2P0i', 'Activo', '2023-10-25 00:38:41', '2023-10-25 00:38:41'),
('K5tZ9MODSMRVkgVMXrXs6qkLzmNfkX', 'Admin', 91, 'damaez', 'gonzales ', 'dama@gmail.com', 'CC', '162527348', 'calle 45', 'Pereira ', '$2b$12$JQ734opnSkGE92CjSAgKuuLaI7GW8T24EscIjuXk4Lvw2u0pJhtYq', 'Activo', '2023-10-19 00:45:58', '2023-10-25 15:34:31'),
('k6MnApbo6p3EW3eEZgaHlb7apYhDh1', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comd', 'CC', '1646', 'km 7 via armenia - potro rojo', 'pereira', '$2b$12$2Ys6n6MUPrCPxnQiQeVvyeBeaLsdLtOUyk.VyBKQwi0lTUZvoeNNW', 'Activo', '2023-10-25 23:14:47', '2023-10-25 23:14:47'),
('KDjyCra7jqV8C8pEj17OxKDx1ZbCEh', 'Suscriptor', 91, 'Mateo', 'hernandez', 'mateoherjim18@gmail.com', 'CC', '2345674', 'Pereira', 'Pereira', '$2b$12$DEm5TiDT0nbRirjIE.Vf5usyKrO48RDOORHr0k18sUhddng7k80nC', 'Activo', '2023-10-23 20:57:40', '2023-10-23 20:57:40'),
('kNJVK6wg8TBWh85H7zJbjxgAVob0zs', 'Admin', 36, 'bob', 'esponga', 'bog@gmail.com', 'CC', '1088123', 'Cra4ta Cruza a la izquerda', 'Por alla', '$2b$12$g/yj2YQGJbfKD7y/np7gHO9URpOgSG4SdvTDc98uqhNoXvrddmM76', 'Activo', '2023-10-22 22:08:09', '2023-10-22 22:08:09'),
('KsxahxJBqbYHpS5LX25cmIFSzroliC', 'Tecnico', 41, 'juan', 'jose', 'juanjo@gmail.com', 'CC', '12145541', 'm6 C10', 'pereira', '$2b$12$UtjUrfuWjl73t3qlWGXQguMTD95IWCLB5PE/h7oEbTQOkdDowx06S', 'Activo', '2023-10-03 22:20:21', '2023-10-03 22:20:21'),
('KTYVHzcKXRw4xkShiNFq3m502KPFDg', 'Admin', 43, 'fabioAdmin', 'farndanez', 'lector@gmail.com', 'CC', '1088444555', 'Calle 04', 'Per', '$2b$12$6Kh8Yrk0bCk3WTY6YB3ZKO8FTsZcCUAzSCs2Esew1E/tT/TLsq/Ni', 'Activo', '2023-10-11 22:21:30', '2023-10-11 22:21:30'),
('Ldk1mrcr2204gx2x9SeM5jv5DdHa1K', 'Admin', 52, 'pedro', 'sallamon', 'erickvnrm@gmail.com', 'CC', '12345321', 'centro', 'dosquebradas', '$2b$12$1QnH376DyNQAdRN4qmaUgewKHWYGzynyaiTl6p0UXOUv/AWAe8FUS', 'Activo', '2023-10-26 12:38:36', '2023-10-26 12:38:36'),
('Lf08Xi7k5wrYqhf2SvWTOwJGxt1deb', 'Suscriptor', 54, 'mcndm', 'herrera', 'cdscscdc@mail.com', 'CC', '1044444', 'Calle 04', 'quinchia', '$2b$12$25juNt/sukO8WPfGUIL0fu9e6MByAsN4ghKuGBKpBk6e41JUeSlYS', 'Activo', '2023-10-30 23:19:40', '2023-10-30 23:19:40'),
('M5dfHiC2ftQ9tb19LRbJUSLuHYuKTY', 'Admin', 49, 'jUAN', 'IFDIOJNFOIN', 'juan@gmail.com', 'CC', '632467476', 'sdmpfkmp', 'adpomd', '$2b$12$uaJ2glT0ua4GPyCLpGuIAu4lyZRh3GAMCXKR/hRMuZ5/KL.dFdxOG', 'Activo', '2023-10-25 22:03:05', '2023-10-25 22:03:05'),
('MqaCYsEDroAPFkKPyOqsEgbwq89Wa7', 'Suscriptor', 91, 'damaezs          ', 'pere', 'ez@gmail.com', 'DNI', '10678451', 'dsadd', 'pereira', '$2b$12$U/1g.cdVcpqiZBoku2fmqOUfJRQmyS4/iO/NVqxk6NJkV4gsQK6pS', 'Activo', '2023-10-25 21:43:36', '2023-10-28 03:07:27'),
('n6RQeJyKR6dYXg9s5cyvaqTLIq0PSv', 'Admin', 92, 'Thalia    ', 'Grisales', 'thalia@gmail.com', 'CC', '78464325', 'Pereira', 'Pereira', '$2b$12$vCxtLyZfPSVksJ/A19BhhenlI1mIuraSsphd381npmodx4qQpcna.', 'Activo', '2023-10-23 21:41:51', '2023-10-28 02:14:24'),
('Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Admin', 1, 'maksd', 'aksdm', 'admin@mail.com', 'CC', '1213', 'ad', 'asd', '$2b$12$XHtNuDmuiSwc8lrx3hhynelEwtS31m8lA4WwglBttiaIr59VeM85a', 'Activo', '2023-10-03 23:24:47', '2023-10-03 23:24:47'),
('oaB3aeFiryWTjgzppsZKEj2yebmD3p', 'Tecnico', 37, 'vdsvss', 'dfs', 'vdsvs@mail.com', 'CC', '1544474', 'Calle 04', 'dosquebradas', '$2b$12$F.Xe6FTzMEylXqpUsDoqiuQjua.K4Zda3L9q5rs3YLkPASlLt8FCq', 'Activo', '2023-10-30 22:50:04', '2023-10-30 22:50:04'),
('oB7Iew0cZpcfuZKjjTiQKzvRh7wykE', 'Tecnico', 1, 'tecnico', 'tecni', 'tecn@gmail.com', 'CC', '1234', 'diasjdiasji', 'pereira', '$2b$12$qTzqxg/4MI7SrCH1Edram./O2YsPVzupdFEjMdsvNMTj5ZGQzPZEC', 'Activo', '2023-09-29 01:04:03', '2023-10-19 07:54:48'),
('ojJaXTaqlVPjEidhQ5xSuW7A4aSuFU', 'Admin', 34, 'julian Andrés', 'Vasquez Morales', 'midnight3424@gmail.com', 'CC', '231312341', 'km 7 via armenia - potro rojo', 'sdadas', '$2b$12$BST8OAF9dvk1o8Ns..MnZOcUSI1rpz1lEsHWnysSfNlcJej/jc0Ji', 'Activo', '2023-10-25 23:21:52', '2023-10-25 23:21:52'),
('ol92TZRuqXRrKTVXzxDknFtoAgQc0j', 'Admin', 1, 'Esteban                  ', 'Mesadas', 'papaniel2145@gmail.com', 'CC', '1001212', 'Transversal 3 #5A51', 'Dosquebradas', '$2b$12$H66ikh9an68h3gk7Ezot6ecq2EqF0J6Vkd4iCbPuul/N9o8f5Qr9W', 'Activo', '2023-09-27 02:23:39', '2023-10-03 22:20:45'),
('orYmQIOx9eJjirqpHvAY2YEpHqz0jB', 'Admin', 34, 'Manuel', 'Elquin', 'manuel@gmail.com', 'CC', '965445678', 'Armenia', 'Armenia', '$2b$12$cRr3cFtDgfksUMWMnSmidei5D6VceqtQomWzPS0TQFfZHMcmh4pS2', 'Activo', '2023-10-25 20:29:26', '2023-10-25 20:29:26'),
('OW3ZJ02xWnpPipX1JWZGrpDDmFcRCO', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comdda', 'CC', '3213121', 'km 7 via armenia - potro rojo', 'dsa', '$2b$12$W1da8UYGc3/ziq1XBCfzKuRzXosiN5tEO7JHEz8Eu1AgQYh.ay88q', 'Activo', '2023-10-25 23:19:23', '2023-10-25 23:19:23'),
('OX69oNPe5zoHtuP3nfnpOf3ngfY1Ip', 'Admin', 34, 'Julian', 'vasquez', 'julianvaskez12@gmail.com', 'CC', '231321', '321312', 'dsa', '$2b$12$HeOVGcRXxks30t2M2tgDq.LQjj1KxjgdJNIHtjjGvoDxVpFfHgAUW', 'Activo', '2023-10-25 23:31:08', '2023-10-25 23:31:08'),
('OXlXFBf6weOKxIH07t0G5H8bZLIdvZ', 'Admin', 1, 'khgkhjk  ', 'hjkhjkhj', 'sadasdassdd@dasdas.com', 'CC', '31312312331', 'hjfghfghf', 'dasdagkj;', '$2b$12$XIgTEmQ6U7WxH93DrEjsiOjBdCRNtMf3EQFf63d2DZqlb1ijl2CPC', 'Activo', '2023-09-29 00:57:41', '2023-10-03 21:03:50'),
('PcKAYBupWXB5PV4eO8WnaUu2fdpN0n', 'Suscriptor', 91, 'David', 'Osorio', 'braulioosoriomartinez@gmail.com', 'CC', '87654319', 'Malaga', 'Pereira', '$2b$12$pVcQbvZ4KPFUquU/g9ulNOe/CMAW.xx2U1VgQalZtCuByCFoTRuzy', 'Activo', '2023-10-23 20:53:04', '2023-10-23 20:53:04'),
('PKRTonuESTgXvTSh7qZxvfjMkMjjLi', 'Admin', 89, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.com', 'CC', '312321', 'km 7 via armenia - potro rojo', 'pereira', '$2b$12$sD8G2C6YSgwz9hS7lPxh0em0hFF5k2Q60435Wc1V88jMFe/AEt8ha', 'Activo', '2023-10-25 23:13:39', '2023-10-25 23:13:39'),
('PROd665M8JL4mrWWZfJMd3y9vWm1Vs', 'Admin', 34, 'julian Andrés', 'Vasquez Morales', 'midnight3424@gmail.comda', 'CC', '231231312', 'km 7 via armenia - potro rojo', '4312', '$2b$12$6npfMwdvWXDkbJSwoBrnxOPWbWFW3Fnv0sEXfXJ3rHKuRF./eWZYW', 'Activo', '2023-10-25 23:33:56', '2023-10-25 23:33:56'),
('prvgupUg7d0XGJEP691tBIwngC5yGV', 'Suscriptor', 80, 'Esteban', 'Mesa', 'dieguito@gmail.com', 'CC', '54574545', 'asdasd', 'Pereira', '$2b$12$0qItp.8PiG.T5wFHUPUUTeb23bCIDpaXvvbUXl9KTAlWesgixMEVi', 'Activo', '2023-10-03 22:27:47', '2023-10-03 22:27:47'),
('pv5sxPEXbOkHQp7qdERgfQ951Jgw2k', 'Tecnico', 35, 'tecnico', 'apellido tecnico', 'tecnico@gmail.com', 'CC', '1088788778', 'calle 20', 'Pereira', '$2b$12$J1c8M5W3RHUmaQEJPOP.F.fvMm9rnvvN7K117r0TdC94EEfC5M.4u', 'Activo', '2023-11-08 11:52:09', '2023-11-08 11:52:09'),
('qbDpeUw43LL3YPK2p2RxlSdECkRM6i', 'Suscriptor', 1, 'hcgcgc', 'herrera', 'ferrrr@mail.com', 'CC', '44455511', 'Calle 04', 'dosquebradas', '$2b$12$2pFkzHcfPUmL8zxAinXAkeq4EmB8jOTm1KWb8syx5Msgaau7diZz.', 'Activo', '2023-10-31 23:31:21', '2023-10-31 23:31:21'),
('qGsp4IfjPQY0Bq4wArqT5PvD52LMNY', 'Suscriptor', 1, 'dsvdvvdvdvdvvv', 'cvdvdvd ', 'dscdsdsv@mail.com', 'CC', '4785415', 'Calle 04', 'dosquebradas', '$2b$12$Rtsx7BKUsy1eSalkAaZUkOEESIGI2UXWvdmkNjaAvWa8Z3mUj63EC', 'Activo', '2023-10-30 23:30:05', '2023-10-30 23:30:05'),
('qioeH01FqLon0p0iLdFEO0vXIa07EY', 'Suscriptor', 55, 'pepe', 'marin', 'pepe@dsa.com', 'CC', '145645', 'dsa', 'risa', '$2b$12$ZG.7fyf95AoGKwxSEEWBlusfGussLvLADSZnOAUhVydWVIhrWLuAG', 'Activo', '2023-10-12 14:35:24', '2023-10-12 14:35:24'),
('qODuYQoi3vUfPqoPXJnv3QJB1ajJTv', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comdsa', 'CC', '321312', 'km 7 via armenia - potro rojo', '523', '$2b$12$g60KQiRpIZtizmRzCFKDh.BsQfDN5IiBNMUy.1MF2pech344/vetm', 'Activo', '2023-10-25 23:25:27', '2023-10-25 23:25:27'),
('qrgxIgsxjlLVLNRWK6rMdHIBQiiswR', 'Suscriptor', 52, 'Mayelin', 'maye', 'maye.gomez@misena.edu.co', 'CC', '1008800', 'sena', 'Pereira', '$2b$12$Uy75zzYApsdl4O/JFUXKgu51KDXAGCfYvfFq2uzp2lUSe/E.1ovxm', 'Activo', '2023-10-26 15:01:01', '2023-10-26 15:01:01'),
('qRMenUOKMSQnZtvI6MCK2sZNzZxU5N', 'Admin', 34, 'nfosadhnfiun', 'oiniasfnioanf', 'carlosinfdn@gamil.com', 'CC', '234324325', 'dsadsaf', 'Pereira', '$2b$12$R6zok.RyxBiuwbAtKH/igOukfMGSDIp8ATAs4BigTsWdYprKfVka.', 'Activo', '2023-10-25 14:27:22', '2023-10-25 14:27:22'),
('rxqrqJmEMfM53Lpe22xOtEC6PmqPiX', 'Admin', 34, 'julian Andrés', 'Vasquez Morales', 'midnight3424@gmail.comads', 'CC', '5152112', 'km 7 via armenia - potro rojo', '3das', '$2b$12$m2rE/VGWyCMw9J0UzhEzIeXrsbkX8J4mAC.0Vo/L/NZHuBwCmyUmi', 'Activo', '2023-10-25 23:36:18', '2023-10-25 23:36:18'),
('S5fowRmujucavWCQO3HVo8lFFe8RXu', 'SuperAdmin', NULL, 'Super', 'Admin', 'superadmin@gmail.com', 'CC', '1234567890', 'Centro calle ', 'Pereira', '$2b$12$T8K5qBO/4uTrkQFFGO3piu9tAwE5art9OqZ9amd2qYzLSHaUCEPX.', 'Activo', '2023-09-16 00:10:38', '2023-10-25 15:14:41'),
('tjaY2yXt7fLZxp4GUNozo6B3xWKWuR', 'Suscriptor', 1, 'cvf', 'svcs', 'dccs@mail.com', 'CC', '4455', 'mnnb', 'dosquebradas', '$2b$12$wGQDGPkDEuZBkfAYGhGKmurgb5c98WnaEP8dZVxb2/fH1dPp3dYny', 'Activo', '2023-10-30 23:45:08', '2023-10-30 23:45:08'),
('u0vuVAfaJvFfdf73hlxhgMJU3NUevF', 'Admin', 39, 'Carlos', 'Ramirez', 'carlos2334@gmail.com', 'CC', '108830112', 'cuba', 'pereira', '$2b$12$mPWQpyaAQmgLn1zkVIP8POSCSErKzU2pgvqCVSAbyT0XRYyO7dBBW', 'Activo', '2023-10-19 06:09:14', '2023-10-19 06:09:14'),
('UJYXF2hT2ogNXujRy6WGwbmmMdrDxk', 'Admin', 39, 'Manuela', 'Beltrán', 'manuela@gmail.com', 'CC', '102938', 'cuba', 'pereira', '$2b$12$jh6jCvQkVYnisokbHbXKh.1xrf61Uoy7JjsLdHy6M73/YNhspTp9m', 'Activo', '2023-10-19 05:05:20', '2023-10-19 05:05:20'),
('Uk01J5aU2RoxJauQASKNccMpvtSmK2', 'Admin', 50, 'jose', 'marrique', 'josemanrrique@gmail.com', 'CC', '107707', 'al lao de la ksa de luis', 'Pereira', '$2b$12$EUzcWokJHHFVMlp8pS16EO2yqh4/DxDQ0dLWbXKmlqnA.3BkV4S..', 'Activo', '2023-10-31 19:25:35', '2023-10-31 19:25:35'),
('UObjI2KXuU6J8PNkNUM22ksHlsGt3g', 'Tecnico', 35, 'Juan ', 'calros ', 'gara@gmail.com', 'CC', '3333333333', 'calle 45', 'Pereira ', '$2b$12$pA3VwW6a5ATfXQ4S72w.lO1G4FvHXkK57G.GTak06jYQv5AUNKRAK', 'Activo', '2023-10-19 00:47:51', '2023-10-19 00:47:51'),
('uoQe9wPjFBR2STlUnesufQ8r6AOoMo', 'Suscriptor', 52, 'Diego ', 'Legarda', 'dflegarda@misena.edu.co', 'CC', '1008801', 'Cuba', 'Pereira', '$2b$12$9nAi18CyVRKKw5a24LwopeLDCZtKI8fHrwbwpbLKfgSzpTqdoU5oS', 'Activo', '2023-10-26 15:03:07', '2023-10-26 15:03:07'),
('uVinFpZ9GmRiJBXgSvF9AkHuqWzoj0', 'Tecnico', 1, 'SADSA', 'dsadas', 'asdasd@das.com', 'CC', '123456', 'asdassssss', 'sdadas', '$2b$12$yt6zyAUfKS0qS5TdOcFlL.KL.RnlkMSRyuNAKbX6EZjfUPDPzgUgy', 'Inactivo', '2023-09-27 04:57:08', '2023-10-19 08:21:34'),
('vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'Admin', 47, 'lulu        ', 'henao', 'lulu@mail.com', 'CC', '140004', 'el lagoss', 'dosquebradas', '$2b$12$7Q/K/We8BCoqjOGToLXSx.Ox2VSla4hEx4Qqedk4fhkSEJ8JM7oLa', 'Activo', '2023-09-29 01:17:21', '2023-10-04 10:42:05'),
('vQ6DdnxX9tVgCRsjs3maPZf5ChbbK5', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.com3123', 'CC', '3421321556', 'km 7 via armenia - potro rojo', 'dsa', '$2b$12$EwtKRbspb7pj26UP2.oFVuiza8nWaG8gV3XdqvWtFkGiiREQJGBeO', 'Activo', '2023-10-25 23:29:36', '2023-10-25 23:29:36'),
('vyUkBOCPCao5GMHUmuBjYwNBvDzLcR', 'Suscriptor', 35, 'Winder', 'Roman', 'w@gmail.com', 'CC', '1008810', 'centro', 'pereira', '$2b$12$189jnRIcYhkY3PkuJ12S.OZexyJ.k6nef8cPO61TLdklcU8rEdt6y', 'Activo', '2023-10-25 00:35:56', '2023-10-25 00:35:56'),
('w0g2MKbnJZJ8YkshnC24IRQt7gK0KS', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.com3', 'CC', '321321', 'km 7 via armenia - potro rojo', 'dsa', '$2b$12$KmysvzMhWvFWAj2h.rRyvOZNf7iavitaPMqJViYd7uTZ3EiQi4THO', 'Activo', '2023-10-25 23:17:49', '2023-10-25 23:17:49'),
('WAqvZ5vx72N36C6zc4LwMkoPlvROtE', 'Admin', 1, 'pepe', 'ramirez', 'pepes@gmail.com', 'CC', '9748565', 'pera', 'pere', '$2b$12$pxv2tbDe85cSg8Lf0LluHOoqf9mlayHBdtZx04M8/GdyC4NGZFf4C', 'Activo', '2023-10-26 15:42:09', '2023-10-26 15:42:09'),
('Wmq97LfNhW5nnujfAvD9w70sytgaRx', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.come13', 'CC', '4141', 'km 7 via armenia - potro rojo', 'pereira', '$2b$12$NcSFsp6yY6nSEJU9Q3tO8e1tkeDAjmYlUwKGa2XYnyAnG7GyEYU7G', 'Activo', '2023-10-25 23:34:52', '2023-10-25 23:34:52'),
('wu9IlHZEseniukyJGMAwxu8QjoajMx', 'Suscriptor', 35, 'Mateo', 'Hernandez', 'Matiu@gmail.com', 'CC', '1231231', 'Industrial', 'Pereira', '$2b$12$2i7T7rHY3h1NfhEPCRv75uWv6pTSZDSoTu4s3f4dnxC5pIiulXtMm', 'Activo', '2023-10-25 00:37:16', '2023-10-25 00:37:16'),
('WunrxuyKUzO3NzLa4MxZ1UkpGTU7lx', 'Suscriptor', 91, 'Santiago', 'vergara', 'santiagovergarafranco@gmail.com', 'CC', '12345678', 'Calle 30', 'Santa Rosa', '$2b$12$LH60HxwRUuw6q.Y.NeYI0..TfZ5wckVPavHjODoM3K4IkeHvxFuMe', 'Activo', '2023-10-23 20:50:53', '2023-10-23 20:50:53'),
('xPf2ZUjWzXocVn4H1PmYQGBuGKbWaI', 'Admin', 37, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comdas', 'CC', '4178545645', 'km 7 via armenia - potro rojo', 'dsadsa', '$2b$12$jc8jZlbGvPwtRzCOf7Dq3uHBtPSQWOVUAVAHMQ7LTLCjiOJv1Gjvi', 'Activo', '2023-10-31 00:00:57', '2023-10-31 00:00:57'),
('XU8z2R0foWHrVQDg8pY28aaNwtZnRs', 'Suscriptor', 48, 'Esteban    ', 'Mesa', 'asdkasjdja@playcell.fun', 'CC', '1007212784', 'Calle 8', 'Pereira', '$2b$12$SrdPmZxYDM3y0EerRx6/5eeyHJRMCfRps5udch3Nu5utnQi7QFaqO', 'Activo', '2023-10-03 21:39:53', '2023-10-03 22:28:09'),
('XzVMtcAhpAQiEw5NDhMqCluQpEzOti', 'Admin', 34, 'Julian Andres', 'Vasquez Morales', 'julianvaskes12@hotmail.comdsad', 'CC', '321332131', 'km 7 via armenia - potro rojo', 'das', '$2b$12$8yRsnABFt6waBsw2PWE9/ORzHofSwT/3bTqLuyqkFVIGwYsc6ucpW', 'Activo', '2023-10-25 23:25:13', '2023-10-25 23:25:13'),
('yT2ioL9UZhCEhFpnJz5K0VhpPyIdY5', 'Tecnico', 2, 'Windows    ', 'Ro', 'aliasrastastas@gmail.com', 'CC', '108809', 'calle 7744', 'Pereira ', '$2b$12$JXt6u7141/DBC7Rm.ZG58ubW/Wgi7NG4iylsyWOtDVTI1ZFKjtdbW', 'Activo', '2023-09-17 13:36:56', '2023-10-25 20:40:55'),
('zrBvnmvA44HOIFv9ehGsYLNqMXbOhv', 'Admin', 84, 'admin', 'admin', 'david2013mip@gmail.com', 'CC', '456', 'Allí', 'Pereira', '$2b$12$c4NrgChgjhp0Za0VTBpFb.Ng7bSbPehyEuBEI17v0HkCq6jLmL9HO', 'Activo', '2023-10-19 00:17:58', '2023-10-19 00:17:58'),
('zrfGXKmHGTSK6DRnu65LWXdEP8wZSR', 'Admin', 35, 'usuario', 'adso', 'usuarioadso@gmail.com', 'CC', '1007', 'aqui', 'aqui', '$2b$12$LJOwGbxt7FuE2ljbrwRohes3xc3XkBA4PD72ug9m.hTwVAfbBIObW', 'Activo', '2023-10-22 19:24:06', '2023-10-22 19:24:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `variables`
--

CREATE TABLE `variables` (
  `id_variable` int(10) UNSIGNED NOT NULL,
  `pregunta` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `variables`
--

INSERT INTO `variables` (`id_variable`, `pregunta`) VALUES
(1, 'NOMBRE DEL PROYECTO'),
(2, 'CLASIFICACION DEL SUELO RURAL'),
(3, 'NUMERO DE VIVIENDAS'),
(4, 'FUENTES ABASTECEDORA'),
(5, 'INGRESOS PROMEDIO POR FAMILIA'),
(6, 'PERIODICIDAD DEL INGRESO'),
(7, 'DISPONIBILIDAD PARA EL PAGO DEL SERVICIO DE ACUEDUCTO'),
(8, 'AÑO BASE DE DISEÑO'),
(9, 'POBLACION RESIDENCIAL'),
(10, 'EXISTE UNA INSTITUCION ESCOLAR'),
(11, 'NUMERO TOTAL DE ALUMNOS'),
(12, 'NUMERO DE ALUMNOS NATIVOS'),
(13, 'NUMERO DE PROFESORES'),
(14, 'NUMERO DE ADMINISTRATIVOS'),
(15, 'POBLACION FLOTANTE'),
(16, 'NUMERO ESTIMADO DE POBLACION FLOTANTE'),
(17, 'ALTURA PROMEDIO SOBRE EL NIVEL DEL MAR DE LA ZONA ATENDIDA'),
(18, 'ALTURA SOBRE EL NIVEL DE MAS DEL PUNTO DE CAPTACION'),
(19, 'CAUDAL MEDIO DE LA FUENTE'),
(20, 'CAUDAL MINIMO DE LA FUENTE'),
(21, 'ALTURA MAXIMA DE CRECIDAS'),
(22, 'TEMPERATURA MEDIA DEL AGUA'),
(23, 'ANCHO MEDIO DEL CAUCE EN EL PUNTO DE CAPTACION');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `datos_variables`
--
ALTER TABLE `datos_variables`
  ADD PRIMARY KEY (`id_empresa`,`id_variable`),
  ADD KEY `id_variable` (`id_variable`);

--
-- Indices de la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id_doc`),
  ADD UNIQUE KEY `id_doc` (`id_doc`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`);

--
-- Indices de la tabla `inmuebles_suscritor`
--
ALTER TABLE `inmuebles_suscritor`
  ADD PRIMARY KEY (`id_inmueble`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `lista_asistencia`
--
ALTER TABLE `lista_asistencia`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_reunion` (`id_reunion`);

--
-- Indices de la tabla `reuniones`
--
ALTER TABLE `reuniones`
  ADD PRIMARY KEY (`id_reunion`),
  ADD KEY `reuniones_ibfk_1` (`id_empresa`);

--
-- Indices de la tabla `servicios`
--
ALTER TABLE `servicios`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id_token`);

--
-- Indices de la tabla `trazabilidad`
--
ALTER TABLE `trazabilidad`
  ADD PRIMARY KEY (`id_trazabilidad`),
  ADD KEY `id_empresa` (`id_empresa`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD KEY `empresa` (`empresa`);

--
-- Indices de la tabla `variables`
--
ALTER TABLE `variables`
  ADD PRIMARY KEY (`id_variable`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id_doc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=127;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT de la tabla `inmuebles_suscritor`
--
ALTER TABLE `inmuebles_suscritor`
  MODIFY `id_inmueble` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=99;

--
-- AUTO_INCREMENT de la tabla `lista_asistencia`
--
ALTER TABLE `lista_asistencia`
  MODIFY `id_asistencia` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `reuniones`
--
ALTER TABLE `reuniones`
  MODIFY `id_reunion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=229;

--
-- AUTO_INCREMENT de la tabla `trazabilidad`
--
ALTER TABLE `trazabilidad`
  MODIFY `id_trazabilidad` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `variables`
--
ALTER TABLE `variables`
  MODIFY `id_variable` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `datos_variables`
--
ALTER TABLE `datos_variables`
  ADD CONSTRAINT `datos_variables_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`),
  ADD CONSTRAINT `datos_variables_ibfk_2` FOREIGN KEY (`id_variable`) REFERENCES `variables` (`id_variable`);

--
-- Filtros para la tabla `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `documentos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `documentos_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `inmuebles_suscritor`
--
ALTER TABLE `inmuebles_suscritor`
  ADD CONSTRAINT `inmuebles_suscritor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `lista_asistencia`
--
ALTER TABLE `lista_asistencia`
  ADD CONSTRAINT `lista_asistencia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`),
  ADD CONSTRAINT `lista_asistencia_ibfk_2` FOREIGN KEY (`id_reunion`) REFERENCES `reuniones` (`id_reunion`);

--
-- Filtros para la tabla `reuniones`
--
ALTER TABLE `reuniones`
  ADD CONSTRAINT `reuniones_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`);

--
-- Filtros para la tabla `trazabilidad`
--
ALTER TABLE `trazabilidad`
  ADD CONSTRAINT `trazabilidad_ibfk_1` FOREIGN KEY (`id_empresa`) REFERENCES `empresas` (`id_empresa`),
  ADD CONSTRAINT `trazabilidad_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios` (`id_servicio`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`empresa`) REFERENCES `empresas` (`id_empresa`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
