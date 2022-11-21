Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4C632C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiKUS1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKUS0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:26:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8993D02FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:26:29 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id t4so9074110wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYY1WGUlFu3LHEknIjWYzHC9m3GxRypTmJeMZynpmoc=;
        b=BMpPUpy1dbUannUvVn81D+zgHMQqJrxbhFO0RaRdh0Sr2YdIiA8qWiPQId/7e86XyE
         UKKUu8FAasA4QhntkdxzK6hhIhw2Kyqdm1ZJxNmD6FLO3b+MiBmFfhiPmmRSr+f6PU2f
         U96ThI8i28vUX0MA1CYwx1GN1Rx7gHILRlCGpDLmSZYh4q1avVqgRxj7HITGxyOb99LI
         aw0mYNug5f9Z8SKZ27Q7XEdzI+xIiJlm9oOprr7CHODuhS5UdqbgS0as/Qrjda6m/Fxc
         Lo83yKRtFrFkCXhVWnr0wxarEA1dXcPtxNAgS0WmPCitqVYJjqv+DJ1dVG00vmQ6oJUW
         RDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYY1WGUlFu3LHEknIjWYzHC9m3GxRypTmJeMZynpmoc=;
        b=xR4QPVK0Pg8fakI+L9mUucqCqxgbHgi3Q5E5vWJQpbC84lH0/nXb6ezK1fuFGCsmGB
         +n/dVyVuGX6k6DgLWNIgmtLm8/cEA/36pT9qavUE90YspS9XIytmmHMRi7FM6twOU6w8
         oCB1HBOMT5WSPJclDJ1tMT+2E04eIFxFPh9I+tRX0u4YCm9rOAaiM+f3/mjqLbCvua2K
         qHPB58EdP+u1E6L4qFfb2v/2EjgEwaK7BjzefvArYV+1XfZlwKT4IcynvlpdSMLQRMWP
         HptVnG3ececSsE6mY+dZnBP7qlK50GaRet76hflmox08EG6d/fWOAUb/sTzkk3eOD7m5
         Ee0w==
X-Gm-Message-State: ANoB5pnMY5rL+JIwKnaB9nJh83kVo5/Beq0qPmqjSqdGO86uqU0AmD1T
        kpebE8/G/2TVSzv9OLrld9g=
X-Google-Smtp-Source: AA0mqf6yCGhkec2FBMPTt/xEGxj7cTO8UY/s4IB/NjHb8m/jA+PTdyj33+oFLraPa4pI+obZxpLhXA==
X-Received: by 2002:a05:600c:4f93:b0:3cf:a616:ccc0 with SMTP id n19-20020a05600c4f9300b003cfa616ccc0mr17700691wmq.73.1669055188375;
        Mon, 21 Nov 2022 10:26:28 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j39-20020a05600c1c2700b003cf57329221sm20867065wms.14.2022.11.21.10.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 10:26:26 -0800 (PST)
Message-ID: <d7afdf50-0e8c-4954-d3f8-1d8890e70a24@gmail.com>
Date:   Mon, 21 Nov 2022 19:26:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v13,2/3] drm: mediatek: Set dpi format in mmsys
Content-Language: en-US
To:     xinlei.lee@mediatek.com, rex-bc.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        nfraprado@collabora.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
References: <1666577099-3859-1-git-send-email-xinlei.lee@mediatek.com>
 <1666577099-3859-3-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1666577099-3859-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2022 04:04, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Dpi output needs to adjust the output format to dual edge for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

I realized that I took this patch by error. I'll drop it from my tree now.

Regards,
Matthias

> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 630a4e301ef6..ad87ecddf58d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -15,6 +15,7 @@
>   #include <linux/of_graph.h>
>   #include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk-mmsys.h>
>   #include <linux/types.h>
>   
>   #include <video/videomode.h>
> @@ -30,6 +31,7 @@
>   #include "mtk_disp_drv.h"
>   #include "mtk_dpi_regs.h"
>   #include "mtk_drm_ddp_comp.h"
> +#include "mtk_drm_drv.h"
>   
>   enum mtk_dpi_out_bit_num {
>   	MTK_DPI_OUT_BIT_NUM_8BITS,
> @@ -67,6 +69,7 @@ struct mtk_dpi {
>   	struct drm_connector *connector;
>   	void __iomem *regs;
>   	struct device *dev;
> +	struct device *mmsys_dev;
>   	struct clk *engine_clk;
>   	struct clk *pixel_clk;
>   	struct clk *tvd_clk;
> @@ -135,6 +138,7 @@ struct mtk_dpi_yc_limit {
>    * @yuv422_en_bit: Enable bit of yuv422.
>    * @csc_enable_bit: Enable bit of CSC.
>    * @pixels_per_iter: Quantity of transferred pixels per iteration.
> + * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be set in MMSYS.
>    */
>   struct mtk_dpi_conf {
>   	unsigned int (*cal_factor)(int clock);
> @@ -153,6 +157,7 @@ struct mtk_dpi_conf {
>   	u32 yuv422_en_bit;
>   	u32 csc_enable_bit;
>   	u32 pixels_per_iter;
> +	bool edge_cfg_in_mmsys;
>   };
>   
>   static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
> @@ -449,8 +454,12 @@ static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
>   		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
>   			     dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE ?
>   			     EDGE_SEL : 0, EDGE_SEL);
> +		if (dpi->conf->edge_cfg_in_mmsys)
> +			mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, MTK_DPI_RGB888_DDR_CON);
>   	} else {
>   		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, 0);
> +		if (dpi->conf->edge_cfg_in_mmsys)
> +			mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, MTK_DPI_RGB888_SDR_CON);
>   	}
>   }
>   
> @@ -778,8 +787,10 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
>   {
>   	struct mtk_dpi *dpi = dev_get_drvdata(dev);
>   	struct drm_device *drm_dev = data;
> +	struct mtk_drm_private *priv = drm_dev->dev_private;
>   	int ret;
>   
> +	dpi->mmsys_dev = priv->mmsys_dev;
>   	ret = drm_simple_encoder_init(drm_dev, &dpi->encoder,
>   				      DRM_MODE_ENCODER_TMDS);
>   	if (ret) {
