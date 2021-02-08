--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Ubuntu 13.0-1.pgdg20.04+1)
-- Dumped by pg_dump version 13.0 (Ubuntu 13.0-1.pgdg20.04+1)

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
-- Name: SequelizeMeta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SequelizeMeta" (
    name character varying(255) NOT NULL
);


ALTER TABLE public."SequelizeMeta" OWNER TO postgres;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    id integer NOT NULL,
    user_id integer NOT NULL,
    account_type_id integer NOT NULL,
    total_balance numeric DEFAULT 0,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_id_seq OWNER TO postgres;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- Name: account_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_type (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.account_type OWNER TO postgres;

--
-- Name: account_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_type_id_seq OWNER TO postgres;

--
-- Name: account_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_type_id_seq OWNED BY public.account_type.id;


--
-- Name: transaction; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaction (
    id integer NOT NULL,
    from_account integer NOT NULL,
    to_account integer NOT NULL,
    total_amount_transfer numeric NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public.transaction OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.transaction_id_seq OWNER TO postgres;

--
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP(3) NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- Name: account_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_type ALTER COLUMN id SET DEFAULT nextval('public.account_type_id_seq'::regclass);


--
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: SequelizeMeta; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SequelizeMeta" (name) FROM stdin;
A-account_type.js
B-user.js
C-account.js
D-transaction.js
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (id, user_id, account_type_id, total_balance, created_at, updated_at) FROM stdin;
2	1	3	50000.00	2021-02-08 20:18:03.15+05:30	2021-02-08 20:18:03.15+05:30
8	2	3	50000.00	2021-02-08 20:29:28.383+05:30	2021-02-08 20:29:28.383+05:30
9	3	3	50000.00	2021-02-08 20:29:40.8+05:30	2021-02-08 20:29:40.8+05:30
5	1	2	50000.00	2021-02-08 20:20:21.871+05:30	2021-02-08 20:20:21.871+05:30
11	3	1	50000.00	2021-02-08 20:29:48.193+05:30	2021-02-08 20:29:48.193+05:30
3	1	2	75000	2021-02-08 20:18:58.388+05:30	2021-02-09 00:24:42.139+05:30
7	2	1	0	2021-02-08 20:29:24.329+05:30	2021-02-09 00:27:03.444+05:30
4	1	2	75000	2021-02-08 20:19:38.234+05:30	2021-02-09 00:27:03.456+05:30
6	2	2	26000	2021-02-08 20:29:18.541+05:30	2021-02-09 01:01:28.48+05:30
10	3	2	74000	2021-02-08 20:29:44.66+05:30	2021-02-09 01:01:28.497+05:30
\.


--
-- Data for Name: account_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_type (id, type, created_at, updated_at) FROM stdin;
1	SAVINGS	2021-02-08 17:38:08.005+05:30	2021-02-08 17:38:08.005+05:30
2	CURRENT	2021-02-08 17:38:08.005+05:30	2021-02-08 17:38:08.005+05:30
3	BASIC_SAVINGS	2021-02-08 17:38:08.005+05:30	2021-02-08 17:38:08.005+05:30
\.


--
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaction (id, from_account, to_account, total_amount_transfer, created_at, updated_at) FROM stdin;
1	7	3	25000	2021-02-09 00:16:12.468+05:30	2021-02-09 00:16:12.468+05:30
2	7	3	25000	2021-02-09 00:24:42.143+05:30	2021-02-09 00:24:42.143+05:30
3	7	4	25000	2021-02-09 00:27:03.46+05:30	2021-02-09 00:27:03.46+05:30
4	6	10	2000	2021-02-09 00:48:30.938+05:30	2021-02-09 00:48:30.938+05:30
5	6	10	2000	2021-02-09 00:49:50.407+05:30	2021-02-09 00:49:50.407+05:30
6	6	10	2000	2021-02-09 00:51:54.495+05:30	2021-02-09 00:51:54.495+05:30
7	6	10	2000	2021-02-09 00:52:22.977+05:30	2021-02-09 00:52:22.977+05:30
8	6	10	2000	2021-02-09 00:53:22.45+05:30	2021-02-09 00:53:22.45+05:30
9	6	10	2000	2021-02-09 00:54:14.432+05:30	2021-02-09 00:54:14.432+05:30
10	6	10	2000	2021-02-09 00:55:09.524+05:30	2021-02-09 00:55:09.524+05:30
11	6	10	2000	2021-02-09 00:55:19.869+05:30	2021-02-09 00:55:19.869+05:30
12	6	10	2000	2021-02-09 00:56:50.778+05:30	2021-02-09 00:56:50.778+05:30
13	6	10	2000	2021-02-09 00:58:28.909+05:30	2021-02-09 00:58:28.909+05:30
14	6	10	2000	2021-02-09 01:01:06.166+05:30	2021-02-09 01:01:06.166+05:30
15	6	10	2000	2021-02-09 01:01:28.501+05:30	2021-02-09 01:01:28.501+05:30
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, first_name, last_name, created_at, updated_at) FROM stdin;
1	vaibhav	sharma	2021-02-08 17:36:16.952+05:30	2021-02-08 17:36:16.952+05:30
2	sagar	sharma	2021-02-08 17:36:16.952+05:30	2021-02-08 17:36:16.952+05:30
3	pranjul	sharma	2021-02-08 17:36:16.952+05:30	2021-02-08 17:36:16.952+05:30
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_id_seq', 11, true);


--
-- Name: account_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_type_id_seq', 3, true);


--
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaction_id_seq', 15, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: SequelizeMeta SequelizeMeta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SequelizeMeta"
    ADD CONSTRAINT "SequelizeMeta_pkey" PRIMARY KEY (name);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account_type account_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_type
    ADD CONSTRAINT account_type_pkey PRIMARY KEY (id);


--
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: account account_account_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_account_type_id_fkey FOREIGN KEY (account_type_id) REFERENCES public.account_type(id);


--
-- Name: account account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: transaction transaction_from_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_from_account_fkey FOREIGN KEY (from_account) REFERENCES public.account(id);


--
-- Name: transaction transaction_to_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_to_account_fkey FOREIGN KEY (to_account) REFERENCES public.account(id);


--
-- PostgreSQL database dump complete
--

