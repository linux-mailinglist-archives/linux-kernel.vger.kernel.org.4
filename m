Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6EC6A495E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjB0SOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjB0SOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:14:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E99AD09
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:14:20 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bt28so7185126wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4hZDlilYvuQSHmPv9Bi8E+OjcOUlnE3oenaLWg3g378=;
        b=MTgXZXe1IPKDhvBnt1mxcTiRHsO6yk27vyF7xU1nmXwCSY4QT+oi5eKQ+Rvuuwqhpu
         8DNQJZqV3KqVrrtRfVU1TnnreG14nzKoXbHX5l3dyNUaq0VsjIs+MrR9zStqRKOI8PKr
         Lmsb2kVNzupLNVDPNaMeMzo550KwWF1JknakIEABjNbluTD7OmI61wsEtRxAnrMWBrBn
         KpxWXfKLJB75lWMecAIPk+eUaoXp01Erzb8+WhnVzuotWtfKdvq3BJ4HsbiesDMPMiq+
         nbkXw4mH9i+ySF6TwnoF0yw6bkZDFXECRRKnNFxmEeOUoBxLDpAVTwDdCpp63P3vB1gG
         ka4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4hZDlilYvuQSHmPv9Bi8E+OjcOUlnE3oenaLWg3g378=;
        b=Gxl9y7kjD8hn6h8SIrwB39SYuZc+jDbXspe7S8DUFp5/BiheXu/cT9Ym6xvUePMdIo
         NI+bVdTuOa86VcVpeQK1+COm/37mq2IQ/9jkHwluQSTR3yHCXvuYiXtqgxx7GHlbiHrp
         FKA9wpdgXWkNO5Kz0KCCwN0aVwdnMQeSr0VqEUqUU6285H3jVYQAWrHuGFldToZR252+
         6/BXvsKwi99FzCM8P7P65JJPtMEEy13ZhPkgqyuiYg+GFZX2DEvfrYTIDF6IMvyJW92H
         gDByJaT0UTsKJ8nHlBmSvH6Ev7HFPxsUU7cIUh7YAYFZi7pUBmzeOBtaS2ypD1KedMTr
         kNMg==
X-Gm-Message-State: AO0yUKWTVqLjCYT0o03L1JrT90rZnWkergLJnBzFw6G2qV0yAkOd2+cg
        p0OnIXinWMq4NQit3ZOBNRSo6A==
X-Google-Smtp-Source: AK7set+e2x0Cl1SRmkQnOmdbKUaRWAqzjWmktVhAsld2IO6YxfurAJg0OO6GH+RH/j4AZ66o2k95Gg==
X-Received: by 2002:adf:fd10:0:b0:2c7:1b4b:d729 with SMTP id e16-20020adffd10000000b002c71b4bd729mr48673wrr.65.1677521659349;
        Mon, 27 Feb 2023 10:14:19 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:8baa:6b32:391b:62de? ([2a05:6e02:1041:c10:8baa:6b32:391b:62de])
        by smtp.googlemail.com with ESMTPSA id u3-20020adfed43000000b002c55ec7f661sm8103081wro.5.2023.02.27.10.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:14:18 -0800 (PST)
Message-ID: <ff124b19-4a21-f9f8-4249-d72e3b8dbd6a@linaro.org>
Date:   Mon, 27 Feb 2023 19:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 14/20] thermal/drivers/da9062: Don't access the thermal
 zone device fields
Content-Language: en-US
To:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, rafael@kernel.org
References: <20230226225406.979703-1-daniel.lezcano@linaro.org>
 <20230226225406.979703-15-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230226225406.979703-15-daniel.lezcano@linaro.org>
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


Hi Adam,

are you ok with this patch ?


On 26/02/2023 23:54, Daniel Lezcano wrote:
> The driver is reading the passive polling rate in the thermal zone
> structure. We want to prevent the drivers to rummage around in the
> thermal zone structure.
> 
> On the other side, the delay is what the driver passed to the
> thermal_zone_device_register() function, so it has already the
> information.
> 
> Reuse the information we have instead of reading the information we
> set.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/da9062-thermal.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
> index e7097f354750..2d31b1f73423 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -41,6 +41,8 @@
>   
>   #define DA9062_MILLI_CELSIUS(t)			((t) * 1000)
>   
> +static unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
> +
>   struct da9062_thermal_config {
>   	const char *name;
>   };
> @@ -95,7 +97,10 @@ static void da9062_thermal_poll_on(struct work_struct *work)
>   		thermal_zone_device_update(thermal->zone,
>   					   THERMAL_EVENT_UNSPECIFIED);
>   
> -		delay = thermal->zone->passive_delay_jiffies;
> +		/*
> +		 * pp_tmp is between 1s and 10s, so we can round the jiffies
> +		 */
> +		delay = round_jiffies(msecs_to_jiffies(pp_tmp));
>   		queue_delayed_work(system_freezable_wq, &thermal->work, delay);
>   		return;
>   	}
> @@ -155,7 +160,6 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>   {
>   	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
>   	struct da9062_thermal *thermal;
> -	unsigned int pp_tmp = DA9062_DEFAULT_POLLING_MS_PERIOD;
>   	const struct of_device_id *match;
>   	int ret = 0;
>   
> @@ -208,8 +212,7 @@ static int da9062_thermal_probe(struct platform_device *pdev)
>   	}
>   
>   	dev_dbg(&pdev->dev,
> -		"TJUNC temperature polling period set at %d ms\n",
> -		jiffies_to_msecs(thermal->zone->passive_delay_jiffies));
> +		"TJUNC temperature polling period set at %d ms\n", pp_tmp);
>   
>   	ret = platform_get_irq_byname(pdev, "THERMAL");
>   	if (ret < 0)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

