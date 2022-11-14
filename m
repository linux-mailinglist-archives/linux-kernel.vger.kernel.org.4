Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9F66277D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiKNIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbiKNIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:36:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603661BEAB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:36:19 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ouUwz-000560-La; Mon, 14 Nov 2022 09:36:17 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ouUwy-0004eB-PZ; Mon, 14 Nov 2022 09:36:16 +0100
Date:   Mon, 14 Nov 2022 09:36:16 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, michael@amarulasolutions.com,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Abel Vesa <abelvesa@kernel.org>
Subject: Re: [PATCH 3/5] clk: imx: rename video_pll1 to video_pll
Message-ID: <20221114083616.zigo7vrbrlurvzzi@pengutronix.de>
References: <20221113180710.1625410-1-dario.binacchi@amarulasolutions.com>
 <20221113180710.1625410-4-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221113180710.1625410-4-dario.binacchi@amarulasolutions.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

On 22-11-13, Dario Binacchi wrote:
> Unlike audio_pll1 and audio_pll2, there is no video_pll2. Further, the
> name used in the RM is video_pll. So, let's rename "video_pll1" to
> "video_pll" to be consistent with the RM and avoid misunderstandings.
> 
> No functional changes intended.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  drivers/clk/imx/clk-imx8mn.c             | 96 ++++++++++++------------
>  include/dt-bindings/clock/imx8mn-clock.h |  8 +-
>  2 files changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
> index 0fae97e61e2c..b80af5d1ef46 100644
> --- a/drivers/clk/imx/clk-imx8mn.c
> +++ b/drivers/clk/imx/clk-imx8mn.c
> @@ -27,7 +27,7 @@ static u32 share_count_nand;
>  static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
>  static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
>  static const char * const audio_pll2_bypass_sels[] = {"audio_pll2", "audio_pll2_ref_sel", };
> -static const char * const video_pll1_bypass_sels[] = {"video_pll1", "video_pll1_ref_sel", };
> +static const char * const video_pll_bypass_sels[] = {"video_pll", "video_pll_ref_sel", };
>  static const char * const dram_pll_bypass_sels[] = {"dram_pll", "dram_pll_ref_sel", };
>  static const char * const gpu_pll_bypass_sels[] = {"gpu_pll", "gpu_pll_ref_sel", };
>  static const char * const m7_alt_pll_bypass_sels[] = {"m7_alt_pll", "m7_alt_pll_ref_sel", };
> @@ -41,23 +41,23 @@ static const char * const imx8mn_a53_sels[] = {"osc_24m", "arm_pll_out", "sys_pl
>  static const char * const imx8mn_a53_core_sels[] = {"arm_a53_div", "arm_pll_out", };
>  
>  static const char * const imx8mn_m7_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll2_250m", "m7_alt_pll_out",
> -				       "sys_pll1_800m", "audio_pll1_out", "video_pll1_out", "sys_pll3_out", };
> +				       "sys_pll1_800m", "audio_pll1_out", "video_pll_out", "sys_pll3_out", };
>  
>  static const char * const imx8mn_gpu_core_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
>  						    "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
> -						    "video_pll1_out", "audio_pll2_out", };
> +						    "video_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mn_gpu_shader_sels[] = {"osc_24m", "gpu_pll_out", "sys_pll1_800m",
>  						      "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
> -						      "video_pll1_out", "audio_pll2_out", };
> +						      "video_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mn_main_axi_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll1_800m",
>  						    "sys_pll2_250m", "sys_pll2_1000m", "audio_pll1_out",
> -						    "video_pll1_out", "sys_pll1_100m",};
> +						    "video_pll_out", "sys_pll1_100m",};
>  
>  static const char * const imx8mn_enet_axi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
>  						    "sys_pll2_250m", "sys_pll2_200m", "audio_pll1_out",
> -						    "video_pll1_out", "sys_pll3_out", };
> +						    "video_pll_out", "sys_pll3_out", };
>  
>  static const char * const imx8mn_nand_usdhc_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll1_800m",
>  						      "sys_pll2_200m", "sys_pll1_133m", "sys_pll3_out",
> @@ -77,23 +77,23 @@ static const char * const imx8mn_usb_bus_sels[] = {"osc_24m", "sys_pll2_500m", "
>  
>  static const char * const imx8mn_gpu_axi_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
>  						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
> -						   "video_pll1_out", "audio_pll2_out", };
> +						   "video_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mn_gpu_ahb_sels[] = {"osc_24m", "sys_pll1_800m", "gpu_pll_out",
>  						   "sys_pll3_out", "sys_pll2_1000m", "audio_pll1_out",
> -						   "video_pll1_out", "audio_pll2_out", };
> +						   "video_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mn_noc_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll3_out",
>  					       "sys_pll2_1000m", "sys_pll2_500m", "audio_pll1_out",
> -					       "video_pll1_out", "audio_pll2_out", };
> +					       "video_pll_out", "audio_pll2_out", };
>  
>  static const char * const imx8mn_ahb_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_800m",
>  					       "sys_pll1_400m", "sys_pll2_125m", "sys_pll3_out",
> -					       "audio_pll1_out", "video_pll1_out", };
> +					       "audio_pll1_out", "video_pll_out", };
>  
>  static const char * const imx8mn_audio_ahb_sels[] = {"osc_24m", "sys_pll2_500m", "sys_pll1_800m",
>  						     "sys_pll2_1000m", "sys_pll2_166m", "sys_pll3_out",
> -						     "audio_pll1_out", "video_pll1_out", };
> +						     "audio_pll1_out", "video_pll_out", };
>  
>  static const char * const imx8mn_dram_alt_sels[] = {"osc_24m", "sys_pll1_800m", "sys_pll1_100m",
>  						    "sys_pll2_500m", "sys_pll2_1000m", "sys_pll3_out",
> @@ -103,49 +103,49 @@ static const char * const imx8mn_dram_apb_sels[] = {"osc_24m", "sys_pll2_200m",
>  						    "sys_pll1_160m", "sys_pll1_800m", "sys_pll3_out",
>  						    "sys_pll2_250m", "audio_pll2_out", };
>  
> -static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out",
> +static const char * const imx8mn_disp_pixel_sels[] = {"osc_24m", "video_pll_out", "audio_pll2_out",
>  						      "audio_pll1_out", "sys_pll1_800m", "sys_pll2_1000m",
>  						      "sys_pll3_out", "clk_ext4", };
>  
>  static const char * const imx8mn_sai2_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "dummy",
> +						"video_pll_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai3_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "dummy",
> +						"video_pll_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai5_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "dummy",
> +						"video_pll_out", "sys_pll1_133m", "dummy",
>  						"clk_ext2", "clk_ext3", };
>  
>  static const char * const imx8mn_sai6_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "dummy",
> +						"video_pll_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_sai7_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						"video_pll1_out", "sys_pll1_133m", "dummy",
> +						"video_pll_out", "sys_pll1_133m", "dummy",
>  						"clk_ext3", "clk_ext4", };
>  
>  static const char * const imx8mn_spdif1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out",
> -						  "video_pll1_out", "sys_pll1_133m", "dummy",
> +						  "video_pll_out", "sys_pll1_133m", "dummy",
>  						  "clk_ext2", "clk_ext3", };
>  
>  static const char * const imx8mn_enet_ref_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_50m",
>  						    "sys_pll2_100m", "sys_pll1_160m", "audio_pll1_out",
> -						    "video_pll1_out", "clk_ext4", };
> +						    "video_pll_out", "clk_ext4", };
>  
>  static const char * const imx8mn_enet_timer_sels[] = {"osc_24m", "sys_pll2_100m", "audio_pll1_out",
>  						      "clk_ext1", "clk_ext2", "clk_ext3",
> -						      "clk_ext4", "video_pll1_out", };
> +						      "clk_ext4", "video_pll_out", };
>  
>  static const char * const imx8mn_enet_phy_sels[] = {"osc_24m", "sys_pll2_50m", "sys_pll2_125m",
> -						    "sys_pll2_200m", "sys_pll2_500m", "video_pll1_out",
> +						    "sys_pll2_200m", "sys_pll2_500m", "video_pll_out",
>  						    "audio_pll2_out", };
>  
>  static const char * const imx8mn_nand_sels[] = {"osc_24m", "sys_pll2_500m", "audio_pll1_out",
>  						"sys_pll1_400m", "audio_pll2_out", "sys_pll3_out",
> -						"sys_pll2_250m", "video_pll1_out", };
> +						"sys_pll2_250m", "video_pll_out", };
>  
>  static const char * const imx8mn_qspi_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll2_333m",
>  						"sys_pll2_500m", "audio_pll2_out", "sys_pll1_266m",
> @@ -160,19 +160,19 @@ static const char * const imx8mn_usdhc2_sels[] = {"osc_24m", "sys_pll1_400m", "s
>  						  "audio_pll2_out", "sys_pll1_100m", };
>  
>  static const char * const imx8mn_i2c1_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
> -						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
> +						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
>  						"audio_pll2_out", "sys_pll1_133m", };
>  
>  static const char * const imx8mn_i2c2_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
> -						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
> +						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
>  						"audio_pll2_out", "sys_pll1_133m", };
>  
>  static const char * const imx8mn_i2c3_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
> -						"sys_pll3_out", "audio_pll1_out", "video_pll1_out",
> +						"sys_pll3_out", "audio_pll1_out", "video_pll_out",
>  						"audio_pll2_out", "sys_pll1_133m", };
>  
>  static const char * const imx8mn_i2c4_sels[] = {"osc_24m", "sys_pll1_160m", "sys_pll2_50m",
> -						"sys_pll3_out",	"audio_pll1_out", "video_pll1_out",
> +						"sys_pll3_out",	"audio_pll1_out", "video_pll_out",
>  						"audio_pll2_out", "sys_pll1_133m", };
>  
>  static const char * const imx8mn_uart1_sels[] = {"osc_24m", "sys_pll1_80m", "sys_pll2_200m",
> @@ -213,42 +213,42 @@ static const char * const imx8mn_ecspi2_sels[] = {"osc_24m", "sys_pll2_200m", "s
>  
>  static const char * const imx8mn_pwm1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
>  						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
> -						"sys_pll1_80m", "video_pll1_out", };
> +						"sys_pll1_80m", "video_pll_out", };
>  
>  static const char * const imx8mn_pwm2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
>  						"sys_pll1_40m", "sys_pll3_out", "clk_ext1",
> -						"sys_pll1_80m", "video_pll1_out", };
> +						"sys_pll1_80m", "video_pll_out", };
>  
>  static const char * const imx8mn_pwm3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
>  						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
> -						"sys_pll1_80m", "video_pll1_out", };
> +						"sys_pll1_80m", "video_pll_out", };
>  
>  static const char * const imx8mn_pwm4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_160m",
>  						"sys_pll1_40m", "sys_pll3_out", "clk_ext2",
> -						"sys_pll1_80m", "video_pll1_out", };
> +						"sys_pll1_80m", "video_pll_out", };
>  
>  static const char * const imx8mn_gpt1_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_gpt2_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_gpt3_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_gpt4_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_gpt5_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_gpt6_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_400m",
> -						"sys_pll1_40m", "video_pll1_out", "sys_pll1_80m",
> +						"sys_pll1_40m", "video_pll_out", "sys_pll1_80m",
>  						"audio_pll1_out", "clk_ext1", };
>  
>  static const char * const imx8mn_wdog_sels[] = {"osc_24m", "sys_pll1_133m", "sys_pll1_160m",
> @@ -261,15 +261,15 @@ static const char * const imx8mn_wrclk_sels[] = {"osc_24m", "sys_pll1_40m", "m7_
>  
>  static const char * const imx8mn_dsi_core_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
>  						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
> -						    "audio_pll2_out", "video_pll1_out", };
> +						    "audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_dsi_phy_sels[] = {"osc_24m", "sys_pll2_125m", "sys_pll2_100m",
>  						   "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
> -						   "audio_pll2_out", "video_pll1_out", };
> +						   "audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_dsi_dbi_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_100m",
>  						   "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
> -						   "audio_pll2_out", "video_pll1_out", };
> +						   "audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "sys_pll1_800m",
>  						  "sys_pll2_500m", "sys_pll3_out", "sys_pll1_266m",
> @@ -277,15 +277,15 @@ static const char * const imx8mn_usdhc3_sels[] = {"osc_24m", "sys_pll1_400m", "s
>  
>  static const char * const imx8mn_camera_pixel_sels[] = {"osc_24m", "sys_pll1_266m", "sys_pll2_250m",
>  							"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
> -							"audio_pll2_out", "video_pll1_out", };
> +							"audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_csi1_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
>  						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
> -						    "audio_pll2_out", "video_pll1_out", };
> +						    "audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_csi2_phy_sels[] = {"osc_24m", "sys_pll2_333m", "sys_pll2_100m",
>  						    "sys_pll1_800m", "sys_pll2_1000m", "clk_ext2",
> -						    "audio_pll2_out", "video_pll1_out", };
> +						    "audio_pll2_out", "video_pll_out", };
>  
>  static const char * const imx8mn_csi2_esc_sels[] = {"osc_24m", "sys_pll2_100m", "sys_pll1_80m",
>  						    "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out",
> @@ -306,9 +306,9 @@ static const char * const imx8mn_clko1_sels[] = {"osc_24m", "sys_pll1_800m", "du
>  						 "dummy", "sys_pll1_80m", };
>  static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_400m",
>  						 "sys_pll2_166m", "sys_pll3_out", "audio_pll1_out",
> -						 "video_pll1_out", "osc_32k", };
> +						 "video_pll_out", "osc_32k", };
>  
> -static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll1_out",
> +static const char * const clkout_sels[] = {"audio_pll1_out", "audio_pll2_out", "video_pll_out",
>  					   "dummy", "dummy", "gpu_pll_out", "dummy",
>  					   "arm_pll_out", "sys_pll1", "sys_pll2", "sys_pll3",
>  					   "dummy", "dummy", "osc_24m", "dummy", "osc_32k"};
> @@ -349,7 +349,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> -	hws[IMX8MN_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> +	hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx_clk_hw_mux("video_pll_ref_sel", base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
>  	hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx_clk_hw_mux("m7_alt_pll_ref_sel", base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> @@ -358,7 +358,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  
>  	hws[IMX8MN_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", base, &imx_1443x_pll);
>  	hws[IMX8MN_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", base + 0x14, &imx_1443x_pll);
> -	hws[IMX8MN_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", base + 0x28, &imx_1443x_pll);
> +	hws[IMX8MN_VIDEO_PLL] = imx_clk_hw_pll14xx("video_pll", "video_pll_ref_sel", base + 0x28, &imx_1443x_pll);
>  	hws[IMX8MN_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", base + 0x50, &imx_1443x_dram_pll);
>  	hws[IMX8MN_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", base + 0x64, &imx_1416x_pll);
>  	hws[IMX8MN_M7_ALT_PLL] = imx_clk_hw_pll14xx("m7_alt_pll", "m7_alt_pll_ref_sel", base + 0x74, &imx_1416x_pll);
> @@ -370,7 +370,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	/* PLL bypass out */
>  	hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
> -	hws[IMX8MN_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
> +	hws[IMX8MN_VIDEO_PLL_BYPASS] = imx_clk_hw_mux_flags("video_pll_bypass", base + 0x28, 16, 1, video_pll_bypass_sels, ARRAY_SIZE(video_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
>  	hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx_clk_hw_mux_flags("m7_alt_pll_bypass", base + 0x74, 28, 1, m7_alt_pll_bypass_sels, ARRAY_SIZE(m7_alt_pll_bypass_sels), CLK_SET_RATE_PARENT);
> @@ -380,7 +380,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>  	/* PLL out gate */
>  	hws[IMX8MN_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", base, 13);
>  	hws[IMX8MN_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", base + 0x14, 13);
> -	hws[IMX8MN_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", base + 0x28, 13);
> +	hws[IMX8MN_VIDEO_PLL_OUT] = imx_clk_hw_gate("video_pll_out", "video_pll_bypass", base + 0x28, 13);
>  	hws[IMX8MN_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", base + 0x50, 13);
>  	hws[IMX8MN_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", base + 0x64, 11);
>  	hws[IMX8MN_M7_ALT_PLL_OUT] = imx_clk_hw_gate("m7_alt_pll_out", "m7_alt_pll_bypass", base + 0x74, 11);


All this changes LGTM.

> diff --git a/include/dt-bindings/clock/imx8mn-clock.h b/include/dt-bindings/clock/imx8mn-clock.h
> index f103b008a12a..5ab6916e444f 100644
> --- a/include/dt-bindings/clock/imx8mn-clock.h
> +++ b/include/dt-bindings/clock/imx8mn-clock.h
> @@ -16,7 +16,7 @@
>  #define IMX8MN_CLK_EXT4				7
>  #define IMX8MN_AUDIO_PLL1_REF_SEL		8
>  #define IMX8MN_AUDIO_PLL2_REF_SEL		9
> -#define IMX8MN_VIDEO_PLL1_REF_SEL		10
> +#define IMX8MN_VIDEO_PLL_REF_SEL		10

Same as in patch-1.

Regards,
  Marco

>  #define IMX8MN_DRAM_PLL_REF_SEL			11
>  #define IMX8MN_GPU_PLL_REF_SEL			12
>  #define IMX8MN_M7_ALT_PLL_REF_SEL		13
> @@ -26,7 +26,7 @@
>  #define IMX8MN_SYS_PLL3_REF_SEL			17
>  #define IMX8MN_AUDIO_PLL1			18
>  #define IMX8MN_AUDIO_PLL2			19
> -#define IMX8MN_VIDEO_PLL1			20
> +#define IMX8MN_VIDEO_PLL			20
>  #define IMX8MN_DRAM_PLL				21
>  #define IMX8MN_GPU_PLL				22
>  #define IMX8MN_M7_ALT_PLL			23
> @@ -36,7 +36,7 @@
>  #define IMX8MN_SYS_PLL3				27
>  #define IMX8MN_AUDIO_PLL1_BYPASS		28
>  #define IMX8MN_AUDIO_PLL2_BYPASS		29
> -#define IMX8MN_VIDEO_PLL1_BYPASS		30
> +#define IMX8MN_VIDEO_PLL_BYPASS			30
>  #define IMX8MN_DRAM_PLL_BYPASS			31
>  #define IMX8MN_GPU_PLL_BYPASS			32
>  #define IMX8MN_M7_ALT_PLL_BYPASS		33
> @@ -46,7 +46,7 @@
>  #define IMX8MN_SYS_PLL3_BYPASS			37
>  #define IMX8MN_AUDIO_PLL1_OUT			38
>  #define IMX8MN_AUDIO_PLL2_OUT			39
> -#define IMX8MN_VIDEO_PLL1_OUT			40
> +#define IMX8MN_VIDEO_PLL_OUT			40
>  #define IMX8MN_DRAM_PLL_OUT			41
>  #define IMX8MN_GPU_PLL_OUT			42
>  #define IMX8MN_M7_ALT_PLL_OUT			43
> -- 
> 2.32.0
> 
> 
> 
