Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3747D6DC03F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjDIOJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDIOJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:09:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD710A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 07:09:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id sb12so6915585ejc.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 07:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681049349; x=1683641349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vymz421Sg3CZ9SMdXdxy0nArc7wypSQUlAaI4yhcxxY=;
        b=yBxsSSlM9HTycJ4VnU98sQcmzl5mWJqp20sEhQj83sQ0P16YwHR7YS4USpZgC7wh7i
         rc3ZzcAjgLmN3DVWIgPu4So7r28Je5oa1570TU5XwD5hcxk7GBOwZRAGUwmYjIkvLM/u
         VfVzE4dN1GL2kU3gGS9/1/yQYgjY9OyOHqu6RnPd6j+zZTXZ/Zf/OmHlb6mKDWRQEr73
         wsTGJmVRZ0mOEh6IwoxUA6eCkdofkoFuOvOddz4rQGXJNhjEednKDd2E5KqmmKW44rpt
         JZ5Ng2ttlw/5zxzWxcB7hYSzB47mhbm3q1FNMG11TwUqtxSII0AHRUCDOzx8YF8g5ASS
         c4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681049349; x=1683641349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vymz421Sg3CZ9SMdXdxy0nArc7wypSQUlAaI4yhcxxY=;
        b=zyXOi/Rx4kxpvLz6wBQmLP/SnjkDbVkKPfSEsDMFogEKcX8NjXh00n8GgKrqqnuqzv
         veecLfU0+ub+wNZptdhQ2Mg6YWDxQrSoXhTmZM3In8jJ48IM4NOp5oKH8YzIgCt0h9VY
         92yM7apm+Ytj4dZ82kcltkmKxqNQfDgweVqdbhwFsioqbqQ5M8hZJvUuev9AFZ6HZ6dV
         zYw0yKLfreLhuQQlXLZIRl6hMsNcHx04O1UWi82VD0mPSro5mkjdxtsSKSKJbBCM+oUH
         xSb6RiMoZND/+Jfdk5oKpq1Zj96+DGexH3E328RlVRQKT77ZkJiUxP4L+JzPzThGNSbG
         RmUA==
X-Gm-Message-State: AAQBX9fP7qDI6NkRYNRA1rfNrJGivXU5tWHk+Zkj9MpdRa0gKKljAc1a
        vt2Za21tou/OZmKRs3QE+M2MTA==
X-Google-Smtp-Source: AKy350Z0Rk/68CrgF9h81Dtol1kxAI5/tYdOd58Idyaysb3OoigfPRtlu9HAOy8sDZy0aM1mivkhvg==
X-Received: by 2002:a17:906:8595:b0:94a:7c88:263a with SMTP id v21-20020a170906859500b0094a7c88263amr877627ejx.9.1681049349654;
        Sun, 09 Apr 2023 07:09:09 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id n3-20020a17090695c300b0092f38a6d082sm4108842ejy.209.2023.04.09.07.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 07:09:09 -0700 (PDT)
Date:   Sun, 9 Apr 2023 17:09:07 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 5/5] clk: imx: imx8ulp: update clk flag for system
 critical clock
Message-ID: <ZDLHA3y7ahkNvgmS@linaro.org>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
 <20230331063814.2462059-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331063814.2462059-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-31 14:38:14, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> In order to support bus fabric clock frequency changed on the fly,
