Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF7F6A0609
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjBWKXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjBWKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:23:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905F3AB0;
        Thu, 23 Feb 2023 02:23:00 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1D09424E289;
        Thu, 23 Feb 2023 18:22:59 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 18:22:59 +0800
Received: from [192.168.125.82] (113.72.147.165) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 18:22:57 +0800
Message-ID: <04e071d8-3195-d065-d33f-ef81e3fcfb22@starfivetech.com>
Date:   Thu, 23 Feb 2023 18:22:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v4 09/19] dt-bindings: clock: Add StarFive JH7110 system
 clock and reset generator
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, Stephen Boyd <sboyd@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        <linux-kernel@vger.kernel.org>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <20230221024645.127922-10-hal.feng@starfivetech.com>
 <e4c2b711-7953-821b-4281-04e4b40154ea@linaro.org> <Y/XxOw+T0WdYY7jP@wendy>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <Y/XxOw+T0WdYY7jP@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.147.165]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 10:40:59 +0000, Conor Dooley wrote:
> On Wed, Feb 22, 2023 at 10:13:19AM +0100, Krzysztof Kozlowski wrote:
>> On 21/02/2023 03:46, Hal Feng wrote:
>> > From: Emil Renner Berthing <kernel@esmil.dk>
>> > 
>> > Add bindings for the system clock and reset generator (SYSCRG) on the
>> > JH7110 RISC-V SoC by StarFive Ltd.
>> > 
>> > Reviewed-by: Rob Herring <robh@kernel.org>
>> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> 
>> I don't know what is happening here as neither this nor other patchset
>> explains anything. Please stop writing what you do in the patches, but
>> explain why. What is easy to get.
>> 
>> (...)
>> 
>> 
>> > +
>> > +#define JH7110_SYSCLK_PLL0_OUT			190
>> > +#define JH7110_SYSCLK_PLL1_OUT			191
>> > +#define JH7110_SYSCLK_PLL2_OUT			192
>> 
>> NAK. Do not add incorrect bindings just to remove it THE SAME TIME.
> 
> For some context, the PLL driver series [1] does the following, which is
> where this complaint stems from:
>> diff --git a/include/dt-bindings/clock/starfive,jh7110-crg.h b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> index 5e4f21ca0642..086a6ddcf380 100644
>> --- a/include/dt-bindings/clock/starfive,jh7110-crg.h
>> +++ b/include/dt-bindings/clock/starfive,jh7110-crg.h
>> @@ -6,6 +6,12 @@
>>  #ifndef __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>>  #define __DT_BINDINGS_CLOCK_STARFIVE_JH7110_CRG_H__
>>  
>> +/* PLL clocks */
>> +#define JH7110_CLK_PLL0_OUT			0
>> +#define JH7110_CLK_PLL1_OUT			1
>> +#define JH7110_CLK_PLL2_OUT			2
>> +#define JH7110_PLLCLK_END			3
>> +
>>  /* SYSCRG clocks */
>>  #define JH7110_SYSCLK_CPU_ROOT			0
>>  #define JH7110_SYSCLK_CPU_CORE			1
>> @@ -198,11 +204,7 @@
>>  #define JH7110_SYSCLK_TDM_TDM_INV		188
>>  #define JH7110_SYSCLK_JTAG_CERTIFICATION_TRNG	189
>>  
>> -#define JH7110_SYSCLK_PLL0_OUT			190
>> -#define JH7110_SYSCLK_PLL1_OUT			191
>> -#define JH7110_SYSCLK_PLL2_OUT			192
> 
> I was talking to Emil, who pointed out that these defines aren't
> actually ever used in the dts, so there's nothing really gained
> by adding them here in the first place.
> Seems like this series could simply move these defines into the driver
> (as the PLL addition series also does) and then we would not have to
> be worried about breaking the ABI in the future?

Sorry for that I didn't synchronize this with Xingyu. I'll move these
PLL definitions into the driver in the next version.

Best regards,
Hal

> 
> 1 - https://patchwork.kernel.org/project/linux-riscv/patch/20230221141147.303642-3-xingyu.wu@starfivetech.com/
> 

