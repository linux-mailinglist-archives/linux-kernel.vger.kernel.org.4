Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E692687EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjBBNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjBBNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:32:04 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BE7729A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:32:02 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l8so1394507wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8QJM+cDMWDwGnLdY1LGO5+3ANd8IL6QkYM6Adr66uY=;
        b=E2uSmXmY4dmx866H1u+0MVNnU1IS7WPXRtRsG9r8ILYDjsmv87BaJji0oo/nGEyjMn
         iTm1/N20f9oNM7YQh/0SE4XzQqjkiS8tg8nSTErWGytM0wxvVKZjSeDZATiyytNni0OF
         5oR9X0q6f5drJ5jbfbzibc5nCO2zscS87jLlScA/h5H+6C9A4IJwopMo6j1iWz2kQvrT
         XtGSS/mmQqEE25Kuq/RoKUhxhAlGr3lMSdwNV55AiHrcqaIc6BvKTii3TAxWT87ZbRst
         QuKIkJVu2Vg1Ez/onQAhfwz8N5L9unF3YFoaMtyyYk+HkPsI/CqtYMOjHT18SMbMuuYf
         Xf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8QJM+cDMWDwGnLdY1LGO5+3ANd8IL6QkYM6Adr66uY=;
        b=Iyu0jnY79rmHdUThpnYGD4lWxVaEjOdDXIC2uh3/k3Cr8Tb924/ClMI6sHubQo8zA9
         Qohxcj7s8g4r1DQ+cTTrzsSlpTaf85tDgCxipzF8bcn1Fzj9UIQe3RM6zrcvgrUHV4cl
         ObIRt5gkbxrlxRr0Jol897zXqgkw/t4c0pyFkNpXO3avrQWTH3bLHatmJGMLufZE34VN
         C0I937Ul962+w1X1PGGJ5XtfW3ufpKlGWqtMg4PMk5utLy2HO0EG1UZ1KvFvX/OH1Aek
         BA6V4f8xJXCGUEWIzDKYtfiPHnGgNI3DaCJJxdWjBNMRQNSculpSt8hYiZ1AL001Vex/
         a6Wg==
X-Gm-Message-State: AO0yUKVFfafsrommMKaLdnKQ/QWgQCJjb4+h3KZd7rxqB1IrstmG1krN
        lmG8Wr4rkfOXpwEZSXvW1ht47g==
X-Google-Smtp-Source: AK7set8wfPW5+yKtg0ak5ruu80kd+dHgySJOEnsHJrFEo1iX7A/CpQPPYwiIzpK5NXzm6KvEaGIykA==
X-Received: by 2002:a05:600c:2b46:b0:3dc:4aa6:a8a9 with SMTP id e6-20020a05600c2b4600b003dc4aa6a8a9mr5650270wmf.7.1675344721184;
        Thu, 02 Feb 2023 05:32:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id y21-20020a05600c341500b003dc522dd25esm4613487wmp.30.2023.02.02.05.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:32:00 -0800 (PST)
Message-ID: <d69f2627-4669-5e30-6535-0a6bb98c365d@linaro.org>
Date:   Thu, 2 Feb 2023 14:31:59 +0100
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
 <fedc35c2-1dc9-48af-f03f-fbb8566284fb@linaro.org>
 <CAJZ5v0h75VH4GQeBStfiAXrFJt1tL=1+nhP9=n_Ok=Txm3e_CA@mail.gmail.com>
 <e7e9704c-df97-2c27-2955-959d847a8bb8@linaro.org>
 <CAJZ5v0jHkL6Lit-0Cqg42i-vYRaD+zc4=g2XziCLSUPAeCpEcA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jHkL6Lit-0Cqg42i-vYRaD+zc4=g2XziCLSUPAeCpEcA@mail.gmail.com>
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

