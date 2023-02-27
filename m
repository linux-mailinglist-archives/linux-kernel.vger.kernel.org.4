Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACC6A3B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 07:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB0Gg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 01:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjB0Gg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 01:36:27 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FED213DEA;
        Sun, 26 Feb 2023 22:36:26 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id b16so2148895iof.11;
        Sun, 26 Feb 2023 22:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7sO0bMZpYnxMStsyVe05Epx0NsAkdFcv2H7c43sQOtg=;
        b=qpzx4DzoLh+ZvlV8hCI6D/z4v46S+1TSahmFrC5pQHpJ5RUJvDP9ynRENQNeojzNmV
         3ZpisoHp/sC7u3cH1gUJI0USNXj3J8aKS/mB/+LViFfkKhvLgmEALcuSWxFqx8+gB+if
         xMC2abo0dxMa9/uz9dmlzHJNXDJ3yMwyOKhXD8ZK1XC4ds1K3ILJnBgLp6wH8nJArqmC
         mgM/H/+GwU37rOhZ4xf/jrGBhnMKUg25YU5912TLCVU6eZUT4+8mTsXg1euxun7aGhoe
         nUkjkbydqjK0FI12Nl5CuZ9UHowmiCQLI0vSY5frlYbvZSdqI/N4GXDuKRVJA2PXS6te
         MXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sO0bMZpYnxMStsyVe05Epx0NsAkdFcv2H7c43sQOtg=;
        b=UkW9he23R/P5+1WHVwEC+pyFz0gk41NdgIFm6JEfH/EKd/CoNS8lfj3CvTxqzFHVyq
         2fWgO5/86dNgXYAMpnCWjziHZHhDC03o7sEReujuyVAG5aDHgF8a3dPLY9ey4kOI/7xU
         fVtpAIYvbNCC4XWwIhZANxwNM4X6r/z6tOipLwU9z9LEpPFLFfR6LJlHq8NlOjni3xk/
         NW2hMaoCfQTw/DBNHraQWJqBv0bsulhamRIMsXX+XEluvvC4RJe68/nUo/ShRJTXVj8Z
         kX44cEOwYaJLTjy7e5tbQCRCxR7QQAhqL0toJpoKYsQVviRVmOw3nboz3OuC1lzmUg6Z
         NpSQ==
X-Gm-Message-State: AO0yUKV4A1M+t2iBWkwtH/dL7953c2raMsiP6d2aK2unSAH7uKhVj+rV
        kuqBcw/kQqoHiptStbTQbHFOAVR5sFQ=
X-Google-Smtp-Source: AK7set8J7OQnEUJHpOVjsdWjF01bozA5t8Z//DgdLIKheUKUy31nZSR+PgKd5tGVJMFuIP6PSbMHZA==
X-Received: by 2002:a5d:8b56:0:b0:74c:87b5:a083 with SMTP id c22-20020a5d8b56000000b0074c87b5a083mr14708547iot.17.1677479785615;
        Sun, 26 Feb 2023 22:36:25 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f11-20020a6bdd0b000000b0073a658f7951sm1784739ioc.48.2023.02.26.22.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 22:36:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <547a469d-eeaa-750c-4fe5-cc82d92493a6@roeck-us.net>
Date:   Sun, 26 Feb 2023 22:36:22 -0800
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
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <58cab864-2a59-b82c-bdfe-2e805a04fd7a@starfivetech.com>
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

On 2/26/23 22:26, Xingyu Wu wrote:
> On 2023/2/24 23:18, Guenter Roeck wrote:
>> On 2/23/23 23:42, Xingyu Wu wrote:
>>> On 2023/2/24 2:23, Guenter Roeck wrote:
>>>> On Mon, Feb 20, 2023 at 04:19:26PM +0800, Xingyu Wu wrote:
>>>>> [...]
>>>>> +
>>>>> +    wdt->wdt_device.min_timeout = 1;
>>>>> +    wdt->wdt_device.max_timeout = starfive_wdt_max_timeout(wdt);
>>>>
>>>>      wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>
>>>> should be set here. Otherwise the warning below would always be seen
>>>> if the module parameter is not set.
>>>>
>>>>> +
>>>>> +    watchdog_set_drvdata(&wdt->wdt_device, wdt);
>>>>> +
>>>>> +    /*
>>>>> +     * see if we can actually set the requested heartbeat,
>>>>> +     * and if not, try the default value.
>>>>> +     */
>>>>> +    watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>>>> +    if (wdt->wdt_device.timeout == 0 ||
>>>>
>>>> If wdt->wdt_device.timeout is pre-initialized, it will never be 0 here.
>>>>
>>>>> +        wdt->wdt_device.timeout > wdt->wdt_device.max_timeout) {
>>>>
>>>> That won't happen because watchdog_init_timeout() validates it and does
>>>> not update the value if it is out of range.
>>>>
>>>>> +        dev_warn(dev, "heartbeat value out of range, default %d used\n",
>>>>> +             STARFIVE_WDT_DEFAULT_TIME);
>>>>> +        wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
>>>>
>>>> And this is then unnecessary. wdt->wdt_device.timeout will always be
>>>> valid if it was pre-initialized.
>>>
>>> It is changed to be this at beginning of the driver:
>>>
>>> static int heartbeat = STARFIVE_WDT_DEFAULT_TIME;
>>>
>>
>> No, this is wrong. The static variable should be set to 0 to indicate
>> "use default".
>>
>>> and it is changed to be this here:
>>>
>>> ret = watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev);
>>> if (ret)
>>>      return ret;
>>>
>>> Would that be better?
>>>
>>
>> No, it is worse, because it would not instantiate the watchdog at all
>> if a bad heartbeat is provided.
>>
> 
> So instantiate the watchdog with hearbeat first. And if this wrong, use default timeout.
> :
> if (watchdog_init_timeout(&wdt->wdt_device, heartbeat, dev))
> 	wdt->wdt_device.timeout = STARFIVE_WDT_DEFAULT_TIME;
> 

I am kind of lost why you have to make it that complicated.
Just pre-initialize wdt->wdt_device.timeout like all the other drivers do,
and as I had suggested earlier.

Guenter

