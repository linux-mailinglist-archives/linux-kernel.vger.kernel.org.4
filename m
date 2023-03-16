Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11036BCCB0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCPKZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCPKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:25:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E5BCFDC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:24:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA64E660309D;
        Thu, 16 Mar 2023 10:24:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962261;
        bh=JdVoGCJf3Q6s6CvpqfATsO0IIiTbtHaPsLAGORiICLQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ShTG0J1nBkA8ToOcGv0l67RQRBXFzu6DU+cCCVS2R+PFfiYGglc452pngu7LtW+VL
         gBnyae7I0t5brIbuJLL01km4PdI3lkTX11Bn8Eb4eg8/SfEdHwtxLwFar1klM3CWPj
         bGDClkcQiJIFpQJEH3ZV5CaVFZDjhYZziCL0kYncNOnxWpNMH3nPu4yYGPQ3mOGLID
         yosnUYg6CG6RyY1YfGOm/v/IwzQxBA5zGgWkKxn5jYi1ul9RIlwzKkbGg/2Xo2rrUI
         DZaUZ8HoFb/EYP1p1QxPAdw0Q0ZA5/seX+eXnCqKUzJwpU1jvf1Rwt/xA9yKKtcpf7
         wX3DR3MZIDI3g==
Message-ID: <4a398efe-af02-b1b6-1617-5537fc490bd7@collabora.com>
Date:   Thu, 16 Mar 2023 11:24:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] iommu/mediatek: Set dma_mask for PGTABLE_PA_35_EN
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        Yunfei Wang <yf.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230316101445.12443-1-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230316101445.12443-1-yong.wu@mediatek.com>
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

Il 16/03/23 11:14, Yong Wu ha scritto:
> When we enable PGTABLE_PA_35_EN, the PA for pgtable may be 35bits.
> Thus add dma_mask for it.
> 
> Fixes: 301c3ca12576 ("iommu/mediatek: Allow page table PA up to 35bit")
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v3: Sorry for a typo. Change from "if (!ret)" to "if (ret)".

I was just about to make you notice. Glad you've fixed that promptly and before
giving me a chance to complain! :-P

Good job!

Cheers,
Angelo

> 
> v2: Just move this out from mt8188 series. Nothing change.
> 
> v1: https://lore.kernel.org/linux-mediatek/20230307080555.14399-3-yong.wu@mediatek.com/
> ---
>   drivers/iommu/mtk_iommu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index d5a4955910ff..6a00ce208dc2 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1258,6 +1258,14 @@ static int mtk_iommu_probe(struct platform_device *pdev)
>   			return PTR_ERR(data->bclk);
>   	}
>   
> +	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN)) {
> +		ret = dma_set_mask(dev, DMA_BIT_MASK(35));
> +		if (ret) {
> +			dev_err(dev, "Failed to set dma_mask 35.\n");
> +			return ret;
> +		}
> +	}
> +
>   	pm_runtime_enable(dev);
>   
>   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {

