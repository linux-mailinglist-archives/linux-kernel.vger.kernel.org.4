Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC14D61DAB5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 15:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKEOCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 10:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKEOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 10:02:15 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9D220BE9;
        Sat,  5 Nov 2022 07:02:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n186so7928279oih.7;
        Sat, 05 Nov 2022 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWKQpWV4q18oUUAJI5y05A3Qk/YN9wzpbCG2obhLtyQ=;
        b=WZJGW3l1z10C+6EY2Vpl9D/BE2rvprjerZP/fVm6a0Lfz3ce47j6rdLjoeBrk9zwRf
         El2g06eggeoqBRt51CGxE8LjuJPD6nF1vLwBUE1Sr4qk0rglhlQb5+O9gkZ3NjMitZMH
         llF0MvXfOmHyhZrTQ1wAfiN/uSQ8ltVsQbD2LAVwQA0KoEDtXxG/gSH/GXDGzzs/1DzF
         GvCVUbfdpacxYILCrY9pLYW8WmQ+01h38IZmMBflXUGJsz0l0A8FqSJ6SSLZtcMO1VA0
         UbF/HZHSQxUv5WsLLHjHNFveTeI5ZrzXCK1n0ayNArjcOwVN+jcJqEe2OP6aXq0OiS/g
         cmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWKQpWV4q18oUUAJI5y05A3Qk/YN9wzpbCG2obhLtyQ=;
        b=qOMXauSZxjASkrZLyz13vfQGNT98T4Am7xxzg7/tS4MlwQ+40iGReqCKPhrgrf0D1G
         hzYBGAEr7YUQDIkAZtppNAxCHePNViT8b3/yFbtmHGrlGdbB1BjZ2Q9qccBUxMUCu9K/
         KJP9EAMMv6PkCm9YEcniHY4wWqAW2BdGku8xmXJKIpyN5paajRa+6ZEPRlt7isPB53G/
         KQZEgR8PB9wD7wlS9gUrr1T50XOLb0iHNFRltwBjLe6G8YcriVIj5n9n90PdqfwTdAVu
         aJF2mQM/LvDc45E42f4cgcw60qIY9we5x0MKORPrCvSaDBpu8ronnJjPq/5698JKksKm
         8J9A==
X-Gm-Message-State: ACrzQf2jmbpe9C+K1Lj8q/10FSUzrC3h83isf7pOoA2goBMgVpVmyq1X
        LYB0W15YsZf/HyTusFqyiiO0M3zOgfc=
X-Google-Smtp-Source: AMsMyM5RaWy/k+dJcmwEl4cIbvyShI1ptqjzBjNZBPpR17CbK3PAkFdqE/NSjFMUMWq60Wb4tRpZbA==
X-Received: by 2002:a05:6808:2387:b0:354:e5a0:ec9d with SMTP id bp7-20020a056808238700b00354e5a0ec9dmr360773oib.202.1667656932512;
        Sat, 05 Nov 2022 07:02:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020a4ae1a3000000b0048fb9b6dd70sm666953ooy.0.2022.11.05.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 07:02:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 5 Nov 2022 07:02:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH] watchdog: Include <linux/kstrtox.h> when appropriate
Message-ID: <20221105140209.GB1606271@roeck-us.net>
References: <08fd5512e569558231247515c04c8596a1d11004.1667646547.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08fd5512e569558231247515c04c8596a1d11004.1667646547.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2022 at 12:09:34PM +0100, Christophe JAILLET wrote:
> The kstrto<something>() functions have been moved from kernel.h to
> kstrtox.h.
> 
> So, in order to eventually remove <linux/kernel.h> from <linux/watchdog.h>,
> include the latter directly in the appropriate files.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c   | 1 +
>  drivers/watchdog/watchdog_dev.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 0cff2adfbfc9..10863d2ef924 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/kstrtox.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 55574ed42504..f31608f3e324 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -35,6 +35,7 @@
>  #include <linux/init.h>		/* For __init/__exit/... */
>  #include <linux/hrtimer.h>	/* For hrtimers */
>  #include <linux/kernel.h>	/* For printk/panic/... */
> +#include <linux/kstrtox.h>	/* For kstrto* */
>  #include <linux/kthread.h>	/* For kthread_work */
>  #include <linux/miscdevice.h>	/* For handling misc devices */
>  #include <linux/module.h>	/* For module stuff/... */
> -- 
> 2.34.1
> 
