Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16261E2AD
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 15:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiKFOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 09:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiKFOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 09:45:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D4DDFCC;
        Sun,  6 Nov 2022 06:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1667745935; bh=uFBIj1CCrW4SrRXLgszwEqhFh2arkkn2G9/bYfdBuY0=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KKMhhAwlV2c7aFU6BFy9D5R52fFfesi4lZEQoZ5oJtO5m1mzJAcWxnoFrhi5Kx9D7
         T1Ld9Kfnzv7IEztlgIcvzBXUsTSdoUitkE7gTpReein8imMfWSNFWTRLzy/JUJfqfj
         qb7qyWkRHgvEwjbVolyZi5ZE295vZIFOsq4mZixpNGdawBQsTFz89hcYcXxktHC4L3
         UMo5yqjM+yDogwJ3bXy+xDU39MKD3AoGrALj8Rm3ATiAyJwMp9kkp++zCcdznLh1mh
         oGnpH2mux4ZfNPCSXn0jQ0ApTTUDlvOp5XWlyas5Wkft8R19unPQiPRWIW9jHGc+kw
         s+pA+Dp+ipVWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([87.78.44.193]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1p0rlR2yje-013ag6; Sun, 06
 Nov 2022 15:45:35 +0100
Date:   Sun, 6 Nov 2022 15:45:33 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y2fIjSKAGleEtjHe@probook>
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-4-j.neuschaefer@gmx.net>
 <066919b1-c43d-f8ed-0191-cce8c575ee37@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q/dsuaf+z0DGbslE"
Content-Disposition: inline
In-Reply-To: <066919b1-c43d-f8ed-0191-cce8c575ee37@linaro.org>
X-Provags-ID: V03:K1:9dfr0Ld2MAubq9uHcBB6ePKJ0SA4vvo9RfOLyZuwrXMU1WaRSI9
 0dykonq5mZbtXsU/zl61UimkgFXqLKmtip6k91MLsR1WmM20zBQ7iZbQChrHQbSVlGk3p0e
 U0FIF5xUTKd/GqwbY7XQFGfSt8jWLJxHigF5HTFa1KNU1nG3AOkhVFVEMQmXJ0zWjVTs3JJ
 ZRjs5FzGAqzcPjo4S1Xtg==
UI-OutboundReport: notjunk:1;M01:P0:wtfUvRvObO0=;rIkuNxZB5jiPWxtSMDpZDyGO44k
 9BWT0nVgq7PRHjf5BumxxAaUhjwcjVYmzRT9DflAxBxj3x2eT8a5C4JHkdDZxA9Ky89x5j5X0
 F9EqSwNmr70RgB2TyQqw/FDYC9Ffdg1pRJrQO2FdIvkzQEyl+HjNS7uJkBpgio9UoMONna5ly
 nStEweGAVb7xwPBhUb6zrsN3ZZTcKmX06QkEpBYoB0Xy1EgZtXcn8ctPgKDxncEC35R84buzt
 GO1P1QPhzVQG8hvLzseCnF9msnFqmJqzjHFiWQvw8iTx/t1vhEx5/KdlOqW9ENGg1XM5KlF1J
 LPD5Ks8XJDbS+JpmK65RT7nkz61sufG6SdsKg1G2/XHUB0kYD7lzxIg0jhf7g7JSoCH9Np4dv
 Ozn3HSr2f8j681WHH50yiMd1Hi+HbMyCWvqQd88I+HMJywdJqRp7N6d94DXn6jwr1XGHbGZbb
 8tVilGMEkasrrjdrmFxzrxFfxbmtrPvPZzJq3j3PJ7g3r+YeiK0BHsdIqehV4YGonKjP68Yhl
 R7VLwoZT68SJLNFdvwCE6q27UBBQzUlM44EAM5qzqQVICTBFt8kJp0WtDRpjbjEMh1X7XX+GR
 00+QXib8WW/U83gg7+q3k/pHbTjN/Duf3sDVKqj+FaFk6o1YK3Yy+Yqxe4JaNVw+9QHB6scsE
 GEK8KUksEhikGjiHlWRIj+LT/6EctyL0yO1zTcmlyg1feytXeTMjPDf+DMwCUm1seg/7XOEkB
 BBmPJ8yuokKSZn56OUKjS2gT8rHhFquK9UqJ2vLJxBsVfUATOX1VhqJptoF5aWUQYHQz0ecgU
 G6haWAF4olFAjP9fxaFP0plsw8na8Oeg79z5rbBV1pxPGRpAk30Kk+xcWBdM8TWalj3pB8y9C
 mpVDd9kU0e6fTbJpu59oUnXc3hEPNzBbtk5xq/yFLNVd5/sMDA14w6uwteMMFk0KlCzzCN/y/
 R9rrJw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q/dsuaf+z0DGbslE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 06, 2022 at 10:38:45AM +0100, Krzysztof Kozlowski wrote:
> On 05/11/2022 19:59, Jonathan Neusch=C3=A4fer wrote:
> > The Flash Interface Unit (FIU) is the SPI flash controller in the
> > Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> > (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> > accessed by software-defined SPI transfers.
> >=20
> > The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
[...]
> > +allOf:
> > +  - $ref: "/schemas/spi/spi-controller.yaml#"
>=20
> Drop the quotes.

Will do.


> > +
> > +properties:
> > +  compatible:
> > +    const: nuvoton,wpcm450-fiu
> > +
> > +  reg:
> > +    items:
> > +      - description: FIU registers
> > +      - description: Memory-mapped flash contents
> > +
> > +  reg-names:
> > +    items:
> > +      - const: control
> > +      - const: memory
> > +    minItems: 1
>=20
> This does not match your 'reg'. Two items are required there.

My intention was rather to make the second reg item actually optional,
i.e. add minItems: 1 for reg as well.  (But, further discussion below.)


> > +    spi@c8000000 {
> > +      compatible =3D "nuvoton,wpcm450-fiu";
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      reg =3D <0xc8000000 0x1000>, <0xc0000000 0x4000000>;
>=20
> reg is the second property.

Ok, I'll move it up.

>=20
> > +      reg-names =3D "control", "memory";
> > +      clocks =3D <&clk WPCM450_CLK_FIU>;
> > +      nuvoton,shm =3D <&shm>;
> > +
> > +      flash@0 {
> > +        compatible =3D "jedec,spi-nor";
> > +      };
> > +    };
> > +
> > +    shm: syscon@c8001000 {
> > +      compatible =3D "nuvoton,wpcm450-shm", "syscon";
> > +      reg =3D <0xc8001000 0x1000>;
> > +    };
> > +
> > +  - |
> > +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> > +    spi@c8000000 {
> > +      compatible =3D "nuvoton,wpcm450-fiu";
> > +      // the "memory" resource may be omitted
>=20
> This is rather obvious, so what you should comment is WHY or WHEN second
> resource can be omitted.

Ok, I'll add more reasoning, which is basically: The "memory" mapping is
only an optimization for faster access, knowledge of it is not necessary
for full operation of the device.

> Not every instance on the hardware has it?

AFAIK every instance has it, and there's unlikely to be any variation on
this fact anymore, because newer Nuvoton SoCs replaced the FIU with a
redesigned and incompatible version.

I admit that the value of making the "memory" mapping optional is rather
theoretical, and I'm open to making this reg item mandatory to simplify
the binding.

> Just to remind - this is the description of hardware, not Linux behavior.

Indeed.


Thanks for your review,
Jonathan

--Q/dsuaf+z0DGbslE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmNnyGwACgkQCDBEmo7z
X9umLg/8C+xb2s+GN31rbtlZ8YbXQlGQ6OIzFaVdHtvz6iPv/jdhAC2VXbjI5N3E
0Hdwx5lwVefglOMOggMbu06b4DztfoGyWGK+rjRILh9F3sGCAeN73PE2iK8L5xQs
Sm+B49sH34KM8wLyGQ7V9OL2in3Q27FFdqawZyIjBPmqxFfcq9UTxlrJBFGHb4JG
8RHx2fLJO7ycrUl9B4SMnGKnGgbufkzSAI4UqR7UKB903XVKUW3oj7yCLYNggVsv
ClhaEbkCiurR4ZrSWkZOQCMhH1CsrqSzQRDdNp6kQC/Zs8Ak2ArPkAHXBtCIi/43
rvTEXF6kQ+aFa2+nwlBJ0lRwKhTcdaIdmeAWs13FGJFVPCfbFaxhWmjZuFQcvUQA
eSO4QPuT22hB+Bx34z3B5WZLadxLZaB6eQVgOzyhpXx4dgWmhuBCh+8X+9w0GKWP
vr5yhAjUUWvMgyVHNSzrQaIZb6+KpApRSNsKk5dzBF2bPCh4YvSRCcEEFvx1cDwJ
Q0IuEHMszpxsc+QaafTvC9bplsUWK6xrwHDWnn/IGaxjNBeFzHqfCyNxLnugnZbm
ERjGJsf4DWFlkOM4wPu8xbgUhXFW1PWTtWhASsoolE9KJ3VRCr4LEfBuOfyeE3mz
TmEgC/mKYuxe+oUmob9WTwwGmAOkJnWU8q5EuXZrljsDhEbUdp8=
=rTe9
-----END PGP SIGNATURE-----

--Q/dsuaf+z0DGbslE--
