Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF3674F2F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjATILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjATIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:11:28 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBC18386C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:11:26 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b5so4154747wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3y5bgWWrzFBKiTAVfD/q/RFhwhvhK/bT8FSQul1BAQ=;
        b=W1sxXu9q7uxD4iIWO7Kb9dE0J4Zwxs6wlwCRzOVMjVSUYR2UciE615O6THnHAQrDUg
         bD20zJCmfngWfeiV8lnVgtVhw8Chq5prNWZLI5UngJLG/V80IU9dy6R9Jyclear1zznz
         Qfg+W9R64fjuoVRPj2qaEPh4Bsbsbi1HcGY9YDeBN71C9Q6WTong+j8QU2VDn64Tcxnq
         c5mVJfdmpE27Ko5c35173yrPh3nQi/SbH09akESt1p1Cqm/AnH2zpDEVx6pYC6MlcQYj
         d+MMsDNTa4vRRz5IToIced7cMPFf+OzIt6sHC0W0OGmw/pgduo9MnGHyO0b2ZAtCOGBY
         fJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3y5bgWWrzFBKiTAVfD/q/RFhwhvhK/bT8FSQul1BAQ=;
        b=MdzknAIMVEQcf+hhzQQMs1DEuVSYtyHTaQUzMTS2Y6g9PiJKESaNUp7VMkXI0Eydq3
         erCByQ4Z3LrV3PwqMaBiCqzEVkq7o76PbrPijmLmSZz4yW9vY1t/B9jGgkefw+lGKnEQ
         qWAKs+vr6cvzrbmNVhmMSE1DK9PUvlw/rbjo+e+GJcyr62uyln1kwC2L9XJVt+48kw0R
         riOCpKdaM6/jq4xeC8uorGXc3IYPE1plmVcvnQOnXeJAlisPholib4ryHUZ2QrN0k40d
         iQQTcXe/hdMuyaS3ph42PG3Ix33hVxhSIe0y78esueV2psxJgIjvJv5AjXOGKeZZm3lA
         coHg==
X-Gm-Message-State: AFqh2koR0PTd1M8+CsFgENyXAlq0uV5qn+YgXzIUaPVVPeiTOjc0Obzm
        tTQxyDY5dDjYt0YZNzdxIwxE6g==
X-Google-Smtp-Source: AMrXdXu4sfjM6OyMOBfqghTyWMCoiGQ/ty1zrdbSxtzmzApA1b2TuJ+QBR+1d8jAIQqVv7T9qygphA==
X-Received: by 2002:adf:f791:0:b0:29d:f817:42c1 with SMTP id q17-20020adff791000000b0029df81742c1mr12223149wrp.54.1674202285148;
        Fri, 20 Jan 2023 00:11:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q23-20020adfb197000000b002be5bdbe40csm835886wra.27.2023.01.20.00.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:11:24 -0800 (PST)
Message-ID: <fd54fb94-ca9b-42a2-9de7-5cc6c87f410f@linaro.org>
Date:   Fri, 20 Jan 2023 09:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 01/11] dt-bindings: clock: Add StarFive JH7110
 System-Top-Group clock and reset generator
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
Cc:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
 <20230120024445.244345-2-xingyu.wu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230120024445.244345-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 03:44, Xingyu Wu wrote:
> Add bindings for the System-Top-Group clock and reset generator (STGCRG)
> on the JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
>  4 files changed, 146 insertions(+)
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
> index 84fd7054cb6e..20243eb5470c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19635,6 +19635,7 @@ F:	arch/riscv/boot/dts/starfive/
>  STARFIVE JH71X0 CLOCK DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>

Not related, drop from this patch.

>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
>  F:	drivers/clk/starfive/clk-starfive-jh71*
> @@ -19654,6 +19655,7 @@ F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
>  STARFIVE JH71X0 RESET CONTROLLER DRIVERS
>  M:	Emil Renner Berthing <kernel@esmil.dk>
>  M:	Hal Feng <hal.feng@starfivetech.com>
> +M:	Xingyu Wu <xingyu.wu@starfivetech.com>

Not related.

>  S:	Maintained
>  F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
>  F:	drivers/reset/starfive/reset-starfive-jh71*
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
>  #define JH7110_AONCLK_END			14
>  
> +/* STGCRG clocks */
> +#define JH7110_STGCLK_HIFI4_CLK_CORE		0
> +#define JH7110_STGCLK_USB0_APB			1
> +#define JH7110_STGCLK_USB0_UTMI_APB		2
> +#define JH7110_STGCLK_USB0_AXI			3
> +#define JH7110_STGCLK_USB0_LPM			4
> +#define JH7110_STGCLK_USB0_STB			5
> +#define JH7110_STGCLK_USB0_APP_125		6
> +#define JH7110_STGCLK_USB0_REFCLK		7
> +#define JH7110_STGCLK_PCIE0_AXI_MST0		8
> +#define JH7110_STGCLK_PCIE0_APB			9
> +#define JH7110_STGCLK_PCIE0_TL			10
> +#define JH7110_STGCLK_PCIE1_AXI_MST0		11
> +#define JH7110_STGCLK_PCIE1_APB			12
> +#define JH7110_STGCLK_PCIE1_TL			13
> +#define JH7110_STGCLK_PCIE01_SLV_DEC_MAINCLK	14
> +#define JH7110_STGCLK_SEC_HCLK			15
> +#define JH7110_STGCLK_SEC_MISCAHB		16
> +#define JH7110_STGCLK_GRP0_MAIN			17
> +#define JH7110_STGCLK_GRP0_BUS			18
> +#define JH7110_STGCLK_GRP0_STG			19
> +#define JH7110_STGCLK_GRP1_MAIN			20
> +#define JH7110_STGCLK_GRP1_BUS			21
> +#define JH7110_STGCLK_GRP1_STG			22
> +#define JH7110_STGCLK_GRP1_HIFI			23
> +#define JH7110_STGCLK_E2_RTC			24
> +#define JH7110_STGCLK_E2_CORE			25
> +#define JH7110_STGCLK_E2_DBG			26
> +#define JH7110_STGCLK_DMA1P_AXI			27
> +#define JH7110_STGCLK_DMA1P_AHB			28
> +
> +#define JH7110_STGCLK_END			29
> +
>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
> index d78e38690ceb..cb70a1759482 100644
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
>  #define JH7110_AONRST_END			8
>  
> +/* STGCRG resets */
> +#define	JH7110_STGRST_SYSCON			0

Drop weird indentation.


Best regards,
Krzysztof

