Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE3C72AC76
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjFJPGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjFJPGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:06:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCC23588;
        Sat, 10 Jun 2023 08:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DC1761044;
        Sat, 10 Jun 2023 15:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77077C433D2;
        Sat, 10 Jun 2023 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686409604;
        bh=U1kzKQLjBw3U2CaamkV1OihnciwYdzX6lEiWfiY9w9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFMmIFLq9D+Je2P4zOq9Qj7TXnerOZE+WOuFadpjtM9DJ4TYvr6yTHF029wKeDHYJ
         +VBXfC49Fg/P9rLKNCAqwr0Rl5ZbfP4RCJiSdX8KdtbpigM56PcwtXfas50SkoWObJ
         qVT5XVDA9aut86TydiQr3HUPR7RKLYwENN5DSMI96yEi8iHEfkh9qtnKI3Ebv+ip/R
         Q0CppC9gNDs0YQGA3YmW3qIGu1UZuKFwqFtytAlnbeie5oatbqDGGl++nk5AHT/PRw
         SW4qw/cqIo1qxOgm82LFoxTTGk+zwIRvN4HNJA/Tqgh1aq6Y/rrHyrnB+S04S6wXeM
         j5rBdXyTfBalQ==
Date:   Sat, 10 Jun 2023 16:06:35 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 2/3] dt-bindings: iio: adc: Add Allwinner
 D1/T113s/R329/T507 SoCs GPADC
Message-ID: <20230610-ranged-outboard-2aaa0cc36cbd@spud>
References: <20230610122934.953106-1-bigunclemax@gmail.com>
 <20230610122934.953106-3-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wh79gADhzXBzQ9SW"
Content-Disposition: inline
In-Reply-To: <20230610122934.953106-3-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wh79gADhzXBzQ9SW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sat, Jun 10, 2023 at 03:29:08PM +0300, Maksim Kiselev wrote:
> From: Maxim Kiselev <bigunclemax@gmail.com>
>=20
> Allwinner's D1/T113s/R329/T507 SoCs have a new general purpose ADC.
> This ADC is the same for all of this SoCs. The only difference is
> the number of available channels.
>=20
> Signed-off-by: Maxim Kiselev <bigunclemax@gmail.com>
> ---
>  .../iio/adc/allwinner,sun20i-d1-gpadc.yaml    | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/allwinner,s=
un20i-d1-gpadc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d=
1-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d=
1-gpadc.yaml
> new file mode 100644
> index 000000000000..2b59844b7c07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/allwinner,sun20i-d1-gpadc=
=2Eyaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/allwinner,sun20i-d1-gpadc.yam=
l#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1 General Purpose ADC
> +
> +maintainers:
> +  - Maksim Kiselev <bigunclemax@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - allwinner,sun20i-d1-gpadc
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^channel@([0-15])$":
> +    $ref: adc.yaml
> +    type: object
> +    description:
> +      Represents the internal channels of the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 0
> +          maximum: 15
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - "#io-channel-cells"
> +  - clocks
> +  - compatible
> +  - interrupts
> +  - reg
> +  - resets
> +
> +unevaluatedProperties: false

How come this one changed to unevaluatedProperties: false?
Wasn't it for the ADC that we previously discussed whether
additionalProperties: false was correct or not?

Cheers,
Conor.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    gpadc: adc@2009000 {
> +        compatible =3D "allwinner,sun20i-d1-gpadc";
> +        reg =3D <0x2009000 0x1000>;
> +        clocks =3D <&ccu CLK_BUS_GPADC>;
> +        resets =3D <&ccu RST_BUS_GPADC>;
> +        interrupts =3D <73 IRQ_TYPE_LEVEL_HIGH>;
> +        #io-channel-cells =3D <1>;
> +
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        channel@0 {
> +            reg =3D <0>;
> +        };
> +
> +        channel@1 {
> +            reg =3D <1>;
> +        };
> +    };
> +...
> --=20
> 2.39.2
>=20

--wh79gADhzXBzQ9SW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZISRewAKCRB4tDGHoIJi
0t7lAQC3g8izalvV17+LOkuzC99K8K7gGKPcCDEWGDZSOQmmcgD+PmIbXH+W/Zd3
WmLf5srpovGreGR+T+Diold6TDIk4ws=
=rCnq
-----END PGP SIGNATURE-----

--wh79gADhzXBzQ9SW--
