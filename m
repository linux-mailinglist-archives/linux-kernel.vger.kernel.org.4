Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60646DC043
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDIOJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDIOJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:09:49 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FEC3C3B
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 07:09:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id g18so18481167ejj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681049384; x=1683641384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4P0D+ScmQTPhvDnEDUsDphPhJjBRKDj6P8P9ohmPrI0=;
        b=AD9rYZ/KadMf6kAAub38x25eqLTe5RwUrsrys1QDk4QYZ7QxdSspUENnKOEmmeefVO
         llBuXunPAiHV3mnb30gmn+GcnQN7+0n6QpOPAnIWelG6kRPJ/b1yVPFBFUbdlgsqTw5E
         k3AnCz4WPo4boeo+MoePQXsRu/meqcGR/4jW1Nkw/znNgfzG1Bwb8/fYC4696RSmCJo7
         kEIvJ1jOHBU1v+9LCDMy0Fw7mxm+C2jcpAXV4hMU8J5OpXzp+BiG32cPxrgw4+iRQYmZ
         XiAg6jh02Wzk1tD0i6DpFjVCT5v/hJ/twDmivWipd53wj2GFgXa1EVFaQyu303o9hJv7
         5WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681049384; x=1683641384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P0D+ScmQTPhvDnEDUsDphPhJjBRKDj6P8P9ohmPrI0=;
        b=DhCzXfDiTFLbco0/PmcxeqkQyeMIzIYj0E83KE7wDPoUZBFVVLIkpXRBHnJL4tMpvO
         g6SSibfQbZl0HTuRdi+fZVqqyToccBANraySWblr+2yQE8v4o7cQB1G8n83O/mLRDugR
         vKk0CAxoaLnnQ302U2L9hKRocAqM8pv6bR+S65DuYuR5cjG0sHx9X2a/egvRnsoSSP0m
         TGsqD22UHASImGPZlr5aYXyVt6j9+md/IoMYyx7ksjJnseZYtZGR7UR2iCkgxFVDKPM3
         GHhjteJwdJs8EkeYhq4YE52e4kjdV63VNvNs64b80AtJFNzyHwSYmchHdNRvtYd02GRu
         EhQw==
X-Gm-Message-State: AAQBX9cEdTUaxmKGXaWhc/gQ7XTJYsI5KeFeyl9trmgOIFk5VQ0iviK2
        otPzwazCdYN7QvBpG0MMtGM9MQ==
X-Google-Smtp-Source: AKy350aaizqAMP1B8a+hkDvgDqZaifKY+dXQs8AVYmo/kdTvIYuUfSOzHLYFxX5t0Ru57sefPMNYzg==
X-Received: by 2002:a17:906:da87:b0:932:3ca:e228 with SMTP id xh7-20020a170906da8700b0093203cae228mr6593363ejb.0.1681049384229;
        Sun, 09 Apr 2023 07:09:44 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id dx5-20020a170906a84500b0094a6cf3b642sm640241ejb.142.2023.04.09.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 07:09:43 -0700 (PDT)
Date:   Sun, 9 Apr 2023 17:09:42 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/5] clk: imx: imx8ulp: Add divider closest support to
 get more accurate clock rate
