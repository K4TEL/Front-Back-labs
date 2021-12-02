-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 02 2021 г., 19:17
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
-- База данных: `delomeme`
--

DELIMITER $$
--
-- Процедуры
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DonationSum` ()  begin
	select sum(w.sum) as fund
    from wishes w
    where w.isDonated=1;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectPageTexts` (IN `page` VARCHAR(20), IN `lang` VARCHAR(20))  begin
	select t.text, t.elementID 
    from texts t
    inner join pages p on p.title = page and t.pageId = p.id
    inner join languages l on l.name = lang and t.langId = l.id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectWishes` ()  begin
	select w.date, w.text, u.login, w.sum, w.isDonated
    from wishes w 
    inner join users u on u.id = w.userId
    ORDER BY w.date DESC;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Wish` (IN `login` VARCHAR(45), IN `text` VARCHAR(500), IN `sum` INT)  begin
	declare user int;
    declare donated boolean default 0;
    
    select u.id
    into user
    from users u
    where u.login=login;
        
    if sum > 0 then
		set donated=1;
	end if;
    
    insert into wishes (text, userId, sum, isDonated)
    values (text, user, sum, donated);
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблицы `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `languages`
--

INSERT INTO `languages` (`id`, `name`) VALUES
(1, 'EN'),
(2, 'RU'),
(3, 'UA');

-- --------------------------------------------------------

--
-- Структура таблицы `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pages`
--

INSERT INTO `pages` (`id`, `title`) VALUES
(1, 'index'),
(2, 'origin'),
(3, 'cult'),
(4, 'symbol'),
(5, 'contact');

-- --------------------------------------------------------

--
-- Структура таблицы `texts`
--

CREATE TABLE `texts` (
  `id` int(10) UNSIGNED NOT NULL,
  `pageId` int(10) UNSIGNED DEFAULT NULL,
  `langId` int(10) UNSIGNED DEFAULT NULL,
  `text` text DEFAULT NULL,
  `elementID` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `texts`
--

INSERT INTO `texts` (`id`, `pageId`, `langId`, `text`, `elementID`) VALUES
(2, 3, 2, 'Культ и приверженцы', 'headTitle'),
(3, 3, 2, '<p><span>Мемодел</span> – служитель Деломема, который занимается производством, воровством и распространением единиц «значимой» для культуры информации.</p>\r\n<p>Чаще всего встречаются в социальных сетях, где проявляются как администраторы/редакторы каналов и комментаторы записей. </p>\r\n<p>Деятельность мемоделов сводится к хобби, но нередко перерастает и в полноценную профессию. Так называемых СММщиков принято обоссывать при встрече за «продажность» и служение ложному капиталистическому божеству. </p>\r\n<h2>Инструменты</h2>\r\n<p>По заветам Деломема, чем больше оригинальных мемов производит его служитель, тем больше profit. Для этого принято использовать любой графический редактор.</p>\r\n<p>Однако, воровство и репост чужих творений тоже поощряется.</p>\r\n<p>Любой мемодел не обходится и без собственного хранилища «сохранёнок», размером и древностью которого измеряется статус в иерархии служителей Деломема. </p>', 'infoLeft'),
(4, 3, 2, '<h2>Ежедневный ПЛАН</h2>\r\n<ul>\r\n    <li>Помолиться Деломему</li>\r\n    <li>Найти канал чтоб пиздить оттуда мемы:</li>\r\n        <ol>\r\n            <li>Спиздить мем</li>\r\n            <li>Сохранить канал</li>\r\n        </ol>\r\n    <li>Запостить:</li>\r\n        <dl>\r\n            <dt>Оригинальный контент</dt>\r\n                <dd>Творчество, обзоры, уникальная информация, собственные мемы и т.д.</dd>\r\n            <dt>Щитпостинг</dt>\r\n                <dd>Ворованые мемы, ссылки на ютуб</dd>\r\n            <dt>Кринж</dt>\r\n                <dd>Постыдные мемы (проверить не отписался ли кто-то после)</dd>\r\n            </dl>\r\n    <li><i>Накормить собой толпу</i></li>\r\n</ul>', 'planRight'),
(5, 2, 2, 'Истоки Деломема', 'headTitle'),
(6, 2, 2, '<p>Появление Деломема связано с культурным развитием наших предков, их тягой к познанию мира и желанием выразиться по этому поводу. </p>\r\n<p>Самые древние признаки его последователей, дошедшие до наших дней, — это наскальные рисунки.</p>\r\n<p>В дальнейшем способы самовыражения мемоделов видоизменялись и с ходом истории становились всё более долговечными. Как следствие, поклонение Деломему претерпело изменения, и кровавые ритуалы уступили место новым молитвенным традициям. </p>', 'infoTop'),
(7, 2, 2, 'Существует ли бог культуры, если бог это и есть часть культуры?', 'subTitle'),
(8, 2, 2, '<p>Деломем многое унаследовал от своих родителей. Сохранилось примерное описание его внешности и способностей:</p>\r\n<p>Красотой не уступал он <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Apollo\')\">Аполлону</a>, и сам к ней всегда стремился. Почитал искусства  и знания. Умом он был проворен и хитер, а по характеру коварен. От <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Loki\')\">Локи</a> перенял он чувство юмора и шутовские повадки. А от <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Hermes_Trismegistus\')\">Гермеса</a> досталось ему красноречие и милость к ворам. В распоряжение от одного из отцов унаследовал он гарем из Муз, которым распоряжается и по сей день. Известно, что иногда он обращается в прекрасных девушек и сам приходит к молящимся вместо Муз. На голове у Деломема всегда можно заметить венок из его любимых трав. В руках у него жезл символизирующий инструмент творения. На поясе горн, что вещает со скоростью света.</p>\r\n\r\n<p style=\"color: #FDF399! important; font-size: 3em;\">Традиционно атрибутами Деломема считаются:</p>\r\n<ul>\r\n    <li><a href=\"symbol.html#horn\">Рог</a></li>\r\n    <li><a href=\"symbol.html#wreath\">Венок</a></li>\r\n    <li><a href=\"symbol.html#wand\">Жезл</a></li>\r\n</ul>', 'infoLeft'),
(9, 2, 2, 'Источник информации:', 'infoRight'),
(10, 4, 2, 'Атрибуты', 'headTitle'),
(11, 4, 1, 'Epithets and Attributes', 'headTitle'),
(12, 4, 1, 'If you notice man with horn and wand, wearing herbal wreath on his head, maybe it’s Delomemat himself, but maybe you should stop doing drugs.', 'subTitle'),
(13, 4, 2, 'Традиционные атрибуты Деломема', 'caption'),
(14, 4, 2, '<th>Изображение</th>\r\n        <th>Название</th>\r\n        <th>Описание</th>', 'header'),
(15, 4, 1, '<p> Heralds attribute, which nowadays exists in the form of share / repost buttons. </p>\r\n             <p> Heralds blew their horn at any opportunity, in honor of the celebration, the beginning or end of the war, etc. </p>\r\n             <p> Symbolizes the widespread of information. </p>', 'descrHorn'),
(16, 4, 2, '<p>Венок из любимых трав Деломема это его постоянный головной убор. Именно из-за букета зверобоя и конопли Деломем всегда позитивно настроен и смотрит на мир с улыбкой.</p>\r\n            <p>Такое же отношение к миру проповедует он и для мемоделов, призывая их ко всему относиться менее серьезно («на похуй»).</p>', 'descrWreath'),
(17, 4, 2, '<p>Палка –копалка, которая делает из ничего что-то.</p>\r\n            <p>Жезл это один из главных атрибутов Деломема, которым он указывает направление мысли мемоделам.</p>\r\n            <p>Как фаллический символ подразумевает распространение мемов-генов.</p>', 'descrWand'),
(18, 4, 2, '<p>Какого-то единого символа это божество не имеет, так как все ближайшие планеты разобрали более могущественные небожители.</p>', 'descrPlanet'),
(19, 4, 2, '<p>Иногда сюда же причисляют сборник анекдотов, или любой другой источник юморесок, но этот инструмент можно скорее отнести к атрибутам самих мемоделов.</p>', 'descrHumor'),
(20, 4, 3, 'Епітети та атрибути', 'headTitle'),
(21, 3, 1, 'Cult and Patronages', 'headTitle'),
(22, 3, 3, 'Культ та прихильники', 'headTitle'),
(23, 2, 1, 'Information source:', 'infoRight'),
(24, 2, 3, 'Джерело інформації:', 'infoRight'),
(25, 4, 2, 'Если вы видите мужчину в венку с горном и жезлом, возможно это Деломем, а возможно вам пора завязывать с ПАВ', 'subTitle'),
(26, 4, 1, '<th>Image</th>\r\n        <th>Title</th>\r\n        <th>Description</th>', 'header'),
(27, 4, 3, '<th>Зображення</th>\r\n        <th>Назва</th>\r\n        <th>Опис</th>', 'header'),
(28, 2, 1, 'Origins of Delomemat', 'headTitle'),
(29, 2, 3, 'Походження Діломема', 'headTitle'),
(30, 2, 1, 'Is there a god of Culture, if any god is a part of Culture?', 'subTitle'),
(31, 2, 3, 'Чи існує бог культури, якщо бог це і є частина культури?', 'subTitle'),
(32, 3, 3, '<p><span>Мемороб</span> – служитель Діломема, який займається виробництвом, крадіжкою та поширенням одиниць «значущою» для культури інформації.</p>\r\n<p>Найчастіше зустрічаються у соціальних мережах, де проявляються як адміністратори/редактори каналів та коментатори записів. </p>\r\n<p>Діяльність меморобів зводиться до хобі, але нерідко переростає й у повноцінну професію. Так званих СММщиків прийнято принижувати при зустрічі за «продажність» та служіння фальшивому капіталістичному божеству. </p>\r\n<h2>Інструменти</h2>\r\n<p>За завітами Діломема, чим більше оригінальних мемов виробляє його служитель, тим більше profit. Для цього прийнято використовувати будь-який графічний редактор.</p>\r\n<p>Але крадіжка та репост чужих творінь теж заохочується.</p>\r\n<p>Будь-який мемороб не обходиться і без власного сховища «збережень», розміром та давниною якого вимірюється статус в ієрархії служителів Діломема.</p>', 'infoLeft'),
(33, 3, 1, '<h2>Daily PLAN</h2>\r\n\r\n<ul>\r\n    <li>Pray to Delomemat</li>\r\n    <li>Find channel to grab memes:</li>\r\n        <ol>\r\n            <li>Grab a meme</li>\r\n            <li>Save the channel</li>\r\n        </ol>\r\n    <li>Post:</li>\r\n        <dl>\r\n            <dt>Original content</dt>\r\n                <dd>Creativity, reviews, unique information, own memes, etc.</dd>\r\n            <dt>Shitposting</dt>\r\n                <dd>Stolen memes, yt links</dd>\r\n            <dt>Cringe</dt>\r\n                <dd>Guilty pleasures (check unsubscribes after)</dd>\r\n            </dl>\r\n    <li><i>Feed the crowd by yourself</i></li>\r\n</ul>', 'planRight'),
(34, 3, 3, '<h2>Щоденний ПЛАН</h2>\r\n<ul>\r\n     <li>Помолитися Діломему</li>\r\n     <li>Знайти канал щоб красти звідти меми:</li>\r\n         <ol>\r\n             <li>Викрасти мем</li>\r\n             <li>Зберегти канал</li>\r\n         </ol>\r\n     <li>Запостити:</li>\r\n         <dl>\r\n             <dt>Оригінальний контент</dt>\r\n                 <dd>Творчість, огляди, унікальна інформація, власні меми і т.д.</dd>\r\n             <dt>Щитпостінг</dt>\r\n                 <dd>Вкрадені меми, посилання на ютуб</dd>\r\n             <dt>Крінж</dt>\r\n                 <dd>Соромні меми (перевірити чи не відписався хтось після)</dd>\r\n             </dl>\r\n     <li><i>Нагодувати собою натовп</i></li>\r\n</ul>', 'planRight'),
(35, 3, 1, '<p> <span> Mememaker </span> is a servitor of Delomemat who is engaged in the production, theft and distribution of units of \"significant\" for the culture information. </p>\r\n<p> Most often found on social networks, where they appear as channel administrators / editors and post commentators. </p>\r\n<p> Mememakers\' activity is reduced to a hobby, but often develops into a full-fledged profession. It is customary to shame the so-called SMMs for \"venality\" and serving a false capitalist deity. </p>\r\n<h2> Tools </h2>\r\n<p> According to Delomemat\'s precepts, the more original memes his servant produces, the more profit he gains. It is customary to use any graphics editor for this. </p>\r\n<p> However, stealing and reposting other people\'s creations is also encouraged. </p>\r\n<p> Any mememaker is not complete without his own storage of \"savings\", the size and age of which define the status in the hierarchy of Delomemat\'s servitors. </p>', 'infoLeft'),
(36, 2, 3, '<p>Діломем багато успадкував від своїх батьків. Зберігся приблизний опис його зовнішності та здібностей:</p>\r\n<p>Красою не поступався він <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Apollo\')\">Аполлону</a>, і сам до неї завжди прагнув. Шанував мистецтва та знання. Розумом він видався кмітливий, а за характером підступний. Від <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Loki\')\">Локі</a> перейняв він почуття гумору і блазнівські звички. А від Гермеса дісталося йому красномовство і милість до крадіїв. У розпорядження від одного з батьків успадкував він гарем із Муз, яким розпоряджається й донині. Відомо, що іноді він перевтілюється у прекрасних дівчат і сам приходить до тих, хто молиться замість Муз. На голові Діломема завжди красується вінок з його улюблених трав. У руках його жезл - інструмент творців. На поясі горн, що віщає зі швидкістю світла.</p>\r\n\r\n<p style=\"color: #FDF399! important; font-size: 3em;\">Традиційно атрибутами Діломема вважаються:</p>\r\n<ul>\r\n    <li><a href=\"symbol.html#horn\">Ріг</a></li>\r\n    <li><a href=\"symbol.html#wreath\">Вінок</a></li>\r\n    <li><a href=\"symbol.html#wand\">Жезл</a></li>\r\n</ul>', 'infoLeft'),
(37, 2, 1, '<p> Delomemat inherited a lot from his parents. An approximate description of his appearance and abilities has left: </p>\r\n<p>By beauty he wasn\'t inferior to<a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Apollo\')\"> Apollo </a>, and he himself always strove for it. Honored arts and knowledge. Mentally he was agile, but by nature he was cunning. From <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Loki\')\"> Loki </a> he adopted his sense of humor and clownish traits. And from <a href=\"javascript:goWiki(\'https://en.wikipedia.org/wiki/Hermes_Trismegistus\')\"> Hermes </a> he got eloquence and mercy to thieves. At the disposal of one of the fathers, he inherited a harem of Muses, which he manages to this day. It is known that sometimes he turns into beautiful girls and comes to prayers himself instead. On Delomemat\'s head, you can always see a wreath of his favorite herbs. In his hands a wand is symbolizing the instrument of creation. On the belt a horn that broadcasts at the speed of light. </p>\r\n\r\n<p style = \"color: # FDF399! important; font-size: 3em;\"> Traditional Delomemat\'s attributes are: </p>\r\n<ul>\r\n    <li> <a href=\"symbol.html#horn\"> Horn </a> </li>\r\n    <li> <a href=\"symbol.html#wreath\"> Wreath </a> </li>\r\n    <li> <a href=\"symbol.html#wand\"> Wand </a> </li>\r\n</ul>', 'infoLeft'),
(38, 2, 3, '<p>Поява Діломема пов\'язана з культурним розвитком наших предків, їх потягом до пізнання світу та бажанням висловитися з цього приводу. </p>\r\n<p>Найдавніші докази існування його послідовників, що дійшли до наших днів, — це наскельні малюнки.</p>\r\n<p>Надалі способи самовираження меморобів видозмінювалися і з ходом історії ставали все більш довговічними. Як наслідок, поклоніння Діломему зазнало змін, і криваві ритуали поступилися місцем новим молитовним традиціям. </p>', 'infoTop'),
(39, 2, 1, '<p> The appearance of Delomemat is associated with the cultural development of our ancestors, their craving for knowledge of the world and the desire to express themselves on this matter. </p>\r\n<p> The most ancient signs of his followers that have survived to this day are rock paintings. </p>\r\n<p> Then, the ways of self-expression of mememakers have changed and became more and more durable over the course of history. As a result, the worship of Delomemat underwent a change, and bloody rituals gave way to new prayer traditions. </p>', 'infoTop'),
(40, 4, 3, 'Традиційні атрибути Діломема', 'caption'),
(41, 4, 1, 'Delomemat\'s traditional attributes', 'caption'),
(42, 4, 3, 'Якщо ви помітили чоловіка з горном і жезлом, який носить на голові вінок з трав, можливо, це сам Діломем, але, можливо, вам варто припинити вживати наркотики.', 'subTitle'),
(43, 4, 3, '<p>Атрибут глашатаїв, який у наш час представлений share/repost кнопками. </p>\r\n             <p>Герольди трубили в горн за будь-якої нагоди, на честь урочистостих подій, початку або закінчення війни і т. д.</p>\r\n             <p>Символізує поширення інформації.</p>', 'descrHorn'),
(44, 4, 2, '<p>Атрибут глашатаев, который в наше время существует в виде share/repost кнопок. </p>\r\n            <p>Герольды трубили в рог при любом удобном случае в честь торжества, начала или окончания войны и т. д.</p>\r\n            <p>Символизирует распространение информации.</p>', 'descrHorn'),
(45, 4, 1, '<p> Sometimes a collection of anecdotes, or any other source of humors, is also included here, but this tool should be linked to the attributes of the mememakers themselves. </p>', 'descrHumor'),
(46, 4, 3, '<p>Іноді сюди ж зараховують збірку анекдотів, або будь-яке інше джерело гуморесок, але цей інструмент можна швидше віднести до атрибутів самих меморобів.</p>', 'descrHumor'),
(47, 4, 1, '<p> This deity does not have any single symbol, since all nearby planets are already owned by more powerful celestials. </p>', 'descrPlanet'),
(48, 4, 3, '<p>Якогось єдиного символу це божество не має, тому що всі найближчі планети розібрали могутніші небожителі.</p>', 'descrPlanet'),
(49, 4, 3, '<p>Палиця-копалиця, яка робить з нічого щось.</p>\r\n             <p>Жезл це один із головних атрибутів Діломема, яким він вказує напрямок думки меморобів.</p>\r\n             <p>Як фалічний символ має на увазі поширення мемов-генів.</p>', 'descrWand'),
(50, 4, 1, '<p> A stick that makes something out of nothing. </p>\r\n             <p> The Wand is one of the main attributes of Delomemat, with which he directs thought for mememakers. </p>\r\n             <p> As a phallic symbol implies the spread of memes-genes. </p>', 'descrWand'),
(51, 4, 1, '<p> A wreath of Delomemat\'s favorite herbs is his permanent headdress. It is because of the bouquet of St. John\'s wort and weed that Delomemat always has a positive attitude and looks at the world with a smile. </p>\r\n             <p> He preaches the same attitude to the world for mememakers, urging them to take everything less seriously. </p>', 'descrWreath'),
(52, 4, 3, '<p>Вінок із улюблених трав Діломема це його постійний головний убір. Саме через букет звіробою та коноплі Діломем завжди позитивно налаштований і дивиться на світ із посмішкою.</p>\r\n             <p>Таке ж ставлення до світу проповідує він і для меморобів, закликаючи їх до всього ставитися менш серйозно.</p>', 'descrWreath'),
(53, 5, 1, 'Feedback:', 'headTitle'),
(54, 5, 2, 'Обратная связь:', 'headTitle'),
(55, 5, 3, 'Зворотній зв\'язок:', 'headTitle'),
(56, 5, 1, 'You:', 'youLabel'),
(57, 5, 2, 'Вы:', 'youLabel'),
(58, 5, 3, 'Ви:', 'youLabel'),
(59, 5, 1, 'Your contacts:', 'emailLabel'),
(60, 5, 2, 'Ваши контакты:', 'emailLabel'),
(61, 5, 3, 'Ваші контакти:', 'emailLabel'),
(62, 5, 1, 'Message:', 'messageLabel'),
(63, 5, 2, 'Сообщение:', 'messageLabel'),
(64, 5, 3, 'Повідомлення:', 'messageLabel'),
(66, 1, 1, 'Church of Delomemat', 'headTitle'),
(67, 1, 2, 'Церковь Деломема', 'headTitle'),
(68, 1, 3, 'Церква Діломема', 'headTitle'),
(69, 1, 2, '<b>Delomemat</b> (с Греч.: <b>delo</b> - <i>Видимый</i>, <b>memat</b> - <i>Желаемый</i>) <b>Деломем</b> – бог всех мемоделов.', 'subTitle'),
(70, 1, 1, '<b>Delomemat</b> (from Greek: <b>delo</b> - <i>Visible</i>, <b>memat</b> - <i>Desired</i>) - god of all mememakers.', 'subTitle'),
(71, 1, 3, '<b>Delomemat</b> (з Греч.: <b>delo</b> - <i>Видимый</i>, <b>memat</b> - <i>Желаемый</i>) <b>Діломем</b> – бог усіх меморобів.', 'subTitle');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`) VALUES
(1, 'admin', 'admin'),
(2, 'test', 'test'),
(3, 'anon', 'anon');

