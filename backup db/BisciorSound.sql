PGDMP                         {            BisciorSound    14.4    14.4 B    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            J           1262    16394    BisciorSound    DATABASE     j   CREATE DATABASE "BisciorSound" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
    DROP DATABASE "BisciorSound";
                postgres    false            �            1255    41223    controllo_anno_albumtraccia()    FUNCTION     "  CREATE FUNCTION public.controllo_anno_albumtraccia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    annoA album.anno_uscita%TYPE;
    annoT traccia.versione%TYPE;
BEGIN
    SELECT Traccia.versione  INTO annoT
    FROM Traccia
    WHERE Traccia.nome = NEW.nome;
    
    SELECT album.annouscita INTO annoA
    FROM album
    WHERE album.nome = NEW.album;
    
    IF(annoT > annoA) THEN
	RAISE EXCEPTION 'L''anno della traccia non può essere maggiore all''anno di uscita dell''album di appartenenza!';
	END IF;
RETURN NULL;
END;

$$;
 4   DROP FUNCTION public.controllo_anno_albumtraccia();
       public          postgres    false            �            1255    41220    controllo_autorecover()    FUNCTION       CREATE FUNCTION public.controllo_autorecover() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    autoreC cover.autore%TYPE;
    autoreT traccia.autore%TYPE;
BEGIN
    SELECT cover.autore  INTO autoreC
    FROM Cover
    WHERE Cover.nome = NEW.nome;
    
    SELECT traccia.autore INTO autoreT
    FROM Traccia
    WHERE Traccia.nome LIKE '%NEW.nome%';
    
    IF(autoreC = autoreT) THEN
	RAISE EXCEPTION 'L''autore della cover deve essere diverso dall''autore della traccia!';
	END IF;
RETURN NULL;
END;

$$;
 .   DROP FUNCTION public.controllo_autorecover();
       public          postgres    false            �            1255    41208    controllo_lunghezzapassword()    FUNCTION     �  CREATE FUNCTION public.controllo_lunghezzapassword() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    pass_word utente.password%type;
BEGIN
	SELECT utente.password INTO pass_word
	FROM utente
	WHERE utente.password = NEW.password;

	IF(LENGTH(pass_word) < 6) THEN
	RAISE EXCEPTION 'La password deve contenere almeno 6 caratteri!'
		USING HINT = 'Inserisci una password più lunga.';
	END IF;
RETURN NULL;
END;

$$;
 4   DROP FUNCTION public.controllo_lunghezzapassword();
       public          postgres    false            �            1255    33034    controllo_preferiti_cover()    FUNCTION     �  CREATE FUNCTION public.controllo_preferiti_cover() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 

BEGIN

IF EXISTS(
    SELECT *
    FROM preferiti_cover AS p1, preferiti_cover AS p2
    WHERE p1.id_utente = p2.id_utente AND p1.id_cover = p2.id_cover AND p1.id_preferito <> p2.id_preferito
)THEN
RAISE EXCEPTION 'La cover è già presente nei preferiti!';
END IF;

RETURN NULL;
END;

$$;
 2   DROP FUNCTION public.controllo_preferiti_cover();
       public          postgres    false            �            1255    33035    controllo_preferiti_traccia()    FUNCTION     �  CREATE FUNCTION public.controllo_preferiti_traccia() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 

BEGIN

IF EXISTS(
    SELECT *
    FROM preferiti_traccia AS p1, preferiti_traccia AS p2
    WHERE p1.id_utente = p2.id_utente AND p1.id_traccia = p2.id_traccia and p1.id_preferito <> p2.id_preferito
)THEN
RAISE EXCEPTION 'La traccia è già presente nei preferiti!';
END IF;

RETURN NULL;
END;

$$;
 4   DROP FUNCTION public.controllo_preferiti_traccia();
       public          postgres    false            �            1255    41210    controllo_sicurezzapassword()    FUNCTION       CREATE FUNCTION public.controllo_sicurezzapassword() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    pass_word utente.password%type;
BEGIN
	SELECT utente.password INTO pass_word
	FROM utente
	WHERE utente.password = NEW.password;

	IF(pass_word = '123456' OR pass_word = '12345678' OR pass_word = '000000' OR pass_word = 'password') THEN
	RAISE EXCEPTION 'La password inserita ha un livello di sicurezza troppo basso!'
		USING HINT = 'Inserisci una password più sicura.';
	END IF;
RETURN NULL;
END;

$$;
 4   DROP FUNCTION public.controllo_sicurezzapassword();
       public          postgres    false            �            1255    41190    controllo_username()    FUNCTION     �  CREATE FUNCTION public.controllo_username() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    user_name utente.username%type;
BEGIN
	SELECT utente.username INTO user_name
	FROM utente
	WHERE utente.username = NEW.username;

	IF(LENGTH(user_name) < 4) THEN
	RAISE EXCEPTION 'Il nome utente deve contenere almeno 4 caratteri!'
		USING HINT = 'Inserisci un nome utente più lungo.';
	END IF;
RETURN NULL;
END;

$$;
 +   DROP FUNCTION public.controllo_username();
       public          postgres    false            �            1255    24791    mostra_tracce()    FUNCTION     �   CREATE FUNCTION public.mostra_tracce() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE             

track_name traccia.nome%TYPE;

BEGIN

	SELECT traccia.nome into track_name
	FROM traccia
	ORDER BY traccia.nome;
     
END;

$$;
 &   DROP FUNCTION public.mostra_tracce();
       public          postgres    false            �            1259    16395    album    TABLE     �   CREATE TABLE public.album (
    nome_album character varying(32) NOT NULL,
    artista character varying(32),
    anno_uscita integer NOT NULL
);
    DROP TABLE public.album;
       public         heap    postgres    false            �            1259    24844    ascolto_cover    TABLE     �   CREATE TABLE public.ascolto_cover (
    id_ascoltoc integer NOT NULL,
    id_utente integer NOT NULL,
    id_cover integer NOT NULL,
    num_ascolti integer DEFAULT 0,
    fascia_oraria character varying(16)
);
 !   DROP TABLE public.ascolto_cover;
       public         heap    postgres    false            �            1259    41198    ascolto_cover_id_ascoltoc_seq    SEQUENCE     �   ALTER TABLE public.ascolto_cover ALTER COLUMN id_ascoltoc ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ascolto_cover_id_ascoltoc_seq
    START WITH 25
    INCREMENT BY 1
    MINVALUE 25
    MAXVALUE 100000
    CACHE 1
);
            public          postgres    false    217            �            1259    24797    ascolto_traccia    TABLE     �   CREATE TABLE public.ascolto_traccia (
    id_ascolto integer NOT NULL,
    id_utente integer NOT NULL,
    id_traccia integer NOT NULL,
    num_ascolti integer DEFAULT 0,
    fascia_oraria character varying(16)
);
 #   DROP TABLE public.ascolto_traccia;
       public         heap    postgres    false            �            1259    41199    ascolto_traccia_id_ascolto_seq    SEQUENCE     �   ALTER TABLE public.ascolto_traccia ALTER COLUMN id_ascolto ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ascolto_traccia_id_ascolto_seq
    START WITH 75
    INCREMENT BY 1
    MINVALUE 75
    MAXVALUE 100000
    CACHE 1
);
            public          postgres    false    216            �            1259    24598    cover    TABLE     &  CREATE TABLE public.cover (
    autore character varying(32) NOT NULL,
    anno_nascita integer NOT NULL,
    anno_rivisitazione integer NOT NULL,
    nome character varying(32) NOT NULL,
    album character varying(32),
    id_cover integer NOT NULL,
    traccia_originale integer NOT NULL
);
    DROP TABLE public.cover;
       public         heap    postgres    false            �            1259    24629    preferiti_cover    TABLE     �   CREATE TABLE public.preferiti_cover (
    id_utente integer NOT NULL,
    id_cover integer NOT NULL,
    id_preferito integer NOT NULL
);
 #   DROP TABLE public.preferiti_cover;
       public         heap    postgres    false            �            1259    33057     preferiti_cover_id_preferito_seq    SEQUENCE     �   ALTER TABLE public.preferiti_cover ALTER COLUMN id_preferito ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.preferiti_cover_id_preferito_seq
    START WITH 26
    INCREMENT BY 1
    MINVALUE 26
    MAXVALUE 100000
    CACHE 1
);
            public          postgres    false    215            �            1259    24607    preferiti_traccia    TABLE     �   CREATE TABLE public.preferiti_traccia (
    id_utente integer NOT NULL,
    id_traccia integer NOT NULL,
    id_preferito integer NOT NULL
);
 %   DROP TABLE public.preferiti_traccia;
       public         heap    postgres    false            �            1259    33062 "   preferiti_traccia_id_preferito_seq    SEQUENCE     �   ALTER TABLE public.preferiti_traccia ALTER COLUMN id_preferito ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.preferiti_traccia_id_preferito_seq
    START WITH 54
    INCREMENT BY 1
    MINVALUE 54
    MAXVALUE 100000
    CACHE 1
);
            public          postgres    false    213            �            1259    16401    traccia    TABLE     �   CREATE TABLE public.traccia (
    id_track integer NOT NULL,
    autore character varying(32) NOT NULL,
    versione integer NOT NULL,
    nome character varying(32) NOT NULL,
    album character varying(32) NOT NULL
);
    DROP TABLE public.traccia;
       public         heap    postgres    false            �            1259    16404    utente    TABLE     �   CREATE TABLE public.utente (
    user_id integer NOT NULL,
    username character varying(32) NOT NULL,
    password character varying(20) NOT NULL,
    admin boolean DEFAULT false NOT NULL
);
    DROP TABLE public.utente;
       public         heap    postgres    false            �            1259    24620    utente_user_id_seq    SEQUENCE     �   ALTER TABLE public.utente ALTER COLUMN user_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.utente_user_id_seq
    START WITH 20
    INCREMENT BY 1
    MINVALUE 20
    MAXVALUE 100000000
    CACHE 1
);
            public          postgres    false    211            8          0    16395    album 
   TABLE DATA           A   COPY public.album (nome_album, artista, anno_uscita) FROM stdin;
    public          postgres    false    209   �\       @          0    24844    ascolto_cover 
   TABLE DATA           e   COPY public.ascolto_cover (id_ascoltoc, id_utente, id_cover, num_ascolti, fascia_oraria) FROM stdin;
    public          postgres    false    217   P^       ?          0    24797    ascolto_traccia 
   TABLE DATA           h   COPY public.ascolto_traccia (id_ascolto, id_utente, id_traccia, num_ascolti, fascia_oraria) FROM stdin;
    public          postgres    false    216   8_       ;          0    24598    cover 
   TABLE DATA           s   COPY public.cover (autore, anno_nascita, anno_rivisitazione, nome, album, id_cover, traccia_originale) FROM stdin;
    public          postgres    false    212   +a       >          0    24629    preferiti_cover 
   TABLE DATA           L   COPY public.preferiti_cover (id_utente, id_cover, id_preferito) FROM stdin;
    public          postgres    false    215   ;b       <          0    24607    preferiti_traccia 
   TABLE DATA           P   COPY public.preferiti_traccia (id_utente, id_traccia, id_preferito) FROM stdin;
    public          postgres    false    213   �b       9          0    16401    traccia 
   TABLE DATA           J   COPY public.traccia (id_track, autore, versione, nome, album) FROM stdin;
    public          postgres    false    210   �c       :          0    16404    utente 
   TABLE DATA           D   COPY public.utente (user_id, username, password, admin) FROM stdin;
    public          postgres    false    211   f       K           0    0    ascolto_cover_id_ascoltoc_seq    SEQUENCE SET     L   SELECT pg_catalog.setval('public.ascolto_cover_id_ascoltoc_seq', 33, true);
          public          postgres    false    220            L           0    0    ascolto_traccia_id_ascolto_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.ascolto_traccia_id_ascolto_seq', 76, true);
          public          postgres    false    221            M           0    0     preferiti_cover_id_preferito_seq    SEQUENCE SET     O   SELECT pg_catalog.setval('public.preferiti_cover_id_preferito_seq', 40, true);
          public          postgres    false    218            N           0    0 "   preferiti_traccia_id_preferito_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.preferiti_traccia_id_preferito_seq', 93, true);
          public          postgres    false    219            O           0    0    utente_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.utente_user_id_seq', 22, true);
          public          postgres    false    214            �           2606    16413    utente AUTO_INCREMENT 
   CONSTRAINT     Z   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT "AUTO_INCREMENT" PRIMARY KEY (user_id);
 A   ALTER TABLE ONLY public.utente DROP CONSTRAINT "AUTO_INCREMENT";
       public            postgres    false    211            �           2606    16409    album album_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (nome_album);
 :   ALTER TABLE ONLY public.album DROP CONSTRAINT album_pkey;
       public            postgres    false    209            �           2606    24848     ascolto_cover ascolto_cover_pkey 
   CONSTRAINT     g   ALTER TABLE ONLY public.ascolto_cover
    ADD CONSTRAINT ascolto_cover_pkey PRIMARY KEY (id_ascoltoc);
 J   ALTER TABLE ONLY public.ascolto_cover DROP CONSTRAINT ascolto_cover_pkey;
       public            postgres    false    217            �           2606    24802    ascolto_traccia ascolto_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.ascolto_traccia
    ADD CONSTRAINT ascolto_pkey PRIMARY KEY (id_ascolto);
 F   ALTER TABLE ONLY public.ascolto_traccia DROP CONSTRAINT ascolto_pkey;
       public            postgres    false    216            �           2606    33025    utente conun 
   CONSTRAINT     K   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT conun UNIQUE (username);
 6   ALTER TABLE ONLY public.utente DROP CONSTRAINT conun;
       public            postgres    false    211            �           2606    24628    cover cover_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT cover_pkey PRIMARY KEY (id_cover);
 :   ALTER TABLE ONLY public.cover DROP CONSTRAINT cover_pkey;
       public            postgres    false    212            �           2606    33056 $   preferiti_cover preferiti_cover_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.preferiti_cover
    ADD CONSTRAINT preferiti_cover_pkey PRIMARY KEY (id_preferito);
 N   ALTER TABLE ONLY public.preferiti_cover DROP CONSTRAINT preferiti_cover_pkey;
       public            postgres    false    215            �           2606    16411    traccia traccia_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_pkey PRIMARY KEY (id_track);
 >   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_pkey;
       public            postgres    false    210            �           2606    24604 	   cover uni 
   CONSTRAINT     L   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT uni UNIQUE (anno_nascita);
 3   ALTER TABLE ONLY public.cover DROP CONSTRAINT uni;
       public            postgres    false    212            �           2606    16415    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    211            �           2620    41224 #   traccia controllo_anno_albumtraccia    TRIGGER     �   CREATE TRIGGER controllo_anno_albumtraccia AFTER INSERT ON public.traccia FOR EACH ROW EXECUTE FUNCTION public.controllo_anno_albumtraccia();
 <   DROP TRIGGER controllo_anno_albumtraccia ON public.traccia;
       public          postgres    false    210    238            �           2620    41221    cover controllo_autorecover    TRIGGER     �   CREATE TRIGGER controllo_autorecover AFTER INSERT ON public.cover FOR EACH ROW EXECUTE FUNCTION public.controllo_autorecover();
 4   DROP TRIGGER controllo_autorecover ON public.cover;
       public          postgres    false    239    212            �           2620    41209 "   utente controllo_lunghezzapassword    TRIGGER     �   CREATE TRIGGER controllo_lunghezzapassword AFTER INSERT ON public.utente FOR EACH ROW EXECUTE FUNCTION public.controllo_lunghezzapassword();
 ;   DROP TRIGGER controllo_lunghezzapassword ON public.utente;
       public          postgres    false    211    240            �           2620    33036 )   preferiti_cover controllo_preferiti_cover    TRIGGER     �   CREATE TRIGGER controllo_preferiti_cover AFTER INSERT ON public.preferiti_cover FOR EACH ROW EXECUTE FUNCTION public.controllo_preferiti_cover();
 B   DROP TRIGGER controllo_preferiti_cover ON public.preferiti_cover;
       public          postgres    false    223    215            �           2620    33037 -   preferiti_traccia controllo_preferiti_traccia    TRIGGER     �   CREATE TRIGGER controllo_preferiti_traccia AFTER INSERT ON public.preferiti_traccia FOR EACH ROW EXECUTE FUNCTION public.controllo_preferiti_traccia();
 F   DROP TRIGGER controllo_preferiti_traccia ON public.preferiti_traccia;
       public          postgres    false    213    228            �           2620    41211 "   utente controllo_sicurezzapassword    TRIGGER     �   CREATE TRIGGER controllo_sicurezzapassword AFTER INSERT ON public.utente FOR EACH ROW EXECUTE FUNCTION public.controllo_sicurezzapassword();
 ;   DROP TRIGGER controllo_sicurezzapassword ON public.utente;
       public          postgres    false    237    211            �           2620    41191    utente controllo_username    TRIGGER     {   CREATE TRIGGER controllo_username AFTER INSERT ON public.utente FOR EACH ROW EXECUTE FUNCTION public.controllo_username();
 2   DROP TRIGGER controllo_username ON public.utente;
       public          postgres    false    211    224            �           2606    24854 )   ascolto_cover ascolto_cover_id_cover_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascolto_cover
    ADD CONSTRAINT ascolto_cover_id_cover_fkey FOREIGN KEY (id_cover) REFERENCES public.cover(id_cover);
 S   ALTER TABLE ONLY public.ascolto_cover DROP CONSTRAINT ascolto_cover_id_cover_fkey;
       public          postgres    false    217    3218    212            �           2606    24849 *   ascolto_cover ascolto_cover_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascolto_cover
    ADD CONSTRAINT ascolto_cover_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 T   ALTER TABLE ONLY public.ascolto_cover DROP CONSTRAINT ascolto_cover_id_utente_fkey;
       public          postgres    false    217    3212    211            �           2606    24814 	   cover fk1    FK CONSTRAINT     z   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT fk1 FOREIGN KEY (traccia_originale) REFERENCES public.traccia(id_track);
 3   ALTER TABLE ONLY public.cover DROP CONSTRAINT fk1;
       public          postgres    false    212    210    3210            �           2606    24819    ascolto_traccia fk1    FK CONSTRAINT     z   ALTER TABLE ONLY public.ascolto_traccia
    ADD CONSTRAINT fk1 FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 =   ALTER TABLE ONLY public.ascolto_traccia DROP CONSTRAINT fk1;
       public          postgres    false    211    216    3212            �           2606    24824    ascolto_traccia fk2    FK CONSTRAINT     }   ALTER TABLE ONLY public.ascolto_traccia
    ADD CONSTRAINT fk2 FOREIGN KEY (id_traccia) REFERENCES public.traccia(id_track);
 =   ALTER TABLE ONLY public.ascolto_traccia DROP CONSTRAINT fk2;
       public          postgres    false    216    210    3210            �           2606    33019 	   cover fk2    FK CONSTRAINT     n   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT fk2 FOREIGN KEY (album) REFERENCES public.album(nome_album);
 3   ALTER TABLE ONLY public.cover DROP CONSTRAINT fk2;
       public          postgres    false    212    209    3208            �           2606    24637 -   preferiti_cover preferiti_cover_id_cover_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_cover
    ADD CONSTRAINT preferiti_cover_id_cover_fkey FOREIGN KEY (id_cover) REFERENCES public.cover(id_cover);
 W   ALTER TABLE ONLY public.preferiti_cover DROP CONSTRAINT preferiti_cover_id_cover_fkey;
       public          postgres    false    215    3218    212            �           2606    24632 .   preferiti_cover preferiti_cover_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_cover
    ADD CONSTRAINT preferiti_cover_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 X   ALTER TABLE ONLY public.preferiti_cover DROP CONSTRAINT preferiti_cover_id_utente_fkey;
       public          postgres    false    3212    211    215            �           2606    24615 +   preferiti_traccia preferiti_id_traccia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_traccia
    ADD CONSTRAINT preferiti_id_traccia_fkey FOREIGN KEY (id_traccia) REFERENCES public.traccia(id_track);
 U   ALTER TABLE ONLY public.preferiti_traccia DROP CONSTRAINT preferiti_id_traccia_fkey;
       public          postgres    false    210    213    3210            �           2606    24610 *   preferiti_traccia preferiti_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_traccia
    ADD CONSTRAINT preferiti_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 T   ALTER TABLE ONLY public.preferiti_traccia DROP CONSTRAINT preferiti_id_utente_fkey;
       public          postgres    false    213    3212    211            �           2606    16426    traccia traccia_album_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_album_fkey FOREIGN KEY (album) REFERENCES public.album(nome_album);
 D   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_album_fkey;
       public          postgres    false    210    3208    209            8   A  x�]�Mn�0���)�@q �,�PPt�f��4�]9mz�n{.V[T����O�{o6<�,B�G��[s(쑌jr�ˢ!�-ܕ�Xx"s�E�e#��<�����^���l�}�p&��݉"�i�RE��\�fdC�{�zºt����9wZ�]�9Q���C�p.�#�ѷ�P�o���w$�k拰�]��3$n1�~g%Ū�?ƪ�L��c2�3CM��ގe����:�,;���?:�+��/b����`�Y�'cRG��)�#�x�]��zK�����b؁�M��"R�}W�0�R~ ���      @   �   x�m�Q�0D��)�@;��=K���ү�㌎��X�&*!����~����l�U�W�'�!&(E������r��	�^�S&!S��nv�yp��d! ��"|�(�_�D�v�;^�l$�
�,\��8������C��B�*�5˳�fX��be���KJpОʜIq��p��qA�k�+�0��~Q�<�����X|���0w�u�`ş����n�� 3�n�      ?   �  x�mUQ�c!���"�)ED����ϱt;[�«�$�F������%���]��ϧ�?B���~a���iux���?nx��g��s-"����\��!�F8���"�d�A}��YV"#?�q|G܀/8�3k����a�P$z�0l���
K���4�g�ҋ��su�c5ļF�a����yGX�KN�7��Ҟ.�����q9��":���|�
��V�1&�Z���4��lH��
*s��T�Lzde*;z4�,�e$6�1��uyh]FG#�>��	>�|����pZD��MhoV)�z�����d9�<U��w��#�%W}
΅����X�PZ>����7�(d�)�۰�ͼH���)I*�}o9C%W%��NZz�~��A��<�O��Te�%7&-;KҘ
��oP5�eb\���k�BM�7/�ϸN�e�d5���*R�����J�5��
�g��[��9�Vv5h�u7O���t~�����&Z      ;      x�]�Mn�0���S���b�вD� *�����n�dB�:62�G�9z���?�Y��{�JM=��>�e 2^���ȶ��o���L�_�����RN�V�p��پ'�{g[�}�d�$2X�u�7���"���J�ap�lu�A�`ˠS���F8�op���T-�e=&w�q@��@�8p�ب}�1�'����]�S9��;v��d�a��BټuR5�F�	\��t�ed&�\��|!����������)e�} ��o�      >   s   x��� ��a�����.��>�H$:�BIM���°4=�����q����W���e�)��Fl�?}L���q΍�hwX�n�q�g���,���]*�a#�T�4������a^      <   �   x��ۑ� C��bv���r��c���pD��m�V)+�V+;>�r b����d��z���	V�uŨ2V
�yTm��\Q���Vmx�L��\�kk��ɽ���Uc�ROc���z_�<DM�9��y��EʤK���YN�T�gL�9Wp_[��cfi�E�,{'��:�M9:�\H(�R�5�p��k��h��d�Y1:��G�4��;\�fA*�� ��xMN������#�خc�qyՌ�_D�x"E?      9   ;  x�u�Mr�0���)�]��H����N&��Q���t�J�Ś"<��=M��9r�B�"��l4��xJa�=�hY���\Z�k
%�σ,����n`Xs�y�.�D��������²3'p��b��%\m�[v�6�3�G8�v��,��Ķdf-�`�2z�r�d��x��H�pY[ϵj��b�B	���
/*һȹ�5+�������_�Z ׺�6/��mӲ�oNa�-�	��Ι�L<>����ܺFR��x[kb�v�fq8d�'��>I����kz�¸�#��fŁ��l�vE���?�H{�4=�9�D�5��"�t+�I�;��V8��m
õ-��j?�RE��+�-��ޓ��Ռ����5$�D���|N�1�t�kqj8�ǵ֬���<�ORh�lM0���޼1��l����R�W��[ŕ`S���5��76>���(1�`O����&�8���7��l&K,9��N��&=��j�m>��n"��/B������J��oع.r]<��?^ǅ�P	�.!�+���v�s��*�]T�=���DA�ۑ1���V`      :   '  x�-��n�0����T��pm��rh��JhcY�`d;i����'��;;��Ȳ�0MY���
�yYL#@���	b�Vi*k��=�us����|F��ŚQyw�+������T`!��:X�F�3�ϐ&�$��:k��u�*��"�A�VE���TZ���G����R7@d"��%Zz�!�'�4Q�0*k_;I��F�<������K� �#-FsV�t�os�mBt��y0v"�I�o��EO�.�T�D�#��)p�]QVQ�1)�M`p�����
�#e(�%5�=X^)<�^���yK���`|�     