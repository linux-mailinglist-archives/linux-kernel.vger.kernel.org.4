Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9271D6C020B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCSN2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjCSN2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:28:16 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB819029;
        Sun, 19 Mar 2023 06:28:12 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 43CB624DC09;
        Sun, 19 Mar 2023 21:28:07 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 19 Mar
 2023 21:28:07 +0800
Received: from [172.16.16.231] (183.27.96.84) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sun, 19 Mar
 2023 21:28:06 +0800
Message-ID: <6294ffee-3c66-5287-59b4-068a7f4e84ba@starfivetech.com>
Date:   Sun, 19 Mar 2023 21:28:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 12/21] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Emil Renner Berthing" <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-13-hal.feng@starfivetech.com>
 <b9a421c0-85df-4c8c-a3cb-8286328c5ed0@spud>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <b9a421c0-85df-4c8c-a3cb-8286328c5ed0@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.84]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 13:14:45 +0000, Conor Dooley wrote:
> On Sat, Mar 11, 2023 at 05:07:24PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add bindings for the always-on clock and reset generator (AONCRG) on the
>> JH7110 RISC-V SoC by StarFive Ltd.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/starfive,jh7110-aoncrg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: StarFive JH7110 Always-On Clock and Reset Generator
>> +
>> +maintainers:
>> +  - Emil Renner Berthing <kernel@esmil.dk>
>> +
>> +properties:
>> +  compatible:
>> +    const: starfive,jh7110-aoncrg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    oneOf:
>> +      - items:
>> +          - description: Main Oscillator (24 MHz)
>> +          - description: GMAC0 RMII reference or GMAC0 RGMII RX
>> +          - description: STG AXI/AHB
>> +          - description: APB Bus
>> +          - description: GMAC0 GTX
>> +
>> +      - items:
>> +          - description: Main Oscillator (24 MHz)
>> +          - description: GMAC0 RMII reference or GMAC0 RGMII RX
>> +          - description: STG AXI/AHB or GMAC0 RGMII RX
>> +          - description: APB Bus or STG AXI/AHB
>> +          - description: GMAC0 GTX or APB Bus
>> +          - description: RTC Oscillator (32.768 kHz) or GMAC0 GTX
> 
> Something tells me that the use of "or" means we're not doing this
> correctly.
> Otherwise,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

There are two possible cases when the number of clock inputs is 6:

Main Oscillator
GMAC0 RMII reference or GMAC0 RGMII RX
STG AXI/AHB
APB Bus
GMAC0 GTX
RTC Oscillator

and

Main Oscillator
GMAC0 RMII reference
GMAC0 RGMII RX
STG AXI/AHB
APB Bus
GMAC0 GTX

So I used the "or" in the items descriptions. Thanks.

Best regards,
Hal

> 
>> +      - items:
>> +          - description: Main Oscillator (24 MHz)
>> +          - description: GMAC0 RMII reference
>> +          - description: GMAC0 RGMII RX
>> +          - description: STG AXI/AHB
>> +          - description: APB Bus
>> +          - description: GMAC0 GTX
>> +          - description: RTC Oscillator (32.768 kHz)
>> +
>> +  clock-names:
>> +    oneOf:
>> +      - minItems: 5
>> +        items:
>> +          - const: osc
>> +          - enum:
>> +              - gmac0_rmii_refin
>> +              - gmac0_rgmii_rxin
>> +          - const: stg_axiahb
>> +          - const: apb_bus
>> +          - const: gmac0_gtxclk
>> +          - const: rtc_osc
>> +
>> +      - minItems: 6
>> +        items:
>> +          - const: osc
>> +          - const: gmac0_rmii_refin
>> +          - const: gmac0_rgmii_rxin
>> +          - const: stg_axiahb
>> +          - const: apb_bus
>> +          - const: gmac0_gtxclk
>> +          - const: rtc_osc
> 

