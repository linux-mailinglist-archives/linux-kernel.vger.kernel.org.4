Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C870EA7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238822AbjEXA43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjEXA4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:56:22 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A9BCD;
        Tue, 23 May 2023 17:56:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 7F1085FD1B;
        Wed, 24 May 2023 03:56:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1684889777;
        bh=6UJu4At4JTYJZJm3ufdH8BuFWlW2L/vFJ5Zl0oCFuaU=;
        h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
        b=DyrqPvLXGsYToa8iWySrhnm3P5Z/mM8+b7Ss+5iIy3ovu7u3BaO9/wkN1Etw9JcaC
         KM+5eMnqEmclo/iRjGd1wbCsLYLRtR1RoyTQCBIh8jGIpXL94EUUWsynGEoFzXu/zQ
         MGn2eFGDaedaH+FQ4a7EpO66CEP27dhPSjU8+Z0iLoBCzpX0d1gqziMwLIO49gjoal
         0OhojjOEUcuE+5KLhe3++MIy7NihYhcUR7G4GPd2XMb7PqyGzrvDS8JLFlq4+Au+m5
         J5CtV3pjcKpje3XRe36ZjodKBhW7PaL+TYPwu2E3dfg2//oRq4wxjJ2gLdqgAkQDLt
         KwzwYfM0U4DOw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed, 24 May 2023 03:56:16 +0300 (MSK)
Message-ID: <3fb39050-9543-f4a4-c8f2-a996e24c8e16@sberdevices.ru>
Date:   Wed, 24 May 2023 03:52:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 6/6] clk: meson: a1: add Amlogic A1 Peripherals clock
 controller driver
Content-Language: en-US
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jian.hu@amlogic.com" <jian.hu@amlogic.com>,
        kernel <kernel@sberdevices.ru>,
        "rockosov@gmail.com" <rockosov@gmail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru>
 <20230426095805.15338-7-ddrokosov@sberdevices.ru>
 <CAFBinCA2OhtVaCJDi8ZfAFLSE4oUgxYBDScaP_WW63curEK8Mg@mail.gmail.com>
 <20230512140630.qd33rwzaalmadpmk@CAB-WSD-L081021>
 <CAFBinCA8e9evk+9hTEgoNOD_+3DBst6vYDcradmr2c996jdUmw@mail.gmail.com>
 <20230517103456.p3sjxzbepvg7cr2r@CAB-WSD-L081021>
 <CAFBinCCPf+asVakAxeBqV-jhsZp=i2zbShByTCXfYYAQ6cCnHg@mail.gmail.com>
 <573d96df-7b08-4fa2-668b-58ff674a314e@gmail.com>
 <20230522134425.pc5fhojf53v6q2jz@CAB-WSD-L081021>
 <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
