Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AA169D0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjBTPjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjBTPjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:39:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C54EFA4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:39:51 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z8so1371429wrm.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVIhqOxk35udozww/RtZodHiFb7HcTDeNqTU8eeVtzE=;
        b=H0RyxtT1izWRRN76xq3i1I8ryq+Ty7TRqkrmV/hP1efnnvjVN4+pt06gZZOdbAH+nE
         ypMcUGMHT7+1zyANYUYVil05hXTV78J8wr9LjqEVvpwsDy/6GwaUmbuJUAHMvDYIM2t7
         nmXfriWRNHfjz+U81vuLSkCeyZag+NEjDZ6l85lTWzcVnFM+AmL0dJu3L+e8YngUvYA7
         epbMas5M0JH63iIkA5NVNx7KCD55vTWFXk7M4qviH30csO6kDtdAtpEP+HEdf2eU0IFw
         qTKc7A3vknTjbUblf1DQ9niudNJF8fbKJe9J8VQaMeVszuW2+Z6XUH/oSVZnAcfkcGMn
         SW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVIhqOxk35udozww/RtZodHiFb7HcTDeNqTU8eeVtzE=;
        b=kQJIgWBYXbvgFTNkYdA3BsKrW33eB/O3jjMr348JzvU2qgFLoSatL3ayZWJBoy3elb
         5trnHc9l1GNDA8Jucjyhspg2MwGsBX58cY/pQL5/ls5FPGsLsSVBfXl0UCt/3ARKosqp
         fIQu+BGURfXtmcRxql14zcDMUs/3C2s3wGTbn9gMJcGeX1R+E6vn3FrMxxTBuwzC8jol
         dHSmZKOappvA3lQktK5n7/8oMqynvFEz49Y/uiKF44Db+QyZcUIFnUwxi2PKDJ6cUT79
         TYiCyyF/y1sOtxm2t2yQluXsWt/vJEBFCR0LDVsiyHDyqxuKrM3ZmbI45XlD1A1iS5sR
         1iDw==
X-Gm-Message-State: AO0yUKVGDneHW/+1l9Ml+YV59kosZtdskQiQ6PdzROV7P4jdCCd+8hDi
        RGvzlN+mUegRyBmMdzU4VZTlGA==
X-Google-Smtp-Source: AK7set/cuh2kzU3qoaRqZA/kLjN5okTetBD3EpHEn+7c6FpGq/LnsCLjp359hicL8gb7PhkQ2x1vYw==
X-Received: by 2002:a5d:40c7:0:b0:2c3:dd60:d749 with SMTP id b7-20020a5d40c7000000b002c3dd60d749mr1852765wrq.47.1676907589613;
        Mon, 20 Feb 2023 07:39:49 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8d87:e6b4:7d0f:3fdb? ([2a05:6e02:1041:c10:8d87:e6b4:7d0f:3fdb])
        by smtp.googlemail.com with ESMTPSA id u13-20020a5d434d000000b002c55ec7f661sm750386wrr.5.2023.02.20.07.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 07:39:49 -0800 (PST)
Message-ID: <1c8efdae-1ef4-ab45-d891-72010d8a4343@linaro.org>
Date:   Mon, 20 Feb 2023 16:39:48 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230220141154.GB4009286@roeck-us.net>
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

On 20/02/2023 15:11, Guenter Roeck wrote:
> On Mon, Feb 20, 2023 at 02:34:08PM +0100, Daniel Lezcano wrote:
>> Hi Guenter,
>>
>> my script should have Cc'ed you but it didn't, so just a heads up this patch
>> ;)
>>
>> On 19/02/2023 15:36, Daniel Lezcano wrote:
>>> In this function, there is a guarantee the thermal zone is registered.
>>>
>>> The sysfs hwmon unregistering will be blocked until we exit the
>>> function. The thermal zone is unregistered after the sysfs hwmon is
>>> unregistered.
>>>
>>> When we are in this function, the thermal zone is registered.
>>>
>>> We can call the thermal_zone_get_crit_temp() function safely and let
>>> the function use the lock which is private the thermal core code.
>>>
> 
> Hmm, if you say so. That very same call used to cause a crash in
> Chromebooks, which is why I had added the locking.

Mmh, I see. I guess we can assume thermal_hwmon is part of the core code 
and remove this change.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