On 02/02/2023 11:32, Rafael J. Wysocki wrote:
> On Wed, Feb 1, 2023 at 8:27 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 01/02/2023 19:47, Rafael J. Wysocki wrote:
>>> On Wed, Feb 1, 2023 at 11:42 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 31/01/2023 20:11, Rafael J. Wysocki wrote:
>>>>> On Tue, Jan 31, 2023 at 5:41 PM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> On 26/01/2023 15:15, Rafael J. Wysocki wrote:
>>>>>>> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
>>>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>>>
>>>>>>>> The thermal framework gives the possibility to register the trip
>>>>>>>> points with the thermal zone. When that is done, no get_trip_* ops are
>>>>>>>> needed and they can be removed.
>>>>>>>>
>>>>>>>> Convert ops content logic into generic trip points and register them with the
>>>>>>>> thermal zone.
>>>>>>>>
>>>>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>>> ---
>>>>>>
>>>>>> [ ... ]
>>>>>>
>>>>>>>> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
>>>>>>>> -                       QRK_MAX_DTS_TRIPS,
>>>>>>>> -                       wr_mask,
>>>>>>>> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
>>>>>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
>>>>>>>> +       if (err)
>>>>>>>> +               goto err_ret;
>>>>>>>> +
>>>>>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
>>>>>>>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
>>>>>>>> +
>>>>>>>> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
>>>>>>>> +       if (err)
>>>>>>>> +               goto err_ret;
>>>>>>>
>>>>>>> If I'm not mistaken, this won't even try to register the thermal zone
>>>>>>> if at least one trip cannot be initialized, but previously it was
>>>>>>> registered in that case, but the trips that failed to respond were
>>>>>>> disabled.
>>>>>>>
>>>>>>> This is a change in behavior that would at least need to be documented
>>>>>>> in the changelog, but it isn't.
>>>>>>>
>>>>>>> I'm not sure if it is safe to make even, however.
>>>>>>
>>>>>> Thanks for catching this.
>>>>>>
>>>>>> Two solutions:
>>>>>>
>>>>>> 1. Set the temperature to THERMAL_TEMP_INVALID and change
>>>>>> get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is
>>>>>> THERMAL_TEMP_INVALID
>>>>>>
>>>>>> 2. Register only the valid trip points.
>>>>>>
>>>>>> What would be the preferable way ?
>>>>>
>>>>> I think that the trip points that are registered currently need to
>>>>> still be registered after the change.
>>>>>
>>>>> Does registering a trip point with the temperature set to
>>>>> THERMAL_TEMP_INVALID cause it to be effectively disabled?
>>>>
>>>> The initial behavior before the changes is:
>>>>
>>>> The function thermal_zone_device_register() will go through all the trip
>>>> points and call thermal_zone_get_trip(), resulting in a call to
>>>> ops->get_trip_temp(). If the call fails, the trip point is tagged as
>>>> disabled and will stay in this state forever, so discarded in the trip
>>>> point crossed detection.
>>>>
>>>> That does not report an error and the trip point is showed in sysfs but
>>>> in a inconsistent state as it is actually disabled. Reading the trip
>>>> point will return an error or not, but it is in any case disabled in the
>>>> thermal framework. The userspace does not have the information about the
>>>> trip point being disabled, so showing it up regardless its state is
>>>> pointless and prone to confusion for the userspace.
>>>>
>>>> IMO, it would be more sane to register the trip points which are
>>>> actually valid, so invalid trip points are not showed up and does
>>>> prevent extra complexity in the thermal core to handle them.
>>>
>>> Except when the trip point can be updated to become a valid one later,
>>> for example in response to a system configuration change.  That can
>>> happen to ACPI-provided trip points, for example.
>>>
>>> I don't think that this is an issue for this particular driver, but
>>> the core needs to handle that case anyway.
>>
>> Yes, but the point is the core code never handled that case.
> 
> True.
> 
> What I wanted to say, though, is that the core needs to allow
> registering trip points with THERMAL_TEMP_INVALID without disabling
> them automatically, so they can be updated and used later.

Ok, so it is fine with the current code AFAICT.

The handle_thermal_trip() functions are discarding trips with 
temperature below zero for hot and critical. The trip crossing detection 
won't happen with these values.

However PASSIVE and ACTIVE trip points are going through the throttling 
governor callback with a -273000 trip temperature. I suppose those very 
specific trip points initialized to THERMAL_TEMP_INVALID are not 
associated with a cooling device, right ?


>> If the trip point fails when registering the thermal zone (and this is
>> not related to our changes), the trip point is added to the disabled
>> trips bitmap and then whatever the action to validate the trip point, it
>> remains disabled for the thermal framework. There is no action to enable
>> it (except I missed something).
>>
>>> Moreover, there is the case when trip points only become relevant when
>>> their temperatures are set via ops->set_trip_temp() and they are
>>> THERMAL_TEMP_INVALID initially, which needs to be handled by the core
>>> either.
>>
>> Ok, then I guess the simplest change is to assign THERMAL_TEMP_INVALID
>> in this driver, if get_trip_temp fails at the initialization time.
>>
>> Later we can add a thermal_zone_device_update_trips() with the needed
>> locking and actions related to the update.
> 
> Well, there is thermal_zone_device_update() and one of the events it
> is supposed to handle is THERMAL_TRIP_CHANGED, so I'm not sure how the
> new interface would differ from it?

Yes, we may have to investigate if the event should trigger the update 
or the update should trigger the event.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

