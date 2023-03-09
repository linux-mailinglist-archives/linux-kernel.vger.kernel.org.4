Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CEB6B2733
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjCIOnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCIOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:43:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3115925960
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:43:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k37so1331357wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678372987;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=q0gj1G9cUcUIZ/a+kpKcCgPzLsFmLDLjCJhAsi47XLs=;
        b=1Fk4F6F3ag7qaE7C4ql023KSpas6Bbillm4A3fFYoeC2LDAhbH1mvC+A0Il9qt+W8J
         fMfaPt7vIa0hkIwrBufZ2S/9rvV0H/Qanq+g8yDU8ZYJ6KapnNMuz9jP/7efmeTOE+bm
         KogUqS5ZYnxpRQB2P6Scxcgbf1UfaxzDLGL16ip0URyTdFKdJ4Zg3eTPmlChi/qdB9FG
         1zXH3/jPKnU4yAkVTIqb4o0/7wAg0ekrl6n+88Zg0Z5K1sD0w1eGlhb7Jf5cO5sDxUfe
         +ss6tKMXJYuHuTcrpd1AJWCgR/roD5hMjm0MGmtOYqNiq8PGKjmcHPluO6JvddZEcCKp
         aUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372987;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0gj1G9cUcUIZ/a+kpKcCgPzLsFmLDLjCJhAsi47XLs=;
        b=suiNSyxQJ48gLbekVvuoxy9hWM1Ig5u/3qlA3fmNO+dJuLFga22zmT9pMoDudEZoYr
         RxPXwUnLqHCQaKFLgVg737vHRhdHZA+Y9jmbkHT7ncF/Elq5lBopg94Qtk6uoSwLcWNs
         TUN9B2RlenYelLJslkw0WIaGXvrNSQWgXRLaTt5h29aBfLEBoUHlhmyJbfolkRLxtrRW
         0YoWovTTGPL74DH7XGBGg9J1wfkIgQaX2xUn1OuJs4KG82wYuRdjLlFRxQDgGl5dS9c+
         qGLUfsU1a11hSJOVIqJQYy6ghzTEbCh25Fkc7UdvLeYZKqBxn3NHBpxuEZNg0poVVdqG
         5D1Q==
X-Gm-Message-State: AO0yUKV1TktOkPcMgkPYWNwtjd+swxV2Rndmi6vTb9p25QGSRSKAof0B
        PtLo5mL1phakP0CSg9mmPP4eTA==
X-Google-Smtp-Source: AK7set8ArfCbj6486s273Ry+S4Gc7m3Z1lE13ELk+BWOmqUuT7//+LeeBL/rhwgneoZ9OZZK+JbCMQ==
X-Received: by 2002:a05:600c:3544:b0:3e8:35a2:6abf with SMTP id i4-20020a05600c354400b003e835a26abfmr19132181wmq.23.1678372987571;
        Thu, 09 Mar 2023 06:43:07 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w17-20020adfd4d1000000b002c6d0462163sm18070580wrk.100.2023.03.09.06.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:43:07 -0800 (PST)
References: <20230301183759.16163-1-ddrokosov@sberdevices.ru>
 <20230301183759.16163-5-ddrokosov@sberdevices.ru>
 <1jilfeaync.fsf@starbuckisacylon.baylibre.com>
 <20230306190539.kl6n347kev5pskz6@CAB-WSD-L081021>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, jian.hu@amlogic.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 4/5] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Date:   Thu, 09 Mar 2023 15:22:08 +0100
