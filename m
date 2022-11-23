Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AC2636858
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbiKWSNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbiKWSLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:11:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD0DCEFFB;
        Wed, 23 Nov 2022 10:06:29 -0800 (PST)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 30EBA6600014;
        Wed, 23 Nov 2022 18:06:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669226767;
        bh=VkdBVLf6PQKIQJO5DDFSN1vQB/6ESgX35dSNtG4ynI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgoQBnUGv8ddeQErPYf+crVHXVCMUcSW/khqsSqmcAHWz5do81TouoAdsnSkVM39G
         X6SlkkwTySVDB/MXAcxhF3BdhYQAVzsxzoiBq2k2X3CbiLSGwvYBDO9qItMUotDDXC
         4RgWKv9Flkw6ABTo7Uisva7agqC+oEpvAskzZuZH3w0e+69tWAtV6WzUC7XKxoxmZC
         Kdyw6khXuXR9328AcpzjUi94/YSQo283G5IGMgB//FmFb67+t2vPDsyBjk+n71Gv0l
         zP/3MJkftdobYN8ChJkOyhq7CLlTCQTjiMmTj3QaYFp8FsML4frkA8FPLsHB+myJnZ
         4948FkBNCR0lw==
Date:   Wed, 23 Nov 2022 13:06:00 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Allen-KH Cheng =?utf-8?B?KOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
Subject: Re: [PATCH v2,3/3] arm64: dts: mt8195: Add video decoder node
Message-ID: <20221123180600.a4w5e2jzydwer7h6@notapiano>
References: <20221110102834.8946-1-yunfei.dong@mediatek.com>
 <20221110102834.8946-3-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221110102834.8946-3-yunfei.dong@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:28:34PM +0800, Yunfei Dong wrote:
> Add video decoder node to mt8195 device tree.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> Compared with v1:
> - add description in yaml, and remove /* ... */ for each reg.
> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 63 ++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..3ef7eef02415 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1874,6 +1874,69 @@
>  			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
>  		};
>  
> +		video-codec@18000000 {
> +			compatible = "mediatek,mt8195-vcodec-dec";
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>;
> +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;

Hi,

similarly to what I've commented for the mt8192 node [1], having dma-ranges
on this node causes IOMMU faults on the latest next. Since the iommu is already
used in this node, please drop the dma-ranges property.

The binding will also need updating to remove this property (given it was marked
as required), so please include that change in either your or Allen's series.

+cc Allen

[1] https://lore.kernel.org/all/20221118141039.y2ap7dzdp26ih2la@notapiano

Thanks,
Nícolas

> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			reg = <0 0x18000000 0 0x1000>,
> +			      <0 0x18004000 0 0x1000>;
> +			ranges = <0 0 0 0x18000000 0 0x26000>;
> +			clocks = <&topckgen CLK_TOP_VDEC>,
> +			         <&topckgen CLK_TOP_UNIVPLL_D4>;
> +			clock-names = "vdec-sel", "top";
> +			assigned-clocks = <&topckgen CLK_TOP_VDEC>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +
> +			vcodec-lat-soc@2000 {
> +				compatible = "mediatek,mtk-vcodec-lat-soc";
> +				reg = <0 0x2000 0 0x800>;
> +				iommus = <&iommu_vpp M4U_PORT_L23_VDEC_UFO_ENC_EXT>,
> +					 <&iommu_vpp M4U_PORT_L23_VDEC_RDMA_EXT>;
> +				clocks = <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +					 <&vdecsys_soc CLK_VDEC_SOC_LAT>;
> +				clock-names = "vdec-soc-vdec", "vdec-soc-lat";
> +				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
> +			};
> +
> +			vcodec-lat@10000 {
> +				compatible = "mediatek,mtk-vcodec-lat";
> +				reg = <0 0x10000 0 0x800>;
> +				interrupts = <GIC_SPI 708 IRQ_TYPE_LEVEL_HIGH 0>;
> +				iommus = <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_VLD_EXT>,
> +					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_VLD2_EXT>,
> +					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_AVC_MC_EXT>,
> +					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_PRED_RD_EXT>,
> +					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_TILE_EXT>,
> +					 <&iommu_vdo M4U_PORT_L24_VDEC_LAT0_WDMA_EXT>;
> +				clocks = <&vdecsys_soc CLK_VDEC_SOC_VDEC>,
> +					 <&vdecsys_soc CLK_VDEC_SOC_LAT>;
> +				clock-names = "vdec-soc-vdec", "vdec-soc-lat";
> +				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC0>;
> +			};
> +
> +			vcodec-core@25000 {
> +				compatible = "mediatek,mtk-vcodec-core";
> +				reg = <0 0x25000 0 0x1000>;
> +				interrupts = <GIC_SPI 707 IRQ_TYPE_LEVEL_HIGH 0>;
> +				iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_UFO_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_PP_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_PRED_RD_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_PRED_WR_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_PPWRAP_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_TILE_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_VLD_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_VLD2_EXT>,
> +					 <&iommu_vdo M4U_PORT_L21_VDEC_AVC_MV_EXT>;
> +				clocks = <&vdecsys CLK_VDEC_VDEC>, <&vdecsys CLK_VDEC_LAT>;
> +				clock-names = "vdec-vdec", "vdec-lat";
> +				power-domains = <&spm MT8195_POWER_DOMAIN_VDEC1>;
> +			};
> +		};
> +
>  		larb24: larb@1800d000 {
>  			compatible = "mediatek,mt8195-smi-larb";
>  			reg = <0 0x1800d000 0 0x1000>;
> -- 
> 2.18.0
> 
> 
> 
