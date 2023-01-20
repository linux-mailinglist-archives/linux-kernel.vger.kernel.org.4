Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FDC675175
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjATJqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjATJqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:46:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B07AF17
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:46:08 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so4294671wrz.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 01:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=nsY3N5w/OcuIb37vMvk7tYxNViydXZA0c/CHmVvoNOo=;
        b=CLZIyAwQPLhK2AxK27j6A6njGog/a2p4aS79YR9wE4GKVD+dwv/7AlHUBNt8aQsIGo
         /cQH9GianjLCNV9/ankI533Tm3aUqjyjEKh5g2/Ut0g/Ee/sQ21/Ww48Ya0G2z4vSkTA
         /3LQrIEDUN0SfJL48+K2Dx2+8MO6JqU+ShhlgcvtbAqV7/Z3rf7zE3AYbJSYK7a/daqn
         YyM+cneeVpNvpm0sgUCpVkp7IYAKwXpv23Iw7mOawy4pE6HdnLVinEM+fDDR0q0nA0Wv
         iMQ8OKyVx5EP5gAqFGTXWx2tQu848yqiAqs7yqy5/n6TYRRRqnevZyIiiIFamyhkGVSQ
         +bEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsY3N5w/OcuIb37vMvk7tYxNViydXZA0c/CHmVvoNOo=;
        b=JjzdJLuEhCa3xIgRi1x6Z8XtvbosNjYklW49s09obt9BOnW4ODN3kwBCSy/4oA6nMC
         Se3HkEipEODdULT3u/O1iExXUpFXR1E5QXcw3pmbBEuLi4LovDlyW1Qi3qjztcHnTUp1
         fshcLCNpfEwP2uBr1xjwVMnSPhEJg9y5l1dJt2ninUS3Du4m6WlV5Cx5uCQykc3O6c7/
         MOnEhAybiQfjhh89Ly4dmNWNiCaHpplMxMMbsRreU270jhHE3TAk987S6FxM77gKx+Qr
         UE0W79Kj1mR5J2LDxAk8H/83tW4sQmSfQg6Ka2RTi69XsgfBrbLO1K1tDJ3se42djDGD
         NfJA==
X-Gm-Message-State: AFqh2krEKyqwf3H0PxgV5my4G52d8tyQCc7ZNhVbZ5K/k9VEZ8g0KwGf
        +9Rwcg6RcauttHSFw+ME30shgQ==
X-Google-Smtp-Source: AMrXdXvyT9hQzOoOVCprmqSF4N4hkPCiVWjbkYVZURild1qzZrpIlziAHbPHLBqJQPPZmE9kvU1gEw==
X-Received: by 2002:a05:6000:1a8f:b0:2be:3fa7:ab4e with SMTP id f15-20020a0560001a8f00b002be3fa7ab4emr6333419wry.38.1674207966518;
        Fri, 20 Jan 2023 01:46:06 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q12-20020adff50c000000b002bc83b85180sm637714wro.114.2023.01.20.01.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 01:46:05 -0800 (PST)
References: <20230116074214.2326-1-yu.tu@amlogic.com>
 <20230116074214.2326-3-yu.tu@amlogic.com>
 <1jedrqyd3w.fsf@starbuckisacylon.baylibre.com>
 <55659095-86d7-91b6-2db6-5cdca228bc09@amlogic.com>
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
Subject: Re: [PATCH V6 2/3] clk: meson: S4: add support for Amlogic S4 SoC
 PLL clock driver
Date:   Fri, 20 Jan 2023 10:43:24 +0100
In-reply-to: <55659095-86d7-91b6-2db6-5cdca228bc09@amlogic.com>
Message-ID: <1j1qnpy1wh.fsf@starbuckisacylon.baylibre.com>
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


On Fri 20 Jan 2023 at 10:58, Yu Tu <yu.tu@amlogic.com> wrote:

