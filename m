Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1C8731DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjFOQh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjFOQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786BE69;
        Thu, 15 Jun 2023 09:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06B061A82;
        Thu, 15 Jun 2023 16:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D897C433C0;
        Thu, 15 Jun 2023 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686847042;
        bh=qNA7RNRSn7+N0rXsnB3tLIGZpW49dK4CI81wmGijPKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FILfp0XhsCAEFvj3KRRIeHhk7gSO6N4Xy03NeLRNCYvAfs29VNg7/UETFjJROjcyE
         P7DvhjAWHw5fxoTtxnxgIyP2OVcMoejHbl2e0qXLatlGYmVhgBzPqvUTgNjZD7radt
         I+fxhhS4VccMG1ebjsplRSfpSyMh073Grs7hun14/7Cz70d6pMl4g7qgYug6f93dK2
         0ftJSIpAiSrxL6jJas7mr2fW1UW0zqVr6oZqDZsqdz4jlfuQacCWByttPYsW7csUgy
         cg0u9K9Ll0Wvg8lgWIRZtFJX06unxfnLh0VZzlBco6Aa7NcFiN9DG58rbf30ksxRoM
         rZqpJ2R98E6IQ==
Date:   Thu, 15 Jun 2023 17:37:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Aleksandr Shubin <privatesub2@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
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
        Maxime Ripard <mripard@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230615-display-encounter-9a7a78562ff8@spud>
References: <20230615144423.828698-1-privatesub2@gmail.com>
 <20230615144423.828698-2-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F7o1AoRcl0OiOFh0"
Content-Disposition: inline
In-Reply-To: <20230615144423.828698-2-privatesub2@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--F7o1AoRcl0OiOFh0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Aleksandr,

On Thu, Jun 15, 2023 at 05:43:56PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
>=20
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).

It would be good to note that the D1 and T113 are identical in terms of
peripherals, they differ only in the architecture of the CPU core, and
even share the majority of their DT. Because of that, using the same
compatible makes sense.
The R329 is a different SoC though, and should have a different
compatible string added, especially as there is a difference in the
number of channels. It would be fine to use the current compatible for
the D1 as a fallback.
The allwinner,pwm-channels property should probably only be allowed on
the R329 and only allow the values of 6 & 9.

> Add a device tree binding for them.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20=
i-pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> new file mode 100644
> index 000000000000..e5f9cb2d5c4f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1, T113-S3 and R329 PWM
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <mripard@kernel.org>

BTW, this should probably be you, since you have the hardware with this
SoC.

> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: allwinner,sun20i-d1-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +  clocks:
> +    items:
> +      - description: 24 MHz oscillator
> +      - description: Bus Clock
> +
> +  clock-names:
> +    items:
> +      - const: hosc
> +      - const: bus
> +
> +  resets:
> +    items:
> +      - description: module reset

Don't need the items here, because there is only one. You can just do
"maxItems: 1" instead.

> +  allwinner,pwm-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of PWM channels configured for this instance
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +  - allwinner,pwm-channels

Cheers,
Conor.

--F7o1AoRcl0OiOFh0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIs+OwAKCRB4tDGHoIJi
0hCRAQClhbz58ZFGWg/0NsMGr2czXIOEYRr3Icjm1MXyaIbQ2QD+JOxFNrOUEjYR
q1YQ5xn6ccQNAWrTPBc2nULAXNeBUwI=
=zm+X
-----END PGP SIGNATURE-----

--F7o1AoRcl0OiOFh0--