> need to update some bus clocks'flags to make sure these clocks'frequency
> and parent can be changed on the fly. For these clocks, HW can make sure
> no glitch will be introduced when changing on the fly.
> 
> In order to support DDR DFS, the HW register bit for DDR_SEL
> and DDR_DIV clock will be modified by TF-A. So need to update
> these two clock's flag to make sure that the linux kernel side
> can correct these clocks' SW state to reflect the actual HW state.
> 
> Reviewed-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx8ulp.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index 6a8a9e50d826..e308c88cb801 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -198,10 +198,10 @@ static int imx8ulp_clk_cgc1_init(struct platform_device *pdev)
>  
>  	clks[IMX8ULP_CLK_NIC_SEL] = imx_clk_hw_mux2("nic_sel", base + 0x34, 28, 2, nic_sels, ARRAY_SIZE(nic_sels));
>  	clks[IMX8ULP_CLK_NIC_AD_DIVPLAT] = imx_clk_hw_divider_flags("nic_ad_divplat", "nic_sel", base + 0x34, 21, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
> +	clks[IMX8ULP_CLK_NIC_PER_DIVPLAT] = imx_clk_hw_divider_flags("nic_per_divplat", "nic_ad_divplat", base + 0x34, 14, 6, CLK_SET_RATE_PARENT);
> +	clks[IMX8ULP_CLK_XBAR_AD_DIVPLAT] = imx_clk_hw_divider_flags("xbar_ad_divplat", "nic_ad_divplat", base + 0x38, 14, 6, CLK_SET_RATE_PARENT);
> +	clks[IMX8ULP_CLK_XBAR_DIVBUS] = imx_clk_hw_divider_flags("xbar_divbus", "xbar_ad_divplat", base + 0x38, 7, 6, CLK_SET_RATE_PARENT);
> +	clks[IMX8ULP_CLK_XBAR_AD_SLOW] = imx_clk_hw_divider_flags("xbar_ad_slow", "xbar_divbus", base + 0x38, 0, 6, CLK_SET_RATE_PARENT);
>  
>  	clks[IMX8ULP_CLK_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("sosc_div1_gate", "sosc", base + 0x108, 7);
>  	clks[IMX8ULP_CLK_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("sosc_div2_gate", "sosc", base + 0x108, 15);
> @@ -255,9 +255,9 @@ static int imx8ulp_clk_cgc2_init(struct platform_device *pdev)
>  	clks[IMX8ULP_CLK_HIFI_DIVCORE] = imx_clk_hw_divider("hifi_core_div", "hifi_sel", base + 0x14, 21, 6);
>  	clks[IMX8ULP_CLK_HIFI_DIVPLAT] = imx_clk_hw_divider("hifi_plat_div", "hifi_core_div", base + 0x14, 14, 6);
>  
> -	clks[IMX8ULP_CLK_DDR_SEL] = imx_clk_hw_mux_flags("ddr_sel", base + 0x40, 28, 3, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_PARENT_GATE);
> -	clks[IMX8ULP_CLK_DDR_DIV] = imx_clk_hw_divider_flags("ddr_div", "ddr_sel", base + 0x40, 21, 6, CLK_IS_CRITICAL);
> -	clks[IMX8ULP_CLK_LPAV_AXI_SEL] = imx_clk_hw_mux("lpav_sel", base + 0x3c, 28, 2, lpav_sels, ARRAY_SIZE(lpav_sels));
> +	clks[IMX8ULP_CLK_DDR_SEL] = imx_clk_hw_mux_flags("ddr_sel", base + 0x40, 28, 3, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_GET_RATE_NOCACHE);
> +	clks[IMX8ULP_CLK_DDR_DIV] = imx_clk_hw_divider_flags("ddr_div", "ddr_sel", base + 0x40, 21, 6, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
> +	clks[IMX8ULP_CLK_LPAV_AXI_SEL] = imx_clk_hw_mux2("lpav_sel", base + 0x3c, 28, 2, lpav_sels, ARRAY_SIZE(lpav_sels));
>  	clks[IMX8ULP_CLK_LPAV_AXI_DIV] = imx_clk_hw_divider_flags("lpav_axi_div", "lpav_sel", base + 0x3c, 21, 6, CLK_IS_CRITICAL);
>  	clks[IMX8ULP_CLK_LPAV_AHB_DIV] = imx_clk_hw_divider_flags("lpav_ahb_div", "lpav_axi_div", base + 0x3c, 14, 6, CLK_IS_CRITICAL);
>  	clks[IMX8ULP_CLK_LPAV_BUS_DIV] = imx_clk_hw_divider_flags("lpav_bus_div", "lpav_axi_div", base + 0x3c, 7, 6, CLK_IS_CRITICAL);
> -- 
> 2.37.1
> 
