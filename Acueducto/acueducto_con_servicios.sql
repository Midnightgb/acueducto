-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2023 a las 02:59:54
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
(77, 'S5fowRmujucavWCQO3HVo8lFFe8RXu', 'P01-F-03_Estatutos_Asociación_Suscriptores324', 1, 'pdf', '2023-10-12 01:10:58', '2023-10-12 01:10:58', 'ArchivosDescarga/Generados/P01-F-03_Estatutos_Asociación_Suscriptores324.pdf'),
(78, 'S5fowRmujucavWCQO3HVo8lFFe8RXu', 'P01-F-02_Formato_Contrato_Condiciones_Uniformes324', 1, 'pdf', '2023-10-12 01:11:06', '2023-10-12 01:11:06', 'ArchivosDescarga/Generados/P01-F-02_Formato_Contrato_Condiciones_Uniformes324.pdf'),
(79, 'S5fowRmujucavWCQO3HVo8lFFe8RXu', 'P01-F-06_ActaConstitución324', 1, 'pdf', '2023-10-12 01:11:11', '2023-10-12 01:11:11', 'ArchivosDescarga/Generados/P01-F-06_ActaConstitución324.pdf'),
(80, 'A6KVicufAR97hSwVInYRu1eaiXQfQ8', 'P01-F-03_Estatutos_Asociación_Suscriptores333', 1, 'pdf', '2023-10-25 00:33:58', '2023-10-25 00:33:58', 'ArchivosDescarga/Generados/P01-F-03_Estatutos_Asociación_Suscriptores333.pdf'),
(81, 'A6KVicufAR97hSwVInYRu1eaiXQfQ8', 'P01-F-02_Formato_Contrato_Condiciones_Uniformes333', 2, 'pdf', '2023-10-25 00:34:04', '2023-10-25 00:34:04', 'ArchivosDescarga/Generados/P01-F-02_Formato_Contrato_Condiciones_Uniformes333.pdf'),
(82, 'A6KVicufAR97hSwVInYRu1eaiXQfQ8', 'P01-F-06_ActaConstitución333', 3, 'pdf', '2023-10-25 00:34:08', '2023-10-25 00:34:08', 'ArchivosDescarga/Generados/P01-F-06_ActaConstitución333.pdf');

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
(1, 'Empresa Prueba', 'Centro', '3201234567', '3201234567', 'empresa@gmail.com', 'Inactivo', '2023-09-16 00:09:33', '2023-09-27 04:52:34'),
(2, 'Empresa Adso', 'Carrera 8va calle 26', '3322889900', '3344556611', 'empresaAdso@gmail.com', 'Inactivo', '2023-09-17 00:12:18', '2023-09-27 01:27:13'),
(34, 'Apple', '123 Apple St, Cupertino, CA', '1234567890', '9876543210', 'info@apple.com', 'Inactivo', '2023-09-27 01:22:18', '2023-09-27 01:27:07'),
(35, 'Microsoft', '456 Microsoft Ave, Redmond, WA', '9876543210', '1234567890', 'info@microsoft.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(36, 'Google', '789 Google Blvd, Mountain View, CA', '5551234567', '5559876543', 'info@google.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(37, 'Amazon', '101 Amazon Dr, Seattle, WA', '121221221', '121221221', 'info@amazon.com', 'Inactivo', '2023-09-27 01:22:18', '2023-09-28 04:51:08'),
(38, 'Facebook', '246 Facebook Ln, Menlo Park, CA', '4445556666', '8889990000', 'info@facebook.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(39, 'Samsung', '321 Samsung Rd, Seoul, South Korea', '1110001111', '2220002222', 'info@samsung.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(40, 'Intel', '654 Intel Blvd, Santa Clara, CA', '3334445555', '6667778888', 'info@intel.com', 'Activo', '2023-09-27 01:22:18', '2023-09-27 01:22:18'),
(41, 'AWS', '789 Adobe Ave, San Jose, CA', '2223334444', '13131231', 'info@adobe.com', 'Activo', '2023-09-27 01:22:18', '2023-09-28 03:37:51'),
(42, 'Sony', '789 Sony Ave, Tokyo, Japan', '1112223333', '4445556666', 'info@sony.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(43, 'HP', '456 HP Rd, Palo Alto, CA', '7778889999', '1112223333', 'info@hp.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(44, 'Dell', '123 Dell Ln, Round Rock, TX', '5556667777', '8889990000', 'info@dell.com', 'Inactivo', '2023-09-27 01:22:57', '2023-09-27 01:27:30'),
(45, 'IBM', '789 IBM Dr, Armonk, NY', '3334445555', '6667778888', 'info@ibm.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(46, 'Oracle', '101 Oracle Ave, Redwood City, CA', '1234567890', '9876543210', 'info@oracle.com', 'Activo', '2023-09-27 01:22:57', '2023-09-27 01:22:57'),
(47, 'Cisco', '246 Cisco Rd, San Jose, CA', '2223334444', '2223334444', 'info@cisco.com', 'Activo', '2023-09-27 01:22:57', '2023-09-28 02:50:48'),
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
(86, 'a', 'a', 'a', 'a', 'papaniel2145212@gmail.com', 'Activo', '2023-10-01 19:52:16', '2023-10-01 19:52:16');

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
  `numero_residentes` tinyint(3) UNSIGNED DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `inmuebles_suscritor`
--

INSERT INTO `inmuebles_suscritor` (`id_inmueble`, `id_usuario`, `direccion`, `estrato`, `uso`, `numero_residentes`, `create_at`, `update_at`) VALUES
(3, 'ek1t2Ga9jAKnwthvl2fFPQ3WqnVFiZ', 'Transversal 3 #5A51', '1', 'Doméstico', 2, '2023-10-04 02:49:09', '2023-10-04 02:49:09'),
(32, 'Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Transversal 3 #5A51', '1', 'Doméstico', 1, '2023-10-04 04:37:36', '2023-10-04 07:41:06'),
(33, 'Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Mirador jajaj', '1', 'Doméstico', 1, '2023-10-04 04:41:52', '2023-10-04 04:41:52'),
(65, 'XU8z2R0foWHrVQDg8pY28aaNwtZnRs', 'calle 21', '1', 'Doméstico', 1, '2023-10-04 07:40:11', '2023-10-04 07:48:47'),
(67, 'XU8z2R0foWHrVQDg8pY28aaNwtZnRs', 'charli mks', '1', 'Doméstico', 1, '2023-10-04 07:43:54', '2023-10-04 07:47:50'),
(68, 'DeeMeNbrzGWgsJaTYfFAXkxCy0WWrK', 'casa de diegueline', '4', 'Doméstico', 4, '2023-10-04 07:59:02', '2023-10-04 07:59:27'),
(70, NULL, 'casa de charli', '1', 'Doméstico', 0, '2023-10-04 09:58:15', '2023-10-04 10:05:56'),
(71, NULL, 'casa de diego', '5', 'Institucional', 0, '2023-10-04 09:58:25', '2023-10-04 10:11:18'),
(73, 'vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'via armenia', '1', 'Doméstico', 4, '2023-10-04 09:59:53', '2023-10-04 09:59:53'),
(74, 'vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'dasd', '1', 'Doméstico', 5, '2023-10-04 10:01:39', '2023-10-04 10:01:39');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reuniones`
--

CREATE TABLE `reuniones` (
  `id_reunion` int(10) UNSIGNED NOT NULL,
  `id_empresa` int(10) UNSIGNED NOT NULL,
  `nom_reunion` varchar(120) DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  `url_asistencia` varchar(200) DEFAULT NULL,
  `cuorum` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'estatutos', 1.1, 1, '2023-10-11 23:39:29', '2023-10-24 23:16:51'),
(2, 'Contrato de condiciones Uniformes', 1.1, 1, '2023-10-24 23:20:13', '2023-10-24 23:20:13'),
(3, 'asamblea de constitucion', 1.1, 1, '2023-10-24 23:22:44', '2023-10-24 23:22:44');

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
(88, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MDUwMTZ9.1mtb30RLkuHbBLzRAABRUXCdOtniipzNO9RBDU6HWCk'),
(89, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MDUwNzB9.1YMYR-E5BkKhyFJNwmbHX-xKjV6KmOemVy2-j6Xm4yc'),
(90, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MDUxNTl9.7ma9AYuunv9gVl5cOGf8Ou89NNeVA7rz3OT081g2ukg'),
(96, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MDcxNDl9.Cu_Lna72F1Njwmc72QeoirDUPdUlT6QK8YxL6z392Fo'),
(102, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MjAzMzh9.XClIny4xO4HDI7tjNwHh6nL6L87eJfxeQrK-J0T2vOk'),
(103, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU0MjEzNzR9.WhPlyP4eCuN2kBWL_VJw-un2eglMZYsqo4CGjm3rg_4'),
(106, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NTQ3MDB9.s8rA0Kz1n-b2dW583QhZAmnuHU5RfckPiJqk2_1RYNc'),
(110, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NTU5Mjd9.Wa6lpZGXAjWJddeBpnNpxuL2en7Wadi04-uYj5kRtzY'),
(121, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NjQ4NzN9.nEgEAyad50Q7jFKvEPQecLxQcx5kWlO0jdkBACGmAe0'),
(125, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ekVhVTZUMjQwYzNUM3lqcDE0eUREU2NwQ3VQVXoiLCJleHAiOjE2OTU2NjY4ODB9.s7goq16VuitKacFEG_Rc9dy2MXQ4bz_rW3Jci8sx3yo'),
(128, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NjcyOTV9.WhJ5e2UiVlKaS7kggIP9FQIxgBpxqLqCqKuzxmuvCcQ'),
(131, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NjkzNTJ9.EbZ5IKe5A5PGsD3_CHtWmxqD0t9nLDZoPbDSUU5FNoY'),
(135, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NzE2MzV9.WYOQX-urM7JNoIk7rA3n0Q7TmfyzpZcHuWHG_NQu1Iw'),
(136, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NzE2ODh9.rjjPY6sAb2HSR08ipkQNOC_pP9p6IbW6IHQ9yv-0T58'),
(137, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NzI0MTd9.b83xA-xBnlyw-E5ULF9nNjnGanF9JUeFX73M5xBFkGk'),
(138, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2NzMyMDl9.e4akBmSxAY_jx_FZ98FB0BsPo9YYpOdAz7-ck2SqlTI'),
(141, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU2OTg1ODZ9.vbxfY7YCYF4ay5s24mykainsSRAFka6-H1hxEvQJSwM'),
(146, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3MDI1MTh9.5PjtN-DCHemlp4ZJbzDSeO3g0DDIUAT4d56M16AwSjM'),
(153, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3MDQyNDV9.l-iJfvlhnICz7H9-6VhItVgN032UGz9jb8bf2zzziAg'),
(154, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3MDQ0Mzl9.kPKgvp8KMh7NqjRk9g_-8Qm7Jgw5sdchbsRgJPgRxi8'),
(156, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3MDU4NzJ9.stnkNk9sxWajU9KNdf1aRHLCk3rz8o96I48emPOfEdE'),
(162, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3Nzc0NjN9.ngsERhTt4GiozeFUO4CJXx7JLsPaMEUoYH-eT8g2Vbs'),
(181, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3Nzk2NDZ9.bqf8VWy5OsFtPCe7b1uG2vqPH-GW1nvZ2qp12yS8q2I'),
(188, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODAyMTF9.nlyk4eXVSYmfSmtKqozEvIXCguJQs07_27sX0CqhALg'),
(190, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODAyNDR9.XzPeoFpY46KgyiJ16fOIaYlxHJXKwEx5eqaIUkit93Q'),
(193, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODA0MDV9.rnt7JeC4zLv2Q9368AmL6snRzmYBkJdO0XaRKut4NUE'),
(195, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODA2NTV9.BhXFKuYEiaT7HhIfs5pxsjo36lXJWKRT3PWOIk6rzm0'),
(196, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODA2ODV9.6hPi6fzSBo3fst9tr5HhcMfsZshegNKREGhocGvOHa0'),
(209, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODE5NzJ9.-HEr0iV0KAuXtiAYfFzwVS48NU6CSMl5N8Gusw7kMeo'),
(214, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODI0MTJ9.RvVbfXj5qDbMLabGz4aXA_NBbFSW2NH87kqO30sEGz4'),
(219, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODMxMDN9.M_e2DoypBcoaKJmz6Rj8iPKcWpzcP-u5Gc_mniuf8-U'),
(220, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODM1NTN9.250TIAsUdLyePRlwp1e243bbjes_PSFGwQU_CteeeRw'),
(221, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODQ2MDl9.J1kz6NSq1oSE5nwY5bUvRl5Dt2M6mhbSERjIr4N-bzI'),
(223, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODUyMzl9.rsjMgeOdczZJr1zGngDVr49cHdOWNIqLbY-TZnshdLg'),
(224, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODY3NTN9.tyRkgLS9eJAkMxyzPMXAXCUrZ5euw_RwR4L9stwJqoE'),
(225, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3ODczMjJ9.g1bH8D50zvJqGt-ZFNO-VD3p9p13RqBr2o9sXhenOCA'),
(229, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3OTE4MjJ9.9Gdw_YBV3jGTnuw6S7Vrir3o_-2v62zM3rTvrM_r1Z0'),
(231, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU3OTE5ODd9.XyQ5bKzY7lSGyAVMOzhIvxXqZNcBO-ZA2QEZm9hBmOY'),
(232, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4Njc1MTV9.fgvGbN_ZkwDhHr36dFmk9Afo6P4BHG7taBrC4XYDsgQ'),
(234, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4Njc2Mzl9.ZC4T5w_sOH796wEHSXeWUf4iIoptfy3DWMlJQ72U4I4'),
(237, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NjgwNTZ9.FrkMQ5mBtXtcMgWGFumUf5oTpL8TCAxn35HY1Y96uDc'),
(249, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzM3NzB9.vIu7bUgmixgR-pVH9DZAlXq1QkVL7iR8Pi1i9ZUiaws'),
(250, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzUzODZ9.NZRyzOHksOdgMhokL4e8KrJoiBkjTnIcifyp-ChQryY'),
(251, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzY0OTl9.c20xvoKRfclrCW_bxb9XEk_m_UH1H-s7UyBzZpAlfXM'),
(253, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzcyNzJ9.1Vgt5BdX3265VQk7l9Q7a3YModFm54hFr-LiKtYPgpQ'),
(254, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzcyNzd9.ogOXaywYeoDiO5Xp-0QmIguDluCsVC-Qj-Qn0ZsDwDk'),
(255, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4Nzc4MTN9.hWzTtApi11-X_8ViSyDBMlNDLBbQ5mYpLL3afDiTQEo'),
(256, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4Nzc4Mjh9.OLoB9Rb7iDmybGdAM7LmihMAMNeyDR5KNnCRE5r7oc4'),
(257, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4Nzg2NDF9.hOT_wYCcCj_aFZ1fIvp3gbu1mttA0EFquO0makI4ZBc'),
(258, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4NzkxNTF9.jWKWdZtLoCsiefUeGuJ_0L0GrK8d-jx2FPwg9-N9Dk0'),
(260, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU4ODc1MDd9.5YPaA0-OJrukUPo4FSHvo0KngWHO1OzskAnsEz_EWHI'),
(263, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5MDcwNjJ9.Z6Ng6AjDmdZPNz9KHEkSqL44a8-HU0W8Zdr1RqKOJFQ'),
(264, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5MDcyNTR9.9zjmXtV9EacbnM6k0TRleOtNMYY3Db_gD_dK5ybt_Cc'),
(265, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5MDc2NjB9.hJXFXFZBo7WPWXrhwKnJlGal9a5jEXB4CoXTxOod4CI'),
(266, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5MDk2MzJ9.B_vTAHG0NyAB_IKxv4Dko9Q-6Zz6sxCv4V2OQsun2L0'),
(271, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5MTAxOTZ9.l8wA3JO49uCTF0cDfgHBKn3TSRO8_O0DmyKHjytKZiY'),
(273, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NDY0Nzd9.9Qz8YdkjxMc-quiyASQfbY1cmty6lH0kG7UGhvqwLk4'),
(278, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2SmdOa2Q0UjlTRVNIbGh6YzdLaVlXaDFwbURuTVYiLCJleHAiOjE2OTU5NDcyNTh9.K--Gl4gKSiWtyKZgjRNbu3V2a4cLGcMwJZZUSX-4Mow'),
(279, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ekVhVTZUMjQwYzNUM3lqcDE0eUREU2NwQ3VQVXoiLCJleHAiOjE2OTU5NDczNDB9.pVDoO7eZ7UEGEXEEcbNqRqXT6i_gsJ22pff9aHHAmcY'),
(280, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NDc4OTB9.KMIBSSySmCbmDcg1COMHuofUE-4OxU39vWNmZ8Hyvks'),
(282, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ekVhVTZUMjQwYzNUM3lqcDE0eUREU2NwQ3VQVXoiLCJleHAiOjE2OTU5NDg5NTV9.bPOEdkKQP23FlF6_iM0gPrCUSi-1X8DE8qdsKDeAZMk'),
(293, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NTE5ODJ9.h9E_reUUpn204oJ73OG7eRmp8JWnK2HhGf4_zsd2WAw'),
(294, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIiLCJleHAiOjE2OTU5NTMyNDl9.98vY30yXVsOiP0COgR6wsBWqkklUwpvrplxosztmkdc'),
(295, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIiLCJleHAiOjE2OTU5NTMzNjd9.2gWpQbkkqqV3ICVZZxZp6dzNt0jnqkTtrO73TnKxsfY'),
(297, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIiLCJleHAiOjE2OTU5NTQ4ODR9.VflQpvW3dIKyfLE10LwEoPeKJB7YdRbiB3LlHncIAjM'),
(298, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIiLCJleHAiOjE2OTU5NTQ5MTB9.Q8UvNf4UzDStFDiTmcJHDbE5agFmLR-IZlQRJd1ck_4'),
(301, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NTU1MTF9.uKNJhlIPXMG_z402yePc81ciYY6nofTobTjmbvvnG3w'),
(302, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NTU2NjZ9.V8k_BlnY0tAKZJtv0xQjqsAA-PWYSFPgvSKlU9vNG7E'),
(307, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2SmdOa2Q0UjlTRVNIbGh6YzdLaVlXaDFwbURuTVYiLCJleHAiOjE2OTU5NTg3ODl9.bOi1329S2Pvx0RRWBHY0qisimkv12D_xTIXvKoBfeFk'),
(309, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NTk1NjZ9.Xxjb6rE0X9kPfkLZiPFx2L4lc9Qs2QUGEkketcrGdLA'),
(311, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjAzODR9.bXNflFKYok77k8RUAgGQHPnHk63u5iPbLEJOHxg-6ZM'),
(312, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjA0MDh9.keisC4wlQHo-gqMxtwDf9G71EOOe7CDfrct7rLYl-Ws'),
(313, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjA0MTl9.x-AsPKo0H-1kkFYDRwgcLU7gnhzXQGJh4igPeQTHKg8'),
(314, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjA0MzV9.0Uj0z1iUFVjP9xalU3QuaPyPfeACt19hpFnMqQuPubc'),
(315, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjE0OTR9.68ttbL3kWx9sRORkR9_hG_XC15tZWf6O3LLnEPl_q9s'),
(316, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjMyMDR9.BdnwVotPRlxggSXLhMSA_6EQ7cYkLIFzJCKMFzypO9c'),
(317, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjMzNzJ9.YCBZo0pnadcu6-N6LMj0gDW0VeQiUY0iBvk3w6f_9so'),
(318, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjQxOTB9.mzZYq0S13SPfki9d8UX6V8MYBBf63cf3j22Vi8n1UtQ'),
(320, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjUyMTh9.NWaRc2YJhsMMv8-3C8AG_jEnzL2ttQNufJmQNYkdYVo'),
(321, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5Njc5NTh9.8bg0u0iIQM3ijnIWTTj_HWgBUsnZvdeMo1aSCNzj1Ig'),
(322, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjgwMzF9.6REKU3FA8ei3g0VEuXVejB_IF5i3comQ2ypMfncYMsg'),
(323, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTU5NjgyODZ9.p2HBF8-NcPt3Eb581PpzAtBSNRU_eAjFMl0LBKYm3ZQ'),
(326, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTM2MjF9.78DCCjDPsbKPQ3wy5taFmPaw1CJ5GqwqTS5rHzUK5uw'),
(327, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MjR9.S2tqH4uRF14G3_81FI1LEA8rymHXJNBcjUpaX1c1wNQ'),
(328, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MjR9.S2tqH4uRF14G3_81FI1LEA8rymHXJNBcjUpaX1c1wNQ'),
(329, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MjV9.h-4MwFkT2FLBGVSxzRh45rXo69yofDReAaoxilF4g80'),
(330, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mjd9._lFpnjircSN_D389ew3bE_DvLL-1peTFED9itZpHIIA'),
(331, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mjh9.X8akpkR9wJ26yjXQcCCe0v2rvKwDJiDPW8qx0rWyD-U'),
(332, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mjl9.BZ-asTlucsCXd7n657cSJYUk4ZMQC9UmRIkM0KC5AO0'),
(333, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MzB9.5PWore709RChg4ywXADlwktkBtqJUXUGimI8QGMOvj0'),
(334, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MzF9.W20M5CgDLs14uYiUeuStgqdLb8QppvHsFSgNpb9IynI'),
(335, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MzJ9.qvhTnwm6kiXr2IOGam58Yyhn8NX0rFM37j6hEz5kTrk'),
(336, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MzV9.WavJSUOZULMXhhn8faMu_vbHF54-Mv0U6FMEBHrk8N0'),
(337, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4MzZ9.SeJYlDu5GXoPmYcR62DQ_ap28cLd_nLUPGaANwLRVBQ'),
(338, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mzd9.bKh31zuORxOhrGEICfIdOPha9347VV0XcdB08zNGmF8'),
(339, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mzh9.Ba0Hk7zjgl0pszuZ-2jmh9zzsIMTXa6B4GDF8Kv83Xg'),
(340, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4Mzl9._3CTm6RvqQcjE3Lwft-5Mf9A4Hjczl_OTsOuGAORojU'),
(341, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDB9.xnSmWoLTiWYzJs6eD9Bqnz3yUM_SWj0MjbpGX_YQ2R4'),
(342, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDF9.aGTrBjv_n2xySfxCbIANgnntOsBRdCmV9KN0_HRyWvQ'),
(343, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDN9.Zu2vLxs39zzMjfTPqXyNtnRz23PfCM_BsyyLvrZRkbM'),
(344, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDN9.Zu2vLxs39zzMjfTPqXyNtnRz23PfCM_BsyyLvrZRkbM'),
(345, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDR9.QYAWPnAH7heTo5TRpEK5bRPgDzCspVVPzbgkelL_xAA'),
(346, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTQ4NDV9.w-slcR4TufwFXQOUVN4oARPuv5CGLZPgeFieUHm1U5U'),
(348, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTc5NTJ9.ePQwF3CE8GKDl90TcEve_2lRerqqris1LXTMxwLz0wI'),
(349, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTgyNjl9.855GooFHpbhN5RumWiihSWGrKgElvwqXjjX1ES80_w4'),
(350, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYwMTg1MDR9.r5HStouXJ617MeUHaf4_TdhPwZt1FOTcBxJ_Efqqubg'),
(353, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYxOTI2MTZ9.ORENv9d6n1-whzPrRQKji8LUWOm-XGcEHpsNie2fvJs'),
(354, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYxOTI4MzZ9.wDxwIUb_15qAW-sietaDshWIM5sw52nuW_rhl85Wxz0'),
(355, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYyMTg0NDJ9.uOXO1FocfHtb4kd6bssMDv-k_VNzhQfO_W4sO1quZOA'),
(358, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNjUwODl9.c09gJma6qUFg0ftjkp7gLj54NbI46vAY6US9L61qCdQ'),
(359, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNjU2NTB9.NWcOspAW7uy95BK1pYi_HJ7GigvlJ711WKWcYiKfkf0'),
(367, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNjg3MjJ9.b7vXLEMBwmNthxFnuignQW8obPGLSTZJxjI_zI7ATw0'),
(369, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzAzNzh9.LwJCjAINJtP1oWJo5nqU6SE_gyjfyXPVfqrCZwICneE'),
(370, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzA0MDl9.DjZpz_D3tMeLmyUUJ6R08KdWo3isjAJ3nft8ZwDhcA0'),
(371, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzA0MjZ9.0C0w6zxiykD-J3czd9GbpTGE4KLUCEscWAk57QBQ2ME'),
(373, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzA2NDJ9.CFpppkqqvHXWJU0rv71JGoc5jNGIcTjBbtoll_x1Nl8'),
(376, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzA4NTl9.Y1SPcWAZlYR3k4LwXBECDLX8w83e_HUjatpJQQrgNhI'),
(378, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzA4Njd9.vIoKu-OoUuEzNGOEpjIsGjfqFmdxdSdGoiBp52jvhjQ'),
(380, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ekVhVTZUMjQwYzNUM3lqcDE0eUREU2NwQ3VQVXoiLCJleHAiOjE2OTYzNzEwNzh9.pMxlUYhZ7tHJeQbbR4mFrrJ5njouFs1uQyGZsGpeiok'),
(381, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI5ekVhVTZUMjQwYzNUM3lqcDE0eUREU2NwQ3VQVXoiLCJleHAiOjE2OTYzNzEyNjV9.oi1Z7sRodVLahnFAViy48WzHp8JMN9vnwIfYwkpDVBU'),
(383, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzUwNDd9.OwTXOTEpnNYBR6xvj2sK_gCZ7n1-ogeAMcYoHvt6T8U'),
(385, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzYzNTN9.2LBTRQskE4gWmH9-xuUxFfZLKF0FmxIcyD7clkjJAzU'),
(386, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzNzg1NTJ9.RGQCZMWEvFZK1RyLYac0fn7LeMshDyOAS-bMdZnSl9k'),
(387, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJOc2N1M29hcjdVUW1Cc2ZoWFFpdVhRM3ZHZk84REoiLCJleHAiOjE2OTYzNzkxMDJ9.et5wLvpJEiEeKW3IFPuxwATCGT-sgIo2-qEv9U62eXc'),
(388, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzODAzMTl9.10nOYXdaC2xChbxdF-FkN9Ydbz6FseHHjbWtbmeAmtk'),
(391, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTYzOTI3MTd9.7Mnvaktk-oaINK35fg7M1meKSpsZ8z6BVQcptDbWVj4'),
(402, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTY0MTQ5ODJ9.NalL0uYxRdXfbJNjHN4ZaJ2JMjt1QB37YEcsd-_EUGQ'),
(403, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTY0MTg0NTV9.G1j9tcC02iUC8pj8PaJKkQckVxZjiDXclP7X20EfCIM'),
(404, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTcwNzA4NjV9.74UGlY_jQQNO_Cl9IAlhtBLiCLvqp58f70lDU1Xn150'),
(405, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTcwNzEwNTd9.FYZdRp3V3yVdJ1QA6qfQPVJuRqAA-S-LuEN8umNYzqk'),
(406, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTcwNzEyMTJ9.iDSOMRaq8u98aMOQbvsn6JwFerb3M7DPeacuEnXul8w'),
(407, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTcwNzUwMzF9.T9_RrJOlqXuh7OCn3zeET0Itx_nPYKCScVguN0LlaKs'),
(411, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJTNWZvd1JtdWp1Y2F2V0NRTzNIVm84bEZGZThSWHUiLCJleHAiOjE2OTgxOTg3Mjd9.P6ZI2QKpntTLZheJtrCVyN07QhdrJZkTBnngGEzq90w');

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
('A6KVicufAR97hSwVInYRu1eaiXQfQ8', 'Admin', 35, 'luna', 'rave', 'luna@gmail.coom', 'CC', '1111', 'aqui', 'tapaquira', '$2b$12$cIbhjKkSKmdRXutz/I.tbO8FEKAWXaOQcQOr9gTZRqFEHmanGFHyu', 'Activo', '2023-10-25 00:31:26', '2023-10-25 00:31:26'),
('AbmAnw9dqhuwJ7f8tSXX1V7NypLhWe', 'Tecnico', 50, 'andres', 'gomez veltran', 'veltran@gmail.com', 'CC', '106745346', 'calle 21 # 23', 'Pereira', '$2b$12$IGV1R1WZn.LawePCuhqFXuIUcs/OIDW.7DXRnzNvdn9SBuccodNoi', 'Inactivo', '2023-10-04 02:02:08', '2023-10-04 08:41:01'),
('CwofYEpdpqG9elm14Ph3DkfeRpzQ3h', 'Suscriptor', 1, 'Esteban', 'Mesa', 'papaniel21asdasdasd5@sgmail.com', 'CC', '234234423423', 'Transversal 3 #5A51', 'Quinchia', '$2b$12$sPCRSpyLbV7LbLyFJ6oSnOI6TPOoUqRneK8G8OIuAdlFTKAmnz56C', 'Activo', '2023-10-04 02:45:42', '2023-10-04 02:45:42'),
('DeeMeNbrzGWgsJaTYfFAXkxCy0WWrK', 'Suscriptor', 80, 'diego    ', 'legarda', 'diego@legarda.comm', 'CC', '216489', 'pereira', 'pereira', '$2b$12$NtZ/9wd5KUX4pTtZAU8ZJOk5RSf2UvV/s2an4ig91IvOeYqmR1NJ6', 'Activo', '2023-10-03 20:35:56', '2023-10-04 08:01:08'),
('ek1t2Ga9jAKnwthvl2fFPQ3WqnVFiZ', 'Suscriptor', 1, 'Esteban', 'Mesa', 'papaniel3434342145@gmail.com', 'CC', '34234234', 'Transversal 3 #5A51', 'Quinchia', '$2b$12$n9.NEO/yflrjBVdFB7bPCeraafE5MGX2pPQgsoz7znsfKzXHYAVIi', 'Activo', '2023-10-04 02:49:09', '2023-10-04 02:49:09'),
('glr6EEGdQemCloeSlFHOmAXj5DTgE9', 'Tecnico', 41, 'Santiago', 'Ramirez', 'rama@gmail.com', 'CC', '1089598', 'Calle 9', 'Dosquebradas', '$2b$12$/H7pQrWuXLeJdashHWwaGOPomWHCxP8il4GQ63WnovNEXDZkqVU0K', 'Activo', '2023-09-29 00:58:05', '2023-09-29 00:58:05'),
('HSpq5iCvWchaDMt5pJORROVnCJwYEe', 'Tecnico', 2, 'gafas   ', 'henao', 'adminxxx@gmail.com', 'CC', '1234564567', 'calle 4', 'Pereira', '$2b$12$juHJM/rPMFgp/Q1mJokPWuX8cYpyCHla01UZCGaRQAVGVTQnvurxO', 'Activo', '2023-09-28 03:24:58', '2023-09-28 13:09:31'),
('j0vmiCeZEvdFzRxVFZCjwVvvaRmDqD', 'Tecnico', 55, 'juanito  ', 'gomez', 'juanito@mail.com', 'CC', '121021', 'Llano ', 'quinchia', '$2b$12$Ol.PQs1wd5AmabXjegRu9OIFdiTmcwPo0Jkz9F.iVcvjuMGjHJsBK', 'Activo', '2023-09-29 01:10:28', '2023-10-03 22:08:15'),
('KsxahxJBqbYHpS5LX25cmIFSzroliC', 'Tecnico', 41, 'juan', 'jose', 'juanjo@gmail.com', 'CC', '12145541', 'm6 C10', 'pereira', '$2b$12$UtjUrfuWjl73t3qlWGXQguMTD95IWCLB5PE/h7oEbTQOkdDowx06S', 'Activo', '2023-10-03 22:20:21', '2023-10-03 22:20:21'),
('Nscu3oar7UQmBsfhXQiuXQ3vGfO8DJ', 'Admin', 1, 'maksd', 'aksdm', 'admin@mail.com', 'CC', '1213', 'ad', 'asd', '$2b$12$XHtNuDmuiSwc8lrx3hhynelEwtS31m8lA4WwglBttiaIr59VeM85a', 'Activo', '2023-10-03 23:24:47', '2023-10-03 23:24:47'),
('oB7Iew0cZpcfuZKjjTiQKzvRh7wykE', 'Tecnico', 1, 'tecnico', 'tecni', 'tecn@gmail.com', 'CC', '1234', 'diasjdiasji', 'pereira', '$2b$12$qTzqxg/4MI7SrCH1Edram./O2YsPVzupdFEjMdsvNMTj5ZGQzPZEC', 'Inactivo', '2023-09-29 01:04:03', '2023-10-04 08:41:05'),
('ol92TZRuqXRrKTVXzxDknFtoAgQc0j', 'Admin', 1, 'Esteban                  ', 'Mesadas', 'papaniel2145@gmail.com', 'CC', '1001212', 'Transversal 3 #5A51', 'Dosquebradas', '$2b$12$H66ikh9an68h3gk7Ezot6ecq2EqF0J6Vkd4iCbPuul/N9o8f5Qr9W', 'Activo', '2023-09-27 02:23:39', '2023-10-03 22:20:45'),
('OXlXFBf6weOKxIH07t0G5H8bZLIdvZ', 'Admin', 1, 'khgkhjk  ', 'hjkhjkhj', 'sadasdassdd@dasdas.com', 'CC', '31312312331', 'hjfghfghf', 'dasdagkj;', '$2b$12$XIgTEmQ6U7WxH93DrEjsiOjBdCRNtMf3EQFf63d2DZqlb1ijl2CPC', 'Activo', '2023-09-29 00:57:41', '2023-10-03 21:03:50'),
('prvgupUg7d0XGJEP691tBIwngC5yGV', 'Suscriptor', 80, 'Esteban', 'Mesa', 'dieguito@gmail.com', 'CC', '54574545', 'asdasd', 'Pereira', '$2b$12$0qItp.8PiG.T5wFHUPUUTeb23bCIDpaXvvbUXl9KTAlWesgixMEVi', 'Activo', '2023-10-03 22:27:47', '2023-10-03 22:27:47'),
('S5fowRmujucavWCQO3HVo8lFFe8RXu', 'SuperAdmin', 1, 'Super', 'Admin', 'superadmin@gmail.com', 'CC', '1234567890', 'Centro calle ', 'Pereira', '$2b$12$T8K5qBO/4uTrkQFFGO3piu9tAwE5art9OqZ9amd2qYzLSHaUCEPX.', 'Activo', '2023-09-16 00:10:38', '2023-09-29 17:56:33'),
('uVinFpZ9GmRiJBXgSvF9AkHuqWzoj0', 'Tecnico', 1, 'SADSA', 'dsadas', 'asdasd@das.com', 'CC', '123456', 'asdassssss', 'sdadas', '$2b$12$yt6zyAUfKS0qS5TdOcFlL.KL.RnlkMSRyuNAKbX6EZjfUPDPzgUgy', 'Activo', '2023-09-27 04:57:08', '2023-09-28 02:21:50'),
('vJVAVgfDMVdVV8eJNHgNnhKDRNDBzn', 'Admin', 47, 'lulu        ', 'henao', 'lulu@mail.com', 'CC', '140004', 'el lagoss', 'dosquebradas', '$2b$12$7Q/K/We8BCoqjOGToLXSx.Ox2VSla4hEx4Qqedk4fhkSEJ8JM7oLa', 'Activo', '2023-09-29 01:17:21', '2023-10-04 10:42:05'),
('XU8z2R0foWHrVQDg8pY28aaNwtZnRs', 'Suscriptor', 48, 'Esteban    ', 'Mesa', 'asdkasjdja@playcell.fun', 'CC', '1007212784', 'Calle 8', 'Pereira', '$2b$12$SrdPmZxYDM3y0EerRx6/5eeyHJRMCfRps5udch3Nu5utnQi7QFaqO', 'Activo', '2023-10-03 21:39:53', '2023-10-03 22:28:09'),
('yT2ioL9UZhCEhFpnJz5K0VhpPyIdY5', 'Tecnico', 2, 'Windows  ', 'Ro', 'aliasrastastas@gmail.com', 'CC', '108809', 'calle 7744', 'Pereira ', '$2b$12$JXt6u7141/DBC7Rm.ZG58ubW/Wgi7NG4iylsyWOtDVTI1ZFKjtdbW', 'Activo', '2023-09-17 13:36:56', '2023-09-28 18:48:35');

CREATE TABLE listaAsistencia (
  id_asistencia INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  id_usuario CHAR(30),
  id_reunion INT UNSIGNED,
  asistencia TINYINT DEFAULT 0,
  FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario),
  FOREIGN KEY (id_reunion) REFERENCES reuniones (id_reunion)
);

-- SELECT usuarios.id_usuario, usuarios.nom_usuario, usuarios.apellido_usuario, usuarios.tipo_doc, usuarios.num_doc, usuarios.direccion, usuarios.correo, IFNULL(listaAsistencia.asistencia, 0) AS asistencia FROM usuarios LEFT JOIN listaAsistencia ON usuarios.id_usuario = listaAsistencia.id_usuario LEFT JOIN reuniones ON listaAsistencia.id_reunion = reuniones.id_reunion WHERE usuarios.empresa = 35 AND usuarios.rol = 'Suscriptor' AND (reuniones.id_reunion = 128 OR reuniones.id_reunion IS NULL);
--
-- Índices para tablas volcadas
--

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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id_doc` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `inmuebles_suscritor`
--
ALTER TABLE `inmuebles_suscritor`
  MODIFY `id_inmueble` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `reuniones`
--
ALTER TABLE `reuniones`
  MODIFY `id_reunion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `servicios`
--
ALTER TABLE `servicios`
  MODIFY `id_servicio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id_token` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=412;

--
-- AUTO_INCREMENT de la tabla `trazabilidad`
--
ALTER TABLE `trazabilidad`
  MODIFY `id_trazabilidad` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

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
