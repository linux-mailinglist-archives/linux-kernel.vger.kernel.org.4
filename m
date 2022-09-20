Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39575BEAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 18:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiITQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 12:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiITQMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 12:12:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106FC6BD67;
        Tue, 20 Sep 2022 09:12:22 -0700 (PDT)
Received: from mercury (dyndsl-091-096-056-222.ewe-ip-backbone.de [91.96.56.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD73E660036C;
        Tue, 20 Sep 2022 17:12:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663690340;
        bh=4pnxuSa/+SQckgAxGLcLTdbVCsMAQVJqmr/cvX1u6IQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1/nry5hg+gMrp6neyk2AW6Za37ZK5LktEaeIhQQoly6pT0Q/uYxhr1qgyuUnQkt/
         uYWe65/RJPiAN3FYfjn9a6f+CEHqAJRmJClV+1ZkVC1J6RZQhF4CVpbGMm1bTmyQD2
         VyCdvQzV97qDUEIPJnqwUyy136UVNcCMfnWNhi2zTInsF1A3N9FSho9KDJ8TggT2Zn
         rxSkWgx6Jop7gewvED1Aerhkdb0WAW1+3M9vzm2JzrrNLwlAdxRuvhUI+6rA6NutZb
         sdqw2eay3nF07QttAyszuU7MYl47I13kbnj5qh2h/P1j/gxzlOgpqjmqAqBAVG/faJ
         VXhXH57/sRYng==
Received: by mercury (Postfix, from userid 1000)
        id 9037D10607CF; Tue, 20 Sep 2022 18:12:18 +0200 (CEST)
Date:   Tue, 20 Sep 2022 18:12:18 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <peterwu.pub@gmail.com>, broonie@kernel.org,
        mazziesaccount@gmail.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        jic23@kernel.org, lars@metafoo.de,
        andriy.shevchenko@linux.intel.com, chiaen_wu@richtek.com,
        alice_chen@richtek.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v11 4/8] lib: add linear range index macro
Message-ID: <20220920161218.dkkfvfomrruebahi@mercury.elektranox.org>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
 <0418eade65d434a25d304eaa804b34f92318be87.1663254344.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5tnc2jgsehdwtia"
Content-Disposition: inline
In-Reply-To: <0418eade65d434a25d304eaa804b34f92318be87.1663254344.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l5tnc2jgsehdwtia
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 15, 2022 at 05:47:32PM +0800, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>=20
> Add linear_range_idx macro for declaring the linear_range struct simply.
>=20
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---

Thanks, queued via immutable branch:

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/psy-linear-range-for-v6.1-signed

for you to fetch changes up to c2f2e2c3aecdbabf822272a4b6e7d91537633cd9:

  lib: add linear range index macro (2022-09-16 22:27:19 +0200)

----------------------------------------------------------------
Immutable branch for linear range and power-supply for v6.1

Immutable branch between linear range and power-supply for driver
changes in MT6370.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
ChiaEn Wu (1):
      lib: add linear range index macro

 include/linux/linear_range.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

-- Sebastian

>  include/linux/linear_range.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/include/linux/linear_range.h b/include/linux/linear_range.h
> index fd3d0b3..2e4f4c3 100644
> --- a/include/linux/linear_range.h
> +++ b/include/linux/linear_range.h
> @@ -26,6 +26,17 @@ struct linear_range {
>  	unsigned int step;
>  };
> =20
> +#define LINEAR_RANGE(_min, _min_sel, _max_sel, _step)		\
> +	{							\
> +		.min =3D _min,					\
> +		.min_sel =3D _min_sel,				\
> +		.max_sel =3D _max_sel,				\
> +		.step =3D _step,					\
> +	}
> +
> +#define LINEAR_RANGE_IDX(_idx, _min, _min_sel, _max_sel, _step)	\
> +	[_idx] =3D LINEAR_RANGE(_min, _min_sel, _max_sel, _step)
> +
>  unsigned int linear_range_values_in_range(const struct linear_range *r);
>  unsigned int linear_range_values_in_range_array(const struct linear_rang=
e *r,
>  						int ranges);
> --=20
> 2.7.4
>=20

--l5tnc2jgsehdwtia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMp5mIACgkQ2O7X88g7
+poHHQ/9HvToYVOdeiCOww5XunH69+2ib0YVQCxyUaHB5DouNsW21uhKmKI8C3SM
znd+W+uaniZH4HWy1VOTPNYb+bFalIFf6ED4cI1ppBn4l2iUlAYbWzIBc7pk5z7C
HdUtqzHPkq5jKuosU38jg/1TBlwnXApBwEuWVRBIwtLKm0y80XBBPUQycr+yqlww
l02ngiAIu7bxPM37iYWorHFE3UzhoW250pzaMDANsIwz/A+T8PrGa+Br4r5R13G+
u+ZUtbzTjmx8HkLFV++DQ3lfJRPWgWtQms+nrSr3V6YNh9KpOl35x6TXaLLyUICa
JStHqjnzrxDWg9vkKHO8FBh2SA8ERt6m0hsLNnGZofbZqot8VqQXz8jPlPFjLw++
ihupgvK2DCSg7ZesmrG4aE2Bt883pue0OVVK5vj+Kvb1QXlwe1QvovMK9jyEe4pd
eS+ItZvrJsBKCRGYXmLO06ZiF7VPIlsm+5atVK1oU4qzmf0i+Q44NH8AneNLsTYO
pdurTGwKmdwaUqLyxOZnYB2FqUlE98aFLvv1AIl8U/jB8Gg6iwPf8OVEP/Ot7BRW
UJzia8CQTINKArz+E9FJm6mkj7GQAmoszMa19j3Bdj+qpSyN9Anjjhoohtz724Ix
c9Gjx2otNjq67/kq0nXvg+X5hi3PiCVDr0q6o8TdaVbseaZP/lk=
=StQZ
-----END PGP SIGNATURE-----

--l5tnc2jgsehdwtia--
