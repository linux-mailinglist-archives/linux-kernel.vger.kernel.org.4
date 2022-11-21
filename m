Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC709632DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKUUJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:09:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiKUUJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:09:41 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B0B8FF89
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:09:39 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5so9261407wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 12:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVe8YNjDYxPQKoteZ3Pvrxguc6rQkSdnDiVEuOuAYLo=;
        b=BhR4z2J7CCPUwWyoE8RdNAYppJ4ftMxcwAIfEN+8pd8przfqwIE3BEuG9TyvOJeoDX
         IXERTPmZ2xDSTeGXwVhaLGCSJfv46KiPFIM8ygf1bl5HoU29d64CL/GEdKe0kRZekxSU
         MSY8mvUaemjdnm4W+Dsu/hcVsVZwk9edZfjasbHPYaT5N8vW6QW9pi/yEIqPC73kx7zA
         sxNSt0q3ICjz5r0ZsbSZjVmTMYFJ5yHMywucdTK+tVHUxS3KB5K1emUw2hnq6w/ckA/S
         ucBbrTIjmRpMTTp2vhWCpGrefE4/M7rCYrtWyaq5lKsQ2lFEqvMNHdk5BfeMsKokuEuo
         dlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVe8YNjDYxPQKoteZ3Pvrxguc6rQkSdnDiVEuOuAYLo=;
        b=aAJtc8yUxrCUOV5GuqIpp6X3RnLcTq+9ReqeSetdOs31UY4Jv0F0S7na4zAGDkSAfO
         zYQoldRQ9d9/dj8F2D1Lt4Ec4lOUESXN8OJItwQJuBb9ssuYcYyaZ14mX2JEfToIdaMe
         0RmjlvmLNFI/ctO8L3fFLIjbqGF06aHZQyOWQHTA2L0miBuY2Gc5brWAn32Gz0FW6oed
         LfS1sGAeM9Id1J5P9tHqdCVnhgkpP7vI4Es37J2hSRL4imfQ94KQJhU1u6uLAWs1Ji8j
         UtmlIkM9UQcAmjyWkBS/YclfzwhqtXNTZCSiKNA848B/woizviLiU66bxukfB2lLRmo9
         zcUw==
X-Gm-Message-State: ANoB5pkW6uzJ9e+pqeZC0GyrF3HVmk5VnRjPWOirObkAH/OrVc2PYZ0q
        JTMZbQI3Ta4OxYXkOowCPHf2dA==
X-Google-Smtp-Source: AA0mqf5kAQTaQnhgBetcityDHmzzHK1ZReH9wrBjaATaWbBFnTZ8sWTU9lbxrB5s1rSDN7xUf4Z7Yw==
X-Received: by 2002:a05:600c:3c8a:b0:3cf:68f8:7901 with SMTP id bg10-20020a05600c3c8a00b003cf68f87901mr6107691wmb.69.1669061377476;
        Mon, 21 Nov 2022 12:09:37 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bc04a000000b003c6bd12ac27sm14371942wmc.37.2022.11.21.12.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 12:09:36 -0800 (PST)
Date:   Mon, 21 Nov 2022 22:09:34 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        michael@amarulasolutions.com, Abel Vesa <abelvesa@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/5] clk: imx8mn: rename vpu_pll to m7_alt_pll
Message-ID: <Y3va/llKXGjKDTP1@linaro.org>
References: <20221117113637.1978703-1-dario.binacchi@amarulasolutions.com>
 <20221117113637.1978703-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117113637.1978703-2-dario.binacchi@amarulasolutions.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17 12:36:33, Dario Binacchi wrote:
