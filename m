Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433486B2D44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCIS7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCIS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:59:01 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41596700D;
        Thu,  9 Mar 2023 10:58:51 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 318C95FD16;
        Thu,  9 Mar 2023 21:58:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1678388329;
        bh=iQKqJC+KWHFowhWmAMuZH51JLu03/9S7uIDEb1nbsBc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=m3i/BVqqs/jufZuSBQCtN9/7Nn669yDB8KcPN5JbhkHchwBDAXDipSgq18H9VegIr
         5Eit8jVWSIwqLE2PTE25cfFRQ7bRi+CcyQzUadWLYEddeCCddaVFyTjeYIgPJtlZ+a
         //FiFhQAeMQR0xXKp4faH9n5mhdDDIkNvLo+ixwZTyXreT2bvWtprJfEom3AcFRTck
         EoauM5DVCqQ3OP5sLxGyz4Dol5Ah5HuD79PUyef9Dan8XReon0XLZ2SAe1x5wf8oZw
         OgH7XcBbrD7ubkB/k87nEUxaiCY5zCzsNUOhAo8WlKaePv/NeO/TDuw2UXQMeCRS4k
         uHbePJPXKDqQA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu,  9 Mar 2023 21:58:48 +0300 (MSK)
Date:   Thu, 9 Mar 2023 21:58:48 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 4/5] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230309185848.t43jdm7aj2jkxlhx@CAB-WSD-L081021>
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-5-ddrokosov@sberdevices.ru>
 <1jilfeaync.fsf@starbuckisacylon.baylibre.com>
 <20230306190539.kl6n347kev5pskz6@CAB-WSD-L081021>
 <1jedpy0yv9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1jedpy0yv9.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/09 14:25:00 #20928723
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 03:22:08PM +0100, Jerome Brunet wrote:
> 
> On Mon 06 Mar 2023 at 22:05, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > Hello Jerome,
> >
> > Thanks a lot for such detailed review. Please find my comments and
> > thoughts below.
> >
> > On Mon, Mar 06, 2023 at 12:38:22PM +0100, Jerome Brunet wrote:
> >> 
> >> On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >> 
> >> > Introduce Peripherals clock controller for Amlogic A1 SoC family.
> >> >
> >> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> >> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >
> > [...]
> >
> >> > +static struct clk_regmap dspa_a_sel = {
> >> > +	.data = &(struct clk_regmap_mux_data){
> >> > +		.offset = DSPA_CLK_CTRL0,
> >> > +		.mask = 0x7,
> >> > +		.shift = 10,
> >> > +		.table = mux_table_dsp_ab,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data){
> >> > +		.name = "dspa_a_sel",
> >> > +		.ops = &clk_regmap_mux_ops,
> >> > +		.parent_data = dsp_ab_parent_data,
> >> > +		.num_parents = ARRAY_SIZE(dsp_ab_parent_data),
> >> > +		/* DSPA_A clk parent should be set statically from dt */
> >> > +		.flags = CLK_SET_RATE_NO_REPARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap dspa_a_div = {
> >> > +	.data = &(struct clk_regmap_div_data){
> >> > +		.offset = DSPA_CLK_CTRL0,
> >> > +		.shift = 0,
> >> > +		.width = 10,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data){
> >> > +		.name = "dspa_a_div",
> >> > +		.ops = &clk_regmap_divider_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&dspa_a_sel.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +static struct clk_regmap dspa_a = {
> >> > +	.data = &(struct clk_regmap_gate_data){
> >> > +		.offset = DSPA_CLK_CTRL0,
> >> > +		.bit_idx = 13,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "dspa_a",
> >> > +		.ops = &clk_regmap_gate_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&dspa_a_div.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		/*
> >> > +		 * DSPA_A accelerator clk, cannot be disabled by CCF if it
> >> > +		 * has been set by bootloader
> >> 
> >> Then IGNORE_UNUSED is wrong. use RO ops with you must retain the
> >> bootloader config.
> >
> > I thought UNUSED logic will disable 'unused' clock during
> > initialization. Or do you mean it's not relevant for ro ops clock,
> > because disable() callback is not defined?
> 
> It does. It does no prevent a disable if the clock is enabled then
> disabled. So what is here works as long as no driver touches this
> clock. In such case you are better off with RO ops.
> 

Okay. But for dspX clocks I'm going to listen to your suggestion and
leave this out with default parameters.

> >
> >> 
> >> Note that it is usually a bad idea to depend on the bootloader config.
> >> Things tends to go bad when other bootloader version join the fun, like
> >> upstream u-boot
> >
> > To be honest, I don't have the ability to test such behavior on our side,
> > because in my hands I have SoC SKUs w/o DSP only.
> 
> Then maybe you should leave these clocks out for now.
> 

Sure, agree.

> > But theoretically DSP FW can be started already from the bootloader, and
> > then we shouldn't touch this clock.
> 
> In theory the bootloader can do it all, why bother booting linux ... :P
> 

Exactly! It depends on your goals and motivation :-)

> > May be CCF has device tree tricks to solve such situations, don't know
> > actually. On the other hand, appropriate driver logic would be a nice
> > exit here.
> 
> If you have a DSP, it is likely to have something to communicate with
> the OS at some point, or at least monitor. Such driver would need to
> handle to clocks properly.
> 
> Since you can test this, I strongly suggest to leave this out for now.
> 

Okay, it's the best decision in such situation.

> >
> > [...]
> >
> >> > +static struct clk_regmap dspa_en_nic = {
> >> > +	.data = &(struct clk_regmap_gate_data){
> >> > +		.offset = DSPA_CLK_EN,
> >> > +		.bit_idx = 0,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "dspa_en_nic",
> >> > +		.ops = &clk_regmap_gate_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&dspa_sel.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		/*
> >> > +		 * DSPA_EN_NIC accelerator clk, cannot be disabled by CCF if it
> >> > +		 * has been set by bootloader
> >> > +		 */
> >> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> >> 
> >> All this just highlight the lack of proper drivers to handle the clock,
> >> like remote proc one.
> >> 
> >
> > Okay, let's imagine we have such a driver. If DSP is already running,
> > we can skip the clock setup on this driver side. Hmmm. It looks like
> > a proper solution...
> >
> > I would prefer to tag it with TODO and mark DSP clocks with ro_ops till
> > we don't have such a driver.
> >
> > [...]
> >
> >> > +
> >> > +static struct clk_regmap fclk_div2_divn = {
> >> > +	.data = &(struct clk_regmap_gate_data){
> >> > +		.offset = CLK12_24_CTRL,
> >> > +		.bit_idx = 12,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data){
> >> > +		.name = "fclk_div2_divn",
> >> > +		.ops = &clk_regmap_gate_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&fclk_div2_divn_pre.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		.flags = CLK_SET_RATE_PARENT,
> >> > +	},
> >> > +};
> >> > +
> >> > +/*
> >> > + * the index 2 is sys_pll_div16, it will be completed in the CPU clock ctrl,
> >> 
> >> I don't get this, what do you mean ? 
> >> 
> >
> > I mean, it will be implemented in the CPU clock controller driver in the
> > next patch series. Agree, I have to make a rephrase.
> >
> >> > + * the index 4 is the clock measurement source, it relies on
> >> > + * the clock measurement register configuration.
> >> 
> >> Obviously ... What mean here is that clock measurement is a debug
> >> feature and should be considered
> >> 
> 
> Arff sorry, "should *NOT* be considered"
> 

Yep, in the current patch (and at all I suppose) it should not be
considered. But IMHO I need to comment out why index 4 is missing.

> >
> > Should I mark it with TODO tag? I prefer to implement 'must have' logic
> > first. Clock measurement are optional from my point of view.
> >
> > [...]
> >
> >> > +static struct clk_regmap pwm_a = {
> >> > +	.data = &(struct clk_regmap_gate_data){
> >> > +		.offset = PWM_CLK_AB_CTRL,
> >> > +		.bit_idx = 8,
> >> > +	},
> >> > +	.hw.init = &(struct clk_init_data) {
> >> > +		.name = "pwm_a",
> >> > +		.ops = &clk_regmap_gate_ops,
> >> > +		.parent_hws = (const struct clk_hw *[]) {
> >> > +			&pwm_a_div.hw
> >> > +		},
> >> > +		.num_parents = 1,
> >> > +		/*
> >> > +		 * The CPU working voltage is controlled by pwm_a
> >> > +		 * in BL2 firmware. The clock is required by the platform
> >> > +		 * to operate correctly. Add the CLK_IS_CRITICAL flag to
> >> > +		 * avoid changing at runtime.
> >> > +		 * About critical, refer to sys
> >> > +		 */
> >> 
> >> PWM_A required by the BL2 ... really ? Looks really fishy to me.
> >> 
> >> Is it possible it is used by regulator instead ?
> >> 
> >
> > Honestly, this comment's information was grabbed from Amlogic custom
> > driver. It has such words:
> >
> > /*
> >  * add CLK_IGNORE_UNUSED flag for pwm controller GATE
> >  * clk core will disable unused clock, it may disable
> >  * vddcore voltage which contrlled by one pwm in bl21.
> >  * add the flag to avoid changing cpu voltage.
> >  */
> >
> > We don't have bl21 source code in the hands, so I can't check
> > unfortunately. But I have no reasons to don't trust Amlogic custom
> > clk driver decisions about low level bootloaders roles.
> 
> So it is a regulator. Not the BL2(1)
> 
> There are several reasons why this is wrong:
> * CLK_IGNORE_UNUSED would be wrong for reasons I already mentionned
> * CLK_SET_RATE_PARENT | CLK_IS_CRITICAL is not great either because
>   nothing prevents the rate to be changed to an absurdly low value, which
>   would not go well with a DVFS PWM.
> * This bakes power contraints specific to your board in the SoC clock
>   controller. Another board, another BL21 could have different
>   contraints. We can't lock all PWM clock sources. This is not
>   appropriate.
> 
> You need to properly describe your regualtors in DT.
> 

I've got deeper and checked other board configurations. Now I see what
you mean. Voltage regulations should happen using vddcpu driver and pwm
clk is used to control core voltage. Thank you for pointing me to this
architecture problem.
In the next patch I will change pwm_a flags to the default value with
CLK_SET_RATE_PARENT.

[...]

-- 
Thank you,
Dmitry
