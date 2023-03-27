Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B69F6CAC38
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjC0RuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjC0Rt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:49:56 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EA01BE7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:49:53 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id o2so9176244plg.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679939393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4f5h2DFlqvcmV9pqrippqGw8S/ID21eu8B8xXXSJvY=;
        b=Mvk1bsNYS+CBDSr9ESNlx3keWydnPpQyoDFOWZ9YYXC/2CYeN0nZLegTO2mYV+JIrD
         F2JlRq5osS4m9X+oh/9REK87lI5zRkpAG/m04Agsa1AQhgQ2YE/bNisUZyUVOvpcXItu
         kEd4e1iV49fJ712x6ENOw3ilvQKjYqr8j6H8SEoBvxxRAsSn6rrrNiaq8vXYGyVV31LX
         sqH23wS6Zsa9DFXlgl6MGSE5sNAEPxRpsg0VG1K4Yii5bbmMiNTiCyKImbDX/kLGsDVp
         3wGzOhdQE8PoyEMGvErUdD1DSNf0Yhkk/T32qxXdrYOd77ZqgYNOSwoDBlU/roYEbpC6
         v6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679939393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4f5h2DFlqvcmV9pqrippqGw8S/ID21eu8B8xXXSJvY=;
        b=UR2v7tGLyFfkO2eWx5NwZ+DyP+pq0W6/xLQVtu+Wvndx4yWRYLcOKWpM8kPrJh0OtC
         K/Sr51/9nGkLcns3auq1Og9GhdsV0u1J/RwsBV7YSPH/82rHqgHoqD2ztUSlH9qUcdq/
         Mcum59wRqsX2Sb7tUr79HGhZV0cD0+/DYEAVSuwmmypDiwqKVHdcrkJSjx0fJPLuDLXj
         YGw6891Pohojuh5GFRhIz20+zNncmd7WLj6qyvWhT9Fa7gihuRwE0Z2HDw4qQ+jWn31x
         Fn8ZYf1CegRyY8raL522yzia7tNii4Iy9Qh4rCKgd1HrpcGeLPCIYOmY4icZUQBI12wO
         2ZKw==
X-Gm-Message-State: AAQBX9dx7WGby5dM1V7QmfP02sbFKWrJ0n+kSJoia7+/FsbPvF1jUz9D
        ZZjEPJDSuwR2AIpIPm3w6nGClw==
X-Google-Smtp-Source: AKy350ZN8y1wHhrKMzs1OKjBk07aV1uh2PuCW6P+QSe5GoisDVxxCs6fCy8ettxlP1de82KZNCsGHA==
X-Received: by 2002:a17:902:d48a:b0:19f:3617:e9e9 with SMTP id c10-20020a170902d48a00b0019f3617e9e9mr17646263plg.43.1679939393112;
        Mon, 27 Mar 2023 10:49:53 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id j4-20020a170903028400b0019a723a831dsm19534686plr.158.2023.03.27.10.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 10:49:52 -0700 (PDT)
Message-ID: <05278bcb-7324-99b4-5442-ac44b2cdeed5@9elements.com>
Date:   Mon, 27 Mar 2023 23:19:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] leds: max597x: Add support for max597x
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20230323194550.1914725-1-Naresh.Solanki@9elements.com>
 <20230323194550.1914725-2-Naresh.Solanki@9elements.com>
 <d6463018-ebdf-30b2-ce0e-f2b5198847f1@wanadoo.fr>
 <688423c6-ba98-002c-efe5-7b0997d6af73@9elements.com>
 <cf18bc52-af25-8ce0-3536-202ea3c6e86d@wanadoo.fr>
 <2077c7e1-cf69-8648-20ac-23793f92ad14@9elements.com>
 <9567ac67-0c4c-0599-7141-9137837f79e2@wanadoo.fr>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <9567ac67-0c4c-0599-7141-9137837f79e2@wanadoo.fr>
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

