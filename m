Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BDF733341
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjFPOOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245726AbjFPOOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:14:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9BF2D47
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:14:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-311183ef595so538364f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686924885; x=1689516885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H6jJ8jl2zxfYRT/VD5e4lCITqgn1yEPd63TtMtS1Jbo=;
        b=DqXjleaypY7ZnQBr+UjU1Gw0u7GTdlCGT7thozHGBIJi/2iXToh+sDyFLe3XMR2GEv
         N3W9TxTzUIvBEfzB6LLaOepGodZViW+xMKwyjr42kRJGOFVTgJLgVgBgIbc8gOWotYT/
         kI7Mo+J9pe/MdRo33Sohw36qAN/yde8A++JM7688Q63ufm5SciQsSjqBuKX5GqzZQBIU
         ZLkS/uPZnXbTj4IbZWfamogVV+2Ag+owXulb2M+nlNPPl/ujDa0f1yGpUM4d7aC1l+S3
         F0G8S1C/MKLlo5mvYRYJAUaHWQB9l5UfBFk2bR5n/HH4ew4twZ5NZDRVj/W2sWymq49F
         oWjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686924885; x=1689516885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H6jJ8jl2zxfYRT/VD5e4lCITqgn1yEPd63TtMtS1Jbo=;
        b=h/BBpKMUJLVZ230ecDTQfFPCmH/cqYkSklyj0rHnJIquJrNLm0Bw4WoOKda87hkHfY
         eJpN/a0ZulVai/DW6vgNwHaXBYqCLrtPbhpSKN4fTcmrgl0cwrYPqP707d/vQx8xWvH6
         IAVxubrh6RBPYOv9hkOJ45Blv1V0lKLQIx8XVd6MjEihGXso6OuUqrrKxfBjEcSMErBo
         oOhShzwY2A3sVCQP6kSwppo3PCFf1RnbL51fENQx/aWqMTZ5w34iJOhgfi0+xob/Mv/Q
         DhzY9Ewe0I0h4cR3ZW4mrEOqLhnbJKo8synSvPp1I9KZN748Fsf7akNshAvs1AEcbsHs
         OBNA==
X-Gm-Message-State: AC+VfDy7FUwoO5KrFFpflwyCa8QrMrL5+xQzc5ffCeeTBWmHTK4926KD
        1irxiv5/x+1dcmZDiWMcdnI7Ww==
X-Google-Smtp-Source: ACHHUZ5YPMVGvwvOFI532kPukbTnEn0EEfKSfKN/XYgNakXzX7586mZ/qG+bWttFxSqtEjozoLVjNg==
X-Received: by 2002:adf:e7d2:0:b0:311:19a2:e3cc with SMTP id e18-20020adfe7d2000000b0031119a2e3ccmr1496535wrn.8.1686924885161;
        Fri, 16 Jun 2023 07:14:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c? ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.googlemail.com with ESMTPSA id k7-20020adfe3c7000000b0030fce98f40dsm9894758wrm.42.2023.06.16.07.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 07:14:44 -0700 (PDT)
Message-ID: <42f245c0-8cc4-9b8c-1b7d-a7daced9a57a@linaro.org>
Date:   Fri, 16 Jun 2023 16:14:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
 <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
 <59c7c90c-50f2-5a77-af12-b266c6e6e0b1@linaro.org>
 <2206a438-8187-4b17-a96c-3affc9552c05@notapiano>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2206a438-8187-4b17-a96c-3affc9552c05@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Nicolas,

thanks for investigating !

