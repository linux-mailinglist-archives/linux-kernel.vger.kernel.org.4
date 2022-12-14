Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2964CC82
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiLNOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiLNOmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:42:09 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4698124F1C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:42:07 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so11457311wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 06:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rI6XR2lyn7oFTWdQADmoc34RIgh4JKwtczSsZCm5SRI=;
        b=Ia7jNBvmkuGTKWVdLZQUkNzvfwvhY/YJBZW8rVNogJR9FQIrqESgmdPt/s/CYdUIzD
         eM5Jy9uClOBqsrDGRg9AuAR4ybXbdcz2Z/dawtK6s4WTdaXlzKsNSADf8G7H6hKEiDEY
         kAOXcvfThI35gFzs16QahArED771GS1YP25/Z9aFDWVKDwA3NKZSxlKfxOHkw67lQIrl
         c4pbMqEbGq2CVzQjEWmmDud+xPKuI8KDoOkvnJSBRNlbXtcKlIyVaefT+Wd+XOUF4eeH
         f/rYrcrkeWcmIwVHkZ6dn0gl/owgteF2xlj3CSENwfnnGL0D82iV0ojh/AmegM7qdpJ+
         SAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rI6XR2lyn7oFTWdQADmoc34RIgh4JKwtczSsZCm5SRI=;
        b=0Rba+PT6j2IIg73RZEcJGCtpoN9p+8SCwoo3PBFxJF6fDABUFHcErC3LQVcPhnG8ay
         JZJgK4zrIoJ5bU26c5z9ggBUR968MriptSVkukG5omB/NxEhpuXkT0SRIKJulb8wzr9Q
         FmKcET+3jHM8RkWaXnhWkd6qbcTH7nGxPClRC8egWDCWlsnG65qF+jC2wExHul33swLv
         BRrszenEJev1VsIGR7FhhnGPP/1eyp9KNrlyo6s38liW0aiNpdWA4NDy24rVMJ00cCDp
         vMFUbxa9hO0t1YWFiN1fLbFi4RZLuvfG8o/LbnFlaRIM4l0PVigpc3gA9Gr1M41KY2lv
         HBkQ==
X-Gm-Message-State: ANoB5pk8wobFLVDNjbuLVdn6eSBtA3oKsE+9nhmsQIq1uR8dglVjtCls
        VtgXy/EwF56w4JKxmg+Nz8mSbx8OYZom4Z4B
X-Google-Smtp-Source: AA0mqf6ePLU6khz8p5yBUPVfwE3r5TS1wyF4B5C7K4YxunCzbWbjeA0LMHqnRLKxzenDx6dzAi6KmQ==
X-Received: by 2002:a1c:f606:0:b0:3c6:e63d:adaf with SMTP id w6-20020a1cf606000000b003c6e63dadafmr18931374wmc.31.1671028925701;
        Wed, 14 Dec 2022 06:42:05 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j26-20020a05600c1c1a00b003d1ee3a6542sm3089143wms.47.2022.12.14.06.42.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:42:05 -0800 (PST)
Message-ID: <4507a68d-6d46-927a-ee74-7245764d4edf@linaro.org>
Date:   Wed, 14 Dec 2022 15:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] Add ACPI trip points parser helpers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221212205843.3119407-1-daniel.lezcano@kernel.org>
 <CAJZ5v0h4RCnGv2C+x1m_Uvu5Hmy273wHDLNzYUuJxT_GFxS5qQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h4RCnGv2C+x1m_Uvu5Hmy273wHDLNzYUuJxT_GFxS5qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 15:10, Rafael J. Wysocki wrote:
> On Mon, Dec 12, 2022 at 9:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Regarding thermal, the ACPI code parsing the trip points is duplicated
>> inside different Intel drivers. The generic ACPI thermal driver also
>> duplicates this code.
>>
>> Those ACPI parsing actions are used to define trip points and these
>> ones are defined by, and specific to, the backend driver.
>>
>> The different get_trip_* ops, also very similar between each other,
>> are using the specific trip point structure to return the requested
>> trip point information.
>>
>>  From there, there is nothing new, all this can be converted to the
>> generic trip point.
>>
>> The first patch provides the functions to parse trip point description
>> from the ACPI table but based on the generic trip point structure. The
>> other patches convert the different Intel driver to use the ACPI
>> functions along with a migration to the generic trip point.
> 
> First off, please resend this series with CCs to linux-acpi.
> 
> Second, what does it depend on?  I think that it depends on the new
> material that hasn't been integrated yet, doesn't it?

Right, I assumed the generic trip points series was in the way to be 
integrated


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

