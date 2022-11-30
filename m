Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D695A63CE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 04:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiK3Dp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 22:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiK3DoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 22:44:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBEAE0C8;
        Tue, 29 Nov 2022 19:43:54 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jn7so15405299plb.13;
        Tue, 29 Nov 2022 19:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q2iyrgtYDuQKt/kE7+C53HCWQJvUcvpFAzkZEkz/5Fk=;
        b=arIafAEMNCqxxUJ6A8NnFQ1SoS9OnNxJfCm0VwcbDkv2lL2Clx8ewRYqQsEHNp6a+o
         CWy6BkJol8zZo2XRRAyqSsvf5qmIeI/AYSnXJhIjd2RNSR8SuUJ1FIqXt39e0SQUeyO+
         RT5BZkQDKd+UFdqHgmSCYtLUsznQf7QB2LtRgvf7qDNiUFraKaCt6M411grsfG0EzdkZ
         L+c7FpPe/3jlZGh9TFsb6lzm5b4IUNm0T4z6mNmVIu4JSZ/wI8HTn0X7MI89GIQNxtf8
         xUjGICCQmMJToDxY9Fyym4SGqZIQjjf0hhCq6OdC1olzrhM4MI6P5gCO7PILN3o/2htV
         6UZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2iyrgtYDuQKt/kE7+C53HCWQJvUcvpFAzkZEkz/5Fk=;
        b=xOq02Mtm4j5v7wMPrxn7Tf3Tvm+Y7COYMSVJ6i2lrGtp8t0eKuNNCH7Y/8vb4/SII8
         jRY6q0rxwSv0/k8NpvZUI/ItopFL+DMDWdk/qcsVWa5vIL9ocKEBnOcUwfgbYQixhjjZ
         Yzwtopdvpaw/4AKioJ9Kb/np51Dnm3Zl4qpg25/Nn8ma+ZZ7RA9WuZ2IspjCCxILtofu
         hl+19FCoTMu18Gxh0KP1laMm6arH6iMyRvvR+SZPH/l9zWKiNieqkQEtJS/PLp0QghtD
         HYsQveWsUu6BzJwG9frZv302Zjz+c2rXbGrymfGBcU/eFozNi8aZrfD/OY3h4Pelzxmc
         paqQ==
X-Gm-Message-State: ANoB5pk40imTSb3zXJk+XOaGfRsovPdDl2u8yo0RTaC+CFSUHTmuEZND
        XX1WrzRziuKd+7p0ihrTPuE=
X-Google-Smtp-Source: AA0mqf6RgG4UbvdUAsdQcRV2TiZBLISWyGOQCPavRvxQ949guJf0YWnsneE94lxtpEV8RpHBZcMBHQ==
X-Received: by 2002:a17:902:7d89:b0:188:4ba9:79ee with SMTP id a9-20020a1709027d8900b001884ba979eemr40717697plm.83.1669779833723;
        Tue, 29 Nov 2022 19:43:53 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-61.three.co.id. [116.206.28.61])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903028600b00189758e2babsm88850plr.125.2022.11.29.19.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 19:43:53 -0800 (PST)
Message-ID: <d6f53bbc-34b9-dcef-b37f-d4babb8b7a4d@gmail.com>
Date:   Wed, 30 Nov 2022 10:43:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 5/7] hte: Re-phrase tegra API document
Content-Language: en-US
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev
References: <20221103174523.29592-1-dipenp@nvidia.com>
 <20221103174523.29592-6-dipenp@nvidia.com> <Y2XZj4j/NQH2igvJ@debian.me>
 <5145d9d3-d3ae-e95a-6583-803f31d6d9b7@nvidia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <5145d9d3-d3ae-e95a-6583-803f31d6d9b7@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 10:34, Dipen Patel wrote:
>> I think the wording can be better:
> I do  not understand, can you please elaborate?

Exactly where? Please quote appropriate hunks from below where do you not
understand.

>>
>> ---- >8 ----
>>
>> diff --git a/Documentation/driver-api/hte/tegra194-hte.rst b/Documentation/driver-api/hte/tegra194-hte.rst
>> index 85e654772782c1..13c45bfc03a75e 100644
>> --- a/Documentation/driver-api/hte/tegra194-hte.rst
>> +++ b/Documentation/driver-api/hte/tegra194-hte.rst
>> @@ -5,11 +5,11 @@ HTE Kernel provider driver
>>  
>>  Description
>>  -----------
>> -The Nvidia tegra HTE provider also known as GTE (Generic Timestamping Engine)
>> -driver implements two GTE instances: 1) GPIO GTE and 2) LIC
>> -(Legacy Interrupt Controller) IRQ GTE. Both GTE instances get the timestamp
>> -from the system counter TSC which has 31.25MHz clock rate, and the driver
>> -converts clock tick rate to nanoseconds before storing it as timestamp value.
>> +The Nvidia tegra HTE provider, also known as GTE (Generic Timestamping Engine)
>> +driver implements two GTE instances: GPIO GTE and LIC (Legacy Interrupt
>> +Controller) IRQ GTE. Both GTE instances get the timestamp from system counter
>> +TSC which has 31.25MHz clock rate, and the driver converts clock tick rate to
>> +nanoseconds before storing it as timestamp value.
>>  
>>  GPIO GTE
>>  --------
>> @@ -19,17 +19,17 @@ needs to be configured as input. Only the always on (AON) GPIO controller
>>  instance supports timestamping GPIOs in real time as it is tightly coupled with
>>  the GPIO GTE. To support this, GPIOLIB adds two optional APIs as mentioned
>>  below. The GPIO GTE code supports both kernel and userspace consumers. The
>> -kernel space consumers can directly talk to HTE subsystem while userspace
>> -consumers timestamp requests go through GPIOLIB CDEV framework to HTE
>> -subsystem. The hte devicetree binding described at
>> -``Documentation/devicetree/bindings/timestamp`` provides an example of how a
>> -consumer can request an GPIO line.
>> +kernel space consumers can directly talk to HTE subsystem while requests from
>> +userspace consumers go through GPIOLIB CDEV framework to HTE subsystem. The hte
>> +devicetree binding described at ``Documentation/devicetree/bindings/timestamp``
>> +provides an example of how a consumer can request an GPIO line.
>>  
>> -See gpiod_enable_hw_timestamp_ns() and gpiod_disable_hw_timestamp_ns().
>> +To toggle hardware timestamp, use gpiod_enable_hw_timestamp_ns() and
>> +gpiod_disable_hw_timestamp_ns().
>>  
>>  For userspace consumers, GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE flag must be
>> -specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c``, which
>> -returns the timestamp in nanoseconds.
>> +specified during IOCTL calls. Refer to ``tools/gpio/gpio-event-mon.c`` for
>> +example.
>>  
>>  LIC (Legacy Interrupt Controller) IRQ GTE
>>  -----------------------------------------
>>

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

