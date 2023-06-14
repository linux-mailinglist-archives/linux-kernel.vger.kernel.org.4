Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA472FC48
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbjFNLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235144AbjFNLVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:21:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C1EE55;
        Wed, 14 Jun 2023 04:21:49 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7F9706606F13;
        Wed, 14 Jun 2023 12:21:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686741708;
        bh=4rOSmo+glHfEoKVvxZWH59dxBdMSG6G4mprKIGBai0Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fNkkUavOECek4JgE3iw0G1BS+US1I4al+SGoGx/Y7LoOlvoz5AdWdL9u1klQsWorv
         5mb1oR4JYFB7wHuVvBMX4/TIDRmc+aWAk79tmBCN3zcm3Lr+m8t6w/CFG0Si38S3D7
         /CaTkELWTKa3PFhFeZqlFIU2QMZL1+4S+noZSlymeHEUQPm95HZZz0CYrf+M5z9OBM
         PUpiuDLFu687qZyvvGXy/9CaIt0DkZgORjKD82eSRqjyewc2sSRdxHewQAOCkcpH4K
         Da/Pag2VC4JgtrhtQT9lB9yW7E1l6BB+LGO+b9Tv0DcgO+GUSrb3Kh8vKFAMLvBjE3
         WfwactpGGiHzA==
Message-ID: <c2127bcd-f990-1c83-45b2-d3a19f66e5bc@collabora.com>
Date:   Wed, 14 Jun 2023 13:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 08/15] soc: mediatek: Support MT8188 VDOSYS1 in
 mtk-mmsys
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-9-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230614073125.17958-9-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/06/23 09:31, Hsiao Chien Sung ha scritto:
> - Add register definitions for MT8188
> - Add VDOSYS1 routing table
> - Update MUTEX definitions accordingly
> - Set VSYNC length from 0x40 (default) to 1 since ETHDR is bypassed
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

