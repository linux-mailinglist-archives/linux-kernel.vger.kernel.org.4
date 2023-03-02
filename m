Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C316A84E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCBPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjCBPFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:05:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3877E457C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 07:05:42 -0800 (PST)
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 296D53F11D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677769540;
        bh=ennINZICblkLNJRKAL6C7ysXY/vpm4KR2muFA6qF6vI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EZyd6UebuPiuudYZItBUpKLm87N5nanSwg54SBSo+D6K/6xS1F9xMpfiBKPwVu08Q
         9idxxiJBRDzs7CZzLgbPT3R2xSyvgDchBGb7xGLqt1joXsrGv/bQUMnl1aQBahhOFt
         FLRD2IWc/GbpxwjsFgLfJ5Lc1WCStUSfc9YiHG01z57zjM+gyf47zIu3NYRYw7kDlX
         el29ib94TxhnwBUMZnDDXo+X/VgZKAVNL0fhcw8uCvI6MoQCO9xRg5KJP88kgYHi7i
         KJ4VuQz0so4n4Lq4z56VnPxjiD1/+hnY0dUBSlMTFxniJnHNu2Q2g0t+7s6LTMCfqS
         PwWyWjER4jVNA==
Received: by mail-qv1-f69.google.com with SMTP id l13-20020ad44d0d000000b004c74bbb0affso8914515qvl.21
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 07:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677769539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ennINZICblkLNJRKAL6C7ysXY/vpm4KR2muFA6qF6vI=;
        b=1H7QDCpbFgC3Lru1nSc5WQN0f3xOwGbR1crq4m9GKnLVuvS1q8JRzTuUlqHEHy/U8Y
         JVVlbS8SmLPW/98RsS8VMHkjpLM73Y5inrEJ6J4YqHbsm5SS+xw0cZWpVigushsanost
         vfCUNuJ3N/yLPcEZpy3YrE257KvezLwBqYnxGejpDzKVNQrxjaV9/8jE9QJxKUGWR7Aw
         XxtRMY/oG70PIXN2qi3ZT2F+tBxnwLiTfB467gHUDhL4k+iwbObo4ctEiLHTJPYcoruL
         BIjd/9ZNnBOxmkLMHCmzqVtFHTfxniDptYE/YrmhFMkSU/rKZ0gFNJyZvse9Ot+I+wpH
         h6bQ==
X-Gm-Message-State: AO0yUKVyGN7HANFIwYEgCFrbNTksE2wQHDzr7cp4sHr2UfxggGTmyGjb
        wyCNOM3rtGheVmaC4kFvnyrJm7xzngyunMMKMrU1lsWJdGlOR1KH0i05IkzfF0+4JsjM5bShLpI
        SOHa92wU2fLbRC1KW79QHeu6lCNgL14LQyjVWVn/hMkORuFUqtHLhPxyi/A==
X-Received: by 2002:a37:4385:0:b0:721:5339:2c89 with SMTP id q127-20020a374385000000b0072153392c89mr2581674qka.7.1677769539182;
        Thu, 02 Mar 2023 07:05:39 -0800 (PST)
X-Google-Smtp-Source: AK7set/wLIZz+wN48cyx3bobDbJlcRdqTIx95pf2ooXaqJzdzUrI6PfTcx9xyTHMIuV8BHgY8aHD9TzSIKUGk43rNDo=
X-Received: by 2002:a37:4385:0:b0:721:5339:2c89 with SMTP id
 q127-20020a374385000000b0072153392c89mr2581660qka.7.1677769538838; Thu, 02
 Mar 2023 07:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com> <20230221083323.302471-2-xingyu.wu@starfivetech.com>
In-Reply-To: <20230221083323.302471-2-xingyu.wu@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Thu, 2 Mar 2023 16:05:22 +0100
Message-ID: <CAJM55Z_O+Gh0RGaAuLPxs4aSi4=5Aa3UksN_SnU-4pOn3X5fDw@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] dt-bindings: clock: Add StarFive JH7110
 System-Top-Group clock and reset generator
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
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

