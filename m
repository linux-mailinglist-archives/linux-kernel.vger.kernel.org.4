Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DDE6DC02C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDINra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjDINr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:47:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E7E3A9A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 06:47:25 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dm2so7112230ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681048044; x=1683640044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oa3PJqPPKBP8BY5DePnA/gKmWHg/CElU4LGBVX+VPN8=;
        b=kkf9fck4q9pQ2/Mm/SJed8Gfe2iTblbHiQJUshw5TZ8ZMw9ShLk+Qh7VNoXmNQXGkw
         1RlpQkEmtZ6jadTDtBpeRrpx8rF6uVZP6Lk9XHpUrYIc3NdQNffp7H/hIufbBCiAyT0M
         elqNYhxwRCo967NnBjxF4zGwTUHcAXKn82t/pKjfUJBhXYBRsKuRehcR6Wbq0SubOkE0
         6VgghHJdSB0sdMBP+FpvGZOUbOVBlrAcqe6xCy5bGa/+VjcqKudlNq1/9hBx+tPGGx1U
         xzrSDmlwLoqhtILaSWQ+u95ar29Mw0F/112RxMUWCxVi9EBQjsSHUa131ewKCsmQyJ6M
         Ayww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681048044; x=1683640044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa3PJqPPKBP8BY5DePnA/gKmWHg/CElU4LGBVX+VPN8=;
        b=0b3ZCvrxxeuFjCKu1tbDPevmyCrsKklKz5+u/lsfP/yf53XzPlw50Wjk1khUhLHVJ1
         Pt5D37Xbmq4E2oCb5HnWO+JzGpjzdFGuZ+bZ6bKzGGAdJsYjy9fp92p84l8leJYFtXtc
         bJ86bus9Epj28AFJNF0bmoxXzwGQ10nsHd0XB7nRLX2ySrZaBww7SdWJHVTZ67iqdsry
         0CkriFgM3qUTuVziJBBy36yGxuKg6gTfWpsbo3sRbAKNtRoT/AXrXVdh0l5yDDU9N4m8
         4+5O2cxZlfkQd0FucenFt3seSi+1AY5LWoGY/M12V4oQQMoqfWBBMQrusGy7pKQROD+M
         V18Q==
X-Gm-Message-State: AAQBX9ehU074ruRxQRV3Wtk6HfNB9BKipqPXjoNayqQ+2SW7+WaoP8Yj
        SHOfYEFGCwVAR64VO/03cJAG5g==
X-Google-Smtp-Source: AKy350aDDPX07T0WkpQm3LDFo7w2z65NpcC0lx6Dl9reqii4FCxvmmjjf/dR0ecppU5U2aT98Fzm0w==
X-Received: by 2002:a17:907:d08e:b0:94a:4ce3:803d with SMTP id vc14-20020a170907d08e00b0094a4ce3803dmr3342828ejc.15.1681048044518;
        Sun, 09 Apr 2023 06:47:24 -0700 (PDT)
Received: from linaro.org ([188.25.26.161])
        by smtp.gmail.com with ESMTPSA id lc22-20020a170906dff600b00933c52c2a0esm4168101ejc.173.2023.04.09.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 06:47:24 -0700 (PDT)
Date:   Sun, 9 Apr 2023 16:47:22 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 7/7] clk: imx: imx93: Add nic and A55 clk
Message-ID: <ZDLB6n3Gyi/2zNxI@linaro.org>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
 <20230403095300.3386988-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403095300.3386988-8-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-03 17:53:00, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The A55 clock logic as below:
>      A55_PLL ----------------->\
>                                 A55_SEL-->A55_CORE
>      A55_CCM_ROOT--->A55_GATE->/
> 
> Add A55 CPU clk to support freq change.
> Add NIC CLK to reflect the clk status
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/clk/imx/clk-imx93.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
> index de1ed1d8ba54..07b4a043e449 100644
> --- a/drivers/clk/imx/clk-imx93.c
> +++ b/drivers/clk/imx/clk-imx93.c
> @@ -33,6 +33,7 @@ static u32 share_count_sai2;
>  static u32 share_count_sai3;
>  static u32 share_count_mub;
>  
> +static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
>  static const char *parent_names[MAX_SEL][4] = {
>  	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
>  	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
> @@ -55,7 +56,7 @@ static const struct imx93_clk_root {
>  	/* a55/m33/bus critical clk for system run */
>  	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_A55_MTR_BUS,	"a55_mtr_bus_root",	0x0080,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> -	{ IMX93_CLK_A55,		"a55_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
> +	{ IMX93_CLK_A55,		"a55_alt_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_M33,		"m33_root",		0x0180,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_BUS_WAKEUP,		"bus_wakeup_root",	0x0280,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
> @@ -117,6 +118,7 @@ static const struct imx93_clk_root {
>  	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
> +	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
>  	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
>  	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
>  	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
> @@ -153,7 +155,7 @@ static const struct imx93_clk_ccgr {
>  	unsigned long flags;
>  	u32 *shared_count;
>  } ccgr_array[] = {
> -	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
> +	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
>  	/* M33 critical clk for system run */
>  	{ IMX93_CLK_CM33_GATE,		"cm33",		"m33_root",		0x8040, CLK_IS_CRITICAL },
>  	{ IMX93_CLK_ADC1_GATE,		"adc1",		"adc_root",		0x82c0, },
> @@ -291,6 +293,9 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  	if (WARN_ON(!anatop_base))
>  		return -ENOMEM;
>  
> +	clks[IMX93_CLK_ARM_PLL] = imx_clk_fracn_gppll_integer("arm_pll", "osc_24m",
> +							      anatop_base + 0x1000,
> +							      &imx_fracn_gppll_integer);
>  	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", anatop_base + 0x1200,
>  							&imx_fracn_gppll);
>  	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", anatop_base + 0x1400,
> @@ -318,6 +323,14 @@ static int imx93_clocks_probe(struct platform_device *pdev)
>  						 ccgr->shared_count);
>  	}
>  
> +	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
> +						  ARRAY_SIZE(a55_core_sels));
> +	clks[IMX93_CLK_A55_CORE] = imx_clk_hw_cpu("a55_core", "a55_sel",
> +						  clks[IMX93_CLK_A55_SEL]->clk,
> +						  clks[IMX93_CLK_A55_SEL]->clk,
> +						  clks[IMX93_CLK_ARM_PLL]->clk,
> +						  clks[IMX93_CLK_A55_GATE]->clk);
> +
>  	imx_check_clk_hws(clks, IMX93_CLK_END);
>  
>  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
> -- 
> 2.37.1
> 
