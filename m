Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC89686495
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjBAKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBAKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:42:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F0564683
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:42:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1045984wms.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qwiLjJ8e06rg1azZyIHqy+YGkXl9Z/znxv+kgB109+w=;
        b=uGTrsN3LSu3GVqxajn8qPJfjUNXnDwwRsDDGCnANpxNMOrvHYhLpqIOY6KWZXNLqAe
         zNdUIksfK0ycxAP4yp4hbSz/1oQiRrLY90b/Whz5JLqBziEm0yFRugn0ukVMpSu5FOnl
         mkJMHEOTcj9/Ww+T5XJI8GqwVW9y2IAs8C4gaDaffZVA/MVv5kjl9gopurMM3+EkmATH
         V2BVsCaVY1CtAjJGt4FprzZaGJLDl9Om3EQgdjlVJBOZM5L4wIIsbcfqRUCPypU4WVDx
         YP4bHb8I/D3qi8zZpAtUe2Lr+6FjV7Qct9VOf0R/oafS5C0IDw66jlo1uexj6VZy7vPY
         YEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwiLjJ8e06rg1azZyIHqy+YGkXl9Z/znxv+kgB109+w=;
        b=ye9Vs2CENGs9pJjraj9nwnm0OvuWrUbpRb9NhECkzMMGGdd7+SR5m88UxXubRo+FTH
         RhloolFuPxjSDFxUtdeBF5vXfil1QGO09KxMTFUAKeJRblcbU+JLs7U1enGDxUlcU7WX
         x/U3ggElxDcN26UbSR/dG4nMXJZItr6ml3JTsRVpjqf22y6XMytkoV8SbZ0THsD9LF+f
         lFDBBXC4ZjDQlOaiS+xNRByQXEWnApsNNA7vO3dCRUqUn6pMWcjBf6JlzF0EqCE6S3kA
         Af6jMRic20tUoYVZWf9aXUsghafbSH4gVrYVXDTiDx3FMY5p5wmXRIJ0mihwOm3gmCKL
         ULgw==
X-Gm-Message-State: AO0yUKX/9UWAMS58/lgezpvWHxatnBIeja6Fc14nY9ECEPo2kacgB9KR
        BslJ6MYaHmwSfXvAVb0rIWDTNA==
X-Google-Smtp-Source: AK7set9+LgltwL4UtrlZdujsMQ+bqlG09BEKRBHz4znPq5LiHYCxyy/+6K/ext9v2XQhcRfXpQIZTg==
X-Received: by 2002:a05:600c:1c0f:b0:3dd:1bd3:4f6d with SMTP id j15-20020a05600c1c0f00b003dd1bd34f6dmr1468912wms.32.1675248139029;
        Wed, 01 Feb 2023 02:42:19 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p30-20020a1c545e000000b003dc433355aasm1379654wmi.18.2023.02.01.02.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 02:42:18 -0800 (PST)
Message-ID: <fedc35c2-1dc9-48af-f03f-fbb8566284fb@linaro.org>
Date:   Wed, 1 Feb 2023 11:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for
 quark_dts
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
 <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org>
 <CAJZ5v0iOYH4WR5WoH=jL6VWKhB4CMeZv5V3U0Q_c_qdCJvvvBw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iOYH4WR5WoH=jL6VWKhB4CMeZv5V3U0Q_c_qdCJvvvBw@mail.gmail.com>
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

On 31/01/2023 20:11, Rafael J. Wysocki wrote:
> On Tue, Jan 31, 2023 at 5:41 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 26/01/2023 15:15, Rafael J. Wysocki wrote:
>>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> The thermal framework gives the possibility to register the trip
>>>> points with the thermal zone. When that is done, no get_trip_* ops are
>>>> needed and they can be removed.
>>>>
>>>> Convert ops content logic into generic trip points and register them with the
>>>> thermal zone.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>
>> [ ... ]
>>
>>>> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
>>>> -                       QRK_MAX_DTS_TRIPS,
>>>> -                       wr_mask,
>>>> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
>>>> +       if (err)
>>>> +               goto err_ret;
>>>> +
>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
>>>> +
>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
>>>> +       if (err)
>>>> +               goto err_ret;
>>>
>>> If I'm not mistaken, this won't even try to register the thermal zone
>>> if at least one trip cannot be initialized, but previously it was
>>> registered in that case, but the trips that failed to respond were
>>> disabled.
>>>
>>> This is a change in behavior that would at least need to be documented
>>> in the changelog, but it isn't.
>>>
>>> I'm not sure if it is safe to make even, however.
>>
>> Thanks for catching this.
>>
>> Two solutions:
>>
>> 1. Set the temperature to THERMAL_TEMP_INVALID and change
>> get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is
>> THERMAL_TEMP_INVALID
>>
>> 2. Register only the valid trip points.
>>
>> What would be the preferable way ?
> 
> I think that the trip points that are registered currently need to
> still be registered after the change.
> 
> Does registering a trip point with the temperature set to
> THERMAL_TEMP_INVALID cause it to be effectively disabled?

The initial behavior before the changes is:

The function thermal_zone_device_register() will go through all the trip 
points and call thermal_zone_get_trip(), resulting in a call to 
ops->get_trip_temp(). If the call fails, the trip point is tagged as 
disabled and will stay in this state forever, so discarded in the trip 
point crossed detection.

That does not report an error and the trip point is showed in sysfs but 
in a inconsistent state as it is actually disabled. Reading the trip 
point will return an error or not, but it is in any case disabled in the 
thermal framework. The userspace does not have the information about the 
trip point being disabled, so showing it up regardless its state is 
pointless and prone to confusion for the userspace.

IMO, it would be more sane to register the trip points which are 
actually valid, so invalid trip points are not showed up and does 
prevent extra complexity in the thermal core to handle them.





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

