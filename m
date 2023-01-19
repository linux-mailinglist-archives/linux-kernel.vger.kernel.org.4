Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A332673F12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjASQjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjASQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:39:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E74B4ED19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:39:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1701653wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 08:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flCnIliu3iTWinWqZKjSC4lmc9rb7ayevnIotzFYCWI=;
        b=Hy2CExWui+HpZKSlyvCRqhCmkhM0iYSBz3Gujxv6sd/OSmc/V2uCkvVZgrfNAhkEBg
         JCSejuljnFRtHsmJRiz+ZRmQmbJoFrqndEamihTkusk+8r73akv48Xu6O4ij9D3PufSf
         4xcwSa53Crwv8fclWb5YuzW8gM7oc96LbQPjN0xgtzgpUlZa/LRqJOZeAS0KRF7TNVSw
         wqleFX5leMPIGhBFUarwc934JnYZCPR7zCpNy9kbHRnEGP4A6KOW+Gej/cbQKcHLeTTF
         Wh/XSY/qwZetU44VSZUsmzrRRTTtjEzC5P8H9YEzv/WqonY1suEwQGLkTvCsmVrXfR4R
         +WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flCnIliu3iTWinWqZKjSC4lmc9rb7ayevnIotzFYCWI=;
        b=ZfdXqd/YMegojzXF1nv3vItGFDwsSjaQUb06lY7FBlWpydBkPcEODMt/hV4HJuXSr0
         k23BfocYulKmWrEuUWM6h51LnV9AD/Ht/p70zhux8UhEd4O/3U4sDsZl7NfN5Y5O01WO
         VVECB0ShxoUMlNd+sGfcRsFfHavClHwUygMkkgjdlaIeHMWWCSwYOvnLfoUQF3pqdFVB
         36hwfGKgG4Zawemcrs51AliQkJ9SpBr5wVVrqvPFWMb6mT5T4jMzA90fz8crsA/9ndf5
         89DqO0Ft9Hy/rdrSqFH5ivkS09g+DxE49esXlWH5GPgnDZxFHbygjaDdkcOlY3lTV/fL
         w1cA==
X-Gm-Message-State: AFqh2kqCOqmkd4MHwmZX4gaVLrcyuobFCoe/0FeCAFtJ2EAzueXbIWtj
        oJJjGgePQD3KX5ngEi47A827FA==
X-Google-Smtp-Source: AMrXdXsedc12wFrc9SXMJvJbhGtzKzaIIvBgMGZ6Iz9DRUVFzJwoDq+wH/AnMCJ0QI14ucqk15sPUw==
X-Received: by 2002:a05:600c:1906:b0:3da:1d51:ef9d with SMTP id j6-20020a05600c190600b003da1d51ef9dmr11323730wmq.15.1674146370951;
        Thu, 19 Jan 2023 08:39:30 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id l36-20020a05600c1d2400b003d1e1f421bfsm6274378wms.10.2023.01.19.08.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 08:39:30 -0800 (PST)
Message-ID: <54674d67-7be3-0abc-4252-e7f4158f56f2@linaro.org>
Date:   Thu, 19 Jan 2023 17:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
 <20230118211123.111493-3-daniel.lezcano@linaro.org>
 <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
 <db701c97-883e-f231-68fa-c851c6a1a862@linaro.org>
 <CAJZ5v0jFQv09MQw8Z0gn1=Yf3JJD=BWKy3+Xy7RWUy1NXAK7wg@mail.gmail.com>
 <85e0a85d-6935-11cc-8396-4c3e425188f2@linaro.org>
 <CAJZ5v0gR-Z1DNcpRCkK6KapjU_F87RZKpE0ssQn1Y5BiH+sG_g@mail.gmail.com>
 <1313b9b6-45f0-aad1-9a3f-c5e1e3636697@linaro.org>
 <CAJZ5v0icp3nH+3-timEh2o8kxXpe4O2uMdJ8pSwe8fmY_OW4zA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0icp3nH+3-timEh2o8kxXpe4O2uMdJ8pSwe8fmY_OW4zA@mail.gmail.com>
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

On 19/01/2023 16:05, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 3:13 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/01/2023 14:24, Rafael J. Wysocki wrote:
>>> On Thu, Jan 19, 2023 at 1:48 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 19/01/2023 13:11, Rafael J. Wysocki wrote:
>>>>> On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> On 19/01/2023 08:41, Zhang, Rui wrote:
>>>>>>> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
>>>>>>>> If the thermal framework fails to initialize, the mutex can be used
>>>>>>>> by
>>>>>>>> the different functions registering a thermal zone anyway.
>>>>>>>
>>>>>>> Hmm, even with no governors and unregistered thermal sysfs class?
>>>>>>>
>>>>>>> IMO, thermal APIs for registering a thermal_zone/cooling_device should
>>>>>>> yield early if thermal_init fails.
>>>>>>> For other APIs that relies on a valid
>>>>>>> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
>>>>>>> be changed.
>>>>>>>
>>>>>>> what do you think?
>>>>>>
>>>>>> I think you are right.
>>>>>>
>>>>>> It would be nice if we can check if the thermal class is registered and
>>>>>> bail out if not. But there is no function to check that AFAICS.
>>>>>>
>>>>>> Alternatively we can convert the thermal class static structure to a
>>>>>> pointer and set it to NULL in case of error in thermal_init() ?
>>>>>
>>>>> It doesn't matter if this is a NULL pointer or a static object that's
>>>>> clearly marked as unused.
>>>>
>>>> Without introducing another global variable, is it possible to know if
>>>> the class is used or not ?
>>>
>>> If thermal_class.p is cleared to NULL on class_register() failures in
>>> thermal_init() (unfortunately, the driver core doesn't do that, but
>>> maybe it should - let me cut a patch for that), then it can be used
>>> for that.
>>
>> It should be in class_unregister() too, right ?
>>
>> And is it possible to add a class_is_registered() ? in order to prevent
>> accessing class structure internals ?
> 
> I suppose so.
> 
> And we'd like it to be used some places like
> thermal_zone_device_register_with_trips(), wouldn't we?

Yes, in thermal_zone_device_register_with_trips() and 
thermal_cooling_device_register().



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

