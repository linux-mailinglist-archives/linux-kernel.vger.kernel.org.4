Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CA6729D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjARVCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjARVB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:01:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B89611C7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:01:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j17so132968wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=knANNtPJ6XIo6dhH/TJiHGKaWP7/nXyBF8BdTVUEzFg=;
        b=pPouJEbcun1aMaef0XckXv6aaN/Kc7o4lkDjrpzkElM69nO9Kw7QQB/dMR1PuTzBQQ
         nHL7j8hbYLZpXYwlGEt6Zr3rCwXEwe2GYHe6HkLClgs01pjBRZOWner8EFFw1T/FTFSB
         0ndN3ChDWYK51the37SIDugqABFI22zaiS6J2r9T5t7q2+gb2KNPA5l8n3LEN61qLe5F
         yXdis2TNVHUR0rmZDh5snxNirBN/p5a0Y0sqvRZOqYMcEC1hy71Zw/6y/D1xVbH25XRZ
         XsdS7FjsoLgRx8QOKHLXldpRqJUVEBGoWYMY0Y/Kk4XK+uzFdA04ElJwHQThrNe6Ctkk
         4aHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knANNtPJ6XIo6dhH/TJiHGKaWP7/nXyBF8BdTVUEzFg=;
        b=04NvSwiU0WOH4heFprWBpcDRiyQQ2MeDxnRVD6Lb81OhkrbBFg//qtVE291J3AoY1n
         8wzVfyN7yXpvXZAj/CCOIMKLFHnw7YnFo0DJonzbDdvXVXyLvqFFyQ6NMKhYHWqPOVBs
         R4g76Siwn0Q1iHgOJRNesodwNhgRnE/RXJLha7kD3ZcuhwxMMAUbvleZ8zpEe9e8hihw
         ahEbfzR6etCF0i0FeEHsW5p2D5ANjxmuK1zmlwdatLhkIGTRyRCctzTon1V43PuSIYs3
         xkYl7Tcn3ofPpsr9Inlt+05k2U36yUMLFux/A0li+EDKm20ESFYXfHv2y3zwjga/GXTi
         qedg==
X-Gm-Message-State: AFqh2krbQ7qDdIGDWW//1izn773kXl8JR2aCBX4oQp/DvsxocSPBLkkb
        mjf82sbG0085Qy8zpb0zFJKFQetoibkj3P2G
X-Google-Smtp-Source: AMrXdXuiJafH4K8yLFpEO1UCI043pMNN7DvU69liShaUlZWracQ11ODpgvhwOGR3LnbnIFCOwzAu1A==
X-Received: by 2002:a05:600c:540e:b0:3da:fc41:198c with SMTP id he14-20020a05600c540e00b003dafc41198cmr7975647wmb.40.1674075685468;
        Wed, 18 Jan 2023 13:01:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id a3-20020a05600c348300b003db09692364sm3074111wmq.11.2023.01.18.13.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:01:25 -0800 (PST)
Message-ID: <87627e1f-322c-a195-8ce6-8922d9787ff0@linaro.org>
Date:   Wed, 18 Jan 2023 22:01:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org>
 <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
 <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
 <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org>
 <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
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

On 18/01/2023 21:53, srinivas pandruvada wrote:
> On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
>> On 18/01/2023 20:16, srinivas pandruvada wrote:
>>
>> [ ... ]
>>
>>>>> But we'd better wait for the thermald test result from
>>>>> Srinvias.
>>>>
>>>> A quick test show that things still work with thermald and these
>>>> changes.
>>>
>>> But I have a question. In some devices trip point temperature is
>>> not
>>> static. When hardware changes, we get notification. For example
>>> INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
>>> Currently get_trip can get the latest changed value. But if we
>>> preregister, we need some mechanism to update them.
>>
>> When the notification INT3403_PERF_TRIP_POINT_CHANGED happens, we
>> call
>> int340x_thermal_read_trips() which in turn updates the trip points.
>>
> 
> Not sure how we handle concurrency here when driver can freely update
> trips while thermal core is using trips.

Don't we have the same race without this patch ? The thermal core can 
call get_trip_temp() while there is an update, no ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

