Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4F70F2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239933AbjEXJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjEXJ14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:27:56 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC01F90;
        Wed, 24 May 2023 02:27:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 771EA5FD41;
        Wed, 24 May 2023 12:27:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684920471;
        bh=EfIel68BfcMlk4RH9fou0d53InM6tvfEdFTRJf8LhVY=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=h/nzMME2gPZvUYWTE1gtwmIunx70knYY/bSk5aLhD3yJ3AfRlG/ele4u4CoqPz7Bi
         4LcjfAqg7bzivB5VpKllWnA17Ny8H4GU0Z1cXCAmE6uESh0DRwFP3QHNJdO45w/57J
         7DXBPb+/XE3cYHC1kyVZSGBap7+g2QLs2KoOzBIrAKLLU2TOQ2CIu/hPsLHwq+Ojig
         e7IUZOFqH12o/mY1oxyczkJEG1CBc5D+w9U60i+R2u6JQC+UpvRjBknB2lkG4ZL+Y4
         GaWoxb0SFk2nR9pi8i+vQE4SPJji4BVDFbuhNkQ0YtG8yOyP7grGuBuFqsM7l1H21I
         9jQSDWmM4L6uQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 24 May 2023 12:27:50 +0300 (MSK)
Date:   Wed, 24 May 2023 12:27:50 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Message-ID: <20230524092750.ldm362chnpkwkcj4@CAB-WSD-L081021>
References: <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
 <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
 <573d96df-7b08-4fa2-668b-58ff674a314e@gmail.com>
 <20230522134425.pc5fhojf53v6q2jz@CAB-WSD-L081021>
 <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
 <20230523102318.kf3o5rtmqdy2patg@CAB-WSD-L081021>
 <2c1f7878-e58c-258f-283d-38d08ebaa07a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c1f7878-e58c-258f-283d-38d08ebaa07a@gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/24 06:36:00 #21405912
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:13:46PM +0200, Heiner Kallweit wrote:
> On 23.05.2023 12:23, Dmitry Rokosov wrote:
> > Heiner,
> > 
> > On Mon, May 22, 2023 at 10:35:59PM +0200, Heiner Kallweit wrote:
> >> On 22.05.2023 15:44, Dmitry Rokosov wrote:
> >>> Heiner,
> >>>
> >>> On Fri, May 19, 2023 at 06:10:50PM +0200, Heiner Kallweit wrote:
> >>>> On 18.05.2023 22:04, Martin Blumenstingl wrote:
> >>>>> Hi Dmitry,
> >>>>>
> >>>>> On Wed, May 17, 2023 at 12:34 PM Dmitry Rokosov
> >>>>> <ddrokosov@sberdevices.ru> wrote:
> >>>>> [...]
> >>>>>>>> Additionally, the CCF determines the best ancestor based on how close
> >>>>>>>> its rate is to the given one, based on arithmetic calculations. However,
> >>>>>>>> we have independent knowledge that a certain clock would be better, with
> >>>>>>>> less jitter and fewer intermediaries, which will likely improve energy
> >>>>>>>> efficiency. Sadly, the CCF cannot take this into account.
> >>>>>>> I agree that the implementation in CCF is fairly simple. There's ways
> >>>>>>> to trick it though: IIRC if there are multiple equally suitable clocks
> >>>>>>> it picks the first one. For me all of this has worked so far which is
> >>>>>>> what makes me curious in this case (not saying that anything is wrong
> >>>>>>> with your approach).
> >>>>>>>
> >>>>>>> Do you have a (real world) example where the RTC clock should be
> >>>>>>> preferred over another clock?
> >>>>>>>
> >>>>>>
> >>>>>> Yes, a real-life example is the need for a 32Khz clock for an external
> >>>>>> wifi chip. There is one option to provide this clock with high
> >>>>>> precision, which is RTC + GENCLK.
> >>>>>>
> >>>>>>> I'm thinking about the following scenario.
> >>>>>>> PWM parents:
> >>>>>>> - XTAL: 24MHz
> >>>>>>> - sys: not sure - let's say 166.67MHz
> >>>>>>> - RTC: 32kHz
> >>>>>>>
> >>>>>>> Then after that there's a divider and a gate.
> >>>>>>>
> >>>>>>> Let's say the PWM controller needs a 1MHz clock: it can take that from
> >>>>>>> XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
> >>>>>>> and use the divider.
> >>>>>>> But let's say the PWM controller needs a 32kHz clock: CCF would
> >>>>>>> automatically pick the RTC clock.
> >>>>>>> So is your implementation there to cover let's say 1kHz where
> >>>>>>> mathematically 24MHz can be divided evenly to 1kHz (and thus should
> >>>>>>> not result in any jitter) but RTC gives better precision in the real
> >>>>>>> world (even though it's off by 24Hz)?
> >>>>>>>
> >>>>>>
> >>>>>> I don't think so. The highest precision that RTC can provide is from a
> >>>>>> 32KHz rate only. However, I believe that a 1kHz frequency can also be
> >>>>>> achieved by using xtal 24MHz with a divider, which can provide high
> >>>>>> precision as well.
> >>>>> Thank you again for the great discussion on IRC today.
> >>>>> Here's my short summary so I don't forget before you'll follow up on this.
> >>>>>
> >>>>> In general there's two known cases where the RTC clock needs to be used:
> >>>>> a) When using the GENCLK output of the SoC to output the 32kHz RTC
> >>>>> clock and connect that to an SDIO WiFi chip clock input (this seems
> >>>>> useful in my understanding because the RTC clock provides high
> >>>>> precision)
> >>>>> b) When using the PWM controller to output a 32kHz clock signal. In
> >>>>> this case my understanding is that using the RTC clock as input to the
> >>>>> PWM controller results in the best possible signal
> >>>>>
> >>>>> The second case won't be supported with Heiner's patches [0] that use
> >>>>> CCF (common clock framework) in the PWM controller driver.
> >>>>> In this series the parent clock is calculated using:
> >>>>>   freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
> >>>>>
> >>>>> A 32kHz clock means a PWM period of 30518ns. So with the above
> >>>>
> >>>> To be precise: 30517,578125ns
> >>>> What means that the PWM framework can't say "I want 32768Hz",
> >>>> but just "I want something being very close to 32768Hz".
> >>>> So what you need is some simple heuristic to interpret the
> >>>> PWM request -> "PWM requests 30518ns, but supposedly it wants
> >>>> 32768Hz"
> >>>>
> >>>> NSEC_PER_SEC / 30518 = 32767 (rounded down from 32767,547)
> >>>> clk_round_rate(channel->clk, 32767) would return 0 (I *think*),
> >>>> because it tries to find the next lower clock.
> >>>>
> >>>> The SoC families I'm familiar with have fclkin2 as PWM parent.
> >>>> That's 1 GHz in my case, what results in a frequency of 32.767,547Hz
> >>>> for period = 30518n.
> >>>> What you're saying is that newer generations don't have PWM parents
> >>>>> 24MHz any longer?
> >>>
> >>> No, of course not. For example, a fixed PLL (with all fclk_divX
> >>> settings) has rates higher than 24MHz. However, we need to consider the
> >>> 'heavy' background of such PWM.
> >>>
> >>> However, we have a "lightweight" clkin (special rtc32k) with a rate of
> >>> 32kHz that we could potentially use as an input to produce a 32kHz
> >>> output on the PWM lines. I don't see any reason why we should not
> >>> support such special cases.
> >>>
> >>
> >> Two more things to consider:
> >> 1. When wanting a 32kHz (well, 32768Hz) output with a 50% duty cycle,
> >>    then we need hi=0 and lo=0 with a 64kHz input clock.
> >>    See point 2 for an explanation of why 0 and not 1.
> >>    Means we couldn't use the RTC input clock. Did you consider this?
> >>    Or do I miss something?
> > 
> > Nope, that's my fault. Using a 32kHz base clock for rates of 16kHz or
> > lower that can be divided evenly is a good choice. However, as you
> > mentioned in point 2, the problem with autoincrements should be fixed
> > first.
> > 
> >> 2. Seems the PWM block internally increments hi and lo, except the
> >>    constant_en bit is set on newer PWM block versions.
> >>    For bigger cnt values the impact is negligible, but for very small
> >>    values it's something we have to consider.
> >>    This was one additional motivation for me to choose an input
> >>    frequency that creates big cnt values.
> > 
> > George has a patchset for this and he will send it very soon as he
> > mentioned in another email. Let's assume the code is already fixed and
> > no longer has any issues. In my opinion, if we want to generate rates of
> > 16kHz, 8kHz, 4kHz, etc., the best parent clock to use is a 32kHz RTC.
> > High-rate clocks may not divide evenly and may not generate an accurate
> > output rate. What do you think about it?
> > 
> With the logic in the CCF conversion patch set for these rates the 24MHz
> xtal mux input would be used, creating exactly the requested rates.
> So I see no difference here. What I don't know is whether power
> consumption may be higher with a higher input rate, or whether quality
> of the mux parent clocks differs.
> 