> The IMX8MN platform does not have any video processing unit (VPU), and
> indeed in the reference manual (document IMX8MNRM Rev 2, 07/2022) there
> is no occurrence of its pll. From an analysis of the code and the RM
> itself, I think vpu pll is used instead of m7 alternate pll, probably
> for copy and paste of code taken from modules of similar architectures.
> 
> As an example for all, if we consider the second row of the "Clock Root"
> table of chapter 5 (Clocks and Power Management) of the RM:
> 
>      Clock Root     offset     Source Select (CCM_TARGET_ROOTn[MUX])
>         ...          ...                    ...
>   ARM_M7_CLK_ROOT   0x8080            000 - 24M_REF_CLK
>                                       001 - SYSTEM_PLL2_DIV5
> 				      010 - SYSTEM_PLL2_DIV4
> 				      011 - M7_ALT_PLL_CLK
> 				      100 - SYSTEM_PLL1_CLK
> 				      101 - AUDIO_PLL1_CLK
> 				      110 - VIDEO_PLL_CLK
> 				      111 - SYSTEM_PLL3_CLK
>         ...          ...                    ...
> 
> but in the source code, the imx8mn_m7_sels clocks list contains vpu_pll
> for the source select bits 011b.
> 
> So, let's rename "vpu_pll" to "m7_alt_pll" to be consistent with the RM.
> 
> The IMX8MN_VPU_* constants have not been removed to ensure backward
> compatibility of the patch.
> 
> No functional changes intended.
> 
> Fixes: 96d6392b54dbb ("clk: imx: Add support for i.MX8MN clock driver")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> 

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
> 
> Changes in v2:
> - Update the commit message.
> - Add Fixes tag.
> - Maintain IMX8MN_VPU_* constants to not break backward compatibility.
> 
>  drivers/clk/imx/clk-imx8mn.c             | 16 ++++++++--------
>  include/dt-bindings/clock/imx8mn-clock.h | 12 ++++++++----
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index d37c45b676ab..72f9563a0ff6 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -30,7 +30,7 @@ static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_
>  static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
>  static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
>  static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
> -static const char * const vpu_pll_bypass_sels[] = {"vpu_pll", "vpu_pll_ref_sel", };
> +static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
>  static const char * const arm_pll_bypass_sels[] = {"arm_pll", "arm_pll_ref_sel", };
>  static const char * const sys_pll3_bypass_sels[] = {"sys_pll3", "sys_pll3_ref_sel", };
>  
> @@ -40,7 +40,7 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
>  
>  static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
>  
> -static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "vpu_pll_out",
> +static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
>  				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
>  
>  static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
> @@ -252,10 +252,10 @@ static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
> -						"vpu_pll_out", "sys_pll2_125m", "sys_pll3_out",
> +						"m7_alt_pll_out", "sys_pll2_125m", "sys_pll3_out",
>  						"sys_pll1_80m", "sys_pll2_166m", };
>  
> -static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "vpu_pll_out",
> +static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_alt_pll_out",
>  						 "sys_pll3_out", "sys_pll2_200m", "sys_pll1_266m",
>  						 "sys_pll2_500m", "sys_pll1_100m", };
>  
> @@ -352,7 +352,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> -	hws[IMX8MN_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  
> @@ -361,7 +361,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
>  	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
>  	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
> -	hws[IMX8MN_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", base + 0x74, &imx_1416x_pll);
> +	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
>  	hws[IMX8MN_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", base + 0x84, &imx_1416x_pll);
>  	hws[IMX8MN_SYS_PLL1] = imx_clk_hw_fixed("sys_pll1", 800000000);
>  	hws[IMX8MN_SYS_PLL2] = imx_clk_hw_fixed("sys_pll2", 1000000000);
> @@ -373,7 +373,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
> -	hws[IMX8MN_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
>  
> @@ -383,7 +383,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	hws[IMX8MN_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
>  	hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
>  	hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
> -	hws[IMX8MN_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", base + 0x74, 11);
> +	hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);
>  	hws[IMX8MN_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", base + 0x84, 11);
>  	hws[IMX8MN_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
>  
> diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
> index 07b8a282c268..694e3c050d04 100644
> --- a/include/dt-bindings/clock/imx8mn-clock.h
> +++ b/include/dt-bindings/clock/imx8mn-clock.h
> @@ -19,7 +19,8 @@
>  #define IMX8MN_VIDEO_PLL1_REF_SEL		10
>  #define IMX8MN_DRAM_PLL_REF_SEL			11
>  #define IMX8MN_GPU_PLL_REF_SEL			12
> -#define IMX8MN_VPU_PLL_REF_SEL			13
> +#define IMX8MN_M7_ALT_PLL_REF_SEL		13
> +#define IMX8MN_VPU_PLL_REF_SEL			IMX8MN_M7_ALT_PLL_REF_SEL
>  #define IMX8MN_ARM_PLL_REF_SEL			14
>  #define IMX8MN_SYS_PLL1_REF_SEL			15
>  #define IMX8MN_SYS_PLL2_REF_SEL			16
> @@ -29,7 +30,8 @@
>  #define IMX8MN_VIDEO_PLL1			20
>  #define IMX8MN_DRAM_PLL				21
>  #define IMX8MN_GPU_PLL				22
> -#define IMX8MN_VPU_PLL				23
> +#define IMX8MN_M7_ALT_PLL			23
> +#define IMX8MN_VPU_PLL				IMX8MN_M7_ALT_PLL
>  #define IMX8MN_ARM_PLL				24
>  #define IMX8MN_SYS_PLL1				25
>  #define IMX8MN_SYS_PLL2				26
> @@ -39,7 +41,8 @@
>  #define IMX8MN_VIDEO_PLL1_BYPASS		30
>  #define IMX8MN_DRAM_PLL_BYPASS			31
>  #define IMX8MN_GPU_PLL_BYPASS			32
> -#define IMX8MN_VPU_PLL_BYPASS			33
> +#define IMX8MN_M7_ALT_PLL_BYPASS		33
> +#define IMX8MN_VPU_PLL_BYPASS			IMX8MN_M7_ALT_PLL_BYPASS
>  #define IMX8MN_ARM_PLL_BYPASS			34
>  #define IMX8MN_SYS_PLL1_BYPASS			35
>  #define IMX8MN_SYS_PLL2_BYPASS			36
> @@ -49,7 +52,8 @@
>  #define IMX8MN_VIDEO_PLL1_OUT			40
>  #define IMX8MN_DRAM_PLL_OUT			41
>  #define IMX8MN_GPU_PLL_OUT			42
> -#define IMX8MN_VPU_PLL_OUT			43
> +#define IMX8MN_M7_ALT_PLL_OUT			43
> +#define IMX8MN_VPU_PLL_OUT			IMX8MN_M7_ALT_PLL_OUT
>  #define IMX8MN_ARM_PLL_OUT			44
>  #define IMX8MN_SYS_PLL1_OUT			45
>  #define IMX8MN_SYS_PLL2_OUT			46
> -- 
> 2.32.0
> 
