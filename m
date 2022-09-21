Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B65BF2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiIUBfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiIUBfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:35:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C74D4FC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:35:39 -0700 (PDT)
X-UUID: 5b6aa906dd8e4244b5d75bd58c3bb2b6-20220921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=51K6Jn+TjrZy99Tw3yXtrCTM6sMA3NQF9UYRankQZFk=;
        b=FIgupq7kNnozk0t9HhjtvmVsdd886Lm2HVmAIqwzNsjtT8bkgA4io6ZlbVraSX1x/zghI4B8mYUB3z8z9Mk1/1J4Jk9BbbGsDWz/8nLNaes3ZOdZa+L+X+e7J+yKPbKvZ6ioPfS4keccQILzBihGo9mFSGy4UGrP7W/IM2cZT3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:0a4f56bf-08c5-4ccd-8aa7-c7de12904823,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.11,REQID:0a4f56bf-08c5-4ccd-8aa7-c7de12904823,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:39a5ff1,CLOUDID:16df16f7-6e85-48d9-afd8-0504bbfe04cb,B
        ulkID:220921093536M8MG0DJ5,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
        ,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
        :0
X-UUID: 5b6aa906dd8e4244b5d75bd58c3bb2b6-20220921
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1109342403; Wed, 21 Sep 2022 09:35:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 21 Sep 2022 09:35:31 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 21 Sep 2022 09:35:31 +0800
Message-ID: <6c3de76f1ecf5fb0f4e96469738d383e89cb0eca.camel@mediatek.com>
Subject: Re: [PATCH v6,2/3] drm: mediatek: Adjust the dpi output format to
 MT8186
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
Date:   Wed, 21 Sep 2022 09:35:31 +0800
In-Reply-To: <1663161662-1598-3-git-send-email-xinlei.lee@mediatek.com>
References: <1663161662-1598-1-git-send-email-xinlei.lee@mediatek.com>
         <1663161662-1598-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
> Dpi output needs to adjust the output format to dual edge for MT8186.
> The bridge ic on MT8186 uses the output format of RGB888_dual_edge. 

I think different sink ic may support different output format, so query
the sink information to decide which outout format.

> Due
> to hardware changes, we need to modify the output format
> corresponding
> to the mmsys register.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nís F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index fb0b79704636..6e02f02f163c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -14,6 +14,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>  #include <linux/types.h>
>  
>  #include <video/videomode.h>
> @@ -28,6 +29,7 @@
>  #include "mtk_disp_drv.h"
>  #include "mtk_dpi_regs.h"
>  #include "mtk_drm_ddp_comp.h"
> +#include "mtk_drm_drv.h"
>  
>  enum mtk_dpi_out_bit_num {
>  	MTK_DPI_OUT_BIT_NUM_8BITS,
> @@ -58,6 +60,11 @@ enum mtk_dpi_out_color_format {
>  	MTK_DPI_COLOR_FORMAT_YCBCR_422
>  };
>  
> +enum mtk_dpi_out_format_con {
> +	MTK_DPI_RGB888_DDR_CON,
> +	MTK_DPI_RGB565_SDR_CON
> +};
> +
>  struct mtk_dpi {
>  	struct drm_encoder encoder;
>  	struct drm_bridge bridge;
> @@ -80,6 +87,7 @@ struct mtk_dpi {
>  	struct pinctrl_state *pins_dpi;
>  	u32 output_fmt;
>  	int refcount;
> +	struct device *mmsys_dev;
>  };
>  
>  static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
> @@ -133,6 +141,7 @@ struct mtk_dpi_yc_limit {
>   * @yuv422_en_bit: Enable bit of yuv422.
>   * @csc_enable_bit: Enable bit of CSC.
>   * @pixels_per_iter: Quantity of transferred pixels per iteration.
> + * @edge_cfg_in_mmsys: If the edge configuration for DPI's output
> needs to be set in MMSYS.
>   */
>  struct mtk_dpi_conf {
>  	unsigned int (*cal_factor)(int clock);
> @@ -151,6 +160,7 @@ struct mtk_dpi_conf {
>  	u32 yuv422_en_bit;
>  	u32 csc_enable_bit;
>  	u32 pixels_per_iter;
> +	bool edge_cfg_in_mmsys;
>  };
>  
>  static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val,
> u32 mask)
> @@ -447,6 +457,8 @@ static void mtk_dpi_dual_edge(struct mtk_dpi
> *dpi)
>  		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
>  			     dpi->output_fmt ==
> MEDIA_BUS_FMT_RGB888_2X12_LE ?
>  			     EDGE_SEL : 0, EDGE_SEL);
> +		if (dpi->conf->edge_cfg_in_mmsys)
> +			mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev,
> MTK_DPI_RGB888_DDR_CON);

Why do you set a DPI driver defined value MTK_DPI_RGB888_DDR_CON into
mmsys driver? I think you should set a value which mmsys driver
understand.

Regards,
CK

>  	} else {
>  		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE,
> 0);
>  	}
> @@ -776,8 +788,10 @@ static int mtk_dpi_bind(struct device *dev,
> struct device *master, void *data)
>  {
>  	struct mtk_dpi *dpi = dev_get_drvdata(dev);
>  	struct drm_device *drm_dev = data;
> +	struct mtk_drm_private *priv = drm_dev->dev_private;
>  	int ret;
>  
> +	dpi->mmsys_dev = priv->mmsys_dev;
>  	ret = drm_simple_encoder_init(drm_dev, &dpi->encoder,
>  				      DRM_MODE_ENCODER_TMDS);
>  	if (ret) {

