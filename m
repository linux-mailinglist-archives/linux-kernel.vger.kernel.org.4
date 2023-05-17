Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A480D70655C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjEQKfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:35:04 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51743C30;
        Wed, 17 May 2023 03:35:01 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 1B6895FD3E;
        Wed, 17 May 2023 13:34:58 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684319698;
        bh=HCQ4TPFcqVI9UeV/PD1K5fm+MO3VePXkoXjbIJEWfqc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=iQpKioKLSuXASDt4w07TGpjm7yJFxXWvKYNukjc91LjZWNIA8m2ZBiI3b1/IIon1v
         EDY5K50Gg9FqfoMhnFJvRdTp39i7cXjWZBP2UfTJsHUq64+SMl3HGu/ZIS/QJg97PD
         uwrWZXlupCpSpuSZXPf8k7JHQIxrQ4e+Az143lxdz6B6UehUF1qsm9BpB8iY5dnJAK
         4Y4L/pTKLaS3R0AwTHheJmaLYbW19om/DydHvB4gvLHpK10ENGrMzRERhAZVF7EYBH
         7nLWZgKn80b78CoiTwYe302ntHB/76gFPRLO63P00+1aKOP2pGQ8vdnLMB0nN7V5Iz
         ys0GKf9E1FBYg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 17 May 2023 13:34:57 +0300 (MSK)
Date:   Wed, 17 May 2023 13:34:56 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/17 06:42:00 #21327754
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

Thank you for reply and for sharing your thoughts, appreciate it!
Please find my comments below.

