Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D0D64F0AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 18:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiLPR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPR4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 12:56:23 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB46D1A81E;
        Fri, 16 Dec 2022 09:56:22 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so1799809oth.8;
        Fri, 16 Dec 2022 09:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg/vF4pR6tcjNNEhvl0wJKi+FI4xcwfuJ2cK0XbWF10=;
        b=HOKV3uf941kc3JAn3x7pnDzcGDY47PHkqTIh+I8NAnI8/z88OqufgZneYXjevyovNf
         GPnrZi0hAmwzD/O1ASBUQhZWnNgwlq6x1wU7drjTgZpSBn2eaJ8fLgzlQeXYnRUgdMRv
         ge8KvVhlV2VrqFIkYOjn6L00DwTq9JlCUe32z9MZKqtjf2ukNmkG6GJJXkIBOzpZp4pr
         RwexnIQV0WSppEz733YDPMlR8epZ9heo2OHnFSgZtzC2QgOlg0+Ho2JeizRP2WcXitoi
         tDwxJz6WqyO5LnVskuS3TwvH3jNNHdA7nZ7153Y6cUExbw9swwmR76+Q60K7GqZe7PL4
         7Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sg/vF4pR6tcjNNEhvl0wJKi+FI4xcwfuJ2cK0XbWF10=;
        b=bHa5G7AkHtNkJNNqUce8775ITzFkvGLbL1FB4Z03KfHP05JGNBJ0QgUzAVv1tTzJB1
         O3YOIqkNoutsjZRMgHsCc2YzPaexmPtFdwkXn7TwLRwDQrAinSy62Q1K5k8o3+B93k07
         PxGZGVUBLjmlz04C8jLMbbVAh6syvib5s1NV4KAbYVj+Le2MM3+s3JMoGhGh32ZwUr/0
         yDCGCORXiVtnnxp16Wps5udrGUMkkJ4J2is7d96akBXQfX8lUMWoTp+Mm8XsjqPTgo3T
         avfK+4Zco23OIZIFKQR46QvaHAz7nvGamSjycwcISDjh3NzHRdM7CG7tndQjxdtLznpx
         9djg==
X-Gm-Message-State: ANoB5pmsxqX6ILtMloGtEy7DRBa0W4V3+ZeFaPWkiZ0vuutyj1rwGm0k
        1fsgWasg/shN4RoUdWuX4PE=
X-Google-Smtp-Source: AA0mqf65/yj7iz9g6D3KkV9AD7W8AdFAwgPKVXRTytpNttRwUh+ZefU9bCJI24DQFoL0eXq9R4bumQ==
X-Received: by 2002:a9d:7f0f:0:b0:670:666b:3472 with SMTP id j15-20020a9d7f0f000000b00670666b3472mr15976311otq.5.1671213382164;
        Fri, 16 Dec 2022 09:56:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r44-20020a05683044ac00b0066e7e4b2f76sm1123870otv.17.2022.12.16.09.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 09:56:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34dc4244-4e62-0b73-b6f9-430e4ee1a1e6@roeck-us.net>
Date:   Fri, 16 Dec 2022 09:56:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] hwmon: coretemp: avoid RDMSR interruptions to isolated
 CPUs
Content-Language: en-US
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>
References: <Y5sWMEG0xCl9bgEi@tpad>
 <68f76ac7-5edd-d437-8bef-e233f2876660@roeck-us.net> <Y5x7hXGGLkcmejKq@tpad>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y5x7hXGGLkcmejKq@tpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/22 06:07, Marcelo Tosatti wrote:
> 
> The coretemp driver uses rdmsr_on_cpu calls to read
> MSR_IA32_PACKAGE_THERM_STATUS/MSR_IA32_THERM_STATUS registers,
> which contain information about current core temperature.
> 
> For certain low latency applications, the RDMSR interruption exceeds
> the applications requirements.
> 
> So disallow reading of crit_alarm and temp files via /sys, returning
> -EINVAL, in case CPU isolation is enabled.
> 
> Temperature information from the housekeeping cores should be
> sufficient to infer die temperature.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v2: improve changelog to mention that an error is returned,
>      and sysfs file is not disabled (Guenter Roeck)
> 

You did not address my feedback. I requested a code change.
Returning -EINVAL is unacceptable, and a solution not creating
the sysfs attributes to start with would be preferred.

Guenter

> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 9bee4d33fbdf..30a35f4130d5 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -27,6 +27,7 @@
>   #include <asm/msr.h>
>   #include <asm/processor.h>
>   #include <asm/cpu_device_id.h>
> +#include <linux/sched/isolation.h>
>   
>   #define DRVNAME	"coretemp"
>   
> @@ -121,6 +122,10 @@ static ssize_t show_crit_alarm(struct device *dev,
>   	struct platform_data *pdata = dev_get_drvdata(dev);
>   	struct temp_data *tdata = pdata->core_data[attr->index];
>   
> +
> +	if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
> +		return -EINVAL;
> +
>   	mutex_lock(&tdata->update_lock);
>   	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
>   	mutex_unlock(&tdata->update_lock);
> @@ -158,6 +163,8 @@ static ssize_t show_temp(struct device *dev,
>   
>   	/* Check whether the time interval has elapsed */
>   	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
> +		if (!housekeeping_cpu(tdata->cpu, HK_TYPE_MISC))
> +			return -EINVAL;
>   		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
>   		/*
>   		 * Ignore the valid bit. In all observed cases the register
> 
> 
> 
> 

