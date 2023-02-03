Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75868A217
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjBCShO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjBCShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:37:12 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719779F9FA;
        Fri,  3 Feb 2023 10:37:11 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id b10-20020a4a9fca000000b004e6f734c6b4so575953oom.9;
        Fri, 03 Feb 2023 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mP4yB9LFFa1Pp5QA3D/tSditesL/r2SNblVIlGMaCVg=;
        b=RecCHPYS+3hkE16dc0YBJZxw7YbHa3qx0zv7aiHUlzw74xEPNkbfPspRNU8wcccqUC
         rbgyQ/oBtoKIez6xqUPAe9jLhOE6imjP8oMTVD4Su6c1sbUmQLL6jCl2ft4A+5a9usDy
         HwRifTLo+VgDI/I5gV+/dUnoKh3krf3efre2pSLCD9XkIT8C74gYGl2ADGcgWMxqBuxa
         G02GGnohx10suTO+N/MLhcTOa0fL9mgOdSRGj5sZ4yrM9BFKuxhg95brASkkY8EuTbEd
         ZFch2fGKZZqwJCOVSrzF3G337fckYbMCZ1jjZ32abE//7laC1B9aoYwRXLcgLdURy/xx
         HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mP4yB9LFFa1Pp5QA3D/tSditesL/r2SNblVIlGMaCVg=;
        b=jJC1ajPDymCWzGIBedl2Z1Ljqq0fpUbJqhkhoZyPg+0mG2ZQ3FYBWYGpwhKlfFu4TK
         TdtIkCBd3WBqQZgN1etjmh847hkcIdU6aYJ90MNrJkMnzC+FlkN36d1uhFWSzWB3ekF7
         cNPuJLL/SE0z6w5TXXINSJoG20tu1Uwn9XVXStwT2k95reSJwLOIfYxYJqrpUA7eCBO0
         +OrELeXbpleCt4CCZMSu9nJU8O/0HHnT1pqOePibcf5Gvp6C9ficIJbWiBmBUpFplCi0
         qiCfNlBqXrpTj+WF+6yeEKAvoaZaLtrED6F2egudZXlDg4MurVAgLd8OHCiqEmnLgipi
         40zg==
X-Gm-Message-State: AO0yUKWuP1G1DN7n1TYtShKY5eUOqUc395oY+d3z89ADV8G3LYbN/aIS
        rphie/UmiFwJ2LA6IiCttWebWQtLdTU=
X-Google-Smtp-Source: AK7set8Zk9gq+khze/M1wx/kYaToNswQiMpxKBYHy2DS0KSkevhFTmiGoV5G+Z5s5bkDA6sRQnZzpA==
X-Received: by 2002:a4a:dfc7:0:b0:519:b605:9d78 with SMTP id p7-20020a4adfc7000000b00519b6059d78mr5517065ood.7.1675449430769;
        Fri, 03 Feb 2023 10:37:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i10-20020a4adf0a000000b00516d4eac864sm1245679oou.29.2023.02.03.10.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 10:37:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef9e6cfb-7b08-d649-feb0-0a56b81770e7@roeck-us.net>
Date:   Fri, 3 Feb 2023 10:37:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] watchdog: diag288_wdt: unify lpar and zvm diag288
 helpers
Content-Language: en-US
To:     Alexander Egorenkov <egorenar@linux.ibm.com>,
        wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        hca@linux.ibm.com
