Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0869681D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjBNPbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjBNPbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:31:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E972A999;
        Tue, 14 Feb 2023 07:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEE1D61748;
        Tue, 14 Feb 2023 15:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F02EC433EF;
        Tue, 14 Feb 2023 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676388657;
        bh=7PBICoqLHkYQKjC9KaZ0CCwJrSKS9sQCI+wch4oCIuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8p+SYzp+vM0MG2+7sCKnpTDV9HanEHxzoOquMM0r7mk45KDnjfma1yFtIMQnTRbI
         w6GrpgNjwIikKoldpWcbMblCYWhq5gdSMTevo0fGcBTXX3p+eysfiU9szeQoG8tSy6
         wntwM6yl4I3tM/EHvJi6wRDNf3DARXVRdz2xNyvVwuTtOykJKeW8MvXSfNoBaIXL16
         hIxUbjo1WfLzVDntygGDAGKqY9DDiCvnfOm6b2oa7hTVjJdGk6MYZ6KcNK272QO9l9
         665Dh7Djh4GMhRtJwwOhBuj3x7lb+8HAxRDgNE1KEmYxFNfI9Xy7vlZNS7lwehbl0W
         s0hdCzjc4StQg==
Date:   Tue, 14 Feb 2023 21:00:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com
Subject: Re: [PATCH v7 3/3] phy: mediatek: add support for phy-mtk-hdmi-mt8195
Message-ID: <Y+upK4nCCYlg+4dU@matsya>
References: <20220919-v7-0-b5b58c5ccc07@baylibre.com>
 <20220919-v7-3-b5b58c5ccc07@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919-v7-3-b5b58c5ccc07@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-23, 12:33, Guillaume Ranquet wrote:
