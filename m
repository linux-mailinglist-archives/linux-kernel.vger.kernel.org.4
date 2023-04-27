Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB546F059C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjD0MSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243386AbjD0MSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:18:20 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3794EC6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:18:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f917585b26so7689970f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682597883; x=1685189883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1vg4m/VO0MJixxSFQxYroHS6wmKORiBS3+pI5CUOeA=;
        b=h8aWLVXfJoVHByEfH4nDVYZAgF7pCMbFAKULlTJDAvY0i9RXCc8hqvbf1SoACMTFLi
         sGAiE3uURyayj6Q4q5y4S1FWrSwXVGFmAYz2GNFk0GwLD0dRj2EFPMWZiFXoFKbFFV+x
         9P4N5aNiE1wimcUPLnIqgCyeGBfhCvqZm2rmvvhKMVcdZTKNfD17oCoduDcdZZiZj1s0
         j+aDXbU7JtBM71oh2fvNMEw2z/kywg2XahtK/jiAHpBHr7OlyA0YfoznY+2NcrxLqN3B
         F26EQ8CGy4sL9AKzIfy5KPXxMG/Mhr/8ojo+qQpxWiTttAbzxgILJCdZd7oqQXj+Uxmm
         BdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597883; x=1685189883;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1vg4m/VO0MJixxSFQxYroHS6wmKORiBS3+pI5CUOeA=;
        b=RYHvPIP9FmdlvV+0u/nkxfH4bkY0CLGma+n+tRl//0/KLhrO3KG0EMlvyQxUGs8KHy
         KNwq+CHaSxP6V9GRq0aKDiEmlM02wF0VvG0veT1VcSH5ZXeOXp89S6abKMrFfdFzuXyM
         SvLNJaGQMrtv1oR7duORVuIlt4XLpKETTaFNlVK5s4zeePylnP/OyhbLzqqq1+a63XMF
         /c5U32TWqLHhP9d/E/1piNQk7/loIJNbOiOkkK6+Wmek9Xj0rNkyUlUFQzUaZyVzrUnZ
         HmAA3qSmSkoR/l8NTfrxMkdhLt0br8ExYdVNIRGmQWx/Aht+ueE9fTRwLSkpH+LMrXkQ
         y5BA==
X-Gm-Message-State: AC+VfDxkMAYOHdQa0SUgW6tmMYqUqLrTRPTYCTItO7ndqBhYRcPID4N0
        6lD41bWth3BWTVaAZa+6oyY=
X-Google-Smtp-Source: ACHHUZ6XSKZdEQZ82p2Ne5sQayHi/JgjrgiM+HvaVe1sFcjLXkT3Cm1pfdAlTzJEugJrw6il1B3WXQ==
X-Received: by 2002:a5d:40cd:0:b0:2ff:3a63:ed61 with SMTP id b13-20020a5d40cd000000b002ff3a63ed61mr1121516wrq.13.1682597882571;
        Thu, 27 Apr 2023 05:18:02 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b002fe254f6c33sm18366680wrw.92.2023.04.27.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 05:18:01 -0700 (PDT)
Message-ID: <ba23e233-a0a2-c5e9-1a63-497d7dea4814@gmail.com>
Date:   Thu, 27 Apr 2023 14:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/2] drm/mediatek: Add DSI support for mt8188 vdosys0
Content-Language: en-US, ca-ES, es-ES
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Nathan Lu <nathan.lu@mediatek.com>
References: <20230427084040.3651-1-jason-jh.lin@mediatek.com>
 <20230427084040.3651-3-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230427084040.3651-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/04/2023 10:40, Jason-JH.Lin wrote:
> Add DSI as main display output for mt8188 vdosys0.
> 
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h     | 1 +
>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      | 5 +++++
>   drivers/gpu/drm/mediatek/mtk_dsi.c          | 9 +++++++++
>   4 files changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> index 72c57442f965..bf06ccb65652 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> @@ -48,6 +48,7 @@ int mtk_dpi_encoder_index(struct device *dev);
>   
>   void mtk_dsi_ddp_start(struct device *dev);
>   void mtk_dsi_ddp_stop(struct device *dev);
> +int mtk_dsi_encoder_index(struct device *dev);
>   
>   int mtk_gamma_clk_enable(struct device *dev);
>   void mtk_gamma_clk_disable(struct device *dev);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index fe20ce26b19f..214233d36487 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -318,6 +318,7 @@ static const struct mtk_ddp_comp_funcs ddp_dsc = {
>   static const struct mtk_ddp_comp_funcs ddp_dsi = {
>   	.start = mtk_dsi_ddp_start,
>   	.stop = mtk_dsi_ddp_stop,
> +	.encoder_index = mtk_dsi_encoder_index,
>   };
>   
>   static const struct mtk_ddp_comp_funcs ddp_gamma = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index d8c49614a107..7ea4dc87c558 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -191,8 +191,13 @@ static const unsigned int mt8188_mtk_ddp_main_routes_0[] = {
>   	DDP_COMPONENT_DP_INTF0
>   };
>   
> +static const unsigned int mt8188_mtk_ddp_main_routes_1[] = {
> +	DDP_COMPONENT_DSI0
> +};
> +
>   static const struct mtk_drm_route mt8188_mtk_ddp_main_routes[] = {
>   	{0, ARRAY_SIZE(mt8188_mtk_ddp_main_routes_0), mt8188_mtk_ddp_main_routes_0},
> +	{0, ARRAY_SIZE(mt8188_mtk_ddp_main_routes_1), mt8188_mtk_ddp_main_routes_1},
>   };
>   
>   static const unsigned int mt8192_mtk_ddp_main[] = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 7d5250351193..f9d2d5447e2e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -865,6 +865,15 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>   	return ret;
>   }
>   
> +int mtk_dsi_encoder_index(struct device *dev)
> +{
> +	struct mtk_dsi *dsi = dev_get_drvdata(dev);
> +	int encoder_index = drm_encoder_index(&dsi->encoder);
> +
> +	dev_dbg(dev, "encoder index:%d", encoder_index);
> +	return encoder_index;
> +}
> +
>   static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>   {
>   	int ret;
