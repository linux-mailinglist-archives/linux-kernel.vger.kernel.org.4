Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D23610432
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiJ0VP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235359AbiJ0VPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:15:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4F13CBC7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:15:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a5so2115097qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 14:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xea8RVcPNPBnXgY0x+RiV5o0A4N7mtMx4Y8u2uRfkrQ=;
        b=nQUQjvLYMTD84uU2F9PgRldjfqQTPUTHH+mf6gbHAUmVg7DAOVggRVtbNvj+NWLvAW
         eaVtkptOwlJ03XRpulAJM0eZT/0XTZNR/fNOpLv+DnaOuW4yr2F7h7b5t94tNDC9g888
         /ieel8CqluCus7O4rbZ0E7pUJd7A7wLYgPovTO4yg2obI0VX4v4YknLuKAv3Eu5AbD3q
         raNo2hy1xysut0vgPV0US8bcmujP8s8wJMOBpUIgdK5b8zbqgFCYBFXzPChh1sbxeMQz
         GV3aFCoRRy+bk0n7L+JhM6yD6iKz11vcpCz0RvGmIzKdJ0cUlVLToofDTNhyYU2OqQog
         3HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xea8RVcPNPBnXgY0x+RiV5o0A4N7mtMx4Y8u2uRfkrQ=;
        b=5NaYXhtkwCayd1LoouDCyHOcqFeUmiYE3Lr91Fco3xXMv1cTXntsifhQ/XK2gEmPD2
         TPFhIjPr52c/TaSF9jzVyrBBwDHBI7rkdlTJd1zDggcPGCmCXbtceeGyGf9biAcEySPg
         rB8QXqaePuEbZniu16+X5xzLW81en0J9SOK6SkWKvBtp9vxE3ugZF0sJSnyFPS00wGYo
         YuGJ+7MQFgyEkCDgIqASlfNL3sMKJiXgN8jfiW4UjEcxpgTfUr77vZu4Ox1IaoHNI8yZ
         qjuXddyW/rSOd12TaOF4pjubkXTt14zmKx9Ai55PKN4d5tOe6LjhGDUTXBx75N4f74+b
         EXNA==
X-Gm-Message-State: ACrzQf0YAxH5VtceXUjflMaA0kQ7XKfsRrMKay3JFl8QEDZFVhO25/GA
        Ie6TNjkE+iY1t/o6Bd+hloRMyg==
X-Google-Smtp-Source: AMsMyM5FHX0KhpeDbrDgVx5q3452D3FZJ/XneKMCHOcQWbPfSVBcy5pVtUirbzpZWerqiedxbojksg==
X-Received: by 2002:a05:620a:2591:b0:6c9:cc85:87e3 with SMTP id x17-20020a05620a259100b006c9cc8587e3mr35994050qko.577.1666905323709;
        Thu, 27 Oct 2022 14:15:23 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0d9500b006eec09eed39sm1683134qkl.40.2022.10.27.14.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:15:23 -0700 (PDT)
Message-ID: <f2652e0e-fb08-efb4-e25a-36a335f0c457@linaro.org>
Date:   Thu, 27 Oct 2022 17:15:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 3/4] ARM: dts: rockchip: add rk3128.dtsi
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com
Cc:     sjg@chromium.org, philipp.tomsich@vrull.eu,
        zhangqing@rock-chips.com, hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <da1252eb-85e9-bdb8-0542-207173523523@gmail.com>
 <2dc46681-894d-4521-bfa7-3e9209691e0a@gmail.com>
 <6fbb01f0-d0d2-bb06-a160-2f8f91ac68ca@linaro.org> <22076018.EfDdHjke4D@diego>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <22076018.EfDdHjke4D@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 16:02, Heiko Stübner wrote:
> Am Donnerstag, 27. Oktober 2022, 21:43:43 CEST schrieb Krzysztof Kozlowski:
>> On 27/10/2022 13:53, Johan Jonker wrote:
>>> Hi Krzysztof, Kever, Heiko and others,
>>>
>>> On 10/27/22 16:58, Krzysztof Kozlowski wrote:
>>>> On 26/10/2022 20:53, Johan Jonker wrote:
>>>>> Add basic rk3128 support.
>>>>>
>>>>
>>>> Thank you for your patch. There is something to discuss/improve.
>>>
>>> Thank you for your review.
>>>
>>> Some more questions/comments below.
>>>
>>>>
>>>>> +#include <dt-bindings/clock/rk3128-cru.h>
>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>>>> +
>>>>> +/ {
>>>>> +	compatible = "rockchip,rk3128";
>>>>> +	interrupt-parent = <&gic>;
>>>>> +	#address-cells = <1>;
>>>>> +	#size-cells = <1>;
>>>>> +
>>>>> +	aliases {
>>>>> +		gpio0 = &gpio0;
>>>>> +		gpio1 = &gpio1;
>>>>> +		gpio2 = &gpio2;
>>>>> +		gpio3 = &gpio3;
>>>
>>> Is gpio OK here?
>>
>> Could be, but let me rephrase it - why do you need aliases in DTSI? What
>> do these aliases represent?
>>
>> The SoC pieces (nodes in DTSI) do not rely on aliases.
> 
> Subsystems use the aliases for numbering their instances.
> So the i2c0 alias causes the i2c bus getting the number 0 in the operating
> system as well - making it i2c0 there too.

No one argues with these...

> 
> 
>>>>> +		i2c0 = &i2c0;
>>>>> +		i2c1 = &i2c1;
>>>>> +		i2c2 = &i2c2;
>>>>> +		i2c3 = &i2c3;
>>>>> +		spi0 = &spi0;
>>>>> +		serial0 = &uart0;
>>>>> +		serial1 = &uart1;
>>>>> +		serial2 = &uart2;
>>>>
>>>> Bus aliases are board specific and represent what is actually available
>>>> on headers/pins etc. These do not belong to SoC DTSI.
>>>
>>> I just follow current Rockchip DT common practice.
>>>
>>> Do we need to change all Rockchip boards?
>>> Would like to hear from Heiko what's the plan here?
>>> Syncing to U-boot is already a mess...
>>
>> Heiko might have his own preference which then over-rules my
>> recommendation here. But in general this applies to all boards, so other
>> boards could be fixed as well. Different point is whether it is actually
>> worth fixing them...
> 
> I remember only parts of the discussion for the previous socs. Back then
> Arnd was advocating mainly for moving the mmc aliases to boards.
> 
> As the aliases in general also determine the naming of the bus instance,
> I'm very much in favor of having the hardware-i2c5 being named i2c5
> in all cases ;-) . Having these hardware busses getting random numbers
> really calls for chaos.
> 
> So I'd really like us to continue the way we arrived at with the previous
> socs now :-)

No, not only mmc. UART, I2C, SPI - all of these should go to the board.

https://lore.kernel.org/linux-rockchip/CAK8P3a25iYksubCnQb1-e5yj=crEsK37RB9Hn4ZGZMwcVVrG7g@mail.gmail.com/

No one here discusses whether ordering should be random or not.

We discuss that this is a property of the board, not of a SoC.

> 

Best regards,
Krzysztof

