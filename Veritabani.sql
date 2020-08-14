--
-- PostgreSQL database dump
--

-- Dumped from database version 11.8
-- Dumped by pg_dump version 12rc1

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

--
-- Name: bakiyeDegisikligiTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."bakiyeDegisikligiTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."bakiye" <> OLD."bakiye" THEN
        INSERT INTO "BakiyeDegisikligiIzle"("urunNo", "eskiBakiye", "yeniBakiye", "degisiklikTarihi")
        VALUES(OLD."uyeNo", OLD."bakiye", NEW."bakiye", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."bakiyeDegisikligiTR1"() OWNER TO postgres;

--
-- Name: cevirdolar(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cevirdolar(kitapnumarasi integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
    DECLARE
    sonuc TEXT;
    kitap record;
    dolar FLOAT;
    
    BEGIN
        kitap:="public"."kitapgetir"(kitapNumarasi);
        
        dolar:=kitap.kitabinfiyati/5.9;
        
       
            RETURN dolar;
        
      
    END    
$$;


ALTER FUNCTION public.cevirdolar(kitapnumarasi integer) OWNER TO postgres;

--
-- Name: kayitEkleTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."kayitEkleTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."ad" = UPPER(NEW."ad"); 
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."kayitEkleTR1"() OWNER TO postgres;

--
-- Name: kdvekle(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kdvekle(kitapnumarasi integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
    DECLARE
    sonuc TEXT;
    kitap record;
    kdvliFiyat FLOAT;
    
    BEGIN
        kitap:="public"."kitapgetir"(kitapNumarasi);
        
        kdvliFiyat:=(kitap.kitabinfiyati*108)/100;
        
       
            RETURN kdvliFiyat;
        
      
    END    
$$;


ALTER FUNCTION public.kdvekle(kitapnumarasi integer) OWNER TO postgres;

--
-- Name: kitapgetir(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.kitapgetir(aranankitap integer) RETURNS TABLE(kitapno integer, kitabinfiyati integer)
    LANGUAGE plpgsql
    AS $$


   BEGIN
        RETURN QUERY SELECT "kitapNo","fiyat" FROM "public"."Kitap"
        WHERE "kitapNo"=arananKitap;

   END

$$;


ALTER FUNCTION public.kitapgetir(aranankitap integer) OWNER TO postgres;

--
-- Name: ogrenciindirimi(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciindirimi(kitapnumarasi integer) RETURNS double precision
    LANGUAGE plpgsql
    AS $$
    DECLARE
    sonuc TEXT;
    kitap record;
    indirimliFiyat FLOAT;
    
    BEGIN
        kitap:="public"."kitapgetir"(kitapNumarasi);
        
        indirimliFiyat:=(kitap.kitabinfiyati*80)/100;
        
       
            RETURN indirimliFiyat;
        
      
    END    
$$;


ALTER FUNCTION public.ogrenciindirimi(kitapnumarasi integer) OWNER TO postgres;

--
-- Name: urunDegisikligiTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."urunDegisikligiTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW."fiyat" <> OLD."fiyat" THEN
        INSERT INTO "UrunDegisikligiIzle"("urunNo", "eskiBirimFiyat", "yeniBirimFiyat", "degisiklikTarihi")
        VALUES(OLD."kitapNo", OLD."fiyat", NEW."fiyat", CURRENT_TIMESTAMP::TIMESTAMP);
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public."urunDegisikligiTR1"() OWNER TO postgres;

--
-- Name: yazarKayitEkleTR1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."yazarKayitEkleTR1"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW."ad" = UPPER(NEW."ad");
    NEW."soyad" = UPPER(NEW."soyad");
    RETURN NEW;
END;
$$;


ALTER FUNCTION public."yazarKayitEkleTR1"() OWNER TO postgres;

SET default_tablespace = '';

--
-- Name: Adres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Adres" (
    "adresNo" integer NOT NULL,
    mahalle character(2044) NOT NULL,
    cadde character(2044) NOT NULL,
    sokak character(2044) NOT NULL,
    "binaNo" character(2044) NOT NULL,
    "daireNo" character(2044) NOT NULL,
    ilce character(2044) NOT NULL,
    il character(2044) NOT NULL,
    ulke character(2044) NOT NULL
);


ALTER TABLE public."Adres" OWNER TO postgres;

--
-- Name: AramaYapma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AramaYapma" (
    "aramaNo" integer NOT NULL,
    "anahtarKelime" character(2044) NOT NULL
);


ALTER TABLE public."AramaYapma" OWNER TO postgres;

--
-- Name: BakiyeDegisikligiIzle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BakiyeDegisikligiIzle" (
    "UrunNo" integer NOT NULL,
    "uyeNo" smallint NOT NULL,
    "eskiBakiye" real NOT NULL,
    "yeniBakiye" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."BakiyeDegisikligiIzle" OWNER TO postgres;

--
-- Name: BakiyeDegisikligiIzle_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."BakiyeDegisikligiIzle_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."BakiyeDegisikligiIzle_kayitNo_seq" OWNER TO postgres;

--
-- Name: BakiyeDegisikligiIzle_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."BakiyeDegisikligiIzle_kayitNo_seq" OWNED BY public."BakiyeDegisikligiIzle"."UrunNo";


--
-- Name: FiyatDegisikligiIzle; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FiyatDegisikligiIzle" (
    "kayitNo" integer NOT NULL,
    "kitapNo" smallint NOT NULL,
    "eskiBirimFiyat" real NOT NULL,
    "yeniBirimFiyat" real NOT NULL,
    "degisiklikTarihi" timestamp without time zone NOT NULL
);


ALTER TABLE public."FiyatDegisikligiIzle" OWNER TO postgres;

--
-- Name: FiyatDegisikligiIzle_kayitNo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."FiyatDegisikligiIzle_kayitNo_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."FiyatDegisikligiIzle_kayitNo_seq" OWNER TO postgres;

--
-- Name: FiyatDegisikligiIzle_kayitNo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."FiyatDegisikligiIzle_kayitNo_seq" OWNED BY public."FiyatDegisikligiIzle"."kayitNo";


--
-- Name: Kitap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kitap" (
    "kitapNo" integer NOT NULL,
    "yazarNo" integer NOT NULL,
    "yayineviNo" integer NOT NULL,
    "turNo" integer NOT NULL,
    "sayfaSayisi" integer NOT NULL,
    fiyat integer NOT NULL,
    ad character(2044) NOT NULL,
    "yayinYili" character(2044) NOT NULL,
    dil character(2044) NOT NULL
);


ALTER TABLE public."Kitap" OWNER TO postgres;

--
-- Name: KitapTur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapTur" (
    "turNo" integer NOT NULL,
    "kitapNo" integer NOT NULL
);


ALTER TABLE public."KitapTur" OWNER TO postgres;

--
-- Name: KitapYazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KitapYazar" (
    "kitapNo" integer NOT NULL,
    "yazarNo" integer NOT NULL
);


ALTER TABLE public."KitapYazar" OWNER TO postgres;

--
-- Name: Kullanici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kullanici" (
    "kullaniciNo" integer NOT NULL,
    adi character(2044) NOT NULL,
    soyadi character(2044) NOT NULL,
    email character(2044) NOT NULL,
    sifre character(2044) NOT NULL
);


