Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F226F2120
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbjD1XP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 19:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346782AbjD1XPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 19:15:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557D749DE;
        Fri, 28 Apr 2023 16:15:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5C860F91;
        Fri, 28 Apr 2023 23:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A674C4339B;
        Fri, 28 Apr 2023 23:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682723718;
        bh=V47hoZiyKH7rDpUH6NwYPJ7TotHzjSslW4RlKcVJpT4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VifBKT2RDFwmgKTgjLwymdT5T9+lRiUD0Jgc6ya20KneNUzUlolcuv6d8KdY+DQjk
         C/1TEAZieV4eTU+238Hi8KkI55t6+GS1tSOtqvMI4eHIKFk+5DWARtxmMA0v+QENcr
         QXhixuXifZc8HxRIFDLInH2c6EnOchvdaPpDYWZnh6vsOnKasVYP2ONeHInbQ7iHL7
         REy5XL1VIYhsV3nReQElrrXqe5EoTlJu09glYLB2lSPEb+wR/SSR3BA3/KEM+HXSc7
         myeXsIbv+LFBxSvN/HThCu4TNp5DwlFQgI9gtfPmKAn9DvLL8TyX34CN1CuOEchsyX
         JaLuRNqLS6+HQ==
Message-ID: <3574700189bb35bba3ad6d79f3a799c9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230424123522.18302-12-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me> <20230424123522.18302-12-nikita.shubin@maquefel.me>
Subject: Re: [PATCH 11/43] dt-bindings: clock: add DT bindings for Cirrus EP93xx
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Date:   Fri, 28 Apr 2023 16:15:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nikita Shubin (2023-04-24 05:34:27)
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
>=20
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/arm/ep93xx.yaml       | 102 ++++++++++++++++++
>  .../dt-bindings/clock/cirrus,ep93xx-clock.h   |  53 +++++++++
>  2 files changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ep93xx.yaml
>  create mode 100644 include/dt-bindings/clock/cirrus,ep93xx-clock.h
>=20
> diff --git a/Documentation/devicetree/bindings/arm/ep93xx.yaml b/Document=
ation/devicetree/bindings/arm/ep93xx.yaml
> new file mode 100644
> index 000000000000..de7020f4f356
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ep93xx.yaml

Why is this in arm/ directory? Isn't it a clock controller?

> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/ep93xx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logick EP93xx device tree bindings
> +
> +description: |+
> +  The EP93xx SoC is a ARMv4T-based with 200 MHz ARM9 CPU.
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: The TS-7250 is a compact, full-featured Single Boar=
d Computer (SBC)
> +          based upon the Cirrus EP9302 ARM9 CPU.
> +        items:
> +          - const: technologic,ts7250
> +          - const: liebherr,bk3
> +          - const: cirrus,ep9301
> +          - const: cirrus,edb9302
> +
> +  soc:
> +    type: object
> +    patternProperties:
> +      "^.*syscon@80930000$":
> +        type: object
> +        properties:
> +          compatible:
> +            items:
> +              - const: cirrus,ep9301-syscon
> +              - const: syscon
> +              - const: simple-mfd

Is there a reason it needs to be a syscon? Or a simple-mfd?

> +          ep9301-reboot:
> +            type: object
> +            properties:
> +              compatible:
> +                const: cirrus,ep9301-reboot
> +        required:
> +          - compatible
> +          - reg
> +          - '#clock-cells'
> +          - ep9301-reboot
> +
> +      "^.*timer@80810000$":
> +        type: object
> +        properties:
> +          compatible:
> +            const: cirrus,ep9301-timer
> +
> +    required:
> +      - syscon@80930000
> +      - timer@80810000
> +
> +required:
> +  - compatible
> +  - soc
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    / {
> +      compatible =3D "technologic,ts7250", "cirrus,ep9301";
> +      model =3D "TS-7250 SBC";
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +      soc {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <1>;
> +          ranges;
> +          compatible =3D "simple-bus";
> +
> +          syscon: syscon@80930000 {
> +                  compatible =3D "cirrus,ep9301-syscon",
> +                                  "syscon", "simple-mfd";
> +                  reg =3D <0x80930000 0x1000>;
> +                  #clock-cells =3D <1>;
> +                  #reset-cells =3D <1>;
> +
> +                  ep9301-reboot {
> +                          compatible =3D "cirrus,ep9301-reboot";
> +                  };
> +          };

The example should only be the clock controller node. No soc node, or
root node.

> +
> +          timer: timer@80810000 {
> +                  compatible =3D "cirrus,ep9301-timer";
> +                  reg =3D <0x80810000 0x100>;
> +                  interrupt-parent =3D <&vic1>;
> +                  interrupts =3D <19>;
> +          };
> +      };
> +    };
> +
> +...
