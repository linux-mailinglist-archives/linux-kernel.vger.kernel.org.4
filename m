Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7D68A210
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbjBCSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjBCSey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:34:54 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48349F9E5;
        Fri,  3 Feb 2023 10:34:52 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-169ba826189so7694816fac.2;
        Fri, 03 Feb 2023 10:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3xAgyB/P34VPcjKH6mtGdp098RjQ2FS2vibr1qsdYQ=;
        b=cTHXYzRuHAMLxkHrkUPLWwJ5IBsBDpwGV6qoTcdt78FUNElTQuQS8lh0hUN2c9VHqQ
         ehR/BeK8KbDB86jD0u5uhB9w/IAsqNIlaLFjz6wbNMtdYngnLRB1PvP2aVI/vtAz9f2i
         6LbtT3w7Ytb+wClz4NcDlVdk9y0GkFSDLe3IOHZoGU/HxJRJg6Rd6Mav3E+oK7AEVOZF
         okeXvytpieRAy0h6uXFJpoV8iW5n92KiCTVb6pR94D++rm17RE35XeiMDYtz51RNCpEY
         NKI+uDfC48KYCBR5/BC1Or1Wv9yFPs3cR34aDf150zaWjq/oCAQxhsTUsvsvfSpBv2ia
         E+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3xAgyB/P34VPcjKH6mtGdp098RjQ2FS2vibr1qsdYQ=;
        b=4UkVfVA7YPLiVSH/Pj+NYJYL+GPtscNtysQQh3fEYtRwRKFKHjurw+4CgQqDu4/q1H
         iR5/U4vVFYD34HKoPgvr3yNl9GN6xRacFgnd0Z1S3Tv9fcyqJBxt57PCv3fcw74GScl4
         mRDVyt9gY/HYm35rza5gC3cEfPOukIEIcg6QJmiOMNhNAFc/clWs+zI5xgTEBdPQ4gpG
         7Au1LLr6AaoB5K/JlEIxoPYPdk2cRcodFwhMfGVUxWFj5xKraQyd7eOrxyqrKnneZw8M
         k7TpysMC5pM6oCL3zWdm5v9vUKqCnZkfJkuwUdXYbayNgSAlRjI6nooFX0MjhnafAWT6
         /feA==
X-Gm-Message-State: AO0yUKUXKc6vDP7mXuQjzXAq0NhqxzM8Kmzbos6O7etFB5RzLN8cDsgk
        +upeM8aY7TVZfHlO6D+97W/8xG0nzys=
X-Google-Smtp-Source: AK7set/4rhXUAgi9ebhQj4/abCroCXSvbIZWfq4Of4h+XWfMADhQGYso/zPRbMxwu4lZb+8GW8QGfg==
X-Received: by 2002:a05:6870:1781:b0:163:b342:cd23 with SMTP id r1-20020a056870178100b00163b342cd23mr4727302oae.48.1675449291972;
        Fri, 03 Feb 2023 10:34:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z18-20020a4a9c92000000b0051a317b5687sm1263624ooj.27.2023.02.03.10.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:34:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1e1451c1-686c-d34a-4388-edb429c212a4@roeck-us.net>
Date:   Fri, 3 Feb 2023 10:34:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <20230203073958.1585738-4-egorenar@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/5] watchdog: diag288_wdt: unify command buffer handling
 for diag288 zvm
In-Reply-To: <20230203073958.1585738-4-egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 23:39, Alexander Egorenkov wrote:
> Simplify and de-duplicate code by introducing a common single command
> buffer allocated once at initialization. Moreover, simplify the interface
> of __diag288_vm() by accepting ASCII strings as the command parameter
> and converting it to the EBCDIC format within the function itself.
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
> ---
>   drivers/watchdog/diag288_wdt.c | 55 +++++++++++++---------------------
>   1 file changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index c8d516ced6d2..c717f47dd4c3 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -69,6 +69,8 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default = C
>   
>   MODULE_ALIAS("vmwatchdog");
>   
> +static char *cmd_buf;
> +

