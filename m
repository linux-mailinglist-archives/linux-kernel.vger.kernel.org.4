Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4C5F460D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJDO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiJDO5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:57:18 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89F7275CA;
        Tue,  4 Oct 2022 07:57:14 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id o17so2359836ljj.2;
        Tue, 04 Oct 2022 07:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7JQ+kbmcSP5RNYOOPozaAGUuDB8WoxkQS0RnWZ/8sdc=;
        b=A5MxBR14HPfmLNB7E9WbzrgnMny3yTnUHwuZbi2Rr0dDF3ndcPi+BGhfoS9oO3PrVK
         dvguRHsFiO7F+cVkfxz2j5Sz4HyiDgg4FVqcJWyV916GQQcKZTLRMc2BZSrp6CE/I0gx
         FGosglv9fRh2KyoSateTnNmtbfCcFz7f/kBg2HqNbE5OHpwee2bvO7Fkq7yYk35c9aax
         dG+53fo6XK+ofWsIbqVsemjU0l+L6cZL5EhwUyn9T0RbgDlCO1Usj/V6mTVSasib300p
         s3WVObf2vn0lj32kg5o8ir4WIa8bG7AGEW+oqVrXFDr37thI1joBh1BAPdvI1J30p1FC
         DlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7JQ+kbmcSP5RNYOOPozaAGUuDB8WoxkQS0RnWZ/8sdc=;
        b=RbWLEOF4ArS72zgN5QTqMWW4DK5mmMvDoIGW6MBDY0fQS/s8i8FUFv1QO3C3bEPoPI
         Pru4t5W0/aUJhZVWmJhJD+CHPWrlZlEjJVI4LU4yNvdhcU6DZVWawfHAD2F6MWDaTJD3
         gvLY7+aQOwOPiqqD5/gTfr0WhmL25G8wSekFC4d2Q+1I+BlT332UDc4frVUFpqZanIQj
         QHqwtmHY89s1IpuM95MHS/F8wxHWFY09pyhJpAKQyTT2SIjC9S31NBdb7f6qSd2N68/k
         p5w+Uc1kzl90CxbXwWFud6s3tgdEhKjyW4lcPse81oE7WcqyfdPk7MJG5DNIYlmbABjr
         cSJg==
X-Gm-Message-State: ACrzQf1U8ak71u6TeTaBnD4543ot1VCXs3c8WmE8MfIwijq8xSEspwRZ
        oMM6kDDqUGOlQxY7ONDJy22h30v8Gvys7A==
X-Google-Smtp-Source: AMsMyM4QcpJpVAA7h6dQC4uEUxe0xip0WVaIvSWXsD9Y3mQfofpuU5QkNgDlZeEjFw7f686oodj7rw==
X-Received: by 2002:a05:651c:546:b0:26c:698f:a4a2 with SMTP id q6-20020a05651c054600b0026c698fa4a2mr8906460ljp.161.1664895433142;
        Tue, 04 Oct 2022 07:57:13 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id q3-20020a0565123a8300b00494a11c5f52sm1945147lfu.256.2022.10.04.07.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:57:11 -0700 (PDT)
Date:   Tue, 4 Oct 2022 16:57:08 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI LMP92064
 controller
Message-ID: <YzxJxCSHP9tGHge6@gmail.com>
References: <20221004134238.3144326-1-l.goehrs@pengutronix.de>
 <20221004134238.3144326-2-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krXJhXCH+I9hQ/Op"
Content-Disposition: inline
In-Reply-To: <20221004134238.3144326-2-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--krXJhXCH+I9hQ/Op
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Overall, a lot of comments does not have the right formatting.
Please run scripts/checkpatch.pl.

On Tue, Oct 04, 2022 at 03:42:38PM +0200, Leonard G=F6hrs wrote:
> The TI LMP92064 is a dual 12 Bit ADC connected via SPI.
> The two channels are intended for simultaneous measurements of the voltage
> across- and current through a load to allow accurate instantaneous power
> measurements.
> The driver does not yet take advantage of this feature, as buffering is n=
ot yet
> implemented.
>=20
> Signed-off-by: Leonard G=F6hrs <l.goehrs@pengutronix.de>
> ---
> +static const struct iio_chan_spec lmp92064_adc_channels[] =3D {
> +	{
> +		.type =3D IIO_CURRENT,
> +		.address =3D TI_LMP92064_CHAN_INC,
> +		.info_mask_separate =3D
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.datasheet_name =3D "INC",
> +	},
> +	{
> +		.type =3D IIO_VOLTAGE,
> +		.address =3D TI_LMP92064_CHAN_INV,
> +		.info_mask_separate =3D
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.datasheet_name =3D "INV",
> +	},
> +};
> +

[...]

> +static int lmp92064_write_reg(struct lmp92064_adc_priv *priv, u16 reg, u=
8 val)
> +static int lmp92064_read_reg(struct lmp92064_adc_priv *priv, u16 reg, u8=
 *val)

Does not regmap work for this?

[...]

> +static int lmp92064_adc_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct lmp92064_adc_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct gpio_desc *gpio_reset;
> +	int ret;
> +	u32 shunt_resistor;
> +
> +	spi->bits_per_word =3D 8;
> +	spi->mode &=3D ~SPI_MODE_X_MASK;
> +	spi->mode |=3D SPI_MODE_0;
> +	ret =3D spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error in SPI setup\n");
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv =3D iio_priv(indio_dev);
> +
> +	priv->spi =3D spi;
> +
> +	ret =3D of_property_read_u32(dev->of_node, "shunt-resistor",
> +				   &shunt_resistor);

device_property_read_u32() ?


> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,

--krXJhXCH+I9hQ/Op
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmM8Sb8ACgkQiIBOb1ld
UjJJMRAArlMzqVmgkLxZUed6pPK2BrT90bF6UApdw6YxWeEcmNt74WjGuNA8fF7s
8yazOsXsGuUh0A4CplLlQD4AQFDPr5gk1cL2Iwl1wpD05Gk+5sAKC6ZPIpm58yp8
pZYlr/GkbFXmnnhoDEWvcxOGBi7hIzWyXSivc3LoEGoiETkz6Y4O6su0ojCBPurW
Z8X7W5fVKo7hA60QpnXsNzCRSYiNS7bbYiscqIR1OEAtMOYELKh/GGvaxDPjAMf8
eqlpiBhQIk+TffUpmViFapyscpa0vMox8tFQO8U+RextUOJtUD1JyHgTzAqGWDQ1
aJZaLCs56JSTMeJPa0w+M7DhLZnAM5C7Mgi7oRrviHTYKTsniGb81Jmfew4ST4eM
I0Z1qa7WUQhYyn9uA7yy1Sb0JNN/uYbutuHbs8xz+gZ4fiQuBVtKpsqwo10NmVFo
pPM479LskPWIK6OeZvOA6alI7KvjOtFQPonaiaRY4Qn8TJ9roRYaPG1czuLA+lM5
xAloZ+VsWnjQM7JMgoUk3psy16Zl3ftLF4YHIbMSpihgIXa97CjjlhHszKij9zvq
RvHElz+j1TKNTtqCRiP7lnBBEVVXK9DtsvY/VWqKxz1Mf0C3bq8wkvLnZJeWz5c6
d5flT28E6KbBf3zWl/16KHmkutTtRu9Pvt3UHLRP7mGDnQ6/UME=
=PAtT
-----END PGP SIGNATURE-----

--krXJhXCH+I9hQ/Op--
