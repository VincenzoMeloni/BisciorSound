PGDMP     7                
    z            LibreriaMusicale_db    14.4    14.4 "                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    16394    LibreriaMusicale_db    DATABASE     q   CREATE DATABASE "LibreriaMusicale_db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
 %   DROP DATABASE "LibreriaMusicale_db";
                postgres    false            �            1255    24794    checkusername()    FUNCTION     ,  CREATE FUNCTION public.checkusername() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
username VARCHAR(32);
username_admin VARCHAR(32);

BEGIN
	SELECT utente.username INTO username
	FROM utente
	WHERE utente.username = NEW.username AND utente.admin = 'false';

	SELECT utente.username INTO username_admin
	FROM utente
	WHERE utente.admin = 'true';
	
	IF(username = username_admin AND username IS NOT NULL) THEN
	RAISE EXCEPTION 'Errore! Username non disponibile.'
    USING HINT = 'Inserisci un nuovo nome utente.';
	END IF;
RETURN NULL;
END;

$$;
 &   DROP FUNCTION public.checkusername();
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
    artista character varying(32) NOT NULL,
    anno_uscita integer NOT NULL
);
    DROP TABLE public.album;
       public         heap    postgres    false            �            1259    24797    ascolto    TABLE     �   CREATE TABLE public.ascolto (
    id_ascolto integer NOT NULL,
    id_utente integer,
    id_traccia integer,
    id_cover integer,
    num_ascolti integer DEFAULT 0,
    fascia_oraria character varying(16)
);
    DROP TABLE public.ascolto;
       public         heap    postgres    false            �            1259    24598    cover    TABLE     �   CREATE TABLE public.cover (
    autore character varying(32),
    anno_nascita integer NOT NULL,
    anno_rivisitazione integer NOT NULL,
    nome character varying(32) NOT NULL,
    album character varying(32),
    id_cover integer NOT NULL
);
    DROP TABLE public.cover;
       public         heap    postgres    false            �            1259    24607 	   preferiti    TABLE     c   CREATE TABLE public.preferiti (
    id_utente integer NOT NULL,
    id_traccia integer NOT NULL
);
    DROP TABLE public.preferiti;
       public         heap    postgres    false            �            1259    24629    preferiti_cover    TABLE     g   CREATE TABLE public.preferiti_cover (
    id_utente integer NOT NULL,
    id_cover integer NOT NULL
);
 #   DROP TABLE public.preferiti_cover;
       public         heap    postgres    false            �            1259    16401    traccia    TABLE     �   CREATE TABLE public.traccia (
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
    START WITH 17
    INCREMENT BY 1
    MINVALUE 17
    NO MAXVALUE
    CACHE 1
);
            public          postgres    false    211                      0    16395    album 
   TABLE DATA           A   COPY public.album (nome_album, artista, anno_uscita) FROM stdin;
    public          postgres    false    209   d)                 0    24797    ascolto 
   TABLE DATA           j   COPY public.ascolto (id_ascolto, id_utente, id_traccia, id_cover, num_ascolti, fascia_oraria) FROM stdin;
    public          postgres    false    216   �*                 0    24598    cover 
   TABLE DATA           `   COPY public.cover (autore, anno_nascita, anno_rivisitazione, nome, album, id_cover) FROM stdin;
    public          postgres    false    212   b,                 0    24607 	   preferiti 
   TABLE DATA           :   COPY public.preferiti (id_utente, id_traccia) FROM stdin;
    public          postgres    false    213   1-                 0    24629    preferiti_cover 
   TABLE DATA           >   COPY public.preferiti_cover (id_utente, id_cover) FROM stdin;
    public          postgres    false    215   �-                 0    16401    traccia 
   TABLE DATA           J   COPY public.traccia (id_track, autore, versione, nome, album) FROM stdin;
    public          postgres    false    210   .                 0    16404    utente 
   TABLE DATA           D   COPY public.utente (user_id, username, password, admin) FROM stdin;
    public          postgres    false    211   .0       $           0    0    utente_user_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.utente_user_id_seq', 43, true);
          public          postgres    false    214            }           2606    16413    utente AUTO_INCREMENT 
   CONSTRAINT     Z   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT "AUTO_INCREMENT" PRIMARY KEY (user_id);
 A   ALTER TABLE ONLY public.utente DROP CONSTRAINT "AUTO_INCREMENT";
       public            postgres    false    211            y           2606    16409    album album_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (nome_album);
 :   ALTER TABLE ONLY public.album DROP CONSTRAINT album_pkey;
       public            postgres    false    209            �           2606    24802    ascolto ascolto_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_pkey PRIMARY KEY (id_ascolto);
 >   ALTER TABLE ONLY public.ascolto DROP CONSTRAINT ascolto_pkey;
       public            postgres    false    216            �           2606    24628    cover cover_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT cover_pkey PRIMARY KEY (id_cover);
 :   ALTER TABLE ONLY public.cover DROP CONSTRAINT cover_pkey;
       public            postgres    false    212            {           2606    16411    traccia traccia_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_pkey PRIMARY KEY (id_track);
 >   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_pkey;
       public            postgres    false    210            �           2606    24604 	   cover uni 
   CONSTRAINT     L   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT uni UNIQUE (anno_nascita);
 3   ALTER TABLE ONLY public.cover DROP CONSTRAINT uni;
       public            postgres    false    212                       2606    16415    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    211            �           2606    24637 -   preferiti_cover preferiti_cover_id_cover_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_cover
    ADD CONSTRAINT preferiti_cover_id_cover_fkey FOREIGN KEY (id_cover) REFERENCES public.cover(id_cover);
 W   ALTER TABLE ONLY public.preferiti_cover DROP CONSTRAINT preferiti_cover_id_cover_fkey;
       public          postgres    false    212    215    3201            �           2606    24632 .   preferiti_cover preferiti_cover_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti_cover
    ADD CONSTRAINT preferiti_cover_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 X   ALTER TABLE ONLY public.preferiti_cover DROP CONSTRAINT preferiti_cover_id_utente_fkey;
       public          postgres    false    3197    215    211            �           2606    24615 #   preferiti preferiti_id_traccia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti
    ADD CONSTRAINT preferiti_id_traccia_fkey FOREIGN KEY (id_traccia) REFERENCES public.traccia(id_track);
 M   ALTER TABLE ONLY public.preferiti DROP CONSTRAINT preferiti_id_traccia_fkey;
       public          postgres    false    3195    213    210            �           2606    24610 "   preferiti preferiti_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti
    ADD CONSTRAINT preferiti_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 L   ALTER TABLE ONLY public.preferiti DROP CONSTRAINT preferiti_id_utente_fkey;
       public          postgres    false    211    213    3197            �           2606    16426    traccia traccia_album_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_album_fkey FOREIGN KEY (album) REFERENCES public.album(nome_album);
 D   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_album_fkey;
       public          postgres    false    3193    210    209               "  x�]��NA��ӧ�7���9��b� ��eܭP��&����i�����x�ϭ��6_�_Ɇ	�Eo��)%kVgX�=91�亀�S��|�Y���Dg�3E��`�=G�q{ ��Yp8r����g��JN���s ��<�"oN)�6vx�ky/O`&��G�bbʘ�'8�{\������N� �2[��Q^8%)2P)\���sZ��.��6�d�W�ߍ��ўđ����;֤i����iL2Xr��ǅ�:����D�t�0�*�yz�|�C�d��� ���}�         �  x�mTۑ1��V���`�㊸
��l6sf=�Hf@i)�}޿�J��'���+W���F$Qw ��=. b��1)�����X);��WŌ<�k�� �15uCx�P3|�3�����z_T�=�"Z�B�b��:Jb�5�2�өǪ
�/��z��,%�q�	i�7 ��ᶘ�'�����R���ՎbQ1b�$�''�49D�\�K	�@h�lFu��$�!|R��"G�#89/�᤭��-{t_�jgv�ķ|�$Y�ᐡ��'+񾥦��e����Vzl�Qu/��;�<�#�!�x�!�e���'�z2��D��G�B|r
q�u��W�����g���Zm�Pjv��i�����L�K�u���p�^Vp=]T�� �RubǷ�V�uy�´}|5V��|=�ع��l�<�5#�˰��ҝ��Q�!��l4���u�]��         �   x�M�K�@D�=�hw�!|�ĥ�O4���q3j&�d &�sx1�qS�W�*�T�i�a�SB?���e������d�������(+/�y �ȸ,�pg9WM����Ї��� \�+:	iMWʅ^X㝵ׂ"���LYt���1l��Yn���=��.�����Բ��.&p�7�P�s�6z�/��B��E�         �   x�5��0C�0L��.��>G��/RdlP�T,t����Ȋ����=,ɘ9B���ی�S9I�6nb�#�#�#/#7."�T����d���cx�zk�C����Ӄ� ��>���Z�hSt�kϰl�������#%         I   x�%���0��a�^4t��?G��>��B+]��Hs��yy>ζy�_��ӊ�!�#
Shj�ɆuX�'�?cj�           x�u��r�@��ڧPo�%�5�GR�iB;$�7Ӌj�bK�zM�>M��s��*�Hn���i�>��,8��Yv��V��X���<�����5�P��u4�n�,��'��Μ������RJ������>5n\&AG8�9W
~���#6�-Yä�_L� ��4��D�xo�a�.� \��g0� s#���x� {��)�fc:ݭ=���]�hpm��Ixa|m��(���>�;�aL��J��;g|����,T5��&	xW[��;PM8�E
��`�$�8n�y��� ��9ba�oVi���;w+*m�����iz�-�V�I�g�͂��i��q�xG?���|E�a�E[�WZ����
�c�Ο�{���������d�Y�S���.n,�Z+3��Eŵ�l��j��-,A�&���ټq��@v�ʎ�S-
ūV�Vq��\%Śa�6���`~�9?�S[>��IG���%2���فeʫ�6�L� �|;���n"��/B���q����<           x�-��n�0�ϓ����%�Vj/�C�z@���8�#۴���Co�ٝ�oJL����"�s�Y�w1�,�#�9jg�آ׆������^n��N(Z�=��m��=�!',�}�FkFyr�?���i�$��)��^��Z�S����N�+;���3�E�����a��cS���GL��v]���s�A�3?	+�����߼(N �/�H�`�{�����V�Ѻ�C4 d5�dV�'|d��Fv����UU�$�Ť��0u��k��t$X�b�5��%˲?&�u�     