From:   George Stark <gnstark@sberdevices.ru>
In-Reply-To: <a121266a-110a-8c4e-cd71-4e35165fc789@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/05/23 21:43:00 #21378639
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 23:36, Heiner Kallweit wrote:
> On 22.05.2023 15:44, Dmitry Rokosov wrote:
>> Heiner,
>>
>> On Fri, May 19, 2023 at 06:10:50PM +0200, Heiner Kallweit wrote:
>>> On 18.05.2023 22:04, Martin Blumenstingl wrote:
>>>> Hi Dmitry,
>>>>
>>>> On Wed, May 17, 2023 at 12:34 PM Dmitry Rokosov
>>>> <ddrokosov@sberdevices.ru> wrote:
>>>> [...]
>>>>>>> Additionally, the CCF determines the best ancestor based on how close
>>>>>>> its rate is to the given one, based on arithmetic calculations. However,
>>>>>>> we have independent knowledge that a certain clock would be better, with
>>>>>>> less jitter and fewer intermediaries, which will likely improve energy
>>>>>>> efficiency. Sadly, the CCF cannot take this into account.
>>>>>> I agree that the implementation in CCF is fairly simple. There's ways
>>>>>> to trick it though: IIRC if there are multiple equally suitable clocks
>>>>>> it picks the first one. For me all of this has worked so far which is
>>>>>> what makes me curious in this case (not saying that anything is wrong
>>>>>> with your approach).
>>>>>>
>>>>>> Do you have a (real world) example where the RTC clock should be
>>>>>> preferred over another clock?
>>>>>>
>>>>> Yes, a real-life example is the need for a 32Khz clock for an external
>>>>> wifi chip. There is one option to provide this clock with high
>>>>> precision, which is RTC + GENCLK.
>>>>>
>>>>>> I'm thinking about the following scenario.
>>>>>> PWM parents:
>>>>>> - XTAL: 24MHz
>>>>>> - sys: not sure - let's say 166.67MHz
>>>>>> - RTC: 32kHz
>>>>>>
>>>>>> Then after that there's a divider and a gate.
>>>>>>
>>>>>> Let's say the PWM controller needs a 1MHz clock: it can take that from
>>>>>> XTAL or sys. Since XTAL is evenly divisible to 1MHz CCF will pick that
>>>>>> and use the divider.
>>>>>> But let's say the PWM controller needs a 32kHz clock: CCF would
>>>>>> automatically pick the RTC clock.
>>>>>> So is your implementation there to cover let's say 1kHz where
>>>>>> mathematically 24MHz can be divided evenly to 1kHz (and thus should
>>>>>> not result in any jitter) but RTC gives better precision in the real
>>>>>> world (even though it's off by 24Hz)?
>>>>>>
>>>>> I don't think so. The highest precision that RTC can provide is from a
>>>>> 32KHz rate only. However, I believe that a 1kHz frequency can also be
>>>>> achieved by using xtal 24MHz with a divider, which can provide high
>>>>> precision as well.
>>>> Thank you again for the great discussion on IRC today.
>>>> Here's my short summary so I don't forget before you'll follow up on this.
>>>>
>>>> In general there's two known cases where the RTC clock needs to be used:
>>>> a) When using the GENCLK output of the SoC to output the 32kHz RTC
>>>> clock and connect that to an SDIO WiFi chip clock input (this seems
>>>> useful in my understanding because the RTC clock provides high
>>>> precision)
>>>> b) When using the PWM controller to output a 32kHz clock signal. In
>>>> this case my understanding is that using the RTC clock as input to the
>>>> PWM controller results in the best possible signal
>>>>
>>>> The second case won't be supported with Heiner's patches [0] that use
>>>> CCF (common clock framework) in the PWM controller driver.
>>>> In this series the parent clock is calculated using:
>>>>    freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>>
>>>> A 32kHz clock means a PWM period of 30518ns. So with the above
>>> To be precise: 30517,578125ns
>>> What means that the PWM framework can't say "I want 32768Hz",
>>> but just "I want something being very close to 32768Hz".
>>> So what you need is some simple heuristic to interpret the
>>> PWM request -> "PWM requests 30518ns, but supposedly it wants
>>> 32768Hz"
>>>
>>> NSEC_PER_SEC / 30518 = 32767 (rounded down from 32767,547)
>>> clk_round_rate(channel->clk, 32767) would return 0 (I *think*),
>>> because it tries to find the next lower clock.
>>>
>>> The SoC families I'm familiar with have fclkin2 as PWM parent.
>>> That's 1 GHz in my case, what results in a frequency of 32.767,547Hz
>>> for period = 30518n.
>>> What you're saying is that newer generations don't have PWM parents
>>>> 24MHz any longer?
>> No, of course not. For example, a fixed PLL (with all fclk_divX
>> settings) has rates higher than 24MHz. However, we need to consider the
>> 'heavy' background of such PWM.
>>
>> However, we have a "lightweight" clkin (special rtc32k) with a rate of
>> 32kHz that we could potentially use as an input to produce a 32kHz
>> output on the PWM lines. I don't see any reason why we should not
>> support such special cases.
>>
> Two more things to consider:
> 1. When wanting a 32kHz (well, 32768Hz) output with a 50% duty cycle,
>     then we need hi=0 and lo=0 with a 64kHz input clock.
>     See point 2 for an explanation of why 0 and not 1.
>     Means we couldn't use the RTC input clock. Did you consider this?
>     Or do I miss something?
> 2. Seems the PWM block internally increments hi and lo, except the
>     constant_en bit is set on newer PWM block versions.
>     For bigger cnt values the impact is negligible, but for very small
>     values it's something we have to consider.
>     This was one additional motivation for me to choose an input
>     frequency that creates big cnt values.
>
Hello Heiner

As I mentioned earlier I have some changes to take into account lo and hi regs incrementing.

But it's more convenient to base my patch on top on one of yours (https://lore.kernel.org/linux-amlogic/23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com/)

Is that ok if I resend your patch along with mine in series?

Best regards
George

>>>
>>>> calculation the PWM driver is asking for a clock rate of >=2GHz.
>>>> We concluded that letting the common clock framework choose the best
>>>> possible parent (meaning: removing CLK_SET_RATE_NO_REPARENT here) can
>>>> be a way forward.
>>>> But this means that the PWM controller driver must try to find the
>>>> best possible parent somehow. The easiest way we came up with
>>>> (pseudo-code):
>>>>    freq = NSEC_PER_SEC / period;
>>>>    fin_freq = clk_round_rate(channel->clk, freq);
>>>>    if (fin_freq != freq) {
>>>>      freq = div64_u64(NSEC_PER_SEC * (u64)0xffff, period);
>>>>      fin_freq = clk_round_rate(channel->clk, freq);
>>>>    }
>>>>
>>>> The idea is: for a requested 32kHz signal the PWM period is 30518ns.
>>>> The updated logic would find that there's a matching clock input and
>>>> use that directly. If not: use the original logic as suggested by
>>>> Heiner.
>>>>
>>>>
>>>> Best regards,
>>>> Martin
>>>>
>>>>
>>>> [0] https://lore.kernel.org/linux-amlogic/9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com/
>

