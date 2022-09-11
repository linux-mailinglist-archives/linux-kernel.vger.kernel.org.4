Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE1A5B5860
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiILK3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiILK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:28:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EB537181;
        Mon, 12 Sep 2022 03:28:39 -0700 (PDT)
Received: from mercury (unknown [185.122.133.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA9956601FE7;
        Mon, 12 Sep 2022 11:28:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978518;
        bh=sB+KgqZBMTpSJAOGyKS/B+RMCSEw/yF4dzXEpEYM6Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lZl3WPS0y3lhw7JNnEzM3yC9un8yRsA8BNqOyc00iOdaIdtWJDrJqI4a3ikyQtIli
         pJul80D+6cdC6KRuia6R4P1WIfAyt7EhJz6n1lG9rmGY53Xp1bXWP+4so6yawI65qg
         2grb7NBI5oOu4cVH2hqh1S9nuLqp4hrfMqHa9etAexqeRiFSE8niJCGuILtZFSZaff
         ryp5mfEbh4Ss38u5WliQugyNIsOzmMoxqWfkgkJF507gRQ5ch9PaOlDPUli1jik0CJ
         zUly1Q4+zuJ8WHVvg3Z38cxPMuwI+aaGSuGULTo9a8pK+BYrdUJRWOTFfl/uCSOENJ
         l8/vMMFCQWChA==
Received: by mercury (Postfix, from userid 1000)
        id 903171063362; Sun, 11 Sep 2022 15:05:30 +0200 (CEST)
Date:   Sun, 11 Sep 2022 15:05:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Ben Dooks <ben-linux@fluff.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq27xxx: fix NULL vs 0 warnings
Message-ID: <20220911130530.l7thynmpso6amn4e@mercury.elektranox.org>
References: <20220721210120.449340-1-ben-linux@fluff.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cuom7xjehcjca6ul"
Content-Disposition: inline
In-Reply-To: <20220721210120.449340-1-ben-linux@fluff.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cuom7xjehcjca6ul
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 21, 2022 at 10:01:20PM +0100, Ben Dooks wrote:
> The driver has a lot of sparse warnings for using 0 as a NULL
> pointer when NULL would be appropriate. Change the 0 values
> to NULL to fix the warnings, some of which are shown here:
>=20
> drivers/power/supply/bq27xxx_battery.c:984:23: warning: Using plain integ=
er as NULL pointer
> drivers/power/supply/bq27xxx_battery.c:985:23: warning: Using plain integ=
er as NULL pointer
> drivers/power/supply/bq27xxx_battery.c:986:23: warning: Using plain integ=
er as NULL pointer
> drivers/power/supply/bq27xxx_battery.c:987:23: warning: Using plain integ=
er as NULL pointer
> drivers/power/supply/bq27xxx_battery.c:988:23: warning: Using plain integ=
er as NULL pointer
>=20
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/bq27xxx_battery.c | 54 +++++++++++++-------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 35e6a394c0df..dccc2683455a 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -868,11 +868,11 @@ enum bq27xxx_dm_reg_id {
>  	BQ27XXX_DM_TERMINATE_VOLTAGE,
>  };
> =20
> -#define bq27000_dm_regs 0
> -#define bq27010_dm_regs 0
> -#define bq2750x_dm_regs 0
> -#define bq2751x_dm_regs 0
> -#define bq2752x_dm_regs 0
> +#define bq27000_dm_regs NULL
> +#define bq27010_dm_regs NULL
> +#define bq2750x_dm_regs NULL
> +#define bq2751x_dm_regs NULL
> +#define bq2752x_dm_regs NULL
> =20
>  #if 0 /* not yet tested */
>  static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
> @@ -881,24 +881,24 @@ static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 48, 2, 1000, 32767 },
>  };
>  #else
> -#define bq27500_dm_regs 0
> +#define bq27500_dm_regs NULL
>  #endif
> =20
>  /* todo create data memory definitions from datasheets and test on chips=
 */
