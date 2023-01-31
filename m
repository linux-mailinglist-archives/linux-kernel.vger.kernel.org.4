Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB190683AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjAaX4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjAaX4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:56:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06267193C3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:56:01 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h12so15757336wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J7cjXGxo7B7ezwlFBvA8n6p6yll3VhxbgEooofcYeVc=;
        b=RHfSPr8EmGLxEuoT1diL+pM5C1bfhHeAR75C4pJVcedWYZHG3thU6DNL0Aow6s3Twu
         ZNBMmHPezgdWxlY1Ls5ir7APfDr5dWiBrwz8ph1heOT9Xto+oDEsKlc+FcbPH5FwLtWQ
         gh+qOhWDOwYeD+6ZWBjgPrmr1s5SUCbfkZt0qaaHmdDONCOWOuea9g4gbZtBFUiAp0Ci
         LRpOoxAvOcWGQYFiE398oIOdZV+ibhIhIDYXypzw5eztdSiGU5+y7GpulK/5ID8VdeNI
         CthsSTUi9LHAQdi9B4u2RayUtdtbsWWKno/JUxyuXfNn3Jwe+Es7j8hv3nekU9Wnxgkd
         fDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J7cjXGxo7B7ezwlFBvA8n6p6yll3VhxbgEooofcYeVc=;
        b=3XOZVI7yQkqCsElaWq8D3Ia9jYhpZd2iu/TdCFoF5si02hnh+F65YDzT3GTlKxS7tl
         5xCjBry+jpItwh8YS9kVHSobULhsbU1jxTaR88xmqpgoovOjx/RoxgA3SsATNr0gsrHv
         DgvPMBB/Oc6kLopTfmc6v9LNHUR8rp/A2/8lpa1/29v2jYf2BUEuuZRpHBBG1f9lPufD
         GEemdYmefbPeoDUurVNMr6WB2aQJ3K7mNZiMX7x0UjAKy1g5CUntwALrhtRCfbLUBF+J
         5UobJYVAMxzhbrfusb8/48Ohx4Zr66C7n4u5RxIFyCpbue+Wwr/xzQPZtop7gFpVZHXi
         GzUw==
X-Gm-Message-State: AO0yUKXOLrNeWrObDul/IbmEx3YLQzPJQenZyWZESEqtADv7KHTkHVFw
        YLDYZlFyJXEu8O1aiPjGQDL+wA==
X-Google-Smtp-Source: AK7set8lx7WEOcGW+mIFQTHwnUz+cL8qSgc66GGZMmNURxxoNMyGZNJQt9VIKBoY+4JrWW9SSUm60A==
X-Received: by 2002:a5d:6f1c:0:b0:2bf:e95c:9919 with SMTP id ay28-20020a5d6f1c000000b002bfe95c9919mr696213wrb.55.1675209359193;
        Tue, 31 Jan 2023 15:55:59 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm16041443wrp.53.2023.01.31.15.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 15:55:58 -0800 (PST)
Message-ID: <1adb80c4-f4c7-5173-877b-e0a8983bf2c1@linaro.org>
Date:   Wed, 1 Feb 2023 00:55:57 +0100
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

No but if we have thermal_zone_get_trip() returning -EINVAL if 
THERMAL_TEMP_INVALID is set for the specified trip id. Then the 
registering will set the disabled flag.

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/drivers/thermal/thermal_core.c?h=thermal/bleeding-edge#n1395




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

