Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC2679529
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 11:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjAXK2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 05:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjAXK2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 05:28:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2921710
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:28:48 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so12498172wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BlcrQjWefz/S13eT32WWKg7ghQtvzvoszqcQe0iG9RQ=;
        b=FfX9E01ayPtK7ZX948dKsjcx67Qj8+70ocH+kVltVTeAvPNGcms6h0thGyi32+5NfK
         UMBWYKr+qYGb7oge+OcRkVlNIHylBTQTzU4ogt6mzlTtoo+PQG0mCc8+Of//9lYFaLWx
         4m6AyOwWVt7S20d3pD0rcd3V9VMCj8pXQ+XcUq2/635qZYgRuC94hXv4W4E0MKjIkBdH
         iNp2SUeKahVmaylMEBsr+Tu3UrVYEp6vhGWSEp6OxjvBoHBWqqdUmQuNSxD1QUDy8d4z
         7KgQDJ81K/PAZUOQ/8AEM9cYEBoeUbRTh5BA+KhDcg+OeHcZkF4YZZvG4JUGfOq6Df6T
         Z0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BlcrQjWefz/S13eT32WWKg7ghQtvzvoszqcQe0iG9RQ=;
        b=6KZiPqk1Py2SBg+xIoYxSjGewACse4fjVOCWvuD/7AvCl2jESQAQEgxkS8K7izTdZ6
         FEOuAKRmR+yuHVhzG2j5wpLpxWtkmyEazHQ9xhLeoVKdMYZ5Y7u2LgaRrvOtB9GNY/wz
         9UgMleCxl5vQL13/SMmY0rR+PXxGTS93ZkKcnJ6xV8Rvq0frzbsXJm74U7+wIb9CFnmZ
         LR7k1yGHn90LUmaGFvBh54MuPj9ulB3GzVkqtADeP7x7uYvvW8lNHF8tP+x27iJ4GPq6
         FbHTwK0JeZkhDmHBDqJJpwMitH1slqMZ9EJwFqBhNwZQiVfK4qgSKOSzU4QYKLe+OoN3
         8Dvw==
X-Gm-Message-State: AFqh2kpMrRDzWSTNs7lzSsUSYCRalcEqHn16PFPWA9icaUzdMsu7r4hv
        g/SHpk4GEkuXCtt/ku+NXX0ahQ==
X-Google-Smtp-Source: AMrXdXs06jKTOVzfu9vyv/1L05BqAtz2Bt2nP7EYZ7yhQoc3BRf/C60l0tLl40SxRyR63Ip6Z9YTlQ==
X-Received: by 2002:a05:600c:c05:b0:3db:2252:e50e with SMTP id fm5-20020a05600c0c0500b003db2252e50emr19888324wmb.24.1674556126935;
        Tue, 24 Jan 2023 02:28:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k21-20020a05600c1c9500b003db30be4a54sm13901674wms.38.2023.01.24.02.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 02:28:46 -0800 (PST)
Message-ID: <a08e0d60-994a-c11b-2f5d-55c6984df7b4@linaro.org>
Date:   Tue, 24 Jan 2023 11:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points for
 intel_soc_dts_iosf
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <20230118181622.33335-3-daniel.lezcano@linaro.org>
 <CAJZ5v0hCJF-+1SFHyNF-=4FWPLcOqRnc09KeA=rz6BdYTvb=BQ@mail.gmail.com>
 <ff598dd3-91d0-b660-7821-e34177056954@linaro.org>
 <CAJZ5v0gSG3aaeywiMWZTzWHmz_tVupeB1xyZfXhhXJ3NEV8-Yg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gSG3aaeywiMWZTzWHmz_tVupeB1xyZfXhhXJ3NEV8-Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 21:19, Rafael J. Wysocki wrote:
> On Mon, Jan 23, 2023 at 7:09 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi Srinivas,
>>
>> On 19/01/2023 21:04, Rafael J. Wysocki wrote:
>>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> From: Daniel Lezcano <daniel.lezcano@kernel.org>
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
>>>>
>>>> @@ -320,7 +304,8 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
>>>>           dts->trip_mask = trip_mask;
>>>>           dts->trip_count = trip_count;
>>>>           snprintf(name, sizeof(name), "soc_dts%d", id);
>>>> -       dts->tzone = thermal_zone_device_register(name,
>>>> +       dts->tzone = thermal_zone_device_register_with_trips(name,
>>>> +                                                 dts->trips,
>>>>                                                     trip_count,
>>>>                                                     trip_mask,
>>>>                                                     dts, &tzone_ops,
>>>> @@ -430,27 +415,28 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
>>>>                   notification = false;
>>>>           else
>>>>                   notification = true;
>>>> -       for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
>>>> -               sensors->soc_dts[i].sensors = sensors;
>>>> -               ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
>>>> -                                          notification, trip_count,
>>>> -                                          read_only_trip_count);
>>>> -               if (ret)
>>>> -                       goto err_free;
>>>> -       }
>>>
>>> How is this change related to the rest of the patch?
>>
>> We want to register the thermal zone with the trip points.
>>
>> thermal_zone_device_register() becomes
>>
>> thermal_zone_device_register_with_trips()
>>
>> But in the current code, the trip points are updated after the thermal
>> zones are created (and strictly speaking it is wrong as get_trip_temp
>> can be invoked before the trip points are updated).
>>
>> So the change inverts the initialization where we update the trip points
>> and then we register the thermal zones.
> 
> It would be nice to write this in the changelog too.

Srinivasn, are you fine with the changes ?

Rafael, if the patches are ok, shall I resend a new version with the 
changelog updated or can you pick them amending the changelog ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

