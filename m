Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BC172F81F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbjFNInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbjFNInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:43:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E11B2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:43:10 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BADD46606F40;
        Wed, 14 Jun 2023 09:43:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686732189;
        bh=uViAY2Cm1gbmVlveITw/e/9a22hLrYLFv1lSuHg22gQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nI21QgcyQ2imTOZIMOYrCjeVJ7nBsbAWXFhdh3O777fcKK4wKEJDqzkPVa6kmfJZu
         o1bxl+Hc0FgXjJZWpWlTxDhX7T6zx8EbQSTgWX4Hc/qHqpGR/t9w5213mLC1iv+jBj
         AIk8lObjSXFYonOjeqhl5C6QZP8UnmgjAWW1jYhDwlZGQBPzo4W+vzRIAY0vzDEhLO
         1qNaJn6Y5eA43oQY9it13C4N9lYEABzhtuAu7GYnEQgWRF5wo1BMVxL6GH/zKEaU6P
         KzLiNGDsSWGM7n86zJBWIQ5OSE8p9aHv5v6fvHBvmcLsgHDmYyKQuaNTbmkNNDqxk5
         /Y8HiSdBobZUA==
Message-ID: <bea69aca-50c2-8b65-4c72-7caaed7e50d1@collabora.com>
Date:   Wed, 14 Jun 2023 10:43:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/4] drm/mediatek: Remove freeing not dynamic allocated
 memory
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230613113210.24949-1-jason-jh.lin@mediatek.com>
 <20230613113210.24949-2-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230613113210.24949-2-jason-jh.lin@mediatek.com>
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

Il 13/06/23 13:32, Jason-JH.Lin ha scritto:
> Fixing the coverity issue of:
> mtk_drm_cmdq_pkt_destroy frees address of mtk_crtc->cmdq_handle
> 
> So remove the free function.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Fixes: 7627122fd1c0 ("drm/mediatek: Add cmdq_handle in mtk_crtc")

Fixes tag goes before your S-o-b tag.

Anyway,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index d40142842f85..8d44f3df116f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -116,10 +116,9 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
>   	dma_addr_t dma_addr;
>   
>   	pkt->va_base = kzalloc(size, GFP_KERNEL);
> -	if (!pkt->va_base) {
> -		kfree(pkt);
> +	if (!pkt->va_base)
>   		return -ENOMEM;
> -	}
> +
>   	pkt->buf_size = size;
>   	pkt->cl = (void *)client;
>   
> @@ -129,7 +128,6 @@ static int mtk_drm_cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt *
>   	if (dma_mapping_error(dev, dma_addr)) {
>   		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
>   		kfree(pkt->va_base);
> -		kfree(pkt);
>   		return -ENOMEM;
>   	}
>   
> @@ -145,7 +143,6 @@ static void mtk_drm_cmdq_pkt_destroy(struct cmdq_pkt *pkt)
>   	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
>   			 DMA_TO_DEVICE);
>   	kfree(pkt->va_base);
> -	kfree(pkt);
>   }
>   #endif
>   


