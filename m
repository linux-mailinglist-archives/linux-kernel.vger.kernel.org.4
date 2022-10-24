Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090E9609D77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiJXJGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiJXJGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:06:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEC550523;
        Mon, 24 Oct 2022 02:05:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a15so7220361ljb.7;
        Mon, 24 Oct 2022 02:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sc2xTyv7WhK0w0KiqvUbbhcFT9MGY/u9f9xFlxY5zGI=;
        b=gu9x4FYoCa++/g5ZhNvlqNJP6LDJ+4zt+iY1gwQWDC/SyQBXxakmjlvhdAK2AE0U6H
         JCXWzc0xxfuKnQ11U4niPu7CRPaW5Fye0gNIcVc488gGegb6RUOVz3VmexFQTqfktLM7
         GwFJzbCZZrNFW0v3rsrG4rc7GwBiRJocr0I20X54VZ0WlnG9GbT8nOnT8nJ2yRZROYOr
         caKWgAlK5DSAuEmGqYy1GBqynKnKS44DCg2T7g5isanAG5ucPMPcuJOl/Ose0A8qSTbo
         AGD2qcizHIH7buHId7DPz5Pcz1s1ahq6Ihr/nh7TiXndn++Hl0UZFLtaYsKCJbAZ9y4K
         gGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc2xTyv7WhK0w0KiqvUbbhcFT9MGY/u9f9xFlxY5zGI=;
        b=x+P9xZfYuQfFIz5LATVLN2+GQZa3Ppj1XupLYYh/6Ca2vSG6NKZyoMmTUXCxxmXk7K
         KPw26hG4MMUNB/F6of4uoK7yYWN97Xedp9LuRyLiXr2dc432lN5KvMgpgd0MEVxLVi4G
         fm8zODJCYz6KQgLIULuy3cJIDxfmzIvjduhM36cGMiLEeS5grxId7YJpBTzFyhKhHWFI
         gNe2qaiw1vZR0kp5msjpcANc6PTCRmDvp5Daa/ja72Nni9Ov4+Y3N9xZhXRAI5eSFG+F
         4kwkwQYwEyTMxHABtlUz6h/D5SUCYnUegPCepSuuZNLOaDjVnXuUUEE+DCG0EGOqffJM
         r8zA==
X-Gm-Message-State: ACrzQf0PwaCDfbWYwLwU+trpxv6vcgDb0zEGGGFSwgLzECl4+JEFM6EG
        jiPwOviLcNVkFGUd8bhidww=
X-Google-Smtp-Source: AMsMyM4Frb2INZxL9iGQKqjwpa+2YRNEk2CXt2SGi+vhM5chBR9b9eHFzWNe/ILnfoqLUmyGcUGASQ==
X-Received: by 2002:a05:651c:b2b:b0:26f:cf40:a560 with SMTP id b43-20020a05651c0b2b00b0026fcf40a560mr12324712ljr.516.1666602317769;
        Mon, 24 Oct 2022 02:05:17 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id a17-20020a05651c031100b0027628240ff7sm1723147ljp.135.2022.10.24.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 02:05:16 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:05:42 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mitja Spes <mitja@lxnav.com>, Lars-Peter Clausen <lars@metafoo.de>,
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
Message-ID: <Y1ZVZpOgq8XkeCF1@gmail.com>
References: <20221021135827.1444793-1-mitja@lxnav.com>
 <20221021135827.1444793-3-mitja@lxnav.com>
 <Y1K7hWKl0siEtaAl@gmail.com>
 <20221023121222.5fe4a743@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uqXQvfub/FN0MVU1"
Content-Disposition: inline
In-Reply-To: <20221023121222.5fe4a743@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uqXQvfub/FN0MVU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Oct 23, 2022 at 12:12:22PM +0100, Jonathan Cameron wrote:
> On Fri, 21 Oct 2022 17:32:21 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Hi Mitja,
> >=20
> > On Fri, Oct 21, 2022 at 03:58:21PM +0200, Mitja Spes wrote:
> > > Don't hardcode the ms5611 SPI speed, limit it instead.
> > >=20
> > > Signed-off-by: Mitja Spes <mitja@lxnav.com>
> > > ---
> > >  drivers/iio/pressure/ms5611_spi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure=
/ms5611_spi.c
> > > index 432e912096f4..a0a7205c9c3a 100644
> > > --- a/drivers/iio/pressure/ms5611_spi.c
> > > +++ b/drivers/iio/pressure/ms5611_spi.c
> > > @@ -91,7 +91,7 @@ static int ms5611_spi_probe(struct spi_device *spi)
> > >  	spi_set_drvdata(spi, indio_dev);
> > > =20
> > >  	spi->mode =3D SPI_MODE_0;
> > > -	spi->max_speed_hz =3D 20000000;
> > > +	spi->max_speed_hz =3D min(spi->max_speed_hz, 20000000U); =20
> >=20
> > max_speed_hz is a limit, and the max frequency the ms5611 support is
> > 20MHz.
> Hi Marcus,
>=20
> I'm not following what you are commenting on.. Perhaps give more
> detail?

Sorry for being unclear.
However, I must have thought wrong, this is good as it takes the speedlimit=
 set
in e.g. devicetree into account.


>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > Best regards,
> > Marcus Folkesson
>=20

Best regards,
Marcus Folkesson

--uqXQvfub/FN0MVU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmNWVWEACgkQiIBOb1ld
UjIUMhAAv8D5WWjvG14j7k8xAuDLVsAylOoEeaDOVDmShMKPzUU4TzNVk6beca+/
/TOo1U9fowbbTMIqxbYXr8mMiyBPaYoLP0WLn+bIfRNhhLyH9bry3X+FJshedLzM
lWAEtyAarjGhnnajUJZzu29EFe0q7pWE36Ai8e4wm24gnuQTROQgBZY9NaDOR2S2
IiL2VeiP/0fZn+8M3aMXHCeINUpQ74wA3bGwbHl2G6pMFbh1oEh39+URQVAXvUTw
3Kj6Brp+d4o+Mhy7pDnJCvRmFmARe2KMqrgKDMWb5hm6Q3APO3b5X5cOJFA5Ric3
Ldwfo/ubmJECTPcX+E1hIqruBkb4OZ0WGDS8FH6uIdxuhrpVkB0zIyiVk6XeCPKW
7fDklzTyjvh/KXf1h8EQC0eLex+xiBhKO8DsaL7XdU68P/imtwIGGQlzRxFThu7B
UHyfk93l6Ut2bQ+QuzgSQD+wBU3KG6TYIEGU9Z4NtSTu0f3OTR+mgZg3oZvvpOh4
1j5IVMMTP6lBOZ2N9mWX6gveaOG4WNVL2c9G30xGBdVzJgYDsfwjo//Yu8rPFdga
ppGxr7HpMy27e4h4uqI38rZzvqhHT+xPvCHZ0Y7dr6uz5zFd3v8inbMH0b4jmlYD
y3WJGGOuWXooVlfn1g36VeK94uRJ9Vgbs+5yamYYItIZsxR7IXk=
=SSFn
-----END PGP SIGNATURE-----

--uqXQvfub/FN0MVU1--
