Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8046BF7B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 05:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCREUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 00:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCREUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 00:20:04 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DE017CF6;
        Fri, 17 Mar 2023 21:20:00 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3B4F224DB8C;
        Sat, 18 Mar 2023 12:19:58 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 18 Mar
 2023 12:19:58 +0800
Received: from [172.16.16.231] (113.72.144.193) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 18 Mar
 2023 12:19:56 +0800
Message-ID: <069c0483-d536-7e66-659f-c6816fc65453@starfivetech.com>
Date:   Sat, 18 Mar 2023 12:19:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 04/21] clk: starfive: Rename "jh7100" to "jh71x0" for
 the common code
To:     Tommaso Merciai <tomm.merciai@gmail.com>
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
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
 <20230311090733.56918-5-hal.feng@starfivetech.com>
 <ZBNoaGd9l0HjFv2l@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Language: en-US
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <ZBNoaGd9l0HjFv2l@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.193]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 20:05:12 +0100, Tommaso Merciai wrote:
> Hello Hal,
> Patcht itself looks good to me, btw I have some style issue applying
> this:
> 
> On Sat, Mar 11, 2023 at 05:07:16PM +0800, Hal Feng wrote:
>> From: Emil Renner Berthing <kernel@esmil.dk>
>> 
>> Rename some variables from "jh7100" or "JH7100" to "jh71x0"
>> or "JH71X0".
>> 
>> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../clk/starfive/clk-starfive-jh7100-audio.c  |  74 ++--
>>  drivers/clk/starfive/clk-starfive-jh7100.c    | 388 +++++++++---------
>>  drivers/clk/starfive/clk-starfive-jh71x0.c    | 284 ++++++-------
>>  drivers/clk/starfive/clk-starfive-jh71x0.h    |  72 ++--
>>  4 files changed, 409 insertions(+), 409 deletions(-)
>> 
[...]
>> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> index a8ba6e25b5ce..baf4b5cb4b8a 100644
>> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
>> +++ b/drivers/clk/starfive/clk-starfive-jh71x0.h
>> @@ -1,6 +1,6 @@
>>  /* SPDX-License-Identifier: GPL-2.0 */
>> -#ifndef __CLK_STARFIVE_JH7100_H
>> -#define __CLK_STARFIVE_JH7100_H
>> +#ifndef __CLK_STARFIVE_JH71X0_H
>> +#define __CLK_STARFIVE_JH71X0_H
>>  
>>  #include <linux/bits.h>
>>  #include <linux/clk-provider.h>
>> @@ -8,107 +8,107 @@
>>  #include <linux/spinlock.h>
>>  
>>  /* register fields */
>> -#define JH7100_CLK_ENABLE	BIT(31)
>> -#define JH7100_CLK_INVERT	BIT(30)
>> -#define JH7100_CLK_MUX_MASK	GENMASK(27, 24)
>> -#define JH7100_CLK_MUX_SHIFT	24
>> -#define JH7100_CLK_DIV_MASK	GENMASK(23, 0)
>> -#define JH7100_CLK_FRAC_MASK	GENMASK(15, 8)
>> -#define JH7100_CLK_FRAC_SHIFT	8
>> -#define JH7100_CLK_INT_MASK	GENMASK(7, 0)
>> +#define JH71X0_CLK_ENABLE	BIT(31)
>> +#define JH71X0_CLK_INVERT	BIT(30)
>> +#define JH71X0_CLK_MUX_MASK	GENMASK(27, 24)
>> +#define JH71X0_CLK_MUX_SHIFT	24
>> +#define JH71X0_CLK_DIV_MASK	GENMASK(23, 0)
>> +#define JH71X0_CLK_FRAC_MASK	GENMASK(15, 8)
>> +#define JH71X0_CLK_FRAC_SHIFT	8
>> +#define JH71X0_CLK_INT_MASK	GENMASK(7, 0)
>>  
>>  /* fractional divider min/max */
>> -#define JH7100_CLK_FRAC_MIN	100UL
>> -#define JH7100_CLK_FRAC_MAX	25599UL
>> +#define JH71X0_CLK_FRAC_MIN	100UL
>> +#define JH71X0_CLK_FRAC_MAX	25599UL
>>  
>>  /* clock data */
>> -struct jh7100_clk_data {
>> +struct jh71x0_clk_data {
>>  	const char *name;
>>  	unsigned long flags;
>>  	u32 max;
>>  	u8 parents[4];
>>  };
>>  
>> -#define JH7100_GATE(_idx, _name, _flags, _parent) [_idx] = {			\
>> +#define JH71X0_GATE(_idx, _name, _flags, _parent) [_idx] = {			\
>>  	.name = _name,								\
>>  	.flags = CLK_SET_RATE_PARENT | (_flags),				\
>> -	.max = JH7100_CLK_ENABLE,						\
>> +	.max = JH71X0_CLK_ENABLE,						\
>>  	.parents = { [0] = _parent },						\
>>  }
> 
> 
> ERROR: space prohibited before open square bracket '['
> #1155: FILE: drivers/clk/starfive/clk-starfive-jh71x0.h:32:
> +#define JH71X0_GATE(_idx, _name, _flags, _parent) [_idx] = {			\
> 
> Same for others define.
> I would suggest this style.
> Hope this can help you:
> 
> #define JH71X0_GATE(_idx, _name, _flags, _parent)		\
> 	[_idx] = {						\
> 		.name = _name,					\
> 		.flags = CLK_SET_RATE_PARENT | (_flags),	\
> 		.max = JH71X0_CLK_ENABLE,			\
> 		.parents = { [0] = _parent },			\
> }
> 
> tested using:
> 
> scripts/checkpatch.pl -f drivers/clk/starfive/clk-starfive-jh71x0.h

