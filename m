Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36518640763
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 14:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiLBNC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 08:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbiLBNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 08:02:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5264CC724A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 05:02:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id f18so7693704wrj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 05:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=VSGdRkSATXRqKQ0oJba1FJCwjfGxv8hG7quZPS95hvo=;
        b=kVQJH+qbKlFSL/lKFRaeroiYGaVJTUnlUnXd7aiavCn9HHnizu+WWANGihtdRNDna8
         gOt9GvdHfAe6rYp5ofwnMes+P4GZy9Hf5LozVSkkicjfe8g8Zoucopd609V/EwGpW9UN
         GIFT4Zvk0w6TpKs5Y+8/t9RA0qC2cvhVey8tmcArrLMXMFxhfE466wMJGQjvrGwd3Q5/
         ENO+zqUQd9BanfxXBWeC+RFMomLTUyulJ3/utt3lTTlmsT38RH5mGVGHSSD0bmEb5of/
         sgShbMSo2KGdgRxn0fkcjb4MW1ZuCbuFKojyEGKpMUJK83QTxUoVJvK2yC8uMy4COhiU
         6x8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSGdRkSATXRqKQ0oJba1FJCwjfGxv8hG7quZPS95hvo=;
        b=yWUIpIMuUeCpMuhPVOSjtAY6XdFJVOQGEnO/TIg6T6MdqL1sX+RUC43E8azFzXuKup
         dWw2BKxOyZEjzDGR1KLR4FmYtvq/Tl4tAWaCCFsQu5dD67vEwhaZDNdQCnwLmDFqCzSD
         JQl1int3plL5KPek7fs8K+Pzg1rlgLHrRHVig44hDdGvo33YOA931SICVWctPMTl9n32
         VvmqRzDAzxY/yVa4EwNAEqVYDS1XO5g6pcBYeeUhqHjEqW4wxP9H6s6/fflDhCz3SpdA
         6hfY+nwA0m4veRCOBMJuIPDuW1dqhDIP+DwkfBSzQyIs/zCePPpOZjtdXptnthp7lNZT
         UMDg==
X-Gm-Message-State: ANoB5pm0rZ9Ayd7q+ElF0jc21Hgu/zaRfSMiFoH5fmVOA6+GPnYzPKoL
        vH6d7OH9yRGcr1zPCsWhT/85+Q==
X-Google-Smtp-Source: AA0mqf4nlk4w6LcawMx9ECvjWt6+yVF8oBT4lT6RFJmdvgQzCahSEK7NLtivQOb0bLQz3bsBY/s6mg==
X-Received: by 2002:adf:ee0d:0:b0:242:28c9:d116 with SMTP id y13-20020adfee0d000000b0024228c9d116mr8740663wrn.286.1669986139791;
        Fri, 02 Dec 2022 05:02:19 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003b4ff30e566sm14902720wms.3.2022.12.02.05.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 05:02:19 -0800 (PST)
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-8-ddrokosov@sberdevices.ru>
 <1jtu2e6mn5.fsf@starbuckisacylon.baylibre.com>
 <20221202124730.uckax232hnjqg26a@CAB-WSD-L081021>
User-agent: mu4e 1.8.10; emacs 28.2
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
Subject: Re: [PATCH v8 07/11] clk: meson: a1: redesign Amlogic A1 PLL clock
 controller
Date:   Fri, 02 Dec 2022 13:49:59 +0100
In-reply-to: <20221202124730.uckax232hnjqg26a@CAB-WSD-L081021>
Message-ID: <1jh6ye6js6.fsf@starbuckisacylon.baylibre.com>
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


On Fri 02 Dec 2022 at 15:47, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> On Fri, Dec 02, 2022 at 12:42:17PM +0100, Jerome Brunet wrote:
>> 
>> On Fri 02 Dec 2022 at 01:56, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
>> 
>> > Summary changes:
>> >     - supported meson-a1-clkc common driver
>> >     - inherited from the base clk-pll driver, implemented own version of
>> >       init/enable/disable/enabled routines; rate calculating logic is
>> >       fully the same
>> >     - aligned CLKID-related definitions with CLKID list from order
>> >       perspective to remove holes and permutations
>> >     - corrected Kconfig dependencies and types
>> >     - provided correct MODULE_AUTHORs() and MODULE_LICENSE()
>> >     - optimized and fix up some clock relationships
>> >     - removed unused register offset definitions (ANACTRL_* group)
>> 
>> This patch mix PLL stuff, factorization change, etc ...
>> In general, when your commit description is a list, it is a hint that
>> you are doing more than one thing in it. It is unlikely to be OK then
>
> It will be fixed by itself, when I'll squash patches.
>
>> > +static int meson_a1_pll_init(struct clk_hw *hw)
>> > +{
>> > +	struct clk_regmap *clk = to_clk_regmap(hw);
>> > +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
>> > +
>> > +	regmap_multi_reg_write(clk->map, pll->base.init_regs,
>> > +			       pll->base.init_count);
>> > +
>> > +	return 0;
>> 
>> Looks the the default init mostly
>> 
>> Looks like you are trying the handle the absence of the rst bit.
>> I'm pretty sure the hifi PLL of the SoC as one but you really don't want
>> to poke, this can be in the generic driver, with MESON_PARM_APPLICABLE()
>> test.
>> 
>> No need to redefine this
>> 
>
> I've redefined it, because in the previous v7 you mentioned that's
> not acceptable to mix init/enable/disable sequences between a1 pll and clk
> common pll driver:
>
> https://lore.kernel.org/linux-amlogic/1jd0ac5kpk.fsf@starbuckisacylon.baylibre.com/
>
> Hmmm, looks like I've made a mistake. You meant only enable/disable
> callbacks...
>
> Anyway, it doesn't matter to me. I think both approaches are okay:
>     * clk-pll customization using MESON_PARM_APPLICABLE()
>     * custom callbacks implementation for some clk_ops like implemented in
>       this patchset.
>
> Please advise what's the best from you point of view?

It is a balance.

Everytime a new PLL comes up, it tends to treaded as a new ip block but,
most of the time after some digging and rework, we learn new things and
it ends up being compatible with the previous ones.

From what I see here
* You are trying to make rst optional, that's fine. Do it with
  MESON_PARM_APPLICABLE() in the main driver. Still I would recommend to
  thorougly for this bit. I'm pretty sure the hifi pll has one.

* You add a new feature called current self-adaptation.
  This can be made optional too in the enable sequence.
  I would not be surprised to find out more PLL have that, even on
  earlier SoC.

>
>> > +}
>> > +
>> > +static int meson_a1_pll_is_enabled(struct clk_hw *hw)
>> > +{
>> > +	struct clk_regmap *clk = to_clk_regmap(hw);
>> > +	struct meson_a1_pll_data *pll = meson_a1_pll_data(clk);
>> > +
>> > +	if (MESON_PARM_APPLICABLE(&pll->base.rst) &&
>> > +	    meson_parm_read(clk->map, &pll->base.rst))
>> > +		return 0;
>> > +
>> > +	if (!meson_parm_read(clk->map, &pll->base.en) ||
>> > +	    !meson_parm_read(clk->map, &pll->base.l))
>> > +		return 0;
>> > +
>> 
>> Same here, pretty sure rst is there and the generic function works but
>> if this update is required, it seems safe to do in the generic driver.
>
> The same thing... in the v7 version you suggested to not touch clk-pll
> driver.
>
> https://lore.kernel.org/linux-amlogic/1jd0ac5kpk.fsf@starbuckisacylon.baylibre.com/
>
> ...

