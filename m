Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556FA5F3E90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiJDIkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJDIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:40:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1312778;
        Tue,  4 Oct 2022 01:40:09 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o17so1269083ljj.2;
        Tue, 04 Oct 2022 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0cJBLgx0FGkVH8iEBTdNOhtJXa7wPHwjH61sWMzelDA=;
        b=IUhkJgKFpfPlEcSVF81afaLWFjvNwot6Gy08u1Q0uHIrEslovSUP9UTmkfv584wpBf
         eS8zS0Fjmyck/c9bKlzmOHrEzh78ggRLQrAhtL1fqdW1MX2Eb3+S9V4uCjYxna0WHZJy
         0iQ1Yzj/HRwOoF/MROoDwi8UyAfbvlgkSpDJhyh6hB223Wmpthgm6pMmqRvXHoXlGTl9
         WSDS3e6HKA7nEECo5GgPQKOlRmc2bVTQF6Xq6P2PQAP/4umJkRjAgvPUdEtr7EcQ8m1F
         PN+jxZQDjCKmwt29hXKbT+1BOu0oP9QoxaIo5z4qD4FhtCQ22eLsnh2aVpwp44w79aEc
         0QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0cJBLgx0FGkVH8iEBTdNOhtJXa7wPHwjH61sWMzelDA=;
        b=h43/AuA86S/bHrN6Pgg5Q4wSx/2LFX4Yjq2H4ThAMP4tGEMOazhu44i/34RxZ6zMl2
         3jM1Gu+hx/c5j3rOy2ne7AY22mBCNrW2PY0G6y1nKVM3fMkZ78fhtibVwL7UgV/6IHPO
         Kx7n2HkmzI9TOtI8LWFqozRZiX2aelu1ZyHnffZE8zdksKkIvSti2E/Si/hhqPTqqRQ3
         w/+qU487SVLSkslY4r9PQqrfYAfmh9vY7Fg35zO/UJHXsymQonTl6818dp1i7/dThGoA
         e3anXm5SWukV6SMCxyD9385dgZ4/dA0HRofWtux1I3YcHmOTvDG+tTprjQEguW4uSDHl
         bing==
X-Gm-Message-State: ACrzQf3OzLGUyD2G69glSzoJURokfcEZyUfj5t0Xg3Gv9Wb2GLx6//AY
        cmW+sfLW9nqWaeApGAhD2/SibWMqckbJlQ==
X-Google-Smtp-Source: AMsMyM4lj6TaI0+/n658awJzWJS/7Xp9TaENOB36uakr2I7+FJqebPF78biM4a/Z0oY05Sj0wxjsvA==
X-Received: by 2002:a2e:a365:0:b0:26d:e65b:e4cc with SMTP id i5-20020a2ea365000000b0026de65be4ccmr1701967ljn.373.1664872807870;
        Tue, 04 Oct 2022 01:40:07 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id bi18-20020a0565120e9200b004896ed8dce3sm1824231lfb.2.2022.10.04.01.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 01:40:07 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:40:05 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Ciprian Regus <ciprian.regus@analog.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: iio: dac: Add AD5754 DAC driver
Message-ID: <YzvxZWimiIkIF8rd@gmail.com>
References: <20221004071825.791307-1-ciprian.regus@analog.com>
 <20221004071825.791307-3-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wNRpo2JyFabJuMi8"
Content-Disposition: inline
In-Reply-To: <20221004071825.791307-3-ciprian.regus@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wNRpo2JyFabJuMi8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

See comments inline

On Tue, Oct 04, 2022 at 10:18:25AM +0300, Ciprian Regus wrote:
> The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial
> input, voltage output DACs. The devices operate from single-
> supply voltages from +4.5 V up to +16.5 V or dual-supply
> voltages from =B14.5 V up to =B116.5 V. The input coding is
> user-selectable twos complement or offset binary for a bipolar
> output (depending on the state of Pin BIN/2sComp), and straight
> binary for a unipolar output.
>=20
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD5724_5734_5754.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad5722_5732_5752.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/ad5724r_5734r_5754r.pdf
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD5722R_5732R_5752R.pdf
> Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
> ---


[...]

> +struct ad5754_span_tbl {
> +	int min;
> +	int max;
> +};
> +
> +const struct ad5754_span_tbl ad5754_range[] =3D {
> +	{0, 5000000},
> +	{0, 10000000},
> +	{0, 10800000},
> +	{-5000000, 5000000},
> +	{-10000000, 10000000},
> +	{-10800000, 10800000},
> +};

Should these be static?