On 27-03-2023 10:50 pm, Christophe JAILLET wrote:
> Le 27/03/2023 à 17:47, Naresh Solanki a écrit :
>> Hi,
>>
>> On 24-03-2023 09:06 pm, Christophe JAILLET wrote:
>>> Le 24/03/2023 à 11:54, Naresh Solanki a écrit :
>>>> Hi,
>>>>
>>>> On 24-03-2023 01:48 am, Christophe JAILLET wrote:
>>>>> Le 23/03/2023 à 20:45, Naresh Solanki a écrit :
>>>>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>>>>
>>>>>> max597x is hot swap controller with indicator LED support.
>>>>>> This driver uses DT property to configure led during boot time &
>>>>>> also provide the LED control in sysfs.
>>>>>>
>>>
>>> [...]
>>>
>>>
>>>>>> +static int max597x_led_probe(struct platform_device *pdev)
>>>>>> +{
>>>>>> +    struct device_node *np = dev_of_node(pdev->dev.parent);
>>>>>> +    struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
>>>>>> +    struct device_node *led_node;
>>>>>> +    struct device_node *child;
>>>>>> +    int ret = 0;
>>>>>> +
>>>>>> +    if (!regmap)
>>>>>> +        return -EPROBE_DEFER;
>>>>>> +
>>>>>> +    led_node = of_get_child_by_name(np, "leds");
>>>>>> +    if (!led_node)
>>>>>> +        return -ENODEV;
>>>>>> +
>>>>>> +    for_each_available_child_of_node(led_node, child) {
>>>>>> +        u32 reg;
>>>>>> +
>>>>>> +        if (of_property_read_u32(child, "reg", &reg))
>>>>>> +            continue;
>>>>>> +
>>>>>> +        if (reg >= MAX597X_NUM_LEDS) {
>>>>>> +            dev_err(&pdev->dev, "invalid LED (%u >= %d)\n", reg,
>>>>>> +                MAX597X_NUM_LEDS);
>>>>>> +            continue;
>>>>>> +        }
>>>>>> +
>>>>>> +        ret = max597x_setup_led(&pdev->dev, regmap, child, reg);
>>>>>> +        if (ret < 0)
>>>>>> +            of_node_put(child);
>>>>>
>>>>> This of_node_put() looks odd to me.
>>>> Not sure if I get this right but if led setup fails of_node_put 
>>>> should be called.
>>>
>>> My understanding is that this of_node_put() is there in case of 
>>> error, to release what would otherwise never be released by 
>>> for_each_available_child_of_node() if we exit early from the loop.
>>>
>>> If the purpose is to release a reference taken in max597x_setup_led() 
>>> in case of error:
>>>     - this should be done IMHO within max597x_setup_led() directly
>>>     - there should be a of_node_get() somewhere in max597x_setup_led()
>>>       (after:
>>>      if (of_property_read_string(nc, "label", &led->led.name))
>>>          led->led.name = nc->name;
>>>        + error handling path,  *or*
>>>       just before the final return ret; when we know that everything 
>>> is fine,
>>>       if I understand correctly the code)
>>>
>>> Is the reference taken elsewhere?
>>> Did I miss something obvious?
>>>
>>>
>> One of the reference is "drivers/leds/leds-sc27xx-bltc.c" line 311
>> Please do let me know if I have to do anything about it.
> By reference, I was speaking of reference taken by a of_node_get() call 
> and released by a of_node_put() call.
> 
> Anyway, I do agree with leds-sc27xx-bltc.c.
> There is a of_node_put() because for_each_available_child_of_node() 
> won't be able to do it by itself *in case of early return* ("return err;")
> 
> In all other paths (when the loop goes to the end), the reference taken 
> by for_each_available_child_of_node() is also released, on the next 
> iteration, by for_each_available_child_of_node().
> 
> In *your* case, if you don't break or return, there is no need to call 
> of_node_put() explicitly. It would lead to a double put. (yours and the 
> one that will be done by for_each_available_child_of_node()).
> 
> Have a look at for_each_available_child_of_node() and more specifically 
> at of_get_next_available_child().
> 
> At the first call 'child' is NULL. A ref is taken [1]. Nothing is released.
> For following calls, a new ref is taken on a new node [1], and the 
> previous reference is released [2].
> On the last call, the 'for' loop will not be executed because there is 
> nothing to scan anymore. No new reference is taken, and the previous 
> (and last) refence is finally released [2].
Yes you are right. That of_node_put would be duplicate as it is already 
taken care by the for loop.
Will remove that in next revision.
> 
> 
> [1]: 
> https://elixir.bootlin.com/linux/v6.3-rc3/source/drivers/of/base.c#L808
> [2]: 
> https://elixir.bootlin.com/linux/v6.3-rc3/source/drivers/of/base.c#L811
> 
>>
>>>>> "return ret;" or "break;" missing ?
>>>>>
>>>> Didn't add a break so that it can continue initializing remaining 
>>>> led if any.
>>>
>>> Ok. Don't know the code enough to see if correct or not, but based on 
>>> my comment above, I think that something is missing in 
>>> max597x_setup_led() and that errors should be silently ignored here.
>> In my implementation, I have chosen to continue with the next LED if 
>> an error occurs, rather than aborting the 'for loop' with an error. I 
>> have seen other implementations also done in a similar way.
>> Do you have any further inputs or suggestions on this approach.
> 
> No, sorry, I won't be of any help on what design is the best.
> 
> CJ
> 
Regards,
Naresh
