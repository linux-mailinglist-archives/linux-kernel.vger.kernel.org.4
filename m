Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B47A703FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245574AbjEOVaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245364AbjEOVaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 17:30:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66985DF;
        Mon, 15 May 2023 14:30:06 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7144C660309E;
        Mon, 15 May 2023 22:30:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684186204;
        bh=XnJ4sqo3d5oaZE49X9V5WhoyHBQJJLbPHuc9JmRD5qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxDGiz9Wrj4036bECCbghqaURyxUJIuyn2dOAcznOXLmNgizE1ZMsle7WwUjb3Qbr
         96p+jTbM9hJQunjX5gk55XSnuDu49EnJZYcDzzXtF826pA94YNC5kX4Rk3oT82C/bN
         sLG+Z12guASy1E1BNSy4F9GFtDhiZmSEnm2XA8G79ggJER2i274V5WZw2HliS96HfC
         aY+k4CRCnl7YVdf+c4dkuC7MOnAX64T/KKUvJtoq34pdPvKodA/el7tVqHEEszj5Um
         67b/OVXR7/dVFxBrSFEl87Pk+wWFccLUGbEapIYKAOHOudMOzu3EyT1CBZe3b1o+PN
         et6+TPJDqAGkw==
Received: by mercury (Postfix, from userid 1000)
        id E46251060F7F; Mon, 15 May 2023 23:30:01 +0200 (CEST)
Date:   Mon, 15 May 2023 23:30:01 +0200
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
        Henrik Grimler <henrik@grimler.se>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 09/10 RESEND] dt-bindings: power: supply:
 rt5033-battery: Apply unevaluatedProperties
Message-ID: <20230515213001.w53uxn4odpdpxyvd@mercury.elektranox.org>
References: <cover.1684182964.git.jahau@rocketmail.com>
 <ef86067348f01a3bbf1bd9b4f81716b62ea1f552.1684182964.git.jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vm4elznq6pnounmx"
Content-Disposition: inline
In-Reply-To: <ef86067348f01a3bbf1bd9b4f81716b62ea1f552.1684182964.git.jahau@rocketmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vm4elznq6pnounmx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 15, 2023 at 10:57:18PM +0200, Jakob Hauser wrote:
> Additionally to the already available ref "power-supply.yaml", replace
> "additionalProperties: false" by "unevaluatedProperties: false". Otherwis=
e,
> when referencing rt5033-battery in an example, message "'power-supplies' =
does
> not match any of the regexes: 'pinctrl-[0-9]+'" will be returned.
>=20
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

> ---
>  .../bindings/power/supply/richtek,rt5033-battery.yaml           | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt503=
3-battery.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt5=
033-battery.yaml
> index 756c16d1727d..b5d8888d03d2 100644
> --- a/Documentation/devicetree/bindings/power/supply/richtek,rt5033-batte=
ry.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt5033-batte=
ry.yaml
> @@ -26,7 +26,7 @@ required:
>    - compatible
>    - reg
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.39.2
>=20

--vm4elznq6pnounmx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRipFkACgkQ2O7X88g7
+pqJDw//UHkBP+bjlwRennvVaDpAW2HhaT3y550VH4QfTPp3wjguIoFGbYAmMPiZ
uRKv2ahId+jwXWO6ZJGmxV0pTPiNXNHn4U/KrEr6m4r5ropRmXzUrYAKlGhZhUE1
YxUfSNMW4zjMRuCgIYmEGOLmHfiNbiE+HCbE+SMj3pUNdA7D3PYk0Yq8/ofKoAH/
yPvDnCIl4o0+TZGDVsZw1F+A6xrSOJOfA9UHQIYMcvurmtTMni2MtrX0ye98n3qx
J7E9tSQvxmWL9ECZHHQo+NZZ/8mX8O/vnxNTEihFSYtry4rGaOJjSkugeCG3Hpx5
T8w6mR8lYD6cGsvBknPpdpi9twAkHN1tmKsPxRJ49auaoO2J/J9DqXKvIbJu0O+f
XAmogweJxkseixyj2XAwsUlAkCO9pICQAf2+29ibyl9WwvMJeEt1qAgk1v06MRX7
7MtcghUJ0wToY9Ayv246/Vsymqa8+I9hup9cwypX1H6+3h7XSJwvxPwS0Ha81hcY
LLItHitanvU3TyjIhDcNt86QYroYfBI4okpj6e0X3u+aX/mDWayGeodGKQM1hSTN
/Uiv/1afkfCWTSGu21+icFy/aZUq+IzUoP8u/WIHO7+9NHWUj4tO4PZ+bqB0Of6Y
biFyWnLra8xrIV24i+VPMlHUL85Sr2gnGCwjM1pZzILfB9MQiRw=
=gsx8
-----END PGP SIGNATURE-----

--vm4elznq6pnounmx--
