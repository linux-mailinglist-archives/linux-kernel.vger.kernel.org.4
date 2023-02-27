Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739A6A4529
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjB0Ouv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjB0Out (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:50:49 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765B8212AB;
        Mon, 27 Feb 2023 06:50:48 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id h10so4034756ila.11;
        Mon, 27 Feb 2023 06:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L+jYyq1jhOJX4L8R02OOarqFh4Kn9adYP/VGoKDxS3Y=;
        b=nNOIXYN7JiHPmx34v6yMlx1tq5eUxFsnvQTj7QKj2zffdl3f/8TTirINmPwsHtqoIk
         PaOZfE257b4iBHJCytvTZP6mZoYsA7cycoYXmeNxfceEgV9wfd3i93XkP6+RMW6O/WOe
         Up6mtIxn6Q4kqtv0YJfB37mJRh63CzAbBbVM6h+hesHAb2QWyPgfZ10zCG7BMkEqXSff
         DvOUeGxkj2G+eBB24Pfvhm11wMxnMDwOgtJitlHbcAik1hG/VJXJ/Wixa8Z1xlUSLKWm
         GB0C039siTeYlazbQ+1jXbxRYDYJfNTiPo5cglaocrWk63Bpnw6ic2pxWaBnz0kCEtsf
         depQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+jYyq1jhOJX4L8R02OOarqFh4Kn9adYP/VGoKDxS3Y=;
        b=SGPU24RFJlGQKqEF7JWLrgpXSENaLQ8mFdEpFn2nNi/qXB5Iwg5KY/MXZqcZMSWQ5J
         J7TMp8gyxPOLBokuOtqx7siNmysMZeGyTwuQqZrLLdXRJ7/8KPuf47m0u/QXjUCMyVE8
         bLa3jSlcLRUtlNar7hpJpko8CHjxEaEE7fsv7ABW3YtM1jzSO9vIA/sNTwruF8MfI12X
         pCMzqAl3IzZGhoVhjaosHRgReb+jiMpTO4kfAWJ/luKfut5oO76mBj9bFRF57Pf3ZtEH
         WAMmAlmhb1TlwXbkhUU40moP4wKiW4l8wMJNu4UoKBFx1m0JU3MzmBVUWXnHEL+yrZJP
         Xglg==
X-Gm-Message-State: AO0yUKXjjAG+m8WNf8CLOgOQqROPYicr/G0m5jiROxr4DpycshY21TCe
        MlwgMomKMxrAq6DKef0XhAg=
X-Google-Smtp-Source: AK7set/5YiCfPaih4CO+pmCM2/MrPak5lsrv8POHxOAFXyUa0OqdaFeC6cXDbBKhR/j9tNcIvnmjEg==
X-Received: by 2002:a05:6e02:1906:b0:315:3252:655f with SMTP id w6-20020a056e02190600b003153252655fmr23175858ilu.21.1677509447731;
        Mon, 27 Feb 2023 06:50:47 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23-20020a02a797000000b003c4f902cca5sm2124648jaj.172.2023.02.27.06.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:50:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a7ffe026-a48b-9ffd-20d3-7d25caba120d@roeck-us.net>
Date:   Mon, 27 Feb 2023 06:50:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/2] drivers: watchdog: Add StarFive Watchdog driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20230220081926.267695-1-xingyu.wu@starfivetech.com>
 <20230220081926.267695-3-xingyu.wu@starfivetech.com>
 <20230223182341.GA200380@roeck-us.net>
 <8ba002ea-299c-2eaf-b1a7-d7d38a540152@starfivetech.com>
 <ae998eb6-54ce-05c4-2961-bdb2393eac64@roeck-us.net>
 <58cab864-2a59-b82c-bdfe-2e805a04fd7a@starfivetech.com>
 <547a469d-eeaa-750c-4fe5-cc82d92493a6@roeck-us.net>
 <2b79e1ac-3399-075d-1d1d-e6d7f88351fc@starfivetech.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2b79e1ac-3399-075d-1d1d-e6d7f88351fc@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 22:45, Xingyu Wu wrote:
> On 2023/2/27 14:36, Guenter Roeck wrote:
>> On 2/26/23 22:26, Xingyu Wu wrote:
>>> On 2023/2/24 23:18, Guenter Roeck wrote:
>>>> On 2/23/23 23:42, Xingyu Wu wrote:
>>>>> On 2023/2/24 2:23, Guenter Roeck wrote:
>>>>>> On Mon, Feb 20, 2023 at 04:19:26PM +0800, Xingyu Wu wrote:
>>>>>>> [...]
>>>>>>> +
>>>>>>> +    wdt->wdt_device.min_timeout = 1;
>>>>>>> +    wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
>>>>>>
>>>>>>       wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>>>
>>>>>> should be set here. Otherwise the warning below would always be seen
>>>>>> if the module parameter is not set.
>>>>>>
>>>>>>> +
>>>>>>> +    watchdog_set_drvdata(&wdt->wdt_device, wdt);
>>>>>>> +
>>>>>>> +    /*
>>>>>>> +     * see if we can actually set the requested heartbeat,
>>>>>>> +     * and if not, try the default value.
>>>>>>> +     */
>>>>>>> +    watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>>>>>> +    if (wdt->wdt_device.timeout == 0 ||
>>>>>>
>>>>>> If wdt->wdt_device.timeout is pre-initialized, it will never be 0 here.
>>>>>>
>>>>>>> +        wdt->wdt_device.timeout > wdt->wdt_device.max_timeout) {
>>>>>>
>>>>>> That won't happen because watchdog_init_timeout() validates it and does
>>>>>> not update the value if it is out of range.
>>>>>>
>>>>>>> +        dev_warn(dev, "heartbeat value out of range, default %d used\n",
>>>>>>> +             STARFIVE_WDT_DEFAULT_TIME);
>>>>>>> +        wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>>>
>>>>>> And this is then unnecessary. wdt->wdt_device.timeout will always be
>>>>>> valid if it was pre-initialized.
>>>>>
>>>>> It is changed to be this at beginning of the driver:
>>>>>
>>>>> static int heartbeat = STARFIVE_WDT_DEFAULT_TIME;
>>>>>
>>>>
>>>> No, this is wrong. The static variable should be set to 0 to indicate
>>>> "use default".
>>>>
>>>>> and it is changed to be this here:
>>>>>
>>>>> ret = watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>>>> if (ret)
>>>>>       return ret;
>>>>>
>>>>> Would that be better?
>>>>>
>>>>
>>>> No, it is worse, because it would not instantiate the watchdog at all
>>>> if a bad heartbeat is provided.
>>>>
>>>
>>> So instantiate the watchdog with hearbeat first. And if this wrong, use default timeout.
>>> :
>>> if (watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev))
>>>      wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>
>>
>> I am kind of lost why you have to make it that complicated.
>> Just pre-initialize wdt->wdt_device.timeout like all the other drivers do,
>> and as I had suggested earlier.
>>
> 
> So you mean just use :
> wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> to initialize watchdog directly?
> 

Yes, as I had suggested before, before calling watchdog_init_timeout().

Guenter

> Best regards,
> Xingyu Wu

