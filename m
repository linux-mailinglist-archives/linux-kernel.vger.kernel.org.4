Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6A6D04E1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjC3Mg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3Mg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:36:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C0AF39
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:36:32 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u1so10798886wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 05:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680179791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2SdBqcaN+6GFOx8z6KlPRSpnR3fHYMtwzYOEPCISQU=;
        b=dZuY7jmT9vyCXbDNUerGw0l6wRsmn0RlBppowH5woVa6tbB1tKBGzHEHu2YLRKOXfO
         3eDfIno32GPPl8cGTXhP5VgiL3GZLtxcdzQS4uxRi2DD0wXJxj268WcYfSlll+Wi8O2i
         Jm8hgX9+4d/bKj3ixsNXXuGoCW+PdQ4umBJKnQVGRTaXJ8n4z2VV2wHRYCwmX32v8YzC
         0ORixTd6z+ph+bEktz6724JHFog/5u26PDHd/vlnEl/xSCLmd3p5NvynNegeBq+CwOCv
         7t8KrOkmR26HAkeYzwzagGqVZPx7aw5NPe1cE0q8ngOZRE7o92ql9YL8p6rDoM5w4+21
         kUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680179791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v2SdBqcaN+6GFOx8z6KlPRSpnR3fHYMtwzYOEPCISQU=;
        b=k2PgB+/VU/4ENZezzNEIiCcln/l2ANk+Wewq5ejKXV8Mr8eOFd9Zo808dHydAKDDi7
         iJyKAjjIrn4yYkoTD3H4z5LwK3whDrcVzmt6vAmdQAZy6XemB00yD8AfuKK+4OXkQqaw
         FMx5q2GDes54BOmk/nn0XF9jvd/FRjGdRExnd8ccB2PHkmrtYZXXmFIqexo+9mmKEAUN
         5eqyCV59ovNPy4DGYAloxxLVLL8AFF1FisJHMf3c4XguXixW6ow53i0H/3aKGHbPImtU
         eDmZEClsxn3beM1dxsS1N6jSKdJgVhnBNWsjLMZZ8sjBZV3gmR4ElcML9uEv3robCWqZ
         AaIg==
X-Gm-Message-State: AO0yUKUDp8Oiv8QV4ivEI9f6nD7BVBYcc+iVvWIzd/Ux6WGhDC6GJYZy
        ngMW8K38eCviTKwYGIH0BEM5xQ==
X-Google-Smtp-Source: AK7set8F33mlI3B/K+4GNJa26Hkl0rO/8byJx+CY3cNSKt2rN5r8e8DfPD7n3KvlXcP+LtzOfmUdaA==
X-Received: by 2002:a7b:cb90:0:b0:3dc:4b87:a570 with SMTP id m16-20020a7bcb90000000b003dc4b87a570mr18706150wmi.35.1680179791154;
        Thu, 30 Mar 2023 05:36:31 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc? ([2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc])
        by smtp.googlemail.com with ESMTPSA id ay13-20020a05600c1e0d00b003ee6def283bsm6013635wmb.11.2023.03.30.05.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 05:36:30 -0700 (PDT)
Message-ID: <ff48b15c-f8ce-b971-c840-81458715d82b@linaro.org>
Date:   Thu, 30 Mar 2023 14:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] thermal: tegra-bpmp: Handle offline zones
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230330094904.2589428-1-cyndis@kapsi.fi>
 <a09d8edf-9db1-0037-15a4-7ce329b82bf2@linaro.org>
 <204e0435-c544-8727-e892-9fc69b8d691d@kapsi.fi>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <204e0435-c544-8727-e892-9fc69b8d691d@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2023 12:06, Mikko Perttunen wrote:
> On 3/30/23 13:03, Daniel Lezcano wrote:
>> On 30/03/2023 11:49, Mikko Perttunen wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Thermal zones located in power domains may not be accessible when
>>> the domain is powergated. In this situation, reading the temperature
>>> will return -BPMP_EFAULT. When evaluating trips, BPMP will internally
>>> use -256C as the temperature for offline zones.
>>
>>> For smooth operation, for offline zones, return -EAGAIN when reading
>>> the temperature and allow registration of zones even if they are
>>> offline during probe.
>>
>> I think it makes more sense to check if the power domain associated 
>> with the device is powered up and if not return -EPROBE_DEFER.
> 
> The power domains in question are related to computer vision engines 
> that only get powered on when in use, possibly never if the user doesn't 
> run a computer vision workload on the system. We still want other 
> thermal zones to be available.

Ok, I see the point.

I'm worried about the semantic of the errors returned, the translation 
from BPMP_EFAULT to EAGAIN and the assumption it is a disabled (may be 
forever) thermal zone.

What does the documentation say for the error msg.rx.ret == -BPMP_EFAULT?



>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>> ---
>>> v2:
>>> * Adjusted commit message.
>>> * Patch 2/2 dropped for now since it is more controversial,
>>>    and this patch is more critical.
>>>
>>>   drivers/thermal/tegra/tegra-bpmp-thermal.c | 9 ++++++++-
>>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/tegra/tegra-bpmp-thermal.c 
>>> b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>>> index f5fd4018f72f..4ffc3bb3bf35 100644
>>> --- a/drivers/thermal/tegra/tegra-bpmp-thermal.c
>>> +++ b/drivers/thermal/tegra/tegra-bpmp-thermal.c
>>> @@ -52,6 +52,8 @@ static int __tegra_bpmp_thermal_get_temp(struct 
>>> tegra_bpmp_thermal_zone *zone,
>>>       err = tegra_bpmp_transfer(zone->tegra->bpmp, &msg);
>>>       if (err)
>>>           return err;
>>> +    if (msg.rx.ret == -BPMP_EFAULT)
>>> +        return -EAGAIN;
>>>       if (msg.rx.ret)
>>>           return -EINVAL;
>>> @@ -259,7 +261,12 @@ static int tegra_bpmp_thermal_probe(struct 
>>> platform_device *pdev)
>>>           zone->tegra = tegra;
>>>           err = __tegra_bpmp_thermal_get_temp(zone, &temp);
>>> -        if (err < 0) {
>>> +
>>> +        /*
>>> +         * Sensors in powergated domains may temporarily fail to be 
>>> read
>>> +         * (-EAGAIN), but will become accessible when the domain is 
>>> powered on.
>>> +         */
>>> +        if (err < 0 && err != -EAGAIN) {
>>>               devm_kfree(&pdev->dev, zone);
>>>               continue;
>>>           }
>>
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