Message-ID: <ZDLHJp1M1lrYikhX@linaro.org>
References: <20230331063814.2462059-1-peng.fan@oss.nxp.com>
 <20230331063814.2462059-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331063814.2462059-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-31 14:38:11, Peng Fan (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> If a divider's parent clock has fractional part, it will hard to round out a
> more accurate clock rate for this divider, add the 'CLK_DIVIDER_ROUND_CLOSEST' flags
> for such divider to get a more accurate clock rate.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx8ulp.c | 16 ++++++++--------
>  drivers/clk/imx/clk.h         |  9 +++++++++
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
> index 89121037a8f0..3cf4b094dfff 100644
> --- a/drivers/clk/imx/clk-imx8ulp.c
> +++ b/drivers/clk/imx/clk-imx8ulp.c
> @@ -275,14 +275,14 @@ static int imx8ulp_clk_cgc2_init(struct platform_device *pdev)
>  	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2_GATE] = imx_clk_hw_gate_dis("pll4_pfd2_div2_gate", "pll4_pfd2", base + 0x60c, 15);
>  	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1_GATE] = imx_clk_hw_gate_dis("pll4_pfd3_div1_gate", "pll4_pfd3", base + 0x60c, 23);
>  	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2_GATE] = imx_clk_hw_gate_dis("pll4_pfd3_div2_gate", "pll4_pfd3", base + 0x60c, 31);
> -	clks[IMX8ULP_CLK_PLL4_PFD0_DIV1] = imx_clk_hw_divider("pll4_pfd0_div1", "pll4_pfd0_div1_gate", base + 0x608, 0, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD0_DIV2] = imx_clk_hw_divider("pll4_pfd0_div2", "pll4_pfd0_div2_gate", base + 0x608, 8, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD1_DIV1] = imx_clk_hw_divider("pll4_pfd1_div1", "pll4_pfd1_div1_gate", base + 0x608, 16, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD1_DIV2] = imx_clk_hw_divider("pll4_pfd1_div2", "pll4_pfd1_div2_gate", base + 0x608, 24, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD2_DIV1] = imx_clk_hw_divider("pll4_pfd2_div1", "pll4_pfd2_div1_gate", base + 0x60c, 0, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2] = imx_clk_hw_divider("pll4_pfd2_div2", "pll4_pfd2_div2_gate", base + 0x60c, 8, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1] = imx_clk_hw_divider("pll4_pfd3_div1", "pll4_pfd3_div1_gate", base + 0x60c, 16, 6);
> -	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2] = imx_clk_hw_divider("pll4_pfd3_div2", "pll4_pfd3_div2_gate", base + 0x60c, 24, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD0_DIV1] = imx_clk_hw_divider_closest("pll4_pfd0_div1", "pll4_pfd0_div1_gate", base + 0x608, 0, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD0_DIV2] = imx_clk_hw_divider_closest("pll4_pfd0_div2", "pll4_pfd0_div2_gate", base + 0x608, 8, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD1_DIV1] = imx_clk_hw_divider_closest("pll4_pfd1_div1", "pll4_pfd1_div1_gate", base + 0x608, 16, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD1_DIV2] = imx_clk_hw_divider_closest("pll4_pfd1_div2", "pll4_pfd1_div2_gate", base + 0x608, 24, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD2_DIV1] = imx_clk_hw_divider_closest("pll4_pfd2_div1", "pll4_pfd2_div1_gate", base + 0x60c, 0, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD2_DIV2] = imx_clk_hw_divider_closest("pll4_pfd2_div2", "pll4_pfd2_div2_gate", base + 0x60c, 8, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD3_DIV1] = imx_clk_hw_divider_closest("pll4_pfd3_div1", "pll4_pfd3_div1_gate", base + 0x60c, 16, 6);
> +	clks[IMX8ULP_CLK_PLL4_PFD3_DIV2] = imx_clk_hw_divider_closest("pll4_pfd3_div2", "pll4_pfd3_div2_gate", base + 0x60c, 24, 6);
>  
>  	clks[IMX8ULP_CLK_CGC2_SOSC_DIV1_GATE] = imx_clk_hw_gate_dis("cgc2_sosc_div1_gate", "sosc", base + 0x108, 7);
>  	clks[IMX8ULP_CLK_CGC2_SOSC_DIV2_GATE] = imx_clk_hw_gate_dis("cgc2_sosc_div2_gate", "sosc", base + 0x108, 15);
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index bb105d6e5b39..ca1f75eb3197 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -356,6 +356,15 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
>  			CLK_SET_RATE_PARENT, mult, div);
>  }
>  
> +static inline struct clk_hw *imx_clk_hw_divider_closest(const char *name,
> +						const char *parent,
> +						void __iomem *reg, u8 shift,
> +						u8 width)
> +{
> +	return clk_hw_register_divider(NULL, name, parent, 0,
> +				       reg, shift, width, CLK_DIVIDER_ROUND_CLOSEST, &imx_ccm_lock);
> +}
> +
>  static inline struct clk_hw *__imx_clk_hw_divider(const char *name,
>  						   const char *parent,
>  						   void __iomem *reg, u8 shift,
> -- 
> 2.37.1
> 
