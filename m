Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9925EB46E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiIZWRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIZWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:16:49 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8017C6DFA1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:16:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n10so12238487wrw.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=fu+0FjwhprIPgO5a09eqxMNYO/LQ8KcDzL4zS2a4sK8=;
        b=Tq/7QkShfKXWHaZSmDsBhK/uJ4YYoO0VCSfWimwhNYm9WkW/g1gGGs2C0RHUu2IJHf
         UpnWtXOXkJi6jASZKKmu5qjRJ3InB5RPcxCAVBc/4P9LSNmijosQau6xoTtl2Gl50JOp
         dDryl9aU5WWVM2r/ilKVlD1vMEeN1uPtQ9yBVIajmg8LK3Gcv/OcJjGmD+rXXx7QZQvw
         8XTOPCAEm1zzxqEZr9737HLrPJ3sGn+I7TsRCi77LwOY4O+1EY7+gDnOJ654xmlc+4jI
         QfqXvCwLqfQiaqrT/jS08UZ9aIfi2OqjqtgDW7GDnhwU5mLHz8yWkjgIIP6Q7PwEF9RA
         MS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=fu+0FjwhprIPgO5a09eqxMNYO/LQ8KcDzL4zS2a4sK8=;
        b=EbMHRC1Wy0iSIwAUrq2DSIQrRuPR/vdbwhKlVWtiNh8jC/BIUB4h0ZSGTyWR7Mrp/g
         OgImJa1kH5LK1Z/AfMyeIa+8zqSqCs5CImTxuLB+XNLCAz7jb5bbUQSXce/AS3L/8PDO
         wj81UdO+HCFIqkAvjA4N1hl1fNydkDs/6HIq+7dyyXgLp85Ior/cee1AuAR04FnmjVGb
         Insk5yJQNuP4oiWIU29H4aBIJ6kaUUX/D47zNOLWoj2e5MHN0VmTVas1hHaH5dsGb0yp
         kdJjvhSLb9yP2p9Da7TP8JCKHnIC4Xy4KrqgEzMWOArXng3rpyB4FmELI6gWTpaowc/3
         /9CA==
X-Gm-Message-State: ACrzQf1ucphAj5nj06GSZwBjNRyEhmrQPEbHgTRdIxOfOUg/nQozuJKw
        Tac2YYDjSiioRiIWYXxGd9/URA==
X-Google-Smtp-Source: AMsMyM7DvjO1hO1qpGdV7d5GQ2qO7Qur0PM0zGux4SpKnA7GS0Gl/KlMGqoPENBcTdhfL4lv4TRuJw==
X-Received: by 2002:adf:ff85:0:b0:228:c365:de29 with SMTP id j5-20020adfff85000000b00228c365de29mr14305477wrr.415.1664230547654;
        Mon, 26 Sep 2022 15:15:47 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a10-20020a05600c068a00b003b483000583sm11577253wmn.48.2022.09.26.15.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 15:15:47 -0700 (PDT)
Message-ID: <657008be-34e3-e2de-a9bd-41d2dc804e51@linaro.org>
Date:   Tue, 27 Sep 2022 00:15:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 05/30] thermal/core/governors: Use
 thermal_zone_get_trip() instead of ops functions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-6-daniel.lezcano@linaro.org>
 <CAJZ5v0ibt6nj6+E3onu4Ri74gX84VBob-hOWQPZiusGKb_Apjw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0ibt6nj6+E3onu4Ri74gX84VBob-hOWQPZiusGKb_Apjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 21:34, Rafael J. Wysocki wrote:
> On Mon, Sep 26, 2022 at 4:06 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The governors are using the ops->get_trip_* functions, Replace these
>> calls with thermal_zone_get_trip().
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Zhang Rui <rui.zhang@intel.com>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com> # IPA
>> ---
>>   drivers/thermal/gov_bang_bang.c       | 29 ++++++++-------
>>   drivers/thermal/gov_fair_share.c      | 18 ++++------
>>   drivers/thermal/gov_power_allocator.c | 51 ++++++++++++---------------
>>   drivers/thermal/gov_step_wise.c       | 22 ++++++------
>>   4 files changed, 53 insertions(+), 67 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
>> index a08bbe33be96..f5b85e5ea707 100644
>> --- a/drivers/thermal/gov_bang_bang.c
>> +++ b/drivers/thermal/gov_bang_bang.c
>> @@ -13,26 +13,25 @@
>>
>>   #include "thermal_core.h"
>>
>> -static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>> +static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
>>   {
>> -       int trip_temp, trip_hyst;
>> +       struct thermal_trip trip;
>>          struct thermal_instance *instance;
>> +       int ret;
>>
>> -       tz->ops->get_trip_temp(tz, trip, &trip_temp);
>> -
>> -       if (!tz->ops->get_trip_hyst) {
>> -               pr_warn_once("Undefined get_trip_hyst for thermal zone %s - "
>> -                               "running with default hysteresis zero\n", tz->type);
>> -               trip_hyst = 0;
>> -       } else
>> -               tz->ops->get_trip_hyst(tz, trip, &trip_hyst);
>> +       ret = __thermal_zone_get_trip(tz, trip_id, &trip);
>> +       if (ret)
>> +               pr_warn_once("Failed to retrieve trip point %d\n", trip_id);
> 
> Does it even make sense to continue beyond this point if ret is nonzero?

No, I think we can bail out from here

> All of the contents of trip can be garbage then AFAICS.
> 
>> +
>> +       if (!trip.hysteresis)
>> +               pr_warn_once("Zero hysteresis value for thermal zone %s\n", tz->type);
> 
> Why do you want to warn about this?  Haven't we declared already that
> zero hysteresis is valid and normal?

Apparently the bang-bang governor is expecting a hysteresis value as the 
check is expecting:

 >> -       if (!tz->ops->get_trip_hyst) {
 >> -               pr_warn_once("Undefined get_trip_hyst for thermal 
zone %s - "
 >> -                               "running with default hysteresis 
zero\n", tz->type);
 >> -               trip_hyst = 0;

It is just to keep a warning as before.

>>
>>          dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
>> -                               trip, trip_temp, tz->temperature,
>> -                               trip_hyst);
>> +                               trip_id, trip.temperature, tz->temperature,
>> +                               trip.hysteresis);
>>
>>          list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
>> -               if (instance->trip != trip)
>> +               if (instance->trip != trip_id)
>>                          continue;
>>
>>                  /* in case fan is in initial state, switch the fan off */


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
