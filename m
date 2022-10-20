Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6511E6059F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiJTIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 04:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiJTId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 04:33:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496318D469;
        Thu, 20 Oct 2022 01:33:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 685AB66023A2;
        Thu, 20 Oct 2022 09:33:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666254832;
        bh=eYxMz6zERQc7GTytaTxwkwMkEwSbrxhut31+a3wEpqo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=McX7Tn5gyIzVRQETcl61spVTpz7+tpl7vReaL79clhy9oI8LNQw/BCnp1mCRLEMj2
         UoppxK88l1oNtHXEjz0UChsVJk01qesYhOaTWdyiwoHbeu+55JW2XeTZFGInqr34KU
         Fdh4tOwi6HLmiLrcLP4wD5aw6Cl/UpxzuAAfdbtCxbbFdmiWeX6fvJ8h2NQjXJ3Qut
         AEh3lX/7PKynaZ61blx05q9pnsR9QTfB/i5lxK9+JeFVu7kvL781F+O/XXRaBk6ey4
         e2SVZ02BqzwUIUV5tgxg60vCcQwR+h5FYkQDkJiCOTZxKjlZDPzWU5ttZ3C6l6CcpR
         zqXswuAhJclyQ==
Message-ID: <3e20104a-674a-666a-10b4-4a19abeabc9a@collabora.com>
Date:   Thu, 20 Oct 2022 10:33:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH,2/2] drm: mediatek: Add mt8188 dpi compatibles and
 platform data
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1666249553-15801-1-git-send-email-xinlei.lee@mediatek.com>
 <1666249553-15801-3-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1666249553-15801-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/10/22 09:05, xinlei.lee@mediatek.com ha scritto:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> For MT8188, the vdosys0 only supports 1T1P mode, so we need to add the compatible for mt8188 edp-intf.
> 
> Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c     | 17 +++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 508a6d9..5cefda4 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -929,6 +929,20 @@ static const struct mtk_dpi_conf mt8183_conf = {
>   	.csc_enable_bit = CSC_ENABLE,
>   };
>   
> +static const struct mtk_dpi_conf mt8188_edpintf_conf = {
> +	.cal_factor = mt8195_dpintf_calculate_factor,
> +	.max_clock_khz = 600000,
> +	.output_fmts = mt8195_output_fmts,
> +	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
> +	.pixels_per_iter = 4,
> +	.input_2pixel = false,
> +	.dimension_mask = DPINTF_HPW_MASK,
> +	.hvsize_mask = DPINTF_HSIZE_MASK,
> +	.channel_swap_shift = DPINTF_CH_SWAP,
> +	.yuv422_en_bit = DPINTF_YUV422_EN,
> +	.csc_enable_bit = DPINTF_CSC_ENABLE,
> +};
> +
>   static const struct mtk_dpi_conf mt8192_conf = {
>   	.cal_factor = mt8183_calculate_factor,
>   	.reg_h_fre_con = 0xe0,
> @@ -1079,6 +1093,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
>   	{ .compatible = "mediatek,mt8183-dpi",
>   	  .data = &mt8183_conf,
>   	},
> +	{ .compatible = "mediatek,mt8188-edp-intf",
> +	  .data = &mt8188_edpintf_conf,

Please rename to:

mediatek,mt8188-dp-intf

and

&mt8188_dpintf_conf

> +	},
>   	{ .compatible = "mediatek,mt8192-dpi",
>   	  .data = &mt8192_conf,
>   	},
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 91f58db..5732ed8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -631,6 +631,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DPI },
>   	{ .compatible = "mediatek,mt8183-dpi",
>   	  .data = (void *)MTK_DPI },
> +	{ .compatible = "mediatek,mt8188-edp-intf",

Same here.

Regards,
Angelo