> Add support for the mediatek hdmi phy on MT8195 SoC
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  drivers/phy/mediatek/Makefile              |   1 +
>  drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 509 +++++++++++++++++++++++++++++
>  drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h | 113 +++++++
>  drivers/phy/mediatek/phy-mtk-hdmi.c        |   3 +
>  drivers/phy/mediatek/phy-mtk-hdmi.h        |   2 +
>  5 files changed, 628 insertions(+)
> 
> diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
> index fb1f8edaffa7..c9a50395533e 100644
> --- a/drivers/phy/mediatek/Makefile
> +++ b/drivers/phy/mediatek/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-mtk-xsphy.o
>  phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
>  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
>  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8173.o
> +phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8195.o
>  obj-$(CONFIG_PHY_MTK_HDMI)		+= phy-mtk-hdmi-drv.o
>  
>  phy-mtk-mipi-dsi-drv-y			:= phy-mtk-mipi-dsi.o
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> new file mode 100644
> index 000000000000..3ddf842683f2
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> @@ -0,0 +1,509 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Copyright (c) 2022 BayLibre, SAS
> + */
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +#include <linux/nvmem-consumer.h>
> +
> +#include "phy-mtk-io.h"
> +#include "phy-mtk-hdmi.h"
> +#include "phy-mtk-hdmi-mt8195.h"
> +
> +static void mtk_hdmi_ana_fifo_en(struct mtk_hdmi_phy *hdmi_phy)
> +{
> +	/* make data fifo writable for hdmi2.0 */
> +	mtk_phy_set_bits(hdmi_phy->regs + HDMI_ANA_CTL, REG_ANA_HDMI20_FIFO_EN);
> +}
> +
> +static void
> +mtk_phy_tmds_clk_ratio(struct mtk_hdmi_phy *hdmi_phy, bool enable)
> +{
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_hdmi_ana_fifo_en(hdmi_phy);
> +
> +	/* HDMI 2.0 specification, 3.4Gbps <= TMDS Bit Rate <= 6G,
> +	 * clock bit ratio 1:40, under 3.4Gbps, clock bit ratio 1:10
> +	 */
> +	if (enable)
> +		mtk_phy_update_field(regs + HDMI20_CLK_CFG, REG_TXC_DIV, 3);
> +	else
> +		mtk_phy_clear_bits(regs + HDMI20_CLK_CFG, REG_TXC_DIV);
> +}
> +
> +static void mtk_hdmi_pll_sel_src(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_REF_XTAL_SEL);
> +	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_REF_RESPLL_SEL);
> +
> +	/* DA_HDMITX21_REF_CK for TXPLL input source */
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITXPLL_REF_CK_SEL);
> +}
> +
> +static void mtk_hdmi_pll_perf(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_BP2);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BC);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_IC, 0x1);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BR, 0x2);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_IR, 0x2);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_BP);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_IBAND_FIX_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT14);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_HIKVCO);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_HREN, 0x1);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_LVR_SEL, 0x1);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT12_11);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_0, RG_HDMITXPLL_TCL_EN);
> +}
> +
> +static int mtk_hdmi_pll_set_hw(struct clk_hw *hw, u8 prediv,
> +			       u8 fbkdiv_high,
> +			       u32 fbkdiv_low,
> +			       u8 fbkdiv_hs3, u8 posdiv1,
> +			       u8 posdiv2, u8 txprediv,
> +			       u8 txposdiv,
> +			       u8 digital_div)
> +{
> +	u8 txposdiv_value;
> +	u8 div3_ctrl_value;
> +	u8 posdiv_vallue;
> +	u8 div_ctrl_value;
> +	u8 reserve_3_2_value;
> +	u8 prediv_value;
> +	u8 reserve13_value;
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_hdmi_pll_sel_src(hw);
> +
> +	mtk_hdmi_pll_perf(hw);
> +
> +	mtk_phy_update_field(regs + HDMI_1_CFG_10, RG_HDMITX21_BIAS_PE_BG_VREF_SEL, 0x2);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_VREF_SEL);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_9, RG_HDMITX21_SLDO_VREF_SEL, 0x2);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BIAS_PE_VREF_SELB);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDOLPF_EN);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_6, RG_HDMITX21_INTR_CAL, 0x11);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
> +
> +	/* TXPOSDIV */
> +	txposdiv_value = ilog2(txposdiv);
> +
> +	mtk_phy_update_field(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV, txposdiv_value);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_EN);
> +
> +	/* TXPREDIV */
> +	switch (txprediv) {
> +	case 2:
> +		div3_ctrl_value = 0x0;
> +		posdiv_vallue = 0x0;
> +		break;
> +	case 4:
> +		div3_ctrl_value = 0x0;
> +		posdiv_vallue = 0x1;
> +		break;
> +	case 6:
> +		div3_ctrl_value = 0x1;
> +		posdiv_vallue = 0x0;
> +		break;
> +	case 12:
> +		div3_ctrl_value = 0x1;
> +		posdiv_vallue = 0x1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_POSDIV_DIV3_CTRL, div3_ctrl_value);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_POSDIV, posdiv_vallue);
> +
> +	/* POSDIV1 */
> +	switch (posdiv1) {
> +	case 5:
> +		div_ctrl_value = 0x0;
> +		break;
> +	case 10:
> +		div_ctrl_value = 0x1;
> +		break;
> +	case 12:
> +		div_ctrl_value = 0x2;
> +		break;
> +	case 15:
> +		div_ctrl_value = 0x3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_DIV_CTRL, div_ctrl_value);
> +
> +	/* DE add new setting */
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT14);
> +
> +	/* POSDIV2 */
> +	switch (posdiv2) {
> +	case 1:
> +		reserve_3_2_value = 0x0;
> +		break;
> +	case 2:
> +		reserve_3_2_value = 0x1;
> +		break;
> +	case 4:
> +		reserve_3_2_value = 0x2;
> +		break;
> +	case 6:
> +		reserve_3_2_value = 0x3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT3_2, reserve_3_2_value);
> +
> +	/* DE add new setting */
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT1_0, 0x2);
> +
> +	/* PREDIV */
> +	prediv_value = ilog2(prediv);
> +
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_PREDIV, prediv_value);
> +
> +	/* FBKDIV_HS3 */
> +	reserve13_value = ilog2(fbkdiv_hs3);
> +
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_1, RG_HDMITXPLL_RESERVE_BIT13, reserve13_value);
> +
> +	/* FBDIV */
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_4, RG_HDMITXPLL_FBKDIV_HIGH, fbkdiv_high);
> +	mtk_phy_update_field(regs + HDMI_1_PLL_CFG_3, RG_HDMITXPLL_FBKDIV_LOW, fbkdiv_low);
> +
> +	/* Digital DIVIDER */
> +	mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_PIXEL_CLOCK_SEL);
> +
> +	if (digital_div == 1) {
> +		mtk_phy_clear_bits(regs + HDMI_CTL_3, REG_HDMITX_PIXEL_CLOCK);
> +	} else {
> +		mtk_phy_set_bits(regs + HDMI_CTL_3, REG_HDMITX_PIXEL_CLOCK);
> +		mtk_phy_update_field(regs + HDMI_CTL_3, REG_HDMITXPLL_DIV, digital_div - 1);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
> +			     unsigned long rate, unsigned long parent_rate)
> +{
> +	int i = 0;

Superfluous init

> +	int ret;
> +	u64 tmds_clk;
> +	u64 pixel_clk;
> +	/* pll input source frequency */
> +	u64 da_hdmitx21_ref_ck;
> +	/* ICO output clk */
> +	u64 ns_hdmipll_ck;
> +	/* source clk for Display digital */
> +	u64 ad_hdmipll_pixel_ck;
> +	u64 pcw;
> +	u32 fbkdiv_low;
> +	u8 digital_div;
> +	u8 txprediv;
> +	u8 txposdiv;
> +	u8 fbkdiv_high;
> +	u8 posdiv1;
> +	u8 posdiv2;
> +	u8 txpredivs[4] = { 2, 4, 6, 12 };

you can use multiple variables in a single line and in reverse christmas
tree order

> +
> +	pixel_clk = rate;
> +	tmds_clk = pixel_clk;
> +
> +	if (tmds_clk < 25000000 || tmds_clk > 594000000)

use 25 * MEGA, more readable..

> +		return -EINVAL;
> +
> +	if (tmds_clk >= 340000000)
> +		hdmi_phy->tmds_over_340M = true;
> +	else
> +		hdmi_phy->tmds_over_340M = false;
> +
> +	/* in Hz */
> +	da_hdmitx21_ref_ck = 26000000UL;
> +
> +	/*  TXPOSDIV stage treatment:
> +	 *	0M  <  TMDS clk  < 54M		  /8
> +	 *	54M <= TMDS clk  < 148.35M    /4
> +	 *	148.35M <=TMDS clk < 296.7M   /2
> +	 *	296.7 <=TMDS clk <= 594M	  /1
> +	 */
> +	if (tmds_clk < 54000000UL)
> +		txposdiv = 8;
> +	else if (tmds_clk >= 54000000UL && tmds_clk < 148350000UL)
> +		txposdiv = 4;
> +	else if (tmds_clk >= 148350000UL && tmds_clk < 296700000UL)
> +		txposdiv = 2;
> +	else if (tmds_clk >= 296700000UL && tmds_clk <= 594000000UL)
> +		txposdiv = 1;
> +	else
> +		return -EINVAL;
> +
> +	/* calculate txprediv: can be 2, 4, 6, 12
> +	 * ICO clk = 5*TMDS_CLK*TXPOSDIV*TXPREDIV
> +	 * ICO clk constraint: 5G =< ICO clk <= 12G
> +	 */
> +	for (i = 0; i < ARRAY_SIZE(txpredivs); i++) {
> +		ns_hdmipll_ck = 5 * tmds_clk * txposdiv * txpredivs[i];
> +		if (ns_hdmipll_ck >= 5000000000UL &&
> +		    ns_hdmipll_ck <= 12000000000UL)
> +			break;
> +	}
> +	if (i == (ARRAY_SIZE(txpredivs) - 1) &&
> +	    (ns_hdmipll_ck < 5000000000UL || ns_hdmipll_ck > 12000000000UL)) {
> +		return -EINVAL;
> +	}
> +	if (i == ARRAY_SIZE(txpredivs))
> +		return -EINVAL;
> +
> +	txprediv = txpredivs[i];
> +
> +	/* PCW calculation: FBKDIV
> +	 * formula: pcw=(frequency_out*2^pcw_bit) / frequency_in / FBKDIV_HS3;
> +	 * RG_HDMITXPLL_FBKDIV[32:0]:
> +	 * [32,24] 9bit integer, [23,0]:24bit fraction
> +	 */
> +	pcw = div_u64(((u64)ns_hdmipll_ck) << PCW_DECIMAL_WIDTH,
> +		      da_hdmitx21_ref_ck / PLL_FBKDIV_HS3);
> +
> +	if (pcw > GENMASK_ULL(32, 0))
> +		return -EINVAL;
> +
> +	fbkdiv_high = FIELD_GET(GENMASK_ULL(63, 32), pcw);
> +	fbkdiv_low = FIELD_GET(GENMASK(31, 0), pcw);
> +
> +	/* posdiv1:
> +	 * posdiv1 stage treatment according to color_depth:
> +	 * 24bit -> posdiv1 /10, 30bit -> posdiv1 /12.5,
> +	 * 36bit -> posdiv1 /15, 48bit -> posdiv1 /10
> +	 */
> +	posdiv1 = 10;
> +	posdiv2 = 1;
> +
> +	/* Digital clk divider, max /32 */
> +	digital_div = div_u64((u64)ns_hdmipll_ck, posdiv1 / posdiv2 / pixel_clk);
> +	digital_div = ad_hdmipll_pixel_ck / pixel_clk;
> +	if (!(digital_div <= 32 && digital_div >= 1))
> +		return -EINVAL;
> +
> +	mtk_hdmi_pll_set_hw(hw, PLL_PREDIV, fbkdiv_high, fbkdiv_low,
> +			    PLL_FBKDIV_HS3, posdiv1, posdiv2, txprediv,
> +			    txposdiv, digital_div);
> +	if (ret)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int mtk_hdmi_pll_drv_setting(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +	u8 data_channel_bias, clk_channel_bias;
> +	u8 impedance, impedance_en;
> +	u32 tmds_clk;
> +	u32 pixel_clk = hdmi_phy->pll_rate;
> +
> +	tmds_clk = pixel_clk;
> +
> +	/* bias & impedance setting:
> +	 * 3G < data rate <= 6G: enable impedance 100ohm,
> +	 *      data channel bias 24mA, clock channel bias 20mA
> +	 * pixel clk >= HD,  74.175MHZ <= pixel clk <= 300MHZ:
> +	 *      enalbe impedance 100ohm
> +	 *      data channel 20mA, clock channel 16mA
> +	 * 27M =< pixel clk < 74.175: disable impedance
> +	 *      data channel & clock channel bias 10mA
> +	 */
> +
> +	/* 3G < data rate <= 6G, 300M < tmds rate <= 594M */
> +	if (tmds_clk > 300000000UL && tmds_clk <= 594000000UL) {
> +		data_channel_bias = 0x3c; /* 24mA */
> +		clk_channel_bias = 0x34; /* 20mA */
> +		impedance_en = 0xf;
> +		impedance = 0x36; /* 100ohm */
> +	} else if (pixel_clk >= 74175000UL && pixel_clk <= 300000000UL) {
> +		data_channel_bias = 0x34; /* 20mA */
> +		clk_channel_bias = 0x2c; /* 16mA */
> +		impedance_en = 0xf;
> +		impedance = 0x36; /* 100ohm */
> +	} else if (pixel_clk >= 27000000UL && pixel_clk < 74175000UL) {
> +		data_channel_bias = 0x14; /* 10mA */
> +		clk_channel_bias = 0x14; /* 10mA */
> +		impedance_en = 0x0;
> +		impedance = 0x0;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	/* bias */
> +	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D0, data_channel_bias);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D1, data_channel_bias);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_1, RG_HDMITX21_DRV_IBIAS_D2, data_channel_bias);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_IBIAS_CLK, clk_channel_bias);
> +
> +	/* impedance */
> +	mtk_phy_update_field(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_IMP_EN, impedance_en);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D0_EN1, impedance);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D1_EN1, impedance);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_D2_EN1, impedance);
> +	mtk_phy_update_field(regs + HDMI_1_CFG_2, RG_HDMITX21_DRV_IMP_CLK_EN1, impedance);

