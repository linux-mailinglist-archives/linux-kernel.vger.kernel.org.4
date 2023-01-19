Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A5673B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 15:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjASOPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 09:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjASOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 09:14:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EDC3ABA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r30so1985241wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 06:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcW98M++UJwEIqM4eSdAQ11GlW76h6H4x45phYJn7Ls=;
        b=FrZAj8M3rvUJfZUInC9OaoJg3z80i+JPUCrlAcVqxaUwhfFDChfp5f4kmWXRb4nzk8
         /84Y1q+O/qc+92b9AWMNpyzHBosnFNzUvCitXQyDRNQWkpMnutq+ym6+2hbaVxLZb260
         qQmJwiFkL1LfsLHPs3qFFjjRMYbRSz3CfnF5qPdIPE1ardKh15+zNSvJ+W+eHL5jdd7M
         a44lBbyr+Lm7DGLb26Evt5eX9qntJFYcIixYOpYhmIBeUkUokSB9elRZtsBPL6WAp2F1
         oljuazmm4Hb2EjFDNrJET/f3QkUHmoU9rOn92t9lNssYDHR1rBZ9LQteXkuzhQC3RCrV
         FwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcW98M++UJwEIqM4eSdAQ11GlW76h6H4x45phYJn7Ls=;
        b=CBdJpXKEKttCmbzkvC6buSyGu/u8BNwXETHRq2HMGVu0YqG/OjkVudcYMQ/Drq+M+M
         9P6LexAgNlhXaFWw+pzZnQH1namBSs19KE8gpLwVjMDD0K0IKMqwZqz7uXo+NIg0ajbc
         4aw9UzxNK1QGSt4766FgqNb+HuFQTkF2RfzKllKlKluOR/nYA+8Z2TKkOqPqiLdglOYO
         hiqiJYGxsWsA6ETMTJTfeOPvqRV0E3cupVPlW84EIvQHbhrLKGACSEkau2I9Ao2Gv7fx
         GysbEdOHtzMdHujil70kL2RiQBuzIYfCbzrk87+MZsU+oG1TZLA+XFXN/t0IxUow4VWO
         FH8A==
X-Gm-Message-State: AFqh2kohFrqhxUeFRZ7nneFdOZ4RO4XQ3DsK+Gv82xSlIxfYxbMLUWI0
        gNydXOSWSQaSoaONk3Xka7r3yg==
X-Google-Smtp-Source: AMrXdXtaN/9UCncmoYd/9STmPOLQ0Jn2whicecBg0F6I8zR7WdAEwAHcQtPRA9xySeEmmGU5/xniQA==
X-Received: by 2002:a05:6000:386:b0:2be:c41:4758 with SMTP id u6-20020a056000038600b002be0c414758mr11490635wrf.38.1674137627563;
        Thu, 19 Jan 2023 06:13:47 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm8227275wri.96.2023.01.19.06.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:13:47 -0800 (PST)
Message-ID: <1313b9b6-45f0-aad1-9a3f-c5e1e3636697@linaro.org>
Date:   Thu, 19 Jan 2023 15:13:46 +0100
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gR-Z1DNcpRCkK6KapjU_F87RZKpE0ssQn1Y5BiH+sG_g@mail.gmail.com>
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

On 19/01/2023 14:24, Rafael J. Wysocki wrote:
> On Thu, Jan 19, 2023 at 1:48 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 19/01/2023 13:11, Rafael J. Wysocki wrote:
>>> On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 19/01/2023 08:41, Zhang, Rui wrote:
>>>>> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
>>>>>> If the thermal framework fails to initialize, the mutex can be used
>>>>>> by
>>>>>> the different functions registering a thermal zone anyway.
>>>>>
>>>>> Hmm, even with no governors and unregistered thermal sysfs class?
>>>>>
>>>>> IMO, thermal APIs for registering a thermal_zone/cooling_device should
>>>>> yield early if thermal_init fails.
>>>>> For other APIs that relies on a valid
>>>>> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
>>>>> be changed.
>>>>>
>>>>> what do you think?
>>>>
>>>> I think you are right.
>>>>
>>>> It would be nice if we can check if the thermal class is registered and
>>>> bail out if not. But there is no function to check that AFAICS.
>>>>
>>>> Alternatively we can convert the thermal class static structure to a
>>>> pointer and set it to NULL in case of error in thermal_init() ?
>>>
>>> It doesn't matter if this is a NULL pointer or a static object that's
>>> clearly marked as unused.
>>
>> Without introducing another global variable, is it possible to know if
>> the class is used or not ?
> 
> If thermal_class.p is cleared to NULL on class_register() failures in
> thermal_init() (unfortunately, the driver core doesn't do that, but
> maybe it should - let me cut a patch for that), then it can be used
> for that.

It should be in class_unregister() too, right ?

And is it possible to add a class_is_registered() ? in order to prevent 
accessing class structure internals ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

