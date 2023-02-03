Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E4A68A1E6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBCSXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbjBCSXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:23:34 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440738BDCF;
        Fri,  3 Feb 2023 10:23:33 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id e21-20020a9d5615000000b006884e5dce99so1609028oti.5;
        Fri, 03 Feb 2023 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S7X7WqOczCUyCBj08/fIIsSdgQKTDjj5sD2KRRUZOsI=;
        b=VcmGKQ98YzAB+J9sBG60vTFulSIYCltoNE6sIU1I8ucAX2NlxULAawwaJ172PaQnna
         caUaFUkYkepFiP62ybsRFhVQsQSBjiQcvwyUZPMtfMgJjD+ixWyBE0M7lbHlRrawI2D1
         w91DZSI/nQx4Vpn8bK11UEdfCcoC8t5+mIy3/0oxl38AdD1cYiOXVIgVHTuOS/Qiba57
         N21Es8nk8Kwz2ITSeEkc4HU3ivB26arZR7srJPqWY8AcBXfyrGlf8MLzvuibUvTO47Wi
         QnB0Ua3pXsOWn7gexU3eOwhsC+QN1gBLQzD/doBpq3lGDtRRKVbTjedoipC0DsVg+Fvw
         pOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7X7WqOczCUyCBj08/fIIsSdgQKTDjj5sD2KRRUZOsI=;
        b=K+99t+8gsNQRwMBIsywjEOci20R5HQtz9eBmaHnQmK0kXfqSHcNvVsR8EMdEbUF/fF
         ABk+jyOrl2AY7Z0IXXmlQQopyrt7ShyumLju9qtQkdztgOaEc7ErMhfUBBH+UoYOcjLb
         YJu6pKXoobkL5bcmD44nr6+GP6+0ufst+Ey8rw39LLYjv1Y8u5uweGUFlpQjSpPvqLpP
         dlz7c1ZqnAk/CefnW4voIS8a/JJUd+htUYaHD0GkFDRzdbk+MDzhgmmRbdlhcvEDyrX0
         4JaUTmLDOp3MjQvfwNy3pmAcbSzpTOlt7NIJXpaubnM3/CghjwlYxDd4zWFfvP3zTAfd
         IUww==
X-Gm-Message-State: AO0yUKX5mvbT6gwjL/upATY21RPYs+8J6cz0pgikv9lsR/nteUwSm+Oj
        Nb6jrtWaLZM5gg7s84vPLI0=
X-Google-Smtp-Source: AK7set930D87whC9k09OD4tmfsqQpmJXKWylcoQ0KG/aRGH4gJ2g6vtWy52ltNd/F5RLF21mDxT2ig==
X-Received: by 2002:a05:6830:2b1f:b0:68b:c04d:79ca with SMTP id l31-20020a0568302b1f00b0068bc04d79camr7921044otv.33.1675448612610;
        Fri, 03 Feb 2023 10:23:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z7-20020a9d65c7000000b0068bb3a9e2b9sm1365472oth.77.2023.02.03.10.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:23:32 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <df2ee423-5913-fd3c-c0e1-6c494d941bfe@roeck-us.net>
Date:   Fri, 3 Feb 2023 10:23:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/5] watchdog: diag288_wdt: remove power management
Content-Language: en-US
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <20230203073958.1585738-3-egorenar@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230203073958.1585738-3-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 23:39, Alexander Egorenkov wrote:
> Remove power management because s390 no longer supports hibernation since
> commit 394216275c7d ("s390: remove broken hibernate / power management
> support").
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/diag288_wdt.c | 65 ++--------------------------------
>   1 file changed, 2 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 07ebbb709af4..c8d516ced6d2 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -27,7 +27,6 @@
>   #include <linux/moduleparam.h>
>   #include <linux/slab.h>
>   #include <linux/watchdog.h>
> -#include <linux/suspend.h>
>   #include <asm/ebcdic.h>
>   #include <asm/diag.h>
>   #include <linux/io.h>
> @@ -103,10 +102,6 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
>   	return __diag288(func, timeout, action, 0);
>   }
>   
> -static unsigned long wdt_status;
> -
> -#define DIAG_WDOG_BUSY	0
> -
>   static int wdt_start(struct watchdog_device *dev)
>   {
>   	char *ebc_cmd;
> @@ -114,15 +109,10 @@ static int wdt_start(struct watchdog_device *dev)
>   	int ret;
>   	unsigned int func;
>   
> -	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status))
> -		return -EBUSY;
> -
>   	if (MACHINE_IS_VM) {
>   		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
> -		if (!ebc_cmd) {
> -			clear_bit(DIAG_WDOG_BUSY, &wdt_status);
> +		if (!ebc_cmd)
>   			return -ENOMEM;
> -		}
>   		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
>   		ASCEBC(ebc_cmd, MAX_CMDLEN);
>   		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
> @@ -139,7 +129,6 @@ static int wdt_start(struct watchdog_device *dev)
>   
>   	if (ret) {
>   		pr_err("The watchdog cannot be activated\n");
> -		clear_bit(DIAG_WDOG_BUSY, &wdt_status);
>   		return ret;
>   	}
>   	return 0;
> @@ -152,8 +141,6 @@ static int wdt_stop(struct watchdog_device *dev)
>   	diag_stat_inc(DIAG_STAT_X288);
>   	ret = __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
>   
> -	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
> -
>   	return ret;
>   }
>   
> @@ -222,45 +209,6 @@ static struct watchdog_device wdt_dev = {
>   	.max_timeout = MAX_INTERVAL,
>   };
>   
> -/*
> - * It makes no sense to go into suspend while the watchdog is running.
> - * Depending on the memory size, the watchdog might trigger, while we
> - * are still saving the memory.
> - */
> -static int wdt_suspend(void)
> -{
> -	if (test_and_set_bit(DIAG_WDOG_BUSY, &wdt_status)) {
> -		pr_err("Linux cannot be suspended while the watchdog is in use\n");
> -		return notifier_from_errno(-EBUSY);
> -	}
> -	return NOTIFY_DONE;
> -}
> -
> -static int wdt_resume(void)
> -{
> -	clear_bit(DIAG_WDOG_BUSY, &wdt_status);
> -	return NOTIFY_DONE;
> -}
> -
> -static int wdt_power_event(struct notifier_block *this, unsigned long event,
> -			   void *ptr)
> -{
> -	switch (event) {
> -	case PM_POST_HIBERNATION:
> -	case PM_POST_SUSPEND:
> -		return wdt_resume();
> -	case PM_HIBERNATION_PREPARE:
> -	case PM_SUSPEND_PREPARE:
> -		return wdt_suspend();
> -	default:
> -		return NOTIFY_DONE;
> -	}
> -}
> -
> -static struct notifier_block wdt_power_notifier = {
> -	.notifier_call = wdt_power_event,
> -};
> -
>   static int __init diag288_init(void)
>   {
>   	int ret;
> @@ -297,21 +245,12 @@ static int __init diag288_init(void)
>   		return -EINVAL;
>   	}
>   
> -	ret = register_pm_notifier(&wdt_power_notifier);
> -	if (ret)
> -		return ret;
> -
> -	ret = watchdog_register_device(&wdt_dev);
> -	if (ret)
> -		unregister_pm_notifier(&wdt_power_notifier);
> -
> -	return ret;
> +	return watchdog_register_device(&wdt_dev);
>   }
>   
>   static void __exit diag288_exit(void)
>   {
>   	watchdog_unregister_device(&wdt_dev);
> -	unregister_pm_notifier(&wdt_power_notifier);
>   }
>   
>   module_init(diag288_init);

