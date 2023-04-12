Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379EA6DF89E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjDLOe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjDLOet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BFE9763;
        Wed, 12 Apr 2023 07:34:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB7AB635A9;
        Wed, 12 Apr 2023 14:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C72C433EF;
        Wed, 12 Apr 2023 14:34:30 +0000 (UTC)
Message-ID: <4ae9a945-6cde-8083-432a-94b6b250d88c@xs4all.nl>
Date:   Wed, 12 Apr 2023 16:34:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 11/14] media: mediatek: vcodec: Remove the setting for
 dma_mask
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        nfraprado@collabora.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, Yunfei Dong <yunfei.dong@mediatek.com>,
        kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>,
        chengci.xu@mediatek.com, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        irui wang <irui.wang@mediatek.com>
References: <20230411093144.2690-1-yong.wu@mediatek.com>
 <20230411093144.2690-12-yong.wu@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230411093144.2690-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 11:31, Yong Wu wrote:
> In order to simplify the masters to set their respective dma masks, MTK
> IOMMU helps to centralize the processing. Because all the dma ranges is
> set in IOMMU, IOMMU knows well the dma mask requirements of masters. After
> this patch, the masters(codec here) code does not need care
> dma-ranges/dma_mask related information.
> 
> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: irui wang <irui.wang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans

> ---
>  .../media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c   | 8 --------
>  .../media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c   | 3 ---
>  2 files changed, 11 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 174a6eec2f54..11583405cf61 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -321,14 +321,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL)) {
> -		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
> -		if (ret) {
> -			mtk_v4l2_err("Failed to set mask");
> -			goto err_core_workq;
> -		}
> -	}
> -
>  	for (i = 0; i < MTK_VDEC_HW_MAX; i++)
>  		mutex_init(&dev->dec_mutex[i]);
>  	mutex_init(&dev->dev_mutex);
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> index 9095186d5495..50e5571608cd 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
> @@ -344,9 +344,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>  		goto err_event_workq;
>  	}
>  
> -	if (of_get_property(pdev->dev.of_node, "dma-ranges", NULL))
> -		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
> -
>  	ret = video_register_device(vfd_enc, VFL_TYPE_VIDEO, -1);
>  	if (ret) {
>  		mtk_v4l2_err("Failed to register video device");

