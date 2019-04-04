CREATE OR REPLACE FUNCTION f_bytea_to_bit(
    IN i_bytea BYTEA
)
RETURNS BIT VARYING
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
BEGIN
    w_bit := ('x' || ltrim(i_bytea::text, '\x'))::bit varying;
RETURN w_bit;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bit_to_bytea(
    IN i_bit BIT VARYING
)
RETURNS bytea
AS
$BODY$
DECLARE
    w_panel_data_len INTEGER;
    w_str_bit TEXT := '';
    w_bytea BYTEA := NULL::BYTEA;
BEGIN
    /* バイト数の取得 */
    w_panel_data_len := octet_length(i_bit);

    IF length(i_bit) % 8 != 0 THEN
        RAISE 'Can not convert to bytea. The passed argument is % bits', length(i_bit);
    END IF;

    FOR i IN 0 .. w_panel_data_len - 1 LOOP
        w_str_bit := w_str_bit || lpad(to_hex(substring(i_bit from (i * 8) + 1  for 8)::int), 2, '0');
    END LOOP;

    w_bytea := decode(w_str_bit, 'hex');

RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_and(
    IN i_bytea_1 BYTEA,
    IN i_bytea_2 BYTEA
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea_1) & f_bytea_to_bit(i_bytea_2);
    w_bytea := f_bit_to_bytea(w_bit);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_or(
    IN i_bytea_1 BYTEA,
    IN i_bytea_2 BYTEA
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea_1) | f_bytea_to_bit(i_bytea_2);
    w_bytea := f_bit_to_bytea(w_bit);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_xor(
    IN i_bytea_1 BYTEA,
    IN i_bytea_2 BYTEA
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea_1) # f_bytea_to_bit(i_bytea_2);
    w_bytea := f_bit_to_bytea(w_bit);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_not(
    IN i_bytea BYTEA
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea);
    w_bytea := f_bit_to_bytea(~w_bit);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_lshift(
    IN i_bytea BYTEA,
    IN i_num INTEGER
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea);
    w_bytea := f_bit_to_bytea(w_bit << i_num);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION f_bytea_rshift(
    IN i_bytea BYTEA,
    IN i_num INTEGER
)
RETURNS BYTEA
AS
$BODY$
DECLARE
    w_bit BIT VARYING := b'';
    w_bytea BYTEA := null::BYTEA;
BEGIN
    w_bit := f_bytea_to_bit(i_bytea);
    w_bytea := f_bit_to_bytea(w_bit >> i_num);
RETURN w_bytea;
END;
$BODY$
LANGUAGE plpgsql;