ALTER TABLE public."Kullanici" OWNER TO postgres;

--
-- Name: KullaniciArama; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."KullaniciArama" (
    "kullaniciNo" integer NOT NULL,
    "aramaNo" integer NOT NULL,
    "aramaSayisi" integer NOT NULL
);


ALTER TABLE public."KullaniciArama" OWNER TO postgres;

--
-- Name: MadalyaKazanma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MadalyaKazanma" (
    "madalyanNo" integer NOT NULL,
    tur character(1) NOT NULL,
    "madalyaSayisi" integer NOT NULL
);


ALTER TABLE public."MadalyaKazanma" OWNER TO postgres;

--
-- Name: Misafir; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Misafir" (
    "kullaniciNo" integer NOT NULL,
    "kullaniciAdi" character(1) NOT NULL,
    sifre character(1) NOT NULL
);


ALTER TABLE public."Misafir" OWNER TO postgres;

--
-- Name: Sepet; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Sepet" (
    "sepetNo" integer NOT NULL,
    "kullaniciNo" integer NOT NULL,
    "kitapNo" integer NOT NULL
);


ALTER TABLE public."Sepet" OWNER TO postgres;

--
-- Name: Tur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tur" (
    "turNo" integer NOT NULL,
    ad character(2044) NOT NULL
);


