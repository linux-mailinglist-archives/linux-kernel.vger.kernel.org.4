Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD805E94F7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiIYRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIYRhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:37:32 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E6A2BB2C;
        Sun, 25 Sep 2022 10:37:31 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id i6so448272pfb.2;
        Sun, 25 Sep 2022 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=LvcwNzv4Ih0dEIU3Z97vDHQe8FGkDkmzBOXb4/gsOks=;
        b=A8VWtO/SDapcveMPwicIvNuGIjgyYLmS26k+6AERfB0Qw9s7ODw4kg6iJfsDL2zhUf
         8uh4f5fOiql206lN2OXR2w33iihuI9OagShXpwnOkDFIey0GULWX/mOYpW0WKhUqMzGW
         PTZb5US8kgZC9OicPnBTjiKni5oFChWytxXQQX4g69GKRi9wFGyplc1M5S8FVkAgq+Rw
         Pkja+4upBTH7VnBRAa9l3yMlzx3vYU3GNR0Hib5DA0FzOdAfKWbRP+Qf42dRp1GDA6nY
         ujgWBplA93Zf2It3TYRgeGzcBQwSt3X8OnO8gPcZYv+a7uyROtmM7W1tBnnRyPwcJHPq
         AGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LvcwNzv4Ih0dEIU3Z97vDHQe8FGkDkmzBOXb4/gsOks=;
        b=HB5UqUvKwEZ38k1XYG/5sLDe3UQXxCwuUWbfWxLypk+dGNmWL2CEcggnx4bZzpQA2U
         vXPlqlp0utG4eB5UYp3jt5R7lE6At8VVaAPLynczQu01ucAoV8M8bLozQRL8XIL3EZeU
         19qnaEz1cS1976jkagzUzBITMyAe6d5i5J4hIC4PqU75wZAzTPagCSv91yrSUu6uc4jX
         7rxDEQR09Dz4KuYudC51y79CFnOOMODZDjUfR0OhC/gLY+tYKLg6xjSYpnYiO5+Z4EyE
         0SqpuER6iEDdyu/y0S84Ty65ihtPCQVIF703v0I4CmH7i2yiNciVeQct6qbgWTMsc0J/
         DDRA==
X-Gm-Message-State: ACrzQf1OYu2ajVtMr1HG2UN7fU+R4XWG14QMT8F1cMmasAKd7dv14bwQ
        UXUJzU+7kfyf8mudxnH3jHs=
X-Google-Smtp-Source: AMsMyM5ukmC+J/nWhj8tLSkU8PdtCBITUCyL6PKTXo1KQOrY+LELb8G+1SnL0RrOzpEqiVb5xY/vWw==
X-Received: by 2002:a63:6685:0:b0:43a:107:d45a with SMTP id a127-20020a636685000000b0043a0107d45amr16267002pgc.49.1664127451353;
        Sun, 25 Sep 2022 10:37:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k2-20020a634b42000000b0043bed49f31fsm8444720pgl.8.2022.09.25.10.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:37:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:37:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] watchdog: imx7ulp: Move suspend/resume to noirq
 phase
Message-ID: <20220925173729.GA1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-2-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-2-alice.guo@oss.nxp.com>
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

On Thu, Aug 25, 2022 at 04:32:50PM +0800, Alice Guo (OSS) wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> The i.MX7ULP's watchdog is enabled by default when out of reset, so the
> resume callback which is to disable watchdog should be called earlier
> to avoid unexpected timeout, move suspend/resume callback to noirq phase.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Tested-by: Peter Chen <peter.chen@nxp.com>
> Tested-by: Li Jun <jun.li@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - none
> 
>  drivers/watchdog/imx7ulp_wdt.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 922b60374295..014f497ea0dc 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -255,7 +255,7 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
>  	return devm_watchdog_register_device(dev, wdog);
>  }
>  
> -static int __maybe_unused imx7ulp_wdt_suspend(struct device *dev)
> +static int __maybe_unused imx7ulp_wdt_suspend_noirq(struct device *dev)
>  {
>  	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
>  
> @@ -267,7 +267,7 @@ static int __maybe_unused imx7ulp_wdt_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused imx7ulp_wdt_resume(struct device *dev)
> +static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
>  {
>  	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
>  	u32 timeout = imx7ulp_wdt->wdd.timeout * WDOG_CLOCK_RATE;
> @@ -286,8 +286,10 @@ static int __maybe_unused imx7ulp_wdt_resume(struct device *dev)
>  	return 0;
>  }
>  
> -static SIMPLE_DEV_PM_OPS(imx7ulp_wdt_pm_ops, imx7ulp_wdt_suspend,
> -			 imx7ulp_wdt_resume);
> +static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx7ulp_wdt_suspend_noirq,
> +				      imx7ulp_wdt_resume_noirq)
> +};
>  
>  static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
>  	{ .compatible = "fsl,imx7ulp-wdt", },
> -- 
> 2.17.1
> 
