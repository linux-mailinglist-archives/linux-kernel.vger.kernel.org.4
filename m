Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B503B680709
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjA3IJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbjA3IIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:08:30 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4842B29C;
        Mon, 30 Jan 2023 00:07:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 5065024E1ED;
        Mon, 30 Jan 2023 16:07:36 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:07:36 +0800
Received: from [192.168.125.128] (183.27.97.127) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:07:35 +0800
Message-ID: <5a34660f-63b3-e6c8-c25c-6bd74b6dd99d@starfivetech.com>
Date:   Mon, 30 Jan 2023 16:03:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 04/11] dt-bindings: clock: Add StarFive JH7110
 Image-Signal-Process clock and reset generator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
 <20230120024445.244345-5-xingyu.wu@starfivetech.com>
 <f85f5283-98b2-46b1-5a91-64ae708a6353@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <f85f5283-98b2-46b1-5a91-64ae708a6353@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.127]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/20 16:12, Krzysztof Kozlowski wrote:
> On 20/01/2023 03:44, Xingyu Wu wrote:
>> Add bindings for the Image-Signal-Process clock and reset
>> generator (ISPCRG) on the JH7110 RISC-V SoC by StarFive Ltd.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-ispcrg.yaml         | 97 +++++++++++++++++++
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 ++++
>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 +++
>>  3 files changed, 131 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
>> new file mode 100644
>> index 000000000000..32794f809364
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-ispcrg.yaml
>> @@ -0,0 +1,97 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-ispcrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Image-Signal-Process Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-ispcrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: ISP Top core
>> +      - description: ISP Top Axi
>> +      - description: NOC ISP Bus
>> +      - description: external DVP
>> +
>> +  clock-names:
>> +    items:
>> +      - const: isp_top_core
>> +      - const: isp_top_axi
>> +      - const: noc_bus_isp_axi
>> +      - const: dvp_clk
>> +
>> +  resets:
>> +    items:
>> +      - description: ISP Top core
>> +      - description: ISP Top Axi
>> +      - description: NOC ISP Bus
>> +
>> +  reset-names:
>> +    items:
>> +      - const: isp_top_core
>> +      - const: isp_top_axi
>> +      - const: noc_bus_isp_axi
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
>> +  power-domains:
>> +    maxItems: 1
>> +    description:
>> +      ISP domain power
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - resets
>> +  - reset-names
>> +  - '#clock-cells'
>> +  - '#reset-cells'
>> +  - power-domains
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/starfive,jh7110-crg.h>
>> +    #include <dt-bindings/power/starfive,jh7110-pmu.h>
>> +    #include <dt-bindings/reset/starfive,jh7110-crg.h>
>> +
>> +    ispcrg: clock-controller@19810000 {
>> +        compatible = "starfive,jh7110-ispcrg";
>> +        reg = <0x19810000 0x10000>;
>> +        clocks = <&syscrg JH7110_SYSCLK_ISP_TOP_CORE>,
>> +                 <&syscrg JH7110_SYSCLK_ISP_TOP_AXI>,
>> +                 <&syscrg JH7110_SYSCLK_NOC_BUS_ISP_AXI>,
>> +                 <&dvp_clk>;
>> +        clock-names = "isp_top_core", "isp_top_axi",
>> +                      "noc_bus_isp_axi", "dvp_clk";
>> +        resets = <&syscrg JH7110_SYSRST_ISP_TOP>,
>> +                 <&syscrg JH7110_SYSRST_ISP_TOP_AXI>,
>> +                 <&syscrg JH7110_SYSRST_NOC_BUS_ISP_AXI>;
>> +        reset-names = "isp_top_core",
>> +                      "isp_top_axi",
>> +                      "noc_bus_isp_axi";
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
>> +        power-domains = <&pwrc JH7110_PD_ISP>;
>> +    };
>> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> index 5ac8a4d90a7a..91ee589809c3 100644
>> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> @@ -256,4 +256,22 @@
>>  
>>  #define JH7110_STGCLK_END			29
>>  
>> +/* ISPCRG clocks */
>> +#define JH7110_ISPCLK_DOM4_APB_FUNC		0
>> +#define JH7110_ISPCLK_MIPI_RX0_PXL		1
>> +#define JH7110_ISPCLK_DVP_INV			2
>> +#define JH7110_ISPCLK_M31DPHY_CFGCLK_IN		3
>> +#define JH7110_ISPCLK_M31DPHY_REFCLK_IN		4
>> +#define JH7110_ISPCLK_M31DPHY_TXCLKESC_LAN0	5
>> +#define JH7110_ISPCLK_VIN_PCLK			6
>> +#define JH7110_ISPCLK_VIN_SYS_CLK		7
>> +#define JH7110_ISPCLK_VIN_PIXEL_CLK_IF0		8
>> +#define JH7110_ISPCLK_VIN_PIXEL_CLK_IF1		9
>> +#define JH7110_ISPCLK_VIN_PIXEL_CLK_IF2		10
>> +#define JH7110_ISPCLK_VIN_PIXEL_CLK_IF3		11
>> +#define JH7110_ISPCLK_VIN_CLK_P_AXIWR		12
>> +#define JH7110_ISPCLK_ISPV2_TOP_WRAPPER_CLK_C	13
>> +
>> +#define JH7110_ISPCLK_END			14
>> +
>>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
>> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> index cb70a1759482..1b40df62cdac 100644
>> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> @@ -179,4 +179,20 @@
>>  
>>  #define JH7110_STGRST_END			23
>>  
>> +/* ISPCRG resets */
>> +#define	JH7110_ISPRST_ISPV2_TOP_WRAPPER_P	0
> 
> Drop weird indentation.

Will fix.

Best regards,
Xingyu Wu

