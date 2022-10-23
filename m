Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381D609754
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJWXhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiJWXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:37:36 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59C5C9F8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:37:34 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id s3so4825979qtn.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HTknq9YRuLbulFwFEx4o7i6TtzfHgzwn+Ccmp35GEU=;
        b=V+DcA8VHkywTvzroSILEaWW4mYWin25hdLz1Q9QfocNcb+9rD8WWjaPGkVkNI1Ako5
         GqD+EXE/hBzVy0YikexMfNjsiJTbewcXcoml+udbQ2KwmTDRYNtoN9W7UE/MsgugXQMZ
         DLWCZIn/pW+JEri/vqAOwshwmm0L0wMgoCzarkY3FlYrihy7lnRmOzkv5HfdcSQ9CXFX
         rCNjtrO7pf1YRJENnBojZ4AG59W4OvquwftJC1j6F2jdsCHpVkNT7dlSsnJjPy1XDtNr
         CAJLOJw74BVmuKOJyEP0d+Z2FIznP2+UhBMghqeVqd1svbeaLUcfmAFQLblwydGIrI1J
         Lwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HTknq9YRuLbulFwFEx4o7i6TtzfHgzwn+Ccmp35GEU=;
        b=WW1F1XCLPhhTJJtfl5uo3F+6SHuFOs2igicHBASaAAtObHrcDpcpYegD9rCrAsh0WM
         LH15ts7a13qME0TNTjdHWaSzEMYG/wsawWMOrg0W5ZM1ldsAb3TH71XFI8p9EO97F1rN
         kIA8L3r/hR17rfxB6sfVNtuThxUSF+yheTQyhTUXocIXnpxhZEhYDnGv7AHtswoHlkH7
         2uh/qZB99xNSb/wMUbLY3c9f29LaWI7V9L00EHfLEszQcgTTyynCSeu8gj51oGR/gi7r
         k4SSW5CxwNKS0pCticqj7v9tlWXKuSuIe+ZukwxSnkDMYUT4vI+LGYoV8IUvY3AOi/gR
         3k8w==
X-Gm-Message-State: ACrzQf3zW/UMO0bdjrBCAwwkEmM/4CqkAnEJTkWSjrYVrtXSLMgw7vRt
        7c1bsQDEvPOnb/rQxTsAVXGGdw==
X-Google-Smtp-Source: AMsMyM6rwckOelcCZiDtW/H974ErLN5TU93FI5lGx84DzpID+0M3gXrIY3sNV9Rd2QWsflpqvOOT9w==
X-Received: by 2002:ac8:58c5:0:b0:39c:c710:f58c with SMTP id u5-20020ac858c5000000b0039cc710f58cmr24698988qta.295.1666568253682;
        Sun, 23 Oct 2022 16:37:33 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a132700b006b61b2cb1d2sm13788507qkj.46.2022.10.23.16.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 16:37:33 -0700 (PDT)
Message-ID: <6f28ccf3-ea27-9d5e-bd67-14f7729f713f@linaro.org>
Date:   Sun, 23 Oct 2022 19:37:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string for
 MT7986
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Rob Herring <robh@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
 <20221021222338.GA565200-robh@kernel.org> <Y1MkIdFXrBrrv958@makrotopia.org>
 <5182e3c4-9e5e-2c36-408b-9029c65c8803@linaro.org>
 <Y1UycU0JvwyAv0x2@makrotopia.org>
 <eab019f7-f801-848e-80a3-5bb526d95d53@linaro.org>
 <Y1VXTlQ1dCSoE8N2@makrotopia.org>
 <261cd2fb-05dc-3772-dcc7-3ab1f3c0222c@linaro.org>
 <Y1VhfqBqshkM7mNR@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1VhfqBqshkM7mNR@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 11:45, Daniel Golle wrote:
> On Sun, Oct 23, 2022 at 11:29:45AM -0400, Krzysztof Kozlowski wrote:
>> On 23/10/2022 11:01, Daniel Golle wrote:
>>> On Sun, Oct 23, 2022 at 08:39:34AM -0400, Krzysztof Kozlowski wrote:
>>>> On 23/10/2022 08:24, Daniel Golle wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On Sat, Oct 22, 2022 at 12:35:25PM -0400, Krzysztof Kozlowski wrote:
>>>>>> On 21/10/2022 18:58, Daniel Golle wrote:
>>>>>>> On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
>>>>>>>> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
>>>>>>>>> Add new compatible string for MT7986 PWM.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>>>>>> ---
>>>>>>>>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>>>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>>>> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
>>>>>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>>>> @@ -8,6 +8,7 @@ Required properties:
>>>>>>>>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>>>>>>>>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>>>>>>>>>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
>>>>>>>>> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
>>>>>>>>
>>>>>>>> This version of the PWM h/w is not compatible with any of the existing 
>>>>>>>> chips? If it is, it should have a fallback compatible.
>>>>>>>
>>>>>>> No, it is unique because it comes with just 2 PWM channels.
>>>>>>> Otherwise the driver behaves just like for MT8183 (4 channels) or
>>>>>>> MT8365 (3 channels) which also got distinct compatible strings.
>>>>>>
>>>>>> Then something would be here compatible. E.g. If you bound MT8183 with
>>>>>> mt7986-pwm compatible, would you get working device with two channels?
>>>>>
>>>>> Yes, but I'd see another 2 channels which do not work, accessing them
>>>>> may even cause problems (I haven't tried that) as it means accessing
>>>>> an undocumented memory range of the SoC which we in general we
>>>>> shouldn't be messing around with.
>>>>
>>>> Why on MT8183 there would be undocumented memory? Where is undocumented
>>>> memory?
>>>
>>> So we were talking about using the MT8183 compatible for MT7986 SoC, as
>>> the PWM units are identical apart from the number of channels they
>>> offer:
>>
>> No, we talk about MT8183 with mt7986-pwm compatible. Read again my message.
> 
> Ok, that was not clear to me. I understood the other way around, to use
> `mediatek,mt8183-pwm` on MT7986 (and not even introduce an additional
> compatible for MT7986 in the driver, but only list it as compatibly with
> existing MT8183 in binding docs).

You need dedicated compatible (which will be used by the driver) because
these are two different devices.

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42


> So: The to-be newly introduced `mediatek,mt7986-pwm` should work on
> MT8183 as well, but in that case only two of the four channels would be
> accessible.
> 
>>
>>>
>>> MT7986 got 2 PWM channels. The MMIO registers used for those two
>>> channels start at offsets 0x10 (pwm0) and 0x50 (pwm1)
>>>
>>> MT8183 got 4 PWM channels. The MMIO registers used for those four
>>> channels start of offsets 0x10 (pwm0), 0x50 (pwm1), 0x90 (pwm2) and
>>> 0xd0 (pwm3).
>>>
>>> Hence, when using the MT8183 compatible with MT7986, the driver will
>>> access offsets 0x90 and 0xd0 in case the users enables the (bogus)
>>> outputs pwm2 and pwm3. These offsets, however, are not mentioned in the
>>> datasheet, so it has to be considered that writing things to these
>>> undocumented offsets could cause unknown behavior.
>>>
>>> I hope it's more clear now what I mean.
>>
>> But even your case is not correct. On MT7986 the device would still have
>> 2 channels, how the heck he would get 4? Driver binds to ,t7986-pwm
>> compatible, which defines 2 channels.
> 
> If we do introduce that new compatible, then yes.

No one here argued against introducing new compatible. The question was
why these devices are not compatible with each other? Why new compatible
is not made a part of family of existing compatibles.


> I understood you were suggesting to use `mediatek,mt8183` on MT7986
> hardware which would have resulted in such behavior.
> 
>>
>>>
>>>>
>>>>>
>>>>> Also note that this case is the same as MT8183 vs. MT8365, they got
>>>>> distinct compatible strings and also for those two the only difference
>>>>> is the number of channels.
>>>>
>>>> So why they are not made compatible?
>>>
>>> My guess is that it's for this very reason:
>>> To correctly communicate the capabilities (in this case: number of
>>> channels) to the driver and not have bogus pwmX show up in the OS
>>> which then causes undocumented MMIO register access in case anyone
>>> tries to actually use them.
>>
>> No, that's not correct reason. There would be no wrong MMIO access and
>> capabilities would be still correctly communicated.
> 
> So what exactly do you mean by "made compatible"?
> In the driver? In DTS files? In DT-bindings?

I review bindings, so by "devices being made compatible" I meant exactly
what Devicetree specification asks:

"The property value consists of a concatenated list of null terminated
strings, from most specific to most general. They allow a device to
express its compatibility with a family of similar devices, potentially
allowing a single device driver to match against several devices."

Which means that devices share some common characteristics, like
programming model, and differ by some other pieces. For device drivers,
usually this also means that a device can use any of the compatibles to
bind and function properly, within the limits/features of that compatible.

>>>>>> If so, they are compatible.
>>>>>
>>>>> By that definition you should remove the additional compatible for
>>>>> MT8365 or rather, it should have been rejected for the same argument.
>>>>>
>>>>> I'm talking about
>>>>> commit fe00faee8060402a3d85aed95775e16838a6dad2
>>>>> commit 394b517585da9fbb2eea2f2103ff47d37321e976
>>>>
>>>> This is a pattern spreading in several Mediatek bindings and we already
>>>> commented on new patches. I don't know why people working on Mediatek do
>>>> not mark pieces compatible.
>>>
>>> Others will have to answer that for you.
>>>
>>> To me this looks a bit like a structural shortcoming of the PWM controller
>>> bindings: if there was a way to tell the driver "hey, this is like MT8183,
>>> but it got only two channels" that would solve it nicely.
>>> This could either be done using child-nodes for each PWM channel or by
>>> simply adding a 'nr-pwms' property.
>>
>> No, it's rather someone did not think about Devicetree compatibles or
>> did not care to design the Mediatek bindings and just copy-paste
>> existing pattern...
> 
> So in that case, maybe those existing patterns should be cleaned up?
> Can you suggest a change? (even informal, I can wrap it up as patch).

Someone knowing the devices should reorganize compatibles to come up
with family models, e.g. expressed in DT schema like:

oneOf:
 - const: mediatek,mt7986-pwm
 - items:
     - enum:
         - mediatek,mt8183-pwm
     - const: mediatek,mt7986-pwm

and so on.

> To me, code is almost always better documentation than actual
> documentation, which is usually time consuming to read, hard to
> understand (compared to reading code or existing examples), and it's
> commonly full of errors. I hardly waste my time with it, if there is
> code or existing examples, I will always prefer do read and understand
> that.

Example schema expresses it:

https://elixir.bootlin.com/linux/v6.0-rc1/source/Documentation/devicetree/bindings/example-schema.yaml#L43



Best regards,
Krzysztof

