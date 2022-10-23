Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A75609464
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJWP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJWP3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:29:52 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2442F397
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:29:49 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c23so4447947qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVSP6kKHDAKLq9LSixfl+dhTMXefhH+oMJ46FKW4FMI=;
        b=SjKJSoHwqhV7MAnSKwEb3d7EOsu8jKc5Z2iUV1kmo5pAEdxV4//ChdnYRNhLO6aShP
         aENkC9oqyL7YftnBq2OLCv85f/gHm06tfFjbE5Yzp1qC1/DDLQfiMzdVpfWkEnjR/KR/
         N/M15xIM4/amfbSRnroGuHOVtiL0Q0sKwuSnP0b3ql6X/EsaqkSu8LSgcWPI98Uco+FB
         U01R5AdO7c2x4z0vwPSfHY3uKn3n650Im/NSurIcjjae9b+f694AVrP1wN4jXFzDXwFp
         biqdBjUlEVcedhNsJQiPIsJZJ0mh0Dw5WDvk4lEvP9ZY51g6o+WxSIIbBqW3ItRRyDq+
         /KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVSP6kKHDAKLq9LSixfl+dhTMXefhH+oMJ46FKW4FMI=;
        b=BaQAF/qtpHRAy0AoJBV2XQzSdNr26265/Ny9KiDgOrGdNfncf8J0B0vhqKG5FWvSdV
         Q8ZmYHVnFyx0M+KW6JgO4Wnm3ckbaqdtkWdd2VrKffmQyJEpGRJZithbpKzuRJ/CJCH1
         iT4AH9oQDd3QSQ1hZuMGNLmlVxSw0vAMylLs0eVxRQ7PAakqHwGhQum4137iI5RswUtp
         kCr7Dh4rpx5LAEnAFGY1T6yqOHra+3TeMmT5OVdgUGIEJJ1BKo9noZj+y5XLRnG1mi5w
         07FycDejvdme/Bza9HTiWC7KAXDmVOSL9Vo05JRAc5fkxp9WF/pWN0w/4CBNVV1zDMJF
         FQFA==
X-Gm-Message-State: ACrzQf2o6JKcj+dI1dsrL9OgbbJJRx/KUHYXOLuPVApyQsov11NNX9q+
        4lU+s7qw0ncm0lWRh5NBehGf1v9K+LVRHQ==
X-Google-Smtp-Source: AMsMyM64TApOWpxw428QRVSCNRXKtG8fHkANR4PG0rwjoOBHXW7sy3qOh854tIP4bIfvL5fuRer27Q==
X-Received: by 2002:a05:622a:1983:b0:39c:d680:8197 with SMTP id u3-20020a05622a198300b0039cd6808197mr24412010qtc.7.1666538988296;
        Sun, 23 Oct 2022 08:29:48 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q1-20020a05620a0d8100b006ec62032d3dsm13366966qkl.30.2022.10.23.08.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 08:29:47 -0700 (PDT)
Message-ID: <261cd2fb-05dc-3772-dcc7-3ab1f3c0222c@linaro.org>
Date:   Sun, 23 Oct 2022 11:29:45 -0400
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y1VXTlQ1dCSoE8N2@makrotopia.org>
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