We conducted some experiments on our end and tried using different
clocks as inputs for PWM to generate small rates like 16kHz. The clock
with the least amount of jitter for the resulting output was the RTC
parent at 32kHz, while using the 64MHz (system clock) or the 24MHz (xtal
clock) resulted in more jitter values but was still acceptable.

As for power consumption, I'm not knowledgeable about it; it's something
only Amlolgic has all the secrets to. However, I presume there was a
strong reason to create a separate RTC clock with good 32kHz quality.

> >>
> >>>>
> >>>>
> >>>>> calculation the PWM driver is asking for a clock rate of >=2GHz.
> >>>>> We concluded that letting the common clock framework choose the best
> >>>>> possible parent (meaning: removing CLK_SET_RATE_NO_REPARENT here) can
> >>>>> be a way forward.
> >>>>> But this means that the PWM controller driver must try to find the
> >>>>> best possible parent somehow. The easiest way we came up with
> >>>>> (pseudo-code):
> >>>>>   freq = NSEC_PER_SEC / period;
> >>>>>   fin_freq = clk_round_rate(channel->clk, freq);
> >>>>>   if (fin_freq != freq) {
> >>>>>     freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
> >>>>>     fin_freq = clk_round_rate(channel->clk, freq);
> >>>>>   }
> >>>>>
> >>>>> The idea is: for a requested 32kHz signal the PWM period is 30518ns.
> >>>>> The updated logic would find that there's a matching clock input and
> >>>>> use that directly. If not: use the original logic as suggested by
> >>>>> Heiner.
> >>>>>
> >>>>>
> >>>>> Best regards,
> >>>>> Martin
> >>>>>
> >>>>>
> >>>>> [0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com/
> >>>>
> >>>
> >>
> > 
> 

-- 
Thank you,
Dmitry
