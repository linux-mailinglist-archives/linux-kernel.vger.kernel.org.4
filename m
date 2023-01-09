Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A784066237B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbjAIKux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjAIKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:50:45 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF29E3C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:50:43 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i15so11923109edf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqpbrmxeSQQBxu71jkn/XTeqp1cCCSTeMHOpaUyG7fI=;
        b=SByDc+YboU7YzuE2RU55S4PSRPtNPCVKltMmSvsWl99LYIq2MsIKmqMdn01FVK8Ox4
         dwfizovmv8tyrXCsGaK/K2JjCxuuFpW0OSrJsmN+ZBxnbCwM5orNiKTVrok6UNrGjlOX
         QGyoq8VxBjiqOQUVQ1ND9N+MUajmQ931gry6xDaN1W40YKXYmD2wk5z3E9Ow/6kTFIvN
         bglFIoNZ5sFB/Kf0Q7Hle3sAVRZ/L5jyC9Fk0KZckygk6CbewjtQb+M/C/Ljjj08r6GG
         Zw+CERzkR+Vsn+hWy0iu712oB5pbeL1Gnt0ZcPiFcQW+tRFj1n3RKY+vJClfsU/uXuaH
         KXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqpbrmxeSQQBxu71jkn/XTeqp1cCCSTeMHOpaUyG7fI=;
        b=uBZAgQIuLLX2s2BW5nmMAuTxvcgw0cb+XgY0rK6KUhjHRYVjpj95y7INWVqN+GHI6G
         ry914djtnywKTqBGg2sc/KoolBrB+Ns/3htWoZqMEgbt+Q40mzBjkRxTG4Uu8CNTtXe6
         lUtQEvrX0CMy+uYfOWSvvUhHsHMVA2YY8IROiiakBqWF2n2IsoOkVSDCAeJiiZa6knF+
         u8BYSFB0jMAtfVk4LRCGMBVEtMKjcSy2x2Qb0epTDAF3KRLv6Cd6g+JzubrX8yfy9BOW
         yOhSJadX4pLP/g6kHUpjNwGflBl9A87vb1hVcTBE26yLN+E20Fe/3UHv1BbYdfjdXVgD
         jPFQ==
X-Gm-Message-State: AFqh2koxpLDNbialuKCl9MuAwg6jT1SNzx6yqFbCl/fVs/6nI/z5nGkh
        LH939I6FYr5Z64/QRLz2PWRDfw==
X-Google-Smtp-Source: AMrXdXtYJYLVPTI4WLtq8sxOc8zoksIY9GdCa9B7v/Ng/gLbxGBzT6tcH11TG3tccr7Lr2DRyYp1+Q==
X-Received: by 2002:a05:6402:500a:b0:498:18e7:1667 with SMTP id p10-20020a056402500a00b0049818e71667mr7651891eda.10.1673261442127;
        Mon, 09 Jan 2023 02:50:42 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id s17-20020a1709060c1100b0084d21db0691sm3573669ejf.179.2023.01.09.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:50:41 -0800 (PST)
Date:   Mon, 9 Jan 2023 12:50:40 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: fix compile testing imxrt1050
Message-ID: <Y7vxgEgCQyp6ODCx@linaro.org>
References: <20221215165836.2136448-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215165836.2136448-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-12-15 17:58:18, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig testing revealed multiple issues with this driver:
> 
> ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-imxrt1050.o
> ERROR: modpost: "imx_clk_hw_pllv3" [drivers/clk/imx/clk-imxrt1050.ko] undefined!
> ERROR: modpost: "imx_clk_hw_pfd" [drivers/clk/imx/clk-imxrt1050.ko] undefined!
> 
> Export the necessary symbols from the core clk driver and add the
> license and author tags. To find this type of problem more easily
> in the future, also enable building on other platforms, as we do for
> the other i.MX clk drivers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fixes tag maybe?

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/Kconfig         | 2 +-
>  drivers/clk/imx/clk-imxrt1050.c | 4 ++++
>  drivers/clk/imx/clk-pfd.c       | 2 ++
>  drivers/clk/imx/clk-pllv3.c     | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 25785ec9c276..f6b82e0b9703 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -115,7 +115,7 @@ config CLK_IMX93
>  
>  config CLK_IMXRT1050
>  	tristate "IMXRT1050 CCM Clock Driver"
> -	depends on SOC_IMXRT
> +	depends on SOC_IMXRT || COMPILE_TEST
>  	select MXC_CLK
>  	help
>  	    Build the driver for i.MXRT1050 CCM Clock Driver
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index e972abd299a8..fd5c51fc92c0 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -167,3 +167,7 @@ static struct platform_driver imxrt1050_clk_driver = {
>  	},
>  };
>  module_platform_driver(imxrt1050_clk_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Jesse Taube <Mr.Bossman075@gmail.com>");
> +MODULE_AUTHOR("Giulio Benetti <giulio.benetti@benettiengineering.com>");
> diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
> index 5d2a9a3be95e..5cf0149dfa15 100644
> --- a/drivers/clk/imx/clk-pfd.c
> +++ b/drivers/clk/imx/clk-pfd.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/clk-provider.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
> @@ -153,3 +154,4 @@ struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
>  
>  	return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_pfd);
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index eea32f87c60a..11fb238ee8f0 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -6,6 +6,7 @@
>  
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> +#include <linux/export.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/slab.h>
> @@ -486,3 +487,4 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>  
>  	return hw;
>  }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_pllv3);
> -- 
> 2.35.1
> 
