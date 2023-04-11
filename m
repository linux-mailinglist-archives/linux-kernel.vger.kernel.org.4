Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7901E6DE597
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 22:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDKUUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 16:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 16:20:11 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A36C1700
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:20:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id v14-20020a05600c470e00b003f06520825fso10318865wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681244408; x=1683836408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VZTODIYwa2LLMwlK/e5EWHCk+R2wg+1paQIcIlxs2w=;
        b=oZJnIqlHSfue/w6vkwGDSV0t3eV7u17CQKZ7YC4aIP5X9HDxh6+I4W8q/lrZIzhe35
         Kdo77usH9syyoMQBzNMATRjH8ImAeRTamOEZLbV0yyyhiskRVy1+WgqyJxBcdgFNsSV6
         JtEJKKHR7NZCDtQeAyv5sfuErx1LiBgIWDvnCoGgsYu10Dnj1E6EfjwGii8CQIf+GBLJ
         8Xw5zKgc54Tv1TusAYRHXUUuHQR20Lhhbr92qb7op5p4ynS/4Bvxgz1XC8tGtnEWke6t
         ovJtYnGCp4CAQD7xgE8dM9JTln9UTYoLrR8qLS6AzArV7ZS2M9ecs7jp5wuXbgBTZPHJ
         tiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681244408; x=1683836408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VZTODIYwa2LLMwlK/e5EWHCk+R2wg+1paQIcIlxs2w=;
        b=0XG/50mTcd6HN7u8P6AWCBD4I4pS5H86/k+bEnl2jpDU60TjokXVCQf1LdDa5jkP6T
         JNPFjkgUQgXAphA2/U7FZJZ29n8/6PC1wHF9bmmYY/28Pp026DsecyF7Tvig4iWVJr/Q
         FiIbmd7uIiPf5uYUlx5EHBTrw0VXwnONvQPo6NiUquAbacUa6mcsugcUkkglZYbUZfxM
         jJck0uyLVlmNk6/IXplj6oFDv2f05G3+d1OXs0LAimnYD/whAuSd8PTAVtVHoLcL1L36
         7X8MlVCwWosfaCZvUCZfApchpOrvGfvP8Lqb337++Tq0L5Hyqjgu9iLcsf50AUXcsUR7
         Odgg==
X-Gm-Message-State: AAQBX9eo7HYV0ADlwwUWjjdmO9rhj7Ew2JnKey4s+h1V8IHYcHyG1HfT
        2M0j0eGTrIh3epCWnLzCcYBdVA==
X-Google-Smtp-Source: AKy350ZUblprExjuX6+jE5HBU86G18yD57JroHEF7F3UtgQLLmllv6bAVK1PzXBeo7F/H9vADM+avA==
X-Received: by 2002:a05:600c:21c8:b0:3dc:4fd7:31f7 with SMTP id x8-20020a05600c21c800b003dc4fd731f7mr7587448wmj.41.1681244408526;
        Tue, 11 Apr 2023 13:20:08 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:3227:36b8:19f8:5420? ([2a05:6e02:1041:c10:3227:36b8:19f8:5420])
        by smtp.googlemail.com with ESMTPSA id m21-20020a7bcb95000000b003ee4e99a8f6sm17904482wmi.33.2023.04.11.13.20.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 13:20:08 -0700 (PDT)
Message-ID: <c2581726-3e02-104c-f2ac-55268470d2c8@linaro.org>
Date:   Tue, 11 Apr 2023 22:20:07 +0200
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jysxvCZ2-dXfqfiJfpZGOYwgMwk1kEuiGOQjV3LK4gMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 20:19, Rafael J. Wysocki wrote:
> On Mon, Apr 10, 2023 at 10:53 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> There are still some drivers needing to play with the thermal zone
>> device internals. That is not the best but until we can figure out if
>> the information is really needed, let's encapsulate the field used in
>> the thermal zone device structure, so we can move forward relocating
>> the thermal zone device structure definition in the thermal framework
>> private headers.
> 
> I'm not really sure why this is needed, so please explain.

Some drivers are accessing tz->device, that implies they have the 
knowledge of the thermal_zone_device structure but we want to 
self-encapsulate this structure and reduce the scope of the structure to 
the thermal core only.

The ACPI and the Menlon drivers are the drivers accessing tz->device.

By adding this wrapper, these drivers do no longer need the thermal zone 
device structure definition.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/thermal_core.c | 6 ++++++
>>   include/linux/thermal.h        | 1 +
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>> index c5025aca22ee..842f678c1c3e 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -1398,6 +1398,12 @@ int thermal_zone_device_id(struct thermal_zone_device *tzd)
>>   }
>>   EXPORT_SYMBOL_GPL(thermal_zone_device_id);
>>
>> +struct device *thermal_zone_device(struct thermal_zone_device *tzd)
>> +{
>> +       return &tzd->device;
>> +}
>> +EXPORT_SYMBOL_GPL(thermal_zone_device);
>> +
>>   /**
>>    * thermal_zone_device_unregister - removes the registered thermal zone device
>>    * @tz: the thermal zone device to remove
>> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
>> index 82ddb32f9876..87837094d549 100644
>> --- a/include/linux/thermal.h
>> +++ b/include/linux/thermal.h
>> @@ -313,6 +313,7 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>>   void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
>>   const char *thermal_zone_device_type(struct thermal_zone_device *tzd);
>>   int thermal_zone_device_id(struct thermal_zone_device *tzd);
>> +struct device *thermal_zone_device(struct thermal_zone_device *tzd);
>>
>>   int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>>                                       struct thermal_cooling_device *,
>> --
>> 2.34.1
>>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