On 15/06/2023 21:17, Nícolas F. R. A. Prado wrote:
> On Thu, Jun 08, 2023 at 11:39:27AM +0200, Daniel Lezcano wrote:
>> On 01/06/2023 19:09, Nícolas F. R. A. Prado wrote:
>>> On Wed, May 31, 2023 at 12:49:43PM +0800, Chen-Yu Tsai wrote:
>>>> On Wed, May 31, 2023 at 3:51 AM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
>>>>>
>>>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>>>
>>>>> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
>>>>> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
>>>>> and update the documentation that describes the Calibration Data Offsets.
>>>>>
>>>>> Changelog:
>>>>>       v4 :
>>>>>           - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
>>>>>             room for SVS support, pointed out by
>>>>>             AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>>
>>>>>       v3 :
>>>>>           - Rebased :
>>>>>               base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>>>>>           - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
>>>>>             Use filtered mode to make sure threshold interrupts are triggered,
>>>>
>>>> I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
>>>> fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a couple
>>>> of the LVTS sensors would be N/A. Not sure if this is related to this change.
>>>
>>> Yes, it is. Filtered mode has some delay associated with reading, meaning most
>>> of the time the value isn't ready, while immediate mode is, well, pretty much
>>> immediate and the read always succeeds.
>>>
>>> For temperature monitoring, filtered mode should be used. It supports triggering
>>> interrupts when crossing the thresholds. Immediate mode is meant for one-off
>>> readings of the temperature. This is why I suggested using filtered mode.
>>>
>>> As far as the thermal framework goes, it's ok that filtered mode doesn't always
>>> return a value, as it will keep the old one. But of course, having the
>>> temperature readout always work would be a desired improvement.
>>>
>>> As for ways to achieve that, I think the intended way would be to enable the
>>> interrupts that signal data ready on filtered mode (bits 19, 20, 21, 28), read
>>> the temperature and cache it so it is always available when the get_temp()
>>> callback is called. The issue with this is that it would cause *a lot* of
>>> interrupts, which doesn't seem worth it.
>>>
>>> Another option that comes to mind would be to enable immediate mode only during
>>> the get_temp() callback, to immediately read a value, and return to filtered
>>> mode at the end. That might work, but I haven't tried yet.
>>
>> Why not understand why the filtered mode is unable to return temperature
>> values most of the time?
>>
>> I tried with the filtered mode and I can see 90% of the time it is not
>> possible to read the temperature.
>>
>> IIUC there are timings which can be setup, may be understand how to set them
>> up in order to read the temperature correctly?
>>
>> Caching values, switching the mode or whatever is hackish :/
> 
> So this is what I've found after some more testing.
> 
> With the current settings, using filtered mode, only about 30% of the
> measurement reads return valid results:
> rate: 29%   (success: 293, fail: 707)
> 
> While, as observed, in immediate mode, the reads always succeed:
> rate: 100%   (success: 1000, fail: 0)
> 
> Changing the configurations so that the measurements take less time improve the
> rate (and analogously increasing the time worsens the rate). That is, with
> PERIOD_UNIT = 0, GROUP_INTERVAL = 0, FILTER_INTERVAL = 0, SENSOR_INTERVAL = 0,
> HW_FILTER = 0 (ie single sample) the rate is much improved:
> rate: 91%   (success: 918, fail: 82)
> 
> Though note that even though we're sampling as fast as possible and sampling
> only once each time, so supposedly what immediate mode does, it's still not at
> 100% like in immediate mode.
> 
> Enabling the sensor 0 filter IRQ (bit 19) I've observed that it is triggered
> about every 3500us (on the controller with all four sensors) with the current
> settings, but after changing those timing registers, it happens every 344us.
> With that in mind, in addition to those timing changes, if we also read the
> register more than once with a timeout longer than that 344, that is,
> 
> rc = readl_poll_timeout(msr, value, value & BIT(16), 240, 400);
> 
> it's enough to get
> rate: 100%   (success: 1000, fail: 0)
> and even better:
> rate: 100%   (success: 10000, fail: 0)
> 
> So it's still not exactly clear what's the relation of the VALID bit with the
> timings in the hardware, but this at least gives us a way to get valid reads
> without sacrificing interrupts.
> 
> Meanwhile, I've also tried reading the measurement during handling of the sensor
> 0 filter IRQ (bit 19), and while it definitely works much better than the
> current 30%, giving a rate of 92%, it's still not 100%, which is intriguing
> given this IRQ is supposed to signal the data is ready... I thought this might
> be caused by timing issues, but increasing the timing of the measurements (by
> setting PERIOD_UNIT = 120), lowered the rate to 84%.
> Simply enabling this interrupt (and not reading the data in the IRQ), gives a
> drastically worse rate:
> rate: 3%   (success: 32, fail: 968)
> Which I understand to mean that whenever the IRQ is cleared, the hardware
> invalidates the previous measurement. So this IRQ is definitely related to the
> VALID bit, but it also is unexpectedly influenced by the timings.
> 
> The VALID bit is also updated when read, and it tends to take the same time
> between IRQs to be reset, so my understanding is that on every IRQ the VALID
> bit is re-set to 1, and reading it clears it. But this does not explain why with
> smaller intervals a single read has more chance of succeeding.
> 
> At this point, though, I feel like if it is possible to guarantee that readings
> in filtered mode will always be valid, it must be some hidden setting in
> LVTS_CONFIG. But with what we have access to, the best we can hope for is to
> make the invalid reads extremely unlikely, which is what shrinking the intervals
> and polling the register as shown above gives us, so it's what I suggest us to
> do.
Let me summarize and check I'm understanding correctly:

1. Immediate mode

  - 100% successful read, no delay when reading
  - No interrupts when crossing the thresholds (at the first glance)

2. Filtered mode

  - Interrupts when data is ready
  - Interrupts when crossing the thresholds
  - Polling read until TMU valid
	- maximum two register reads
	- minimum delay 240us
	- maximum delay 480us

 From my POV, the filtered mode is not designed for an OSPM, it is for 
real time system for thermal acquisition or similar. It is unthinkable a 
sensor is firing so many interrupts waking up the CPU to tell a 
temperature is ready to be read. And it is strange we have to poll loop 
a register to read a temperature.

The thermal framework is designed to protect the silicon and 
consequently reads with non constant delay and/or high delay can have an 
impact on time sensitive governor. Skipping the temperature because we 
fail to read is also not acceptable, in the case of mitigation, that can 
have an impact.


The normal mode should be:

  - temperature below threshold => no wakeups
  - temperature crosses the threshold => interrupt fires
  - mitigation => wake up every 'passive' delay period

With the filtered mode we have:

  - temperature below threshold => interrupts telling the value is ready 
(we want to ignore that)

  - temperature crosses the threshold => interrupt but not sure we can 
read the temperature correctly

  - mitigation => wake up every 'passive' delay period but not sure we 
can read the temperature correctly

With the immediate mode:

  - temperature below threshold => interrupts is not working, so we have 
to monitor the temperature and wake up every <monitor> delay

  - temperature crosses the threshold => no interrupt, detected by the 
monitoring

  - mitigation => wake up every 'passive' delay period, temperature is 
accurate

It seems not logical to have the immediate mode not working with the 
interrupts when crossing the thresholds. I would say we should stick to 
the immediate mode and double check if the interrupt can work with this 
mode.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

