Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66A6751A9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjATJw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjATJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:52:53 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127244BE5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:52:51 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5454683wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=FnjzLigWTWrmVYT7keQxDKaopp0We8SxlDZVkLkpEYc=;
        b=CkgI1BIZB/UVM6UII4xu7jq+VyvnfafGgTj6jesx5TVV9fBJwMW6oITwzQhWKtrHyk
         uy2yPxhzqMa5r4bm+UxhcH+fl6iTXEsXi6GI+HNlK/ao2CKpREvxU5RoR1Bh9t3AeOZX
         r+TqA9dF/GsFGNrBqh49qpoaqleQHh47gYaf9oAGojQn9bnthXK9GhnF0puo/5+z/HNr
         wJKhEq1s18AjKsEhqhQS/cuHm1+7IBtLM5pDCBJALqDMP+VPoWrI49Bs3yXwbvPoJd8G
         GWIYPcbVn1c2/TwM/B3PKALxRz7D7U5NClbZURDa2UXLeAJFG8+7ybjLNe81hJpcBDzC
         /gMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnjzLigWTWrmVYT7keQxDKaopp0We8SxlDZVkLkpEYc=;
        b=DqAWi6ZvqdgMrIznXIN+N8X70w6Q/rbTFU1iPa/zcIIgJESxjJ/ik3ml2i/ltDbe8o
         N5wOMltWwpvqJcpVy8brwBVmhlk8nOGZJEjWNIumqoMTHjns1Njp8zAOp91voH6fX6kV
         dcFNj8O4+oZwdkosZbkvMh2yh0cEZ6BDqygzcP2eUIzL226RfR8MIFj8yLO7TMoWFMoJ
         UvW0C3udXx4j9ea0IeOyP171Yc6y+U5Jnw1Rara7XIii84Ux114atusZ5IrKoQgehhpa
         SQ2C6mPz8MRpKTWsLqNmuzN9YwW0kMjLtKj7ADEwbsKP/wW6KRpWKnU5S3rjR5g2eecp
         GBwg==
X-Gm-Message-State: AFqh2ko6syUi4rmDe39VvJI9I7mO5p7K6+uPlBRRh02NVe7iaAMQwqa8
        O1gvdE9tB70lfV8fKOMEBOuKJA==
X-Google-Smtp-Source: AMrXdXup3WUxvn3YSSPPEY8ObOfbzJeR6OV0og1Ivv7BMGJZOj1s6tojl0jM8yq9LLbQWb2eu2d6fQ==
X-Received: by 2002:a05:600c:3b05:b0:3d6:b691:b80d with SMTP id m5-20020a05600c3b0500b003d6b691b80dmr13511451wms.21.1674208369487;
        Fri, 20 Jan 2023 01:52:49 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm1923545wmq.28.2023.01.20.01.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 01:52:48 -0800 (PST)
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-4-yu.tu@amlogic.com>
 <1ja62eybrv.fsf@starbuckisacylon.baylibre.com>
 <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "kelvin . zhang" <Kelvin.Zhang@amlogic.com>,
        "qi . duan" <qi.duan@amlogic.com>
