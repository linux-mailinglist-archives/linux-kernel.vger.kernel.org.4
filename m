Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A90680733
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbjA3IPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjA3IP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:15:26 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0E1024C;
        Mon, 30 Jan 2023 00:15:06 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id ECE7224E1ED;
        Mon, 30 Jan 2023 16:14:24 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:14:25 +0800
Received: from [192.168.125.128] (183.27.97.127) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:14:23 +0800
Message-ID: <ce15c2be-e959-334a-2297-cfbb6bc2d62f@starfivetech.com>
Date:   Mon, 30 Jan 2023 16:10:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 07/11] dt-bindings: clock: Add StarFive JH7110
 Video-Output clock and reset generator
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
 <20230120024445.244345-8-xingyu.wu@starfivetech.com>
 <428dc119-82ab-e565-7bd6-1a99ec3967d9@linaro.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <428dc119-82ab-e565-7bd6-1a99ec3967d9@linaro.org>
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

On 2023/1/20 16:13, Krzysztof Kozlowski wrote:
> On 20/01/2023 03:44, Xingyu Wu wrote:
>> Add bindings for the Video-Output clock and reset generator (VOUTCRG)
>> on the JH7110 RISC-V SoC by StarFive Ltd.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-voutcrg.yaml        | 96 +++++++++++++++++++
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 22 +++++
>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 16 ++++
>>  3 files changed, 134 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>> new file mode 100644
>> index 000000000000..a6a43d86a392
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
>> @@ -0,0 +1,96 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-voutcrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Video-Output Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-voutcrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Vout Top core
>> +      - description: Vout Top Ahb
>> +      - description: Vout Top Axi
>> +      - description: Vout Top HDMI MCLK
>> +      - description: I2STX0 BCLK
>> +      - description: external HDMI pixel
>> +
>> +  clock-names:
>> +    items:
>> +      - const: vout_src
>> +      - const: vout_top_ahb
>> +      - const: vout_top_axi
>> +      - const: vout_top_hdmitx0_mclk
>> +      - const: i2stx0_bclk
>> +      - const: hdmitx0_pixelclk
>> +
>> +  resets:
>> +    items:
>> +      - description: Vout Top core
>> +
>> +  reset-names:
>> +    items:
>> +      - const: vout_top_src
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
>> +      Vout domain power
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
>> +    voutcrg: clock-controller@295C0000 {
>> +        compatible = "starfive,jh7110-voutcrg";
>> +        reg = <0x295C0000 0x10000>;
>> +        clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
>> +                 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
>> +                 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
>> +                 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
>> +                 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
>> +                 <&hdmitx0_pixelclk>;
>> +        clock-names = "vout_src", "vout_top_ahb",
>> +                      "vout_top_axi", "vout_top_hdmitx0_mclk",
>> +                      "i2stx0_bclk", "hdmitx0_pixelclk";
>> +        resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
>> +        reset-names = "vout_top_src";
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
>> +        power-domains = <&pwrc JH7110_PD_VOUT>;
>> +    };
>> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> index 91ee589809c3..3ebece93cbd3 100644
>> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> @@ -274,4 +274,26 @@
>>  
>>  #define JH7110_ISPCLK_END			14
>>  
>> +/* VOUTCRG clocks */
>> +#define JH7110_VOUTCLK_APB			0
>> +#define JH7110_VOUTCLK_DC8200_PIX		1
>> +#define JH7110_VOUTCLK_DSI_SYS			2
>> +#define JH7110_VOUTCLK_TX_ESC			3
>> +#define JH7110_VOUTCLK_DC8200_AXI		4
>> +#define JH7110_VOUTCLK_DC8200_CORE		5
>> +#define JH7110_VOUTCLK_DC8200_AHB		6
>> +#define JH7110_VOUTCLK_DC8200_PIX0		7
>> +#define JH7110_VOUTCLK_DC8200_PIX1		8
>> +#define JH7110_VOUTCLK_DOM_VOUT_TOP_LCD		9
>> +#define JH7110_VOUTCLK_DSITX_APB		10
>> +#define JH7110_VOUTCLK_DSITX_SYS		11
>> +#define JH7110_VOUTCLK_DSITX_DPI		12
>> +#define JH7110_VOUTCLK_DSITX_TXESC		13
>> +#define JH7110_VOUTCLK_MIPITX_DPHY_TXESC	14
>> +#define JH7110_VOUTCLK_HDMI_TX_MCLK		15
>> +#define JH7110_VOUTCLK_HDMI_TX_BCLK		16
>> +#define JH7110_VOUTCLK_HDMI_TX_SYS		17
>> +
>> +#define JH7110_VOUTCLK_END			18
>> +
>>  #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__ */
>> diff --git a/include/dt-bindings/reset/starfive,jh7110-crg.h b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> index 1b40df62cdac..f89589610cf5 100644
>> --- a/include/dt-bindings/reset/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/reset/starfive,jh7110-crg.h
>> @@ -195,4 +195,20 @@
>>  
>>  #define JH7110_ISPRST_END			12
>>  
>> +/* VOUTCRG resets */
>> +#define	JH7110_VOUTRST_DC8200_AXI		0
>> +#define	JH7110_VOUTRST_DC8200_AHB		1
> 
> Ditto

Will fix.

Best regards,
Xingyu Wu

