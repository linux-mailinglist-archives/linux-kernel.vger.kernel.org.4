Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7C6606AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJTWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiJTWAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:00:34 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CC110B2D;
        Thu, 20 Oct 2022 15:00:31 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-13af2d12469so1231414fac.13;
        Thu, 20 Oct 2022 15:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VOAmf6LMMzFHHFyiTHvOQ6ROsuoWD0GGZVua/cd2o40=;
        b=B4KqYc2mv+RbpdPMtvqHy8+rA10bS0giGabR5xTKZuTPhRhmafJGmENMZXNYMA9xZb
         s0KCzll9kgG2KMZcPUk91nJexwZF5/H9gIPpyrmCletvr91HnDC1VYiBFhyRnmy3+gY1
         lofO5PPd8jsGK1p9B2Ls2oo4SyIEO/BV5v54Z934nxL1t1+irulUisARVx9JkNmjMtJq
         1znBdnGP1ar0qWpMWYU/QrDwKzWlOse9rA2f0oMjXZgpJTMiDxgxXPnAjS9LWQTroBv0
         81OQSJ+kgc/hDR5LIdrRNQ5x2bOE+g0R4PGCJh4VTPTCqV5roALsiEmpXlVRWSZLdPbC
         jrOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VOAmf6LMMzFHHFyiTHvOQ6ROsuoWD0GGZVua/cd2o40=;
        b=Zl0HBGz+VB1/QHiX3m671sDoPOg/Cmc5xs2Qjjgy4V0KqboWa3CAvaJMQbrvfYRFWh
         mEHE20AB5sFcSyDKa9qv4Fchn8K0xhQiu69IUGkPiAZelo8Oo34Fqx6KvAJ//e/4gNJQ
         VUT1AvU0ep/20dJkk0jUbJm3xaKFyZ2XP+Bjnr9cefH8gN5lLyftFQtfhXQXMQA/0bUt
         vutApGZFTsfCqP4v5t2B9RHJmnACy2Rix6dkCBAZX8NC+HmXtzEGzeJ5B1FSaMb65vUj
         qZgs7s4s23P5+GTCTojjzPTMebGOtvZm4Mz+6x8phlTT60FwiuE/zD/lSe3tzxSfbbl2
         YCMQ==
X-Gm-Message-State: ACrzQf1sBrXZm3gexO8JnsFxBYHt1QcpnZ4IxRFEAAEvmok1vEp6yD4Z
        B77sMo2hEmuqEyKV76RDVUQ=
X-Google-Smtp-Source: AMsMyM5ep75R4Y+KYb34yU+as//zw7oUEUnGn7n3/9oF7uhoadLDyjBFhT/7JdD1Vp+UVCYuRVMp+A==
X-Received: by 2002:a05:6870:c147:b0:136:90c4:ee84 with SMTP id g7-20020a056870c14700b0013690c4ee84mr10385807oad.295.1666303231308;
        Thu, 20 Oct 2022 15:00:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e25-20020aca1319000000b00342eade43d4sm443013oii.13.2022.10.20.15.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:00:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 15:00:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] watchdog: kempld: Remove #ifdef guards for PM
 related functions
Message-ID: <20221020220029.GD4035307@roeck-us.net>
References: <20221020185047.1001522-1-paul@crapouillou.net>
 <20221020185047.1001522-5-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020185047.1001522-5-paul@crapouillou.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 07:50:47PM +0100, Paul Cercueil wrote:
> Use the pm_ptr() macro to handle the .suspend/.resume callbacks.
> 
> This macro allows the suspend and resume functions to be automatically
> dropped by the compiler when CONFIG_SUSPEND is disabled, without having
> to use #ifdef guards. Not using #ifdef guards means that the code is
> always compiled independently of any Kconfig option, and thanks to that
> bugs and regressions are easier to catch.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/kempld_wdt.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
> index 40bd518ed873..e6c7a2906680 100644
> --- a/drivers/watchdog/kempld_wdt.c
> +++ b/drivers/watchdog/kempld_wdt.c
> @@ -75,9 +75,7 @@ struct kempld_wdt_data {
>  	struct watchdog_device		wdd;
>  	unsigned int			pretimeout;
>  	struct kempld_wdt_stage		stage[KEMPLD_WDT_MAX_STAGES];
> -#ifdef CONFIG_PM
>  	u8				pm_status_store;
> -#endif
>  };
>  
>  #define DEFAULT_TIMEOUT		30 /* seconds */
> @@ -495,7 +493,6 @@ static int kempld_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM
>  /* Disable watchdog if it is active during suspend */
>  static int kempld_wdt_suspend(struct platform_device *pdev,
>  				pm_message_t message)
> @@ -531,18 +528,14 @@ static int kempld_wdt_resume(struct platform_device *pdev)
>  	else
>  		return kempld_wdt_stop(wdd);
>  }
> -#else
> -#define kempld_wdt_suspend	NULL
> -#define kempld_wdt_resume	NULL
> -#endif
>  
>  static struct platform_driver kempld_wdt_driver = {
>  	.driver		= {
>  		.name	= "kempld-wdt",
>  	},
>  	.probe		= kempld_wdt_probe,
> -	.suspend	= kempld_wdt_suspend,
> -	.resume		= kempld_wdt_resume,
> +	.suspend	= pm_ptr(kempld_wdt_suspend),
> +	.resume		= pm_ptr(kempld_wdt_resume),
>  };
>  
>  module_platform_driver(kempld_wdt_driver);
> -- 
> 2.35.1
> 