> +
> +enum AD5754_TYPE {
> +	AD5722,
> +	AD5732,
> +	AD5752,
> +	AD5724,
> +	AD5734,
> +	AD5754,
> +	AD5722R,
> +	AD5732R,
> +	AD5752R,
> +	AD5724R,
> +	AD5734R,
> +	AD5754R,
> +};
> +
> +struct ad5754_chip_info {
> +	const char *name;
> +	u32 resolution;
> +	bool internal_vref;
> +	const u32 data_mask;
> +	const struct iio_chan_spec *channels;
> +	u32 num_channels;
> +};
> +
> +const struct iio_chan_spec ad5754_channels[][AD5754_MAX_CHANNELS] =3D {

static?

> +	[AD5754_2_CHANNELS] =3D {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +	},
> +	[AD5754_4_CHANNELS] =3D {
> +		AD5754_CHANNEL(0),
> +		AD5754_CHANNEL(1),
> +		AD5754_CHANNEL(2),
> +		AD5754_CHANNEL(3),
> +	},
> +};
> +
> +const struct ad5754_chip_info ad5754_chip_info_data[] =3D {

static?

[...]

> +
> +
> +static int ad5754_probe(struct spi_device *spi)
> +{
> +	struct regulator *vref_reg;
> +	struct iio_dev *indio_dev;
> +	struct ad5754_state *st;
> +	struct device *dev;
> +	int ret;
> +
> +	dev =3D &spi->dev;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi =3D spi;
> +	st->dev =3D dev;
> +	st->chip_info =3D device_get_match_data(dev);
> +	if (!st->chip_info)
> +		st->chip_info =3D
> +			(const struct ad5754_chip_info *)spi_get_device_id(spi)->driver_data;
> +
> +	st->regmap =3D devm_regmap_init(st->dev, NULL, st, &ad5754_regmap_confi=
g);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(st->dev, PTR_ERR(vref_reg),
> +				     "Regmap init error\n");

Are you sure you want to pass vref_reg here? :-)
st->regmap

> +
> +	st->dac_max_code =3D BIT(st->chip_info->resolution) - 1;
> +	st->sub_lsb =3D AD5754_MAX_RESOLUTION - st->chip_info->resolution;
> +
> +	vref_reg =3D devm_regulator_get_optional(st->dev, "vref");
> +	if (IS_ERR(vref_reg)) {
> +		if (!st->chip_info->internal_vref)
> +			return dev_err_probe(st->dev, PTR_ERR(vref_reg),
> +			       "Failed to get the vref regulator\n");
> +
> +		st->vref =3D AD5754_INT_VREF;
> +		ret =3D ad5754_int_vref_enable(st);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regulator_enable(vref_reg);
> +		if (ret)
> +			return dev_err_probe(st->dev, PTR_ERR(vref_reg),
> +				"Failed to enable the vref regulator\n");

ret contains the error code here, not vref_reg.

> +
> +		ret =3D devm_add_action_or_reset(dev, ad5754_disable_regulator, vref_r=
eg);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D regulator_get_voltage(vref_reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Failed to get vref\n");
> +
> +		st->vref =3D ret / 1000;
> +	}
> +
> +	indio_dev->name =3D st->chip_info->name;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->info =3D &ad5754_info;
> +	indio_dev->channels =3D st->chip_info->channels;
> +	indio_dev->num_channels =3D st->chip_info->num_channels;
> +
> +	ret =3D ad5754_enable_channels(st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(st->dev, indio_dev);
> +}
> +

[...]

> +module_driver(ad5754_driver,
> +	      ad5754_register_driver,
> +	      ad5754_unregister_driver);

Use module_spi_driver() instead

> +
> +MODULE_AUTHOR("Ciprian Regus <ciprian.regus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5754 DAC");
> +MODULE_LICENSE("GPL");
> --=20
> 2.30.2
>=20

Best regards
Marcus Folkesson

--wNRpo2JyFabJuMi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmM78WAACgkQiIBOb1ld
UjIeUBAAhIaHOjhwWQa1Xaiua9sPj4FVhMmOdG5/mo3DiuwKg81R/XZw8jNTK4M6
mdG+/QoGQbkTDpQlmQZwnlnkb6r6Jjliws0bz5+WgxJGDTcCJgse057nvWWP4Q37
MRrw8AOkTTvVJC+r6s797txupBa+/e3cE/AQQJch4cVgDLsXiWw1D2lQ1aPsKeKw
3UOLVusaCrg6Zb8RufFv+o6QtpzdeulwXQ5XjLMKhuLphmVkB5jX01DewgeUzvsN
xVkg1sSbLJL6IIt8/nYDwgB51QWRt+jPCCytbcn4QjLM9nX0Hkc0gXzn/RGxN05O
UkYwWukPkEgJ0z5+pqTrPij7JiQjwyWMesdmP0/Kgm8QqnJawRwTzLlT1YmqCwFU
jllOBuEQfUUmhqtU/NDp5a3VPyHJSmkGOsgjeoDyrH3N7zMUj5BvToUwAkDwT8GN
OjikTHJWkCEFycKED4UurOene4+bgFItWrhrlgBAuqfXbI46nPqb5O6/zRiz/eVd
0gPIgG/LfWeL83hTxrqgVe+Uvknfm+xWZeHdQEOeE3kVjm6cItcZ8LV8BPxJjpNJ
MffMJ2bFMtbPVeHItCbcC/DUJVGYugofT1J1Sg2JhqDfDd5WvGVDB9yfgOyntKY/
XciSXtWXL1IbrvUZ9cvIOcHMG/DMZmJ+z0ZNh8Sili37Ip3vylo=
=zsq7
-----END PGP SIGNATURE-----

--wNRpo2JyFabJuMi8--
