Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A786E69E43F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjBUQIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjBUQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:08:05 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28AA19F3A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:08:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t15so5106038wrz.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdD9y9rCjIHthGshBW57ufN82DibH/ZpDD247EMOs2o=;
        b=Q5ZO20HOW0s4nP2ba8lL2IB+A+ZmjM7nMJCunr9g75SvsvdVhNN10vh3ClLcJTCDIx
         /Np6lFeUzjrQI38wnuf8S9jS3aSUVWkFKhFM/WCr0VXGzPXB79Nichmcl/+9e0EiiCp8
         ASaT4XtJLM6GLCf9+BeZsrVpVQ70Ggp72j+HHovEw4wmmegiFUDuGf+sYRPWLb+HttiH
         hLo1fdklqKsj6INdUSbM5VO4N+++aCai6kBH2sJ5Oo2uJMZGJdPNDKHhyBv3b4LXAzjs
         Tv707/uRFAK5ARy6tixd2GXb4KilFOuXKbjrKmxxHF6GmIGmoav6OBHOqj7T7MEkrDsB
         yD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VdD9y9rCjIHthGshBW57ufN82DibH/ZpDD247EMOs2o=;
        b=b4owOcWiMJzVkmuSRp3vnbyk6luUijUWy3dfqJU6rYG94XcKnfu6Y9WhVkUvHZVCp0
         ehCdQLOUJegQubGxBF1kLFu16Dw6I8rP7HEAijaev8yq/BQUrwW1DJZDp1xzOlG+cQ9K
         f9xPacvDI8A0ey7Z8TJVbTFyT1Swp5CwfmV5T1/NLrOxI5xHZbOeBHsd+wMSHz7Y7C2/
         9TK8XNKjnAUtoSc4EtrMlQhJOughB6N9l+LBXJREWskrnBBtjfVhmx9xdcdbdkvHUuDF
         q4hHHPru22sBp41pJ3bmwoluAC631/5CTFi2MdMWdiDSPvDcc6khVVo99c05n25uMj+T
         MLrg==
X-Gm-Message-State: AO0yUKVRls0nfFwFBUuUBJ2YrpTY9DL5cKjk6T5wxz8DZhF3AONuqjNz
        p9yjXkyfOgQfeuqaXe0fUHEkkg==
X-Google-Smtp-Source: AK7set/koM3naKmqPifbC2rfzG55+0RWRlOw0+YfmzFE5+bSPYVQUZweQXTX1WFGi7nd0T3QObWaeA==
X-Received: by 2002:adf:f390:0:b0:2c5:8353:e0ec with SMTP id m16-20020adff390000000b002c58353e0ecmr4569005wro.10.1676995682121;
        Tue, 21 Feb 2023 08:08:02 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:1e9:315c:bb40:e382? ([2a05:6e02:1041:c10:1e9:315c:bb40:e382])
        by smtp.googlemail.com with ESMTPSA id e5-20020adff345000000b002c705058773sm2018262wrp.74.2023.02.21.08.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 08:08:01 -0800 (PST)
Message-ID: <c0333a78-a834-6eed-5c80-7fcd31aa666d@linaro.org>
Date:   Tue, 21 Feb 2023 17:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 07/17] thermal/hwmon: Use the thermal API instead
 tampering the internals
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-8-daniel.lezcano@linaro.org>
 <9ac3a59f-a3b7-4128-87d0-7b3310ce7828@linaro.org>
 <20230220141154.GB4009286@roeck-us.net>
 <1c8efdae-1ef4-ab45-d891-72010d8a4343@linaro.org>
 <20230220171210.GA1606748@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230220171210.GA1606748@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/2023 18:12, Guenter Roeck wrote:
> On Mon, Feb 20, 2023 at 04:39:48PM +0100, Daniel Lezcano wrote:
>> On 20/02/2023 15:11, Guenter Roeck wrote:
>>> On Mon, Feb 20, 2023 at 02:34:08PM +0100, Daniel Lezcano wrote:
>>>> Hi Guenter,
>>>>
>>>> my script should have Cc'ed you but it didn't, so just a heads up this patch
>>>> ;)
>>>>
>>>> On 19/02/2023 15:36, Daniel Lezcano wrote:
>>>>> In this function, there is a guarantee the thermal zone is registered.
>>>>>
>>>>> The sysfs hwmon unregistering will be blocked until we exit the
>>>>> function. The thermal zone is unregistered after the sysfs hwmon is
>>>>> unregistered.
>>>>>
>>>>> When we are in this function, the thermal zone is registered.
>>>>>
>>>>> We can call the thermal_zone_get_crit_temp() function safely and let
>>>>> the function use the lock which is private the thermal core code.
>>>>>
>>>
>>> Hmm, if you say so. That very same call used to cause a crash in
>>> Chromebooks, which is why I had added the locking.
>>
>> Mmh, I see. I guess we can assume thermal_hwmon is part of the core code and
>> remove this change.
>>
> 
> Yes. Anyway, the sequence of events was roughly as follows.
> 
> - thermal zone is device is registered
> - hwmon device is registered
>    - userspace is triggered and starts reading device attributes
> - while userspace has a hwmon attribute open, thermal device is unregistered
> - hwmon device is unregistered (sysfs attribute is still open)
> - hwmon device attribute function is called
> - Since thermal device ops have been released after the thermal device
>    was unregistered, trying to call an ops callback fails.
> 
> That doesn't normally happen, but the Intel wireless driver has the habit
> of registering a thermal zone early in its probe function, only to unregister
> it immediately afterwards if the probe function fails. If some userspace
> activity is triggered by the hwmon device registration, the thermal and
> hwmon device removal may be timed such that the hwmon devive is removed
> while one (or more) of its attribute files are still open. Normally that
> doesn't matter, but it is fatal here since the ops callbacks are not owned
> by the hwmon device but by the thermal device.
> 
> Essentially every ops callback has this problem.
> thermal_zone_get_temp() had it as well, also associated with
> a hwmon sysfs attribute read operation. See commit 1c6b30060777
> ("thermal/core: Ensure that thermal device is registered in
> thermal_zone_get_temp").
> 
> If you don't want non-thermal code to access ->ops directly, the thermal
> code would have to provide protected accessor functions, similar to
> thermal_zone_get_temp().

Hopefully we are getting rid of most of the ops soon ... :/



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

