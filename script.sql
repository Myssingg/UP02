
CREATE DATABASE "UP02" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE "UP02" OWNER TO postgres;

\connect "UP02"

CREATE TABLE public."Cities" (
    id integer NOT NULL,
    "cityName" character varying NOT NULL
);


ALTER TABLE public."Cities" OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16714)
-- Name: Cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Cities" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Cities_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 16835)
-- Name: Manufacturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Manufacturers" (
    id integer NOT NULL,
    "manufacturerName" character varying NOT NULL
);


ALTER TABLE public."Manufacturers" OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16834)
-- Name: Manufacturers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Manufacturers" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Manufacturers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 16735)
-- Name: OrderStatuses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrderStatuses" (
    id integer NOT NULL,
    "statusName" character varying NOT NULL
);


ALTER TABLE public."OrderStatuses" OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16734)
-- Name: OrderStatuses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."OrderStatuses" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."OrderStatuses_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16768)
-- Name: Orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Orders" (
    id integer NOT NULL,
    "dateOrder" date NOT NULL,
    "deliveryDate" date,
    "pickupPointId" integer NOT NULL,
    "userId" integer NOT NULL,
    "codeForObtaining" integer NOT NULL,
    "orderStatusId" integer NOT NULL
);


ALTER TABLE public."Orders" OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16767)
-- Name: Orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Orders" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Orders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16725)
-- Name: PickupPoints; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PickupPoints" (
    id integer NOT NULL,
    index character varying(6) NOT NULL,
    "cityId" integer NOT NULL,
    "streetId" integer NOT NULL,
    "houseNumber" character varying(5)
);


ALTER TABLE public."PickupPoints" OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16724)
-- Name: PickupPoints_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."PickupPoints" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."PickupPoints_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 240 (class 1259 OID 16845)
-- Name: ProductCategories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductCategories" (
    id integer NOT NULL,
    "categoryName" character varying NOT NULL
);


ALTER TABLE public."ProductCategories" OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16844)
-- Name: ProductCategories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ProductCategories" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ProductCategories_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 16854)
-- Name: Products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Products" (
    id character varying(10) NOT NULL,
    "productName" character varying NOT NULL,
    "unitOfMeansurementId" integer NOT NULL,
    price numeric NOT NULL,
    "supplierId" integer NOT NULL,
    "manufacturerId" integer NOT NULL,
    "categoryId" integer NOT NULL,
    discount integer NOT NULL,
    stock integer NOT NULL,
    description character varying,
    "pictureName" character varying
);


ALTER TABLE public."Products" OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16892)
-- Name: ProductsInOrders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ProductsInOrders" (
    id integer NOT NULL,
    "orderId" integer NOT NULL,
    "productId" character varying(10) NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public."ProductsInOrders" OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16891)
-- Name: ProductsInOrders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."ProductsInOrders" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."ProductsInOrders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16745)
-- Name: Roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Roles" (
    id integer NOT NULL,
    "roleName" character varying NOT NULL
);


ALTER TABLE public."Roles" OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16744)
-- Name: Roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Roles" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Roles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16705)
-- Name: Streets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Streets" (
    id integer NOT NULL,
    "streetName" character varying NOT NULL
);


ALTER TABLE public."Streets" OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16704)
-- Name: Streets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Streets" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Streets_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 236 (class 1259 OID 16825)
-- Name: Suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Suppliers" (
    id integer NOT NULL,
    "supplierName" character varying NOT NULL
);


ALTER TABLE public."Suppliers" OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16824)
-- Name: Suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Suppliers" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Suppliers_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16815)
-- Name: UnitsOfMeansurement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UnitsOfMeansurement" (
    id integer NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public."UnitsOfMeansurement" OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16814)
-- Name: UnitsOfMeansurement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."UnitsOfMeansurement" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."UnitsOfMeansurement_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 230 (class 1259 OID 16755)
-- Name: Users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Users" (
    id integer NOT NULL,
    "roleId" integer NOT NULL,
    "FIO" character varying NOT NULL,
    login character varying NOT NULL,
    password character varying NOT NULL
);


ALTER TABLE public."Users" OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16754)
-- Name: Users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."Users" ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Users_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 5103 (class 0 OID 16715)
-- Dependencies: 222
-- Data for Name: Cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Cities" (id, "cityName") OVERRIDING SYSTEM VALUE VALUES (1, ' Лесной');