ALTER TABLE public."Tur" OWNER TO postgres;

--
-- Name: Uye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Uye" (
    "kullaniciNo" integer NOT NULL,
    "adresNo" integer NOT NULL,
    "sepetNo" integer NOT NULL,
    bakiye integer NOT NULL
);


ALTER TABLE public."Uye" OWNER TO postgres;

--
-- Name: UyeMadalya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."UyeMadalya" (
    "kullaniciNo" integer NOT NULL,
    "madalyaNo" integer NOT NULL
);


ALTER TABLE public."UyeMadalya" OWNER TO postgres;

--
-- Name: YayinEvi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."YayinEvi" (
    "yayineviNo" integer NOT NULL,
    "adresNo" integer NOT NULL,
    ad character(2044) NOT NULL,
    "telefonNo" character(2044) NOT NULL,
    site character(2044) NOT NULL,
    "tedarikSuresi" integer NOT NULL
);


ALTER TABLE public."YayinEvi" OWNER TO postgres;

--
-- Name: Yazar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yazar" (
    "yazarNo" integer NOT NULL,
    ad character(2044) NOT NULL,
    soyad character(2044) NOT NULL
);


ALTER TABLE public."Yazar" OWNER TO postgres;

--
-- Name: BakiyeDegisikligiIzle UrunNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BakiyeDegisikligiIzle" ALTER COLUMN "UrunNo" SET DEFAULT nextval('public."BakiyeDegisikligiIzle_kayitNo_seq"'::regclass);


--
-- Name: FiyatDegisikligiIzle kayitNo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FiyatDegisikligiIzle" ALTER COLUMN "kayitNo" SET DEFAULT nextval('public."FiyatDegisikligiIzle_kayitNo_seq"'::regclass);


