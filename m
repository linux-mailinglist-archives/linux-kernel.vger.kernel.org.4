Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F2D724821
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbjFFPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbjFFPqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:46:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4026139
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:45:59 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30aef0b8837so5136615f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686066358; x=1688658358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZb/LSRaeuM9YR+LBFnjbnz/LjYgZUSzBf+uR9nUwOw=;
        b=gM/eyy+g6O2zLXUltAl7IUBbKy2ELlu1RI8hraHzLB4zLWa+TLuj29a2+uEZTfOzVx
         DjtX/N8CNwMpzVLJntNEzKP8zaA5xLfhN2H3/vK8VuK1eERgiLedGKfJ6lok9mRnglx2
         OScSFSb1DTDq1x+nBdNgRUr5uyqv368YsyiOmP5xhAsou0Ed137d4xFX6ZtkIJIVbVh8
         p5D3mlB8IGvIx3HqozmWLDXYF0lCgrhl8IUJT3/PFImw3yXYbudcYe/E6WNF7nfbvQQH
         F0WTkLS60XMt0R/AHZpigMNNanU6NaauczY/yK+LddXFenx0hc9x+n8H2flCkZFAhmj7
         9DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686066358; x=1688658358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wZb/LSRaeuM9YR+LBFnjbnz/LjYgZUSzBf+uR9nUwOw=;
        b=fRdunl95HnHQSYf+phVLEYy4LiRcgTagUANykPV3qzybzOvDVULE0i3acK5jrfKP/Q
         aGuGe0mizr1gcd3ClBf0U0e1jyQzsYF6nMB7dkiAFAb/OKGgnWKzbKd9hGFBhyRyWLM6
         p2UQQXjK/kQ2uSeEt9WdAQC0E0S8r7OoY1x2WxyRZFL/tOaxxo+WJYejt3MYA4rqEreI
         +AXxSiwQWuQ3D42HJqNUyCm0dO7KbI/1u5vvXwduYgaInqLWz7HqKw7pLS9Ix0fyUiLy
         KOAyFiemKWyXxXdUmKYLUnaeC66PgP8979VXrJXK1SWZ4Ckd3R4fv/mrWfTZHT8V1qAJ
         +eMQ==
X-Gm-Message-State: AC+VfDxsmT2CeIf+8br4S7fcRdJVt4xKpQiQLBHLCXPnk0l1SfZD8Cc9
        suaUcWR4+D6/MHY7nW4VI7qY+w==
X-Google-Smtp-Source: ACHHUZ6k8PVvRfUwRe2aKfxo+yMvfbbG3AjKPaHsOSeVMITlhxclCBf7qRlKhlne+LUdWTC7qgQYug==
X-Received: by 2002:a5d:4a12:0:b0:30e:4515:1529 with SMTP id m18-20020a5d4a12000000b0030e45151529mr2208242wrq.37.1686066358254;
        Tue, 06 Jun 2023 08:45:58 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id f9-20020a056000036900b0030c2e3c7fb3sm12860673wrf.101.2023.06.06.08.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 08:45:57 -0700 (PDT)
Message-ID: <6f2a63a1-1cc2-03e9-c983-8cb117923fb9@linaro.org>
Date:   Tue, 6 Jun 2023 17:45:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/7] ACPI: thermal: Drop redundant
 ACPI_TRIPS_REFRESH_DEVICES symbol
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <13298027.uLZWGnKmhe@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13298027.uLZWGnKmhe@kreacher>
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

On 04/06/2023 14:13, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Drop the ACPI_TRIPS_REFRESH_DEVICES symbol which is redundant, because
> ACPI_TRIPS_DEVICES can be used directly instead of it without any
> drawbacks and rename the ACPI_TRIPS_REFRESH_THRESHOLDS to
> ACPI_TRIPS_THRESHOLDS to make the code a bit more consistent.
> 
> While at it, fix up some formatting white space used in the symbol
> definitions.
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
>   drivers/acpi/thermal.c |   13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -238,12 +238,11 @@ static int acpi_thermal_set_cooling_mode
>   #define ACPI_TRIPS_ACTIVE	BIT(3)
>   #define ACPI_TRIPS_DEVICES	BIT(4)
>   
> -#define ACPI_TRIPS_REFRESH_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
> -#define ACPI_TRIPS_REFRESH_DEVICES	ACPI_TRIPS_DEVICES
> +#define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
>   
> -#define ACPI_TRIPS_INIT      (ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT |	\
> -			      ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE |	\
> -			      ACPI_TRIPS_DEVICES)
> +#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
> +				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
> +				 ACPI_TRIPS_DEVICES)
>   
>   /*
>    * This exception is thrown out in two cases:
> @@ -906,13 +905,13 @@ static void acpi_thermal_notify(struct a
>   		acpi_queue_thermal_check(tz);
>   		break;
>   	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> -		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_THRESHOLDS);
> +		acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
>   		acpi_queue_thermal_check(tz);
>   		acpi_bus_generate_netlink_event(device->pnp.device_class,
>   						dev_name(&device->dev), event, 0);
>   		break;
>   	case ACPI_THERMAL_NOTIFY_DEVICES:
> -		acpi_thermal_trips_update(tz, ACPI_TRIPS_REFRESH_DEVICES);
> +		acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
>   		acpi_queue_thermal_check(tz);
>   		acpi_bus_generate_netlink_event(device->pnp.device_class,
>   						dev_name(&device->dev), event, 0);
> 
> 
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

