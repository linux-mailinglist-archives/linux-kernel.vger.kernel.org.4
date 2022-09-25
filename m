Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C495E94FE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiIYRiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIYRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:38:15 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F02F038;
        Sun, 25 Sep 2022 10:38:13 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id w2so4681317pfb.0;
        Sun, 25 Sep 2022 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=2vEbHYuJGgQum3kzmbdVe9uD89qeBZ07c5sX6JB1tcI=;
        b=YuDjhzNIBBIcGapSxPLiAW/CSLoE1d2A7Pp/zdSQ6b6qam9inwQMvRMQFi+gv7yR//
         WCH29foGVBUc1/S5/CkZmIhfdPluLXU0nFttnCae6xJFU/oM8L+vlkyFThdqnW0eTjoY
         adm1spunUtcx9bMhnbe6WLNtYc2ua8YaiMKVC9N62PwaVWTsj102WpmU8667AIYHue/B
         7pwYgxBUwn1/x8k1EvcUaWSdiJluVTtKWAfunMDXYxpyD4TOUJJTn2li+5zrYHJi7gLW
         e/TZioLVipN9BBsaylJaYARIQWCBJftrJPLEQUQHhHbqWno2s7uaLPzoIYEV4lvjHOR9
         Cwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2vEbHYuJGgQum3kzmbdVe9uD89qeBZ07c5sX6JB1tcI=;
        b=HGJGCaHh3aYNB2TgqF4wjh24d7mEot4h8e02Tj7SUzesoW+eUpG6cgION0vVr0y4le
         bT45Hs/eyZODCXYPSFQlmVS4oxkth1vknDzsQMVouww4gW7weJFq6+hSvgeSeHNmN469
         4MBb3jNVubqLHVHleyx6DA3kXJugcY8uKWdFlBK/Sh74a6vIscMgijl0vEDM3h4wVMB9
         51Gwt4X31Ni4/CIvcWLlRuYuPu8tbaH1ZH1CviMI5AIr8pTTjb6GtV3KeBG60nbP2R6S
         bjOko7Ggg1x5YH2aguXhdQiU4hkHGE+nBrypbB4BAVgzIWqPbpID3oft7i/zPshNqj/I
         O+EQ==
X-Gm-Message-State: ACrzQf1EOvU3V7B/CMRbOVpA7AJZkZ/IF8U86lG4CFu/K0mbLNH+bWwE
        dO8qhWk1vqqA199KsE6ontHvUZUvcdGMHg==
X-Google-Smtp-Source: AMsMyM5JsDvTGWSHqgW/daBtU0EMC7bEQ9c2t7DnNOQKLIKMdlYvi9XHr6GpXXlyC5IAz0pGHMJI/Q==
X-Received: by 2002:a05:6a00:9a7:b0:54c:27c4:3ad6 with SMTP id u39-20020a056a0009a700b0054c27c43ad6mr19939850pfg.9.1664127492442;
        Sun, 25 Sep 2022 10:38:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b0016cf3f124e1sm9699668plf.234.2022.09.25.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:38:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:38:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Message-ID: <20220925173810.GD1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-5-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-5-alice.guo@oss.nxp.com>
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

On Thu, Aug 25, 2022 at 04:32:53PM +0800, Alice Guo (OSS) wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
> about 3400us and 6700us respectively. So current 20us timeout is
> not enough. When reconfiguring is on-going, unlock and configure CS
> will lead to unknown result.
> 
> Increase the wait timeout value to 10ms and check the return value
> of RCS wait to fix the issue
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
>  drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index a0f6b8cea78f..12715c248688 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -39,7 +39,7 @@
>  #define DEFAULT_TIMEOUT	60
>  #define MAX_TIMEOUT	128
>  #define WDOG_CLOCK_RATE	1000
> -#define WDOG_WAIT_TIMEOUT	20
> +#define WDOG_WAIT_TIMEOUT	10000
>  
>  static bool nowayout = WATCHDOG_NOWAYOUT;
>  module_param(nowayout, bool, 0000);
> @@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
>  		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
>  	else
>  		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
> -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
>  
>  enable_out:
>  	local_irq_enable();
> @@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
>  	if (ret)
>  		goto timeout_out;
>  	writel(val, wdt->base + WDOG_TOVAL);
> -	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
> +	if (ret)
> +		goto timeout_out;
>  
>  	wdog->timeout = timeout;
>  
> -- 
> 2.17.1
> 
