Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF56B725600
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbjFGHkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjFGHj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:39:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB12123
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 00:37:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6niy-0003Fq-Gk; Wed, 07 Jun 2023 09:36:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6niv-005gu6-Dy; Wed, 07 Jun 2023 09:36:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6niu-00BwY7-5i; Wed, 07 Jun 2023 09:36:52 +0200
Date:   Wed, 7 Jun 2023 09:36:52 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-watchdog@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 2/7] dt-bindings: pwm: restrict node name suffixes
Message-ID: <20230607073652.hoyrernfcuoryrqs@pengutronix.de>
References: <20230530144851.92059-1-krzysztof.kozlowski@linaro.org>
 <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="53ce3yyaolwya5ci"
Content-Disposition: inline
In-Reply-To: <20230530144851.92059-3-krzysztof.kozlowski@linaro.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--53ce3yyaolwya5ci
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 04:48:46PM +0200, Krzysztof Kozlowski wrote:
> Make the pattern matching node names a bit stricter to improve DTS
> consistency.  The pattern is restricted to:
> 1. Only one unit address or one -N suffix,
> 2. -N suffixes to decimal numbers.
>=20
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

>=20
> ---
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/pwm/pwm.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm.yaml b/Documentati=
on/devicetree/bindings/pwm/pwm.yaml
> index 3c01f85029e5..abd9fa873354 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm.yaml
> @@ -13,7 +13,7 @@ select: false
> =20
>  properties:
>    $nodename:
> -    pattern: "^pwm(@.*|-[0-9a-f])*$"
> +    pattern: "^pwm(@.*|-([0-9]|[1-9][0-9]+))?$"

With this patch we forbid now the following patterns:

	pwm-[0-9a-f][@-].*
	pwm-0[0-9a-f]+
	pwm-[a-f]([@-].*)?

Checking for such names:

	$ git grep -oP '\bpwm-([0-9a-f][@-].*|0[0-9a-f]+|[0-9]*[a-f][0-9a-f]*)(*pl=
a:\s*\{)' arch/*/boot/dts
	arch/arm/boot/dts/meson8.dtsi:pwm-f-ao
	arch/arm/boot/dts/meson8.dtsi:pwm-e
	arch/arm/boot/dts/meson8b.dtsi:pwm-d
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x7
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-b-x19
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-c
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x5
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-c-x8
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x3
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-d-x6
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-e
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-z
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-a
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-x
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-f-h
	arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi:pwm-a-e

These are all pinmux-settings and no pwm nodes, so the change is fine.
(But arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi isn't properly
sorted alphabetically.)

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--53ce3yyaolwya5ci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSAM5MACgkQj4D7WH0S
/k7r5ggApZ2+XCI0I3PKhfnhGNckF4ZiCto9+JLH90d1BNst1xY7hWlJ167vUCbC
mTgPD2HQHlKyPJoKmhRbTRF2ZYtdxN7fkJSqpz5RIhZwpuQjmaC7sfWcLSun07v+
1XzaZA4WQTsuvIw7mKZD0juHmlOK+kNRYLKyIgnN10uB8CGGHzv2zbG+WUJHxOhG
vNVwYz4TD1ScNmj9YJm+isi2OOrmsoXW6XeAQO1wxqP6iMUr6fjKcI7dxvirIXm4
diVZ7dr/5OY+vG0Y9bZKpp43GswLtmqCowdrBtxHr5EYhjR5BUfWMPvwCj4s2JK0
ta30Rl7GObRgiuLVYr2pbDMZPuVqOw==
=fGeW
-----END PGP SIGNATURE-----

--53ce3yyaolwya5ci--
