Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60C05BC1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiISERp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiISERn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:17:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525111C1B;
        Sun, 18 Sep 2022 21:17:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso4926624pjd.4;
        Sun, 18 Sep 2022 21:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=xvBYQEJlnutmzsBa+QOcpxvGoRXQhVpejHGJpeAOxkU=;
        b=dU4n/EvFzEBPci2Ddrpy6TiF6zQh2Mtp+oHWXb405CNEATK+AOXtBuYIYd/tMNpqWn
         M2/PuG1jVEkdMXjaAl9ttTfYpQblWAnfyJ+RHTeH6fxMtzjXCrJWQTU6G4oo0KICfMjA
         8qw5+NePeMXT2MFHSnX1ZD50Qe37syd73WFMg0QbBbefgOHEo+nTkWu6on+F4Fnj3rH4
         qzFUVWQ10eI3/iX8eDnD7UavFGFiV5qiRexYwwBEfaguyJQEl7hAlrU+gqV5ck8bW1PR
         XZSK6dznG2kiu/SkU4MIQdNV05EqPamXVetY5ZL101uPyqjjMoFVMDLrpk/QRf1y5kK8
         YCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xvBYQEJlnutmzsBa+QOcpxvGoRXQhVpejHGJpeAOxkU=;
        b=RKiYp+lTa55Oe6xCcxRo8TpJ3yYliwPor/GdttgyDXcuPcR2ah0G3ZxAzEbpPUedGj
         gPpcX9Rew8PUtUHY7+jOAEKSiHC4T3t8ahi2pxAoxdcchL0QaJWPIRkfGjtXQHJAjxJd
         lSc+tFpul2jNb+jPjFD1b3BiLctpKI+7tKUj8WlcMzm0xh5sTqDYTFTwhb+eG2niq6eE
         oKp5g+FR9g3fmfy3pdPL4rsga2LF4gGU5ElToWGqGKnWrNAs4Ph2WujFz897ud0NXADR
         ABTst+fypabEmGw7LtuJBu7gBEq7bv42BvBmSz7XwvJKZS9vO4/NCBnNPaJdMGS/Uyvr
         lN2Q==
X-Gm-Message-State: ACrzQf37NIGCZPaAQMLnGVUqu9RV0TXHhk9AideoJ2/SC64VIPeuZiPw
        GriDb/QqZYZKl0lWUwnGj5H62+DseL4FNw==
X-Google-Smtp-Source: AMsMyM59wmTasauLFeA6g9m6IOJ9i5Ww/m2Mg1qGQzdrp0Ek0GINmeCUDLbNvt9Phr0W+EYGHE2K3g==
X-Received: by 2002:a17:903:2104:b0:176:a9ef:418b with SMTP id o4-20020a170903210400b00176a9ef418bmr11132625ple.134.1663561058922;
        Sun, 18 Sep 2022 21:17:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d8-20020a631d08000000b00434feb1841dsm17335626pgd.66.2022.09.18.21.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 21:17:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aabb7c21-9a80-696e-6a38-29de57e025ba@roeck-us.net>
Date:   Sun, 18 Sep 2022 21:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Vladimir Panteleev <git@vladimir.panteleev.md>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220918140829.443722-1-git@vladimir.panteleev.md>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] watchdog: sp5100_tco: Add "action" module parameter
In-Reply-To: <20220918140829.443722-1-git@vladimir.panteleev.md>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 07:08, Vladimir Panteleev wrote:
> Allow configuring the "action" bit, as documented in [1].
> 
> Previously, the only action supported by this module was to reset the
> system (0).  It can now be configured to power off (1) instead.
> 
> [1]: https://www.amd.com/system/files/TechDocs/44413.pdf
> 
> Signed-off-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> ---
>   drivers/watchdog/sp5100_tco.c | 13 +++++++++++--
>   drivers/watchdog/sp5100_tco.h |  2 +-
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index ae54dd33e233..802f12e8fd76 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -65,6 +65,12 @@ static struct pci_dev *sp5100_tco_pci;
>   
>   /* module parameters */
>   
> +#define WATCHDOG_ACTION 0
> +static bool action = WATCHDOG_ACTION;
> +module_param(action, bool, 0444);
> +MODULE_PARM_DESC(action, "Action taken when watchdog expires, 0 to reset, 1 to poweroff (default="
> +		 __MODULE_STRING(WATCHDOG_ACTION) ")");
> +

Other module parameters are not visible. I do not see the benefit of
having this one visible.

>   #define WATCHDOG_HEARTBEAT 60	/* 60 sec default heartbeat. */
>   static int heartbeat = WATCHDOG_HEARTBEAT;  /* in seconds */
>   module_param(heartbeat, int, 0);
> @@ -297,8 +303,11 @@ static int sp5100_tco_timer_init(struct sp5100_tco *tco)
>   	if (val & SP5100_WDT_FIRED)
>   		wdd->bootstatus = WDIOF_CARDRESET;
>   
> -	/* Set watchdog action to reset the system */
> -	val &= ~SP5100_WDT_ACTION_RESET;
> +	/* Set watchdog action */
> +	if (action)
> +		val |= SP5100_WDT_ACTION;
> +	else
> +		val &= ~SP5100_WDT_ACTION;
>   	writel(val, SP5100_WDT_CONTROL(tco->tcobase));
>   
>   	/* Set a reasonable heartbeat before we stop the timer */
> diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
> index 6a0986d2c94b..9752ab2b0130 100644
> --- a/drivers/watchdog/sp5100_tco.h
> +++ b/drivers/watchdog/sp5100_tco.h
> @@ -18,7 +18,7 @@
>   
>   #define SP5100_WDT_START_STOP_BIT	BIT(0)
>   #define SP5100_WDT_FIRED		BIT(1)
> -#define SP5100_WDT_ACTION_RESET		BIT(2)
> +#define SP5100_WDT_ACTION		BIT(2)

I do not see the point of renaming this define.

>   #define SP5100_WDT_DISABLED		BIT(3)
>   #define SP5100_WDT_TRIGGER_BIT		BIT(7)
>   

