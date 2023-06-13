Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7194172F00C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjFMXjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjFMXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:39:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D371727;
        Tue, 13 Jun 2023 16:39:11 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 06CBD6606EF9;
        Wed, 14 Jun 2023 00:39:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686699550;
        bh=IKYgT2kpzwm26VrHhP6ovXhCybkwMBtlj3qr8WiFGbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k6Z8PSNSJkj4IA9XxLF1dVbJynR/k5304D5jZaNwmxcG8cBsNDlRLm5oAoXzgyCf0
         w8uALy6UV3NlqUnG/ED4DkXdl4mz/UtWSLi+Yyf4yjzScb9AqjZCP9U40+RPACuYTH
         31kindpdAEOOJPydLidvKe+USIxnIHCAlv3xUkTBCtKbeYEsv0qNCUvyhuYHShlY9E
         W9Vd9c+2Vkb9ey4GW/uDIevQYWvfJdOeZkK27kuaFmPaf5XOQk9Ji4E4LF0Th9guLe
         rTCaOu5hA56IodBvpuVv40u7UzdnqbMAEG1eztn7LdGztaZj6C604dMa8YBKqSaTeY
         VAk+KbbS+aZLg==
Received: by mercury (Postfix, from userid 1000)
        id 50F631060A57; Wed, 14 Jun 2023 01:39:07 +0200 (CEST)
Date:   Wed, 14 Jun 2023 01:39:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 20/25] dt-bindings: devfreq: event: convert Rockchip
 DFI binding to yaml
Message-ID: <20230613233907.a5t4ckpmbqip7iue@mercury.elektranox.org>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
 <20230524083153.2046084-21-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igsprmquqpwnps2m"
Content-Disposition: inline
In-Reply-To: <20230524083153.2046084-21-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igsprmquqpwnps2m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 24, 2023 at 10:31:48AM +0200, Sascha Hauer wrote:
> Convert the Rockchip DFI binding to yaml.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>=20
> Notes:
>     Changes since v4:
>    =20
>     - Revert to state of v3 (changes were lost in v4)
>=20
>  .../bindings/devfreq/event/rockchip,dfi.yaml  | 61 +++++++++++++++++++
>  .../bindings/devfreq/event/rockchip-dfi.txt   | 18 ------
>  .../rockchip,rk3399-dmc.yaml                  |  2 +-
>  3 files changed, 62 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockc=
hip,dfi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/devfreq/event/rockc=
hip-dfi.txt
>=20
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi=
=2Eyaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> new file mode 100644
> index 0000000000000..7a82f6ae0701e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/event/rockchip,dfi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip DFI
> +
> +maintainers:
> +  - Sascha Hauer <s.hauer@pengutronix.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3399-dfi
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pclk_ddr_mon
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  rockchip,pmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the syscon managing the "PMU general register files".
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/rk3308-cru.h>
> +
> +    bus {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
> +
> +      dfi: dfi@ff630000 {
> +        compatible =3D "rockchip,rk3399-dfi";
> +        reg =3D <0x00 0xff630000 0x00 0x4000>;
> +        interrupts =3D <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +        rockchip,pmu =3D <&pmugrf>;
> +        clocks =3D <&cru PCLK_DDR_MON>;
> +        clock-names =3D "pclk_ddr_mon";
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi=
=2Etxt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> deleted file mode 100644
> index 148191b0fc158..0000000000000
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -
> -* Rockchip rk3399 DFI device
> -
> -Required properties:
> -- compatible: Must be "rockchip,rk3399-dfi".
> -- reg: physical base address of each DFI and length of memory mapped reg=
ion
> -- rockchip,pmu: phandle to the syscon managing the "pmu general register=
 files"
> -- clocks: phandles for clock specified in "clock-names" property
> -- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon=
";
> -
> -Example:
> -	dfi: dfi@ff630000 {
> -		compatible =3D "rockchip,rk3399-dfi";
> -		reg =3D <0x00 0xff630000 0x00 0x4000>;
> -		rockchip,pmu =3D <&pmugrf>;
> -		clocks =3D <&cru PCLK_DDR_MON>;
> -		clock-names =3D "pclk_ddr_mon";
> -	};
> diff --git a/Documentation/devicetree/bindings/memory-controllers/rockchi=
p,rk3399-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ro=
ckchip,rk3399-dmc.yaml
> index fb4920397d08e..aba8649aaeb10 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/rockchip,rk339=
9-dmc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/rockchip,rk339=
9-dmc.yaml
> @@ -18,7 +18,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Node to get DDR loading. Refer to
> -      Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt.
> +      Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml.
> =20
>    clocks:
>      maxItems: 1
> --=20
> 2.39.2
>=20

--igsprmquqpwnps2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmSI/hQACgkQ2O7X88g7
+pruyw/+PclczDdjsGUjLjCBWzHU1CIdodfMwJfKjcmX+gJhGxbklOg+VyjnxF+R
BBcnoYB6lmSEUIGQmEz9AJ/8dQoTB9mSENw8tKimVPLSdiRO/qdLxsspTZJ5OSQE
fIn/+MoVkW6Xvv7a14oumTvrZGNjPhD/OQMRcMY5mfdLsIi0E9UMIob9ow8r6Qqj
0M1YUBp9YenTWD8J/e5mOafaJ6E7EoDoEQSytRppQHiFN4E7EjNQr5hduOChlyoP
BAIPj1jz2HhVUJdTwgdlxhOUmhjpKLewcFdZSB7hTjY5SrYhMEUlByRog3ILiSO8
mNvPhN+VHnumvv+8KkSm2sgpZ7FvUjjxfRobydFoXWnlb5Z5GQtuJiz65bVzI57v
vzf/QWAXQ9dey+Q2Q+FQh4nPAmovV3KQ07GUR4bfL3ofMsUJZaT+tpGbqvpRklTh
unG/PDWK1WSPBLxN09V3+5aiXm12hHw0/JJIxZWPXL7CvwOuhKj8vO6mrXlabdy9
H5H3jcPE8MCcN7c6ZhOV4H8Lbt1VwqhjBY16Z8etzIOMaq8uL2Cg9hbZTbFbL/Q8
gnS+7wY+t1VYP9+1XWnoIverBeCd3Q/jixTGXs7bMZxwOXqWHHqgwsj00zWBU6ns
yInon6jNb03nDPpygcL7EKVeTBmKyeFJKgL3CaoLCYF7LneOZqo=
=k0al
-----END PGP SIGNATURE-----

--igsprmquqpwnps2m--
