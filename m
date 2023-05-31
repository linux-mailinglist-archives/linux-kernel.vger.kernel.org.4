Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D173718A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjEaTYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjEaTYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:24:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B719A133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:24:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9707313e32eso1132269266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685561043; x=1688153043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAjA45gDit75AtUQfi+mfN3JC53ugWR4SgeCXc0mV34=;
        b=G9jJFHIJZPBF/WQIQki+BUxqPf13tT4Y6RcVo45iddQJqt6cW0pZrHBdMfx2g/JY++
         LWPz4/UL9ri3bP2G/XZ8ZSl6d+JtPXMg6tRQruioTT7hSRCHrUICgp9D3eXFub12QHj1
         Cc3nOfrQxZZklwGv3ip4QsrsgRmEWHOiWKujcvKvEl7UkV1YhQ3uZYgFW6tZsc/4BFdg
         AOK+KkEenV60SWjRDkIwFwNg3ESsbkNuU3iGDuJYcyh87AgUi9JqwM8TLdJLz58n69U8
         nqqsaySUj9Q4eQPpu4OlZsXDKFtcC6ZqB9D2iGJ+UXvdV9KZaItbfPcGabXFj408G/87
         IebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561043; x=1688153043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAjA45gDit75AtUQfi+mfN3JC53ugWR4SgeCXc0mV34=;
        b=bYERFArgy8GXHznj+JwWshi7UQY90q5qFeR5khTYpWpm6Z8OGLRwNOFWJIx8gXd3GH
         v2/38iCBUdfshuu17U4356R2pp4a7i0wPzMkudv/y6sBygUiJXXr3nJpwtmwH4Sr3IoT
         tT2hvaGSW3BSb0X4gRvwqg1I799+LnFyUKfIMI8hdTXkfo5yV1+6Df7COfGkXbdWM16w
         HWvAIqsHiyqkiD+xZsTko1la1AOpCCKAZiZ3jd4s1jxk/Q8Ywlv7msuhkOTmet7KQ3m2
         opqrsErE9EGbX+l55a5r2XGfIWAl1cTQhSa8p+lVQKeo224iI3It9rm/0gO2rHBFXTli
         XN+w==
X-Gm-Message-State: AC+VfDzul2Rmsr3Hh4w9KsiKlPpeylVohxBPbGBK697ffH0X1HqRxM/i
        qmotNUIAyXbxClDk6wNH+VBBxA==
X-Google-Smtp-Source: ACHHUZ4dDGbEqjzik0Di9UF0rnW5OQCTmu2jTxPectyfPNrUhzsop6dCQ7HF5kgWwci6Vy9xvYPhFQ==
X-Received: by 2002:a17:907:1626:b0:973:a9c3:e055 with SMTP id hb38-20020a170907162600b00973a9c3e055mr5646754ejc.71.1685561043227;
        Wed, 31 May 2023 12:24:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906248f00b0094f3d700868sm9401648ejb.80.2023.05.31.12.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:24:02 -0700 (PDT)
Message-ID: <01dae949-4018-37f4-2dd9-cbecbd65b9a1@linaro.org>
Date:   Wed, 31 May 2023 21:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 5/5] dt-bindings: iio: ad7192: Allow selection of clock
 modes
Content-Language: en-US
To:     Fabrizio Lamarque <fl.scratchpad@gmail.com>
Cc:     Conor Dooley <conor@kernel.org>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230530075311.400686-1-fl.scratchpad@gmail.com>
 <20230530075311.400686-6-fl.scratchpad@gmail.com>
 <20230530-cannabis-headstone-883c5b891dd3@spud>
 <CAPJMGm4=sRQGPmVi8NjAVvOVrr8s2By6PO8kKRKZt3W0FR9j-Q@mail.gmail.com>
 <5d65b644-9b79-d232-d0d0-d2772325eef5@linaro.org>
 <CAPJMGm6T_x9Oocdmbrhi879QqZSd812LxJP=J554UbH9k9_LBw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPJMGm6T_x9Oocdmbrhi879QqZSd812LxJP=J554UbH9k9_LBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 31/05/2023 11:40, Fabrizio Lamarque wrote:
