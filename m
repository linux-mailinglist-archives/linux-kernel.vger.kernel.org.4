Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86705E9503
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIYRiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbiIYRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:38:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA02EF2E;
        Sun, 25 Sep 2022 10:38:34 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id go6so4383367pjb.2;
        Sun, 25 Sep 2022 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=vQZO1T+2P9vB/pAMKD6Wmpnh4LsSpeo97BnzaUWc8kw=;
        b=V1WwtKj2hYjgQkYuV+CzUcuHJcJKeuorLIpBql4WK464n0rrnZ4eLe8jNObsTSw5eh
         DfAB2aHJUTkIEOJq79ArH3vWGT3HHoRwSiszdZRUXiegTHJxU7mEmv98fvL41WDbyIdF
         jYGTp4hKyvZgJotOy3xeRpIM4lCrAA9JovVlenZ9B6fscRiPG6526u2lrZAqZbhKhKNS
         sjPTyRImZcvE7q/6ucWLQOzoKBSBp3RoCSBCCfdJcIGd7zfu9Ex3eoGRaHjm/w1NSoI9
         xh4rGkDEA0I65J1oREAeCDfQFOPrffpjcYC/FPgVm+iK1r70MbQ4Ln1PiN1R3FpbwqoB
         T+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vQZO1T+2P9vB/pAMKD6Wmpnh4LsSpeo97BnzaUWc8kw=;
        b=6F8Bdfgrso2ZxD31vgA5vkjBlwcNHFBjvZ/mCSSZXqBq8vFaGaap0EzwnuNyHL2K3F
         j4u78kzciADXJJAMzN0XbzznzRvbvmFHoBmURIaAta8CdewEz7O3Qw7bdEcyOKKPcVzA
         5u1ay89d5tWvZG/RlV0re4rRxVOuyh01L5M0W3HRgdFE/EtiTF1d4RaTR8Nq+uFL+ggv
         uqhxVhBsZC7uE+1gADqWZMcWTygijiPmfMsW9f58qi6OsWFCwrkOKGhNeErCPC4l4eMU
         7DIIyJ6gCVh61Mpq5/YR/7PW69G4o7KYElifhluhkNPNHaIjUoYt5xVA6RQMW7sNUmSj
         bTIw==
X-Gm-Message-State: ACrzQf0mx7Q3OiFjgCI+yHiFv6hRH8Oq5Z8RxDSykL35yPB9i7AiPJzW
        hViRhp0XnybOkI2FfOhMrOjXjtOeIBb8JA==
X-Google-Smtp-Source: AMsMyM7OIFM4CJxHM2BKDOc/BYhHvukBGHOTZosq9H5BaZKKIe0cn6ZLE92n09UAsXpQbjAFIo3CnA==
X-Received: by 2002:a17:902:f707:b0:178:77ca:a770 with SMTP id h7-20020a170902f70700b0017877caa770mr18142218plo.54.1664127513845;
        Sun, 25 Sep 2022 10:38:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b00176d8e33601sm9555031plg.203.2022.09.25.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:38:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:38:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] watchdog: imx7ulp_wdt: init wdog when it was
 active
Message-ID: <20220925173832.GF1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-7-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-7-alice.guo@oss.nxp.com>
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

On Thu, Aug 25, 2022 at 04:32:55PM +0800, Alice Guo (OSS) wrote:
> From: Jason Liu <jason.hui.liu@nxp.com>
> 
> Paired with suspend, we can only init wdog again when it was active
> and ping it once to avoid the watchdog timeout after it resumed.
> 
> Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Tested-by: Jacky Bai <ping.bai@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - none
> 
>  drivers/watchdog/imx7ulp_wdt.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 0cafa86fff7f..dee02c2a52c9 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -136,13 +136,6 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
>  	return ret;
>  }
>  
> -static bool imx7ulp_wdt_is_enabled(void __iomem *base)
> -{
> -	u32 val = readl(base + WDOG_CS);
> -
> -	return val & WDOG_CS_EN;
> -}
> -
>  static int imx7ulp_wdt_ping(struct watchdog_device *wdog)
>  {
>  	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
> @@ -382,11 +375,11 @@ static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (imx7ulp_wdt_is_enabled(imx7ulp_wdt->base))
> +	if (watchdog_active(&imx7ulp_wdt->wdd)) {
>  		imx7ulp_wdt_init(imx7ulp_wdt, timeout);
> -
> -	if (watchdog_active(&imx7ulp_wdt->wdd))
>  		imx7ulp_wdt_start(&imx7ulp_wdt->wdd);
> +		imx7ulp_wdt_ping(&imx7ulp_wdt->wdd);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
