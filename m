Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC3A6738F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjASMsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:48:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AA4A1C8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:48:03 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id e3so1722366wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SzgPzscJOs9bD9bKLf8DR2H95WRF50a0Xpvor8+/ZYE=;
        b=BBHz9sQ+8FcubjdbKVR7ztEM9BLLlqWw7SSs7/trvWU6XmzMSx38W/ZjNJbNQTLWPw
         J6WdusrOlr2etXy9w8qmm9MXMmykNTI+3+sT8Ivw5t3iM/91x2EkGa+Vvdyos3ddO9Iz
         OGOzjJuY6l8dUpIdVsd6JWYZRaw+mY5hLppj6RBZ8zqJB8Jm9qMMAbA9p7aGw+neMZT8
         X7LUb5B2eK3dAZrU7Fw3m5NwmWIJDHxdqV38chCJEBo39E1rArLQe4JvPO6sdHpYy9cb
         yG1QORViYmcBe0D4412V/zvV33d8BLtKbrHjcZECfErHib+0VWSWUnsEZtB+yqmkatTR
         cJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzgPzscJOs9bD9bKLf8DR2H95WRF50a0Xpvor8+/ZYE=;
        b=qx0+alpmmYYKcG8Km0XsMpWPUKKo8/xROtWwT89ZyB7nrzIkCTisuvv6crX0j935q+
         cwG52Z2pGybGyrqzKkuBtwRkdFEhmDfwTvctuVS3QZNAizKSHG/WPMGmsqG19+RKfKmU
         EvFRb6V5BiI2LXR9nxD9tJx9qT8PYcjB5kKmCBQ38cZk6ybCYY0/eUkVxvKUHCdIqBGY
         8xMiFubG4dsRMqA1Y+EvkcY4UNsPsoSXPVFDfXbm7Q9VmdzWO6+Yu7VPacxla/hLa0KY
         cRsAw2/f1IGCmqPL6l2Ijj/xKSR/9MIt+pIFeKF2xO5DHxf+CFN+oKa0VbnoR0ETVyyl
         jYGQ==
X-Gm-Message-State: AFqh2kpfoMJSJ0Qg94no1vNAqApTMmaMr/WyOp3C0hEa+stx3GmOEvIY
        1anRvTmDx9zJsZew87UBiC3+3g==
X-Google-Smtp-Source: AMrXdXs0ehj9AqHy7ag2lj+/c7aqzv7n5IXVooS6uM+om/Ui0eObRn8fGglK2o0gIcVOiqF7vJIBoA==
X-Received: by 2002:a5d:4cc8:0:b0:2bd:d779:c1b5 with SMTP id c8-20020a5d4cc8000000b002bdd779c1b5mr17961684wrt.27.1674132481987;
        Thu, 19 Jan 2023 04:48:01 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bu9-20020a056000078900b002be1dcb6efbsm8090120wrb.9.2023.01.19.04.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 04:48:01 -0800 (PST)
Message-ID: <85e0a85d-6935-11cc-8396-4c3e425188f2@linaro.org>
Date:   Thu, 19 Jan 2023 13:48:00 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jFQv09MQw8Z0gn1=Yf3JJD=BWKy3+Xy7RWUy1NXAK7wg@mail.gmail.com>
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

On 19/01/2023 13:11, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/01/2023 08:41, Zhang, Rui wrote:
>>> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
>>>> If the thermal framework fails to initialize, the mutex can be used
>>>> by
>>>> the different functions registering a thermal zone anyway.
>>>
>>> Hmm, even with no governors and unregistered thermal sysfs class?
>>>
>>> IMO, thermal APIs for registering a thermal_zone/cooling_device should
>>> yield early if thermal_init fails.
>>> For other APIs that relies on a valid
>>> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
>>> be changed.
>>>
>>> what do you think?
>>
>> I think you are right.
>>
>> It would be nice if we can check if the thermal class is registered and
>> bail out if not. But there is no function to check that AFAICS.
>>
>> Alternatively we can convert the thermal class static structure to a
>> pointer and set it to NULL in case of error in thermal_init() ?
> 
> It doesn't matter if this is a NULL pointer or a static object that's
> clearly marked as unused.

Without introducing another global variable, is it possible to know if 
the class is used or not ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

