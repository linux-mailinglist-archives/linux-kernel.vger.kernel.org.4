Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136E5E8F09
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiIXRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiIXRqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:46:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1858B3DF0C
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:46:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t7so4395510wrm.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PidL8HbvElJbEheoeeqV1s6FcqDGhf+ZLhoJ9e+vloM=;
        b=w0y7zlp+XcgXymTTBZ4AduZUGhju7PQibuzTDEj004ms2dM35faUfrLgfWXqMST/EC
         x9/cA+bXsFLyFaTaJG/bOTg2WZ+VMXM+TX1RYK+USt7bF7R1pIz0CNqGfhzcvhArE6Jb
         Jmrcto2FYttlMWjXXMYX0CbFwyOJLAUJGbmyK1/59NPdaeDK0a5gd9xN34QHDpIYrrp7
         RKJnnMxO9RFFrDG9sM1BftBfS6NOrazulwok4BfKmAvWU21Ns2Jx0LTg0sXw3nkt5dGZ
         kHCn7WrH2qeFAIjvvnZWhhl4moJ+uj6yZyI4P58wBnW41JE2xaySovoDvhVdLpWyr+KM
         /3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PidL8HbvElJbEheoeeqV1s6FcqDGhf+ZLhoJ9e+vloM=;
        b=fd+tdJ8U0loxlX73ig7xTKalf0vAVT8sTCNZPcRlErqyi94xb3Nmu7nvXp4ZevpZ0t
         aeG4KCy/0B+2ygjWOl7j3ZHBGZKDfUn2XVgzib7DrRV5b8uUOk6TnOFQZvbuaYWdCJxD
         CVZu8z6fzDmO5b6mYD5bqFU84uDsknXyu1DNdjIg00Cdogu8937qEbxIIvoasaGk2TIa
         wpWwLfnZDCnGtfYJnmq5YmJzp6HYkFi/dfPcQ/smlBtiz9joB5zmiW26V55UHpEkuTI1
         nb4qVXxFzvFafj2cZst2PesB2l27GiVP2225l0qcQ7ed+Wf7zm2pw3gKd3Hjow8nH7ns
         7UmA==
X-Gm-Message-State: ACrzQf2RxXWJuPdxdvqYHuNL+i++7zEWcq7Z21JsyRla2iacXwQxY+ud
        BobcYM4VxBPgdKDKwzbvLrRHBsdWJJ/KJg==
X-Google-Smtp-Source: AMsMyM5bWGkLKNdckHybLoiG2loxjttxjGyyj60loFc/uATd5PTV/gjegR8pjVbCyts7z7wIB2hovQ==
X-Received: by 2002:adf:f8ca:0:b0:226:e456:1896 with SMTP id f10-20020adff8ca000000b00226e4561896mr8771897wrq.177.1664041594583;
        Sat, 24 Sep 2022 10:46:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id az41-20020a05600c602900b003b492b30822sm5983227wmb.2.2022.09.24.10.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 10:46:34 -0700 (PDT)
Message-ID: <ca5090c2-35d6-c507-7fb2-c293712cd53f@linaro.org>
Date:   Sat, 24 Sep 2022 19:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 01/30] thermal/core: Add a generic
 thermal_zone_get_trip() function
Content-Language: en-US
To:     Marek Szyprowski <m.szyprowski@samsung.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
References: <20220921094244.606948-1-daniel.lezcano@linaro.org>
 <20220921094244.606948-2-daniel.lezcano@linaro.org>
 <CGME20220923221936eucas1p1e01148605c9aaf27d8d71969feb99144@eucas1p1.samsung.com>
 <c85a77a3-409b-3e83-08a7-ac7e1888790d@samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <c85a77a3-409b-3e83-08a7-ac7e1888790d@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 00:19, Marek Szyprowski wrote:
> Hi Daniel,
> 
> On 21.09.2022 11:42, Daniel Lezcano wrote:
>> The thermal_zone_device_ops structure defines a set of ops family,
>> get_trip_temp(), get_trip_hyst(), get_trip_type(). Each of them is
>> returning a property of a trip point.
>>
>> The result is the code is calling the ops everywhere to get a trip
>> point which is supposed to be defined in the backend driver. It is a
>> non-sense as a thermal trip can be generic and used by the backend
>> driver to declare its trip points.
>>
>> Part of the thermal framework has been changed and all the OF thermal
>> drivers are using the same definition for the trip point and use a
>> thermal zone registration variant to pass those trip points which are
>> part of the thermal zone device structure.
>>
>> Consequently, we can use a generic function to get the trip points
>> when they are stored in the thermal zone device structure.
>>
>> This approach can be generalized to all the drivers and we can get rid
>> of the ops->get_trip_*. That will result to a much more simpler code
>> and make possible to rework how the thermal trip are handled in the
>> thermal core framework as discussed previously.
>>
>> This change adds a function thermal_zone_get_trip() where we get the
>> thermal trip point structure which contains all the properties (type,
>> temp, hyst) instead of doing multiple calls to ops->get_trip_*.
>>
>> That opens the door for trip point extension with more attributes. For
>> instance, replacing the trip points disabled bitmask with a 'disabled'
>> field in the structure.
>>
>> Here we replace all the calls to ops->get_trip_* in the thermal core
>> code with a call to the thermal_zone_get_trip() function.
>>
>> While at it, add the thermal_zone_get_num_trips() to encapsulate the
>> code more and reduce the grip with the thermal framework internals.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> This patch landed in linux next-20220923 as commit 78ffa3e58d93
> ("thermal/core: Add a generic thermal_zone_get_trip() function").
> Unfortunately it introduces a deadlock:
> 
> thermal_zone_device_update() calls handle_thermal_trip() under the
> tz->lock, which in turn calls thermal_zone_get_trip(), which gathers
> again tz->lock. I've tried to fix this by switching
> handle_thermal_trip() to call __thermal_zone_get_trip().
> 
> This helps for fixing the issue in this change, but then I've tried to
> apply it on top of linux next-20220923. Unfortunately it fails again. It
> looks that the other changes also assumes that calling
> thermal_zone_get_trip() is possible under the tz->lock, because in my
> case it turned out that handle_non_critical_trips() called
> step_wise_throttle(), which in turn called thermal_zone_get_trip(). I
> gave up fixing this. Please re-check possible call paths and adjust
> locking to them.

Yes, you are correct. Those paths have the lock held. I'm fixing this


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
