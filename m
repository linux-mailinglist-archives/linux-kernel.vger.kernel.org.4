Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259FE6A8FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCCDOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:14:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCCDOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:14:12 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758E144AF;
        Thu,  2 Mar 2023 19:14:08 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id F37B324E401;
        Fri,  3 Mar 2023 11:13:54 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 11:13:54 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Mar
 2023 11:13:53 +0800
Message-ID: <190f5d4b-77dd-8c2b-0d23-33f717fc1562@starfivetech.com>
Date:   Fri, 3 Mar 2023 11:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 01/11] dt-bindings: clock: Add StarFive JH7110
 System-Top-Group clock and reset generator
Content-Language: en-US
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
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
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-2-xingyu.wu@starfivetech.com>
 <CAJM55Z_O+Gh0RGaAuLPxs4aSi4=5Aa3UksN_SnU-4pOn3X5fDw@mail.gmail.com>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <CAJM55Z_O+Gh0RGaAuLPxs4aSi4=5Aa3UksN_SnU-4pOn3X5fDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/2 23:05, Emil Renner Berthing wrote:
> On Tue, 21 Feb 2023 at 09:37, Xingyu Wu <xingyu.wu@starfivetech.com> wrote:
>> Add bindings for the System-Top-Group clock and reset generator (STGCRG)
>> on the JH7110 RISC-V SoC by StarFive Ltd.
>>
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-stgcrg.yaml         | 82 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 34 ++++++++
>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 28 +++++++
>>  4 files changed, 145 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>> new file mode 100644
>> index 000000000000..b64ccd84200a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-stgcrg.yaml
>> @@ -0,0 +1,82 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-stgcrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 System-Top-Group Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-stgcrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Main Oscillator (24 MHz)
>> +      - description: HIFI4 core
>> +      - description: STG AXI/AHB
>> +      - description: USB (125 MHz)
>> +      - description: CPU Bus
>> +      - description: HIFI4 Axi
>> +      - description: NOC STG Bus
>> +      - description: APB Bus
>> +
>> +  clock-names:
>> +    items:
>> +      - const: osc
>> +      - const: hifi4_core
>> +      - const: stg_axiahb
>> +      - const: usb_125m
>> +      - const: cpu_bus
>> +      - const: hifi4_axi
>> +      - const: nocstg_bus
>> +      - const: apb_bus
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/clock/starfive,jh7110-crg.h> for valid indices.
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +    description:
>> +      See <dt-bindings/reset/starfive,jh7110-crg.h> for valid indices.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +
>> +    stgcrg: clock-controller@10230000 {
>> +        compatible = "starfive,jh7110-stgcrg";
>> +        reg = <0x10230000 0x10000>;
>> +        clocks = <&osc>,
>> +                 <&syscrg JH7110_SYSCLK_HIFI4_CORE>,
>> +                 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
>> +                 <&syscrg JH7110_SYSCLK_USB_125M>,
>> +                 <&syscrg JH7110_SYSCLK_CPU_BUS>,
>> +                 <&syscrg JH7110_SYSCLK_HIFI4_AXI>,
>> +                 <&syscrg JH7110_SYSCLK_NOCSTG_BUS>,
>> +                 <&syscrg JH7110_SYSCLK_APB_BUS>;
>> +        clock-names = "osc", "hifi4_core",
>> +                      "stg_axiahb", "usb_125m",
>> +                      "cpu_bus", "hifi4_axi",
>> +                      "nocstg_bus", "apb_bus";
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 93eb504c3b21..2e70c9f21989 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19914,6 +19914,7 @@ F:      arch/riscv/boot/dts/starfive/
>>  STARFIVE JH71X0 CLOCK DRIVERS
>>  M:     Emil Renner Berthing <kernel@esmil.dk>
>>  M:     Hal Feng <hal.feng@starfivetech.com>
>> +M:     Xingyu Wu <xingyu.wu@starfivetech.com>
>>  S:     Maintained
>>  F:     Documentation/devicetree/bindings/clock/starfive,jh71*.yaml
>>  F:     drivers/clk/starfive/clk-starfive-jh71*
>> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> index 5e4f21ca0642..5ac8a4d90a7a 100644
>> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> @@ -1,6 +1,7 @@
>>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>>  /*
>>   * Copyright 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright 2022 StarFive Technology Co., Ltd.
>>   */
>>
>>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>> @@ -222,4 +223,37 @@
>>
>>  #define JH7110_AONCLK_END                      14
> 
> Hi Xingyu,
> 
> The clock and reset names below have been shortened from the very long
> names in the documentation. I see you've come to the same shortened
> names as I used in the first STGCRG driver I pushed, which is great,
> but I find it highly unlikely to have happened without looking at /
> copying my code like you did for the SYSCRG and AONCRG drivers Hal has
> posted. Unfortunately the commit message above doesn't reflect that,
> so please add a
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

Thanks. But these STG/ISP/VOUT drivers are transplanted from 7110-SDK wrote
by myself one year ago and followed 7100 clock drivers framework and structure
at that time. And I haven't seen your STGCRG driver before. I improved these
to follow these SYSCRG and AONCRG drivers' framework. So you could look like copying
your code but these are still little different like these clock and reset name.

But I don't know if I am right. I follow your code framework to write it and
I should add 'Co-developed-by' and 'Signed-off-by' to reflect that. It that right?

> 
> I do have some updated suggestions for short names below though:
> 
>> +/* STGCRG clocks */
>> +#define JH7110_STGCLK_HIFI4_CLK_CORE           0
>> +#define JH7110_STGCLK_USB0_APB                 1
>> +#define JH7110_STGCLK_USB0_UTMI_APB            2 unli
>> +#define JH7110_STGCLK_USB0_AXI                 3
>> +#define JH7110_STGCLK_USB0_LPM                 4
>> +#define JH7110_STGCLK_USB0_STB                 5
>> +#define JH7110_STGCLK_USB0_APP_125             6
>> +#define JH7110_STGCLK_USB0_REFCLK              7
>> +#define JH7110_STGCLK_PCIE0_AXI_MST0           8
>> +#define JH7110_STGCLK_PCIE0_APB                        9
>> +#define JH7110_STGCLK_PCIE0_TL                 10
>> +#define JH7110_STGCLK_PCIE1_AXI_MST0           11
>> +#define JH7110_STGCLK_PCIE1_APB                        12
>> +#define JH7110_STGCLK_PCIE1_TL                 13
>> +#define JH7110_STGCLK_PCIE01_SLV_DEC_MAINCLK   14
> 
> Does PCIE01 here mean that the clock is used by both pcie0 and pcie1?
> If so then maybe just call it JH7110_PCIE_SLV_MAIN

Yes, it is used by both pcie0 and pcie1. Will modify it.

> 
>> +#define JH7110_STGCLK_SEC_HCLK                 15
> 
> For other clocks I think "hclk" means ahb clock, so maybe JH7110_STGCLK_SEC_AHB

Will modify it.

> 
>> +#define JH7110_STGCLK_SEC_MISCAHB              16
> 
> I find something like JH7110_STGCLK_SEC_MISC_AHB a little easier to read.

Will modify it.

> 
>> +#define JH7110_STGCLK_GRP0_MAIN                        17
>> +#define JH7110_STGCLK_GRP0_BUS                 18
>> +#define JH7110_STGCLK_GRP0_STG                 19
>> +#define JH7110_STGCLK_GRP1_MAIN                        20
>> +#define JH7110_STGCLK_GRP1_BUS                 21
>> +#define JH7110_STGCLK_GRP1_STG                 22
>> +#define JH7110_STGCLK_GRP1_HIFI                        23
>> +#define JH7110_STGCLK_E2_RTC                   24
>> +#define JH7110_STGCLK_E2_CORE                  25
>> +#define JH7110_STGCLK_E2_DBG                   26
>> +#define JH7110_STGCLK_DMA1P_AXI                        27
>> +#define JH7110_STGCLK_DMA1P_AHB                        28
>> +
>> +#define JH7110_STGCLK_END                      29
>> +
>>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
>> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> index d78e38690ceb..4a865ded78b8 100644
>> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> @@ -1,6 +1,7 @@
>>  /* SPDX-License-Identifier: GPL-2.0 OR MIT */
>>  /*
>>   * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>>   */
>>
>>  #ifndef __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__
>> @@ -151,4 +152,31 @@
>>
>>  #define JH7110_AONRST_END                      8
>>
>> +/* STGCRG resets */
>> +#define JH7110_STGRST_SYSCON                   0
>> +#define JH7110_STGRST_HIFI4_CORE               1
>> +#define JH7110_STGRST_HIFI4_AXI                        2
>> +#define JH7110_STGRST_SEC_TOP_HRESETN          3
> 
> JH7110_STGRST_SEC_AHB to match the clock above.

Will modify it.

> 
>> +#define JH7110_STGRST_E24_CORE                 4
>> +#define JH7110_STGRST_DMA1P_AXI                        5
>> +#define JH7110_STGRST_DMA1P_AHB                        6
>> +#define JH7110_STGRST_USB0_AXI                 7
>> +#define JH7110_STGRST_USB0_APB                 8
>> +#define JH7110_STGRST_USB0_UTMI_APB            9
>> +#define JH7110_STGRST_USB0_PWRUP               10
>> +#define JH7110_STGRST_PCIE0_AXI_MST0           11
>> +#define JH7110_STGRST_PCIE0_AXI_SLV0           12
>> +#define JH7110_STGRST_PCIE0_AXI_SLV            13
>> +#define JH7110_STGRST_PCIE0_BRG                        14
>> +#define JH7110_STGRST_PCIE0_CORE               15
>> +#define JH7110_STGRST_PCIE0_APB                        16
>> +#define JH7110_STGRST_PCIE1_AXI_MST0           17
>> +#define JH7110_STGRST_PCIE1_AXI_SLV0           18
>> +#define JH7110_STGRST_PCIE1_AXI_SLV            19
>> +#define JH7110_STGRST_PCIE1_BRG                        20
>> +#define JH7110_STGRST_PCIE1_CORE               21
>> +#define JH7110_STGRST_PCIE1_APB                        22
>> +
>> +#define JH7110_STGRST_END                      23
>> +
>>  #endif /* __DT_BINDINGS_RESET_STARFIVE_JH7110_CRG_H__ */
>> --
>> 2.25.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

Best regards
