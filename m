Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736E363F192
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiLAN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiLAN1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:27:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D8FA897B;
        Thu,  1 Dec 2022 05:27:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F17996200F;
        Thu,  1 Dec 2022 13:27:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C47C433C1;
        Thu,  1 Dec 2022 13:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669901225;
        bh=NFIvcHXQ+/ERF3OpK8I1hJFW+cU//2XvbCqp4ucNeSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iObA3Dleu2jdelwAijdwi5+2YZTfvqGM59aZBZlE30aS8f8ETH931ZNCziK1j9mAn
         DBpEjNBMPqB7gQ49g1mdAGKkOajDDuNKZic92I7fNZvNixJwh9h37PubJr9tf1hzOY
         cFh71oKgj6OgiT7MC/dVaYyQRMxldK6ymjUeCoFVSZ9S4q/hduXMPl0pEOzkYNeKbF
         oP9kkvSzjX34VdUl2wuaxPHT6QKAiQQ2vRi2VWht6x50hrUs515CWL4gfWsQMj/gkp
         qclsVVs03aiOIfzKjKgpJq9JEoaOg7WLRFRHdQ5vJp5jsQ8nNGFTP+oRKBfrp4DkCn
         4Wa5/phsqCaTg==
Received: by mercury (Postfix, from userid 1000)
        id 849AB1060E96; Thu,  1 Dec 2022 14:27:02 +0100 (CET)
Date:   Thu, 1 Dec 2022 14:27:02 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix maintainer email for a few ROHM ICs
Message-ID: <20221201132702.y2tdgopcqjtbqkiw@mercury.elektranox.org>
References: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="olgbnsuo2og2janb"
Content-Disposition: inline
In-Reply-To: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--olgbnsuo2og2janb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 01, 2022 at 08:57:52AM +0200, Matti Vaittinen wrote:
> The email backend used by ROHM keeps labeling patches as spam. This can
> result to missing the patches.
>=20
> Switch my mail address from a company mail to a personal one.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
>=20
> I did this a while ago for my email addresses at the MAINTAINERS. Forgot
> the dt-bindings and doing the conversion for bindings now.
> ---

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml   | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml     | 2 +-
>  .../devicetree/bindings/power/supply/rohm,bd99954.yaml          | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71815-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71828-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71837-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71847-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml    | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yam=
l b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
> index 86a37c92b834..d48c404c848e 100644
> --- a/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
> +++ b/Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71828 Power Management Integrated Circuit LED driver
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    This module is part of the ROHM BD71828 MFD device. For more details
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> index fbface720678..7cda8adc178e 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71815 Power Management Integrated Circuit bindings
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    BD71815AGW is a single-chip power management ICs for battery-powered
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> index 8380166d176c..c13730aa34d9 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71828 Power Management Integrated Circuit bindings
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    BD71828GW is a single-chip power management IC for battery-powered por=
table
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> index 3bfdd33702ad..3ab8dcf0e8f1 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71837 Power Management Integrated Circuit bindings
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    BD71837MWV is programmable Power Management ICs for powering single-co=
re,
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml=
 b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> index 5d531051a153..8ed4390bb43f 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71847 and BD71850 Power Management Integrated Circuit bind=
ings
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    BD71847AMWV and BD71850MWV are programmable Power Management ICs for p=
owering
> diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml =
b/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
> index 6483860da955..e1ebea9ad5da 100644
> --- a/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
> +++ b/Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD9576MUF and BD9573MUF Power Management Integrated Circuit =
bindings
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    BD9576MUF and BD9573MUF are power management ICs primarily intended for
> diff --git a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.=
yaml b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
> index 24b06957b4ca..6a0756e33eb8 100644
> --- a/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD99954 Battery charger
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
>    - Markus Laine <markus.laine@fi.rohmeurope.com>
>    - Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
> =20
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regu=
lator.yaml
> index d61e8675f067..027fab3dc181 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.=
yaml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.=
yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71815 Power Management Integrated Circuit regulators
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    This module is part of the ROHM BD718215 MFD device. For more details
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71828-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regu=
lator.yaml
> index 5ce587fff961..3cbe3b76ccee 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.=
yaml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71828-regulator.=
yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71828 Power Management Integrated Circuit regulators
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    This module is part of the ROHM BD71828 MFD device. For more details
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71837-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regu=
lator.yaml
> index 1941b36cf1ef..ab842817d847 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.=
yaml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.=
yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71837 Power Management Integrated Circuit regulators
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    List of regulators provided by this controller. BD71837 regulators node
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71847-reg=
ulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regu=
lator.yaml
> index a1b806373853..65fc3d15f693 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.=
yaml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.=
yaml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD71847 and BD71850 Power Management Integrated Circuit regu=
lators
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    List of regulators provided by this controller. BD71847 regulators node
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regu=
lator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regula=
tor.yaml
> index 7cb74cc8c5d9..1e41168a4980 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.y=
aml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd9576-regulator.y=
aml
> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: ROHM BD9576 and BD9573 Power Management Integrated Circuit regula=
tors
> =20
>  maintainers:
> -  - Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +  - Matti Vaittinen <mazziesaccount@gmail.com>
> =20
>  description: |
>    This module is part of the ROHM BD9576 MFD device. For more details
>=20
> base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
> --=20
> 2.38.1
>=20
>=20
> --=20
> Matti Vaittinen, Linux device drivers
> ROHM Semiconductors, Finland SWDC
> Kiviharjunlenkki 1E
> 90220 OULU
> FINLAND
>=20
> ~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
> Simon says - in Latin please.
> ~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
> Thanks to Simon Glass for the translation =3D]=20



--olgbnsuo2og2janb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOIq5wACgkQ2O7X88g7
+pp1pg//dnrex19LVaxeoRcryBpQCbZZ4lSDJkXbbn3LcD6JZQtZymXViKEBkTi4
L5xhsh/lVYl6HdbJVuMYe7T1ToBO0pRWVS92oVqDwarsaKn3vX7vJuhi8k5THdxg
prUNv3zpaYAiS2zp5rr43ojRSS+3/FlcY2WSlyT8xaaPTD8EZjUIwbftyXCvGUpn
GlTDvidKQp06slW0ef+EYYY3sCFlI2MArrCSZYtKqwz8KhczFTVv4e9S4L/ubwLx
CM5thTdqW7poNUNVe/8D/0QI+OeCUpzabzgBjldWBajrxeIA9i2EDOODhe2Ebk1M
j1WC41T55FkjAW7QJIKPVZWT7jiY7bSKpHCpEA0+crrUhCtXq3EmNOl4exewul9z
um/ZOCdJubuL9YfzpHhBlWagWf1hUVqTZMdMOGnx21T3c0dEDrFjaxPwU+SzOmQT
TS9VxWqN6N533a6RD7k4fNVu0JQ2MHNmIuyI2jSr1xS7z9EpZ4ne2NjzEP9ScPc7
5jOnXK/hMx/10rFE/1odqyemGk+TVN74V62W1mzcUEAVzrqUHYFnlk43rda/T8Xn
GQTMABXrMZykLfac3PMssIrBJWAfMwjs0bWRhHuoaIfASXmHmBvCCcuE8XXW01iN
rXSuJIU2vNgf+YcEpqLon3n9i/ly9qYV7aLCa3oyqAv2xkVQta0=
=oRzv
-----END PGP SIGNATURE-----

--olgbnsuo2og2janb--