-- --------------------------------------------------------

--
-- Структура таблицы `wishes`
--

CREATE TABLE `wishes` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `text` varchar(500) DEFAULT NULL,
  `userId` int(10) UNSIGNED DEFAULT NULL,
  `sum` int(11) DEFAULT NULL,
  `isDonated` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `wishes`
--

INSERT INTO `wishes` (`id`, `date`, `text`, `userId`, `sum`, `isDonated`) VALUES
(2, '2021-11-30 04:20:00', 'Щоб мама жила вічно!', 2, 1337, 1),
(7, '2021-11-30 19:21:03', 'Слава Україні!', 1, 42, 1),
(9, '2021-12-02 19:35:22', 'Мир у всьому світі!', 3, 0, 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Индексы таблицы `texts`
--
ALTER TABLE `texts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `pageId_idx` (`pageId`),
  ADD KEY `langId_idx` (`langId`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Индексы таблицы `wishes`
--
ALTER TABLE `wishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId_idx` (`userId`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `texts`
--
ALTER TABLE `texts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `wishes`
--
ALTER TABLE `wishes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `texts`
--
ALTER TABLE `texts`
  ADD CONSTRAINT `langId` FOREIGN KEY (`langId`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `pageId` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Ограничения внешнего ключа таблицы `wishes`
--
ALTER TABLE `wishes`
  ADD CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
