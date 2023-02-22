Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF51F69F2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjBVKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:44:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjBVKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:44:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1837B53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 02:44:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D9E76600864;
        Wed, 22 Feb 2023 10:44:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677062646;
        bh=2c2NjaUUjpoZ9sAYskn4chLZb1xFyWpgbPXg/Yf9Ihw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ltbA5xeVzjRT6lsN6jY1JhI/67FS776M26GCLglPecv2wIsthsOsCOXE5DgZS5kOI
         eC690RY+xGt9Q61oMOyvJbruXY3ZUzux9IKejP5bR4SQ1uGhzXwTUV8Uw9wFZtxBzE
         HeCxYsfMH1dJGgR6B+46Vajro0HABA+F9aqwzH5krNM03PpH9WhpsCuiFaODeJFA0s
         6VBegZwTykG9r1lFljFUI3VWru+X3nq/3BgXnWFZAm+u06opTtfxZoJGQJ7rOlP+B7
         u5nmcxjKqvmzGGfmoAl8jeXr42bf/dWJD4sGvH+kWwdqdPDuAg7nNf88Hy/jWJPpBn
         WIeQFz78C98Nw==
Message-ID: <24f7dcf8-4f65-d397-b080-30840536012b@collabora.com>
Date:   Wed, 22 Feb 2023 11:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 1/2] drm/mediatek: change mmsys compatible for mt8195
 mediatek-drm
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221227074759.5216-1-jason-jh.lin@mediatek.com>
 <20221227074759.5216-2-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221227074759.5216-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/12/22 08:47, Jason-JH.Lin ha scritto:
> Because compatible of mt8195 is changing from "mediatek,mt8195-mmsys"
> to "mediatek,mt8195-vdosys0".
> 
> We have to revert the multiple compatible finding function and
> add driver data of mt8195 vdosys0 to mediatek-drm and the sub driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c |   6 ++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 128 +++--------------------
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h   |   6 --
>   3 files changed, 20 insertions(+), 120 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 0ec2e4049e07..66cdd0bc1311 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -370,6 +370,10 @@ static const struct mtk_disp_rdma_data mt8183_rdma_driver_data = {
>   	.fifo_size = 5 * SZ_1K,
>   };
>   
> +static const struct mtk_disp_rdma_data mt8192_rdma_driver_data = {
> +	.fifo_size = 5 * SZ_1K,
> +};
> +
>   static const struct mtk_disp_rdma_data mt8195_rdma_driver_data = {
>   	.fifo_size = 1920,
>   };
> @@ -381,6 +385,8 @@ static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
>   	  .data = &mt8173_rdma_driver_data},
>   	{ .compatible = "mediatek,mt8183-disp-rdma",
>   	  .data = &mt8183_rdma_driver_data},
> +	{ .compatible = "mediatek,mt8192-disp-rdma",
> +	  .data = &mt8192_rdma_driver_data},
>   	{ .compatible = "mediatek,mt8195-disp-rdma",
>   	  .data = &mt8195_rdma_driver_data},
>   	{},

Can you please drop unrelated changes in mtk_disp_rdma.c and send a v8?
We should aim to get this entire thing (8195 vdosys1) finally upstream.


After dropping mtk_disp_rdma.c changes:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


