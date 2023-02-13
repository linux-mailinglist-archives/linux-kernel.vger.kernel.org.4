Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FB2695257
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBMUx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBMUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:53:26 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD9A1F936;
        Mon, 13 Feb 2023 12:53:25 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DEA0B6600358;
        Mon, 13 Feb 2023 20:53:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676321604;
        bh=MU7Up8g4XWnVTRiQOQ2hENRWDzhjov7avNea39+l+Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geEetMYcrIHbpVpbPa9dydMUzw1+ROLFBBuiumfTN1Xap1cRFGbhMhu9VGlXR6vzp
         InR4bjm6Pj30yFfc4jmpex/JPceOii7RT3gXgOIcYGNICTepjKYW5qd6EjrurTbn8t
         VU+Dej4qdWUG79hUBzUm2tceeRv9CINGNE9NM5MMp43j78vb88O4gWFWU9o5ZyidVN
         ZPnINWO2KDamwWA/sjLPfqPUOFgCPj62ZaBZPILLZT94NY5v/SQlZVZMHv7suV2y5d
         o+iT0AsXYpvLeUWJQZoU/XGSsSUXkjm9yKRa+T8qCIed2VZ9k2uN3MjGgaAvJJr02+
         eOTFCsP78yehw==
Received: by mercury (Postfix, from userid 1000)
        id 724F81060961; Mon, 13 Feb 2023 21:53:21 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:53:21 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterwu.pub@gmail.com
Subject: Re: [Patch][next] dt-bindings: power: supply: Revise Richtek RT9467
 compatible name
Message-ID: <20230213205321.xrhvrdqy5ksiagbv@mercury.elektranox.org>
References: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r3cq4aakiv6m7xrb"
Content-Disposition: inline
In-Reply-To: <dc8873c3125f7aa6f84dc7b33a44bf00907e0814.1675853673.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r3cq4aakiv6m7xrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 08, 2023 at 11:14:24AM +0800, ChiaEn Wu wrote:
> Revise RT9467 compatible name from "richtek,rt9467-charger" to
> "richtek,rt9467"
>=20
> Fixes: e1b4620fb503 ("dt-bindings: power: supply: Add Richtek RT9467 batt=
ery charger")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---

Is there a new version of this fixing the issues pointed out by Krzysztof?
Also I think the filename and $id should be changed to richtek,rt9467.yaml
in addition to the compatible change.

Thanks,

-- Sebastian

>  .../devicetree/bindings/power/supply/richtek,rt9467-charger.yaml      | =
4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt946=
7-charger.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9=
467-charger.yaml
> index 92c5706..9176808 100644
> --- a/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charg=
er.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9467-charg=
er.yaml
> @@ -25,7 +25,7 @@ description: |
> =20
>  properties:
>    compatible:
> -    const: richtek,rt9467-charger
> +    const: richtek,rt9467
> =20
>    reg:
>      maxItems: 1
> @@ -65,7 +65,7 @@ examples:
>        #size-cells =3D <0>;
> =20
>        charger@5b {
> -        compatible =3D "richtek,rt9467-charger";
> +        compatible =3D "richtek,rt9467";
>          reg =3D <0x5b>;
>          wakeup-source;
>          interrupts-extended =3D <&gpio_intc 32 IRQ_TYPE_LEVEL_LOW>;
> --=20
> 2.7.4
>=20

--r3cq4aakiv6m7xrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqo0EACgkQ2O7X88g7
+pqQSQ/+OkcfFPZuVrVvDR2ftl8gF8q3d0f9bhdHTcWG7rc3umiDAVn956mOKbMq
Uitnia+BeovzD1oiGhfF5F7sriXqMGo4Ul7Jr3xXmkXzDZw4l5dlRAwtv8R0tlAN
/ELRpIMViEFCWOBlAMEQYkhKECNKtSCe/U69iS6ouwoPkVnxWhpG46zCsMR+9pFX
VSgDyXNf/HPDaTvOhX0p7NMQG8Ov69TzSuwrO21krRCWEcrvdXaXfQ7VrFsYb/2z
XYntcAqeOawPKCn8Rm0QpDGuczujvIWvrqYJMJf5ItAcfH6ga5UwzHRs2dZmOm9q
UlhSxpc3/ZtiS0RzY5+cVT7iFlJ2UKxtVVS9YVhg+NXhwebAFdDIKwdsvGf9Qvzz
hB+FJ8GXVPcUQZr5E7002FDwa/OXum2434AFM0pBrlkxwLXpVthqAUAj3v5DTASW
Q0+qaDID8J84jDAr+0QWulGKp1HbuhOutJg9f34/5oE8Am73IQLBSYh8gq55s6S6
p4tfMnvY4n0ZyV9Elvg8cwlT1x869hLIq96jADp8rxaNMl8h+sXNRzsDq6ZYyLBe
Xs1LLukQSTHV8m8DHJ0BpEjfr+n3K+geisZL1feQSE248scNexm0nSbT8f9oGm+4
TnPKWjKtblKrkh7TGIr35abxhb5Gzq7lkPp2CtxYppW9WuMusfY=
=RCkA
-----END PGP SIGNATURE-----

--r3cq4aakiv6m7xrb--
