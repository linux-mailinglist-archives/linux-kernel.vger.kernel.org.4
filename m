Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03D4645F88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 18:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiLGRAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 12:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiLGQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:59:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B736933D;
        Wed,  7 Dec 2022 08:59:36 -0800 (PST)
Received: from mercury (dyndsl-091-096-059-166.ewe-ip-backbone.de [91.96.59.166])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6F4976602BC8;
        Wed,  7 Dec 2022 16:59:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670432374;
        bh=bEvlL0mnv13cihi3HCIkl9DCfnP1k298XjhbL7LAufA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVlDFCTzOHXdtF44MPRDBp745dkSoal+m9XlgbrVk0eVveZ4SV+Bv1Rnj0ZBG6Rt3
         iZzkYM/8F/qgm/5INpH4ZuEVZdheQuxkmKnjbF4NYwKekrccgWZ80uTQ5fVMnlVnEK
         7sz8TmoCZwYK3OEI28mJ6n6F3xGALBFdeq22ossum96yZrYwJqiWDu1PsWPLAsHI7x
         hRrGzEFqetXXh+ZUi+bUOEraSs2OtVyf9i/MzyAzh8Cjc9+JImlrgZ8QqwdNdYumLv
         0XdveLAuHK+do5iCZu9zBRZS6X/efajXc1hQZdTXVcNAcNiE0Vb1uyxHCLrTy7hmA0
         6hG/oUhpNGlZw==
Received: by mercury (Postfix, from userid 1000)
        id 119591060F43; Wed,  7 Dec 2022 17:59:32 +0100 (CET)
Date:   Wed, 7 Dec 2022 17:59:32 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        Daniel Mack <zonque@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing 'unevaluatedProperties' to
 regulator nodes
Message-ID: <20221207165932.hmgj4giz5ivei46i@mercury.elektranox.org>
References: <20221206211554.92005-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tn5la4fl5slxzyzl"
Content-Disposition: inline
In-Reply-To: <20221206211554.92005-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tn5la4fl5slxzyzl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 06, 2022 at 03:15:55PM -0600, Rob Herring wrote:
> Several regulator schemas are missing 'unevaluatedProperties' constraint
> which means any extra properties are allowed. Upon adding the
> constraint, there's numerous warnings from using the deprecated
> 'regulator-compatible' property. Remove the usage as examples shouldn't
> be using long since deprecated properties.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'd suggest that Mark take this if that's okay with Lee. Or I can take=20
> it.
>=20
>  Documentation/devicetree/bindings/mfd/max77650.yaml  |  2 --
>  .../devicetree/bindings/mfd/mediatek,mt6360.yaml     |  9 ---------
>  .../bindings/power/supply/mt6360_charger.yaml        |  2 +-
>  .../bindings/regulator/max77650-regulator.yaml       |  1 +
>  .../devicetree/bindings/regulator/max8660.yaml       |  6 +-----
>  .../bindings/regulator/mt6360-regulator.yaml         | 12 +++---------
>  6 files changed, 6 insertions(+), 26 deletions(-)
>=20
> [...]
>
> diff --git a/Documentation/devicetree/bindings/power/supply/mt6360_charge=
r.yaml b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> index b89b15a5bfa4..4c74cc78729e 100644
> --- a/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/mt6360_charger.yaml
> @@ -26,6 +26,7 @@ properties:
>      type: object
>      description: OTG boost regulator.
>      $ref: /schemas/regulator/regulator.yaml#
> +    unevaluatedProperties: false
> =20
>  required:
>    - compatible
> @@ -39,7 +40,6 @@ examples:
>        richtek,vinovp-microvolt =3D <14500000>;
> =20
>        otg_vbus_regulator: usb-otg-vbus-regulator {
> -        regulator-compatible =3D "usb-otg-vbus";
>          regulator-name =3D "usb-otg-vbus";
>          regulator-min-microvolt =3D <4425000>;
>          regulator-max-microvolt =3D <5825000>;

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

> [...]

-- Sebastian

--tn5la4fl5slxzyzl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOQxmgACgkQ2O7X88g7
+pqenQ/9Ho8lsTUBjGsxEgwS8RpLC8U1AP8yglgqBuUrbdcwAuL3g0yWJMB4Cm4a
trhgJgCBr2fd4LLFbJzQH/tVrcUZtFJ957ZmvKr0E1xcVkiDgR8ujhhCCCOgB5vG
IpjFq+8lXplomNmb3hOlRKkuC+2YWYM1cXvEQyFyPOYZAThebqOpYQcETx5rxegs
VTdhV4cB6b+jG2fsR+3BVw+rJ9U3oxjbY5XuwUJ2GyA15InCnBOh0945mc6vLDvN
vNCwgsgvS8D7emYsLt666/gI3LKRLH6H+3p8Vu2yYAU58mu21gg7L6z6jswSlm+V
MsMVDTiwzLYq/EaYQbGaTazJjigroldPnUf268xI6OgG7tSqowA0PuYaT+GkKfrY
0dPGbQf1K6NbCQ4V+Fh1BO1h0kOtX6FCjkLJ0d1ZZTC7DwIMe1tLgXZux0mETsQo
aCli/01Y+oVc6vulRN9HRGvthS01OoByy5vdikomiO6cJH3l8Jwb7gNz07kVrJyF
aDzTDqorec2e7bMleqRGwncCINLYqw0z/Mh0ZLKPgbs/L2YXOI7nhGVaCj5p4wNb
44Nky3qwmg0iu12vbmydFMWjRIICBnOU3xCqfe7tDfi4jDCJqKkHcHU15JR2bPPC
LYL6vJb5f66lQGyI+SWJoXT+q5bps6L/KhDMea6xKmWTjss81gM=
=VLUI
-----END PGP SIGNATURE-----

--tn5la4fl5slxzyzl--