> On Wed, May 31, 2023 at 9:14 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 31/05/2023 08:59, Fabrizio Lamarque wrote:
>>> On Tue, May 30, 2023 at 7:22 PM Conor Dooley <conor@kernel.org> wrote:
>>>>
>>>> On Tue, May 30, 2023 at 09:53:11AM +0200, fl.scratchpad@gmail.com wrote:
>>>>> From: Fabrizio Lamarque <fl.scratchpad@gmail.com>
>>>>>
>>>>> AD7192 supports external clock sources, generated by a digital clock
>>>>> source or a crystal oscillator, or internally generated clock option
>>>>> without external components.
>>>>>
>>>>> Describe choice between internal and external clock, crystal or external
>>>>> oscillator, and internal clock output enable.
>>>>>
>>>>> Signed-off-by: Fabrizio Lamarque <fl.scratchpad@gmail.com>
>>>>> ---
>>>>>  .../bindings/iio/adc/adi,ad7192.yaml          | 27 ++++++++++++++++---
>>>>>  1 file changed, 24 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>>> index 16def2985ab4..f7ecfd65ad80 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>>>>> @@ -32,7 +32,8 @@ properties:
>>>>>
>>>>>    clocks:
>>>>>      maxItems: 1
>>>>> -    description: phandle to the master clock (mclk)
>>>>> +    description: |
>>>>> +      Master clock (mclk). If not set, internal clock is used.
>>>>>
>>>>>    clock-names:
>>>>>      items:
>>>>> @@ -50,6 +51,17 @@ properties:
>>>>>    vref-supply:
>>>>>      description: VRef voltage supply
>>>>>
>>>>> +  adi,clock-xtal:
>>>>> +    description: |
>>>>> +      Select whether an external crystal oscillator or an external
>>>>> +      clock is applied as master (mclk) clock.
>>>>> +    type: boolean
>>>>
>>>> Am I being daft, or are these the same thing? If they are not, and use
>>>> different input pins, I think it should be explained as it not clear.
>>>> Could you explain why we actually care that the source is a xtal versus
>>>> it being mclk, and why just having master clock is not sufficient?
>>>
>>> I may revise the description as follows. Feel free to add your suggestions
>>> in case it is still not clear enough.
>>>
>>> "Select whether an external crystal oscillator between MCLK1 and MCLK2 or
>>> an external CMOS-compatible clock on MCLK2 is used as master clock".
>>>
>>> This is used to properly set CLK0 and CLK1 bits in the MODE register.
>>> I guess most applications would use an external crystal or internal clock.
>>> The external digital clock would allow synchronization of multiple ADCs,
>>
>> Description confuses me. Why would it matter what type of clock you have
>> as input - external crystal oscillator or external CMOS-compatible
>> clock? Later you refer to "internal", so maybe you meant here also
>> internal for one of the options?
> 
> The AD7192 needs to be configured according to the type of external
> clock that is
> applied on MCLK1/MCLK2 pins in order to activate the correct circuitry.
> 
> Here are some citations from the datasheet:
> 
> MCLK2 pin description:
> "The AD7192 has an internal 4.92 MHz clock. This internal clock can be
> made available
> on the MCLK2 pin. The clock for the AD7192 can be provided externally
> also in the form
> of a crystal or external clock. A crystal can be tied across the MCLK1
> and MCLK2 pins.
> Alternatively, the MCLK2 pin can be driven with a CMOS-compatible clock and the
> MCLK1 pin left unconnected."
> 
> Each of these clock modes have to be configured via AD7192 mode register.
> (Clock source configuration bits, mode register, CLK0 and CLK1).
> Here is their description from datasheet:
> 
> "Either the on-chip 4.92 MHz clock or an external clock can be used.
> The ability to
> use an external clock allows several AD7192 devices to be synchronized. Also,
> 50 Hz/60 Hz rejection is improved when an accurate external clock
> drives the AD7192."
> 
> The choice between internal clock, external crystal oscillator or
> external CMOS digital
> clock is a decision of the HW designer driven by noise rejection,
> synchronization, and
> cost requirements.
> 
> If possible, I kindly ask you suggestions on how to adjust the description
> so that it would be cleaner.

It's fine. I missed that part that first option requires feeding the
clock through two pins ("and").

Best regards,
Krzysztof

