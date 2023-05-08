Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59FA6FB548
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbjEHQhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjEHQhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42E56E8E;
        Mon,  8 May 2023 09:37:34 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 539FA66032C9;
        Mon,  8 May 2023 17:37:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563852;
        bh=udDMBajQiOPVdGZyg8mQ3I6M6Uy1zjD8NZ9JgkagEVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpI11uVtHUtq6e129Ry21XqOUdkwH+VfEBkkO1IDaIjlDshx2iaaRPrS0AsYReOrx
         DztirCNlLJa6b0Fo2rVH+70sNgYXyjWpqR/CDS6lM4Qfz9/pJud+hX7RgYD7JPpyLs
         vC3RUHa2O7WOtqzdZv2xqn/javd160IiA4pTW589wPSAIba3APsiSflEcou1QUOMck
         4hZ3KD3QN9WbKAuqppz8xWfzs16W1ZCFGaNqK1vCwKbJJUswK46A4/5lCKabE0gbYo
         qNel3EsRIH6nek2mKOu7Tt8jTKMu/4CAhwVySWpoTak9cuBjtkL//ir5BRaV5xNCLO
         QFS9qgy7PQbXA==
Received: by mercury (Postfix, from userid 1000)
        id 3827E1067084; Mon,  8 May 2023 15:34:13 +0200 (CEST)
Date:   Mon, 8 May 2023 15:34:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] power: supply: hwmon: constify pointers to
 hwmon_channel_info
Message-ID: <20230508133413.ojt4hjxbxofixxh7@mercury.elektranox.org>
References: <20230407150326.80183-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dguijg5cxkkxb3fj"
Content-Disposition: inline
In-Reply-To: <20230407150326.80183-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dguijg5cxkkxb3fj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 07, 2023 at 05:03:26PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@=
linaro.org/
>=20
> Therefore I propose this should also go via hwmon tree.
>=20
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---

Thanks, queued (to my for-next branch).

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index a48aa4afb828..c97893d4c25e 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -293,7 +293,7 @@ static const struct hwmon_ops power_supply_hwmon_ops =
=3D {
>  	.read_string	=3D power_supply_hwmon_read_string,
>  };
> =20
> -static const struct hwmon_channel_info *power_supply_hwmon_info[] =3D {
> +static const struct hwmon_channel_info * const power_supply_hwmon_info[]=
 =3D {
>  	HWMON_CHANNEL_INFO(temp,
>  			   HWMON_T_LABEL     |
>  			   HWMON_T_INPUT     |
> --=20
> 2.34.1
>=20

--dguijg5cxkkxb3fj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY+lQACgkQ2O7X88g7
+prO+Q//QSMdR1Hjn+1cUVSJn9lLDExWtvOYSWrSiECUCpLfCIZCr+QeClYYUYcN
xLtZc9441/a54EYbGt6EjkJh+WqZbmnl5SI8PUUfIb465oLCqwAh3ZkreSzIhWjs
H6C6HLKKCI+kWTL1zAQC6RENWAU8X0nZrFaZT/yuGexfOyHBtakTk/Ki1lkANP90
8/jPrSPtvhwS53VzAiVloRLX/GsJsaIc8pywv6UUygJDcOR7Xy+U4AXp4Y0ZLgqg
ITTYFpi+qbG1fxdOJ2HSHx0ozEa1kERCz7diAJOixlpzGkxq0qg+Kf1StpqFcKvQ
qwNUkGuheCMw+/ehTM+wIZXy2wGRuQzqZ8asuu8UwHGlFOWo+lCxvBWyTNAOSnQy
nJVXs3DWyTp+rVqk5rSQ7s0D7Urnca1RcbVtE8yfkr9OT+HuHeqcrIwygeVsigbD
iBDKd98yVfEs9k/DvJHVdmiowJVJPJ//vVEOkTMR528UBDWJxIA9YOIVoWtb/M38
LeGFOptAH6hDKHSezFz4HfKEE+KoZ/nnitIbYTND97OZU1Kf+AuFp8j1PErW1AkX
sf1XvYAdUJ91DicxsVuNdIuGcd6SRQPxzm/tmS5Z12IT3icfX2cGBuWUjYW+yyJP
ng/tRI1EJEWMjDuFFL3LYLwZS505c05Lwv66CDRRS0cJhPFP4GY=
=fKk0
-----END PGP SIGNATURE-----

--dguijg5cxkkxb3fj--
