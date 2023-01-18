Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8094672B2C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjARWOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjARWOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:14:30 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D365F01
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:14:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j17so234934wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egY6XBJDoe1wCCvHptPORHfFmJ5o0bmjSybogaKhxrI=;
        b=xhK1YXGz1iG9zw8n8l7pbAefehCk66eUvgu5XTBk0C1MHWGKVcV55BtletQsQ0SbdR
         cFRpWZ0yMltC2ygvlv4TigAfTx6FxPUgjd30WiYL3im6tZ4rdzqFqzx/r+OpILlqjwVZ
         4FuL8fepwtM2HAxbkVS4dLIhlLxSxTt3T7nlCuHXsJXmPVMvuX5WBoVxSbToWXXEeyY1
         ry1pyGoErhXJpBGncz2t4oElEcMNQtW3hzj4wp3YA82kkmAXaqLLYpVp54XFXvIYQEY2
         PopbTJkokiGGybsIeEMeWOvQMt/8r93di9URWRHGIFzqjSjg2IurhS2h7TdtEtHXJMfz
         Wcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egY6XBJDoe1wCCvHptPORHfFmJ5o0bmjSybogaKhxrI=;
        b=LBPCKcK9E4xFyk+rZaA1AtDuEzNhUvjgan6sEC+MBOw3mH+9YDR+QuU6Y4q1nQrP2b
         HEr0iAXGzEE8xeJ9/bpZ0CJBRcLHt8frkoiVqpV51GINaKLyNCLjrRnjSSrAhrcgfhQE
         SfvAA1MeYMBly2yYYePOvsy7UbRpr/tVy9s81QExgIvY5bhaOCuoIUpZdsKNxMk7WNAM
         OOFwjeqFOXIC06q9FHu0vjT8n3T3NDwcjrXH4h1Z0uZMjT9ML8o+PBGIMRGt6weZEkSj
         jmSPJmzZgT2eGnn3vG0rf9SyttyOZjDZIrwayn0jWKrlGDcws4Wc01Ffpqb2/BzfoGUy
         kNDQ==
X-Gm-Message-State: AFqh2kreF6eMU/25VM1B7LWd4s+VrAE0cAneXXxtQHDLeZkEFzOjxv/a
        MXvrQUOYZvJFD43NhXxhIthZkcB/3UtmFpxi
X-Google-Smtp-Source: AMrXdXvLIQ7udxrEj0OpmJcLvXl9yE5kf6WaRmM5Ei43XvTaGd6G2RysPm6iatEz4NjdYZtWWTgIcg==
X-Received: by 2002:a05:600c:4f52:b0:3d2:3b4d:d619 with SMTP id m18-20020a05600c4f5200b003d23b4dd619mr8227806wmq.15.1674080063751;
        Wed, 18 Jan 2023 14:14:23 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f24-20020a05600c491800b003d9e74dd9b2sm2938429wmp.9.2023.01.18.14.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 14:14:23 -0800 (PST)
Message-ID: <d6f71181-1de4-7937-eda0-8805d9dfc3b4@linaro.org>
Date:   Wed, 18 Jan 2023 23:14:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
 <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
 <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
 <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
 <87627e1f-322c-a195-8ce6-8922d9787ff0@linaro.org>
 <340f3ecdaddb2c422dcbe3df712a082f333eab0d.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <340f3ecdaddb2c422dcbe3df712a082f333eab0d.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 22:16, srinivas pandruvada wrote:
> On Wed, 2023-01-18 at 22:01 +0100, Daniel Lezcano wrote:
>> On 18/01/2023 21:53, srinivas pandruvada wrote:
>>> On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
>>>> On 18/01/2023 20:16, srinivas pandruvada wrote:
>>>>
>>>> [ ... ]
>>>>
>>>>>>> But we'd better wait for the thermald test result from
>>>>>>> Srinvias.
>>>>>>
>>>>>> A quick test show that things still work with thermald and
>>>>>> these
>>>>>> changes.
>>>>>
>>>>> But I have a question. In some devices trip point temperature
>>>>> is
>>>>> not
>>>>> static. When hardware changes, we get notification. For example
>>>>> INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
>>>>> Currently get_trip can get the latest changed value. But if we
>>>>> preregister, we need some mechanism to update them.
>>>>
>>>> When the notification INT3403_PERF_TRIP_POINT_CHANGED happens, we
>>>> call
>>>> int340x_thermal_read_trips() which in turn updates the trip
>>>> points.
>>>>
>>>
>>> Not sure how we handle concurrency here when driver can freely
>>> update
>>> trips while thermal core is using trips.
>>
>> Don't we have the same race without this patch ? The thermal core can
>> call get_trip_temp() while there is an update, no ?
> Yes it is. But I can add a mutex locally here to solve.
> But not any longer.
> 
> I think you need some thermal_zone_read_lock/unlock() in core, which
> can use rcu. Even mutex is fine as there will be no contention as
> updates to trips will be rare.

I was planning to provide a thermal_trips_update(tz, trips) and from 
there handle the locking.

As the race was already existing, can we postpone this change after the 
generic trip points changes?

There is still a lot of work to do to consolidate the code. One of them 
is to provide a generic function to browse the trip points and ensure 
the code is using it instead of directly inspect the thermal zone 
internals structure.

I'm almost there but I need the remaining Intel drivers changes to be 
merged (as well as ACPI which is finished but depending on this series).

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

