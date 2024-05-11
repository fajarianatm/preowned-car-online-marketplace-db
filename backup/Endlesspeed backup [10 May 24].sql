PGDMP               
        |            endlesspeed    16.2    16.2 5    K           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            L           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            M           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            N           1262    25642    endlesspeed    DATABASE     m   CREATE DATABASE endlesspeed WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE endlesspeed;
                postgres    false            �            1259    25686    advertisement    TABLE        CREATE TABLE public.advertisement (
    advertisement_id integer NOT NULL,
    product_id integer NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    is_bid_allowed boolean NOT NULL
);
 !   DROP TABLE public.advertisement;
       public         heap    postgres    false            �            1259    25685 "   advertisement_advertisement_id_seq    SEQUENCE     �   CREATE SEQUENCE public.advertisement_advertisement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.advertisement_advertisement_id_seq;
       public          postgres    false    221            O           0    0 "   advertisement_advertisement_id_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.advertisement_advertisement_id_seq OWNED BY public.advertisement.advertisement_id;
          public          postgres    false    220            �            1259    25700    bid    TABLE     �   CREATE TABLE public.bid (
    bid_id integer NOT NULL,
    user_id integer NOT NULL,
    advertisement_id integer NOT NULL,
    bid_price integer NOT NULL,
    CONSTRAINT bid_bid_price_check CHECK ((bid_price > 0))
);
    DROP TABLE public.bid;
       public         heap    postgres    false            �            1259    25699    bid_bid_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bid_bid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.bid_bid_id_seq;
       public          postgres    false    223            P           0    0    bid_bid_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.bid_bid_id_seq OWNED BY public.bid.bid_id;
          public          postgres    false    222            �            1259    25718    bid_status_log    TABLE     �   CREATE TABLE public.bid_status_log (
    bid_status_log_id integer NOT NULL,
    bid_id integer NOT NULL,
    bid_status character varying(20) DEFAULT 'Sent'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);
 "   DROP TABLE public.bid_status_log;
       public         heap    postgres    false            �            1259    25717 $   bid_status_log_bid_status_log_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bid_status_log_bid_status_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.bid_status_log_bid_status_log_id_seq;
       public          postgres    false    225            Q           0    0 $   bid_status_log_bid_status_log_id_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.bid_status_log_bid_status_log_id_seq OWNED BY public.bid_status_log.bid_status_log_id;
          public          postgres    false    224            �            1259    25643    city    TABLE     �   CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(255) NOT NULL,
    location point NOT NULL
);
    DROP TABLE public.city;
       public         heap    postgres    false            �            1259    25671    product    TABLE     �  CREATE TABLE public.product (
    product_id integer NOT NULL,
    user_id integer NOT NULL,
    brand character varying(255) NOT NULL,
    model character varying(255) NOT NULL,
    colour character varying(20) NOT NULL,
    body_type character varying(50) NOT NULL,
    transmission character varying(20) NOT NULL,
    year integer NOT NULL,
    price integer NOT NULL,
    picture text NOT NULL,
    CONSTRAINT product_price_check CHECK ((price > 0))
);
    DROP TABLE public.product;
       public         heap    postgres    false            �            1259    25670    product_product_id_seq    SEQUENCE     �   CREATE SEQUENCE public.product_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.product_product_id_seq;
       public          postgres    false    219            R           0    0    product_product_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.product_product_id_seq OWNED BY public.product.product_id;
          public          postgres    false    218            �            1259    25651    users    TABLE     y  CREATE TABLE public.users (
    user_id integer NOT NULL,
    city_id integer NOT NULL,
    username character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255),
    email character varying(255) NOT NULL,
    phone_number character varying(20) NOT NULL,
    address text,
    location point,
    is_verified boolean
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    25650    users_user_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.users_user_id_seq;
       public          postgres    false    217            S           0    0    users_user_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;
          public          postgres    false    216            �           2604    25689    advertisement advertisement_id    DEFAULT     �   ALTER TABLE ONLY public.advertisement ALTER COLUMN advertisement_id SET DEFAULT nextval('public.advertisement_advertisement_id_seq'::regclass);
 M   ALTER TABLE public.advertisement ALTER COLUMN advertisement_id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    25703 
   bid bid_id    DEFAULT     h   ALTER TABLE ONLY public.bid ALTER COLUMN bid_id SET DEFAULT nextval('public.bid_bid_id_seq'::regclass);
 9   ALTER TABLE public.bid ALTER COLUMN bid_id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    25721     bid_status_log bid_status_log_id    DEFAULT     �   ALTER TABLE ONLY public.bid_status_log ALTER COLUMN bid_status_log_id SET DEFAULT nextval('public.bid_status_log_bid_status_log_id_seq'::regclass);
 O   ALTER TABLE public.bid_status_log ALTER COLUMN bid_status_log_id DROP DEFAULT;
       public          postgres    false    224    225    225            �           2604    25674    product product_id    DEFAULT     x   ALTER TABLE ONLY public.product ALTER COLUMN product_id SET DEFAULT nextval('public.product_product_id_seq'::regclass);
 A   ALTER TABLE public.product ALTER COLUMN product_id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    25654    users user_id    DEFAULT     n   ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);
 <   ALTER TABLE public.users ALTER COLUMN user_id DROP DEFAULT;
       public          postgres    false    217    216    217            D          0    25686    advertisement 
   TABLE DATA           u   COPY public.advertisement (advertisement_id, product_id, title, description, created_at, is_bid_allowed) FROM stdin;
    public          postgres    false    221   �@       F          0    25700    bid 
   TABLE DATA           K   COPY public.bid (bid_id, user_id, advertisement_id, bid_price) FROM stdin;
    public          postgres    false    223   �L       H          0    25718    bid_status_log 
   TABLE DATA           [   COPY public.bid_status_log (bid_status_log_id, bid_id, bid_status, created_at) FROM stdin;
    public          postgres    false    225   �Q       >          0    25643    city 
   TABLE DATA           <   COPY public.city (city_id, city_name, location) FROM stdin;
    public          postgres    false    215   sa       B          0    25671    product 
   TABLE DATA           {   COPY public.product (product_id, user_id, brand, model, colour, body_type, transmission, year, price, picture) FROM stdin;
    public          postgres    false    219   �b       @          0    25651    users 
   TABLE DATA           �   COPY public.users (user_id, city_id, username, first_name, last_name, email, phone_number, address, location, is_verified) FROM stdin;
    public          postgres    false    217   g       T           0    0 "   advertisement_advertisement_id_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.advertisement_advertisement_id_seq', 1, false);
          public          postgres    false    220            U           0    0    bid_bid_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.bid_bid_id_seq', 1, false);
          public          postgres    false    222            V           0    0 $   bid_status_log_bid_status_log_id_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.bid_status_log_bid_status_log_id_seq', 1, false);
          public          postgres    false    224            W           0    0    product_product_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.product_product_id_seq', 1, false);
          public          postgres    false    218            X           0    0    users_user_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);
          public          postgres    false    216            �           2606    25693     advertisement advertisement_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_pkey PRIMARY KEY (advertisement_id);
 J   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT advertisement_pkey;
       public            postgres    false    221            �           2606    25706    bid bid_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT bid_pkey PRIMARY KEY (bid_id);
 6   ALTER TABLE ONLY public.bid DROP CONSTRAINT bid_pkey;
       public            postgres    false    223            �           2606    25724 "   bid_status_log bid_status_log_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.bid_status_log
    ADD CONSTRAINT bid_status_log_pkey PRIMARY KEY (bid_status_log_id);
 L   ALTER TABLE ONLY public.bid_status_log DROP CONSTRAINT bid_status_log_pkey;
       public            postgres    false    225            �           2606    25649    city city_city_name_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);
 A   ALTER TABLE ONLY public.city DROP CONSTRAINT city_city_name_key;
       public            postgres    false    215            �           2606    25647    city city_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);
 8   ALTER TABLE ONLY public.city DROP CONSTRAINT city_pkey;
       public            postgres    false    215            �           2606    25679    product product_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (product_id);
 >   ALTER TABLE ONLY public.product DROP CONSTRAINT product_pkey;
       public            postgres    false    219            �           2606    25731    advertisement unique_product_id 
   CONSTRAINT     `   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT unique_product_id UNIQUE (product_id);
 I   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT unique_product_id;
       public            postgres    false    221            �           2606    25662    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    217            �           2606    25664 $   users users_first_name_last_name_key 
   CONSTRAINT     p   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_first_name_last_name_key UNIQUE (first_name, last_name);
 N   ALTER TABLE ONLY public.users DROP CONSTRAINT users_first_name_last_name_key;
       public            postgres    false    217    217            �           2606    25658    users users_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    217            �           2606    25660    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public            postgres    false    217            �           2606    25712    bid fk_advertisement_bid    FK CONSTRAINT     �   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_advertisement_bid FOREIGN KEY (advertisement_id) REFERENCES public.advertisement(advertisement_id);
 B   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_advertisement_bid;
       public          postgres    false    221    3490    223            �           2606    25725    bid_status_log fk_bid_bidstatus    FK CONSTRAINT        ALTER TABLE ONLY public.bid_status_log
    ADD CONSTRAINT fk_bid_bidstatus FOREIGN KEY (bid_id) REFERENCES public.bid(bid_id);
 I   ALTER TABLE ONLY public.bid_status_log DROP CONSTRAINT fk_bid_bidstatus;
       public          postgres    false    225    223    3494            �           2606    25665    users fk_city_user    FK CONSTRAINT     u   ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_city_user FOREIGN KEY (city_id) REFERENCES public.city(city_id);
 <   ALTER TABLE ONLY public.users DROP CONSTRAINT fk_city_user;
       public          postgres    false    215    3478    217            �           2606    25694 &   advertisement fk_product_advertisement    FK CONSTRAINT     �   ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT fk_product_advertisement FOREIGN KEY (product_id) REFERENCES public.product(product_id);
 P   ALTER TABLE ONLY public.advertisement DROP CONSTRAINT fk_product_advertisement;
       public          postgres    false    221    3488    219            �           2606    25707    bid fk_user_bid    FK CONSTRAINT     s   ALTER TABLE ONLY public.bid
    ADD CONSTRAINT fk_user_bid FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 9   ALTER TABLE ONLY public.bid DROP CONSTRAINT fk_user_bid;
       public          postgres    false    217    223    3484            �           2606    25680    product fk_user_product    FK CONSTRAINT     {   ALTER TABLE ONLY public.product
    ADD CONSTRAINT fk_user_product FOREIGN KEY (user_id) REFERENCES public.users(user_id);
 A   ALTER TABLE ONLY public.product DROP CONSTRAINT fk_user_product;
       public          postgres    false    3484    219    217            D     x�]Xɲ�8<�_�x�nn��=�����2�%�HBM���_?��6O�-ZTUVf��oz��.��L�H�Z;K����z��^�v>���Nn��L�H�4�󗤐q���MGUUu)�w�H��"��=�y�D�������<ɽz<V��E��df;�zZ� �f��r�m�sj������zI*����$iT�EYd�+��e�� �i1�ʹ.:o����E"u�AT���]V5`O�/z�=�|����,��u�y�4xp.r�;�-w����H|�[[�Mb�����ޮ��ͨek�#�)�>�I�,G��'�0e7�����q;B��2I6/n�*i2�V�B|7�"�v�n��"�?��A��C�f��+�2�n��L�i3J��$�L�MRm�4J��NY�R���s�#��ܯS�}�y�⫝2�Ԇ%#8n�m^�D���@!�8�<���0X�÷[5��G;�p�~�-�4��T8󲟑����B�%P��y|�#ř3�b��Q�I\a�Z����"�Q����@��Ӯ���f>�^ @�|��y�G�9�� b��!C��#�5�����0WJd.�7I5u�U5҈F|�>D�l�������e�p�*�3��Z��V�=�A �p���S3>�Z< ���3��i-����I�I^��I,��w@�A�j1v�=*� � ��6��V�3�(M��o���:�3���k��ղ��C���F�9�c�dQ�q�>X��~ ��o �-�~�g�}aB|���T[4�|?�9�k�..|���뀔��c���$t��9c��hT �B�eY�,���ոvEϚl�?-�2�ۿ��Y��t�� p�|5I	m<���
�jjѿK2��i�e �?=�픻�m�3z���9���}B�Y �7��k����ԥ���M�o�&ʪ,�rƕ,T��	37�X�����x�[��V������者J	�N������L��B`}�����?d�ލ�/�
��F��E.$7�f�YHr(5R{q���M��ɧu���72<������t�(����U,���ƀ�g5�=F �3���9z�T���?�����q)�tS$nޔI�Xo`�ų18�h�5��e�嬌#�������#�=5���^���hH;;��gML3��pk�7���2�"gz�B7(�hB�)�L]|��X`�cC��6_�R� �ɝ��k�(���IZSO�x��d�*N��'�X�Q������|�� �
��ӳC�)1�}���9;�|(��in6q���&_�1���^�@��)�
�`ّ%d�M��A)����,���b����#X_W<̙ Cʀ>��.��{0j�� �n�Z�ﵙoqc9^��J��Фy��L�tR�� N%Pw��7��|V��P��ʓ�=�U��8�V�h����ܱ�u3������f��*����9��AE�xD���*~�"`/��	��C���V�ju�Iq����du\?i.�~��5�O �(�o�������h_Vr�v[�{u�~sl�q|�����'�[��e���d�)SvPZ�/� sֆ�_�CGC��S��9ͣ��|@����/	�K`^舚</���ay'|�(�i���3��>����R�T���l��(-*z��X�����4����>�>��4G���ѶQ�����%��?�M�1� ��=$�P�&V�>=Rj��������g}��]�с�+�ɢlW�����pЃ�XwB�eS��2*���i��F`}���~�p��!��-n�Uuln�;�	����A�� ��Ԣ��ay���`�Y�1c�b�4��^l�{��R��z��6��V�'�$�v`�?e0Ii-�$�zކ��8y���D�����@��ho���v��(=���S3�Ԓ@y���5�V:����ɻ|`���7K��g���q���˾�dWI��9�������Sp���4���/Ւ�n���#��gY��I���� "��c��V�[~����ih�g�����O�
�*���%%��1�Mr���-��'�
_�W����B��B����a�t�);E��-��4�ؓAx�c�v8�p�;(�iJ�s�?Q!��̝�2���s���h/OZ8t� ���	�8��ݩw���k~�b�u���X���3%��t:@��к��je�����i��<�԰�:��xϠ�TC�����T'��oᓒ8�}�+��)XO;�TӐ����y�����.����t��U��Y?����{���/��n�������fP5^g�O0���͎u�m�m4�'z��Xh %�c
X�!P;��ry�F5�(��E�����X��yqu�� d�lt�N^���p8c=s:?{��~g��0&���<�H�y,�����7�ȍ�l_�$$s��
�=�k
]���y��0*�``��.g kSQ��/J����b�0,0����5zx�<ҭ�������=���$)S�x�*ʚ��(�S���B/���(]$���v=D�� ы�v3��v�/�����7�5��EY��i�	,�1��1V���p���_�<9˞�2/O�����NU�6�:��Y{7�h���0��MB�` Ϛ�� Aq�>��h�o�N���0\9 �~^�߼�&�����%�����y���S
NI�11�����<n�9�.0�;m�˵��ګ�A��ck���P ǉr���b.ņ	0TŅ7�hX��{�rν��u�u�[�8��]8��^����ݫ���Q����ʼN��J`}լ�{�Լ����V�rY�r��p���1�:�q�!���v?�7.����ߚ
I�ŭ������ek��U���xk  :��3�:_H���45"fL���z�^�y��p��̧[��[L�VS��PI��47�A���]Q?���>q�{�ybMz�&������l]����x���X`�>�`x��i?�o6g?Ҝ�-�N�+�����=���<ܖإ&#�7z���� �p<      F   �  x�]WI�1[Ӈ�+<s�����6��*���$(��e,9���&GƐӿ��W���������s�L���]Y��t9����/�)�����>�U�{�����]Q\�����*v���fm��t.ݛwi[ξ+C��s�C(mH�x?^[�F��k,Nn%O5��~���%�!6��	�iw�I?�Y�f�,����#�Ku� ���!v��%}�s���)�5d�����鼃EJL +���d��=J�:�L4�1P��&
��!�s3&��o� ��0�%@�T:�:=��L��~�O�l�����ŞN��q�B
$ڃP�z���C�#D���&V��%y����
���8U"lY��H$-��'�n��:���%c��ŀ�d6Q��U+���"NcqJy֫��zX*�O�%6R �QZ�S�kQĸ�3n
���l�R����^���B��������a�al}�S[qm�S�h6P�W�7����.�%7�>�{����Md�a'Y�&���:���l;�iZ7&Ԧ3Ш�q鸀/[Ag>o%HHq��鲃f��tŋS��	8�%����K�Ρ���_���U��A�E�0P�Ӹp|n����)"1,�� ��<�س�������=��v!h@D^�+����t�Kp��l���7�V��F���*ߤjnc�c�}���E�z��S���u����Q��ԳOBP�(ޡ<�by�V҃>�1M���.�'e���t��a��h��WYTR4g���R��G#�L
�ղ��в��֚W������o� }�eRi�N���Q���Ke p���Ec��s�>���w/1;V�!Ja�
�����۝34}�k�Q5�3J� ��j.�p����Լ��9u�ҷ�"��3|�dH�l��C����&�"�������sRێa!<����-���O]?�:j����'�P�S��5���/)<go�I��]��AOّ�^�PL���rWo����r�ՙAa��h�T�W�u[�26�WI��J�SO˧�Vk���%�R!W4IH�䫠�xe�/���˓
4p�z�(��T�'�>�S��j���<|{-.7-�I�CE�m�Q+��"Fԑ觶���U�:�������KW�Ð���ք�p���q��4�&�A����-�T�Q(	�p;r 
3��"h1��r���>���+������|{S�J6a����������9>�}���Al�o��k����������j_�      H   t  x�uZ=��Ln��S�<Fᯀjo��u��4����(���8�y� �.$��DQ9����}�P��-�5���u�,�8�пc�{��Q_�/�W�5V�����V�R}�ģ.I�>O?�g���y��\�9��:㈟���_c�l�Ƹ�ըs"�������?��5�K�k�+�p?�?�&��o{�y��g�u��W��/����\�v��~�"��W�ߕ%Yv�8��g��Ѥ.O�1O�ǯ��������_�G���R��8E<����|����f�)ƨ{"���𗌗����S��g�� 4�%���8D����!����\��y�ݣL�3��5�(�L�����z���q�
�	���������O~�b�x}�������k-���C6���<��y��wDž��Fݑ5�<0��E�������j�z`���AQE��bN�6`��:�5}I\�1�O�E�VԿ�ȴS'����y$�Y���<T~�U�硟|\�N�Cv����x��5�lթ�P�z�;�-x�J���ơ��n�v�*�N�Ccˮ2�R��~�)���l�hF��O������R ��̫�A~hn����jN�OF=!��Eچ���0�,�'�/�+�#%��� P#^�-���iuظ��d�,s�Ŀ���܇r��0�����FIb�.�4����az���~�˰���0ۊh}!i8���"k��16�Gg�]ZW��Q~X<h� �:�4��6��	�	�Jg�S}6�ߦ,Ji:��1�AwHYG�b�y�/�?K��ˌ*��T�^
�� >E�̀j+0e �u/7k� �
��r�ؘ��ּ`�����zv��lDB�:-P��a���|�`�e|ފQ��hwU�d]CL������n,"�(3�`b������ţ�OgX��������66��������75 �I:� �-q�:|>!�՛�� s�u����3`�eb2�ܨ�9nG�����0��`=��p��B Qv��8&X@8'�@��z�w�hc�G-��sB���:�xi\ i0
�hSh��+J�!��s�[Kk4_|#d���~?&�E��534p�Ũ'P-¼Xi�br�8"�@q5��*��0�gF��4Þ��
3�L=b�w��h!018��	��afȬ%�J���66B	� �>�{���| �Ϝ��7������w%�6�X��F�0l�A�dS6ZPO5��`�\���[?t%�t*fA�cnm�RS���L eJ��d%�J5ñlRg�1�^��Aq�����옱s�X�Ht����p�&��*PƚP�q�yo, �(o��\g�|t�4a�u��n����i�Q���g��ߛa�����d�:r<Z��h�^ ?�`ԟ�P�n�	b^r�lCc�c&X�i�;}�(�S�kTs�2FmJ�]� I%5����#�Q��;��J�Gn^z�@ �DB�<rwp±�A��72�E+�%���]☏���\phσXC}R�BPؕ]��2� hIAne ����Q �R[�r�`m.�ҽ\����Gm.����CN��QI�y6NQ���,����GmR��
��1qa4V#��Z<u
�3����ȂBSJ����Q��U޸L�QG�ƃJފ�Ҳt*T4�Q{�����O�s�?@0�LNgx��QsCm�d���_��QxT>h�N2�ӹ�TD�N��$}J.�I�{�u���K�I.Q�~iklT2�_M��a��0����8�/Eb�/�c����p��P�εY6�$�&�}�D�#j˞<��uF����:�-[��;fFrŃ�޻��0�)Þ��7d8�Ԙ�];�v��&��~��?���n��ي�a��Ѻ~�4��-�_
,�2*�rDNl���x��v�ޖf�/�d���0������}�h�I�?puܖo|���MrY`��C���,g���N:��#�K��+��B�0j� =�ƳX���^.�vג�(��M7T�z���%�~��.A���1��\�Lq&(�(\��y��F�� z$eq��FҺ#��	��6G\�qY�J�*�\�3��{H>s�,ሲ�YЉ˭|�ϒ���c�5��L�;��o4r��D�.L[<6`}�C������<�Ǿт��r�9�}9��gK�T��W�Zr��Y��<(qt��<pٷyҵ��;���\dcΥ�F?c��g�ْ�Fo���E��������{�A�_ ^'�)�.��m��&��>�uU�a�qO��GmS����3�ͮ�w��c��؃A\6�(͌4�������$��'������^��Ñ���>�ԓ���6�ϋ��h��pN �!�MP~�:�je�E��!�ۖｵ���ܠI��K$���w ����_�`wD7��ƙP���ad@ ���^�e���	�B,p�y������2�?|�u��	�tѪ:����fW��H���ѸU�Ihv�0Y:h�c��XO��6Vnc�j\iN��Y�����W��XW���6�w����0-b[E�V�<5W��{��!���{��b�Z���vDn������&�S�Tl���Ը����``y� �u��U�@���y�=&���fΤ8�Xnk��Y�=�s�$��y�ZVXQ����o/�K�s�v����s�j���b���p���N㄁���B�E7��\��
�X�1����}qEb�	��B�������F`�揯6�r�kX y,���������{��E(} �V�q�qZ��ў*��X|��:ai�(��츭�Ę}�2/
_c,��mI��e�'�*5h�?��`�C=qf-B�-�������Ö�?a��#�R�#�F_�z�]b[��bI���f)$&�w�G�[k���E�i|7�ٷ�ﻹ�(FV-乄nv��t �He�B�Kl���n\��<G.T7�9�3Uz��<���W~KP�wG��K'��x�[9z�X��Ps*��ğ���Q��Z
�R�����smL���R���}m<{}�߸�Q�8b��t���)�{B�f"������<��y����:Y���5��vB�2nv�SS�Ų޺'m?�������@�f�P���m�d�nx�9�yú:n�?���+�";*o)�ױ��蕁�Mm�#4�<6���8�Ϧ�(����D߀@3��C�u�s��w�}u�;!?�����t�>��2@Q��񹯔����{�2x�Llv��Z?)kJ9DqY��gnz�Б�n�.�O������aZ�B������[�4�K��&��{����}�-z�/��]��V(�u�f°"��+��7(���hr�K�������<ZA�my��ql���F+�(�e_7rw�v]���|L���W-Y��o49�r�OI`��UEi�s�,�X<��^:�^i�sm�)��������r��ϮXh����@�6ͨ�Y��ik ?���ƳS�c�����q�믧���J��:0ԕ���m�j&�ː�Z*�}* ���4��ņ����I�t�w1^D5���KEm�d�ĸX�y�����'�;����*�](pXr���v�8���?�^߂giڔ������?f��ip�����,j����A� /����k��}H�"�t�G��~Z2�O�ܟ0=�v��������Qm�k������an���\�t#�,�s	�v���gv�Yv�#?���f�ĳ ��͂�� `���R�?*���/���-OΠ��~O#��]C/�8+�1�b�ھ�&cv�SH��G�9���7�Z�#,{��-$�v����v�ӗ!o%}-LK��}l�g��3"<��E�66�k*�~�����c��+��Gw�Ϭr��:��V1Ar      >   e  x�Uұj�@�y��-��I:���Щ%PH;��$���=��+�N YL�;��_&�p��������p����YIE� J(�b��A�[��k�GH��sN��9���y:1N��(N��-^o�k�b���~�o|4�C�%%�y���8_¬����\�@��	 ��p$wer��=�K,D\fJT��t)��ow�2��5#�Sc )��,^n_j��z	RN�d�A��+�2�]7S��ج�c���h~��o��iw����L\��v�\�.���z�^�����ZVk
s)D��5��W��ݨ��P�l`�ƭ�kؕp:��?�v�g��d<_?��m{�ɖ ,8����ڪ��b�����~      B     x��X]o7|&��@Mr��7�-P$i�}�Ȃu�%֩8��w�ȩ�wGJ5`I��pvgvi���ۗm�߮�j�����Y<��M�X}K�>4�}��H*ǔ����V]��{'��~�~i����z�]��+��R��_Wm�<���w�uӵ��
<9��f*N>���n��a�Q����.ڮ[n�QKe�f����;IFG��v�ۯ��V�n��E���){�6����d*�)z�m�ns���#���g�;�z�r��9`ϋ}����L�shgUeѭ���#�>�������Z[��Ȉ`����O�O��A~�> O�E�V�]}�<�`����n� �:&+i��;�xj���keu�	��+�\?�K�.Z�&�:��i�y��A6�"�D�N#_PP��i�U���?>\ݼ<�;t-�`(��Y�{F1*1��!GZ�9������񣂡$qP9���ʽ������i��8DzĨC��.N�M=���ݾ%��?��T A����O�);~���eR�2c��2p:X� �drG��KܕA.hN�r�Iu��NF��+I��-�>��K��Y��I�?�����~ϔ�媚(jꙟN�`G�����7�p!k(�s+���z�"'������h Y�P1��"�2��І�l,�M$�C*l3﷛�����o��k��h]/�A�ę�Cc���:�T\��T���Aj�;�1
��Q�4�.Q�2�6kb���,���A_Y{�k�N�<E���ӗ���h@�	바z��G�s�M�+0!"�됒�,�2-��s&���ɂl�r:�$��������FN�0#�����kEp����m�@�u9G�[D����4�~�˻�twK[@5�J�lF��|P#�E��r\hi������{��P�1�/��S���clI���OG_&0b)p�����u��߮~}����LNTj[���c�M�eV�����R7!ir	:��j��;����&�`�om���ǬL�1>��8��G����%��k���]c�      @      x�}Z�r۸�}f���I������q2s�L�W�٩�:/P$K�$�E�ۥ��� e�k&q�&�F_V7�&t��\ujʣ{,���7O'���zvۺ^����\�w�.lfL��?��U����l\�g�Hm�6Ӌ����Bp)�%�ox"
-����۴�SY9Ó��9'7�����OW�����x�֨wi!xjD���w<5aV�Y������X�02/hV����ݩ���{q�T�O'�/�uӟ9W�Zs�[��#6��ln��pU��6ZC/��)��g���)M�K�5K�uU?����&?@a���'θQ�b:�R�ˎ�òݯ���'�Z&oTl�_�]0ű�ӛ�6-�'w(���Z_�?I�F����`�Ra,A��_�������M�g�s��W�K�Y��u�hv�(�yr\?�ʭk�0�R����md��WS�%ߥV�Lj��u��6�����
3��"���:X��5��m�������H��`�@�&ϸf��L��?�7�f��5�}[��&�~z��oL��ȷ�#��xt���S�Dc�����]p�\nX�Dљ�W��sڗ��ІE(n��Kü��
ɼ.l"$-�5Gwv�r[�e�����X�C�z@aߥLA/����|N,�:�^�'�nM<�*���F�Ɗ)�w���GD_|8a�m�~�#���S0�Ð	>��"ﬄ����TR�jJ�z��o`$7�`@�F��P�.d&6�q�H��{P��O-�ˇB�QH��K�)a�"8-B$G����
N���h������p�\�T�K�P�Z
��]�B|���y)LR��l`Q����=��B�������Ǒs�m�Y��e[wx�:�!2+={2�~)��Km%�S� �Z4�(1m3�s�O�nq�~��MY��3�0sb�
'��V%��7"��@��{gE� �d
�q�K(�g]��hH~�Zm��+h*�A�#(���c٬7�:��i��g��+D��gB�h�_����Xh��/�,��ϨC~qͪ���]߉�d�k��t����r�����E��<&Zէ�v��3�0��U���m�mȦ~fO��c}k���-Bs����iݸx�R�Z�i� �{C���"�	F�*:9���,�f��c���б�;�����s�n���JX,	g��2t�����ط,2)�{��qB�S���p�L�|
�<c�7�.�
6Z���ux�`�P6�Y��P$M?�om�b�!����NXq!f�b����N�%ͻ�qG�`����x6��B+�,���Y=�cɒ�$B׹�8��I���p��T�M`v#��? �#l��r��y{�pK�D
+��������Gg̀� qN���y����a�Sn�#����rK�W�.���p�j#�a	�g�V��?�'�֜�U@�K�#������{X ّ74��I�)�EIo�� ����jsK������L�z�%k�<�B���Z��\��+��N^x�\|��U�����Q	�����}`�Ń��|��)�=L��=��Uz�ql1��Bn�NA+8���B'�Q��"�����@���m&ԥ������#E���]C��!0�^��M��<�\���j|MX���[MY�.eL"�y�`XŹX�ȩB@0�6&�Y�����} ?$�J�Ӈ`�E&���PB*���SL5�Ρ:���4���v�CI��՟���x�A�����5J^����dz"$Dq�Ѯ�z	@�7O#xF_�3D�;4O�f����"�.`�� ��O �}j�eD�?���-�=����<Sj]�;�'<��m0|�������Q{�}9YJDCdr��p�+``p}n����߭W���P\��l��*x�O���?-���
~ 2�w�{������4�@�?�ŷ��d�>=1i����s�ڣ[9|�6���D���DcY�R���'FyIV2��S��l_��vO����C�"��C��Br�VEf�/:��{��%ݮb�/�rѝ�}�i��z�A$�x�{�k@w-y����v�~��aZ�{��=/b��~�rٸmy "w�	��S�	���O�p0D5+Sk��0v�O��dA��u���Ʌm��z
��Z���@��V���k�ɹݺ�'x�9.��8�ע�U[�`و��c u�?9ٳ����+ͽx��&V㝠ߍ�2m�R%�"�2?5(O�����d�\��j.�A����+��D����إX�T�]l��j&g?�A�����m^ ����|���x4}������@�OwCt1]�ث&-w��ȗ(�\g���f&�.�M��(/������zf:`���	�m�(������G�`����2b�����.����6�u�F��'c�4!�"R,]א��'��_��܋1���� �4�b�	%6dj�8��r�̈L�>��w�苇*g�z�SU�%�~�C�&�"ZG��>Tb_F'7�B)��?`�A�հT
�/ �7������q,���]{���V� ̷�I	%r'� |��*��\F�2��"��m��\�T�ZxP\�y�# ;Fp��tO8ў �F#�О��>,�6�QsUz��'�//�%aMv2y螰��)�I	��4����T�{��u�'�����>�,�Ӷt��.����|�x�AC �t��Ͱ����f�Pง��v����Jn/�ѠQ8���X��c�*g:*��(O�k���G�U96��U�F�L"�G��#47���]�E�B
A����$ ����Za�s��4���&�&?��*'d�T���C�h�	�$F��Z�a�*�Y���N��oP�Ԟ���"�ʜ(�t����қ}�R�������B�����t�QU�t<ߙ&�x��A8K�T�8���g�����o�l�p�VqN�7'������r��d�O��>bz��ǐ�3s�H"��M�>���C����(�G�ע��`�f�#�X���3��2��!�J�_��́������UA�^�TY�Y���ۙ��\�_�C�(��o _��Z8�'H��aLu��OG�)p3Hɐ��:�
_G��K~��8�= �)�§��p96�\i5��"�{�(�oKj�$�d>��F_�O tS(��Q�ύ{�>�M�`�x�F���*n<�[G�hд��
gòB��C�R�~P[>$>�f�<ְ�z��>�������9�C�cҾKs[�p��kS�3�O�_X^���; s���R��#�=at���gcΙ��s�^ِ�.Fߩqq�.�Nd1*)E���O�"Noq ��V@��+�xG�[#�����e��+,�3q�o�p���G_*��"��9�t���3�~�+��긆��3pu9u�Q}����a}*	1m/��Ɇ��Q��}��P
������GYOӃ��\ֳ�(��7Ľ�u���m��":�j�5h����
8��Aӎ��:��W_�*^�h�j���u�`H�u�4��g��'ʈ�2�O,n��c�ߠT����G*���`Ȩ��H�����?��)�x�ҟ.�\���j8wu)	�ίI�'����&�*��84�'�gL � g�yr�U�	q�&7��<D�pȨ�v��C)V�><����d�˛��܊�G���/0���3���@�\����xg.������M��5P��_���Ń<T(F= �IAO�=Znf�6y;�*Jv�?ɶ��<���������L9�a	���� &. 6�-)����b����L��tO8F���:�ZH�{�o���L�S��,��30<���i��R�Xl�ȯ�ԔΛ��JF{�j-��և�Xs�vog=����\ȵ"�L�.Ռ����3��P�ܮ��u�b�N�"�R���^��a%9������,�A4	/���Jo�<}���GE��2��:���.��l�����2���x�|"ε������+;B��M���E����5��z���ر|��!�m"�2�,`ף���;m�� ��]�{�����5~�ᐑJ4��� 	  �A�ǽh�۠Y������KX���?��?t��0������� ��m��32�v��76�A� �B�T��A�h�:1��a
p�I�?<>���V�]{�5������%�/�/��#Np��u�=k8�W�)�V˭�j��R����f޻��6y�+$:4�����$�ݥ����:��#��]G�O���/dյ����8����ӛM�gZ!���<l���V���e�O�&�R����U0�No
�ɑv/�������vW��UR�_����n�;�p�pzz�j�J��;��o�x��g��ѥa}D�_?���6�Ă"o4h�%Ex4˺���������������,�ܟ�Az������2��ĵp�)��62QW�ʒb:Wa	&,�`w��\����|���ģʜP���p���fT>�v9>^^��Kj@��y��tr�}���7'R@3o>����
X��}��<H�~�G˃!���6��B���1��m;����x������Y�     