> -#define bq27510g1_dm_regs 0
> -#define bq27510g2_dm_regs 0
> -#define bq27510g3_dm_regs 0
> -#define bq27520g1_dm_regs 0
> -#define bq27520g2_dm_regs 0
> -#define bq27520g3_dm_regs 0
> -#define bq27520g4_dm_regs 0
> -#define bq27521_dm_regs 0
> -#define bq27530_dm_regs 0
> -#define bq27531_dm_regs 0
> -#define bq27541_dm_regs 0
> -#define bq27542_dm_regs 0
> -#define bq27546_dm_regs 0
> -#define bq27742_dm_regs 0
> +#define bq27510g1_dm_regs NULL
> +#define bq27510g2_dm_regs NULL
> +#define bq27510g3_dm_regs NULL
> +#define bq27520g1_dm_regs NULL
> +#define bq27520g2_dm_regs NULL
> +#define bq27520g3_dm_regs NULL
> +#define bq27520g4_dm_regs NULL
> +#define bq27521_dm_regs NULL
> +#define bq27530_dm_regs NULL
> +#define bq27531_dm_regs NULL
> +#define bq27541_dm_regs NULL
> +#define bq27542_dm_regs NULL
> +#define bq27546_dm_regs NULL
> +#define bq27742_dm_regs NULL
> =20
>  #if 0 /* not yet tested */
>  static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
> @@ -907,7 +907,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 67, 2, 2800,  3700 },
>  };
>  #else
> -#define bq27545_dm_regs 0
> +#define bq27545_dm_regs NULL
>  #endif
> =20
>  static struct bq27xxx_dm_reg bq27411_dm_regs[] =3D {
> @@ -937,7 +937,7 @@ static struct bq27xxx_dm_reg bq27426_dm_regs[] =3D {
>  #if 0 /* not yet tested */
>  #define bq27441_dm_regs bq27421_dm_regs
>  #else
> -#define bq27441_dm_regs 0
> +#define bq27441_dm_regs NULL
>  #endif
> =20
>  #if 0 /* not yet tested */
> @@ -947,13 +947,13 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] =3D {
>  	[BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 82, 9, 2, 2500,  3700 },
>  };
>  #else
> -#define bq27621_dm_regs 0
> +#define bq27621_dm_regs NULL
>  #endif
> =20
> -#define bq27z561_dm_regs 0
> -#define bq28z610_dm_regs 0
> -#define bq34z100_dm_regs 0
> -#define bq78z100_dm_regs 0
> +#define bq27z561_dm_regs NULL
> +#define bq28z610_dm_regs NULL
> +#define bq34z100_dm_regs NULL
> +#define bq78z100_dm_regs NULL
> =20
>  #define BQ27XXX_O_ZERO		BIT(0)
>  #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
> --=20
> 2.35.1
>=20

--cuom7xjehcjca6ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmMd3RkACgkQ2O7X88g7
+prvGA/+I9d48BFPKAOHGfx1VJdTf3+vBdnOSsKaocmf3bkxLDgfQejLiJYtQOae
angVxOVfO/4ps+kFs/TJX2RoEZPBESueob4DjV6O/58PewlVA4vE9M+dOQNMlczx
6LdFCSmd+GjExb53o9uz1wafQZKzV9+5gWfT4Bnl5KuhI8bsVbIXCm8heryE4YA3
TohAI8H73VEzjHxL/mnpb+YBLOK06EeiBBmgG/0y2DGRrpboQUMZmas2vsOVRPHc
G2jVr01XcdKo293xc0M8viNZG+y1aYHYLyi+H3/zk41DA/J+IWcad9VI150Xcsrl
kioYpt6KGAF6lJj2CZ0IyFsO/3Q9wUf+sEK5wwY3V9+YnCSeFtpeacZRj/4aiZNs
RJ0s3+78rLyhYhD8Wxm5U6VHc8lE2Q6p9irZ4owzpFNjR+Yre6HuLhzbAJ8rSYND
WiU+mgjdvTYjepnrvXqXfZqIj47wzfixlH1squQW53gYSPnPAcUw+LPJ+bp4KoGe
9bPVKGFDzGfiCirQjcz8vRkBzmYEyyY2rkNSe1953ytR8u58hhx9pQmOly7ZMNP5
z9dUNP4ISg40/GGV1GTcnsjlZPKaG3PruXCqq1G3rtr8XT17Y/eGjtFoJKZiZzoS
7bB6pTC0FCtJbkVcMNmjKE49BO7wKRfqR80+IhmJcf8jgSag5Aw=
=cn+N
-----END PGP SIGNATURE-----

--cuom7xjehcjca6ul--