Subject: Re: [PATCH V6 3/3] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Date:   Fri, 20 Jan 2023 10:47:31 +0100
In-reply-to: <aedb0764-b5cb-7f49-f279-51dbec070e80@amlogic.com>
Message-ID: <1jwn5hwn0w.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 20 Jan 2023 at 11:33, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi
> On 2023/1/19 19:37, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>> [...]
>> 
>>> +
>>> +/* Video Clocks */
>>> +static struct clk_regmap s4_vid_pll_div = {
>>> +	.data = &(struct meson_vid_pll_div_data){
>>> +		.val = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 0,
>>> +			.width   = 15,
>>> +		},
>>> +		.sel = {
>>> +			.reg_off = CLKCTRL_VID_PLL_CLK_DIV,
>>> +			.shift   = 16,
>>> +			.width   = 2,
>>> +		},
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vid_pll_div",
>>> +		/*
>>> +		 * The frequency division from the hdmi_pll clock to the vid_pll_div
>>> +		 * clock is the default value of this register. When designing the
>>> +		 * video module of the chip, a default value that can meet the
>>> +		 * requirements of the video module will be solidified according
>>> +		 * to the usage requirements of the chip, so as to facilitate chip
>>> +		 * simulation. So this is ro_ops.
>>> +		 * It is important to note that this clock is not used on this
>>> +		 * chip and is described only for the integrity of the clock tree.
>>> +		 */
>> If it is reset value and will be applicable to all the design, regarless
>> of the use-case, then yes RO ops is OK
>> 
>>>From what I understand here, the value will depend on the use-case requirements.
>> This is a typical case where the DT prop "assigned-rate" should be used, not RO ops.
>
> Check the previous chip history, the actual scene is not used at all,
> basically is used in simulation. So the previous SOC was "ro_ops" without
> any problems.  This S4 SOC is not actually useful either.
>
> So when you were upstream, you had no problem making "ro_ops". I wonder if
> I could delete this useless clock, so you don't have to worry about it.

I don't know what to make of this. What is the point of adding a useless
clock ?

>
>> 
>>> +		.ops = &meson_vid_pll_div_ro_ops,
>>> +		.parent_data = (const struct clk_parent_data []) {
>>> +			{ .fw_name = "hdmi_pll", }
>>> +		},
>>> +		.num_parents = 1,
>>> +		.flags = CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> 
>>> +
>>> +/* VDEC clocks */
>>> +static const struct clk_parent_data s4_dec_parent_data[] = {
>>> +	{ .fw_name = "fclk_div2p5", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div5", },
>>> +	{ .fw_name = "fclk_div7", },
>>> +	{ .fw_name = "hifi_pll", },
>>> +	{ .fw_name = "gp0_pll", },
>>> +	{ .fw_name = "xtal", }
>>> +};
>>> +
>>> +static struct clk_regmap s4_vdec_p0_mux = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_VDEC_CLK_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 9,
>>> +		.flags = CLK_MUX_ROUND_CLOSEST,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vdec_p0_mux",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_dec_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_dec_parent_data),
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>> s/patent/parent ?
>> s/he wants/it requires ?
>
> Okay.
>
>> 
>>> +		 */
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> [...]
>> 
>>> +static const struct clk_parent_data s4_vpu_clkc_parent_data[] = {
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "fclk_div5", },
>>> +	{ .fw_name = "fclk_div7", },
>>> +	{ .fw_name = "mpll1", },
>>> +	{ .hw = &s4_vid_pll.hw },
>>> +	{ .fw_name = "mpll2", },
>>> +	{ .fw_name = "gp0_pll", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_vpu_clkc_p0_mux  = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_VPU_CLKC_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 9,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "vpu_clkc_p0_mux",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_vpu_clkc_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_vpu_clkc_parent_data),
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>>> +		 */
>> That's quite a lot of occurences of the same comment.
>> At the same time, other clocks with the same flag have no comment.
>> Please make general comment, before the Video/VPU section, explaining
>> which clocks needs on a use-case basis (through DT) and possibly how it
>> should be set, what should drive the choices.
>> 
>
> The owner of the corresponding driver module wants to have a fixed clock,
> but I can't explain every specific reason.

Why can't you ?

> So I'm going to change it all
> to.flags = CLK_SET_RATE_PARENT in the next version. Let CCF choose the
> appropriate clock as you suggested. If there is a corresponding module you
> want to change, ask him to give you a specific explanation. Do you think
> that's all right?

If the flag is actually required and there is a reason, no it is not.

>
> I will not reply to you below.

Noted.

>
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> 
>>> +
>>> +/* EMMC/NAND clock */
>>> +static const struct clk_parent_data s4_sd_emmc_clk0_parent_data[] = {
>>> +	{ .fw_name = "xtal", },
>>> +	{ .fw_name = "fclk_div2", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "hifi_pll", },
>>> +	{ .fw_name = "fclk_div2p5", },
>>> +	{ .fw_name = "mpll2", },
>>> +	{ .fw_name = "mpll3", },
>>> +	{ .fw_name = "gp0_pll", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_sd_emmc_c_clk0_sel = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_NAND_CLK_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 9,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "sd_emmc_c_clk0_sel",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_sd_emmc_clk0_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_sd_emmc_clk0_parent_data),
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>>> +		 */
>> I'm getting a bit suspicious about the use (and abuse ...) of this flag.
>> I don't quite get how selecting the base PLL for MMC should be done on
>> use-case basis and should be up the board DT ...
>> Other SoC have all used fdiv2 so far. Do you expect this setting to be
>> part of the dtsi SoC file ?
>> 
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> 
>>> +
>>> +/* SPICC Clock */
>>> +static const struct clk_parent_data s4_spicc_parent_data[] = {
>>> +	{ .fw_name = "xtal", },
>>> +	{ .hw = &s4_sys_clk.hw },
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +	{ .fw_name = "fclk_div2", },
>>> +	{ .fw_name = "fclk_div5", },
>>> +	{ .fw_name = "fclk_div7", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_spicc0_mux = {
>>> +	.data = &(struct clk_regmap_mux_data){
>>> +		.offset = CLKCTRL_SPICC_CLK_CTRL,
>>> +		.mask = 0x7,
>>> +		.shift = 7,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data) {
>>> +		.name = "spicc0_mux",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_spicc_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_spicc_parent_data),
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>>> +		 */
>> This is getting too far. All the parent clocks are fixed.
>> Let CCF do the job of picking the most adequate clock for the job
>> instead of manually settings things
>> 
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> 
>>> +
>>> +/* PWM Clock */
>>> +static const struct clk_parent_data s4_pwm_parent_data[] = {
>>> +	{ .fw_name = "xtal", },
>>> +	{ .hw = &s4_vid_pll.hw },
>>> +	{ .fw_name = "fclk_div4", },
>>> +	{ .fw_name = "fclk_div3", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_pwm_a_mux = {
>>> +	.data = &(struct clk_regmap_mux_data) {
>>> +		.offset = CLKCTRL_PWM_CLK_AB_CTRL,
>>> +		.mask = 0x3,
>>> +		.shift = 9,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "pwm_a_mux",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = s4_pwm_parent_data,
>>> +		.num_parents = ARRAY_SIZE(s4_pwm_parent_data),
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>>> +		 */
>> Same here ... this is really going to far.
>> 
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>>> +
>> 
>>> +
>>> +static struct clk_regmap s4_saradc_mux = {
>>> +	.data = &(struct clk_regmap_mux_data) {
>>> +		.offset = CLKCTRL_SAR_CLK_CTRL,
>>> +		.mask = 0x3,
>>> +		.shift = 9,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "saradc_mux",
>>> +		.ops = &clk_regmap_mux_ops,
>>> +		.parent_data = (const struct clk_parent_data []) {
>>> +			{ .fw_name = "xtal", },
>>> +			{ .hw = &s4_sys_clk.hw },
>>> +		},
>>> +		.num_parents = 2,
>>> +		/*
>>> +		 * When the driver uses this clock, needs to specify the patent clock
>>> +		 * he wants in the dts.
>>> +		 */
>> For each clock type, if this flag is going to be used, I'd like a clear
>> explanation about why it is use-case dependent and why you need manual
>> control over this. Same applies to all the occurence.
>> 
>>> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT,
>>> +	},
>>> +};
>> 

