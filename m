Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44F06341DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiKVQtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiKVQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:49:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1215E7298F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:49:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so11742792wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3fcqOHVduVIIg4z4ijk3ykjn2RM3trgK5/ehZ3bY1M=;
        b=GdK7IiaGPYoYt2Cullz/bFXz5P3zaEbhbB2t0ZpbwFzBQeOMMKazdbcRBwospX37Ui
         pqMiIGLcaq9zFfPEICfldvKXfL31lnz0AaqH4lHRW1xbnHaDy/Lg4rdvd7XQjNxtq+ay
         1iqBc+fexaXnaY8vB2aO3JXyzKh/ipGhRImpUWnP3k8BcfmZebvEe4wqfSsUE5LZmN+8
         LmM6RhNUPnWyN7PHzsyFSneAEOivB3ucTrbdj4p7TsX7scxtByO6GWlpXTANw65+rSSo
         fJQ6zBeq9qJWeAL4dyugp+BKONx4Qikr+2fGiGvQOWJomWt9c7/sR/U9dBCEYOn2FDML
         9FtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3fcqOHVduVIIg4z4ijk3ykjn2RM3trgK5/ehZ3bY1M=;
        b=Qq1dhlRTFZN8SiUR3FaC2MfIhTFWOKCW1m03Hk0CGPgCtg60EjbXt2Ji04NqccCkg9
         Ta4ydFcm7G3nSPF9cWNTCrlJisSkmxnzgLhAmavTEgQzZ+BQsoTp9KB20lknoEhCD1qM
         ioMENNbMTXoCSd/8iqqdObrlRKPw68O5LXCa5m3EywidDzn923Oegw5Pq3/54Uqj/RBm
         zyFqiRN+ABuoHULF3EpnKbYPr61vmhEswoyBz5KRfQwde7q+BoDyfdwMbx1XHl2tY6aU
         qFVs5rSgOWX1XMuAF19HQo+zeR7bj43ylwbii3Uc6XVHuEkG85xavskBLqxPPmh29SRp
         rAdw==
X-Gm-Message-State: ANoB5pk30uUiXYkzlS0EUbCdSSYWVrp+P1XNugybtc3tALE82XXrSpG0
        eMEswK0bTpeueFUPWwRiZtA=
X-Google-Smtp-Source: AA0mqf5ZtsT30GoUH/4TBViJcG2p2xVpb/2WXR2KXr7wvrCOOAoP5enGR17CBNRPJryrNLruXod8Yg==
X-Received: by 2002:a05:600c:3590:b0:3d0:1489:78c4 with SMTP id p16-20020a05600c359000b003d0148978c4mr5836156wmq.167.1669135744520;
        Tue, 22 Nov 2022 08:49:04 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d6509000000b0023c8026841csm14497653wru.23.2022.11.22.08.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:49:03 -0800 (PST)
Message-ID: <f51c7f56-4c62-0351-3b01-ae2f6432fb05@gmail.com>
Date:   Tue, 22 Nov 2022 17:49:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/6] iommu/mediatek: Improve safety for mediatek,smi
 property in larb nodes
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com,
        youlin.pei@mediatek.com, anan.sun@mediatek.com,
        xueqi.zhang@mediatek.com, Guenter Roeck <groeck@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20221018024258.19073-1-yong.wu@mediatek.com>
 <20221018024258.19073-6-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/10/2022 04:42, Yong Wu wrote:
> No functional change. Just improve safety from dts.
> 
> All the larbs that connect to one IOMMU must connect with the same
> smi-common. This patch checks all the mediatek,smi property for each
> larb, If their mediatek,smi are different, it will return fails.
> Also avoid there is no available smi-larb nodes.
> 
> Suggested-by: Guenter Roeck <groeck@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 53 +++++++++++++++++++++++++++------------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 9cbff48f03c0..f7ac102e343f 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1042,7 +1042,7 @@ static const struct component_master_ops mtk_iommu_com_ops = {
>   static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
>   				  struct mtk_iommu_data *data)
>   {
> -	struct device_node *larbnode, *smicomm_node, *smi_subcomm_node;
> +	struct device_node *larbnode, *frst_avail_smicomm_node = NULL;
>   	struct platform_device *plarbdev, *pcommdev;
>   	struct device_link *link;
>   	int i, larb_nr, ret;
> @@ -1054,6 +1054,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		return -EINVAL;
>   
>   	for (i = 0; i < larb_nr; i++) {
> +		struct device_node *smicomm_node, *smi_subcomm_node;
>   		u32 id;
>   
>   		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> @@ -1094,27 +1095,47 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			goto err_larbdev_put;
>   		}
>   
> +		/* Get smi-(sub)-common dev from the last larb. */
> +		smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> +		if (!smi_subcomm_node) {
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		}
> +
> +		/*
> +		 * It may have two level smi-common. the node is smi-sub-common if it
> +		 * has a new mediatek,smi property. otherwise it is smi-commmon.
> +		 */
> +		smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
> +		if (smicomm_node)
> +			of_node_put(smi_subcomm_node);
> +		else
> +			smicomm_node = smi_subcomm_node;
> +
> +		/*
> +		 * All the larbs that connect to one IOMMU must connect with the same
> +		 * smi-common.
> +		 */
> +		if (!frst_avail_smicomm_node) {
> +			frst_avail_smicomm_node = smicomm_node;
> +		} else if (frst_avail_smicomm_node != smicomm_node) {
> +			dev_err(dev, "mediatek,smi property is not right @larb%d.", id);
> +			of_node_put(smicomm_node);
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		} else {
> +			of_node_put(smicomm_node);
> +		}
> +
>   		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>   		platform_device_put(plarbdev);
>   	}
>   
> -	/* Get smi-(sub)-common dev from the last larb. */
> -	smi_subcomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
> -	if (!smi_subcomm_node)
> +	if (!frst_avail_smicomm_node)
>   		return -EINVAL;
>   
> -	/*
> -	 * It may have two level smi-common. the node is smi-sub-common if it
> -	 * has a new mediatek,smi property. otherwise it is smi-commmon.
> -	 */
> -	smicomm_node = of_parse_phandle(smi_subcomm_node, "mediatek,smi", 0);
> -	if (smicomm_node)
> -		of_node_put(smi_subcomm_node);
> -	else
> -		smicomm_node = smi_subcomm_node;
> -
> -	pcommdev = of_find_device_by_node(smicomm_node);
> -	of_node_put(smicomm_node);
> +	pcommdev = of_find_device_by_node(frst_avail_smicomm_node);
> +	of_node_put(frst_avail_smicomm_node);
>   	if (!pcommdev)
>   		return -ENODEV;
>   	data->smicomm_dev = &pcommdev->dev;
