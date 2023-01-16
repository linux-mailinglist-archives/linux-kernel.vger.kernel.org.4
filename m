Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6430E66BB7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 11:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAPKQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 05:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAPKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 05:16:08 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA73C161
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:15:13 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b4so20534719edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 02:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ub1IltuuPTGiOpoZBxnkRWyKh1N9ylDkHOUiK2hYg9w=;
        b=ynemqw6wwxgBl+4b2kXkFC+EGlDrNfMPXfAQ4yTtEeQ/2YwdChWmypIfai4He8Dm44
         Nhe6Qr9YPI9ZLY4IEL5VXvQzl6nwlwSl5cf2FKLPAnVE3Pz8ab1f/lxZWh65/L+Zo1oW
         f3ucpAp9Me3owhAj0YMYppYFVu22ushl8l2PprkubjmQcVdoCo2I6dZfKO6Bn/KYYhDK
         gR+WUx4mxudw5D9c2O5FZa6M3rAGv+JjUou7Ee8cZHQDhgiXQUU/qu0CpISTYrZeP3JR
         s0mjY5J1+inDoDC6a+a9aLncV1471PIJ1Zi5gO5Rps+d8RlwCY90fj0fixb/ndxpZ/1x
         fPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ub1IltuuPTGiOpoZBxnkRWyKh1N9ylDkHOUiK2hYg9w=;
        b=5uF3S5QueLVCyri5hjcP1fAkTgcJtefA0WiYw0fW+x5OvGNQFenq03EtTAn4wQvU7+
         Av1Xv1Z4lhV8TSs5wYKVrdITc3q+t8WWwDRnZOwMjG11pQYm5d6KprgYiUia96Cc/sko
         XPmBAOBCAPjIGzRatoFEEp8AwyqVnfoPIDy3uFUAMXnDh0TNwhJ/C7AMXjRqg5ccMfr4
         rUwVPrWMtK3/saqRI22q7PTeQl40O1IgijGONopCmVJV/0OHhwo5rBlLQg6o7JFHNzb8
         0fiWAml1RsPilDyrBHAbIAtfm84qQbCoq5J94j2mlS3mkh1Tbk/7UmxRjRKSVq9R3jhQ
         TZIA==
X-Gm-Message-State: AFqh2koQka374bG12JwmOe5C8HZ0Wvo96oUcgFs6jOImxpplh4lty4NT
        jEh2F2YvZQS3myRM3jWA9ZvUUg==
X-Google-Smtp-Source: AMrXdXu04vVZPp8ia2hR+/ydM5jArZZnEJ0FwctcRIDucgJOQcL0ewW9tLEZASuOZOHRw8DNQE7cbQ==
X-Received: by 2002:a05:6402:3220:b0:49e:1d59:794f with SMTP id g32-20020a056402322000b0049e1d59794fmr1522549eda.22.1673864112349;
        Mon, 16 Jan 2023 02:15:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7d781000000b0048ecd372fc9sm11290663edq.2.2023.01.16.02.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:15:11 -0800 (PST)
Message-ID: <7cffc639-3b61-1479-115c-34dffdfd8cc9@linaro.org>
Date:   Mon, 16 Jan 2023 11:15:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] ARM: dts: imx6qdl: support child mfd cells for the
 reset controller
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Bastian Krause <bst@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230113-syscon-child-mfd-v1-0-0dd31b7de373@pengutronix.de>
 <20230113-syscon-child-mfd-v1-2-0dd31b7de373@pengutronix.de>
 <392f6e9d-b7c2-37df-2067-f7d967a20f10@linaro.org>
 <12080bf5-2cc4-e215-555e-5438ed1bd851@pengutronix.de>
 <1b5613ad-6d0d-0979-ddd0-4677ade7beb9@linaro.org>
 <e492a90c-147c-a50b-80aa-86f47306cff0@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e492a90c-147c-a50b-80aa-86f47306cff0@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 10:26, Ahmad Fatoum wrote:
> On 16.01.23 10:14, Krzysztof Kozlowski wrote:
>> On 16/01/2023 09:27, Ahmad Fatoum wrote:
>>> Hello Krzysztof,
>>>
>>> On 16.01.23 09:20, Krzysztof Kozlowski wrote:
>>>> On 13/01/2023 18:32, Bastian Krause wrote:
>>>>> The actual syscon-reboot-mode child node can be added by a board
>>>>> device-tree or fixed up by the bootloader. For the child node to be
>>>>> probed, the compatible needs to include simple-mfd. The binding now
>>>>> specifies this, so have the SoC dtsi adhere to it.
>>>>>
>>>>> Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>>> Signed-off-by: Bastian Krause <bst@pengutronix.de>
>>>>> ---
>>>>>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>>>>> index ff1e0173b39be..b16be39458aa6 100644
>>>>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>>>>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>>>>> @@ -865,7 +865,8 @@ epit2: epit@20d4000 { /* EPIT2 */
>>>>>  			};
>>>>>  
>>>>>  			src: reset-controller@20d8000 {
>>>>> -				compatible = "fsl,imx6q-src", "fsl,imx51-src";
>>>>> +				compatible = "fsl,imx6q-src", "fsl,imx51-src",
>>>>> +					     "syscon", "simple-mfd";
>>>>
>>>> You need children here. Otherwise simple-mfd does not make sense. If you
>>>> expect something else to add children (I don't understand why, usually
>>>> reboot capability is fixed per SoC and only sometimes extended with some
>>>> other means), then this "else" will also change compatible.
>>>
>>> It's about syscon-reboot-mode, not syscon-reboot. Such modes are board-
>>> not soc-specific. 
>>
>> syscon-reboot-mode is also mostly SoC specific. What exactly would
>> differ on different boards? Register offsets of SoC component? Register
>> values used by SoC power management unit?
> 
> The modes supported. Let's say you want a bootloader mode that drops
> the board's bootloader into a fastboot gadget mode. You'd add a
> syscon-reboot-mode pointing at one of the non-volatile registers and
> you would define a magic value to indicate fastboot, both in the
> bootloader and Linux.

Bootloader and other firmware (e.g. ATF) is tightly tied to SoC, not to
board. There might be differences between firmware used and OS (e.g.
ChromeOS uses their own bootloader, different than Linux and Android on
the same SoC), but again this is not board specific.

> 
> In theory, the reboot mode could also talk to the bootrom[1] to change
> the bootsource. This is also not board-agnostic, because it may not
> make sense to have a spinor reboot mode if your board doesn't have one.
> 
> We have this scheme for STM32MP1 already and that's why I suggested
> Bastian to do it likewise for i.MX as he needs this functionality:
> https://lore.kernel.org/all/20201021102855.18026-1-a.fatoum@pengutronix.de/

I don't understand why you use clearly wrong patches as examples. Bad
patterns and bugs are not reason to use same approach.

The binding is wrong - you do not allow syscon-reboot-mode and if you
ever tested your patches, you would see the errors.

> https://elixir.bootlin.com/barebox/latest/source/arch/arm/dts/stm32mp151.dtsi#L44

Whether this part is correct, tricky to say. Why these offsets are not
valid for other board?


Best regards,
Krzysztof