I will fix the errors reported by checkpatch.pl in v6. Thanks.

Best regards,
Hal

> 
> 
> Thanks for your work,
> Tommaso
> 
> 
>>  
>> -#define JH7100__DIV(_idx, _name, _max, _parent) [_idx] = {			\
>> +#define JH71X0__DIV(_idx, _name, _max, _parent) [_idx] = {			\
>>  	.name = _name,								\
>>  	.flags = 0,								\
>>  	.max = _max,								\
>>  	.parents = { [0] = _parent },						\
>>  }
>>  
>> -#define JH7100_GDIV(_idx, _name, _flags, _max, _parent) [_idx] = {		\
>> +#define JH71X0_GDIV(_idx, _name, _flags, _max, _parent) [_idx] = {		\
>>  	.name = _name,								\
>>  	.flags = _flags,							\
>> -	.max = JH7100_CLK_ENABLE | (_max),					\
>> +	.max = JH71X0_CLK_ENABLE | (_max),					\
>>  	.parents = { [0] = _parent },						\
>>  }
>>  
>> -#define JH7100_FDIV(_idx, _name, _parent) [_idx] = {				\
>> +#define JH71X0_FDIV(_idx, _name, _parent) [_idx] = {				\
>>  	.name = _name,								\
>>  	.flags = 0,								\
>> -	.max = JH7100_CLK_FRAC_MAX,						\
>> +	.max = JH71X0_CLK_FRAC_MAX,						\
>>  	.parents = { [0] = _parent },						\
>>  }
>>  
>> -#define JH7100__MUX(_idx, _name, _nparents, ...) [_idx] = {			\
>> +#define JH71X0__MUX(_idx, _name, _nparents, ...) [_idx] = {			\
>>  	.name = _name,								\
>>  	.flags = 0,								\
>> -	.max = ((_nparents) - 1) << JH7100_CLK_MUX_SHIFT,			\
>> +	.max = ((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT,			\
>>  	.parents = { __VA_ARGS__ },						\
>>  }
>>  
>> -#define JH7100_GMUX(_idx, _name, _flags, _nparents, ...) [_idx] = {		\
>> +#define JH71X0_GMUX(_idx, _name, _flags, _nparents, ...) [_idx] = {		\
>>  	.name = _name,								\
>>  	.flags = _flags,							\
>> -	.max = JH7100_CLK_ENABLE |						\
>> -		(((_nparents) - 1) << JH7100_CLK_MUX_SHIFT),			\
>> +	.max = JH71X0_CLK_ENABLE |						\
>> +		(((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT),			\
>>  	.parents = { __VA_ARGS__ },						\
>>  }
>>  
>> -#define JH7100_MDIV(_idx, _name, _max, _nparents, ...) [_idx] = {		\
>> +#define JH71X0_MDIV(_idx, _name, _max, _nparents, ...) [_idx] = {		\
>>  	.name = _name,								\
>>  	.flags = 0,								\
>> -	.max = (((_nparents) - 1) << JH7100_CLK_MUX_SHIFT) | (_max),		\
>> +	.max = (((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT) | (_max),		\
>>  	.parents = { __VA_ARGS__ },						\
>>  }
>>  
>> -#define JH7100__GMD(_idx, _name, _flags, _max, _nparents, ...) [_idx] = {	\
>> +#define JH71X0__GMD(_idx, _name, _flags, _max, _nparents, ...) [_idx] = {	\
>>  	.name = _name,								\
>>  	.flags = _flags,							\
>> -	.max = JH7100_CLK_ENABLE |						\
>> -		(((_nparents) - 1) << JH7100_CLK_MUX_SHIFT) | (_max),		\
>> +	.max = JH71X0_CLK_ENABLE |						\
>> +		(((_nparents) - 1) << JH71X0_CLK_MUX_SHIFT) | (_max),		\
>>  	.parents = { __VA_ARGS__ },						\
>>  }
>>  
>> -#define JH7100__INV(_idx, _name, _parent) [_idx] = {				\
>> +#define JH71X0__INV(_idx, _name, _parent) [_idx] = {				\
>>  	.name = _name,								\
>>  	.flags = CLK_SET_RATE_PARENT,						\
>> -	.max = JH7100_CLK_INVERT,						\
>> +	.max = JH71X0_CLK_INVERT,						\
>>  	.parents = { [0] = _parent },						\
>>  }
>>  
>> -struct jh7100_clk {
>> +struct jh71x0_clk {
>>  	struct clk_hw hw;
>>  	unsigned int idx;
>>  	unsigned int max_div;
>>  };
>>  
>> -struct jh7100_clk_priv {
>> +struct jh71x0_clk_priv {
>>  	/* protect clk enable and set rate/parent from happening at the same time */
>>  	spinlock_t rmw_lock;
>>  	struct device *dev;
>>  	void __iomem *base;
>>  	struct clk_hw *pll[3];
>> -	struct jh7100_clk reg[];
>> +	struct jh71x0_clk reg[];
>>  };
>>  
>> -const struct clk_ops *starfive_jh7100_clk_ops(u32 max);
>> +const struct clk_ops *starfive_jh71x0_clk_ops(u32 max);
>>  
>>  #endif
>> -- 
>> 2.38.1
>> 

