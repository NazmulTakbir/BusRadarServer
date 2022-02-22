--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2022-02-22 17:31:17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 16880)
-- Name: bus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus (
    bus_id integer NOT NULL,
    company_id integer NOT NULL,
    tracker_id integer NOT NULL,
    route_id integer NOT NULL
);


ALTER TABLE public.bus OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16879)
-- Name: bus_bus_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_bus_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_bus_id_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 217
-- Name: bus_bus_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_bus_id_seq OWNED BY public.bus.bus_id;


--
-- TOC entry 216 (class 1259 OID 16871)
-- Name: bus_route; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_route (
    route_id integer NOT NULL,
    bus_stop_list integer[] NOT NULL
);


ALTER TABLE public.bus_route OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16870)
-- Name: bus_route_route_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_route_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_route_route_id_seq OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 215
-- Name: bus_route_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_route_route_id_seq OWNED BY public.bus_route.route_id;


--
-- TOC entry 210 (class 1259 OID 16840)
-- Name: bus_stops; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bus_stops (
    bus_stop_id integer NOT NULL,
    address text NOT NULL,
    lactitude numeric NOT NULL,
    longitude numeric NOT NULL,
    CONSTRAINT bus_stops_lactitude_check CHECK (((lactitude >= ('-90'::integer)::numeric) AND (lactitude <= (90)::numeric))),
    CONSTRAINT bus_stops_longitude_check CHECK (((longitude >= ('-180'::integer)::numeric) AND (longitude <= (180)::numeric)))
);


ALTER TABLE public.bus_stops OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16839)
-- Name: bus_stops_bus_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bus_stops_bus_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bus_stops_bus_stop_id_seq OWNER TO postgres;

--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 209
-- Name: bus_stops_bus_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bus_stops_bus_stop_id_seq OWNED BY public.bus_stops.bus_stop_id;


--
-- TOC entry 212 (class 1259 OID 16853)
-- Name: company; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.company (
    company_id integer NOT NULL,
    company_name text NOT NULL
);


ALTER TABLE public.company OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16852)
-- Name: company_company_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.company_company_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.company_company_id_seq OWNER TO postgres;

--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 211
-- Name: company_company_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.company_company_id_seq OWNED BY public.company.company_id;


--
-- TOC entry 214 (class 1259 OID 16862)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    customer_id integer NOT NULL,
    customer_name text NOT NULL
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16861)
-- Name: customer_customer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_customer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.customer_customer_id_seq OWNER TO postgres;

--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 213
-- Name: customer_customer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_customer_id_seq OWNED BY public.customer.customer_id;


--
-- TOC entry 224 (class 1259 OID 16927)
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    rating integer NOT NULL,
    review_data date DEFAULT CURRENT_DATE,
    comment character varying(63),
    bus_no integer NOT NULL,
    customer_id integer NOT NULL,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16926)
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_review_id_seq OWNER TO postgres;

--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 223
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- TOC entry 220 (class 1259 OID 16897)
-- Name: ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket (
    ticket_id integer NOT NULL,
    bus_no integer NOT NULL,
    start_index integer NOT NULL,
    end_index integer NOT NULL,
    route_id integer NOT NULL,
    price integer NOT NULL
);


ALTER TABLE public.ticket OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16914)
-- Name: ticket_price; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ticket_price (
    ticket_price_id integer NOT NULL,
    ticket_id integer NOT NULL,
    price integer NOT NULL,
    date_modified date DEFAULT CURRENT_DATE
);


ALTER TABLE public.ticket_price OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16913)
-- Name: ticket_price_ticket_price_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_price_ticket_price_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_price_ticket_price_id_seq OWNER TO postgres;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 221
-- Name: ticket_price_ticket_price_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_price_ticket_price_id_seq OWNED BY public.ticket_price.ticket_price_id;


--
-- TOC entry 219 (class 1259 OID 16896)
-- Name: ticket_ticket_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ticket_ticket_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ticket_ticket_id_seq OWNER TO postgres;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 219
-- Name: ticket_ticket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ticket_ticket_id_seq OWNED BY public.ticket.ticket_id;


--
-- TOC entry 3205 (class 2604 OID 16883)
-- Name: bus bus_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus ALTER COLUMN bus_id SET DEFAULT nextval('public.bus_bus_id_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 16874)
-- Name: bus_route route_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_route ALTER COLUMN route_id SET DEFAULT nextval('public.bus_route_route_id_seq'::regclass);


--
-- TOC entry 3199 (class 2604 OID 16843)
-- Name: bus_stops bus_stop_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_stops ALTER COLUMN bus_stop_id SET DEFAULT nextval('public.bus_stops_bus_stop_id_seq'::regclass);


--
-- TOC entry 3202 (class 2604 OID 16856)
-- Name: company company_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company ALTER COLUMN company_id SET DEFAULT nextval('public.company_company_id_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 16865)
-- Name: customer customer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer ALTER COLUMN customer_id SET DEFAULT nextval('public.customer_customer_id_seq'::regclass);


--
-- TOC entry 3209 (class 2604 OID 16930)
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- TOC entry 3206 (class 2604 OID 16900)
-- Name: ticket ticket_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket ALTER COLUMN ticket_id SET DEFAULT nextval('public.ticket_ticket_id_seq'::regclass);


--
-- TOC entry 3207 (class 2604 OID 16917)
-- Name: ticket_price ticket_price_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_price ALTER COLUMN ticket_price_id SET DEFAULT nextval('public.ticket_price_ticket_price_id_seq'::regclass);


--
-- TOC entry 3387 (class 0 OID 16880)
-- Dependencies: 218
-- Data for Name: bus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus (bus_id, company_id, tracker_id, route_id) FROM stdin;
1	1	1	1
2	2	2	2
3	3	3	3
4	4	4	1
5	5	5	2
6	1	5	3
\.


--
-- TOC entry 3385 (class 0 OID 16871)
-- Dependencies: 216
-- Data for Name: bus_route; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_route (route_id, bus_stop_list) FROM stdin;
1	{1,2,3}
2	{4,3,5}
3	{6,7,8,4}
\.


--
-- TOC entry 3379 (class 0 OID 16840)
-- Dependencies: 210
-- Data for Name: bus_stops; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bus_stops (bus_stop_id, address, lactitude, longitude) FROM stdin;
1	Police Plaza	23.77372235339186	90.41619845459428
2	Gulshan 1	23.78051326059967	90.41711310674275
3	Gulshan 2	23.793947722834744	90.41499501226576
5	Notun Bazar	23.797599050613776	90.42374178343026
6	ECE	23.72727168429172	90.38917813481505
4	Mohammadpur	23.757263452796234	90.36175192970221
7	City College	23.739103034519097	90.38325668901471
8	Dhanmondi 15	23.744066035091272	90.37265141644683
\.


--
-- TOC entry 3381 (class 0 OID 16853)
-- Dependencies: 212
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.company (company_id, company_name) FROM stdin;
1	Saintmartin Hyundai
2	Saintmartin Paribahan
3	ShohagTravels
4	Volvo Travels
5	Green Line
\.


--
-- TOC entry 3383 (class 0 OID 16862)
-- Dependencies: 214
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (customer_id, customer_name) FROM stdin;
1	Asif
2	Nawmi
3	Takbir
4	Afnan
5	Saif
6	Sharif
\.


--
-- TOC entry 3393 (class 0 OID 16927)
-- Dependencies: 224
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, rating, review_data, comment, bus_no, customer_id) FROM stdin;
1	2	2022-02-21	Very poor service!	1	1
2	3	2022-02-21	Improvement needed!	1	2
3	2	2022-02-21	Driver drives recklessly.	1	3
4	1	2022-02-21	Seat cover repair needed.	1	4
5	5	2022-02-21	Very good service!	2	1
6	5	2022-02-21	Quality is satisfactory!	2	5
7	4	2022-02-21	Driver drives sincerely.	2	3
8	3	2022-02-21	Punctuality needed.	2	6
9	5	2022-02-21	Very nice service!	3	1
10	5	2022-02-21	Quality is good!	3	5
11	4	2022-02-21	Driver drives carefully.	4	3
12	5	2022-02-21	Punctuality maintained.	4	6
\.


--
-- TOC entry 3389 (class 0 OID 16897)
-- Dependencies: 220
-- Data for Name: ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket (ticket_id, bus_no, start_index, end_index, route_id, price) FROM stdin;
8	2	1	3	2	20
12	2	3	1	2	20
19	3	3	1	3	20
26	4	1	3	1	20
32	5	1	3	2	20
35	5	3	1	2	20
1	1	1	2	1	10
2	1	1	3	1	20
3	1	2	3	1	10
4	1	2	1	1	10
5	1	3	2	1	10
6	1	3	1	1	20
7	2	1	2	2	10
9	2	2	3	2	10
10	2	2	1	2	10
11	2	3	2	2	10
13	3	1	2	3	10
14	3	1	3	3	20
15	3	1	4	3	30
16	3	2	1	3	10
17	3	2	3	3	10
18	3	2	4	3	20
20	3	3	2	3	10
21	3	3	4	3	10
22	3	4	3	3	10
23	3	4	2	3	20
24	3	4	1	3	30
25	4	1	2	1	10
27	4	2	1	1	10
28	4	2	3	1	10
29	4	3	1	1	20
30	4	3	2	1	10
31	5	1	2	2	10
33	5	2	1	2	10
34	5	2	3	2	10
36	5	3	2	2	10
37	6	1	2	3	10
38	6	1	3	3	20
39	6	1	4	3	30
40	6	2	1	3	10
41	6	2	3	3	10
42	6	2	4	3	20
43	6	3	2	3	10
44	6	3	1	3	20
45	6	3	4	3	10
46	6	4	3	3	10
47	6	4	2	3	20
48	6	4	1	3	30
\.


--
-- TOC entry 3391 (class 0 OID 16914)
-- Dependencies: 222
-- Data for Name: ticket_price; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ticket_price (ticket_price_id, ticket_id, price, date_modified) FROM stdin;
\.


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 217
-- Name: bus_bus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_bus_id_seq', 6, true);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 215
-- Name: bus_route_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_route_route_id_seq', 3, true);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 209
-- Name: bus_stops_bus_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bus_stops_bus_stop_id_seq', 8, true);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 211
-- Name: company_company_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.company_company_id_seq', 5, true);


--
-- TOC entry 3411 (class 0 OID 0)
-- Dependencies: 213
-- Name: customer_customer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_customer_id_seq', 6, true);


--
-- TOC entry 3412 (class 0 OID 0)
-- Dependencies: 223
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 12, true);


