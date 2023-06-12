Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049E472BA95
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjFLI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjFLI20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:28:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBAD10C7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:27:33 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-97881a996a0so739615566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686558452; x=1689150452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5bIDTjXQH5L90i2XX/gTWlQ9d360txShID6EFAAOrY=;
        b=DUsTQM0th5Nt72TsPog0YPlk3jJf7qdzxGpDnRsqn00kTMcFqgmfL31vivrO+ze6H1
         cmbnAw7QNvB1j9nx5dYJL1hqw8FMk3pGTA+gljxF4xgzcnaPbq/I6SWfFociaO5Owt4P
         nPuQg+Mg0ZRVLnYdy94HiLehqk8ntN1mJ7UW1MWUddSc2WYLYX/N/7gQ4gclTuuXogXO
         zuQaXbeJsdnVB5MPS6ZPl/t9PngoYCtuT7hqsMM1uUqPDDblnT+8lqdtfUkMEczQQsa7
         y5ZWUs6MMQHtpziktzvIb6jFGEQfVS8hNenrZCZTjbOjNXepH1T/hsD7cM9U2MKiOtZt
         5mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686558452; x=1689150452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5bIDTjXQH5L90i2XX/gTWlQ9d360txShID6EFAAOrY=;
        b=SoemLZttQSajrUMQ2XvLmNMpcbyysfbmDJcgNu71gzBnYFQOyJf1ANiA0lmMiY9wTP
         40VJJoVUYgOLYXQE5vuwImQmrRm56fA3wASmaQXlf+JzqggDf0FokOM73cXv1ha+9YkE
         2LfzuwJGXS2NxAy9n/FTqG2I3n9qVo8kF6kg3Z5cq2Ki3Grk4M9ejg6BwPTLPswSY5Al
         JP/B3CT6DNOKXP5jVuax4EB7yKhiPbULiASmg9T7+NwgD6HGf0mLU0oqy1WzuL4FZQSE
         pY0weDCbA3JEoo7LosVcjhPlZszGYFr/27g8VaVk8mQWiFiK4O8LrSkCMjREWRq/8aCU
         FJNg==
X-Gm-Message-State: AC+VfDxEvECfWr6RL4hiopNjL1JKdbW6gwt01JG4MoExQmLnUPiIQEOg
        qs07cxESH/yhSsT9TKoxgEg6tw==
X-Google-Smtp-Source: ACHHUZ780bHh0/qlAhme+NUUhtBLlL2dWKyBMTEzWXXJYLswBXHMMVxwYZNy/VEf+HHZyoSdMvP2OA==
X-Received: by 2002:a17:906:7303:b0:974:61dc:107c with SMTP id di3-20020a170906730300b0097461dc107cmr9378908ejc.44.1686558452294;
        Mon, 12 Jun 2023 01:27:32 -0700 (PDT)
Received: from linaro.org ([86.121.163.20])
        by smtp.gmail.com with ESMTPSA id f27-20020a170906391b00b0097888b3b5a7sm4850523eje.31.2023.06.12.01.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 01:27:31 -0700 (PDT)
Date:   Mon, 12 Jun 2023 11:27:30 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Yuxing Liu <lyx2022@hust.edu.cn>
Cc:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: imx: clk-imx8mp: improve error handling in
 imx8mp_clocks_probe()
Message-ID: <ZIbW8uqb/8X8qY7h@linaro.org>
References: <20230503070607.2462-1-lyx2022@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503070607.2462-1-lyx2022@hust.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-03 07:06:07, Yuxing Liu wrote:
> Replace of_iomap() and kzalloc() with devm_of_iomap() and devm_kzalloc()
> which can automatically release the related memory when the device
> or driver is removed or unloaded to avoid potential memory leak.
> 
> In this case, iounmap(anatop_base) in line 427,433 are removed
> as manual release is not required.
> 
> Besides, referring to clk-imx8mq.c, check the return code of
> of_clk_add_hw_provider, if it returns negtive, print error info
> and unregister hws, which makes the program more robust.
> 
> Fixes: 9c140d992676 ("clk: imx: Add support for i.MX8MP clock driver")
> Signed-off-by: Yuxing Liu <lyx2022@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> This issue is found by static analysis and remains untested.
> ---
>  drivers/clk/imx/clk-imx8mp.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
> index 3253589851ff..de7d2d2176be 100644
> --- a/drivers/clk/imx/clk-imx8mp.c
> +++ b/drivers/clk/imx/clk-imx8mp.c
> @@ -414,25 +414,22 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np;
>  	void __iomem *anatop_base, *ccm_base;
> +	int err;
>  
>  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
> -	anatop_base = of_iomap(np, 0);
> +	anatop_base = devm_of_iomap(dev, np, 0, NULL);
>  	of_node_put(np);
> -	if (WARN_ON(!anatop_base))
> -		return -ENOMEM;
> +	if (WARN_ON(IS_ERR(anatop_base)))
> +		return PTR_ERR(anatop_base);
>  
>  	np = dev->of_node;
>  	ccm_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (WARN_ON(IS_ERR(ccm_base))) {
> -		iounmap(anatop_base);
> +	if (WARN_ON(IS_ERR(ccm_base)))
>  		return PTR_ERR(ccm_base);
> -	}
>  
> -	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> -	if (WARN_ON(!clk_hw_data)) {
> -		iounmap(anatop_base);
> +	clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
> +	if (WARN_ON(!clk_hw_data))
>  		return -ENOMEM;
> -	}
>  
>  	clk_hw_data->num = IMX8MP_CLK_END;
>  	hws = clk_hw_data->hws;
> @@ -721,7 +718,12 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
>  
>  	imx_check_clk_hws(hws, IMX8MP_CLK_END);
>  
> -	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	err = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> +	if (err < 0) {
> +		dev_err(dev, "failed to register hws for i.MX8MP\n");
> +		imx_unregister_hw_clocks(hws, IMX8MP_CLK_END);
> +		return err;
> +	}
>  
>  	imx_register_uart_clocks();
>  
> -- 
> 2.34.1
> 
