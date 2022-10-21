Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89272607AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUPce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJUPcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:32:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491EA25E8BD;
        Fri, 21 Oct 2022 08:31:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bs14so4162579ljb.9;
        Fri, 21 Oct 2022 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+p99hO3JZsR3seDJh1ppmG0TxM1BLGHE9A9k9GaJDs=;
        b=BcTN4zri20y46WsjqEfUjS5FU+fZeCOVKrwpNqQxB7BbjtnOGV4eIgVh5PktzREHx1
         1vvM+zqgn8rLOcueR338/w5rKClqs7BOXESRRhfgMzyalI5r9y+M+w7Rrt7v9WDS6o8m
         4aEuDr1TBr+EkQnwdGqGBFfa0qLJDcic49rSFu0wOk9VLbb4tIy/nl5xU6yW9xqRsCBe
         biw2n+MrI00XXYFJ+zIgxSvaegs1LTuUsKsOVG+rf6qA5NRMgu7KN68Zk3Z61c6e6EEx
         y12uJHvEFfT3ybVwgH68WzEMl03/umEbC5TFGNvlrQCWU6VWUD7hKZoUx80bm3nZdWND
         v1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+p99hO3JZsR3seDJh1ppmG0TxM1BLGHE9A9k9GaJDs=;
        b=CUHFLEjxp7P0ExiW6M/WArkLj0M5bI1V+IvpZ6xnoSZftZcNjj9EYhz3gGDg32svRz
         IAfkFCc319sy5XXo+2wlRQlctfYv0G5zYQaYrmDGnyhIn9DD2zSMjTewQ/H8zCZpmAQh
         wZlJPT83Typ7uAcB7nN2lfzA4MisiiUBVVWeNk/z6sGZPuZSngNy1tIHR42/9/66JUMq
         obhg1Vlu1zebt8jUOwohWuh8aLkzDlratT6e5mh9nNk1hdKt58RB3ap0yFLkufG1j07V
         doo+hvzDymR+kf0cq3L+/4ZsL+6ODVzxz9qBGaij4R03HRZEksXsjvqP0yq0B7hJedvI
         BL6Q==
X-Gm-Message-State: ACrzQf1Tis46zN9U+L3kqIWggcf13Hr57bGn/LJKJPOOwcFwtOM5+Fq6
        AStBSHpTrMuRIkXJKzopTqSRfxJu56SdZQ==
X-Google-Smtp-Source: AMsMyM7Xac7NFe3v49LtkmSLbfyCv1+e8q8cfcpBfkJG/xly/TehfvdFn9GUNIPfFYzFN6fC1AjDtQ==
X-Received: by 2002:a2e:9dd3:0:b0:26f:b69f:289a with SMTP id x19-20020a2e9dd3000000b0026fb69f289amr6699446ljj.53.1666366317476;
        Fri, 21 Oct 2022 08:31:57 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id n24-20020a195518000000b00492c663bba2sm3200062lfe.124.2022.10.21.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:31:56 -0700 (PDT)
Date:   Fri, 21 Oct 2022 17:32:21 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: ms5611: changed hardcoded SPI
 speed to value limited
Message-ID: <Y1K7hWKl0siEtaAl@gmail.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
 <20221021135827.1444793-3-mitja@lxnav.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v0Xw8fmF8ByqwP89"
Content-Disposition: inline
In-Reply-To: <20221021135827.1444793-3-mitja@lxnav.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v0Xw8fmF8ByqwP89
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mitja,

On Fri, Oct 21, 2022 at 03:58:21PM +0200, Mitja Spes wrote:
> Don't hardcode the ms5611 SPI speed, limit it instead.
>=20
> Signed-off-by: Mitja Spes <mitja@lxnav.com>
> ---
>  drivers/iio/pressure/ms5611_spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5=
611_spi.c
> index 432e912096f4..a0a7205c9c3a 100644
> --- a/drivers/iio/pressure/ms5611_spi.c
> +++ b/drivers/iio/pressure/ms5611_spi.c
> @@ -91,7 +91,7 @@ static int ms5611_spi_probe(struct spi_device *spi)
>  	spi_set_drvdata(spi, indio_dev);
> =20
>  	spi->mode =3D SPI_MODE_0;
> -	spi->max_speed_hz =3D 20000000;
> +	spi->max_speed_hz =3D min(spi->max_speed_hz, 20000000U);

max_speed_hz is a limit, and the max frequency the ms5611 support is
20MHz.

Best regards,
Marcus Folkesson

--v0Xw8fmF8ByqwP89
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmNSu4EACgkQiIBOb1ld
UjK1VQ/9Fr5fWh7p566FC/TtB0AR3vyoNNvzkF/tnqTagW0bJ4+uelZqyFYxn8Iw
kS97p1YUm7zHYGWMAL2UCD8+BnGmSJBgtqxEMoa/Ew5ULHCvEVRfpVUFoM//e5EJ
fNFP65loD41VTggRSNTOcNUbdBMrHpzo5L/ENecV4fWQrwc1xKd4DDCu/dL0GlAd
2uQrKcOJbBJh4wR3n7SslOqsL4cQgZWPi89S/xvVf5VPJNjoUAmf0Lic4ZVT1FJn
ZffsTT+oTrkfUnddb26djSp+KxMg9mqaK3OPOFyWebxe4Cp9Ot+4I3uIGguSA9JP
byvoQsg17ds/EalPufTcVl11+YVqrBQ7qnUM/zlXirTzeSbm4NkEQagHkVrwgi3H
dHoF+bURYV23enpF7FQjCm/XsFHXYuiop7NzFtYTZbC9O4+g2C7i806fit0XhbY+
AJ7irSOgVTMat+UUi8M0irAVbI+GHl8U9ww/ptrghm2hUnQmmvlrI1BLYu8LOZ9P
tdtUq0a+YYFlX+1fwDUIYdLV9ELZlJOIfmvlX5skBge8C8H0qWPLTOdxISra8pP4
QIFWPQYkx4PPOcNEppCc0fX576aiYyY9RLZany6vRKspgIJwNton90OqjmOzO0RG
2V6zmX7NGPtalh1Nz1t8RRtT1UvaOqBd4hfZG+KF4yoxgO/5QwU=
=92FB
-----END PGP SIGNATURE-----

--v0Xw8fmF8ByqwP89--
