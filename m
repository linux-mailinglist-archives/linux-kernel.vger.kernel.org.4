Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA9E638BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiKYOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKYOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:00:12 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640A71A20B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:00:11 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id p18so2686335qkg.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjzxbShCuhaNg54+nrPp15MJmztbSk7YVhXWVk5CBJ8=;
        b=IbVcdyFbKtMGOCI/11X2t+p5NtvR/9w8nSvKKteyFaxhkx5HAUHYAFVub1UQI8nMC9
         SwcOXGPeD+VYqUb2ulYG8hDJtKd1HSrretLGt0o5MH0UZfBClDvOkzNGelRau4SULhut
         wTGwy+ZaeGqLotPjGaKF8GgVRhKOErluq5DzCSw0XNMcQBVHpfTpm9/r+N+jKgFIS5aP
         ohEFiiA1+I9VzeWoYwqI3iHr+tVNfB9fSnGn7Nonr+Bp0D0U61VIxgS8JthPMBelBpiV
         jnRfqZ0d6EZgIq+HSx9tUPQESSd5wl0aVFOsmIqURSvqESqQMVm3HNpWBCPhrbqFjMiG
         c7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjzxbShCuhaNg54+nrPp15MJmztbSk7YVhXWVk5CBJ8=;
        b=N+0ev3zPyxmlLEB+t0cWWHoVwN9AuqHKpGoW5SQpA3Pey/gj0by74syhlZWnYy27f7
         jr5dTxefVGcRslYjJsjmyzW2ovy1e6YmWcAI5u5/p18lpIJZtWbMVTmiVHn8YSertGa9
         FJugsDbQHJZBpJ53IuGzJWw7cAIwXiKO7Z+5hhobsikZ4kC/AjeVIvr9F9NaxIlszAFU
         G84eAVSFdl4Uv6ruxgyv3ti+CxEka5308PkrM+rx2mxIvSmQz4qGBeRK07aMLm1Tw2Pv
         YOIhyG8J1PDDDq807IaMwHTBZKPQ31T8sPZ+Q27z0rIxysRmD5HNSMOeUMABsEkQXYo+
         Fg9A==
X-Gm-Message-State: ANoB5pkj7twAPCvQ76In/GCgsHnEpO03OOEG8+cv2MYD4EGacUqEvXiA
        tP45C1Je1SVt13y6fA3C608=
X-Google-Smtp-Source: AA0mqf67DtXFtn/qb9P6aBhjIcVo0SEDwkPqGPdEOyz3y0/cgnjrBHYYrLUo62bgOLN0kaqe0PEtJg==
X-Received: by 2002:a05:620a:8009:b0:6fa:88c:50e5 with SMTP id ee9-20020a05620a800900b006fa088c50e5mr33170333qkb.186.1669384809363;
        Fri, 25 Nov 2022 06:00:09 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-72-77-81-136.pitbpa.fios.verizon.net. [72.77.81.136])
        by smtp.gmail.com with ESMTPSA id u19-20020a37ab13000000b006e99290e83fsm2713482qke.107.2022.11.25.06.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:00:08 -0800 (PST)
Date:   Fri, 25 Nov 2022 09:00:02 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <Y4DKYqgecIlGTxQK@errol.ini.cmu.edu>
References: <20221124161618.34ca07b3@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124161618.34ca07b3@endymion.delvare>
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 04:16:18PM +0100, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> As a minor optimization, this also lets us drop of_match_ptr() and
> ifdef-guarding, as we now know what they will resolve to, we might as
> well save cpp some work.

Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Thanks,
--G
 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Karol Gugala <kgugala@antmicro.com>
> Cc: Mateusz Holenko <mholenko@antmicro.com>
> Cc: Gabriel Somlo <gsomlo@gmail.com>
> Cc: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/soc/litex/Kconfig          |    2 +-
>  drivers/soc/litex/litex_soc_ctrl.c |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> --- linux-6.0.orig/drivers/soc/litex/Kconfig
> +++ linux-6.0/drivers/soc/litex/Kconfig
> @@ -7,7 +7,7 @@ config LITEX
>  
>  config LITEX_SOC_CONTROLLER
>  	tristate "Enable LiteX SoC Controller driver"
> -	depends on OF || COMPILE_TEST
> +	depends on OF
>  	depends on HAS_IOMEM
>  	select LITEX
>  	help
> --- linux-6.0.orig/drivers/soc/litex/litex_soc_ctrl.c
> +++ linux-6.0/drivers/soc/litex/litex_soc_ctrl.c
> @@ -82,13 +82,11 @@ static int litex_reset_handler(struct no
>  	return NOTIFY_DONE;
>  }
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id litex_soc_ctrl_of_match[] = {
>  	{.compatible = "litex,soc-controller"},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, litex_soc_ctrl_of_match);
> -#endif /* CONFIG_OF */
>  
>  static int litex_soc_ctrl_probe(struct platform_device *pdev)
>  {
> @@ -131,7 +129,7 @@ static int litex_soc_ctrl_remove(struct
>  static struct platform_driver litex_soc_ctrl_driver = {
>  	.driver = {
>  		.name = "litex-soc-controller",
> -		.of_match_table = of_match_ptr(litex_soc_ctrl_of_match)
> +		.of_match_table = litex_soc_ctrl_of_match,
>  	},
>  	.probe = litex_soc_ctrl_probe,
>  	.remove = litex_soc_ctrl_remove,
> 
> 
> -- 
> Jean Delvare
> SUSE L3 Support