On Tue, 21 Feb 2023 at 09:37, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
> Add bindings for the System-Top-Group clock and reset generator (STGCRG)
> on the JH7110 RISC-V SoC by StarFive Ltd.
>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
>  4 files changed, 145 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
> new file mode 100644
> index 000000000000..b64ccd84200a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-stgcrg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 System-Top-Group Clock and Reset Generator
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-stgcrg
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Main Oscillator (24 MHz)
> +      - description: HIFI4 core
> +      - description: STG AXI/AHB
> +      - description: USB (125 MHz)
> +      - description: CPU Bus
> +      - description: HIFI4 Axi
> +      - description: NOC STG Bus
> +      - description: APB Bus
> +
> +  clock-names:
> +    items:
> +      - const: osc
> +      - const: hifi4_core
> +      - const: stg_axiahb
> +      - const: usb_125m
> +      - const: cpu_bus
> +      - const: hifi4_axi
> +      - const: nocstg_bus
> +      - const: apb_bus
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
> +
> +  '#reset-cells':
> +    const: 1
> +    description:
> +      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
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
> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
> +
> +    stgcrg: clock-controller@10230000 {
> +        compatible = "starfive,jh7110-stgcrg";
> +        reg = <0x10230000 0x10000>;
> +        clocks = <&osc>,
> +                 <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
> +                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
> +                 <&syscrg JH7110_SYSCLK_USB_125M>,
> +                 <&syscrg JH7110_SYSCLK_CPU_BUS>,
> +                 <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
> +                 <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
> +                 <&syscrg JH7110_SYSCLK_APB_BUS>;
> +        clock-names = "osc", "hifi4_core",
> +                      "stg_axiahb", "usb_125m",
> +                      "cpu_bus", "hifi4_axi",
> +                      "nocstg_bus", "apb_bus";
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93eb504c3b21..2e70c9f21989 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19914,6 +19914,7 @@ F:      arch/riscv/boot/dts/starfive/
>  STARFIVE JH71X0 CLOCK DRIVERS
>  M:     Emil Renner Berthing <kernel@esmil.dk>
>  M:     Hal Feng <hal.feng@starfivetech.com>
> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
>  F:     drivers/clk/starfive/clk-starfive-jh71*
> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
> index 5e4f21ca0642..5ac8a4d90a7a 100644
> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>  /*
>   * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright 2022 StarFive Technology Co., Ltd.
>   */
>
>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
> @@ -222,4 +223,37 @@
>
>  #define JH7110_AONCLK_END                      14

Hi Xingyu,

The clock and reset names below have been shortened from the very long
names in the documentation. I see you've come to the same shortened
names as I used in the first STGCRG driver I pushed, which is great,
but I find it highly unlikely to have happened without looking at /
copying my code like you did for the SYSCRG and AONCRG drivers Hal has
posted. Unfortunately the commit message above doesn't reflect that,
so please add a
Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

I do have some updated suggestions for short names below though:

> +/* STGCRG clocks */
> +#define JH7110_STGCLK_HIFI4_CLK_CORE           0
> +#define JH7110_STGCLK_USB0_APB                 1
> +#define JH7110_STGCLK_USB0_UTMI_APB            2 unli
> +#define JH7110_STGCLK_USB0_AXI                 3
> +#define JH7110_STGCLK_USB0_LPM                 4
> +#define JH7110_STGCLK_USB0_STB                 5
> +#define JH7110_STGCLK_USB0_APP_125             6
> +#define JH7110_STGCLK_USB0_REFCLK              7
> +#define JH7110_STGCLK_PCIE0_AXI_MST0           8
> +#define JH7110_STGCLK_PCIE0_APB                        9
> +#define JH7110_STGCLK_PCIE0_TL                 10
> +#define JH7110_STGCLK_PCIE1_AXI_MST0           11
> +#define JH7110_STGCLK_PCIE1_APB                        12
> +#define JH7110_STGCLK_PCIE1_TL                 13
> +#define JH7110_STGCLK_PCIE01_SLV_DEC_MAINCLK   14

Does PCIE01 here mean that the clock is used by both pcie0 and pcie1?
If so then maybe just call it JH7110_PCIE_SLV_MAIN

> +#define JH7110_STGCLK_SEC_HCLK                 15

For other clocks I think "hclk" means ahb clock, so maybe JH7110_STGCLK_SEC_AHB

> +#define JH7110_STGCLK_SEC_MISCAHB              16

I find something like JH7110_STGCLK_SEC_MISC_AHB a little easier to read.

> +#define JH7110_STGCLK_GRP0_MAIN                        17
> +#define JH7110_STGCLK_GRP0_BUS                 18
> +#define JH7110_STGCLK_GRP0_STG                 19
> +#define JH7110_STGCLK_GRP1_MAIN                        20
> +#define JH7110_STGCLK_GRP1_BUS                 21
> +#define JH7110_STGCLK_GRP1_STG                 22
> +#define JH7110_STGCLK_GRP1_HIFI                        23
> +#define JH7110_STGCLK_E2_RTC                   24
> +#define JH7110_STGCLK_E2_CORE                  25
> +#define JH7110_STGCLK_E2_DBG                   26
> +#define JH7110_STGCLK_DMA1P_AXI                        27
> +#define JH7110_STGCLK_DMA1P_AHB                        28
> +
> +#define JH7110_STGCLK_END                      29
> +
>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
> index d78e38690ceb..4a865ded78b8 100644
> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>  /*
>   * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>   */
>
>  #ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
> @@ -151,4 +152,31 @@
>
>  #define JH7110_AONRST_END                      8
>
> +/* STGCRG resets */
> +#define JH7110_STGRST_SYSCON                   0
> +#define JH7110_STGRST_HIFI4_CORE               1
> +#define JH7110_STGRST_HIFI4_AXI                        2
> +#define JH7110_STGRST_SEC_TOP_HRESETN          3

JH7110_STGRST_SEC_AHB to match the clock above.

> +#define JH7110_STGRST_E24_CORE                 4
> +#define JH7110_STGRST_DMA1P_AXI                        5
> +#define JH7110_STGRST_DMA1P_AHB                        6
> +#define JH7110_STGRST_USB0_AXI                 7
> +#define JH7110_STGRST_USB0_APB                 8
> +#define JH7110_STGRST_USB0_UTMI_APB            9
> +#define JH7110_STGRST_USB0_PWRUP               10
> +#define JH7110_STGRST_PCIE0_AXI_MST0           11
> +#define JH7110_STGRST_PCIE0_AXI_SLV0           12
> +#define JH7110_STGRST_PCIE0_AXI_SLV            13
> +#define JH7110_STGRST_PCIE0_BRG                        14
> +#define JH7110_STGRST_PCIE0_CORE               15
> +#define JH7110_STGRST_PCIE0_APB                        16
> +#define JH7110_STGRST_PCIE1_AXI_MST0           17
> +#define JH7110_STGRST_PCIE1_AXI_SLV0           18
> +#define JH7110_STGRST_PCIE1_AXI_SLV            19
> +#define JH7110_STGRST_PCIE1_BRG                        20
> +#define JH7110_STGRST_PCIE1_CORE               21
> +#define JH7110_STGRST_PCIE1_APB                        22
> +
> +#define JH7110_STGRST_END                      23
> +
>  #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
