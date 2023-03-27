Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2EC6CA981
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjC0PrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbjC0PrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:47:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5565C2113
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:47:21 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id fd25so5993128pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679932041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7tv73jSNqfHmt4DCwlLY8nz3A8KmKibtRmlvCUDC90=;
        b=YKzk6g4t7aiHs3R2sUJ4039eVRFIn2Y4Yh6CTfv+mLZ/QMQAZ3pUhY+w4fZpDt01ok
         yfMTwEDfpQ/ArS/ZsgfLeT6B+nBy9+YTgxlrUHuaOZR0AXyJ6cjmfbRxaU43kPYVdNQN
         biISvgxUhHnLV8figliz0mSrk2+Aen1FBRZOaDiKntJYu0RpWRV4jjTxe6dakHnIv1QG
         AEssgFVOXP8lx6J3+Plv8AOmKfRCEjTgnN77q8movbklo7IE0jVcKasDYX3yT/KIwZy6
         QtuqkIgd2eIvWMXKJ4ajQE0qBTSCOt2HMiEWD1hD5bI1Qt+99Wu+QDh/J5TnMlD4tRWa
         SgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7tv73jSNqfHmt4DCwlLY8nz3A8KmKibtRmlvCUDC90=;
        b=KGOaPHmrVW5gToUlRal/xdE0lrAEHqE2tCSI7TgmxovOoAv+6CHZI2IZ7V2k1WrUbP
         d0VWooXa44uBsoJUVkN/miSt9htLF3fUvoigZjoLvRZGi0oTdda1R+wrGZuq89z0QggN
         rkTJwRFrQt4DJCuMu+sCf7XOrsF2AH/Hwp3oraWkHtdWa4OTDYgnI1E3/Va7pVWgGCHh
         lyIMKuuiqILksueRQlJ6NPvyisJ8bFLbV+vjLYGMwxI2QIeRNpq/A/gy2VVZOlRpPCMI
         dGrnnRRjLTHGlWVG+Ukxu99G/Y2Yfh8pb9liXZdBHy+4qeNyA63g5pSA+aQ0bpKPEH8Z
         l5MA==
X-Gm-Message-State: AAQBX9e2D1wRYRutIw/7jSmrzFFFdRQnf8kfdaHWbIjCTwHlB5dxNtHK
        xRtYFKDPt7WOzpceKN9Em9q+wg==
X-Google-Smtp-Source: AKy350aPdKZpoXQW0ZwfzEE5ftsDBqDawZzd0DYrv1yPU3BKElGSZj7xOPj6Z9kddnAdkXrw022VcA==
X-Received: by 2002:a62:1794:0:b0:624:f1f2:234a with SMTP id 142-20020a621794000000b00624f1f2234amr9877214pfx.23.1679932040749;
        Mon, 27 Mar 2023 08:47:20 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id u20-20020aa78394000000b00608dae58695sm19080379pfm.209.2023.03.27.08.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 08:47:20 -0700 (PDT)
Message-ID: <2077c7e1-cf69-8648-20ac-23793f92ad14@9elements.com>
Date:   Mon, 27 Mar 2023 21:17:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] leds: max597x: Add support for max597x
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230323194550.1914725-2-Naresh.Solanki@9elements.com>
 <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
 <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
 <cf18bc52-af25-8ce0-3536-202ea3c6e86d@wanadoo.fr>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <cf18bc52-af25-8ce0-3536-202ea3c6e86d@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24-03-2023 09:06 pm, Christophe JAILLET wrote:
> Le 24/03/2023 à 11:54, Naresh Solanki a écrit :
>> Hi,
>>
>> On 24-03-2023 01:48 am, Christophe JAILLET wrote:
>>> Le 23/03/2023 à 20:45, Naresh Solanki a écrit :
>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>
>>>> max597x is hot swap controller with indicator LED support.
>>>> This driver uses DT property to configure led during boot time &
>>>> also provide the LED control in sysfs.
>>>>
> 
> [...]
> 
> 
>>>> +static int max597x_led_probe(struct platform_device *pdev)
>>>> +{
>>>> +    struct device_node *np = dev_of_node(pdev->dev.parent);
>>>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>>> +    struct device_node *led_node;
>>>> +    struct device_node *child;
>>>> +    int ret = 0;
>>>> +
>>>> +    if (!regmap)
>>>> +        return -EPROBE_DEFER;
>>>> +
>>>> +    led_node = of_get_child_by_name(np, "leds");
>>>> +    if (!led_node)
>>>> +        return -ENODEV;
>>>> +
>>>> +    for_each_available_child_of_node(led_node, child) {
>>>> +        u32 reg;
>>>> +
>>>> +        if (of_property_read_u32(child, "reg", &reg))
>>>> +            continue;
>>>> +
>>>> +        if (reg >= MAX597X_NUM_LEDS) {
>>>> +            dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>>>> +                MAX597X_NUM_LEDS);
>>>> +            continue;
>>>> +        }
>>>> +
>>>> +        ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>>>> +        if (ret < 0)
>>>> +            of_node_put(child);
>>>
>>> This of_node_put() looks odd to me.
>> Not sure if I get this right but if led setup fails of_node_put should 
>> be called.
> 
> My understanding is that this of_node_put() is there in case of error, 
> to release what would otherwise never be released by 
> for_each_available_child_of_node() if we exit early from the loop.
> 
> If the purpose is to release a reference taken in max597x_setup_led() in 
> case of error:
>     - this should be done IMHO within max597x_setup_led() directly
>     - there should be a of_node_get() somewhere in max597x_setup_led()
>       (after:
>      if (of_property_read_string(nc, "label", &led->led.name))
>          led->led.name = nc->name;
>        + error handling path,  *or*
>       just before the final return ret; when we know that everything is 
> fine,
>       if I understand correctly the code)
> 
> Is the reference taken elsewhere?
> Did I miss something obvious?
> 
> 
One of the reference is "drivers/leds/leds-sc27xx-bltc.c" line 311
Please do let me know if I have to do anything about it.

>>> "return ret;" or "break;" missing ?
>>>
>> Didn't add a break so that it can continue initializing remaining led 
>> if any.
> 
> Ok. Don't know the code enough to see if correct or not, but based on my 
> comment above, I think that something is missing in max597x_setup_led() 
> and that errors should be silently ignored here.
In my implementation, I have chosen to continue with the next LED if an 
error occurs, rather than aborting the 'for loop' with an error. I have 
seen other implementations also done in a similar way.
Do you have any further inputs or suggestions on this approach.

> 
> CJ
> 
>>>> +    }
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
> 
> [...]
> 
Regards,
Naresh
