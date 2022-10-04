Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADA5F42D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJDMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJDMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:17:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1B917E22;
        Tue,  4 Oct 2022 05:17:36 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 84EF166022A5;
        Tue,  4 Oct 2022 13:17:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664885854;
        bh=/tqb9jV5S9BCu2snlkrtd4SvQlYSk2B4MpJZMTyb8Ic=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZoIjkG+3WzJOAHvAUxbOtSXkgMwd0x7ckyCZIC5r2ssKs6m3wlKKo2cp9qQiK3Ik+
         z71YKzkpXh/n4eNPUsNQRWHGLxvJY9u6XNMnFUbQCuYq7jlrkRWvvYzjWXLthI4EWt
         mu+X0FBg0DOwEgmFr1GSMoaQA6TN+v0MxE2gx4yBvlZ/v2PbMk+KKc77ucGGKMR28f
         iZX1iWjnF4e17kZ5MmcYsgaiRFH9RC3N5ynsGMyx57QQnTgGFypvhXlS1X5/1/2pVo
         xUeK75ZxAyqLga+Aa2EBFT5CtcqRJH8PYnmdigKZlf0Qg5swaw5fMNoy8sCQAdA8HB
         7lINPvVQ+wxkw==
Message-ID: <4471ec11-40f6-3d93-e6a7-c746a427e8ca@collabora.com>
Date:   Tue, 4 Oct 2022 14:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 4/6] soc: mediatek: mmsys: add config api for RSZ
 switching and DCM
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
References: <20221004093319.5069-1-moudy.ho@mediatek.com>
 <20221004093319.5069-5-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221004093319.5069-5-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/10/22 11:33, Moudy Ho ha scritto:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> Due to MT8195 HW design, some RSZs have additional settings that
> need to be configured in MMSYS.
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>

Hello Moudy,

please remember that you have to add your Signed-off-by tag to all of the commits
that you're sending, even if you're not the author, otherwise they are not
acceptable.

> ---
>   drivers/soc/mediatek/mt8195-mmsys.h    |  8 ++++++
>   drivers/soc/mediatek/mtk-mmsys.c       | 40 ++++++++++++++++++++++++++
>   include/linux/soc/mediatek/mtk-mmsys.h |  4 +++
>   3 files changed, 52 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8195-mmsys.h b/drivers/soc/mediatek/mt8195-mmsys.h
> index abfe94a30248..e0cf13d09763 100644
> --- a/drivers/soc/mediatek/mt8195-mmsys.h
> +++ b/drivers/soc/mediatek/mt8195-mmsys.h
> @@ -75,6 +75,14 @@
>   #define MT8195_SOUT_DSC_WRAP1_OUT_TO_SINA_VIRTUAL0		(2 << 16)
>   #define MT8195_SOUT_DSC_WRAP1_OUT_TO_VPP_MERGE			(3 << 16)
>   
> +/* VPPSYS1 */
> +#define MT8195_SVPP1_HW_DCM_1ST_DIS0				0x150
> +#define MT8195_SVPP1_HW_DCM_1ST_DIS1				0x160
> +#define MT8195_SVPP1_HW_DCM_2ND_DIS0				0x1a0
> +#define MT8195_SVPP1_HW_DCM_2ND_DIS1				0x1b0
> +#define MT8195_SVPP2_BUF_BF_RSZ_SWITCH				0xf48
> +#define MT8195_SVPP3_BUF_BF_RSZ_SWITCH				0xf74
> +
>   static const struct mtk_mmsys_routes mmsys_mt8195_routing_table[] = {
>   	{
>   		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index c4d15f99f853..c98cfcb7db38 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -261,6 +261,46 @@ void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val)
>   }
>   EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_dpi_fmt_config);
>   
> +void mtk_mmsys_merge_config(struct device *dev, u32 id, bool enable)

void mtk_mmsys_merge_config(struct device *dev, u32 svpp_id, bool enable)

or

void mtk_mmsys_vpp_merge_config(struct device *dev, u32 id, bool enable)

...adding that "svpp" or "vpp" word makes the function easier to understand :-)

> +{
> +	u32 reg;
> +
> +	switch (id) {
> +	case 2:
> +		reg = MT8195_SVPP2_BUF_BF_RSZ_SWITCH;
> +		break;
> +	case 3:
> +		reg = MT8195_SVPP3_BUF_BF_RSZ_SWITCH;
> +		break;
> +	default:
> +		dev_err(dev, "Invalid id %d\n", id);
> +		return;
> +	}
> +
> +	mtk_mmsys_update_bits(dev_get_drvdata(dev), reg, ~0, enable);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mmsys_merge_config);
> +
> +void mtk_mmsys_rsz_dcm_config(struct device *dev, bool enable)

...would be the same here, but only about the function name, so I'd go with
changing the name for both.

> +{
> +	u32 val = 0;
> +
> +	if (enable)
> +		val = BIT(25);

No magic bits please, add a definition for them

> +	mtk_mmsys_update_bits(dev_get_drvdata(dev),
> +			      MT8195_SVPP1_HW_DCM_1ST_DIS0, BIT(25), val);
> +	mtk_mmsys_update_bits(dev_get_drvdata(dev),
> +			      MT8195_SVPP1_HW_DCM_2ND_DIS0, BIT(25), val);
> +
> +	if (enable)
> +		val = (BIT(4) | BIT(5));

same here

> +	mtk_mmsys_update_bits(dev_get_drvdata(dev),
> +			      MT8195_SVPP1_HW_DCM_1ST_DIS1, (BIT(4) | BIT(5)), val);
> +	mtk_mmsys_update_bits(dev_get_drvdata(dev),
> +			      MT8195_SVPP1_HW_DCM_2ND_DIS1, (BIT(4) | BIT(5)), val);
> +}
> +EXPORT_SYMBOL_GPL(mtk_mmsys_rsz_dcm_config);
> +
>   static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
>   				  bool assert)
>   {
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index d2b02bb43768..2d5c7fe920b0 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -67,4 +67,8 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>   
>   void mtk_mmsys_ddp_dpi_fmt_config(struct device *dev, u32 val);
>   
> +void mtk_mmsys_merge_config(struct device *dev, u32 id, bool enable);
> +
> +void mtk_mmsys_rsz_dcm_config(struct device *dev, bool enable);
> +
>   #endif /* __MTK_MMSYS_H */


