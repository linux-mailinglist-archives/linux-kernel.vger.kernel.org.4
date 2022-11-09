Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148E0622710
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiKIJcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbiKIJcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:32:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107E22BDC;
        Wed,  9 Nov 2022 01:32:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B5576602905;
        Wed,  9 Nov 2022 09:32:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667986350;
        bh=aKTpg/ANFcmHZS6rm4S2+2Jpe3Cgbu7viy4fKsSsIpo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O2GvFZIETDdsB/6xrek1ymsjKH5wqdVDFwde5Ddu8gIy5YdTeN8tUODdLJjzy6PgD
         Uq12P/F7sVOWjVUYhVPOQgY/kb5vrxGi/MvMsMYzWKyUSMLMJUI9dJgPap0duXutzA
         FI9bePzzml12R37tj9UUBHs626/WZiTQVqCPz1rkgmKrpwxHCWybwZJGLO3WLFufVG
         eSaYcfJiyyWgZmtBA6dhOq/8YWToduukp2SIGf2anvZCQwENk4mYnUjfpKrShYbKyy
         Lyb9SQB5p0e2h4qsOxB9BDVzm2Kl2CqL66XdBfz0l+49ppZF+YXReXSA3QRyi0T8u8
         EVLwd4yKi0Ncg==
Message-ID: <e3224f98-3f76-ef32-2088-dc7119f080be@collabora.com>
Date:   Wed, 9 Nov 2022 10:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/3] arm64: dts: mt8195: Add video decoder node
Content-Language: en-US
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Rob Herring <robh@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221109073529.26765-1-yunfei.dong@mediatek.com>
 <20221109073529.26765-3-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221109073529.26765-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/11/22 08:35, Yunfei Dong ha scritto:
> Add video decoder node to mt8195 device tree.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
> dtbs_check pass.
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 63 ++++++++++++++++++++++++
>   1 file changed, 63 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..ffabf91d4273 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1874,6 +1874,69 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_CAM>;
>   		};
>   
> +		video-codec@18000000 {
> +			compatible = "mediatek,mt8195-vcodec-dec";
> +			mediatek,scp = <&scp>;
> +			iommus = <&iommu_vdo M4U_PORT_L21_VDEC_MC_EXT>;
> +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			reg = <0 0x18000000 0 0x1000>,      /* VDEC_SYS */
> +			      <0 0x18004000 0 0x1000>;      /* VDEC_RACING_CTRL */

Since we're adding register descriptions to the schema file, you don't need any
comments in front of the iospaces that you're declaring here... this means that
it also fits on one line:
			reg = <0 0x18000000 0 0x1000>, <0 0x18004000 0 0x1000>;

> +			ranges = <0 0 0 0x18000000 0 0x26000>;
> +			clocks = <&topckgen CLK_TOP_VDEC>,
> +			         <&topckgen CLK_TOP_UNIVPLL_D4>;
> +			clock-names = "vdec-sel", "top";
> +			assigned-clocks = <&topckgen CLK_TOP_VDEC>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +
> +			vcodec-lat-soc@2000 {
> +				compatible = "mediatek,mtk-vcodec-lat-soc";
> +				reg = <0 0x2000 0 0x800>;		/* VDEC_MISC */

We can perhaps add descriptions to the schema file for VDEC_MISC as well,
meaning that we don't need that comment as well.

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
> +				reg = <0 0x10000 0 0x800>;		/* VDEC_MISC */

same here

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
> +				reg = <0 0x25000 0 0x1000>;		/* VDEC_CORE_MISC */

...and same here too.

Regards,
Angelo