I love that you added documentation to struct mtk_mmsys_driver_data. Good job!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/soc/mediatek/mt8188-mmsys.h | 127 ++++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c    |  13 +++
>   drivers/soc/mediatek/mtk-mmsys.h    |  29 +++++++
>   drivers/soc/mediatek/mtk-mutex.c    |  35 ++++++++
>   4 files changed, 204 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8188-mmsys.h b/drivers/soc/mediatek/mt8188-mmsys.h
> index 448cc3761b43..447afb72d95f 100644
> --- a/drivers/soc/mediatek/mt8188-mmsys.h
> +++ b/drivers/soc/mediatek/mt8188-mmsys.h
> @@ -67,6 +67,57 @@
>   #define MT8188_SOUT_DSC_WRAP0_OUT_TO_VPP_MERGE		BIT(18)
>   #define MT8188_SOUT_DSC_WRAP0_OUT_TO_DISP_WDMA0		BIT(19)
> 
> +#define MT8188_VDO1_SW0_RST_B					0x1d0
> +#define MT8188_VDO1_HDR_TOP_CFG					0xd00
> +#define MT8188_VDO1_MIXER_IN1_ALPHA				0xd30
> +#define MT8188_VDO1_MIXER_IN1_PAD				0xd40
> +#define MT8188_VDO1_MERGE0_ASYNC_CFG_WD				0xe30
> +#define MT8188_VDO1_HDRBE_ASYNC_CFG_WD				0xe70
> +#define MT8188_VDO1_VPP_MERGE0_P0_SEL_IN			0xf04
> +#define MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0		1
> +#define MT8188_VDO1_VPP_MERGE0_P1_SEL_IN			0xf08
> +#define MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1		1
> +#define MT8188_VDO1_DISP_DPI1_SEL_IN				0xf10
> +#define MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT		0
> +#define MT8188_VDO1_DISP_DP_INTF0_SEL_IN			0xf14
> +#define MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT	0
> +#define MT8188_VDO1_MERGE4_SOUT_SEL				0xf18
> +#define MT8188_MERGE4_SOUT_TO_DPI1_SEL				BIT(2)
> +#define MT8188_MERGE4_SOUT_TO_DP_INTF0_SEL			BIT(3)
> +#define MT8188_VDO1_MIXER_IN1_SEL_IN				0xf24
> +#define MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT		1
> +#define MT8188_VDO1_MIXER_IN2_SEL_IN				0xf28
> +#define MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT		1
> +#define MT8188_VDO1_MIXER_IN3_SEL_IN				0xf2c
> +#define MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT		1
> +#define MT8188_VDO1_MIXER_IN4_SEL_IN				0xf30
> +#define MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT		1
> +#define MT8188_VDO1_MIXER_OUT_SOUT_SEL				0xf34
> +#define MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL			1
> +#define MT8188_VDO1_VPP_MERGE1_P0_SEL_IN			0xf3c
> +#define MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA2		1
> +#define MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL			0xf40
> +#define MT8188_SOUT_TO_MIXER_IN1_SEL				1
> +#define MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL			0xf44
> +#define MT8188_SOUT_TO_MIXER_IN2_SEL				1
> +#define MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL			0xf48
> +#define MT8188_SOUT_TO_MIXER_IN3_SEL				1
> +#define MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL			0xf4c
> +#define MT8188_SOUT_TO_MIXER_IN4_SEL				1
> +#define MT8188_VDO1_MERGE4_ASYNC_SEL_IN				0xf50
> +#define MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT		1
> +#define MT8188_VDO1_MIXER_IN1_SOUT_SEL				0xf58
> +#define MT8188_MIXER_IN1_SOUT_TO_DISP_MIXER			0
> +#define MT8188_VDO1_MIXER_IN2_SOUT_SEL				0xf5c
> +#define MT8188_MIXER_IN2_SOUT_TO_DISP_MIXER			0
> +#define MT8188_VDO1_MIXER_IN3_SOUT_SEL				0xf60
> +#define MT8188_MIXER_IN3_SOUT_TO_DISP_MIXER			0
> +#define MT8188_VDO1_MIXER_IN4_SOUT_SEL				0xf64
> +#define MT8188_MIXER_IN4_SOUT_TO_DISP_MIXER			0
> +#define MT8188_VDO1_MIXER_SOUT_SEL_IN				0xf68
> +#define MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER		0
> +#define MT8188_VDO1_MIXER_VSYNC_LEN				0xd5c
> +
>   static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
>   	{
>   		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> @@ -146,4 +197,80 @@ static const struct mtk_mmsys_routes mmsys_mt8188_routing_table[] = {
>   	},
>   };
> 
> +static const struct mtk_mmsys_routes mmsys_mt8188_vdo1_routing_table[] = {
> +	{
> +		DDP_COMPONENT_MDP_RDMA0, DDP_COMPONENT_MERGE1,
> +		MT8188_VDO1_VPP_MERGE0_P0_SEL_IN, GENMASK(0, 0),
> +		MT8188_VPP_MERGE0_P0_SEL_IN_FROM_MDP_RDMA0
> +	}, {
> +		DDP_COMPONENT_MDP_RDMA1, DDP_COMPONENT_MERGE1,
> +		MT8188_VDO1_VPP_MERGE0_P1_SEL_IN, GENMASK(0, 0),
> +		MT8188_VPP_MERGE0_P1_SEL_IN_FROM_MDP_RDMA1
> +	}, {
> +		DDP_COMPONENT_MDP_RDMA2, DDP_COMPONENT_MERGE2,
> +		MT8188_VDO1_VPP_MERGE1_P0_SEL_IN, GENMASK(0, 0),
> +		MT8188_VPP_MERGE1_P0_SEL_IN_FROM_MDP_RDMA2
> +	}, {
> +		DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MERGE0_ASYNC_SOUT_SEL, GENMASK(1, 0),
> +		MT8188_SOUT_TO_MIXER_IN1_SEL
> +	}, {
> +		DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MERGE1_ASYNC_SOUT_SEL, GENMASK(1, 0),
> +		MT8188_SOUT_TO_MIXER_IN2_SEL
> +	}, {
> +		DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MERGE2_ASYNC_SOUT_SEL, GENMASK(1, 0),
> +		MT8188_SOUT_TO_MIXER_IN3_SEL
> +	}, {
> +		DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MERGE3_ASYNC_SOUT_SEL, GENMASK(1, 0),
> +		MT8188_SOUT_TO_MIXER_IN4_SEL
> +	}, {
> +		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
> +		MT8188_VDO1_MIXER_OUT_SOUT_SEL, GENMASK(0, 0),
> +		MT8188_MIXER_SOUT_TO_MERGE4_ASYNC_SEL
> +	}, {
> +		DDP_COMPONENT_MERGE1, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MIXER_IN1_SEL_IN, GENMASK(0, 0),
> +		MT8188_MIXER_IN1_SEL_IN_FROM_MERGE0_ASYNC_SOUT
> +	}, {
> +		DDP_COMPONENT_MERGE2, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MIXER_IN2_SEL_IN, GENMASK(0, 0),
> +		MT8188_MIXER_IN2_SEL_IN_FROM_MERGE1_ASYNC_SOUT
> +	}, {
> +		DDP_COMPONENT_MERGE3, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MIXER_IN3_SEL_IN, GENMASK(0, 0),
> +		MT8188_MIXER_IN3_SEL_IN_FROM_MERGE2_ASYNC_SOUT
> +	}, {
> +		DDP_COMPONENT_MERGE4, DDP_COMPONENT_ETHDR_MIXER,
> +		MT8188_VDO1_MIXER_IN4_SEL_IN, GENMASK(0, 0),
> +		MT8188_MIXER_IN4_SEL_IN_FROM_MERGE3_ASYNC_SOUT
> +	}, {
> +		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
> +		MT8188_VDO1_MIXER_SOUT_SEL_IN, GENMASK(2, 0),
> +		MT8188_MIXER_SOUT_SEL_IN_FROM_DISP_MIXER
> +	}, {
> +		DDP_COMPONENT_ETHDR_MIXER, DDP_COMPONENT_MERGE5,
> +		MT8188_VDO1_MERGE4_ASYNC_SEL_IN, GENMASK(2, 0),
> +		MT8188_MERGE4_ASYNC_SEL_IN_FROM_MIXER_OUT_SOUT
> +	}, {
> +		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
> +		MT8188_VDO1_DISP_DPI1_SEL_IN, GENMASK(1, 0),
> +		MT8188_DISP_DPI1_SEL_IN_FROM_VPP_MERGE4_MOUT
> +	}, {
> +		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DPI1,
> +		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(1, 0),
> +		MT8188_MERGE4_SOUT_TO_DPI1_SEL
> +	}, {
> +		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
> +		MT8188_VDO1_DISP_DP_INTF0_SEL_IN, GENMASK(1, 0),
> +		MT8188_DISP_DP_INTF0_SEL_IN_FROM_VPP_MERGE4_MOUT
> +	}, {
> +		DDP_COMPONENT_MERGE5, DDP_COMPONENT_DP_INTF1,
> +		MT8188_VDO1_MERGE4_SOUT_SEL, GENMASK(3, 0),
> +		MT8188_MERGE4_SOUT_TO_DP_INTF0_SEL
> +	}
> +};
> +
>   #endif /* __SOC_MEDIATEK_MT8188_MMSYS_H */
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 9619faa796e8..3a81ef2bcc3c 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -89,6 +89,15 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
>   	.num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
>   };
> 
> +static const struct mtk_mmsys_driver_data mt8188_vdosys1_driver_data = {
> +	.clk_driver = "clk-mt8188-vdo1",
> +	.routes = mmsys_mt8188_vdo1_routing_table,
> +	.num_routes = ARRAY_SIZE(mmsys_mt8188_vdo1_routing_table),
> +	.sw0_rst_offset = MT8188_VDO1_SW0_RST_B,
> +	.num_resets = 96,
> +	.vsync_len = 1,
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8192-mm",
>   	.routes = mmsys_mt8192_routing_table,
> @@ -213,6 +222,9 @@ void mtk_mmsys_mixer_in_config(struct device *dev, int idx, bool alpha_sel, u16
>   			      alpha_sel << (19 + idx), cmdq_pkt);
>   	mtk_mmsys_update_bits(mmsys, MT8195_VDO1_MIXER_IN1_PAD + (idx - 1) * 4,
>   			      GENMASK(31, 16) | GENMASK(1, 0), biwidth << 16 | mode, cmdq_pkt);
> +	if (mmsys->data->vsync_len)
> +		mtk_mmsys_update_bits(mmsys, MT8188_VDO1_MIXER_VSYNC_LEN, ~0,
> +				      mmsys->data->vsync_len, cmdq_pkt);
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_mixer_in_config);
> 
> @@ -431,6 +443,7 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   	{ .compatible = "mediatek,mt8183-mmsys", .data = &mt8183_mmsys_driver_data },
>   	{ .compatible = "mediatek,mt8186-mmsys", .data = &mt8186_mmsys_driver_data },
>   	{ .compatible = "mediatek,mt8188-vdosys0", .data = &mt8188_vdosys0_driver_data },
> +	{ .compatible = "mediatek,mt8188-vdosys1", .data = &mt8188_vdosys1_driver_data },
>   	{ .compatible = "mediatek,mt8192-mmsys", .data = &mt8192_mmsys_driver_data },
>   	/* "mediatek,mt8195-mmsys" compatible is deprecated */
>   	{ .compatible = "mediatek,mt8195-mmsys", .data = &mt8195_vdosys0_driver_data },
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index 6725403d2e3a..e4ab46017430 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -86,6 +86,34 @@ struct mtk_mmsys_routes {
>   	u32 val;
>   };
> 
> +/**
> + * struct mtk_mmsys_driver_data - settings for the mmsys
> + * @clk_driver: Clock driver name that the mmsys is using
> + *              (defined in drivers/clk/mediatek/clk-*.c).
> + * @routes: Routing table of the mmsys.
> + *          It provides mux settings from one module to another.
> + * @num_routes: Array size of the routes.
> + * @sw0_rst_offset: Register offset for the reset control.
> + * @num_resets: Number of reset bits that are defined
> + * @is_vppsys: Whether the mmsys is VPPSYS (Video Processing Pipe)
> + *             or VDOSYS (Video). Only VDOSYS needs to be added to drm driver.
> + * @vsync_len: VSYNC length of the MIXER.
> + *             VSYNC is usually triggered by the connector, so its length is
> + *             a fixed value as long as the frame rate is decided, but ETDHR and
> + *             MIXER generate their own VSYNC due to hardware design, therefore
> + *             MIXER has to sync with ETHDR by adjusting VSYNC length.
> + *             On MT8195, there is no such setting so we use the gap between
> + *             falling edge and rising edge of SOF (Start of Frame) signal to
> + *             do the job, but since MT8188, VSNYC_LEN setting is introduced to
> + *             solve the problem and is given 0x40 (ticks) as the default value.
> + *             Please notice that this value has to be set to 1 (minimum) if
> + *             ETHDR is bypassed, otherwise MIXER could wait too long and causing
> + *             underflow.
> + *
> + * Each MMSYS (multi-media system) may have different settings, they may use
> + * different clock sources, mux settings, reset control ...etc., and these
> + * differences are all stored here.
> + */
>   struct mtk_mmsys_driver_data {
>   	const char *clk_driver;
>   	const struct mtk_mmsys_routes *routes;
> @@ -93,6 +121,7 @@ struct mtk_mmsys_driver_data {
>   	const u16 sw0_rst_offset;
>   	const u32 num_resets;
>   	const bool is_vppsys;
> +	const u8 vsync_len;
>   };
> 
>   /*
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index 26f3d9a41496..11dda20eb462 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -134,6 +134,22 @@
>   #define MT8188_MUTEX_MOD_DISP_POSTMASK0		24
>   #define MT8188_MUTEX_MOD2_DISP_PWM0		33
> 
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA0	0
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA1	1
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA2	2
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA3	3
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA4	4
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA5	5
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA6	6
> +#define MT8188_MUTEX_MOD_DISP1_MDP_RDMA7	7
> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE0	20
> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE1	21
> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE2	22
> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE3	23
> +#define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
> +#define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
> +#define MT8188_MUTEX_MOD_DISP1_DP_INTF1		39
> +
>   #define MT8195_MUTEX_MOD_DISP_OVL0		0
>   #define MT8195_MUTEX_MOD_DISP_WDMA0		1
>   #define MT8195_MUTEX_MOD_DISP_RDMA0		2
> @@ -265,6 +281,7 @@
>   #define MT8183_MUTEX_SOF_DPI0			2
>   #define MT8188_MUTEX_SOF_DSI0			1
>   #define MT8188_MUTEX_SOF_DP_INTF0		3
> +#define MT8188_MUTEX_SOF_DP_INTF1		4
>   #define MT8195_MUTEX_SOF_DSI0			1
>   #define MT8195_MUTEX_SOF_DSI1			2
>   #define MT8195_MUTEX_SOF_DP_INTF0		3
> @@ -276,6 +293,7 @@
>   #define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
>   #define MT8188_MUTEX_EOF_DSI0			(MT8188_MUTEX_SOF_DSI0 << 7)
>   #define MT8188_MUTEX_EOF_DP_INTF0		(MT8188_MUTEX_SOF_DP_INTF0 << 7)
> +#define MT8188_MUTEX_EOF_DP_INTF1		(MT8188_MUTEX_SOF_DP_INTF1 << 7)
>   #define MT8195_MUTEX_EOF_DSI0			(MT8195_MUTEX_SOF_DSI0 << 7)
>   #define MT8195_MUTEX_EOF_DSI1			(MT8195_MUTEX_SOF_DSI1 << 7)
>   #define MT8195_MUTEX_EOF_DP_INTF0		(MT8195_MUTEX_SOF_DP_INTF0 << 7)
> @@ -446,6 +464,21 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
>   	[DDP_COMPONENT_DSI0] = MT8188_MUTEX_MOD_DISP_DSI0,
>   	[DDP_COMPONENT_PWM0] = MT8188_MUTEX_MOD2_DISP_PWM0,
>   	[DDP_COMPONENT_DP_INTF0] = MT8188_MUTEX_MOD_DISP_DP_INTF0,
> +	[DDP_COMPONENT_MDP_RDMA0] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA0,
> +	[DDP_COMPONENT_MDP_RDMA1] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA1,
> +	[DDP_COMPONENT_MDP_RDMA2] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA2,
> +	[DDP_COMPONENT_MDP_RDMA3] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA3,
> +	[DDP_COMPONENT_MDP_RDMA4] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA4,
> +	[DDP_COMPONENT_MDP_RDMA5] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA5,
> +	[DDP_COMPONENT_MDP_RDMA6] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA6,
> +	[DDP_COMPONENT_MDP_RDMA7] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA7,
> +	[DDP_COMPONENT_MERGE1] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE0,
> +	[DDP_COMPONENT_MERGE2] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE1,
> +	[DDP_COMPONENT_MERGE3] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE2,
> +	[DDP_COMPONENT_MERGE4] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE3,
> +	[DDP_COMPONENT_ETHDR_MIXER] = MT8188_MUTEX_MOD_DISP1_DISP_MIXER,
> +	[DDP_COMPONENT_MERGE5] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
> +	[DDP_COMPONENT_DP_INTF1] = MT8188_MUTEX_MOD_DISP1_DP_INTF1,
>   };
> 
>   static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
> @@ -606,6 +639,8 @@ static const unsigned int mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
>   		MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
>   	[MUTEX_SOF_DP_INTF0] =
>   		MT8188_MUTEX_SOF_DP_INTF0 | MT8188_MUTEX_EOF_DP_INTF0,
> +	[MUTEX_SOF_DP_INTF1] =
> +		MT8188_MUTEX_SOF_DP_INTF1 | MT8188_MUTEX_EOF_DP_INTF1,
>   };
> 
>   static const unsigned int mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
> --
> 2.18.0
> 

