Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080BC6DFE96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjDLTRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjDLTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:17:06 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1345BB1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:17:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso12267744wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681327023; x=1683919023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JPqy9NofiPKg/4vHJj/WtlvhzS9v4H9kbl58UXMbQuE=;
        b=Jpy2XD4NlDub++eB/sdm7Uc8d/TVzKRPTE2ZaxVIGQt3OODKiNGQeplX2yIeFdQq1b
         7OcxziQZI0q+HJoYrg9wW4KplBKmAJkMmsi44toIY2omQq/2ChlnUwQobkrRYUmRjiqN
         oyFXzLddfHqHhywZ0k0mU2E1EmdZ/8o57GXjcNcFCLfTPTChLlFYYd2olUtnohg/uGlK
         mlBuFcS5t7vDgKeW4fCp5vD5tW+XOIcGRCmBg99jMQTCbresgITPNy7eDrnlCfHUE3/r
         5MKkTsIioyB8IDnPPb9SobifKD+9iiSdsXokk7VuwMZ/rmEiMahaFxoL8jLxoWy1AEOj
         xjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327023; x=1683919023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPqy9NofiPKg/4vHJj/WtlvhzS9v4H9kbl58UXMbQuE=;
        b=eRdXAHX42n7sUPwh46ja0OVeJfJkTfrEgpMz9GHUUTieH4M3o6K4rDcVYNpqYTD+8P
         Irvv96FebCfUfdOcD+ctoBnTfni5zJgsDjjY2c8xaKspSkddrURmww1zIZg8MifiM45o
         /2851p28gUOIp2VySS3DwaOJQSykD82uTEbebQ/DG+7SxjaBOccLQ2P58dKgxjc5Uc/U
         5ni0TNY8R9nde6J4m0g4KE9Zg70ueBpdRAKsXiQ5A3zNEheoU8c67esl1P8h+cQah+TQ
         uTWJTDU+I2RhTeKne7rd3rZlEVAe06q3occxrZorND7PES4XunuPY/Hq6fwa1bsPuDTj
         jaqw==
X-Gm-Message-State: AAQBX9dwZZkMz6eYQ/Q/2hiURvIjOdqE+paMNHh/+cYNrMPLeo3co40O
        0P3RgpWp2/HTdhXPNmQRJhK4Nw==
X-Google-Smtp-Source: AKy350ZL4VgPzt43cnlTVFc5Uel/WGZIjdR9vAPkrTKeVbcjcFhzd5NJpbMHzJ80U2+2zy43osO9Ig==
X-Received: by 2002:a05:600c:215a:b0:3f0:9cc5:27ec with SMTP id v26-20020a05600c215a00b003f09cc527ecmr2447602wml.41.1681327023126;
        Wed, 12 Apr 2023 12:17:03 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6418:c878:b0e:d11b? ([2a05:6e02:1041:c10:6418:c878:b0e:d11b])
        by smtp.googlemail.com with ESMTPSA id z1-20020a5d6541000000b002f02dbddc26sm9995496wrv.68.2023.04.12.12.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:17:02 -0700 (PDT)
Message-ID: <cac6faa7-91ac-1fbb-8cdf-670422585cfc@linaro.org>
Date:   Wed, 12 Apr 2023 21:17:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/7] thermal/core: Encapsulate tz->device field
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>
References: <20230410205305.1649678-1-daniel.lezcano@linaro.org>
 <20230410205305.1649678-3-daniel.lezcano@linaro.org>
 <CAJZ5v0jysxvCZ2-dXfqfiJfpZGOYwgMwk1kEuiGOQjV3LK4gMw@mail.gmail.com>
 <c2581726-3e02-104c-f2ac-55268470d2c8@linaro.org>
 <CAJZ5v0i65XivddWvP9OSuXePwbeWYsgtOr_GB=BBN_jwsWarjQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0i65XivddWvP9OSuXePwbeWYsgtOr_GB=BBN_jwsWarjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 20:56, Rafael J. Wysocki wrote:
> On Tue, Apr 11, 2023 at 10:20 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 11/04/2023 20:19, Rafael J. Wysocki wrote:
>>> On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> There are still some drivers needing to play with the thermal zone
>>>> device internals. That is not the best but until we can figure out if
>>>> the information is really needed, let's encapsulate the field used in
>>>> the thermal zone device structure, so we can move forward relocating
>>>> the thermal zone device structure definition in the thermal framework
>>>> private headers.
>>>
>>> I'm not really sure why this is needed, so please explain.
>>
>> Some drivers are accessing tz->device, that implies they have the
>> knowledge of the thermal_zone_device structure but we want to
>> self-encapsulate this structure and reduce the scope of the structure to
>> the thermal core only.
>>
>> The ACPI and the Menlon drivers are the drivers accessing tz->device.
>>
>> By adding this wrapper, these drivers do no longer need the thermal zone
>> device structure definition.
> 
> So you want to move the definition of struct thermal_zone_device from
> include/linux/thermal.h into a local header in drivers/thermal/ and
> make it entirely local to the thermal core IIUC.
> 
> Which would be forcing the callers of
> thermal_zone_device_register_with_trips() (and friends) to use
> pointers to a data type that's not completely defined (from their
> perspective), but they would still have access to the trips array
> passed to that function.
> 
> That doesn't sound particularly consistent and what's the purpose of doing it?
The first thing is prevent drivers tampering with the thermal core 
structure internals, so moving the structures from 
include/linux/thermal.h to drivers/thermal/thermal_core.h is one step to 
this direction.

As you point it, drivers can still do things with the trip arrays passed 
as parameter. For that the idea is to do the same as:

https://lore.kernel.org/all/20230404075138.2914680-3-daniel.lezcano@linaro.org/

So the array is an initialization data and it will stay private to the 
thermal core code.

In order to update the trip points, we add a 
thermal_zone_device_trips_update() function which does a kmemdup, 
pointer switch, kfree of the previous trips and a notification.

I addressed that in response to your ACPI series questions:

https://lore.kernel.org/all/38a5a6e0-2af8-8365-b20e-8494a4efcb0c@linaro.org/

Does it make sense with this additional information ?


>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>    drivers/thermal/thermal_core.c | 6 ++++++
>>>>    include/linux/thermal.h        | 1 +
>>>>    2 files changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>>> index c5025aca22ee..842f678c1c3e 100644
>>>> --- a/drivers/thermal/thermal_core.c
>>>> +++ b/drivers/thermal/thermal_core.c
>>>> @@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(thermal_zone_device_id);
>>>>
>>>> +struct device *thermal_zone_device(struct thermal_zone_device *tzd)
>>>> +{
>>>> +       return &tzd->device;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(thermal_zone_device);
>>>> +
>>>>    /**
>>>>     * thermal_zone_device_unregister - removes the registered thermal zone device
>>>>     * @tz: the thermal zone device to remove
>>>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>>>> index 82ddb32f9876..87837094d549 100644
>>>> --- a/include/linux/thermal.h
>>>> +++ b/include/linux/thermal.h
>>>> @@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>>>>    void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>>>>    const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
>>>>    int thermal_zone_device_id(struct thermal_zone_device *tzd);
>>>> +struct device *thermal_zone_device(struct thermal_zone_device *tzd);
>>>>
>>>>    int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>>>>                                        struct thermal_cooling_device *,
>>>> --
>>>> 2.34.1
>>>>
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

