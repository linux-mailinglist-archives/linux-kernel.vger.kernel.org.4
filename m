Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5470208E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjENWrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:47:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875E710FF;
        Sun, 14 May 2023 15:47:39 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D7B4660574D;
        Sun, 14 May 2023 23:47:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684104458;
        bh=m7FaWHC0hcEZ+opoVXS6xLiU5AcgWk6c8qi7kt4a7f4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AMNy42BMf16qchg5vkGDSoBcfNmj+52iI/k6VlbbwocZPlbYU5ahcu3kloZZMfngv
         d+Lp7wZVRl551b5bcB+ez69FIj76ibqTuNK7LRJOS6RAb39+LnFLhwr4TVUi09O/PU
         vXSCOZcfkDDyop5GU+UUpz/AtsCna0BmqiYJjwBkSHp0/Cx9wvyMXg53vyUZDkQ7bU
         iipqopFvPbWB+hBldMB4kCR3A5u5zMV9RUpRLjmyqnyc1hHVavtAu3MFf2kQIP9stz
         whQ8EFQb4MaOrjgTMQ0wbDUCJcQzMfDPDTcMnggob5KLcLtnNXTkpUpeLU35ljfk83
         0KoPVy0D8o00A==
Received: by mercury (Postfix, from userid 1000)
        id 0D5281061381; Mon, 15 May 2023 00:47:36 +0200 (CEST)
Date:   Mon, 15 May 2023 00:47:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v5 07/10] power: supply: rt5033_battery: Move struct
 rt5033_battery to battery driver
Message-ID: <20230514224736.guld3npymqbr3no4@mercury.elektranox.org>
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-8-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w66avb2qq2hrapvz"
Content-Disposition: inline
In-Reply-To: <20230514123130.41172-8-jahau@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w66avb2qq2hrapvz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 14, 2023 at 02:31:27PM +0200, Jakob Hauser wrote:
> Move struct rt5033_battery from the mfd header into the battery driver be=
cause
> it's not used by others.
>=20
> Within struct rt5033_battery, remove the line "struct rt5033_dev *rt5033;"
> because it doesn't get used.
>=20
> In rt5033.h, remove #include <linux/power_supply.h>, it's not necessary
> anymore.
>=20
> In rt5033_battery.c, remove #include <linux/mfd/rt5033.h>, it's not neces=
sary
> anymore either. Instead add #include <linux/regmap.h> and
>=20
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/rt5033_battery.c | 9 ++++++++-
>  include/linux/mfd/rt5033.h            | 8 --------
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply=
/rt5033_battery.c
> index 5c04cf305219..91e1efd81f69 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -6,11 +6,18 @@
>   * Author: Beomho Seo <beomho.seo@samsung.com>
>   */
> =20
> +#include <linux/i2c.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/power_supply.h>
> +#include <linux/regmap.h>
>  #include <linux/mfd/rt5033-private.h>
> -#include <linux/mfd/rt5033.h>
> +
> +struct rt5033_battery {
> +	struct i2c_client	*client;
> +	struct regmap		*regmap;
> +	struct power_supply	*psy;
> +};
> =20
>  static int rt5033_battery_get_capacity(struct i2c_client *client)
>  {
> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
> index 3992fb2ef0a8..bb3d18945d21 100644
> --- a/include/linux/mfd/rt5033.h
> +++ b/include/linux/mfd/rt5033.h
> @@ -12,7 +12,6 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/regmap.h>
> -#include <linux/power_supply.h>
> =20
>  /* RT5033 regulator IDs */
>  enum rt5033_regulators {
> @@ -32,11 +31,4 @@ struct rt5033_dev {
>  	bool wakeup;
>  };
> =20
> -struct rt5033_battery {
> -	struct i2c_client	*client;
> -	struct rt5033_dev	*rt5033;
> -	struct regmap		*regmap;
> -	struct power_supply	*psy;
> -};
> -
>  #endif /* __RT5033_H__ */
> --=20
> 2.39.2
>=20

--w66avb2qq2hrapvz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRhZQcACgkQ2O7X88g7
+prJyA/+O1YQSYfVIfUyrW708AKFet4/dTSpu9Y9VZEuKZxWzYVOsvajBQi1vybJ
+9lJ2FABRwTzwLOpR6tbEsXPBodDSP9WrrAquB35woUlPIMl/UQKsxDmRU4jYdci
yVneUpa80i+sLBfmIB5zCxIjj9l93xN+JQ174PYfF7OJ7p1fhuKXducqkHgHM3aZ
Ub33OJy3ArKahI8PQCA04uFoMjMGN8tML4ZPHXB7wfbvGEDfWbicMzb02TWu7D2Q
uTEDxZgYjQnqeMOeD42J6dDQuVohrHCN9QS+U70glXMSLOS+HYSx99d/0PKhLojD
ja0QZ4xA9lWxP9KE//kQNxlf34a2W7oawrIjWgoKXK3WXJ9D6vW4pTBdwjdRDQvV
ZSktIUvvaft4zc9aZ4j5DMKI8lsjk2YI7nuGIS+/Y2Q368YQn+mW/akPHscVp6qK
7luonWrLqwH6nus3Ly3WPx9kUFZe0XylrQryJIfvxfi4zhsYr21izOIKhjEc7Xdv
g3zNzYI8tR4MKFhlPMvCBk9JiP8yB+wZUCuHeQBeWWAt/zZuiGJMmiQL0pyonL/V
0+b+ba8db4DvaaM2DFfksC8/zBhzL4siHfX6NVBi5SUbtz8bcbnFAjUHf6xDdjAN
zEHjM5iCnV/neMRoOrsSnMAht+y4DjAxbQ5Yt4ryPeYSrJ6h3/M=
=onLL
-----END PGP SIGNATURE-----

--w66avb2qq2hrapvz--
