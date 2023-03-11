Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299EB6B599D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbjCKJGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCKJGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:06:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8434411CBC9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:06:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cy23so29888750edb.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678525596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zowTuWNW9XK1G8KnVImseow9x8MhvPdzG9vsjjSpvmU=;
        b=VuoACss0qcQNCyF7nKEwruQXM8LGr3AqsvT4nSr8D5RdN+4ssu+HI7SL0B3By5pQd6
         F4zhfdIXayE8QpQ5cY2SXeTYKso96M908nwQDfxwsdU6Y2NiAxyEQnYzNV8J0zb2oyER
         nH3X0tf7QVb0WlVslyUxp0zo+sY2YYSeV1xwDfZVK325oBMg73ofOWT8d3ht1cLbS+K6
         Thv1yXYZ+KxkYIYWG0Yd21prkxHDPrML+CioU2ey2Ghbg88oaHvY8A8aSxNMavgq3Nb2
         nPa+RMnThUmP52V5CCxSzbo43E/bPgvqy84VFN+OF4Cb8Vfu7qhmvRh0c+yop1wNTX+u
         Q7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678525596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zowTuWNW9XK1G8KnVImseow9x8MhvPdzG9vsjjSpvmU=;
        b=T87mNpAHona/1hc4cikYa30S2iX8L0S6aOv8wxiprvdlIpdX9oYdN4kwcjbxX7FjzU
         guJodo5qD7/7xUEbw1fRww6uUlfvF06ytqaUFrIlOpWx+KiLeYgFF5Edrno0qcd+mDzI
         NUmHrSLEY0lJa554vemCokNJbh87/PzLksJXWyMoFO6IP4wl75Thq84TTz8ViNiCA20w
         OKdgm5v6Z+DDLesZPcqh7jONck0/Z1DbBy5jTIrsuCsZxOmY/C2bSKC1P7qbePnjUTwK
         HGSY+vkNI9BrCby+zlnrRYpG2S+rJE7eiixFW4TMuTdX2KrFjoENrfW97nsp6qUT/khg
         DEVg==
X-Gm-Message-State: AO0yUKU+tFclJyUc68Y0q2NA7p9F8n7tXiFuS5L5k2kyt7gtCvFpgGRU
        CHyrWkWlIU35WxfkjF5TDYSsWQ==
X-Google-Smtp-Source: AK7set90tSUkimrYFxcnFBlQ+OiRBGzIs1ZDtM8PuhvEals3K2QMWWdBOGGWH+ZiYB3eTWkRek251Q==
X-Received: by 2002:a17:906:ce39:b0:8aa:f2f2:7543 with SMTP id sd25-20020a170906ce3900b008aaf2f27543mr27382374ejb.29.1678525596014;
        Sat, 11 Mar 2023 01:06:36 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b? ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id mj16-20020a170906af9000b008c33ebac259sm878569ejb.127.2023.03.11.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 01:06:35 -0800 (PST)
Message-ID: <d993fc28-1bb5-0a05-c7d2-4891038328e6@linaro.org>
Date:   Sat, 11 Mar 2023 10:06:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: leds: Document rohm,bd65b60 bindings
To:     Bogdan Ionescu <bogdan.ionescu.work@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.or, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308201451.11629-1-bogdan.ionescu.work@gmail.com>
 <c0ec5137-ed86-d695-7335-d1564d814862@linaro.org>
 <CALfPHoVT007ifyTepr_p-saDQtv5Sk7iYXM4qSMXyaCLL3iE2A@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CALfPHoVT007ifyTepr_p-saDQtv5Sk7iYXM4qSMXyaCLL3iE2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 11:41, Bogdan Ionescu wrote:
> Thanks for the feedback, I am working on addressing the issues you have
> raised. If I haven't mentioned something, please assume I am implementing
> your suggestion.
> 
>>> +    properties:
>>> +      rohm,enable-outputs:
>>
>> I don't understand why do you need this property. You should use
>> generic/existing properties, if possible.
> 
>> Drop led object. There is no real need for it, is it?
> 
> Would this structure be more appropriate:
> 
> + led-controler@64 {
> +     compatible = "rohm,bd65b60";
> +     reg = <0x64>;
> +     default-state = "keep";
> +     linux,default-trigger = "backlight";
> +
> +     led@1 {
> +         reg = <1>;
> +         function = LED_FUNCTION_BACKLIGHT;
> +         color = <LED_COLOR_ID_WHITE>;
> +     };
> +
> +     led@2 {
> +         reg = <2>;
> +         function = LED_FUNCTION_BACKLIGHT;
> +         color = <LED_COLOR_ID_WHITE>;
> +     };
> + };
> 
> Can I have 2 led nodes if they share the same brightness?

I think yes, but what about LED on/off? Is it also shared or separate?
Because if it is shared, then basically it is just one LED...

> 
>>> +        enum: [ 0, 8, 16 ]
>>> +        default: 16
>>
>> What are the units? percent? Volts? Then use unit suffix in property
>> name. Your other file suggests volts so make it microvolts.
> 
> The chip has 3 possible values 25V, 30V and 35V. How should the driver
>  handle a value that is not exactly that?
> Should it round down for safety or return an error?

Then use -microvolt and real units
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml


> 
> This was the reason for creating the bindings header file.
> Is it possible to reference defines from the bindings header file?
> 
> + enum:
> +   - BD65B60_OVP_25V
> +   - BD65B60_OVP_30V
> +   - BD65B60_OVP_35V
> + default: BD65B60_OVP_35V
> 
> I would prefer it if I didn't have to expose the weird bitmasks that ROHM
> have decided to use and instead use the actual values.
> 
> Apologies for the long email, but I wanted to make sure I was clear.




Best regards,
Krzysztof