--
-- TOC entry 3413 (class 0 OID 0)
-- Dependencies: 221
-- Name: ticket_price_ticket_price_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_price_ticket_price_id_seq', 1, false);


--
-- TOC entry 3414 (class 0 OID 0)
-- Dependencies: 219
-- Name: ticket_ticket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ticket_ticket_id_seq', 48, true);


--
-- TOC entry 3223 (class 2606 OID 16885)
-- Name: bus bus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT bus_pkey PRIMARY KEY (bus_id);


--
-- TOC entry 3221 (class 2606 OID 16878)
-- Name: bus_route bus_route_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_route
    ADD CONSTRAINT bus_route_pkey PRIMARY KEY (route_id);


--
-- TOC entry 3213 (class 2606 OID 16851)
-- Name: bus_stops bus_stops_lactitude_longitude_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_stops
    ADD CONSTRAINT bus_stops_lactitude_longitude_key UNIQUE (lactitude, longitude);


--
-- TOC entry 3215 (class 2606 OID 16849)
-- Name: bus_stops bus_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus_stops
    ADD CONSTRAINT bus_stops_pkey PRIMARY KEY (bus_stop_id);


--
-- TOC entry 3217 (class 2606 OID 16860)
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (company_id);


--
-- TOC entry 3219 (class 2606 OID 16869)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (customer_id);


--
-- TOC entry 3229 (class 2606 OID 16936)
-- Name: reviews reviews_bus_no_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_bus_no_customer_id_key UNIQUE (bus_no, customer_id);


--
-- TOC entry 3231 (class 2606 OID 16934)
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- TOC entry 3225 (class 2606 OID 16902)
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- TOC entry 3227 (class 2606 OID 16920)
-- Name: ticket_price ticket_price_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_price
    ADD CONSTRAINT ticket_price_pkey PRIMARY KEY (ticket_price_id);


--
-- TOC entry 3232 (class 2606 OID 16886)
-- Name: bus fk_bus_company; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT fk_bus_company FOREIGN KEY (company_id) REFERENCES public.company(company_id);


--
-- TOC entry 3237 (class 2606 OID 16937)
-- Name: reviews fk_bus_review; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_bus_review FOREIGN KEY (bus_no) REFERENCES public.bus(bus_id);


--
-- TOC entry 3233 (class 2606 OID 16891)
-- Name: bus fk_bus_route; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bus
    ADD CONSTRAINT fk_bus_route FOREIGN KEY (route_id) REFERENCES public.bus_route(route_id);


--
-- TOC entry 3234 (class 2606 OID 16903)
-- Name: ticket fk_bus_ticket; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_bus_ticket FOREIGN KEY (bus_no) REFERENCES public.bus(bus_id);


--
-- TOC entry 3238 (class 2606 OID 16942)
-- Name: reviews fk_customer_review; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT fk_customer_review FOREIGN KEY (customer_id) REFERENCES public.customer(customer_id);


--
-- TOC entry 3236 (class 2606 OID 16921)
-- Name: ticket_price fk_ticket_price; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket_price
    ADD CONSTRAINT fk_ticket_price FOREIGN KEY (ticket_id) REFERENCES public.ticket(ticket_id);


--
-- TOC entry 3235 (class 2606 OID 16908)
-- Name: ticket fk_ticket_route; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ticket
    ADD CONSTRAINT fk_ticket_route FOREIGN KEY (route_id) REFERENCES public.bus_route(route_id);


-- Completed on 2022-02-22 17:31:18

--
-- PostgreSQL database dump complete
--

