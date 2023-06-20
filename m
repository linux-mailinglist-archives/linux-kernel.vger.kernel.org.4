Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107CB737463
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjFTSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjFTSfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:35:07 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AB1730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:35:04 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31110aea814so5171688f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687286102; x=1689878102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PR3F/Lo89XNi8ACwW/OuQPrkwwjj+rXmF3VUywhcwFg=;
        b=VhHiR2OvsffVKMkKzj8PqY8JudqHRCasgS8cyOaINAfEWxgpd7NEn3/S537qD1IPg1
         ew9wY+HtOZaS8Yoa5yy2CNtGvqzrlqTU6sr9o3afhAtv158guTG38kbLEsxlPWYr4yXu
         JCWqa4CfGZoEXUEopJYvpV/ic5Zg/ZRSU+ASUcghNN3WDgepEsAMMFbc3QCXdhepvgJb
         2tSTrgcXGdvMhUqe06BBYNyTvrb4/T9wuqe1ixLM3op5wicAbCIPTVgxC0uNbWuine2L
         8VQ6ZoWp/EWMnjsOPJbXVxAVpaysdN012mYi8q07RU5qG4dFcm9kqaN/IX07OYXAbYBK
         k9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286102; x=1689878102;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR3F/Lo89XNi8ACwW/OuQPrkwwjj+rXmF3VUywhcwFg=;
        b=DpfxHoge74Epl6lZGSZbUjnzycz9euV4LEpIbvqUSgC3AfoH3a5JVhpxgVFmBY98tQ
         OjdqJM8GDUqv8iEP91oUGPk6Y4RXrfUjRoi2woBoGjEmWA26Ozy6IWHUhb9o6IxaC5o+
         8B4YSsB0aNnggyVhZpaMT9YDyK4xeGWhxISjofOVkmzvz7LAIz6tYPOy/y8146LO8k0J
         444+NAWSpc2FsZbulfNwI2VJz1khio8QzzHkjtO0DIRn4otKewuaQjudN+elPfsSDKhD
         8RjCYnRTN81J8zCYstEJXrjcXJHz+dz1M7Xw9Pf56u/g2LdEKFLoBsykTdz3+EZ5vo9Y
         ZO+A==
X-Gm-Message-State: AC+VfDxRRcil6XV1yL6x1/25SA5DZez9U3YhPyona9XwtnvaHmO7bV+1
        D9FMIL2eBx0wKTMxL5T2I1cQAeFVLYlKTM641fo=
X-Google-Smtp-Source: ACHHUZ7bkgaucP7BfcBl5pIhge6Qp6jSizfdXQd/dQee7SS26YsTyNymPtZijUEcnaPXQBcGAQMoXQ==
X-Received: by 2002:a05:6000:1191:b0:30a:b147:69db with SMTP id g17-20020a056000119100b0030ab14769dbmr12855269wrx.24.1687286101719;
        Tue, 20 Jun 2023 11:35:01 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:fae4:142d:36ed:5151? ([2a05:6e02:1041:c10:fae4:142d:36ed:5151])
        by smtp.googlemail.com with ESMTPSA id e14-20020adfe38e000000b0030fcf3d75c4sm2553084wrm.45.2023.06.20.11.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 11:35:01 -0700 (PDT)
Message-ID: <93448681-8a0b-f565-1a98-a8607ff37488@linaro.org>
Date:   Tue, 20 Jun 2023 20:35:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/8] thermal/core: Update the generic trip points
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, thierry.reding@gmail.com,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230525140135.3589917-1-daniel.lezcano@linaro.org>
 <20230525140135.3589917-5-daniel.lezcano@linaro.org>
 <CAJZ5v0iv6HkxmV08JyUO3K1YMPXerEb5qNobVkUNv2zW+qVh+w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0iv6HkxmV08JyUO3K1YMPXerEb5qNobVkUNv2zW+qVh+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

thanks for the comments