--
-- Data for Name: Adres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Adres" VALUES
	(1, 'mah                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 'cad                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 'sok                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', '1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', '1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', 'kucukc                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      ', 'istanbul                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 'turkiye                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     '),
	(2, 'zirve                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'bag                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ', 'gunes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', '54                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', '3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           ', 'fatih                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'istanbul                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 'turkiye                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     '),
	(3, 'sahin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'ay                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', 'jupiter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', '24                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', '17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          ', 'besiktas                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 'istanbul                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 'turkiye                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ');


--
-- Data for Name: AramaYapma; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: BakiyeDegisikligiIzle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: FiyatDegisikligiIzle; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Kitap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kitap" VALUES
	(2, 2, 2, 2, 454, 35, 'beyin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', '2016                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', 'turkce                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      '),
	(3, 3, 3, 3, 235, 20, 'sapiens                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', '2015                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', 'ingilizce                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   ');


--
-- Data for Name: KitapTur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KitapTur" VALUES
	(2, 2),
	(3, 3);


--
-- Data for Name: KitapYazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."KitapYazar" VALUES
	(2, 2),
	(3, 3);


--
-- Data for Name: Kullanici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kullanici" VALUES
	(1, 'ayse                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', 'fatma                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'ada@hotmail.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             ', '1234                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ');


--
-- Data for Name: KullaniciArama; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: MadalyaKazanma; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Misafir; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Sepet; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Sepet" VALUES
	(1, 1, 2),
	(2, 1, 3);


--
-- Data for Name: Tur; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Tur" VALUES
	(1, 'polisiye                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    '),
	(2, 'ask                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         '),
	(3, 'siyaset                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ');


--
-- Data for Name: Uye; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Uye" VALUES
	(1, 1, 1, 299);


--
-- Data for Name: UyeMadalya; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: YayinEvi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."YayinEvi" VALUES
	(2, 2, 'domingo                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', '0534232532                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 'domingo.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ', 2),
	(3, 3, 'alfa                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ', '0544235435                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  ', 'alfa.com                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ', 4);


--
-- Data for Name: Yazar; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yazar" VALUES
	(1, 'ahmet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'mehmet                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      '),
	(2, 'hüseyin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     ', 'alp                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         '),
	(3, 'abdul                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ', 'berk                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        ');


--
-- Name: BakiyeDegisikligiIzle_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."BakiyeDegisikligiIzle_kayitNo_seq"', 1, false);


--
-- Name: FiyatDegisikligiIzle_kayitNo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."FiyatDegisikligiIzle_kayitNo_seq"', 1, false);


--
-- Name: BakiyeDegisikligiIzle  ; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BakiyeDegisikligiIzle"
    ADD CONSTRAINT " " PRIMARY KEY ("UrunNo");


--
-- Name: Adres Adres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Adres"
    ADD CONSTRAINT "Adres_pkey" PRIMARY KEY ("adresNo");


--
-- Name: AramaYapma AramaYapma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AramaYapma"
    ADD CONSTRAINT "AramaYapma_pkey" PRIMARY KEY ("aramaNo");


--
-- Name: KitapTur KitapTur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "KitapTur_pkey" PRIMARY KEY ("turNo", "kitapNo");


--
-- Name: KitapYazar KitapYazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "KitapYazar_pkey" PRIMARY KEY ("kitapNo", "yazarNo");


--
-- Name: Kitap Kitap_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "Kitap_pkey" PRIMARY KEY ("kitapNo");


--
-- Name: KullaniciArama KullaniciArama_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciArama"
    ADD CONSTRAINT "KullaniciArama_pkey" PRIMARY KEY ("kullaniciNo", "aramaNo");


--
-- Name: Kullanici Kullanici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kullanici"
    ADD CONSTRAINT "Kullanici_pkey" PRIMARY KEY ("kullaniciNo");


--
-- Name: MadalyaKazanma MadalyaKazanma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MadalyaKazanma"
    ADD CONSTRAINT "MadalyaKazanma_pkey" PRIMARY KEY ("madalyanNo");


--
-- Name: Misafir Misafir_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Misafir"
    ADD CONSTRAINT "Misafir_pkey" PRIMARY KEY ("kullaniciNo");


--
-- Name: FiyatDegisikligiIzle PK; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FiyatDegisikligiIzle"
    ADD CONSTRAINT "PK" PRIMARY KEY ("kayitNo");


--
-- Name: Sepet Sepet_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sepet"
    ADD CONSTRAINT "Sepet_pkey" PRIMARY KEY ("sepetNo");


--
-- Name: Tur Tur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tur"
    ADD CONSTRAINT "Tur_pkey" PRIMARY KEY ("turNo");


--
-- Name: UyeMadalya UyeMadalya_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UyeMadalya"
    ADD CONSTRAINT "UyeMadalya_pkey" PRIMARY KEY ("kullaniciNo", "madalyaNo");


--
-- Name: Uye Uye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "Uye_pkey" PRIMARY KEY ("kullaniciNo");


--
-- Name: YayinEvi YayinEvi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YayinEvi"
    ADD CONSTRAINT "YayinEvi_pkey" PRIMARY KEY ("yayineviNo");


--
-- Name: Yazar Yazar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yazar"
    ADD CONSTRAINT "Yazar_pkey" PRIMARY KEY ("yazarNo");


--
-- Name: YayinEvi kayitKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "kayitKontrol" BEFORE INSERT ON public."YayinEvi" FOR EACH ROW EXECUTE PROCEDURE public."kayitEkleTR1"();


--
-- Name: Yazar yazarKayitKontrol; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "yazarKayitKontrol" BEFORE INSERT ON public."Yazar" FOR EACH ROW EXECUTE PROCEDURE public."yazarKayitEkleTR1"();


--
-- Name: Misafir KullaniciMisafir; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Misafir"
    ADD CONSTRAINT "KullaniciMisafir" FOREIGN KEY ("kullaniciNo") REFERENCES public."Kullanici"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UyeMadalya UyeMadalyaKazanma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UyeMadalya"
    ADD CONSTRAINT "UyeMadalyaKazanma" FOREIGN KEY ("madalyaNo") REFERENCES public."MadalyaKazanma"("madalyanNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Uye lnk_Adres_Uye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "lnk_Adres_Uye" FOREIGN KEY ("adresNo") REFERENCES public."Adres"("adresNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: YayinEvi lnk_Adres_YayinEvi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."YayinEvi"
    ADD CONSTRAINT "lnk_Adres_YayinEvi" FOREIGN KEY ("adresNo") REFERENCES public."Adres"("adresNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KullaniciArama lnk_AramaYapma_KullaniciArama; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciArama"
    ADD CONSTRAINT "lnk_AramaYapma_KullaniciArama" FOREIGN KEY ("aramaNo") REFERENCES public."AramaYapma"("aramaNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapTur lnk_Kitap_KitapTur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "lnk_Kitap_KitapTur" FOREIGN KEY ("kitapNo") REFERENCES public."Kitap"("kitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapYazar lnk_Kitap_KitapYazar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "lnk_Kitap_KitapYazar" FOREIGN KEY ("kitapNo") REFERENCES public."Kitap"("kitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Sepet lnk_Kitap_Sepet; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Sepet"
    ADD CONSTRAINT "lnk_Kitap_Sepet" FOREIGN KEY ("kitapNo") REFERENCES public."Kitap"("kitapNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KullaniciArama lnk_Kullanici_KullaniciArama; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KullaniciArama"
    ADD CONSTRAINT "lnk_Kullanici_KullaniciArama" FOREIGN KEY ("kullaniciNo") REFERENCES public."Kullanici"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Uye lnk_Kullanici_Uye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "lnk_Kullanici_Uye" FOREIGN KEY ("kullaniciNo") REFERENCES public."Kullanici"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Uye lnk_Sepet_Uye; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Uye"
    ADD CONSTRAINT "lnk_Sepet_Uye" FOREIGN KEY ("sepetNo") REFERENCES public."Sepet"("sepetNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapTur lnk_Tur_KitapTur; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapTur"
    ADD CONSTRAINT "lnk_Tur_KitapTur" FOREIGN KEY ("turNo") REFERENCES public."Tur"("turNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kitap lnk_YayinEvi_Kitap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kitap"
    ADD CONSTRAINT "lnk_YayinEvi_Kitap" FOREIGN KEY ("yayineviNo") REFERENCES public."YayinEvi"("yayineviNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: KitapYazar lnk_Yazar_KitapYazar; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."KitapYazar"
    ADD CONSTRAINT "lnk_Yazar_KitapYazar" FOREIGN KEY ("yazarNo") REFERENCES public."Yazar"("yazarNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UyeMadalya uyeMadalya; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."UyeMadalya"
    ADD CONSTRAINT "uyeMadalya" FOREIGN KEY ("kullaniciNo") REFERENCES public."Uye"("kullaniciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