sounds odd that we are writing same value to diff registers?

> +
> +	return 0;
> +}
> +
> +static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_TX_POSDIV_EN);
> +
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_SER_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D0_DRV_OP_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D1_DRV_OP_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_D2_DRV_OP_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_CK_DRV_OP_EN);
> +
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D0_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D1_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_D2_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_FRL_CK_EN);
> +
> +	mtk_hdmi_pll_drv_setting(hw);
> +
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BG_PWD);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_BIAS_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_CKLDO_EN);
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDO_EN);
> +
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_PWR_ON);
> +	usleep_range(5, 10);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_ISO_EN);
> +	usleep_range(5, 10);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
> +	usleep_range(30, 50);
> +	return 0;
> +}
> +
> +static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	mtk_phy_set_bits(regs + HDMI_1_CFG_10, RG_HDMITX21_BG_PWD);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_6, RG_HDMITX21_BIAS_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_CKLDO_EN);
> +	mtk_phy_clear_bits(regs + HDMI_1_CFG_3, RG_HDMITX21_SLDO_EN);
> +
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_2, RG_HDMITXPLL_PWD);
> +	usleep_range(10, 20);
> +	mtk_phy_set_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_ISO_EN);
> +	usleep_range(10, 20);
> +	mtk_phy_clear_bits(regs + HDMI_1_PLL_CFG_4, DA_HDMITXPLL_PWR_ON);
> +}
> +
> +static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				 unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	dev_dbg(hdmi_phy->dev, "%s: %lu Hz, parent: %lu Hz\n", __func__, rate,
> +		parent_rate);
> +
> +	return mtk_hdmi_pll_calc(hdmi_phy, hw, rate, parent_rate);
> +}
> +
> +static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				    unsigned long *parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	hdmi_phy->pll_rate = rate;
> +	return rate;
> +}
> +
> +static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
> +					      unsigned long parent_rate)
> +{
> +	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
> +
> +	return hdmi_phy->pll_rate;
> +}
> +
> +static const struct clk_ops mtk_hdmi_pll_ops = {
> +	.prepare = mtk_hdmi_pll_prepare,
> +	.unprepare = mtk_hdmi_pll_unprepare,
> +	.set_rate = mtk_hdmi_pll_set_rate,
> +	.round_rate = mtk_hdmi_pll_round_rate,
> +	.recalc_rate = mtk_hdmi_pll_recalc_rate,
> +};
> +
> +static void vtx_signal_en(struct mtk_hdmi_phy *hdmi_phy, bool on)
> +{
> +	void __iomem *regs = hdmi_phy->regs;
> +
> +	if (on)
> +		mtk_phy_set_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_EN);
> +	else
> +		mtk_phy_clear_bits(regs + HDMI_1_CFG_0, RG_HDMITX21_DRV_EN);
> +}
> +
> +static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
> +{
> +	vtx_signal_en(hdmi_phy, true);
> +	usleep_range(100, 150);
> +}
> +
> +static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
> +{
> +	vtx_signal_en(hdmi_phy, false);
> +}
> +
> +static int mtk_hdmi_phy_configure(struct phy *phy, union phy_configure_opts *opts)
> +{
> +	struct phy_configure_opts_dp *dp_opts = &opts->dp;
> +	struct mtk_hdmi_phy *hdmi_phy = phy_get_drvdata(phy);
> +	int ret;
> +
> +	ret = clk_set_rate(hdmi_phy->pll, dp_opts->link_rate);
> +
> +	if (ret)
> +		return ret;
> +
> +	mtk_phy_tmds_clk_ratio(hdmi_phy, hdmi_phy->tmds_over_340M);
> +
> +	return ret;
> +}
> +
> +struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf = {
> +	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
> +	.hdmi_phy_clk_ops = &mtk_hdmi_pll_ops,
> +	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
> +	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
> +	.hdmi_phy_configure = mtk_hdmi_phy_configure,
> +};
> +
> +MODULE_AUTHOR("Can Zeng <can.zeng@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek MT8195 HDMI PHY Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
> new file mode 100644
> index 000000000000..22a68dc9550c
> --- /dev/null
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Copyright (c) 2022 BayLibre, SAS
> + */
> +
> +#ifndef _MTK_HDMI_PHY_8195_H
> +#define _MTK_HDMI_PHY_8195_H
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/types.h>
> +
> +#define PCW_DECIMAL_WIDTH 24
> +#define PLL_PREDIV 1
> +#define PLL_FBKDIV_HS3 1
> +
> +#define HDMI20_CLK_CFG 0x70
> +#define REG_TXC_DIV GENMASK(31, 30)
> +
> +#define HDMI_1_CFG_0 0x00
> +#define RG_HDMITX21_DRV_IBIAS_CLK GENMASK(10, 5)
> +#define RG_HDMITX21_DRV_IMP_EN GENMASK(23, 20)
> +#define RG_HDMITX21_DRV_EN GENMASK(27, 24)
> +#define RG_HDMITX21_SER_EN GENMASK(31, 28)
> +
> +#define HDMI_1_CFG_1 0x04
> +#define RG_HDMITX21_DRV_IBIAS_D0 GENMASK(19, 14)
> +#define RG_HDMITX21_DRV_IBIAS_D1 GENMASK(25, 20)
> +#define RG_HDMITX21_DRV_IBIAS_D2 GENMASK(31, 26)
> +
> +#define HDMI_1_CFG_10 0x40
> +#define RG_HDMITXPLL_REF_CK_SEL GENMASK(2, 1)
> +#define RG_HDMITX21_VREF_SEL BIT(4)
> +#define RG_HDMITX21_BIAS_PE_VREF_SELB BIT(10)
> +#define RG_HDMITX21_BIAS_PE_BG_VREF_SEL GENMASK(16, 15)
> +#define RG_HDMITX21_BG_PWD BIT(20)
> +
> +#define HDMI_1_CFG_2 0x08
> +#define RG_HDMITX21_DRV_IMP_D0_EN1 GENMASK(13, 8)
> +#define RG_HDMITX21_DRV_IMP_D1_EN1 GENMASK(19, 14)
> +#define RG_HDMITX21_DRV_IMP_D2_EN1 GENMASK(25, 20)
> +#define RG_HDMITX21_DRV_IMP_CLK_EN1 GENMASK(31, 26)
> +
> +#define HDMI_1_CFG_3 0x0c
> +#define RG_HDMITX21_CKLDO_EN BIT(3)
> +#define RG_HDMITX21_SLDOLPF_EN BIT(7)
> +#define RG_HDMITX21_SLDO_EN GENMASK(11, 8)
> +
> +#define HDMI_1_CFG_6 0x18
> +#define RG_HDMITX21_D2_DRV_OP_EN BIT(8)
> +#define RG_HDMITX21_D1_DRV_OP_EN BIT(9)
> +#define RG_HDMITX21_D0_DRV_OP_EN BIT(10)
> +#define RG_HDMITX21_CK_DRV_OP_EN BIT(11)
> +#define RG_HDMITX21_FRL_EN BIT(12)
> +#define RG_HDMITX21_FRL_CK_EN BIT(13)
> +#define RG_HDMITX21_FRL_D0_EN BIT(14)
> +#define RG_HDMITX21_FRL_D1_EN BIT(15)
> +#define RG_HDMITX21_FRL_D2_EN BIT(16)
> +#define RG_HDMITX21_INTR_CAL GENMASK(22, 18)
> +#define RG_HDMITX21_TX_POSDIV GENMASK(27, 26)
> +#define RG_HDMITX21_TX_POSDIV_EN BIT(28)
> +#define RG_HDMITX21_BIAS_EN BIT(29)
> +
> +#define HDMI_1_CFG_9 0x24
> +#define RG_HDMITX21_SLDO_VREF_SEL GENMASK(5, 4)
> +
> +#define HDMI_1_PLL_CFG_0 0x44
> +#define RG_HDMITXPLL_HREN GENMASK(13, 12)
> +#define RG_HDMITXPLL_IBAND_FIX_EN BIT(24)
> +#define RG_HDMITXPLL_LVR_SEL GENMASK(27, 26)
> +#define RG_HDMITXPLL_BP2 BIT(30)
> +#define RG_HDMITXPLL_TCL_EN BIT(31)
> +
> +#define HDMI_1_PLL_CFG_1 0x48
> +#define RG_HDMITXPLL_RESERVE_BIT1_0 GENMASK(1, 0)
> +#define RG_HDMITXPLL_RESERVE_BIT3_2 GENMASK(3, 2)
> +#define RG_HDMITXPLL_RESERVE_BIT12_11 GENMASK(12, 11)
> +#define RG_HDMITXPLL_RESERVE_BIT13 BIT(13)
> +#define RG_HDMITXPLL_RESERVE_BIT14 BIT(14)
> +
> +#define HDMI_1_PLL_CFG_2 0x4c
> +#define RG_HDMITXPLL_BC GENMASK(28, 27)
> +#define RG_HDMITXPLL_IC GENMASK(26, 22)
> +#define RG_HDMITXPLL_BR GENMASK(21, 19)
> +#define RG_HDMITXPLL_IR GENMASK(18, 14)
> +#define RG_HDMITXPLL_BP GENMASK(13, 10)
> +#define RG_HDMITXPLL_HIKVCO BIT(29)
> +#define RG_HDMITXPLL_PWD BIT(31)
> +
> +#define HDMI_1_PLL_CFG_3 0x50
> +#define RG_HDMITXPLL_FBKDIV_LOW GENMASK(31, 0)
> +
> +#define HDMI_1_PLL_CFG_4 0x54
> +#define DA_HDMITXPLL_ISO_EN BIT(1)
> +#define DA_HDMITXPLL_PWR_ON BIT(2)
> +#define RG_HDMITXPLL_POSDIV_DIV3_CTRL BIT(21)
> +#define RG_HDMITXPLL_POSDIV GENMASK(23, 22)
> +#define RG_HDMITXPLL_DIV_CTRL GENMASK(25, 24)
> +#define RG_HDMITXPLL_PREDIV GENMASK(29, 28)
> +#define RG_HDMITXPLL_FBKDIV_HIGH BIT(31)
> +
> +#define HDMI_ANA_CTL 0x7c
> +#define REG_ANA_HDMI20_FIFO_EN BIT(16)
> +
> +#define HDMI_CTL_3 0xcc
> +#define REG_HDMITXPLL_DIV GENMASK(4, 0)
> +#define REG_HDMITX_REF_XTAL_SEL BIT(7)
> +#define REG_HDMITX_REF_RESPLL_SEL BIT(9)
> +#define REG_PIXEL_CLOCK_SEL BIT(10)
> +#define REG_HDMITX_PIXEL_CLOCK BIT(23)
> +
> +#endif /* MTK_HDMI_PHY_8195_H */
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
> index 32f713301768..d2e824771f9d 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.c
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
> @@ -161,6 +161,9 @@ static const struct of_device_id mtk_hdmi_phy_match[] = {
>  	{ .compatible = "mediatek,mt8173-hdmi-phy",
>  	  .data = &mtk_hdmi_phy_8173_conf,
>  	},
> +	{ .compatible = "mediatek,mt8195-hdmi-phy",
> +	  .data = &mtk_hdmi_phy_8195_conf,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_hdmi_phy_match);
> diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
> index f5aac9d352d8..fc2ad6a0527f 100644
> --- a/drivers/phy/mediatek/phy-mtk-hdmi.h
> +++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
> @@ -40,10 +40,12 @@ struct mtk_hdmi_phy {
>  	unsigned char drv_imp_d0;
>  	unsigned int ibias;
>  	unsigned int ibias_up;
> +	bool tmds_over_340M;
>  };
>  
>  struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
>  
> +extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
>  extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
>  
> 
> -- 
> 2.39.0

-- 
~Vinod
