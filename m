Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF9F72481C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjFFPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:45:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A9F93
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:45:35 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso63929395e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686066333; x=1688658333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjmkqNjWvkkkWu9fwkZt4kzyy0KOeA6vdXpXW6eeYsI=;
        b=UUJyfgVRY/lZMeWDMl1M8Kw+CPT/3pJ85LtIJZqB2ml7hu8TSwdZmHL+U8N2ErAHud
         93Q2buj8fJUmOBBVhc47aqRcx5XkoWS7q+HPpbl3Z+kAT3B4qI5DzLfhL7Irf1SS6b2A
         djyCGo6bDC7PS+gs7GxJ2HpnC5Q3Yy/FCdLLMbH8Xlc+cwxQHolGxXFb9VhSFHi3HPg6
         qfYSwyQUDc2NC8PTbkTxlTwpCcvk4ZEmMO0lBQEcKjx4BJ414v/XjX14K01I7L0VRyd+
         oFEhS8rtG17N/YFCZrhJg017M2Q44lkGC6cgs1R7pz8+U/072pQsIR4P+BmMoj36sOIr
         pjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066333; x=1688658333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjmkqNjWvkkkWu9fwkZt4kzyy0KOeA6vdXpXW6eeYsI=;
        b=jNvU04TZ0KmOKxBlAFKJBrCWtsYvaOFTwIyudnaNoDegpMWX2X2VCfVomtuAFhg+NS
         bFIamfjzxwXTKHnXTzohWNNL74wulDqWgXyjo+1vw2H+fF1P1ZAsG1HIJRVOVHvCUgQP
         8DuJABjsYhKOR7s3skvmkB1grTwhO16fcfmxZzArjRGyugAIo5T0Zst2Z6CCg6HkJVIt
         0PZvrnielBDsiHkAdN4FOaUqOWqT1AqOX7SciUfsFtTvP6LLeSsal/p8o5Msxs4cBEwL
         0YdaxFCnt9Er/c/jft9ljFfx2gDTKyIOntqncfz+cgScfx78xtvZQI8YuYaL/vF8HSfC
         Z9JQ==
X-Gm-Message-State: AC+VfDw29RFrW3fwAkznn/i7yr71J1vG/4uiWqsuxF51vPcoAdO2/bZo
        8vMgz7XKPWifUnMtgX3zL6LGTw==
X-Google-Smtp-Source: ACHHUZ69tvRpTe8UQ4S3CR4bz6PL3KAc/6SOo6AK4bbdP+qIYU6Z1ahQDVy8TPocW5dHdLAqUKiijg==
X-Received: by 2002:a05:600c:202:b0:3f6:1474:905 with SMTP id 2-20020a05600c020200b003f614740905mr2945175wmi.29.1686066333405;
        Tue, 06 Jun 2023 08:45:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id j11-20020a5d564b000000b00307c8d6b4a0sm13009936wrw.26.2023.06.06.08.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:45:32 -0700 (PDT)
Message-ID: <ab70132e-10c8-40a2-8b2b-f701e529e840@linaro.org>
Date:   Tue, 6 Jun 2023 17:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/7] ACPI: thermal: Use BIT() macro for defining flags
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <5959573.lOV4Wx5bFT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5959573.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 14:07, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Use the BIT() macro for defining flag symbols in the ACPI thermal driver
> instead of using "raw" values for the flags.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
> 
> v1 -> v2: Added R-by from Michal.
> 
> ---
>   drivers/acpi/thermal.c |   10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -232,11 +232,11 @@ static int acpi_thermal_set_cooling_mode
>   	return 0;
>   }
>   
> -#define ACPI_TRIPS_CRITICAL	0x01
> -#define ACPI_TRIPS_HOT		0x02
> -#define ACPI_TRIPS_PASSIVE	0x04
> -#define ACPI_TRIPS_ACTIVE	0x08
> -#define ACPI_TRIPS_DEVICES	0x10
> +#define ACPI_TRIPS_CRITICAL	BIT(0)
> +#define ACPI_TRIPS_HOT		BIT(1)
> +#define ACPI_TRIPS_PASSIVE	BIT(2)
> +#define ACPI_TRIPS_ACTIVE	BIT(3)
> +#define ACPI_TRIPS_DEVICES	BIT(4)
>   
>   #define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
>   #define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

