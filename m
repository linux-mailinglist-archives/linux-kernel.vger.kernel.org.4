Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4AF63D51F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 13:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiK3MAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 07:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiK3L75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:59:57 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD36F839
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:59:54 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h10so3892064ljk.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ON5FjK+dwOvFBeCLYK/IKSJQsVy9DHwVDaXKHa528g=;
        b=PYyOAVgjg/t20ES1VyJBna5xfttRfQZyFma2PetyzaUUMFovuqyOqC37rxYmVZS3T5
         XzUUsfM55bd83svQTtQhOL35wFLBjt8xG/ABvgyj8kPaw+RvBpcyr+Cwm4kftK8VT4dm
         l/YYoFOWSuPkeaHkii4vJLLiH/SMkXNkH7h6f8ME05L+8O5q0IZtlHWhFp5xnmZpvayp
         AP+g+g8KDKLKLv5Ol4TsDX8r3DLRJ9VIfCpvLlufCQBBSQzoP2EGXsxWRTfv+oGnLXyZ
         nW95Xk6BdkduGqvqrTa4iPR6XbAPxJ1IzyTC+8Lda2MuxVRa3VWzy3R+CfuqHDyxlq/s
         G9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ON5FjK+dwOvFBeCLYK/IKSJQsVy9DHwVDaXKHa528g=;
        b=TTHBv8lOO03BTGnmSwC1bi8mPhAZS/76VcucV+nlCx2F4nEV2khePFLqJch2rA5G8U
         sHDidFnGwvF3DcIAEfdDx2+P3gGjAaLNnt5+mwYLSDzJQCv0LnEh1Z1uEoMZEBJ414XY
         T+xwo94IDHivFVGyIBzKSvkoCT3MqJSxRoqj9JGxbT5lG+HHRiQRgySn4IFknVEXHxGI
         /jAFyVaJ1TkX3xr27jDqQkkXGgQGtl+dpHRU4EuJM7zcMoNNN+sYTsL5QQe2p3XFeNNc
         b+924CoqeRURoQgrctd0Ix14pSSUJh/ojwH0wgQQgpYYt5a9Si4wX4VVmAnmatZ+Sl+M
         bDhA==
X-Gm-Message-State: ANoB5pm5y/osLKnyt7QxChqukA8e+dKGnTsx6cF1alvqYIS9r5FLLn6P
        j1kxUmTaPMpkAJsi8VI9+UDDjw==
X-Google-Smtp-Source: AA0mqf7XGjB6Ub5eyCrIcgsZktv4Dekz8D+amikQ5Wy4MCraS2xhaXmVl57rBX08PU0lRnRGqazSSg==
X-Received: by 2002:a2e:aaa1:0:b0:277:7678:60dd with SMTP id bj33-20020a2eaaa1000000b00277767860ddmr18323523ljb.147.1669809592747;
        Wed, 30 Nov 2022 03:59:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b4-20020a2eb904000000b00279cbcfd7dbsm62226ljb.30.2022.11.30.03.59.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:59:52 -0800 (PST)
Message-ID: <c13b67ec-c030-302a-6315-fad18323923a@linaro.org>
Date:   Wed, 30 Nov 2022 12:59:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b-spi
Content-Language: en-US
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221129140955.137361-1-gch981213@gmail.com>
 <20221129140955.137361-3-gch981213@gmail.com>
 <98b72494-3188-76d5-2e24-9dc127a8b31a@linaro.org>
 <CAJsYDVJknDWKMW1tH0M=85tJOPG-HngxhhMzvJpk5qn_Q9mzAg@mail.gmail.com>
 <7b3f97f9-34af-413c-aaad-9108b4f36c51@linaro.org>
 <CAJsYDVKXvJZaqCBx7RSsfVZkKTGdbp78GHA4mvmUdQwyEyGkBQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAJsYDVKXvJZaqCBx7RSsfVZkKTGdbp78GHA4mvmUdQwyEyGkBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 10:25, Chuanhong Guo wrote:
> Hi!
> 
> On Wed, Nov 30, 2022 at 5:08 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>> And that's exactly what I said - the compatibles should not include bus
>> information. The bus information comes from... the bus!
> 
> Oh. I thought there will be a conflict if there is a SPI driver and
> , say, an I2C driver with the same compatible string.

We already have such. For example: adi,adxl312

> 
>> [...]
>>>>
>>>> Why unit address is optional?
>>>
>>> It isn't. I copy-pasted it from led-class-multicolor.yaml and
>>> didn't check the exact regex.
>>> I'll fix it in the next version.
>>
>> Make it required and matching your case.
> 
> Got it.
> 
>> [...]
>>>>> +      default-intensity:
>>>>> +        description: |
>>>>> +          An array of 3 integer specifying the default intensity of each color
>>>>> +          components in this LED. <255 255 255> if unspecified.
>>>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>> +        minItems: 3
>> [...]
>> So this is brightness of each color...
> 
> I don't think so.
> See the kernel doc for multicolor LED:
> https://docs.kernel.org/leds/leds-class-multicolor.html
> This property sets the sysfs file multi_intensity while the
> actual LED brightness is controlled with another sysfs
> file called 'brightness'.
> Setting multi_intensity alone doesn't change the LED
> brightness at all.

If you had brightness, that would be correct. But you do not have
brightness, right? Therefore the final brightness is always:

subled[i].brightness = 255 * subled[i].intensity / max_brightness (also
255);

Or your bindings are incomplete...

Best regards,
Krzysztof