In-reply-to: <20230306190539.kl6n347kev5pskz6@CAB-WSD-L081021>
Message-ID: <1jedpy0yv9.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 06 Mar 2023 at 22:05, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Hello Jerome,
>
> Thanks a lot for such detailed review. Please find my comments and
> thoughts below.
>
> On Mon, Mar 06, 2023 at 12:38:22PM +0100, Jerome Brunet wrote:
>> 
>> On Wed 01 Mar 2023 at 21:37, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>> 
>> > Introduce Peripherals clock controller for Amlogic A1 SoC family.
>> >
>> > Signed-off-by: Jian Hu <jian.hu@amlogic.com>
>> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
>
> [...]
>
>> > +static struct clk_regmap dspa_a_sel = {
>> > +	.data = &(struct clk_regmap_mux_data){
>> > +		.offset = DSPA_CLK_CTRL0,
>> > +		.mask = 0x7,
>> > +		.shift = 10,
>> > +		.table = mux_table_dsp_ab,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "dspa_a_sel",
>> > +		.ops = &clk_regmap_mux_ops,
>> > +		.parent_data = dsp_ab_parent_data,
>> > +		.num_parents = ARRAY_SIZE(dsp_ab_parent_data),
>> > +		/* DSPA_A clk parent should be set statically from dt */
>> > +		.flags = CLK_SET_RATE_NO_REPARENT,
>> > +	},
>> > +};
>> > +
>> > +static struct clk_regmap dspa_a_div = {
>> > +	.data = &(struct clk_regmap_div_data){
>> > +		.offset = DSPA_CLK_CTRL0,
>> > +		.shift = 0,
>> > +		.width = 10,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "dspa_a_div",
>> > +		.ops = &clk_regmap_divider_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&dspa_a_sel.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		.flags = CLK_SET_RATE_PARENT,
>> > +	},
>> > +};
>> > +
>> > +static struct clk_regmap dspa_a = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = DSPA_CLK_CTRL0,
>> > +		.bit_idx = 13,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data) {
>> > +		.name = "dspa_a",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&dspa_a_div.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * DSPA_A accelerator clk, cannot be disabled by CCF if it
>> > +		 * has been set by bootloader
>> 
>> Then IGNORE_UNUSED is wrong. use RO ops with you must retain the
>> bootloader config.
>
> I thought UNUSED logic will disable 'unused' clock during
> initialization. Or do you mean it's not relevant for ro ops clock,
> because disable() callback is not defined?

It does. It does no prevent a disable if the clock is enabled then
disabled. So what is here works as long as no driver touches this
clock. In such case you are better off with RO ops.

>
>> 
>> Note that it is usually a bad idea to depend on the bootloader config.
>> Things tends to go bad when other bootloader version join the fun, like
>> upstream u-boot
>
> To be honest, I don't have the ability to test such behavior on our side,
> because in my hands I have SoC SKUs w/o DSP only.

Then maybe you should leave these clocks out for now.

> But theoretically DSP FW can be started already from the bootloader, and
> then we shouldn't touch this clock.

In theory the bootloader can do it all, why bother booting linux ... :P

> May be CCF has device tree tricks to solve such situations, don't know
> actually. On the other hand, appropriate driver logic would be a nice
> exit here.

If you have a DSP, it is likely to have something to communicate with
the OS at some point, or at least monitor. Such driver would need to
handle to clocks properly.

Since you can test this, I strongly suggest to leave this out for now.

>
> [...]
>
>> > +static struct clk_regmap dspa_en_nic = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = DSPA_CLK_EN,
>> > +		.bit_idx = 0,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data) {
>> > +		.name = "dspa_en_nic",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&dspa_sel.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * DSPA_EN_NIC accelerator clk, cannot be disabled by CCF if it
>> > +		 * has been set by bootloader
>> > +		 */
>> > +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>> 
>> All this just highlight the lack of proper drivers to handle the clock,
>> like remote proc one.
>> 
>
> Okay, let's imagine we have such a driver. If DSP is already running,
> we can skip the clock setup on this driver side. Hmmm. It looks like
> a proper solution...
>
> I would prefer to tag it with TODO and mark DSP clocks with ro_ops till
> we don't have such a driver.
>
> [...]
>
>> > +
>> > +static struct clk_regmap fclk_div2_divn = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = CLK12_24_CTRL,
>> > +		.bit_idx = 12,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data){
>> > +		.name = "fclk_div2_divn",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&fclk_div2_divn_pre.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		.flags = CLK_SET_RATE_PARENT,
>> > +	},
>> > +};
>> > +
>> > +/*
>> > + * the index 2 is sys_pll_div16, it will be completed in the CPU clock ctrl,
>> 
>> I don't get this, what do you mean ? 
>> 
>
> I mean, it will be implemented in the CPU clock controller driver in the
> next patch series. Agree, I have to make a rephrase.
>
>> > + * the index 4 is the clock measurement source, it relies on
>> > + * the clock measurement register configuration.
>> 
>> Obviously ... What mean here is that clock measurement is a debug
>> feature and should be considered
>> 

Arff sorry, "should *NOT* be considered"

>
> Should I mark it with TODO tag? I prefer to implement 'must have' logic
> first. Clock measurement are optional from my point of view.
>
> [...]
>
>> > +static struct clk_regmap pwm_a = {
>> > +	.data = &(struct clk_regmap_gate_data){
>> > +		.offset = PWM_CLK_AB_CTRL,
>> > +		.bit_idx = 8,
>> > +	},
>> > +	.hw.init = &(struct clk_init_data) {
>> > +		.name = "pwm_a",
>> > +		.ops = &clk_regmap_gate_ops,
>> > +		.parent_hws = (const struct clk_hw *[]) {
>> > +			&pwm_a_div.hw
>> > +		},
>> > +		.num_parents = 1,
>> > +		/*
>> > +		 * The CPU working voltage is controlled by pwm_a
>> > +		 * in BL2 firmware. The clock is required by the platform
>> > +		 * to operate correctly. Add the CLK_IS_CRITICAL flag to
>> > +		 * avoid changing at runtime.
>> > +		 * About critical, refer to sys
>> > +		 */
>> 
>> PWM_A required by the BL2 ... really ? Looks really fishy to me.
>> 
>> Is it possible it is used by regulator instead ?
>> 
>
> Honestly, this comment's information was grabbed from Amlogic custom
> driver. It has such words:
>
> /*
>  * add CLK_IGNORE_UNUSED flag for pwm controller GATE
>  * clk core will disable unused clock, it may disable
>  * vddcore voltage which contrlled by one pwm in bl21.
>  * add the flag to avoid changing cpu voltage.
>  */
>
> We don't have bl21 source code in the hands, so I can't check
> unfortunately. But I have no reasons to don't trust Amlogic custom
> clk driver decisions about low level bootloaders roles.

