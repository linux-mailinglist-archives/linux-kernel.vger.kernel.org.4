Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437A26B6DED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCMDWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCMDWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:22:37 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2E27D64;
        Sun, 12 Mar 2023 20:22:35 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id B9B5724E1D2;
        Mon, 13 Mar 2023 11:22:33 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 11:22:33 +0800
Received: from [192.168.125.74] (183.27.96.115) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 13 Mar
 2023 11:22:32 +0800
Message-ID: <92306b73-d7d2-0d60-de15-87bcd71714ed@starfivetech.com>
Date:   Mon, 13 Mar 2023 11:22:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 11/21] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
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
 <20230311090733.56918-12-hal.feng@starfivetech.com>
 <34b0473a-91bd-453b-91dd-01defde92d68@spud>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <34b0473a-91bd-453b-91dd-01defde92d68@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS061.cuchost.com (172.16.6.21) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 13:11:38 +0000, Conor Dooley wrote:
> On Sat, Mar 11, 2023 at 05:07:23PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Add bindings for the system clock and reset generator (SYSCRG) on the
>> JH7110 RISC-V SoC by StarFive Ltd.
>> 
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../clock/starfive,jh7110-syscrg.yaml         | 104 +++++++++
>>  MAINTAINERS                                   |   8 +-
>>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 203 ++++++++++++++++++
>>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 142 ++++++++++++
>>  4 files changed, 454 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>>  create mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
>>  create mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>> 
>> diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> new file mode 100644
>> index 000000000000..84373ae31644
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
> 
>> +  clock-names:
>> +    oneOf:
>> +      - items:
>> +          - const: osc
>> +          - enum:
>> +              - gmac1_rmii_refin
>> +              - gmac1_rgmii_rxin
>> +          - const: i2stx_bclk_ext
>> +          - const: i2stx_lrck_ext
>> +          - const: i2srx_bclk_ext
>> +          - const: i2srx_lrck_ext
>> +          - const: tdm_ext
>> +          - const: mclk_ext
>> +
>> +      - items:
>> +          - const: osc
>> +          - const: gmac1_rmii_refin
>> +          - const: gmac1_rgmii_rxin
>> +          - const: i2stx_bclk_ext
>> +          - const: i2stx_lrck_ext
>> +          - const: i2srx_bclk_ext
>> +          - const: i2srx_lrck_ext
>> +          - const: tdm_ext
>> +          - const: mclk_ext
> 
> Assuming nothing else here is optional,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Yeah, nothing else here is optional. Thanks for your review.

Best regards,
Hal
