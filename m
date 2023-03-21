Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3D56C2A92
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjCUGmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCUGmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:42:52 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5473B3D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:42:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so22733162edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679380963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZxdoxCdxOSK76csmiHvWVviR8b5uFc7das86FowyEA=;
        b=Q77N/pCDZ5UqWK2CEFyhd48bzTHRzRdC+fIk2wv7DvUjV088FRYNSRDF47TwiFcIY+
         6bc6N9tTDugYqe7PrxLXlvMowY1tZCcD9H8wX92jysgdjNO7JslSWlBpGtS+7zCl/Rw5
         KUq4Mw5OXZTgTWz9UUnzX32JHuV04N7+lFjmFbGbXr3IeM5R2l/d1tNzk/8V43gkRbVM
         5uhWfTAqvu0bIu4gN+aJPX3c+rLI/0G3v4MXl+zIRAfYFClh7u4y1TPQTVanyhUBboxo
         3FTtd763S4LhZZJIIqOJkN4vIlqFq7suOBIPUl13V9vAjsqkHgJZWB9hbHP8JxqXPoVV
         8wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZxdoxCdxOSK76csmiHvWVviR8b5uFc7das86FowyEA=;
        b=HrJMHe3aE1SVdqORb9JsXbHANN6rwc1Y2IQFBEcDSdtZkFc6K+pkwhPkiBQ9w5mMR1
         GczgAl3Pnr8t9nwETdTqnLiOg5YfxkKA2JNvfZDRn52G8jLN0kJxVeyuSnCsLpj3d3zG
         ty2djjo7fLyxfyX8Xv7inrIimJtfd70N5CJwPb4nLVZAUzDQE8y3BwTBIVWeTmXk+hhf
         M+wbUO0ZiViyk2oTCQFLAINDaLBNEFt0U8pNRp2u5p+jeyqTmCoGWpUVt0m0ym35uRtB
         ZaJkoKsg++4DuGVwU2SMCYLa9Fc/n0QT+9DcVOnwR9NIo7gph2EVFSlpWisxoGzerzpf
         bKPg==
X-Gm-Message-State: AO0yUKWa6E5FFrHd2/Xc4MMZDm9lfTXKQmNc0WVIn5EzGW/ul7Pigntx
        NPXql2dJZ65/9xudU+taP4lBQQ==
X-Google-Smtp-Source: AK7set9j3BlKpRUZBh8SOioTfpdcPC8TrFrDROc2nnTNIMT+cZLemllV3YhB2gxA209Qf0OV9+t6vQ==
X-Received: by 2002:aa7:db44:0:b0:4fe:9689:96bb with SMTP id n4-20020aa7db44000000b004fe968996bbmr2288623edt.35.1679380963102;
        Mon, 20 Mar 2023 23:42:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id f11-20020a50a6cb000000b00501c96564b5sm1955522edc.93.2023.03.20.23.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 23:42:38 -0700 (PDT)
Message-ID: <94cdb512-b168-6ffe-73c1-caf23bb79d6f@linaro.org>
Date:   Tue, 21 Mar 2023 07:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: aw2013: Document vddio-supply
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230320174949.174600-1-linmengbo0689@protonmail.com>
 <20230320175131.174657-1-linmengbo0689@protonmail.com>
 <922eab51-6931-8533-db51-51cd911a36b3@linaro.org>
 <ZBitAGOmF/hyxDYP@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZBitAGOmF/hyxDYP@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/2023 19:59, Stephan Gerhold wrote:
> On Mon, Mar 20, 2023 at 07:04:22PM +0100, Krzysztof Kozlowski wrote:
>> On 20/03/2023 18:55, Lin, Meng-Bo wrote:
>>> Some LEDs controllers are used with external pull-up for the interrupt
>>> line and the I2C lines, so we might need to enable a regulator to bring
>>> the lines into usable state.
>>
>> Not a property of this device.
>>
>>> Otherwise, this might cause spurious
>>> interrupts and reading from I2C will fail.
>>>
>>> Document support for "vddio-supply" that is enabled by the aw2013 driver
>>> so that the regulator gets enabled when needed.
>>>
>>> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/leds/leds-aw2013.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
>>> index 08f3e1cfc1b1..79b69cf1d1fe 100644
>>> --- a/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
>>> +++ b/Documentation/devicetree/bindings/leds/leds-aw2013.yaml
>>> @@ -23,6 +23,11 @@ properties:
>>>    vcc-supply:
>>>      description: Regulator providing power to the "VCC" pin.
>>>  
>>> +  vddio-supply:
>>> +    description: |
>>> +      Optional regulator that provides digital I/O voltage,
>>
>> NAK. I responded to your patch and you just send a v2 without explanation.
>>
>> The device does not have VDDIO pin, either.
>>
> 
> The power supply Lin is trying to add here is basically the "VIO1"
> example in "Figure 1 AW2013 Typical Application Circuit" on page 1 of
> the AW2013 datasheet [1]. The I2C pins and the interrupt output are both
> open-drain and therefore require external pull-up resistors, connected
> to a power supply that might not be always on.
> 
> Because of the open-drain pins AW2013 does indeed not have a dedicated
> input pin for the I/O supply voltage. However, it is still necessary to
> describe the power supply _somewhere_, to ensure that it is enabled when
> needed.
> 
> It is hard to model this properly but it's generally easiest to handle
> this inside the peripheral driver since it knows exactly when I2C and/or
> interrupt lines are currently needed or not. This situation is fairly
> common for I2C devices so there are several precedents, e.g.:
> 
>   1. cypress,tm2-touchkey.yaml: "vddio-supply"
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3e730ec11d51283ad62a98436967c01b718132ab
>   2. goodix,gt7375p.yaml: "mainboard-vddio-supply"
>      https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1d18c1f3b7d938bdefc44289d137b4e6c7a3d502

Both are mistaken. How can you enumerate or autodetect a device if its
regulator pulling up I2C are not on? What's more, on I2C lines you could
have more devices, so you expect each of them having the supply?

These are properties of I2C controller, not the consumer. I2C controller
should enable any regulators necessary for the IO pins.

Best regards,
Krzysztof

