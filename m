Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D755BF2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbiIUBmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiIUBmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:42:23 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259FE6F547
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:42:22 -0700 (PDT)
X-UUID: 703dd3b6f24f4de180f0f2fec3804f80-20220921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Tq90Bjfg+TXQMaLmpe7Z9PksYm21CzY8e2ZRrswIE1c=;
        b=TbJkAo0lFb2YdwsxSPun9J9GY/nP7bVSreLJ/ZHI5T82b/0CnpQ6vb5n3TDGFmz7PLst8DA4deI+435YzCxFryEPBqD9NTGC5kgwz4jrIofgqw3B1UOtnMuAxhbuaAsi+e6joFghllE9XVeoi8bWrNGEMJlU+H5OugCzmlWCFgI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:521f5ee7-3bc0-4eb5-b297-b0eac02453ca,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:521f5ee7-3bc0-4eb5-b297-b0eac02453ca,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:942517f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220921093536M8MG0DJ5,BulkQuantity:67,Recheck:0,SF:28|17|19|48,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:41,QS:nil,BEC:nil,COL:0
X-UUID: 703dd3b6f24f4de180f0f2fec3804f80-20220921
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1013596175; Wed, 21 Sep 2022 09:42:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 21 Sep 2022 09:42:15 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 21 Sep 2022 09:42:15 +0800
Message-ID: <9f27f3c589c538319f9383cf284226b52209524d.camel@mediatek.com>
Subject: Re: [PATCH v6,3/3] drm: mediatek: Add mt8186 dpi compatible to
 mtk_dpi.c
From:   CK Hu <ck.hu@mediatek.com>
To:     <xinlei.lee@mediatek.com>, <matthias.bgg@gmail.com>,
        <jason-jh.lin@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <p.zabel@pengutronix.de>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jitao.shi@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 21 Sep 2022 09:42:15 +0800
In-Reply-To: <1663161662-1598-4-git-send-email-xinlei.lee@mediatek.com>
References: <1663161662-1598-1-git-send-email-xinlei.lee@mediatek.com>
         <1663161662-1598-4-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xinlei:

On Wed, 2022-09-14 at 21:21 +0800, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add the compatible because use edge_cfg_in_mmsys in mt8186.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c     | 21 +++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 6e02f02f163c..52bcc4114afd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -942,6 +942,24 @@ static const struct mtk_dpi_conf mt8183_conf = {
>  	.csc_enable_bit = CSC_ENABLE,
>  };
>  
> +static const struct mtk_dpi_conf mt8186_conf = {
> +	.cal_factor = mt8183_calculate_factor,
> +	.reg_h_fre_con = 0xe0,
> +	.max_clock_khz = 150000,
> +	.output_fmts = mt8183_output_fmts,
> +	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
> +	.edge_cfg_in_mmsys = true,

According to the previous review, edge_cfg_in_mmsys is not necessary,
so mt8186_conf is identical to mt8192_conf.

Regards,
CK

> +	.pixels_per_iter = 1,
> +	.is_ck_de_pol = true,
> +	.swap_input_support = true,
> +	.support_direct_pin = true,
> +	.dimension_mask = HPW_MASK,
> +	.hvsize_mask = HSIZE_MASK,
> +	.channel_swap_shift = CH_SWAP,
> +	.yuv422_en_bit = YUV422_EN,
> +	.csc_enable_bit = CSC_ENABLE,
> +};
> +
>  static const struct mtk_dpi_conf mt8192_conf = {
>  	.cal_factor = mt8183_calculate_factor,
>  	.reg_h_fre_con = 0xe0,
> @@ -1092,6 +1110,9 @@ static const struct of_device_id
> mtk_dpi_of_ids[] = {
>  	{ .compatible = "mediatek,mt8183-dpi",
>  	  .data = &mt8183_conf,
>  	},
> +	{ .compatible = "mediatek,mt8186-dpi",
> +	  .data = &mt8186_conf,
> +	},
>  	{ .compatible = "mediatek,mt8192-dpi",
>  	  .data = &mt8192_conf,
>  	},
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 546b79412815..3d32fbc66ac1 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -646,6 +646,8 @@ static const struct of_device_id
> mtk_ddp_comp_dt_ids[] = {
>  	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8183-dpi",
>  	  .data = (void *)MTK_DPI },
> +	{ .compatible = "mediatek,mt8186-dpi",
> +	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8192-dpi",
>  	  .data = (void *)MTK_DPI },
>  	{ .compatible = "mediatek,mt8195-dp-intf",

