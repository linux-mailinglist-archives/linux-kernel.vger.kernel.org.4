Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0264E23C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 21:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiLOUPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 15:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiLOUPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 15:15:32 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C042FBDF;
        Thu, 15 Dec 2022 12:15:32 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3e45d25de97so5288837b3.6;
        Thu, 15 Dec 2022 12:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iK4o9jLvL400oAI7gEBPMmyw5mH/OfCQsL+GJz6EUHE=;
        b=FYpzgSu9zxFCEB9DpsLOEbzthnkgW6+UtEfzlgYsMp+oEloOnYVB6FsMTKHc8ef7Ol
         zvgSd0UaFf+unzNSBr8vkWFSnPGwxktncmDM0+ftf3XHHXdd9RyUEUiylE5Rs67rpd0o
         xc0OTHWKVJ0cXXCP9bJJ5uBVEt/5uniVJtRnTw1MqpUj8Dd9eOgkL5qkQ9zq5BxVXGmj
         ZqpO9fFkNYxbJqSUSNm7xBnEtPqaE0ktyBkbKXceEOCdOeDagmEVLgqHP+E8yDer/tdQ
         UGocSBQ8f7Xn0aWerfyeTmQkjqf06ZBbe7hHoQB+iDt7r333slCqxyV2qG4W5Kx+XZ9E
         eysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iK4o9jLvL400oAI7gEBPMmyw5mH/OfCQsL+GJz6EUHE=;
        b=ah+M4L4gI+k5PsbrftzHiunsiFklkAGT2CiX2JeYXiH1SgwJxSO9DUjlGasNPRPhZR
         zRYszDAJltfiLH9HtphakuAOaFXUx9ojLJ1GsjL9I15SvbyCOoOdPycTuhj98JvzyQ/T
         aUeVjC4nOkURA/HqM44VpNaHjfdbtLnIMn1crhNJNjbfTJM1h16+njBm4Lr1tgwl60ze
         o7G6U5GoXJqcOvxCFV3+jPTirGBs2rGhA1SdDVXTL9nL1JumYcT8V320MLH9YCDO3r1V
         G+OdushmJU/eeN81i/a5o/gmd8GqN0v/EVKWiHY3CGb8DUTZmbmDjgPF9mgxTkQMJ0ro
         yP1A==
X-Gm-Message-State: ANoB5plIQFF2JdWbyAmSjFhE+iTCdtYLUoNUiqdJ+ICC3T1qyDhY+0Og
        1ceRa1qxi7L4GxuPaiA7AOY=
X-Google-Smtp-Source: AA0mqf5kqRcoR1s9S1eHc44XGjbfjpzsT1/6GNL5vrgogObGEBdPweTHjesvj8jJUu38rHm17qyBbw==
X-Received: by 2002:a81:9c7:0:b0:36b:eafd:ca50 with SMTP id 190-20020a8109c7000000b0036beafdca50mr34291075ywj.52.1671135331232;
        Thu, 15 Dec 2022 12:15:31 -0800 (PST)
Received: from [10.4.10.38] (pool-108-26-182-112.bstnma.fios.verizon.net. [108.26.182.112])
        by smtp.gmail.com with ESMTPSA id c15-20020ae9ed0f000000b006e702033b15sm12450949qkg.66.2022.12.15.12.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 12:15:30 -0800 (PST)
Message-ID: <f7f57361-8a4b-00e4-57fe-0ed103ddb10e@gmail.com>
Date:   Thu, 15 Dec 2022 15:15:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] clk: imx: fix compile testing imxrt1050
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221215165836.2136448-1-arnd@kernel.org>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20221215165836.2136448-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/22 11:58, Arnd Bergmann wrote:
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
> ---
>   drivers/clk/imx/Kconfig         | 2 +-
>   drivers/clk/imx/clk-imxrt1050.c | 4 ++++
>   drivers/clk/imx/clk-pfd.c       | 2 ++
>   drivers/clk/imx/clk-pllv3.c     | 2 ++
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> index 25785ec9c276..f6b82e0b9703 100644
> --- a/drivers/clk/imx/Kconfig
> +++ b/drivers/clk/imx/Kconfig
> @@ -115,7 +115,7 @@ config CLK_IMX93
>   
>   config CLK_IMXRT1050
>   	tristate "IMXRT1050 CCM Clock Driver"
> -	depends on SOC_IMXRT
> +	depends on SOC_IMXRT || COMPILE_TEST
Not sure what COMPILE_TEST is but,
Acked-by: Jesse Taube <Mr.Bossman075@gmail.com>

Sorry about the issues introduced.

Thanks,
Jesse Taube
>   	select MXC_CLK
>   	help
>   	    Build the driver for i.MXRT1050 CCM Clock Driver
> diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
> index e972abd299a8..fd5c51fc92c0 100644
> --- a/drivers/clk/imx/clk-imxrt1050.c
> +++ b/drivers/clk/imx/clk-imxrt1050.c
> @@ -167,3 +167,7 @@ static struct platform_driver imxrt1050_clk_driver = {
>   	},
>   };
>   module_platform_driver(imxrt1050_clk_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_AUTHOR("Jesse Taube <Mr.Bossman075@gmail.com>");
> +MODULE_AUTHOR("Giulio Benetti <giulio.benetti@benettiengineering.com>");
> diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
> index 5d2a9a3be95e..5cf0149dfa15 100644
> --- a/drivers/clk/imx/clk-pfd.c
> +++ b/drivers/clk/imx/clk-pfd.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #include <linux/clk-provider.h>
> +#include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/slab.h>
>   #include <linux/err.h>
> @@ -153,3 +154,4 @@ struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
>   
>   	return hw;
>   }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_pfd);
> diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
> index eea32f87c60a..11fb238ee8f0 100644
> --- a/drivers/clk/imx/clk-pllv3.c
> +++ b/drivers/clk/imx/clk-pllv3.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/clk-provider.h>
>   #include <linux/delay.h>
> +#include <linux/export.h>
>   #include <linux/io.h>
>   #include <linux/iopoll.h>
>   #include <linux/slab.h>
> @@ -486,3 +487,4 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
>   
>   	return hw;
>   }
> +EXPORT_SYMBOL_GPL(imx_clk_hw_pllv3);