--
-- TOC entry 5119 (class 0 OID 16835)
-- Dependencies: 238
-- Data for Name: Manufacturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (1, 'Яуза');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (2, 'Т8 Издательские технологии');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (3, 'Прогресс книга');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (4, 'Время');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (6, 'Неолит');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (7, 'Амрита-Русь');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (8, 'Златоуст');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (9, 'Аспект Пресс');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (10, 'ВКН');
INSERT INTO public."Manufacturers" (id, "manufacturerName") OVERRIDING SYSTEM VALUE VALUES (5, 'Лениздат');


--
-- TOC entry 5107 (class 0 OID 16735)
-- Dependencies: 226
-- Data for Name: OrderStatuses; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."OrderStatuses" (id, "statusName") OVERRIDING SYSTEM VALUE VALUES (1, 'Завершен');
INSERT INTO public."OrderStatuses" (id, "statusName") OVERRIDING SYSTEM VALUE VALUES (2, 'Новый ');


--
-- TOC entry 5113 (class 0 OID 16768)
-- Dependencies: 232
-- Data for Name: Orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (1, '2024-02-27', '2024-04-20', 1, 10, 901, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (5, '2024-03-17', '2024-04-24', 2, 10, 905, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (9, '2024-04-02', '2024-04-28', 5, 10, 909, 2);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (10, '2024-04-03', '2024-04-29', 19, 10, 910, 2);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (2, '2023-09-28', '2024-04-21', 11, 7, 902, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (6, '2024-03-01', '2024-04-25', 15, 7, 906, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (3, '2024-03-21', '2024-04-22', 2, 8, 903, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (7, '2024-02-28', '2024-04-26', 3, 8, 907, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (4, '2024-02-20', '2024-04-23', 11, 9, 904, 1);
INSERT INTO public."Orders" (id, "dateOrder", "deliveryDate", "pickupPointId", "userId", "codeForObtaining", "orderStatusId") OVERRIDING SYSTEM VALUE VALUES (8, '2024-03-31', '2024-04-27', 19, 9, 908, 2);


--
-- TOC entry 5105 (class 0 OID 16725)
-- Dependencies: 224
-- Data for Name: PickupPoints; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (1, '420151', 1, 1, '32');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (2, '125061', 1, 2, '8');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (3, '630370', 1, 3, '24');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (4, '125837', 1, 3, '40');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (5, '400562', 1, 4, '32');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (6, '614510', 1, 5, '47');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (7, '410542', 1, 6, '46');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (8, '620839', 1, 7, '8');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (9, '443890', 1, 8, '1');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (10, '625590', 1, 8, '20');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (11, '394242', 1, 8, '43');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (12, '603379', 1, 9, '46');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (13, '603721', 1, 10, '41');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (14, '410172', 1, 11, '13');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (15, '614611', 1, 12, '50');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (16, '454311', 1, 13, '19');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (17, '660007', 1, 14, '19');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (18, '603036', 1, 15, '4');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (19, '394060', 1, 16, '43');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (20, '410661', 1, 17, '50');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (21, '625683', 1, 18, NULL);
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (22, '450983', 1, 19, '26');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (23, '394782', 1, 20, '3');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (24, '344288', 1, 20, '1');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (25, '603002', 1, 21, '28');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (26, '450558', 1, 22, '30');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (27, '614164', 1, 23, '30');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (28, '660540', 1, 24, '25');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (29, '125703', 1, 25, '49');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (30, '625283', 1, 26, '46');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (31, '614753', 1, 27, '35');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (32, '426030', 1, 5, '44');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (33, '450375', 1, 28, '44');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (34, '625560', 1, 29, '12');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (35, '630201', 1, 19, '17');
INSERT INTO public."PickupPoints" (id, index, "cityId", "streetId", "houseNumber") OVERRIDING SYSTEM VALUE VALUES (36, '190949', 1, 30, '26');


--
-- TOC entry 5121 (class 0 OID 16845)
-- Dependencies: 240
-- Data for Name: ProductCategories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductCategories" (id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (1, 'Художественная литература');
INSERT INTO public."ProductCategories" (id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (2, 'Учебник для вузов');
INSERT INTO public."ProductCategories" (id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (3, 'Хрестоматия');
INSERT INTO public."ProductCategories" (id, "categoryName") OVERRIDING SYSTEM VALUE VALUES (4, 'Учебное пособие');


--
-- TOC entry 5122 (class 0 OID 16854)
-- Dependencies: 241
-- Data for Name: Products; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('А112Т4', 'Прокляты и убиты', 1, 585, 1, 1, 1, 25, 6, 'Роман-эпопею Прокляты и убиты Виктора Астафьева по праву считают одним из самых сильных и пронзительных произведений отечественной военной прозы.', '1.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('D325D4', 'Девайс', 1, 1599, 3, 2, 1, 5, 12, 'Молодой фрилансер Захар Скаро устраивается на очередную подработку. Задача, казалось бы, тривиальная: тестирование нового устройства. Вот только вопрос в том, тестированием какой реальности занимается этот новый Девайс?', '3.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('S432T5', 'Необыкновенное обыкновенное чудо. Школьные истории', 1, 549, 4, 2, 1, 15, 15, NULL, '4.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('G432G6', 'Информационная безопасность. Национальные стандарты Российской Федерации. 3-е издание. Учебное пособие', 1, 3899, 6, 3, 2, 22, 3, 'В учебном пособии рассмотрено более 300 действующих открытых документов национальной системы стандартизации Российской Федерации, включая международные и межгосударственные стандарты в области информационной безопасности по состоянию на начало 2023 года.', '6.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('C346F5', 'Квантовые миры и возникновение пространства-времени', 1, 1349, 8, 3, 2, 5, 4, 'Шон Кэрролл — физик-теоретик и один из самых известных в мире популяризаторов науки — заставляет нас по-новому взглянуть на физику. Столкновение с главной загадкой квантовой механики полностью поменяет наши представления о пространстве и времени.', '8.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('F256G6', 'Вселенная. Происхождение жизни, смысл нашего существования и огромный космос', 1, 1799, 8, 3, 2, 6, 2, 'Знаменитый физик Шон Кэрролл в свойственной ему увлекательной манере объясняет принципы, которые лежат в основах научных революций от Дарвина до Эйнштейна, и показывает как невероятные научные открытия последнего столетия изменили наш мир.', NULL);
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('J532V5', 'Пушкин. Бродский. Империя и судьба. В 2-х томах (комплект из 2-х книг)', 1, 529, 9, 4, 3, 8, 6, 'Первая книга двухтомника «Пушкин. Бродский. Империя и судьба» пронизана пушкинской темой. Пушкин — «певец империи и свободы» — присутствует даже там, где он впрямую не упоминается, ибо его судьба, как и судьба других героев книги, органично связана с трагедией великой империи.', '10.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('G643F4', 'Иосиф Бродский. Избранные эссе (комплект из 6-ти книг)', 1, 4925, 10, 5, 3, 2, 24, 'Шесть сборников избранных эссе Иосифа Бродского (1940-1996), великого поэта, драматурга, мыслителя, лауреата Нобелевской премии по литературе (1987): «Будущее или далекое прошлое», «Верь своей боли», «Как читать книгу», «О русской литературе», «О тирании», «Путеводитель по переименованному городу». Все тексты представлены на английском языке и в переводе на русский и открывают автора не только как поэта, но как историка, критика, и глубокого и ироничного мыслителя.', '11.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('J326V5', 'Тысячелетие императорской керамикиv', 1, 2599, 11, 5, 3, 5, 4, 'Фарфор стал величайшим символом китайской культуры. Это одно из выдающихся изобретений, внесших неоценимый вклад в мировую цивилизацию. ', '12.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('J632F6', 'Вечные спутники: Портреты из всемирной литературы', 1, 1599, 12, 5, 3, 0, 6, 'Книга Вечные спутники - это цикл критических очерков о культуре и великих литераторах, сопровождавших жизнь и творчество русского писателя, поэта, литературного критика и общественного деятеля Дмитрия Мережковского (1865–1941). ', '13.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('G843H5', 'Тайны и загадки отца БраунаТайны и загадки отца Брауна', 1, 193, 2, 1, 1, 30, 9, 'Тайны и загадки отца БраунаТайны и загадки отца Брауна', '2.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('H542F5', 'Linux. Командная строка. Лучшие практики', 1, 1799, 7, 3, 2, 4, 5, 'Linux. Командная строка. Лучшие практики', '7.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('F325D4', 'Чук и Гек', 1, 209, 5, 2, 1, 18, 3, 'Чук и Гек', '5.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('G632H6', 'Формирование литературной репутации Н.Г.Чернышевского в ХIX-XXI веках', 1, 1349, 13, 6, 3, 2, 8, 'Монография Д. А. Щербакова - новаторская. Поэтапно рассмотрены не только многочисленные суждения известных отечественных и зарубежных критиков, литературоведов, философов и политиков, различным образом характеризовавших Н. Г. Чернышевского в связи и вне связи со знаменитым романом Что делать? ', '14.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('G543F5', 'Религиозные верования с древнейших времен до наших дней', 1, 879, 13, 7, 3, 4, 6, 'Настоящее издание представляет собой сборник переводов лекций по истории дохристианских и нехристианских религий, прочитанных в Лондоне в период с 1888 по 1891 гг. авторитетными исследователями данного раздела религиоведения. ', '16.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('M642E5', 'Теория искусства. Краткий путеводитель', 1, 879, 14, 6, 3, 3, 2, NULL, '15.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('B653G6', 'Русский язык: Первые шаги. Часть 3. Учебное пособие', 1, 2699, 15, 8, 4, 8, 9, 'Пособие является завершающей частью учебного комплекса. Третья часть содержит 10 уроков (21-30, последний-повторительный). Усвоение лексико-грамматического материала рассчитано примерно на 200-240 часов аудиторных занятий. ', '17.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('J735J7', 'Синтетический образ индивидуального психического мира', 1, 1099, 16, 8, 3, 9, 4, 'Психика подобна определенным объектам, это фиксируют сами люди в языке и искусстве. В данном исследовании рассматриваются в этом плане образы сосуда, воронки, дерева и крепости.', '18.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('H436H7', 'Английский язык в спорте: Учебное пособие', 1, 1999, 17, 9, 4, 2, 0, 'Учебное пособие подготовлено для слушателей, изу чающих английский язык как язык специальности', '19.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('H475R5', 'Лексика и грамматика современного китайского языка (к тому II учебника «Новый практический курс китайского языка» под редакцией Лю Сюня): учебное пособие', 1, 608, 18, 10, 4, 25, 12, 'Пособие выступает дополнением ко второму тому учебника «Новый практический курс китайского языка» (под редакцией Лю Сюня). ', '20.jpg');
INSERT INTO public."Products" (id, "productName", "unitOfMeansurementId", price, "supplierId", "manufacturerId", "categoryId", discount, stock, description, "pictureName") VALUES ('JJ55', 'Эпопея', 1, 4445, 2, 1, 1, 3, 2, 'Обычная эпопея', 'picture.png');


--
-- TOC entry 5124 (class 0 OID 16892)
-- Dependencies: 243
-- Data for Name: ProductsInOrders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'А112Т4', 2);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (2, 1, 'G843H5', 2);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (3, 2, 'G843H5', 1);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (4, 2, 'А112Т4', 1);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (5, 3, 'D325D4', 10);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (6, 3, 'S432T5', 10);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (7, 4, 'F325D4', 5);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (8, 4, 'D325D4', 4);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (9, 5, 'G432G6', 20);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (10, 5, 'H542F5', 20);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (11, 6, 'А112Т4', 2);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (12, 6, 'G843H5', 2);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (13, 7, 'C346F5', 3);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (14, 7, 'F256G6', 3);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (15, 8, 'F325D4', 1);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (16, 8, 'G432G6', 1);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (17, 9, 'J532V5', 5);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (18, 9, 'F256G6', 1);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (19, 10, 'F256G6', 5);
INSERT INTO public."ProductsInOrders" (id, "orderId", "productId", count) OVERRIDING SYSTEM VALUE VALUES (20, 10, 'J532V5', 5);


--
-- TOC entry 5109 (class 0 OID 16745)
-- Dependencies: 228
-- Data for Name: Roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Roles" (id, "roleName") OVERRIDING SYSTEM VALUE VALUES (1, 'Администратор');
INSERT INTO public."Roles" (id, "roleName") OVERRIDING SYSTEM VALUE VALUES (2, 'Менеджер');
INSERT INTO public."Roles" (id, "roleName") OVERRIDING SYSTEM VALUE VALUES (3, 'Авторизированный клиент');


--
-- TOC entry 5101 (class 0 OID 16705)
-- Dependencies: 220
-- Data for Name: Streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (1, ' Вишневая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (2, ' Подгорная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (3, ' Шоссейная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (4, ' Зеленая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (5, ' Маяковского');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (6, ' Светлая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (7, ' Цветочная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (8, ' Коммунистическая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (9, ' Спортивная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (10, ' Гоголя');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (11, ' Северная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (12, ' Молодежная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (13, ' Новая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (14, ' Октябрьская');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (15, ' Садовая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (16, ' Фрунзе');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (17, ' Школьная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (18, ' 8 Марта');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (19, ' Комсомольская');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (20, ' Чехова');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (21, ' Дзержинского');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (22, ' Набережная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (23, '  Степная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (24, ' Солнечная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (25, ' Партизанская');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (26, ' Победы');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (27, ' Полевая');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (28, ' Клубная');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (29, ' Некрасова');
INSERT INTO public."Streets" (id, "streetName") OVERRIDING SYSTEM VALUE VALUES (30, ' Мичурина');


--
-- TOC entry 5117 (class 0 OID 16825)
-- Dependencies: 236
-- Data for Name: Suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (1, 'Виктор Астафьев');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (2, 'Гилберт Кит Честертон');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (3, 'Кирилл Каланджи');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (4, 'Людмила Улицкая');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (5, 'Аркадий Гайдар');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (6, 'Юрий Родичев');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (7, 'Дэниел Джей Барретт');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (8, 'Шон Кэрролл');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (9, 'Яков Гордин');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (10, 'Иосиф Бродский');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (11, 'Янь Чуннянь Янь Чуннянь');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (12, 'Дмитрий Мережковский');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (13, 'Дмитрий Щербаков');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (14, 'Роджер Осборн, Дэн Стерджис');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (15, 'Любовь Беликова, Инна Ерофеева, Татьяна Шутова');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (16, 'Сергей Моргачев');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (17, 'Екатерина Габарта, Ирина Игнатьева');
INSERT INTO public."Suppliers" (id, "supplierName") OVERRIDING SYSTEM VALUE VALUES (18, 'Татьяна Лопаткина, Софья Маннапова');


--
-- TOC entry 5115 (class 0 OID 16815)
-- Dependencies: 234
-- Data for Name: UnitsOfMeansurement; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."UnitsOfMeansurement" (id, name) OVERRIDING SYSTEM VALUE VALUES (1, 'шт.');


--
-- TOC entry 5111 (class 0 OID 16755)
-- Dependencies: 230
-- Data for Name: Users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (1, 1, 'Никифорова Анна Семеновна', '94d5ous@gmail.com', 'uzWC67');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (2, 1, 'Стелина Евгения Петровна', 'uth4iz@mail.com', '2L6KZG');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (3, 1, 'Михайлюк Анна Вячеславовна', '5d4zbu@tutanota.com', 'rwVDh9');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (4, 2, 'Ситдикова Елена Анатольевна', 'ptec8ym@yahoo.com', 'LdNyos');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (5, 2, 'Ворсин Петр Евгеньевич', '1qz4kw@mail.com', 'gynQMT');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (6, 2, 'Старикова Елена Павловна', '4np6se@mail.com', 'AtnDjr');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (7, 3, 'Никифорова Весения Николаевна', 'yzls62@outlook.com', 'JlFRCZ');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (8, 3, 'Сазонов Руслан Германович', '1diph5e@tutanota.com', '8ntwUp');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (9, 3, 'Одинцов Серафим Артёмович', 'tjde7c@yahoo.com', 'YOyhfR');
INSERT INTO public."Users" (id, "roleId", "FIO", login, password) OVERRIDING SYSTEM VALUE VALUES (10, 3, 'Степанов Михаил Артёмович', 'wpmrc3do@tutanota.com', 'RSbvHv');


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 221
-- Name: Cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cities_id_seq"', 1, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 237
-- Name: Manufacturers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Manufacturers_id_seq"', 10, true);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 225
-- Name: OrderStatuses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."OrderStatuses_id_seq"', 2, true);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 231
-- Name: Orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Orders_id_seq"', 10, true);


--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 223
-- Name: PickupPoints_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."PickupPoints_id_seq"', 36, true);


--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 239
-- Name: ProductCategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductCategories_id_seq"', 4, true);


--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 242
-- Name: ProductsInOrders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."ProductsInOrders_id_seq"', 20, true);


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 227
-- Name: Roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Roles_id_seq"', 3, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 219
-- Name: Streets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Streets_id_seq"', 30, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 235
-- Name: Suppliers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Suppliers_id_seq"', 18, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 233
-- Name: UnitsOfMeansurement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."UnitsOfMeansurement_id_seq"', 1, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 229
-- Name: Users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Users_id_seq"', 10, true);


--
-- TOC entry 4918 (class 2606 OID 16723)
-- Name: Cities Cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cities"
    ADD CONSTRAINT "Cities_pkey" PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 16843)
-- Name: Manufacturers Manufacturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Manufacturers"
    ADD CONSTRAINT "Manufacturers_pkey" PRIMARY KEY (id);


--
-- TOC entry 4922 (class 2606 OID 16743)
-- Name: OrderStatuses OrderStatuses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrderStatuses"
    ADD CONSTRAINT "OrderStatuses_pkey" PRIMARY KEY (id);


--
-- TOC entry 4928 (class 2606 OID 16778)
-- Name: Orders Orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_pkey" PRIMARY KEY (id);


--
-- TOC entry 4920 (class 2606 OID 16733)
-- Name: PickupPoints PickupPoints_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PickupPoints"
    ADD CONSTRAINT "PickupPoints_pkey" PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 16853)
-- Name: ProductCategories ProductCategories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductCategories"
    ADD CONSTRAINT "ProductCategories_pkey" PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 16900)
-- Name: ProductsInOrders ProductsInOrders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductsInOrders"
    ADD CONSTRAINT "ProductsInOrders_pkey" PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 16869)
-- Name: Products Products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_pkey" PRIMARY KEY (id);


--
-- TOC entry 4924 (class 2606 OID 16753)
-- Name: Roles Roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Roles"
    ADD CONSTRAINT "Roles_pkey" PRIMARY KEY (id);


--
-- TOC entry 4916 (class 2606 OID 16713)
-- Name: Streets Streets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Streets"
    ADD CONSTRAINT "Streets_pkey" PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 16833)
-- Name: Suppliers Suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Suppliers"
    ADD CONSTRAINT "Suppliers_pkey" PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 16823)
-- Name: UnitsOfMeansurement UnitsOfMeansurement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UnitsOfMeansurement"
    ADD CONSTRAINT "UnitsOfMeansurement_pkey" PRIMARY KEY (id);


--
-- TOC entry 4926 (class 2606 OID 16766)
-- Name: Users Users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_pkey" PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 16789)
-- Name: Orders Orders_orderStatusId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_orderStatusId_fkey" FOREIGN KEY ("orderStatusId") REFERENCES public."OrderStatuses"(id);


--
-- TOC entry 4945 (class 2606 OID 16779)
-- Name: Orders Orders_pickupPointId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_pickupPointId_fkey" FOREIGN KEY ("pickupPointId") REFERENCES public."PickupPoints"(id);


--
-- TOC entry 4946 (class 2606 OID 16784)
-- Name: Orders Orders_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Orders"
    ADD CONSTRAINT "Orders_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."Users"(id);


--
-- TOC entry 4941 (class 2606 OID 16794)
-- Name: PickupPoints PickupPoints_cityId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PickupPoints"
    ADD CONSTRAINT "PickupPoints_cityId_fkey" FOREIGN KEY ("cityId") REFERENCES public."Cities"(id) NOT VALID;


--
-- TOC entry 4942 (class 2606 OID 16799)
-- Name: PickupPoints PickupPoints_streetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PickupPoints"
    ADD CONSTRAINT "PickupPoints_streetId_fkey" FOREIGN KEY ("streetId") REFERENCES public."Streets"(id) NOT VALID;


--
-- TOC entry 4951 (class 2606 OID 16901)
-- Name: ProductsInOrders ProductsInOrders_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductsInOrders"
    ADD CONSTRAINT "ProductsInOrders_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Orders"(id);


--
-- TOC entry 4952 (class 2606 OID 16906)
-- Name: ProductsInOrders ProductsInOrders_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ProductsInOrders"
    ADD CONSTRAINT "ProductsInOrders_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Products"(id);


--
-- TOC entry 4947 (class 2606 OID 16885)
-- Name: Products Products_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."ProductCategories"(id);


--
-- TOC entry 4948 (class 2606 OID 16880)
-- Name: Products Products_manufacturerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_manufacturerId_fkey" FOREIGN KEY ("manufacturerId") REFERENCES public."Manufacturers"(id);


--
-- TOC entry 4949 (class 2606 OID 16875)
-- Name: Products Products_supplierId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_supplierId_fkey" FOREIGN KEY ("supplierId") REFERENCES public."Suppliers"(id);


--
-- TOC entry 4950 (class 2606 OID 16870)
-- Name: Products Products_unitOfMeansurementId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Products"
    ADD CONSTRAINT "Products_unitOfMeansurementId_fkey" FOREIGN KEY ("unitOfMeansurementId") REFERENCES public."UnitsOfMeansurement"(id);


--
-- TOC entry 4943 (class 2606 OID 16911)
-- Name: Users Users_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Users"
    ADD CONSTRAINT "Users_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public."Roles"(id) NOT VALID;