So it is a regulator. Not the BL2(1)

There are several reasons why this is wrong:
* CLK_IGNORE_UNUSED would be wrong for reasons I already mentionned
* CLK_SET_RATE_PARENT | CLK_IS_CRITICAL is not great either because
  nothing prevents the rate to be changed to an absurdly low value, which
  would not go well with a DVFS PWM.
* This bakes power contraints specific to your board in the SoC clock
  controller. Another board, another BL21 could have different
  contraints. We can't lock all PWM clock sources. This is not
  appropriate.

You need to properly describe your regualtors in DT.

>
> [...]
>
>> > +static int meson_a1_periphs_probe(struct platform_device *pdev)
>> > +{
>> > +	struct device *dev = &pdev->dev;
>> > +	struct clk_hw *hw;
>> > +	void __iomem *base;
>> > +	struct regmap *map;
>> > +	int clkid, i, err;
>> > +
>> > +	base = devm_platform_ioremap_resource(pdev, 0);
>> > +	if (IS_ERR(base))
>> > +		return dev_err_probe(dev, PTR_ERR(base),
>> > +				     "can't ioremap resource\n");
>> > +
>> > +	map = devm_regmap_init_mmio(dev, base, &a1_periphs_regmap_cfg);
>> > +	if (IS_ERR(map))
>> > +		return dev_err_probe(dev, PTR_ERR(map),
>> > +				     "can't init regmap mmio region\n");
>> > +
>> > +	/* Populate regmap for the regmap backed clocks */
>> > +	for (i = 0; i < ARRAY_SIZE(a1_periphs_regmaps); i++)
>> > +		a1_periphs_regmaps[i]->map = map;
>> > +
>> > +	for (clkid = 0; clkid < a1_periphs_hw_onecell_data.num; clkid++) {
>> > +		hw = a1_periphs_hw_onecell_data.hws[clkid];
>> > +		err = devm_clk_hw_register(dev, hw);
>> > +		if (err)
>> > +			return dev_err_probe(dev, err,
>> > +					     "clock registration failed\n");
>> > +	}
>> > +
>> > +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> > +					   &a1_periphs_hw_onecell_data);
>> > +}
>> > +
>> > +#ifdef CONFIG_OF
>> 
>> Same as the PLL driver
>> 
>
> Sure, good point.
>
> [...]

