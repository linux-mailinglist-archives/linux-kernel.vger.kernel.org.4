Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505E25FEE92
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJNN05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNN0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:26:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F491B76F6;
        Fri, 14 Oct 2022 06:26:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id k9so4301642pll.11;
        Fri, 14 Oct 2022 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B85YzJa+gzD30iQI+jRM1asD652V/dJZGGt/+VYQU/o=;
        b=T0We9qEM1OuX233DTgvvqc5j/ONlheakLJyA/6o8ap4qO839PjW2okMknbno5w2Dwa
         YjiQevt7ClKSXV9S+51PC1WHOOAvUYLcyAbBRWEPTBbgWq60jZjAvX7R58Li/flyoMSk
         txq/eSU/kcFeHxJtcheasqPYrAh6YSLenZU41BsBGhEaP3lXPLyfkE2xZTqiXpx5oUwS
         7BCq6DY6TIj1bgrFgxL8xg+kpiYml2TKnbz0TngAMXwYndTckSD58rejcWoMR/Eoeuvi
         3JKAQ/6acDfqEb4f9zZIBKjZ0S/Bw5zz/fOWRdyzZ74p6I0OeYYePqL5fWLgL7yLB7m4
         A3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B85YzJa+gzD30iQI+jRM1asD652V/dJZGGt/+VYQU/o=;
        b=E+b20xoahOs5awk2c0vqk9JxH63K/Hi69pNK6NnIoHUtlSYVs5VaDGlo1GooMQaLMZ
         PYyGVzpjNKLrOgXJflHBmN8iRHFhS+I6B7YpaivQYB71M7eDgX6Jgqqncmiv6D9fl8Cv
         rjkiykHJsC7Pjfw5LcoLvSGi5iSvsY/5xDfxKCqM9kIZE6SjH1COwXmdnMOaLh76BucB
         q3XqBF9EAA8aXZJQSkbAdiZch6rQ1xR1SWwJjWnLNQZkwis0vr61AUkAveiCg9VE7VOi
         ZdEMaL76O8fJiD+w4sipJ+R8wtgbFpZK0G1BwYRLymyxW/FuzfY6JYyZxqvhI2+jWDAG
         DSzg==
X-Gm-Message-State: ACrzQf3PYCudCoDKPJbUPOQqx9SI7ntLGfTk1nTVIqe+JGCYtunqE9AQ
        Sk+7CLtANJBUv1Dy0belez4=
X-Google-Smtp-Source: AMsMyM6um/5Z+wwjpyTvGnSTOSvAQomH0AZ2k5Nn7qx5rK5ZHPNVYBEYZ5yQFLl99M3+3IdsXL3TgA==
X-Received: by 2002:a17:90a:fa85:b0:20a:ddd3:d431 with SMTP id cu5-20020a17090afa8500b0020addd3d431mr17532500pjb.210.1665754011237;
        Fri, 14 Oct 2022 06:26:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b12-20020aa78ecc000000b005627470944dsm1679224pfr.189.2022.10.14.06.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:26:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c16b8b0c-3935-4d52-eb7f-809d571142b5@roeck-us.net>
Date:   Fri, 14 Oct 2022 06:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 1/4] hwmon/coretemp: Rename indx to index
To:     Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, len.brown@intel.com
References: <20221014090147.1836-1-rui.zhang@intel.com>
 <20221014090147.1836-2-rui.zhang@intel.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221014090147.1836-2-rui.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 02:01, Zhang Rui wrote:
> Use variable name 'index' instead of 'indx' for the index in the
> core_data[] array.
> 
> No functional change expected.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/coretemp.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index ccf0af5b988a..bfdcfe8ccb34 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -515,15 +515,15 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
>   		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
>   }
>   
> -static void coretemp_remove_core(struct platform_data *pdata, int indx)
> +static void coretemp_remove_core(struct platform_data *pdata, int index)
>   {
> -	struct temp_data *tdata = pdata->core_data[indx];
> +	struct temp_data *tdata = pdata->core_data[index];
>   
>   	/* Remove the sysfs attributes */
>   	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
>   
> -	kfree(pdata->core_data[indx]);
> -	pdata->core_data[indx] = NULL;
> +	kfree(pdata->core_data[index]);
> +	pdata->core_data[index] = NULL;
>   }
>   
>   static int coretemp_probe(struct platform_device *pdev)
> @@ -647,7 +647,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	struct platform_device *pdev = coretemp_get_pdev(cpu);
>   	struct platform_data *pd;
>   	struct temp_data *tdata;
> -	int indx, target;
> +	int index, target;
>   
>   	/*
>   	 * Don't execute this on suspend as the device remove locks
> @@ -661,12 +661,12 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   		return 0;
>   
>   	/* The core id is too big, just return */
> -	indx = TO_ATTR_NO(cpu);
> -	if (indx > MAX_CORE_DATA - 1)
> +	index = TO_ATTR_NO(cpu);
> +	if (index > MAX_CORE_DATA - 1)
>   		return 0;
>   
>   	pd = platform_get_drvdata(pdev);
> -	tdata = pd->core_data[indx];
> +	tdata = pd->core_data[index];
>   
>   	cpumask_clear_cpu(cpu, &pd->cpumask);
>   
> @@ -677,7 +677,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
>   	 */
>   	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
>   	if (target >= nr_cpu_ids) {
> -		coretemp_remove_core(pd, indx);
> +		coretemp_remove_core(pd, index);
>   	} else if (tdata && tdata->cpu == cpu) {
>   		mutex_lock(&tdata->update_lock);
>   		tdata->cpu = target;

