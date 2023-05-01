Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A86F3528
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjEARnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjEARn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:43:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5851A8
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:43:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f9b9aa9d75so1575565f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682963006; x=1685555006;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=KWAQxRppuZL76jxl312jAhqOoymrs7nJ8TG4C726RtE=;
        b=CoydJabmyK6nsiu4/DyVcD32sGakdDP3vSNK7d7+Kj2YBWx8NuwQrs/vT4xv9RkZSy
         fPt7ZVFP2loG2ZtXuw4JY2V4IVHt7r8xx0rPMAfQjoGnp3vBkzB/Bb/HUmeBCCJS6e7q
         uL7bef3K1d2OKjFBLAAIr5JbAQLmfpzCBWzXUnxslBlEn0iLJqqtH6+FxGsbzxhD5ExI
         Mc507jIwmHAHedxkatF7ptCgSJP3QX0szConssBMKmGJFYWtT8SZwkAHkXooO4jnPIai
         ZmO7TPnLoppaXkt34OMamXzl67aPDR5MIG5qIZ42Dfox0SYfvCUWSPQOOZ4hbFyTcuKf
         VXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682963006; x=1685555006;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWAQxRppuZL76jxl312jAhqOoymrs7nJ8TG4C726RtE=;
        b=b1X+hE4Fb1gNMuR3GleeMQKRDR7lmYi1fW1I9Lzmx/Pjfc1G8vJpha6vXlDsZULkBs
         B/NeLwrs0p2eMcNZzICpm1qCBvA6E0Ej8GfxpSghk54W6hBIGY/NUtL4ZILKpN9yBrKZ
         u+vG8mnE9r/UBKt80HEzhIYaO1bHeFbSGeLvk/04028g4O//X4yFtlrAfo0kfRaRQjF7
         jIB/SZkldVxiiJ6Dn7ofiCWWX/R0cB6O6H8dQFSZk3uWKcs/gjna/qCa+xguaBD3Ka2M
         9GoKL+GHN/P/6zX+JagT1m0dhHXwPQJ7i1ZtsNElPSef2lPsBhIeRkwPigQXGzHwlPxM
         N4Mw==
X-Gm-Message-State: AC+VfDxQWvyp99QHzLfcYI+TucYk32rmde3L7S1yc+tHMb0T3gFxna0j
        LP4cWjGhWCdJutYe4jguAq/8nw==
X-Google-Smtp-Source: ACHHUZ41tSRIwqt4t/r56GXoMbyRL5di4OgNoAeDZuDa65UkAb7PtSfmleaf6RGcDoS3+Ui3FnRZdg==
X-Received: by 2002:adf:cc89:0:b0:304:a40c:43c3 with SMTP id p9-20020adfcc89000000b00304a40c43c3mr9973070wrj.45.1682963005887;
        Mon, 01 May 2023 10:43:25 -0700 (PDT)
Received: from localhost ([2a04:cec0:11b2:f613:c075:6ab:a69e:307d])
        by smtp.gmail.com with ESMTPSA id j14-20020adfea4e000000b002fc3d8c134bsm28854132wrn.74.2023.05.01.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:43:25 -0700 (PDT)
References: <20230417065005.24967-1-yu.tu@amlogic.com>
 <20230417065005.24967-5-yu.tu@amlogic.com>
 <20230426110538.y2d4qhv2qffc62vj@CAB-WSD-L081021>
 <6cc4c3f2-4df5-6456-fe65-71aa4a13c866@amlogic.com>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yu Tu <yu.tu@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kelvin.zhang@amlogic.com, qi.duan@amlogic.com
Subject: Re: [PATCH V7 4/4] clk: meson: s4: add support for Amlogic S4 SoC
 peripheral clock controller
Date:   Mon, 01 May 2023 19:37:58 +0200
In-reply-to: <6cc4c3f2-4df5-6456-fe65-71aa4a13c866@amlogic.com>
Message-ID: <1jpm7kuev7.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 27 Apr 2023 at 16:15, Yu Tu <yu.tu@amlogic.com> wrote:

