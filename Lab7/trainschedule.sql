-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Ноя 24 2021 г., 10:27
-- Версия сервера: 10.4.21-MariaDB
-- Версия PHP: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `trainschedule`
--

-- --------------------------------------------------------

--
-- Структура таблицы `races`
--

CREATE TABLE `races` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `races`
--

INSERT INTO `races` (`id`, `title`) VALUES
(1, 'Lviv-Kyiv'),
(2, 'Kyiv-Kharkiv'),
(3, 'Kharkiv-Lviv'),
(4, 'Kyiv-Lviv');

-- --------------------------------------------------------

--
-- Структура таблицы `rails`
--

CREATE TABLE `rails` (
  `id` int(10) UNSIGNED NOT NULL,
  `idStation` int(10) UNSIGNED DEFAULT NULL,
  `number` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `rails`
--

INSERT INTO `rails` (`id`, `idStation`, `number`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 2, 2),
(5, 3, 1),
(6, 3, 2),
(7, 3, 3),
(8, 3, 4);

-- --------------------------------------------------------

--
-- Структура таблицы `schedule`
--

CREATE TABLE `schedule` (
  `id` int(10) UNSIGNED NOT NULL,
  `arrival` datetime DEFAULT NULL,
  `departure` datetime DEFAULT NULL,
  `idLocation` int(10) UNSIGNED DEFAULT NULL,
  `idTransport` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `schedule`
--

INSERT INTO `schedule` (`id`, `arrival`, `departure`, `idLocation`, `idTransport`) VALUES
(21, '2021-12-12 04:12:00', '2021-12-12 04:18:00', 3, 3),
(22, '2021-12-08 02:19:00', '2021-12-08 02:21:00', 1, 1),
(23, '2021-12-07 00:17:00', '2021-12-07 00:38:00', 6, 9),
(24, '2021-12-30 03:55:00', '2021-12-30 04:26:00', 4, 7),
(25, '2021-12-03 06:52:00', '2021-12-03 07:08:00', 8, 2),
(26, '2022-01-07 12:01:00', '2022-01-07 12:05:00', 7, 7),
(27, '2021-11-24 12:15:00', '2021-11-24 12:20:00', 2, 5),
(28, '2021-11-25 18:10:00', '2021-11-25 18:14:00', 1, 2),
(29, '2021-11-26 16:11:00', '2021-11-26 16:16:00', 7, 6),
(30, '2021-12-05 14:14:00', '2021-12-05 14:18:00', 1, 4),
(31, '2022-01-24 12:18:00', '2022-01-24 12:20:00', 8, 10),
(32, '2022-02-24 19:18:00', '2022-02-24 19:22:00', 7, 8);

-- --------------------------------------------------------

--
-- Структура таблицы `stations`
--

CREATE TABLE `stations` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `stations`
--

INSERT INTO `stations` (`id`, `title`) VALUES
(1, 'Kyiv'),
(2, 'Kharkiv'),
(3, 'Lviv');

-- --------------------------------------------------------

--
-- Структура таблицы `trains`
--

CREATE TABLE `trains` (
  `number` int(10) UNSIGNED NOT NULL,
  `vagons` int(11) DEFAULT NULL,
  `startHead` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `trains`
--

INSERT INTO `trains` (`number`, `vagons`, `startHead`) VALUES
(1001, 10, 1),
(1002, 9, 0),
(1003, 6, 0),
(1004, 6, 0),
(1005, 7, 1),
(1006, 8, 1),
(1007, 3, 1),
(1008, 10, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `trainsonrace`
--

CREATE TABLE `trainsonrace` (
  `id` int(10) UNSIGNED NOT NULL,
  `idRace` int(10) UNSIGNED DEFAULT NULL,
  `numTrain` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `trainsonrace`
--

INSERT INTO `trainsonrace` (`id`, `idRace`, `numTrain`) VALUES
(1, 1, 1001),
(2, 1, 1008),
(3, 2, 1005),
(4, 2, 1003),
(5, 2, 1004),
(6, 3, 1002),
(7, 3, 1006),
(8, 1, 1007),
(9, 4, 1007),
(10, 4, 1001);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `races`
--
ALTER TABLE `races`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Индексы таблицы `rails`
--
ALTER TABLE `rails`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `station_idx` (`idStation`);

--
-- Индексы таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `location_idx` (`idLocation`),
  ADD KEY `transport_idx` (`idTransport`);

--
-- Индексы таблицы `stations`
--
ALTER TABLE `stations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Индексы таблицы `trains`
--
ALTER TABLE `trains`
  ADD PRIMARY KEY (`number`),
  ADD UNIQUE KEY `id_UNIQUE` (`number`);

--
-- Индексы таблицы `trainsonrace`
--
ALTER TABLE `trainsonrace`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `race_idx` (`idRace`),
  ADD KEY `train_idx` (`numTrain`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `races`
--
ALTER TABLE `races`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `rails`
--
ALTER TABLE `rails`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT для таблицы `stations`
--
ALTER TABLE `stations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `trains`
--
ALTER TABLE `trains`
  MODIFY `number` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1009;

--
-- AUTO_INCREMENT для таблицы `trainsonrace`
--
ALTER TABLE `trainsonrace`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `rails`
--
ALTER TABLE `rails`
  ADD CONSTRAINT `station` FOREIGN KEY (`idStation`) REFERENCES `stations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `location` FOREIGN KEY (`idLocation`) REFERENCES `rails` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `transport` FOREIGN KEY (`idTransport`) REFERENCES `trainsonrace` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `trainsonrace`
--
ALTER TABLE `trainsonrace`
  ADD CONSTRAINT `race` FOREIGN KEY (`idRace`) REFERENCES `races` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `train` FOREIGN KEY (`numTrain`) REFERENCES `trains` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