> Hi Jerome,
>
> On 2023/1/19 19:20, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Mon 16 Jan 2023 at 15:42, Yu Tu <yu.tu@amlogic.com> wrote:
>> 
>>> Add the S4 PLL clock controller driver in the s4 SoC family.
>>>
>>> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
>>> ---
>> [...]
>> 
>>> +
>>> +static struct clk_regmap s4_fclk_div2 = {
>>> +	.data = &(struct clk_regmap_gate_data){
>>> +		.offset = ANACTRL_FIXPLL_CTRL1,
>>> +		.bit_idx = 24,
>>> +	},
>>> +	.hw.init = &(struct clk_init_data){
>>> +		.name = "fclk_div2",
>>> +		.ops = &clk_regmap_gate_ro_ops,
>> On the previous SoC, these fixed divider gate were not read-only.
>> They are marked as critical when necessary, with the appropriate
>> comment.
>> Why is it different on the s4 ?
>
> In fact, this part of the SOC is no different from the previous G12a/b and
> so on.
>
> I remember that my first version was made according to G12A, and I changed
> this way under your suggestion.
>
> Maybe you were busy and forgot. For me, this mode and the previous g12a
> mode function is ok. I can do either. So now how do you decide to go that
> way?

No I did not forgot.
I told you that cannot put CRITICAL (or IGNORE_USED) without explaining
why. I stand by this. Same goes for RO ops. 

>
>> 
>>> +		.parent_hws = (const struct clk_hw *[]) {
>>> +			&s4_fclk_div2_div.hw
>>> +		},
>>> +		.num_parents = 1,
>>> +	},
>>> +};
>>> +
>> [...]
>> 
>>> +#ifndef __MESON_S4_PLL_H__
>>> +#define __MESON_S4_PLL_H__
>>> +
>>> +/* ANA_CTRL - Registers
>>> + * REG_BASE:  REGISTER_BASE_ADDR = 0xfe008000
>> This multi-line comment style is wrong in clk/
>> REG_BASE is not used so I'm not sure this is useful
>
> I will remove REG_BASE and  change this format in next version.
>
>> 
>>> + */
>>> +#define ANACTRL_FIXPLL_CTRL0                       0x040
>>> +#define ANACTRL_FIXPLL_CTRL1                       0x044
>>> +#define ANACTRL_FIXPLL_CTRL2                       0x048
>>> +#define ANACTRL_FIXPLL_CTRL3                       0x04c
>>> +#define ANACTRL_FIXPLL_CTRL4                       0x050
>>> +#define ANACTRL_FIXPLL_CTRL5                       0x054
>>> +#define ANACTRL_FIXPLL_CTRL6                       0x058
>>> +#define ANACTRL_FIXPLL_STS                         0x05c
>>> +#define ANACTRL_GP0PLL_CTRL0                       0x080
>>> +#define ANACTRL_GP0PLL_CTRL1                       0x084
>>> +#define ANACTRL_GP0PLL_CTRL2                       0x088
>>> +#define ANACTRL_GP0PLL_CTRL3                       0x08c
>>> +#define ANACTRL_GP0PLL_CTRL4                       0x090
>>> +#define ANACTRL_GP0PLL_CTRL5                       0x094
>>> +#define ANACTRL_GP0PLL_CTRL6                       0x098
>>> +#define ANACTRL_GP0PLL_STS                         0x09c
>>> +#define ANACTRL_HIFIPLL_CTRL0                      0x100
>>> +#define ANACTRL_HIFIPLL_CTRL1                      0x104
>>> +#define ANACTRL_HIFIPLL_CTRL2                      0x108
>>> +#define ANACTRL_HIFIPLL_CTRL3                      0x10c
>>> +#define ANACTRL_HIFIPLL_CTRL4                      0x110
>>> +#define ANACTRL_HIFIPLL_CTRL5                      0x114
>>> +#define ANACTRL_HIFIPLL_CTRL6                      0x118
>>> +#define ANACTRL_HIFIPLL_STS                        0x11c
>>> +#define ANACTRL_MPLL_CTRL0                         0x180
>>> +#define ANACTRL_MPLL_CTRL1                         0x184
>>> +#define ANACTRL_MPLL_CTRL2                         0x188
>>> +#define ANACTRL_MPLL_CTRL3                         0x18c
>>> +#define ANACTRL_MPLL_CTRL4                         0x190
>>> +#define ANACTRL_MPLL_CTRL5                         0x194
>>> +#define ANACTRL_MPLL_CTRL6                         0x198
>>> +#define ANACTRL_MPLL_CTRL7                         0x19c
>>> +#define ANACTRL_MPLL_CTRL8                         0x1a0
>>> +#define ANACTRL_MPLL_STS                           0x1a4
>>> +#define ANACTRL_HDMIPLL_CTRL0                      0x1c0
>>> +#define ANACTRL_HDMIPLL_CTRL1                      0x1c4
>>> +#define ANACTRL_HDMIPLL_CTRL2                      0x1c8
>>> +#define ANACTRL_HDMIPLL_CTRL3                      0x1cc
>>> +#define ANACTRL_HDMIPLL_CTRL4                      0x1d0
>>> +#define ANACTRL_HDMIPLL_CTRL5                      0x1d4
>>> +#define ANACTRL_HDMIPLL_CTRL6                      0x1d8
>>> +#define ANACTRL_HDMIPLL_STS                        0x1dc
>>> +#define ANACTRL_HDMIPLL_VLOCK                      0x1e4
>>> +
>>> +/*
>>> + * CLKID index values
>>> + *
>>> + * These indices are entirely contrived and do not map onto the hardware.
>>> + * It has now been decided to expose everything by default in the DT header:
>>> + * include/dt-bindings/clock/axg-clkc.h. Only the clocks ids we don't want
>>> + * to expose, such as the internal muxes and dividers of composite clocks,
>>> + * will remain defined here.
>>> + */
>>> +#define CLKID_FIXED_PLL_DCO		0
>>> +#define CLKID_FCLK_DIV2_DIV		2
>>> +#define CLKID_FCLK_DIV3_DIV		4
>>> +#define CLKID_FCLK_DIV4_DIV		6
>>> +#define CLKID_FCLK_DIV5_DIV		8
>>> +#define CLKID_FCLK_DIV7_DIV		10
>>> +#define CLKID_FCLK_DIV2P5_DIV		12
>>> +#define CLKID_GP0_PLL_DCO		14
>>> +#define CLKID_HIFI_PLL_DCO		16
>>> +#define CLKID_HDMI_PLL_DCO		18
>>> +#define CLKID_HDMI_PLL_OD		19
>>> +#define CLKID_MPLL_50M_DIV		21
>>> +#define CLKID_MPLL_PREDIV		23
>>> +#define CLKID_MPLL0_DIV			24
>>> +#define CLKID_MPLL1_DIV			26
>>> +#define CLKID_MPLL2_DIV			28
>>> +#define CLKID_MPLL3_DIV			30
>>> +
>>> +#define NR_PLL_CLKS			32
>>> +/* include the CLKIDs that have been made part of the DT binding */
>>> +#include <dt-bindings/clock/amlogic,s4-pll-clkc.h>
>>> +
>>> +#endif /* __MESON_S4_PLL_H__ */
>> 

