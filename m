Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DDA62FACF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiKRQvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiKRQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:51:04 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C618CFC8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:51:03 -0800 (PST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 923553F1C3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1668790261;
        bh=D7JhrXwjD/BBBqSqzrNVCIT+3QaOVEAS69GN8n0gs5k=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KN1o1xTAuztXEnjQNPJ2mCB+HAzH8uR5GdcIix7DhP9zg/LJwIpA+fEi72Qn4ezDh
         L7oUYb65nQWr1X4EM3KXgMs7qp0RPYTenRQI+VigEip+QKFoG1mwfdvIEVPqLJASed
         19zcilTy3MUOPYvIlJ28S0RE18tTq8oY+6EmUBRISlJq6KdmJLugh+gLpoob/HtmQO
         oWPBuPKCGTbxh5xa0C83FP0Yb9Ha61Pjoi2eZMrEQyYB1+9dmHfG8HqTpE+PxKEzNQ
         ueTteRT+Wxho/c6E2tDVfU1kX5JnhmYn9W7J9oimo3kvrxfinHUmbppgIuHBURNeTf
         /MZT4dEan1V+w==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-352e29ff8c2so54550197b3.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7JhrXwjD/BBBqSqzrNVCIT+3QaOVEAS69GN8n0gs5k=;
        b=yHLUytjJfDL+qQBZ0sVnD8uXULXD6rGX+USezYtCQkRoARa51QPJQAkFCdbF/8Gw6E
         JoAMyrYbU2/Gg8/nDXrrHupUvUoe+8rHxrc2UFAeqY3Q6gj9sypilFAAjh+jzOWoo2vy
         Xum1SX5125BeLPKAKmZZ8owWWqk8aNtDEh3o2E2d+yZE6JIJlkEi8LHFBy3/RsCA5Lz7
         puu7lgevwkIGFxDNa9ECOeIrFjM1y2bs9Srl3DMb/+iTYFMJsC9qukV6ph2p5xFyqmSb
         GlVqbZfY6NGNXmUs8svRLK90mz+03cg5U1wqcC2Zl0A7jl7WqhFVVwio2zJzlyGzMtGE
         CXMg==
X-Gm-Message-State: ANoB5pnhX2PmUnpUM8peLhrfigp+bOHnqNQvKPr+8+jwe83ru53Sl2Go
        zcOo1qv3qxKJ2U+ua78LgMa6NeUai3GpEsFhvOQeA/2V2J3OfWQiv46dZsz62IITAL6WIifeQtS
        DX/K1lwmayixFhamk80EkFRnR7+J1eoNToYOvPR57ml0rH9HhA2DCmANzxg==
X-Received: by 2002:a0d:cad3:0:b0:36f:d611:a5fe with SMTP id m202-20020a0dcad3000000b0036fd611a5femr7231976ywd.230.1668790257887;
        Fri, 18 Nov 2022 08:50:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4tElp8nJoQLvE/hqWEoMn1u151CU6SJLh+Fi0lqoLGYR8AyP+OgUb500asOPg169mEZCCEMqafDTTt4wcsAHo=
X-Received: by 2002:a0d:cad3:0:b0:36f:d611:a5fe with SMTP id
 m202-20020a0dcad3000000b0036fd611a5femr7231956ywd.230.1668790257679; Fri, 18
 Nov 2022 08:50:57 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com> <20221118010627.70576-10-hal.feng@starfivetech.com>
In-Reply-To: <20221118010627.70576-10-hal.feng@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 18 Nov 2022 17:50:41 +0100
Message-ID: <CAJM55Z_Gq22NiVYHawvjsehL8j3agvp_b2RCgabdTki+ovWa8Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> From: Emil Renner Berthing <kernel@esmil.dk>
>
> Add bindings for the system clock and reset generator (SYSCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-syscrg.yaml         | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  2 files changed, 81 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> new file mode 100644
> index 000000000000..a8cafbc0afe2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-syscrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 System Clock and Reset Generator
> +
> +maintainers:
> +  - Emil Renner Berthing <kernel@esmil.dk>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-syscrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: RMII reference clock
> +      - description: RGMII RX clock
> +      - description: I2S TX bit clock
> +      - description: I2S TX left/right clock
> +      - description: I2S RX bit clock
> +      - description: I2S RX left/right clock
> +      - description: TDM
> +      - description: mclk

Maybe you could ask your colleagues for a better description of these clocks.

> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: gmac1_rmii_refin
> +      - const: gmac1_rgmii_rxin
> +      - const: i2stx_bclk_ext
> +      - const: i2stx_lrck_ext
> +      - const: i2srx_bclk_ext
> +      - const: i2srx_lrck_ext
> +      - const: tdm_ext
> +      - const: mclk_ext
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive-jh7110.h> for valid indices.
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/reset/starfive-jh7110.h> for valid indices.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@13020000 {
> +        compatible = "starfive,jh7110-syscrg";
> +        reg = <0x13020000 0x10000>;
> +        clocks = <&osc>, <&gmac1_rmii_refin>,
> +                 <&gmac1_rgmii_rxin>,
> +                 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
> +                 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
> +                 <&tdm_ext>, <&mclk_ext>;
> +        clock-names = "osc", "gmac1_rmii_refin",
> +                      "gmac1_rgmii_rxin",
> +                      "i2stx_bclk_ext", "i2stx_lrck_ext",
> +                      "i2srx_bclk_ext", "i2srx_lrck_ext",
> +                      "tdm_ext", "mclk_ext";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eeab26f5597c..ec6647e2772f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19602,7 +19602,7 @@ STARFIVE CLOCK DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  M:     Hal Feng <hal.feng@starfivetech.com>
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/clock/starfive,jh7100-*.yaml
> +F:     Documentation/devicetree/bindings/clock/starfive*
>  F:     drivers/clk/starfive/
>  F:     include/dt-bindings/clock/starfive*
>
> --
> 2.38.1
>