On 23/10/2022 11:01, Daniel Golle wrote:
> On Sun, Oct 23, 2022 at 08:39:34AM -0400, Krzysztof Kozlowski wrote:
>> On 23/10/2022 08:24, Daniel Golle wrote:
>>> Hi Krzysztof,
>>>
>>> On Sat, Oct 22, 2022 at 12:35:25PM -0400, Krzysztof Kozlowski wrote:
>>>> On 21/10/2022 18:58, Daniel Golle wrote:
>>>>> On Fri, Oct 21, 2022 at 05:23:38PM -0500, Rob Herring wrote:
>>>>>> On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
>>>>>>> Add new compatible string for MT7986 PWM.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>>>> ---
>>>>>>>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>>>>>>>  1 file changed, 1 insertion(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
>>>>>>> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
>>>>>>> @@ -8,6 +8,7 @@ Required properties:
>>>>>>>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>>>>>>>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>>>>>>>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
>>>>>>> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.
>>>>>>
>>>>>> This version of the PWM h/w is not compatible with any of the existing 
>>>>>> chips? If it is, it should have a fallback compatible.
>>>>>
>>>>> No, it is unique because it comes with just 2 PWM channels.
>>>>> Otherwise the driver behaves just like for MT8183 (4 channels) or
>>>>> MT8365 (3 channels) which also got distinct compatible strings.
>>>>
>>>> Then something would be here compatible. E.g. If you bound MT8183 with
>>>> mt7986-pwm compatible, would you get working device with two channels?
>>>
>>> Yes, but I'd see another 2 channels which do not work, accessing them
>>> may even cause problems (I haven't tried that) as it means accessing
>>> an undocumented memory range of the SoC which we in general we
>>> shouldn't be messing around with.
>>
>> Why on MT8183 there would be undocumented memory? Where is undocumented
>> memory?
> 
> So we were talking about using the MT8183 compatible for MT7986 SoC, as
> the PWM units are identical apart from the number of channels they
> offer:

No, we talk about MT8183 with mt7986-pwm compatible. Read again my message.

> 
> MT7986 got 2 PWM channels. The MMIO registers used for those two
> channels start at offsets 0x10 (pwm0) and 0x50 (pwm1)
> 
> MT8183 got 4 PWM channels. The MMIO registers used for those four
> channels start of offsets 0x10 (pwm0), 0x50 (pwm1), 0x90 (pwm2) and
> 0xd0 (pwm3).
> 
> Hence, when using the MT8183 compatible with MT7986, the driver will
> access offsets 0x90 and 0xd0 in case the users enables the (bogus)
> outputs pwm2 and pwm3. These offsets, however, are not mentioned in the
> datasheet, so it has to be considered that writing things to these
> undocumented offsets could cause unknown behavior.
> 
> I hope it's more clear now what I mean.

But even your case is not correct. On MT7986 the device would still have
2 channels, how the heck he would get 4? Driver binds to ,t7986-pwm
compatible, which defines 2 channels.

> 
>>
>>>
>>> Also note that this case is the same as MT8183 vs. MT8365, they got
>>> distinct compatible strings and also for those two the only difference
>>> is the number of channels.
>>
>> So why they are not made compatible?
> 
> My guess is that it's for this very reason:
> To correctly communicate the capabilities (in this case: number of
> channels) to the driver and not have bogus pwmX show up in the OS
> which then causes undocumented MMIO register access in case anyone
> tries to actually use them.

No, that's not correct reason. There would be no wrong MMIO access and
capabilities would be still correctly communicated.

> 
>>
>>>
>>>>
>>>> If so, they are compatible.
>>>
>>> By that definition you should remove the additional compatible for
>>> MT8365 or rather, it should have been rejected for the same argument.
>>>
>>> I'm talking about
>>> commit fe00faee8060402a3d85aed95775e16838a6dad2
>>> commit 394b517585da9fbb2eea2f2103ff47d37321e976
>>
>> This is a pattern spreading in several Mediatek bindings and we already
>> commented on new patches. I don't know why people working on Mediatek do
>> not mark pieces compatible.
> 
> Others will have to answer that for you.
> 
> To me this looks a bit like a structural shortcoming of the PWM controller
> bindings: if there was a way to tell the driver "hey, this is like MT8183,
> but it got only two channels" that would solve it nicely.
> This could either be done using child-nodes for each PWM channel or by
> simply adding a 'nr-pwms' property.

No, it's rather someone did not think about Devicetree compatibles or
did not care to design the Mediatek bindings and just copy-paste
existing pattern...

Best regards,
Krzysztof