> On 2023/4/26 19:05, Dmitry Rokosov wrote:
>> [Some people who received this message don't often get email from
>> ddrokosov@sberdevices.ru. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>> [ EXTERNAL EMAIL ]
>> On Mon, Apr 17, 2023 at 02:50:05PM +0800, Yu Tu wrote:
>>> Add the peripherals clock controller driver in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>>>   drivers/clk/meson/Kconfig          |   12 +
>>>   drivers/clk/meson/Makefile         |    1 +
>>>   drivers/clk/meson/s4-peripherals.c | 3814 ++++++++++++++++++++++++++++
>>>   drivers/clk/meson/s4-peripherals.h |  217 ++
>>>   4 files changed, 4044 insertions(+)
>>>   create mode 100644 drivers/clk/meson/s4-peripherals.c
>>>   create mode 100644 drivers/clk/meson/s4-peripherals.h
>>>
>>> diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
>>> index a663c90a3f3b..a6eb9fa15c74 100644
>>> --- a/drivers/clk/meson/Kconfig
>>> +++ b/drivers/clk/meson/Kconfig
>>> @@ -128,4 +128,16 @@ config COMMON_CLK_S4_PLL
>>>          aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>>          Say Y if you want the board to work, because plls are the parent of most
>>>          peripherals.
>>> +
>>> +config COMMON_CLK_S4
>>> +     tristate "S4 SoC Peripherals clock controllers support"
>>> +     depends on ARM64
>>> +     default y
>>> +     select COMMON_CLK_MESON_REGMAP
>>> +     select COMMON_CLK_MESON_DUALDIV
>>> +     select COMMON_CLK_MESON_VID_PLL_DIV
>>> +     help
>>> +       Support for the Peripherals clock controller on Amlogic S805X2 and S905Y4
>>> +       devices, aka s4. Amlogic S805X2 and S905Y4 devices include AQ222 and AQ229.
>>> +       Say Y if you want peripherals to work.
>>>   endmenu
>>> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
>>> index 376f49cc13f1..c9130afccb48 100644
>>> --- a/drivers/clk/meson/Makefile
>>> +++ b/drivers/clk/meson/Makefile
>>> @@ -20,3 +20,4 @@ obj-$(CONFIG_COMMON_CLK_GXBB) += gxbb.o gxbb-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_G12A) += g12a.o g12a-aoclk.o
>>>   obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o meson8-ddr.o
>>>   obj-$(CONFIG_COMMON_CLK_S4_PLL) += s4-pll.o
>>> +obj-$(CONFIG_COMMON_CLK_S4) += s4-peripherals.o
>> [...]
>
> ?
>
>> 
>>> +static struct clk_regmap s4_ceca_32k_clkin = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = CLKCTRL_CECA_CTRL0,
>>> +             .bit_idx = 31,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "ceca_32k_clkin",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_data = (const struct clk_parent_data []) {
>>> +                     { .fw_name = "xtal", }
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap s4_ceca_32k_div = {
>>> +     .data = &(struct meson_clk_dualdiv_data){
>>> +             .n1 = {
>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>> +                     .shift   = 0,
>>> +                     .width   = 12,
>>> +             },
>>> +             .n2 = {
>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>> +                     .shift   = 12,
>>> +                     .width   = 12,
>>> +             },
>>> +             .m1 = {
>>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>>> +                     .shift   = 0,
>>> +                     .width   = 12,
>>> +             },
>>> +             .m2 = {
>>> +                     .reg_off = CLKCTRL_CECA_CTRL1,
>>> +                     .shift   = 12,
>>> +                     .width   = 12,
>>> +             },
>>> +             .dual = {
>>> +                     .reg_off = CLKCTRL_CECA_CTRL0,
>>> +                     .shift   = 28,
>>> +                     .width   = 1,
>>> +             },
>>> +             .table = s4_32k_div_table,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "ceca_32k_div",
>>> +             .ops = &meson_clk_dualdiv_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_ceca_32k_clkin.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap s4_ceca_32k_sel_pre = {
>>> +     .data = &(struct clk_regmap_mux_data) {
>>> +             .offset = CLKCTRL_CECA_CTRL1,
>>> +             .mask = 0x1,
>>> +             .shift = 24,
>>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "ceca_32k_sel_pre",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_ceca_32k_div.hw,
>>> +                     &s4_ceca_32k_clkin.hw
>>> +             },
>>> +             .num_parents = 2,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap s4_ceca_32k_sel = {
>>> +     .data = &(struct clk_regmap_mux_data) {
>>> +             .offset = CLKCTRL_CECA_CTRL1,
>>> +             .mask = 0x1,
>>> +             .shift = 31,
>>> +             .flags = CLK_MUX_ROUND_CLOSEST,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "ceca_32k_sel",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_ceca_32k_sel_pre.hw,
>>> +                     &s4_rtc_clk.hw
>>> +             },
>>> +             .num_parents = 2,
>>> +             .flags = CLK_SET_RATE_PARENT,
>> In my opinion, all clocks that can inherit from a more accurate RTC clock
>> should be marked with the CLK_SET_RATE_NO_REPARENT flag.
>> This is necessary because in certain situations, it may be required to
>> freeze their parent. The setup of these clocks' parent should be located
>> on the device tree's side.
>
> We don't need to freeze parent,in a real project.

"a real project" to whom ?

Dmitry remark makes sense to me.

>
>> [...]
>> 
>>> +
>>> +/*
>>> + * gen clk is designed for debug/monitor some internal clock quality. Some of the
>>> + * corresponding clock sources are not described in the clock tree and internal clock
>>> + * for debug, so they are skipped.
>>> + */
>>> +static u32 s4_gen_clk_mux_table[] = { 0, 4, 5, 7, 19, 21, 22,
>>> +                                   23, 24, 25, 26, 27, 28 };
>>> +static const struct clk_parent_data s4_gen_clk_parent_data[] = {
>>> +     { .fw_name = "xtal", },
>>> +     { .hw = &s4_vid_pll.hw },
>>> +     { .fw_name = "gp0_pll", },
>>> +     { .fw_name = "hifi_pll", },
>>> +     { .fw_name = "fclk_div2", },
>>> +     { .fw_name = "fclk_div3", },
>>> +     { .fw_name = "fclk_div4", },
>>> +     { .fw_name = "fclk_div5", },
>>> +     { .fw_name = "fclk_div7", },
>>> +     { .fw_name = "mpll0", },
>>> +     { .fw_name = "mpll1", },
>>> +     { .fw_name = "mpll2", },
>>> +     { .fw_name = "mpll3", },
>>> +};
>>> +
>>> +static struct clk_regmap s4_gen_clk_sel = {
>>> +     .data = &(struct clk_regmap_mux_data){
>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>> +             .mask = 0x1f,
>>> +             .shift = 12,
>>> +             .table = s4_gen_clk_mux_table,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "gen_clk_sel",
>>> +             .ops = &clk_regmap_mux_ops,
>>> +             .parent_data = s4_gen_clk_parent_data,
>>> +             .num_parents = ARRAY_SIZE(s4_gen_clk_parent_data),
>> I think, the gen_clk selector should be marked with the
>> CLK_SET_RATE_NO_REPARENT flag. This is because the GEN clock can be
>> connected to an external pad and may be set up directly from the
>> device tree.
>
> This is used by the debug table clock and is not connected externally.
>

Again, Dmitry remark is very interresting.
This debug clock is typacally one you don't really want to automatically reparent

>> 
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap s4_gen_clk_div = {
>>> +     .data = &(struct clk_regmap_div_data){
>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>> +             .shift = 0,
>>> +             .width = 11,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data){
>>> +             .name = "gen_clk_div",
>>> +             .ops = &clk_regmap_divider_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_gen_clk_sel.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT,
>>> +     },
>>> +};
>>> +
>>> +static struct clk_regmap s4_gen_clk = {
>>> +     .data = &(struct clk_regmap_gate_data){
>>> +             .offset = CLKCTRL_GEN_CLK_CTRL,
>>> +             .bit_idx = 11,
>>> +     },
>>> +     .hw.init = &(struct clk_init_data) {
>>> +             .name = "gen_clk",
>>> +             .ops = &clk_regmap_gate_ops,
>>> +             .parent_hws = (const struct clk_hw *[]) {
>>> +                     &s4_gen_clk_div.hw
>>> +             },
>>> +             .num_parents = 1,
>>> +             .flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
>>> +     },
>>> +};
>>> +
>> [...]
>> --
>> Thank you,
>> Dmitry