References: <20230203073958.1585738-1-egorenar@linux.ibm.com>
 <20230203073958.1585738-6-egorenar@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230203073958.1585738-6-egorenar@linux.ibm.com>
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
> Change naming of the internal diag288 helper functions
> to improve overall readability and reduce confusion:
> * Rename __diag288() to diag288().
> * Get rid of the misnamed helper __diag288_lpar() that was used not only
>    on LPARs but also zVM and KVM systems.
> * Rename __diag288_vm() to diag288_str().
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/diag288_wdt.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index a29ad164b27a..4631d0a3866a 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -71,8 +71,8 @@ MODULE_ALIAS("vmwatchdog");
>   
>   static char *cmd_buf;
>   
> -static int __diag288(unsigned int func, unsigned int timeout,
> -		     unsigned long action, unsigned int len)
> +static int diag288(unsigned int func, unsigned int timeout,
> +		   unsigned long action, unsigned int len)
>   {
>   	union register_pair r1 = { .even = func, .odd = timeout, };
>   	union register_pair r3 = { .even = action, .odd = len, };
> @@ -92,7 +92,7 @@ static int __diag288(unsigned int func, unsigned int timeout,
>   	return err;
>   }
>   
> -static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
> +static int diag288_str(unsigned int func, unsigned int timeout, char *cmd)
>   {
>   	ssize_t len;
>   
> @@ -102,13 +102,7 @@ static int __diag288_vm(unsigned int  func, unsigned int timeout, char *cmd)
>   	ASCEBC(cmd_buf, MAX_CMDLEN);
>   	EBC_TOUPPER(cmd_buf, MAX_CMDLEN);
>   
> -	return __diag288(func, timeout, virt_to_phys(cmd_buf), len);
> -}
> -
> -static int __diag288_lpar(unsigned int func, unsigned int timeout,
> -			  unsigned long action)
> -{
> -	return __diag288(func, timeout, action, 0);
> +	return diag288(func, timeout, virt_to_phys(cmd_buf), len);
>   }
>   
>   static int wdt_start(struct watchdog_device *dev)
> @@ -119,11 +113,10 @@ static int wdt_start(struct watchdog_device *dev)
>   	if (MACHINE_IS_VM) {
>   		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
>   			: WDT_FUNC_INIT;
> -		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
> +		ret = diag288_str(func, dev->timeout, wdt_cmd);
>   		WARN_ON(ret != 0);
>   	} else {
> -		ret = __diag288_lpar(WDT_FUNC_INIT,
> -				     dev->timeout, LPARWDT_RESTART);
> +		ret = diag288(WDT_FUNC_INIT, dev->timeout, LPARWDT_RESTART, 0);
>   	}
>   
>   	if (ret) {
> @@ -135,7 +128,7 @@ static int wdt_start(struct watchdog_device *dev)
>   
>   static int wdt_stop(struct watchdog_device *dev)
>   {
> -	return __diag288(WDT_FUNC_CANCEL, 0, 0, 0);
> +	return diag288(WDT_FUNC_CANCEL, 0, 0, 0);
>   }
>   
>   static int wdt_ping(struct watchdog_device *dev)
> @@ -152,10 +145,10 @@ static int wdt_ping(struct watchdog_device *dev)
>   		func = conceal_on ? (WDT_FUNC_INIT | WDT_FUNC_CONCEAL)
>   			: WDT_FUNC_INIT;
>   
> -		ret = __diag288_vm(func, dev->timeout, wdt_cmd);
> +		ret = diag288_str(func, dev->timeout, wdt_cmd);
>   		WARN_ON(ret != 0);
>   	} else {
> -		ret = __diag288_lpar(WDT_FUNC_CHANGE, dev->timeout, 0);
> +		ret = diag288(WDT_FUNC_CHANGE, dev->timeout, 0, 0);
>   	}
>   
>   	if (ret)
> @@ -206,20 +199,21 @@ static int __init diag288_init(void)
>   			return -ENOMEM;
>   		}
>   
> -		ret = __diag288_vm(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
> +		ret = diag288_str(WDT_FUNC_INIT, MIN_INTERVAL, "BEGIN");
>   		if (ret != 0) {
>   			pr_err("The watchdog cannot be initialized\n");
>   			kfree(cmd_buf);
>   			return -EINVAL;
>   		}
>   	} else {
> -		if (__diag288_lpar(WDT_FUNC_INIT, 30, LPARWDT_RESTART)) {
> +		if (diag288(WDT_FUNC_INIT, WDT_DEFAULT_TIMEOUT,
> +			    LPARWDT_RESTART, 0)) {
>   			pr_err("The watchdog cannot be initialized\n");
>   			return -EINVAL;
>   		}
>   	}
>   
> -	if (__diag288_lpar(WDT_FUNC_CANCEL, 0, 0)) {
> +	if (diag288(WDT_FUNC_CANCEL, 0, 0, 0)) {
>   		pr_err("The watchdog cannot be deactivated\n");
>   		return -EINVAL;
>   	}

