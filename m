Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3923562D9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiKQLll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiKQLlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:41:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500096E541
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:40:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdGF-0004db-1A; Thu, 17 Nov 2022 12:40:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdG6-004q8e-Fp; Thu, 17 Nov 2022 12:40:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ovdG6-00HGZa-PW; Thu, 17 Nov 2022 12:40:42 +0100
Date:   Thu, 17 Nov 2022 12:40:42 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Zhi Mao <zhi.mao@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: mediatek: Add compatible for MT7986
Message-ID: <20221117114042.iafjyb6yuxp7tavr@pengutronix.de>
References: <6f28ccf3-ea27-9d5e-bd67-14f7729f713f@linaro.org>
 <e2170b37f28238c59b2f43309822b63a4d0ac9b1.1667243978.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="354maudea2s6zisl"
Content-Disposition: inline
In-Reply-To: <e2170b37f28238c59b2f43309822b63a4d0ac9b1.1667243978.git.daniel@makrotopia.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--354maudea2s6zisl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 07:23:28PM +0000, Daniel Golle wrote:
> Add new compatible string for MT7986 PWM and list compatible units for
> existing entries. Also make sure the number of pwm1-X clocks is listed
> for all supported units.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/pwm/pwm-mediatek.txt  | 20 +++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Doc=
umentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 554c96b6d0c3e0..952a338e06e7c5 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -2,14 +2,15 @@ MediaTek PWM controller
> =20
>  Required properties:
>   - compatible: should be "mediatek,<name>-pwm":
> -   - "mediatek,mt2712-pwm": found on mt2712 SoC.
> +   - "mediatek,mt2712-pwm", "mediatek,mt6795-pwm": found on mt2712 SoC.
>     - "mediatek,mt6795-pwm": found on mt6795 SoC.
> -   - "mediatek,mt7622-pwm": found on mt7622 SoC.
> -   - "mediatek,mt7623-pwm": found on mt7623 SoC.
> +   - "mediatek,mt7622-pwm", "mediatek,mt8195-pwm", "mediatek,mt8183-pwm"=
, "mediatek,mt7986-pwm": found on mt7622 SoC.
> +   - "mediatek,mt7623-pwm", "mediatek,mt7628-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> -   - "mediatek,mt8183-pwm": found on mt8183 SoC.
> -   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
> +   - "mediatek,mt8183-pwm", "mediatek,mt7986-pwm": found on mt8183 SoC.
> +   - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm", "mediatek,mt7986-pwm"=
: found on mt8195 SoC.
>     - "mediatek,mt8365-pwm": found on mt8365 SoC.
>     - "mediatek,mt8516-pwm": found on mt8516 SoC.
>   - reg: physical base address and length of the controller's registers.
> @@ -20,11 +21,14 @@ Required properties:
>                  has no clocks
>     - "top": the top clock generator
>     - "main": clock used by the PWM core
> +   - "pwm1"  : the PWM1 clock for mt7629
> +   - "pwm1-2": the two per PWM clocks for mt7986
>     - "pwm1-3": the three per PWM clocks for mt8365
> -   - "pwm1-8": the eight per PWM clocks for mt2712
> +   - "pwm1-4": the four per PWM clocks for mt7628 or mt8183
> +   - "pwm1-5": the five per PWM clocks for mt7623 or mt8516
>     - "pwm1-6": the six per PWM clocks for mt7622
> -   - "pwm1-5": the five per PWM clocks for mt7623
> -   - "pwm1"  : the PWM1 clock for mt7629
> +   - "pwm1-7": the seven per PWM clocks for mt6795
> +   - "pwm1-8": the eight per PWM clocks for mt2712
>   - pinctrl-names: Must contain a "default" entry.
>   - pinctrl-0: One property must exist for each entry in pinctrl-names.
>     See pinctrl/pinctrl-bindings.txt for details of the property values.

I have no concerns. However converting that to yaml would be a nice
thing. Also I didn't notice an effort to adapt the dts files
accordingly. But that might be because I wasn't on Cc: for these (or I
might have missed them despite the Cc: :-)

I'll mark this patch as handled-elsewhere in the PWM patchwork.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--354maudea2s6zisl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN2HbcACgkQwfwUeK3K
7AnwKAf+KLqsYzYCpZ4xcmQE2Sz176na/2EfV4aRcaOI59IzpZ+9qLx6fB/TZJkk
5EZpDBLhvfU7Z2cZSh1NaIofHryDB/4kLHraevxfBE0llrkKYp4tqjiFqc65zixf
vNx92I9KqJlV4yYfZOoMBF2rbdNkQ6GUMGARzzt/1S1Un0qbURY61vgHFXrYcPri
wlMOrg8NHAC+vDrlWm18kf9s/xHtG3q7r9BXRvfOY87sFrg7fabt1ZZZekxcZCs9
fvqxRXzFF08k6ocGxqrMKJzkHquA4YSLLRoiuYhox824yVqiMtMkwaQc2kqQUNjN
ass9UQVGR/pSxuqIRyUzl6Lu6fL+7A==
=RVOc
-----END PGP SIGNATURE-----

--354maudea2s6zisl--