Personally I wound not even bother allocating this, but that is just my personal
opinion. And I guess one more static variable doesn't make much of a difference
either.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>   static int __diag288(unsigned int func, unsigned int timeout,
>   		     unsigned long action, unsigned int len)
>   {
> @@ -88,11 +90,18 @@ static int __diag288(unsigned int func, unsigned int timeout,
>   	return err;
>   }
>   
> -static int __diag288_vm(unsigned int  func, unsigned int timeout,
> -			char *cmd, size_t len)
> +static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
>   {
> +	ssize_t len;
> +
> +	len = strscpy(cmd_buf, cmd, MAX_CMDLEN);
> +	if (len < 0)
> +		return len;
> +	ASCEBC(cmd_buf, MAX_CMDLEN);
> +	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
> +
>   	diag_stat_inc(DIAG_STAT_X288);
> -	return __diag288(func, timeout, virt_to_phys(cmd), len);
> +	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
>   }
>   
>   static int __diag288_lpar(unsigned int func, unsigned int timeout,
> @@ -104,24 +113,14 @@ static int __diag288_lpar(unsigned int func, unsigned int timeout,
>   
>   static int wdt_start(struct watchdog_device *dev)
>   {
> -	char *ebc_cmd;
> -	size_t len;
>   	int ret;
>   	unsigned int func;
>   
>   	if (MACHINE_IS_VM) {
> -		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
> -		if (!ebc_cmd)
> -			return -ENOMEM;
> -		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
> -		ASCEBC(ebc_cmd, MAX_CMDLEN);
> -		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
> -
>   		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
>   			: WDT_FUNC_INIT;
> -		ret = __diag288_vm(func, dev->timeout, ebc_cmd, len);
> +		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
>   		WARN_ON(ret != 0);
> -		kfree(ebc_cmd);
>   	} else {
>   		ret = __diag288_lpar(WDT_FUNC_INIT,
>   				     dev->timeout, LPARWDT_RESTART);
> @@ -146,19 +145,10 @@ static int wdt_stop(struct watchdog_device *dev)
>   
>   static int wdt_ping(struct watchdog_device *dev)
>   {
> -	char *ebc_cmd;
> -	size_t len;
>   	int ret;
>   	unsigned int func;
>   
>   	if (MACHINE_IS_VM) {
> -		ebc_cmd = kmalloc(MAX_CMDLEN, GFP_KERNEL);
> -		if (!ebc_cmd)
> -			return -ENOMEM;
> -		len = strlcpy(ebc_cmd, wdt_cmd, MAX_CMDLEN);
> -		ASCEBC(ebc_cmd, MAX_CMDLEN);
> -		EBC_TOUPPER(ebc_cmd, MAX_CMDLEN);
> -
>   		/*
>   		 * It seems to be ok to z/VM to use the init function to
>   		 * retrigger the watchdog. On LPAR WDT_FUNC_CHANGE must
> @@ -167,9 +157,8 @@ static int wdt_ping(struct watchdog_device *dev)
>   		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
>   			: WDT_FUNC_INIT;
>   
> -		ret = __diag288_vm(func, dev->timeout, ebc_cmd, len);
> +		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
>   		WARN_ON(ret != 0);
> -		kfree(ebc_cmd);
>   	} else {
>   		ret = __diag288_lpar(WDT_FUNC_CHANGE, dev->timeout, 0);
>   	}
> @@ -212,25 +201,20 @@ static struct watchdog_device wdt_dev = {
>   static int __init diag288_init(void)
>   {
>   	int ret;
> -	char ebc_begin[] = {
> -		194, 197, 199, 201, 213
> -	};
> -	char *ebc_cmd;
>   
>   	watchdog_set_nowayout(&wdt_dev, nowayout_info);
>   
>   	if (MACHINE_IS_VM) {
> -		ebc_cmd = kmalloc(sizeof(ebc_begin), GFP_KERNEL);
> -		if (!ebc_cmd) {
> +		cmd_buf = kmalloc(MAX_CMDLEN, GFP_KERNEL);
> +		if (!cmd_buf) {
>   			pr_err("The watchdog cannot be initialized\n");
>   			return -ENOMEM;
>   		}
> -		memcpy(ebc_cmd, ebc_begin, sizeof(ebc_begin));
> -		ret = __diag288_vm(WDT_FUNC_INIT, 15,
> -				   ebc_cmd, sizeof(ebc_begin));
> -		kfree(ebc_cmd);
> +
> +		ret = __diag288_vm(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
>   		if (ret != 0) {
>   			pr_err("The watchdog cannot be initialized\n");
> +			kfree(cmd_buf);
>   			return -EINVAL;
>   		}
>   	} else {
> @@ -251,6 +235,7 @@ static int __init diag288_init(void)
>   static void __exit diag288_exit(void)
>   {
>   	watchdog_unregister_device(&wdt_dev);
> +	kfree(cmd_buf);
>   }
>   
>   module_init(diag288_init);

