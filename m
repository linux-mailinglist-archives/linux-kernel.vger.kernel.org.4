Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC09673BC54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjFWQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjFWQGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC346210A;
        Fri, 23 Jun 2023 09:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 578C661A8D;
        Fri, 23 Jun 2023 16:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC2C433C8;
        Fri, 23 Jun 2023 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687536371;
        bh=1E90KwmrUhKXNTTm2SbNNwpufeK6ASp2c6/zr7HTCik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ANHlBmST7NSB15AbS9Oxi3q0Z5qE4FwhfC95Y2y4CKodA/+Nn8IYu3U3k4SQg06k1
         9qTgb0jWNRiPV6iNmXdriKGMt6EeCVgUfGhkPt8zzBztvxX0OaMz/uRxH/qMEUhHmb
         jETUspbKQvaafjLjOaXtjaskPp8vaCR7D1nvnjFKGOrw1PtmwmpZpS3MtnmyvIsnW8
         7K5HwL6ZVy2VY4+x2VXjm8KDJQFuLUUxhSDfaFslgHGpuFiCtwjQUWms1Au89okW2D
         gM8N2MS9iVmwzmVcs37ceavmRmpo6/jljPNNInCehw8A1cZ24UJp0OIYFrkvzJunsE
         vsDzrK1yAv6SQ==
Date:   Fri, 23 Jun 2023 17:06:05 +0100
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
        Andre Przywara <andre.przywara@arm.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <20230623-chrome-squishy-3b501a44eda9@spud>
References: <20230623150012.1201552-1-privatesub2@gmail.com>
 <20230623150012.1201552-2-privatesub2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KULVfyZvgvI/nhWt"
Content-Disposition: inline
In-Reply-To: <20230623150012.1201552-2-privatesub2@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KULVfyZvgvI/nhWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Alexksandr,

On Fri, Jun 23, 2023 at 05:59:59PM +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller witch is different from the previous pwm-sun4i.
>=20
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
>=20
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
>=20
> Add a device tree binding for them.
>=20
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20=
i-pwm.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.y=
aml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> new file mode 100644
> index 000000000000..eec9d1dd67c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/allwinner,sun20i-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner D1, T113-S3 and R329 PWM
> +
> +maintainers:
> +  - Aleksandr Shubin <privatesub2@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: allwinner,sun20i-d1-pwm
> +      - items:
> +          - const: allwinner,sun20i-r329-pwm
> +          - const: allwinner,sun20i-d1-pwm
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
> +    maxItems: 1
> +    description: module reset
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: allwinner,sun20i-r329-pwm
> +
> +    then:
> +      properties:
> +        allwinner,pwm-channels:
> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          description: The number of PWM channels configured for this in=
stance
> +          enum: [6, 9]

Last time I acked something like this, Krzysztof complained about
defining properties inside conditionals. This diff avoids the
definition in the conditional, while also disallowing it on the D1.
Thoughts?

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
index eec9d1dd67c2..6c04aaa5e9ab 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
@@ -37,6 +37,11 @@ properties:
     maxItems: 1
     description: module reset
=20
+  allwinner,pwm-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The number of PWM channels configured for this instance
+    enum: [6, 9]
+
 allOf:
   - $ref: pwm.yaml#
=20
@@ -47,15 +52,14 @@ allOf:
             const: allwinner,sun20i-r329-pwm
=20
     then:
-      properties:
-        allwinner,pwm-channels:
-          $ref: /schemas/types.yaml#/definitions/uint32
-          description: The number of PWM channels configured for this inst=
ance
-          enum: [6, 9]
-
       required:
         - allwinner,pwm-channels
=20
+    else:
+      not:
+        required:
+          - allwinner,pwm-channels
+
 required:
   - compatible
   - reg


> +
> +      required:
> +        - allwinner,pwm-channels
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#pwm-cells"
> +  - clocks
> +  - clock-names
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sun20i-d1-ccu.h>
> +    #include <dt-bindings/reset/sun20i-d1-ccu.h>
> +
> +    pwm: pwm@2000c00 {
> +      compatible =3D "allwinner,sun20i-d1-pwm";
> +      reg =3D <0x02000c00 0x400>;
> +      clocks =3D <&dcxo>, <&ccu CLK_BUS_PWM>;
> +      clock-names =3D "hosc", "bus";
> +      resets =3D <&ccu RST_BUS_PWM>;
> +      #pwm-cells =3D <0x3>;
> +    };
> +
> +...
> --=20
> 2.25.1
>=20

--KULVfyZvgvI/nhWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJXC7QAKCRB4tDGHoIJi
0uBkAQCILXb1WLhuGxMe3N91d0Gdimyg2vHC9UVU2pxuqueUDQEApJu97z7JoBHd
cVe5e774+GSm5eVJm9VFGf0vSj5BRw4=
=1G5Q
-----END PGP SIGNATURE-----

--KULVfyZvgvI/nhWt--
