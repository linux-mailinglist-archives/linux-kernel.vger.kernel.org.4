Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A741769DD18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbjBUJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjBUJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:43:59 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCD2D5D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:43:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h32so14806044eda.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyKGI0nCGNiU3s1gpibfntG06MqeP3FH0OEDkylMToM=;
        b=n4wLVR8b4XV16OwzuC3dPqrraVOgyrp/pXNgwKTvXIzlL7MBtCjyVIN3twUx1diVwS
         vFyiJwlDaLHlgFb/TdGsmT0gRaUHNzD3eGVyA79dYHlOBmbzN7blYIrQiv5meUgHQENL
         SnutbpAZUP/ZKzY6LPan1UvbggVYU2rGhJP2guN4L+rI4snem+JvuyZEdHwdNiJ/DaT8
         CgUU1EniLLfPZdMGQ9VD4Z5q9YGRC0AhcuEnpgxY0HQQJppYOMUwbzwNUpnro9W+PKe9
         3l/w4XKLJSi6yUbkCfxmYfiulxMXjTkJ8P2rJNK52EOWdCi/dX2jvQtHi2YFygJqCbmO
         Y3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyKGI0nCGNiU3s1gpibfntG06MqeP3FH0OEDkylMToM=;
        b=tA7ASLUNebbI/Oy+ctx5gaDGIGVPD6xkCheQ68zrhsQTOdQ5Z4MoRXLnL0N6vhpc78
         5c3Mu/cnaWZMLha/QUje+rbEnCbQ4d4RxqdWyNv5l71gSwEVyjbJRJSZ/VjI/d/QMQ16
         IYvyu7IJ3Yo1ZOIiWRoqXDem+nUH4O0PfINdluLjukeQq7ESZzjSCNOLklldZc9VTzrl
         B96Rx1++8lBvHBm5hbKSbh6GcS/VfabbAo4HXDHjMYG5yWnd4tkFjBdlR1QvJfiKlcgq
         rLbsJJEpjxumBZH4F6bWCdjkZe/wDq47NzGirBHZtYgyDuuEgOVV8KHGdua7SP9lRaZN
         8zLg==
X-Gm-Message-State: AO0yUKVUC029sTzHzvDEKaRRsA3e7GefQiNB5iYBTvc5CwwCJlffafFU
        fj4rIreRWK+27Emn/O0pSfEaxA==
X-Google-Smtp-Source: AK7set/YK40uzvhDahUih9uXPhcgv8EqyGGtNljX8QGKFaGfGBjTWJ9JDHZ9qMx/PoBQ85Hrk3fboQ==
X-Received: by 2002:a17:907:f99:b0:8b1:3b96:3fe8 with SMTP id kb25-20020a1709070f9900b008b13b963fe8mr11514916ejc.52.1676972636608;
        Tue, 21 Feb 2023 01:43:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id se11-20020a170906ce4b00b008cecb8f374asm2824876ejb.0.2023.02.21.01.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 01:43:56 -0800 (PST)
Message-ID: <6fd971de-19f6-84e4-154f-bd3117483881@linaro.org>
Date:   Tue, 21 Feb 2023 10:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
 <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 04:32, Ryan Chen wrote:
> Hello Jeremy,
> 
>> -----Original Message-----
>> From: Jeremy Kerr <jk@codeconstruct.com.au>
>> Sent: Monday, February 20, 2023 7:24 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
>>
>> Hi Ryan,
>>
>>>>> +  clock-frequency:
>>>>> +    description:
>>>>> +      Desired I2C bus clock frequency in Hz. default 100khz.
>>>>> +
>>>>> +  multi-master:
>>>>> +    type: boolean
>>>>> +    description:
>>>>> +      states that there is another master active on this bus
>>>>
>>>> These are common to all i2c controllers, but I see that
>>>> i2c-controller.yaml doesn't include them (while i2c.text does).
>>>>
>>>> I assume we're OK to include these in the device bindings in the meantime.
>>>> But in that case, you may also want to include the common "smbus-alert"
>>>> property, which you consume in your driver.
>>>>
>>> Since i2c.text have multi-master, smbus-alert. I don't need those two right?
>>
>> Depends whether the maintainers consider i2c.text as part of the schema, I
>> figure. Might be best to get their input on this.
> 
> 
> Yes, I will drop this, also integrate into aspeed,i2c.yaml file.
> 
>>>>> +  timeout:
>>>>> +    type: boolean
>>>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>>>> +
>>>>> +  byte-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use byte mode transmit
>>>>> +
>>>>> +  buff-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use buffer mode transmit
>>>>
>>>> These three aren't really a property of the hardware, more of the
>>>> intended driver configuration. Do they really belong in the DT?
>>>>
>>> Sorry, I am confused.
>>> This is hardware controller mode setting for each i2c transfer.
>>> So I add it in property for change different i2c transfer mode.
>>> Is my mis-understand the property setting?
>>
>> It depends what this is configuration is for.
>>
>> Would you set the transfer mode based on the design of the board? Is there
>> something about the physical i2c bus wiring (or some other hardware design
>> choice) that would mean you use one setting over another?
>>
> No, it not depend on board design. It is only for register control for controller transfer behave.

Then DT does not look like suitable place for it. Drop the property.


> The controller support 3 different trigger mode for transfer.
> Byte mode: it means step by step to issue transfer.
> Example i2c read, each step will issue interrupt then driver need trigger for next step.
> Sr (start read) | D | D | D | P
> Buffer mode: it means, the data can prepare into buffer register, then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling. 
> The DMA mode most like with buffer mode, The differ is data prepare in DRAM, than trigger transfer. 
> 
> 
>> On the other hand, if it's just because of OS behaviour, then this doesn't belong
>> in the DT.
>>
>> Maybe to help us understand: why would you ever *not* want DMA mode?
>> Isn't that always preferable?
> In AST SOC i2c design is 16 i2c bus share one dma engine. 
> It can be switch setting by dts setting. Otherwise driver by default probe is DMA mode.

DMA mode is chosen by existence (or lack) of dmas property, isn't it?
Why do you need separate property instead of using the standard one?

Best regards,
Krzysztof

