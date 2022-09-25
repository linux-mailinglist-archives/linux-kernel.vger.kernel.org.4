Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6525E94FC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiIYRiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbiIYRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:38:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF62F032;
        Sun, 25 Sep 2022 10:37:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso4732503pjm.5;
        Sun, 25 Sep 2022 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=xO448KceCisavgnMEtu9+mgSatT/mAr0e7j2jQiXQOs=;
        b=DSS1aszJsakUZlcb7/PTe16dIZzZYm4BhnUgSuNVpOT2LZ1uqlazjrdX42YPGVAkiD
         k78sYxx9jWssLTAkbM5vCPAHMDKBtAUKLwo23v3m6xkw7GLsySs71OSCxNFxEB9p6nNU
         XlySIQVQkRTnSRgjeJpJAkVHEpBy7Jz5XW5j+hdjBQDITVGlm5Hk11L1XkFFqy4Q7CCa
         dNlJaoHqd2fAqj1AGqTzxLFfnHGsudwiFxrWS4XEhgiP7xa/dpZ9N63WSXjv6EKvQSG+
         ZPVa/5I9IQ/R0FoAhh0kv48jrS++cDCXZm1LNGVBVH2QQD1E4eHSY3tK/7v9tGjhYYMs
         lDmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xO448KceCisavgnMEtu9+mgSatT/mAr0e7j2jQiXQOs=;
        b=m4QYY+CO1PNtobnJfuJc2naAybIPXYNxeCqEscBGsBXdkwQH6LVQQG0w2NpB4QrbJk
         BmZ6P7WjXtdug3O3pXAzQO5EJEBx+IF+XYkFnX1JUfeDyKwq7IMhODO1DnQNRdK9aznU
         RDM7+XcnurflTsE8Ro3L5u7y0r8BzcZfztps18v4E0gR7kojK9Ca/fHUja21lcUe+82Z
         HfQuRQlHw1i4jK6MRmXSeJv+MvtgT1M5HX3NWInjtDGljcqT61CTsItHPspSfkOq8imC
         nFkQ4PqL6JG5z3sak9aXpIA2JubO6lV8QLehcw5amc8veVvCyFQILMf0nWYBV09qEi5A
         dF8Q==
X-Gm-Message-State: ACrzQf0a4W82P0dlKKw60MoYR1tkob4XqeB6H1CdvK2cDOI/Dt55bImo
        GhAX4utBHiJ34NBGGHQo1ng=
X-Google-Smtp-Source: AMsMyM6Fn/F4zHe5vkGrtbUhUFxGb86wljflha7lD+1Ypm8Et09ZnFu5Xy60yHwXmZ/fJxvmm9znmg==
X-Received: by 2002:a17:90b:3803:b0:203:a31c:e2e9 with SMTP id mq3-20020a17090b380300b00203a31ce2e9mr20398444pjb.13.1664127478675;
        Sun, 25 Sep 2022 10:37:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b0016f057b88c9sm9547644pls.26.2022.09.25.10.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:37:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:37:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] watchdog: imx7ulp_wdt: Check CMD32EN in wdog init
Message-ID: <20220925173757.GC1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-4-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-4-alice.guo@oss.nxp.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:32:52PM +0800, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> When bootloader has enabled the CMD32EN bit, switch to use 32bits
> unlock command to unlock the CS register. Using 32bits command will
> help on avoiding 16 bus cycle window violation for two 16 bits
> commands.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - none
> 
>  drivers/watchdog/imx7ulp_wdt.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index b8ac0cb04d2f..a0f6b8cea78f 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -180,11 +180,16 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
>  
>  	local_irq_disable();
>  
> -	mb();
> -	/* unlock the wdog for reconfiguration */
> -	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> -	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> -	mb();
> +	val = readl(base + WDOG_CS);
> +	if (val & WDOG_CS_CMD32EN) {
> +		writel(UNLOCK, base + WDOG_CNT);
> +	} else {
> +		mb();
> +		/* unlock the wdog for reconfiguration */
> +		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
> +		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> +		mb();
> +	}
>  
>  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
>  	if (ret)
> -- 
> 2.17.1
> 
