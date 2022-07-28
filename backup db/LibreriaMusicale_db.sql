PGDMP         6                z           LibreriaMusicale_db    14.4    14.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16394    LibreriaMusicale_db    DATABASE     q   CREATE DATABASE "LibreriaMusicale_db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Italian_Italy.1252';
 %   DROP DATABASE "LibreriaMusicale_db";
                postgres    false            �            1259    16395    album    TABLE     �   CREATE TABLE public.album (
    nome_album character varying(32) NOT NULL,
    artista character varying(32) NOT NULL,
    anno_uscita integer NOT NULL
);
    DROP TABLE public.album;
       public         heap    postgres    false            �            1259    16398    ascolto    TABLE     �   CREATE TABLE public.ascolto (
    num_ascolti integer NOT NULL,
    id_utente integer NOT NULL,
    id_traccia integer NOT NULL,
    fascia_oraria character varying(16) NOT NULL
);
    DROP TABLE public.ascolto;
       public         heap    postgres    false            �            1259    24598    cover    TABLE     �   CREATE TABLE public.cover (
    autore character varying(32),
    anno_nascita integer NOT NULL,
    anno_rivisitazione integer NOT NULL,
    nome character varying(32) NOT NULL,
    album character varying(32)
);
    DROP TABLE public.cover;
       public         heap    postgres    false            �            1259    24607 	   preferiti    TABLE     c   CREATE TABLE public.preferiti (
    id_utente integer NOT NULL,
    id_traccia integer NOT NULL
);
    DROP TABLE public.preferiti;
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
       public         heap    postgres    false                      0    16395    album 
   TABLE DATA           A   COPY public.album (nome_album, artista, anno_uscita) FROM stdin;
    public          postgres    false    209   �                 0    16398    ascolto 
   TABLE DATA           T   COPY public.ascolto (num_ascolti, id_utente, id_traccia, fascia_oraria) FROM stdin;
    public          postgres    false    210                      0    24598    cover 
   TABLE DATA           V   COPY public.cover (autore, anno_nascita, anno_rivisitazione, nome, album) FROM stdin;
    public          postgres    false    213                     0    24607 	   preferiti 
   TABLE DATA           :   COPY public.preferiti (id_utente, id_traccia) FROM stdin;
    public          postgres    false    214   �                  0    16401    traccia 
   TABLE DATA           J   COPY public.traccia (id_track, autore, versione, nome, album) FROM stdin;
    public          postgres    false    211   !                 0    16404    utente 
   TABLE DATA           D   COPY public.utente (user_id, username, password, admin) FROM stdin;
    public          postgres    false    212   (#       q           2606    16409    album album_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.album
    ADD CONSTRAINT album_pkey PRIMARY KEY (nome_album);
 :   ALTER TABLE ONLY public.album DROP CONSTRAINT album_pkey;
       public            postgres    false    209            y           2606    24602    cover cover_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT cover_pkey PRIMARY KEY (nome);
 :   ALTER TABLE ONLY public.cover DROP CONSTRAINT cover_pkey;
       public            postgres    false    213            s           2606    16411    traccia traccia_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_pkey PRIMARY KEY (id_track);
 >   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_pkey;
       public            postgres    false    211            {           2606    24604 	   cover uni 
   CONSTRAINT     L   ALTER TABLE ONLY public.cover
    ADD CONSTRAINT uni UNIQUE (anno_nascita);
 3   ALTER TABLE ONLY public.cover DROP CONSTRAINT uni;
       public            postgres    false    213            u           2606    16413    utente utente_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_pkey PRIMARY KEY (user_id);
 <   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_pkey;
       public            postgres    false    212            w           2606    16415    utente utente_username_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.utente
    ADD CONSTRAINT utente_username_key UNIQUE (username);
 D   ALTER TABLE ONLY public.utente DROP CONSTRAINT utente_username_key;
       public            postgres    false    212            |           2606    16416    ascolto ascolto_id_traccia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_id_traccia_fkey FOREIGN KEY (id_traccia) REFERENCES public.traccia(id_track);
 I   ALTER TABLE ONLY public.ascolto DROP CONSTRAINT ascolto_id_traccia_fkey;
       public          postgres    false    211    3187    210            }           2606    16421    ascolto ascolto_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.ascolto
    ADD CONSTRAINT ascolto_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 H   ALTER TABLE ONLY public.ascolto DROP CONSTRAINT ascolto_id_utente_fkey;
       public          postgres    false    210    3189    212            �           2606    24615 #   preferiti preferiti_id_traccia_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti
    ADD CONSTRAINT preferiti_id_traccia_fkey FOREIGN KEY (id_traccia) REFERENCES public.traccia(id_track);
 M   ALTER TABLE ONLY public.preferiti DROP CONSTRAINT preferiti_id_traccia_fkey;
       public          postgres    false    3187    214    211                       2606    24610 "   preferiti preferiti_id_utente_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.preferiti
    ADD CONSTRAINT preferiti_id_utente_fkey FOREIGN KEY (id_utente) REFERENCES public.utente(user_id);
 L   ALTER TABLE ONLY public.preferiti DROP CONSTRAINT preferiti_id_utente_fkey;
       public          postgres    false    214    3189    212            ~           2606    16426    traccia traccia_album_fkey    FK CONSTRAINT        ALTER TABLE ONLY public.traccia
    ADD CONSTRAINT traccia_album_fkey FOREIGN KEY (album) REFERENCES public.album(nome_album);
 D   ALTER TABLE ONLY public.traccia DROP CONSTRAINT traccia_album_fkey;
       public          postgres    false    211    3185    209               "  x�]��NA��ӧ�7���9��b� ��eܭP��&����i�����x�ϭ��6_�_Ɇ	�Eo��)%kVgX�=91�亀�S��|�Y���Dg�3E��`�=G�q{ ��Yp8r����g��JN���s ��<�"oN)�6vx�ky/O`&��G�bbʘ�'8�{\������N� �2[��Q^8%)2P)\���sZ��.��6�d�W�ߍ��ўđ����;֤i����iL2Xr��ǅ�:����D�t�0�*�yz�|�C�d��� ���}�            x������ � �         �   x�M�=
�@F��S�]҄���R�
ш�ͪ�dq�6A�H�Ëi"��W����˒7��i�Ǳ|O?��ü ��YK&��o�k����XEs�޸�3���f��
�s���q-RK%��8�$q�a��Jk�|`�~�Bf�:���U���
U�rW���h���/�A��c$�x0HD�             x�3�4�2�4b 64� +F��� C7           x�u��r�@��ڧPo�%�5�GR�iB;$�7Ӌj�bK�zM�>M��s��*�Hn���i�>��,8��Yv��V��X���<�����5�P��u4�n�,��'��Μ������RJ������>5n\&AG8�9W
~���#6�-Yä�_L� ��4��D�xo�a�.� \��g0� s#���x� {��)�fc:ݭ=���]�hpm��Ixa|m��(���>�;�aL��J��;g|����,T5��&	xW[��;PM8�E
��`�$�8n�y��� ��9ba�oVi���;w+*m�����iz�-�V�I�g�͂��i��q�xG?���|E�a�E[�WZ����
�c�Ο�{���������d�Y�S���.n,�Z+3��Eŵ�l��j��-,A�&���ټq��@v�ʎ�S-
ūV�Vq��\%Śa�6���`~�9?�S[>��IG���%2���فeʫ�6�L� �|;���n"��/B���q����<           x�-��n�0Eח���a�H�&dQ�.�JhB�`d5���Iw��s�s�l����,MS�I�Ѳ��!�>+k��*�e��n�3=7w8�N'���L�����]�b~Ϛ�O	+;W�!�P�N(?CED����5��s�*��)�A�VE��vPZ���C��U�r?�2J���D�����&�i��*L��ǎ0���_���fe�h7'G��W�%��u��o@�Pde��ه |R�[������T`��(í^y_�U@?oI��RPhg     