On 20/06/2023 13:28, Rafael J. Wysocki wrote:
> On Thu, May 25, 2023 at 4:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> At this point, the generic trip points rework allows to create a
>> thermal zone with a fixed number of trip points. This usage satisfy
>> almost all of the existing drivers.
>>
>> A few remaining drivers have a mechanism where the firmware updates
>> the trip points. But there is no such update mechanism for the generic
>> trip points, thus those drivers can not be converted to the generic
>> approach.
>>
>> This patch provides a function 'thermal_zone_trips_update()' allowing
>> to change the trip points of a thermal zone.
>>
>> At the same time, with the logic the trip points array is passed as a
>> parameter to the thermal zone at creation time, we make our own
>> private trip points array by copying the one passed as parameter.
> 
> So the design seems to require the caller to create a new array of
> trip points and pass it to thermal_zone_trips_update(), so it can
> replace the zone's trips array with it.
> 
> If only one trip point changes and there are multiple defined, this is
> rather not efficient.

This update is only for replacing the current trip array when one or 
several trip points are added or removed. We can see that in one or two 
drivers only.

This function is supposed to be called rarely (and I doubt there is 
really a lot of hardware sending notification to add/remove trip points).

For changing a trip point property like its temperature or its 
hysteresis, we keep the usual set_trip_point() function.

> Do you want to prevent the core from using stale trip points this way?
>   If so, it should be stated here.

No, that will be a side effect. We can put this point apart, it will be 
addressed in a cleanup series after everything is converted to the 
generic trip points.


> Moreover, at least in the cases when num_trips doesn't change, it
> might be more efficient to walk the new trips[] array and only copy
> the ones that have changed over their old versions.

IMO, that is over-engineered, especially for dedicating this 
optimization for a very few drivers and ultra rare usages.


> I am also not sure if this interface is going to be convenient from
> the user's perspective, especially if the trips get sorted by the core
> (in the future).  They would need to recreate the entire trips array
> every time from scratch, even if only one trip point changes, which
> means quite a bit of churn for thermal zones with many trip points.

Actually, the driver is not supposed to deal with the array. It can 
create the array on the stack, pass it to the 
thermal_zone_device_register_with_trips() function and forget about it.

The trip points array should not be used by a driver anymore.


> It might be better to allow them to update trips in place and notify
> the core about the change, all under the zone lock to prevent the core
> from using trips simultaneously.

I'm not sure to understand. The core code is called with this function 
and takes the lock.

> And arguably, changing num_trips would be questionable due to the
> sysfs consistency reasons mentioned below.

[ ... ]

>> Note, no code has been found where the trip points update leads to a
>> refresh of the trip points in sysfs, so it is very unlikey the number
>> of trip points changes. However, for the sake of consistency it would
>> be nicer to have the trip points being refreshed in sysfs also, but
>> that could be done in a separate set of changes.
> 
> So at this point user space has already enumerated the trip points, so
> it may fail if some of them go away or it may not be able to use any
> new trip points appearing in sysfs.

Yes, that is why I think the adding/removal of the trip points was never 
really supported. I would be very curious to see a platform with such a 
feature.

> For this reason, until there is a way to notify user space about the
> need to re-enumerate trip points (and user space indicates support for
> it), the only trip point property that may change in sysfs is the
> temperature.

The userspace can be notified when there is a change with:

THERMAL_GENL_EVENT_TZ_TRIP_CHANGE
THERMAL_GENL_EVENT_TZ_TRIP_ADD
THERMAL_GENL_EVENT_TZ_TRIP_DELETE

The last two ones are not implemented today but that could be done after 
as that would be a new feature.

Let me summarize the situation:

  - The trip point crossing events are not correctly detected because of 
how they are handled and we need to sort them out.

  - In order to sort them out, we need to convert the drivers to the 
generic trip point and remove all those get_trip_* | set_trip_* ops

  - Almost all the drivers are converted except the ACPI thermal and the 
intel_soc_dts_iosf drivers which are blocking the feature

  - The ACPI thermal driver can potentially add or remove a trip point 
but we are not sure that can happen

  - We need to decorrelate the trip id and the array index for the ACPI 
thermal driver

The generic trip points change is a big chunk of work and I would like 
to have some progress to fix the trip crossing detection along with the 
removal of the resulting dead code.

Given there may not be a real usage of the thermal trip number update, 
can we stay simple and keep the proposed change but forcing the same 
number of trip points ?

We can then improve the existing code if it is really needed


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