On Tue, May 16, 2023 at 11:10:19PM +0200, Martin Blumenstingl wrote:
> Hello Dmitry,
> 
> On Fri, May 12, 2023 at 4:06 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> [...]
> > > > +static struct clk_regmap pwm_a_sel = {
> > > > +       .data = &(struct clk_regmap_mux_data){
> > > > +               .offset = PWM_CLK_AB_CTRL,
> > > > +               .mask = 0x1,
> > > > +               .shift = 9,
> > > > +       },
> > > > +       .hw.init = &(struct clk_init_data){
> > > > +               .name = "pwm_a_sel",
> > > > +               .ops = &clk_regmap_mux_ops,
> > > > +               .parent_data = pwm_abcd_parents,
> > > > +               .num_parents = ARRAY_SIZE(pwm_abcd_parents),
> > > > +               /* For more information, please refer to rtc clock */
> > > > +               .flags = CLK_SET_RATE_NO_REPARENT,
> > > Heiner is working on a series that adds common clock support to the
> > > PWM driver [0].
> > > I think his plans for a next step are adding support for SoCs where
> > > the PWM clocks are part of the peripheral clock controller (instead of
> > > being part of the PWM controller registers).
> > >
> >
> > Yes, I'm keeping up with this review and staying informed. It's worth
> > noting that the peripheral clock driver already includes PWM clocks,
> > with an important remark about reparenting being switched off. It's
> > described below.
> Indeed, this is why this question came to my mind
> 
> > > Have you considered removing CLK_SET_RATE_PARENT from the &rtc clock
> > > so downstream clocks won't change the rtc clock rate by accident?
> > > Then we could drop the CLK_SET_RATE_NO_REPARENT flag from the PWM
> > > clocks to allow them to pick the best available parent (whether that's
> > > the rtc clock, xtal or sys_pll).
> > > That said, it would require managing the CLKID_RTC_32K_SEL clock (or
> > > it's parents) using assigned-clocks instead of doing so with the PWM
> > > (and other) clocks. Whether this would cause problems: I'm not sure,
> > > so I'm hoping that you can share some insights.
> > >
> > >
> >
> > Allow me to share my thoughts on this matter. From my understanding,
> > Amlogic provides an RTC clock that is both accurate and power-effective
> > in achieving a 32KHz signal from an internal xtal of 24MHz. However,
> > this requires a complex RTC divider with four parameters (m1, m2, n1,
> > n2), as it cannot be accomplished with a single divider. Our team has
> > measured the RTC clock using an oscilloscope on the GEN CLK pin and
> > found that it provides a stable 32KHz signal with acceptable jitter. On
> > the other hand, other approaches, such as the PWM way, yield less stable
> > and less accurate 32KHz signals with greater jitter.
> This part is clear to me (we may have even chatted on IRC how to use
> the GEN CLK output previously)
> 
> > Additionally, the CCF determines the best ancestor based on how close
> > its rate is to the given one, based on arithmetic calculations. However,
> > we have independent knowledge that a certain clock would be better, with
> > less jitter and fewer intermediaries, which will likely improve energy
> > efficiency. Sadly, the CCF cannot take this into account.
> I agree that the implementation in CCF is fairly simple. There's ways
> to trick it though: IIRC if there are multiple equally suitable clocks
> it picks the first one. For me all of this has worked so far which is
> what makes me curious in this case (not saying that anything is wrong
> with your approach).
> 
> Do you have a (real world) example where the RTC clock should be
> preferred over another clock?
> 

Yes, a real-life example is the need for a 32Khz clock for an external
wifi chip. There is one option to provide this clock with high
precision, which is RTC + GENCLK.

> I'm thinking about the following scenario.
> PWM parents:
> - XTAL: 24MHz
> - sys: not sure - let's say 166.67MHz
> - RTC: 32kHz
> 
> Then after that there's a divider and a gate.
> 
> Let's say the PWM controller needs a 1MHz clock: it can take that from
> XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
> and use the divider.
> But let's say the PWM controller needs a 32kHz clock: CCF would
> automatically pick the RTC clock.
> So is your implementation there to cover let's say 1kHz where
> mathematically 24MHz can be divided evenly to 1kHz (and thus should
> not result in any jitter) but RTC gives better precision in the real
> world (even though it's off by 24Hz)?
> 

I don't think so. The highest precision that RTC can provide is from a
32KHz rate only. However, I believe that a 1kHz frequency can also be
achieved by using xtal 24MHz with a divider, which can provide high
precision as well.

> > Given the advantages of the RTC clock, we wish to be able to control the
> > RTC as a parent for specific leaf clocks. This is achievable with the
> > 'assigned-clocks' feature of CCF OF, but it poses a significant
> > architectural problem. The 'assigned-clocks' node does not lock/pin the
> > parent, and a simple clk_set_rate() call can change the parent during
> > rate propagation.
> Are you aware of clk_set_rate_exclusive() and clk_rate_exclusive_{get,put}()?
> It locks a clock and all of its parents to a certain rate. Other
> consumers are unable to change the rate unless the lock is released
> again.
> 

Agreed, this API works well for protecting the rate changes. However, I
do not think it covers the scenario where we want to change the rate but
still retain the parent (if it has already been assigned from the dts).

> > In my opinion, an ideal solution to this problem would
> > be an additional patch to the CCF core that provides this locking
> > capability.As a board DTS developer, I know which clock I want to use
> > as the parent and have a strong reason for doing so, and I do not wish
> > to open up my parent muxing to other drivers. But until the behavior of
> > 'assigned-clocks' is not available, we will simply label all RTC
> > children with the CLK_SET_RATE_NO_REPARENT flag.
> 
> PS: while writing this reply I found
> drivers/clk/sunxi-ng/ccu-sun6i-rtc.c which implements
> clk_ops.recalc_accuracy
> I'm not sure I understand this correctly but it seems that CCF is not
> using that information when making the decision which parent to use.

Hmm, I couldn't find how accuracy is used in the logic. It seems that
only the clk_summary contains information on accuracy.

I actually do not like my approach very much. CCF is not very flexible,
yet at the same time it does not allow for strict rules to be set for
the clock. With my approach, each developer would have to set up
assigned clocks directly from the device tree. However, if we back all
clocks inherited from RTC to the reparenting process, we can lose
assigned clocks for the RTC state.

As I mentioned earlier, I believe the best solution is to change CCF to
provide a new 'assigned-clocks-exclusive' mechanism while protecting the
clock from parent changing. I can provide an RFC patch for this if you
do not mind.

However, I think it is necessary to move forward with that patch series
since many other meson-a1.dtsi changes depend on it. We can merge the
current driver implementation as is, and after the CCF has an exclusive
assigned-clocks mechanism, then I will rework this driver.
Alternatively, I can revert all PARENT flags back and change the logic,
if it becomes necessary in the future on upstream boards.

-- 
Thank you,
Dmitry
