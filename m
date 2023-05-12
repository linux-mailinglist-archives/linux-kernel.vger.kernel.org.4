Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3017009F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbjELOGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjELOGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:06:38 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5A1B8;
        Fri, 12 May 2023 07:06:35 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 51F475FD7F;
        Fri, 12 May 2023 17:06:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1683900392;
        bh=Wty4lPdUl1Ry9LEa9KvWzRRPn/a18yqNQKacXZMS6oc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=MQu3fETnqRD++Dvd5Edd/wJkzKTcTtmlgHgxPWSvbZqyZ050kPpnx4O7g+08Rc0ph
         0KJ15CGO4YcM15Vvj9wTAuPujliJtd2tWOKhmdY99+ypLXLbhsgZ2Sq/lzlilebmmw
         qdm9r+r2JbGrLrmnfnJsl1e7f0hdozXXHOm0SzpCVslCeTaWjk/+L+ukC8aiU6J022
         J9IcGEFJjvnwsQHukaeim0kpRilczpixzAPoS0Kl/AEg3bJhuYhpdMcQA72MGmc96q
         PnHXIn7O9lU++x6+dE5EPDZvVDs1T8rZDO2UXH/87lOpX+cKA+mY/RVzTpQKKQiA72
         jw6M2QhHYphDQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 12 May 2023 17:06:31 +0300 (MSK)
Date:   Fri, 12 May 2023 17:06:30 +0300
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
Message-ID: <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/12 11:36:00 #21269061
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

On Mon, May 01, 2023 at 09:06:24PM +0200, Martin Blumenstingl wrote:
> Hi Dmitry,
> 
> overall this looks pretty good.

Thank you! Please find my thoughts about RTC clock below.

> 
> +Cc Heiner
> 
> On Wed, Apr 26, 2023 at 11:58 AM Dmitry Rokosov
> <ddrokosov@sberdevices.ru> wrote:
> [...]
> > +static struct clk_regmap pwm_a_sel = {
> > +       .data = &(struct clk_regmap_mux_data){
> > +               .offset = PWM_CLK_AB_CTRL,
> > +               .mask = 0x1,
> > +               .shift = 9,
> > +       },
> > +       .hw.init = &(struct clk_init_data){
> > +               .name = "pwm_a_sel",
> > +               .ops = &clk_regmap_mux_ops,
> > +               .parent_data = pwm_abcd_parents,
> > +               .num_parents = ARRAY_SIZE(pwm_abcd_parents),
> > +               /* For more information, please refer to rtc clock */
> > +               .flags = CLK_SET_RATE_NO_REPARENT,
> Heiner is working on a series that adds common clock support to the
> PWM driver [0].
> I think his plans for a next step are adding support for SoCs where
> the PWM clocks are part of the peripheral clock controller (instead of
> being part of the PWM controller registers).
> 

Yes, I'm keeping up with this review and staying informed. It's worth
noting that the peripheral clock driver already includes PWM clocks,
with an important remark about reparenting being switched off. It's
described below.

> Have you considered removing CLK_SET_RATE_PARENT from the &rtc clock
> so downstream clocks won't change the rtc clock rate by accident?
> Then we could drop the CLK_SET_RATE_NO_REPARENT flag from the PWM
> clocks to allow them to pick the best available parent (whether that's
> the rtc clock, xtal or sys_pll).
> That said, it would require managing the CLKID_RTC_32K_SEL clock (or
> it's parents) using assigned-clocks instead of doing so with the PWM
> (and other) clocks. Whether this would cause problems: I'm not sure,
> so I'm hoping that you can share some insights.
> 
> 

Allow me to share my thoughts on this matter. From my understanding,
Amlogic provides an RTC clock that is both accurate and power-effective
in achieving a 32KHz signal from an internal xtal of 24MHz. However,
this requires a complex RTC divider with four parameters (m1, m2, n1,
n2), as it cannot be accomplished with a single divider. Our team has
measured the RTC clock using an oscilloscope on the GEN CLK pin and
found that it provides a stable 32KHz signal with acceptable jitter. On
the other hand, other approaches, such as the PWM way, yield less stable
and less accurate 32KHz signals with greater jitter.

Additionally, the CCF determines the best ancestor based on how close
its rate is to the given one, based on arithmetic calculations. However,
we have independent knowledge that a certain clock would be better, with
less jitter and fewer intermediaries, which will likely improve energy
efficiency. Sadly, the CCF cannot take this into account.

Given the advantages of the RTC clock, we wish to be able to control the
RTC as a parent for specific leaf clocks. This is achievable with the
'assigned-clocks' feature of CCF OF, but it poses a significant
architectural problem. The 'assigned-clocks' node does not lock/pin the
parent, and a simple clk_set_rate() call can change the parent during
rate propagation. In my opinion, an ideal solution to this problem would
be an additional patch to the CCF core that provides this locking
capability. As a board DTS developer, I know which clock I want to use
as the parent and have a strong reason for doing so, and I do not wish
to open up my parent muxing to other drivers. But until the behavior of
'assigned-clocks' is not available, we will simply label all RTC
children with the CLK_SET_RATE_NO_REPARENT flag.

> Best regards,
> Martin
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com/

-- 
Thank you,
Dmitry
