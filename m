Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F25634195
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234254AbiKVQdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiKVQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:33:04 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349D623BEA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:32:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 189-20020a1c02c6000000b003d02dd48c45so470642wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tP8o2qeHXoHC6ulVNsIBHcsYBkHGaXQH2ePC4lnEEXg=;
        b=PYjoG1xoo59ZH+t/QsWjfv2FKr9FaZRvnkvbrQGj0ALZy6VUc62MnwiJqjedlETq6Y
         oNxAFPDWaSKT03DWcBCAKD+eMpVQEOgrMrNnuCrDUPLdQ0FHxMrSCaMMQpuEIalRLN0D
         u7zRUrGe6QULUakhwdeB3tnWXG6Vrw1QDVOLG8RDEjAd4i1xc3sIuMLu44uvK0gwIdYP
         SYJe+l2UZPYKlfbtoTcJQjHzh+BQe3DFJRHmRth8lppKU+4fYWyK30q3Hs+O3H9QhMQv
         V0OQaoTcaOSIDTsuUGp+/3xTRmGt0MVq3Iz3hisiK5QlZYSkH3yl2ehVQ0jw9NdGSbcs
         bYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tP8o2qeHXoHC6ulVNsIBHcsYBkHGaXQH2ePC4lnEEXg=;
        b=owYppuOtF2IeD5WlDaOuJCZ+4j8s94zf7+JaWlTIXcLzOwq3TnLHq9bV53o/Fu0EcG
         Z+MkODbRWlLH+RmforsXRS5e2kSnky6OSZm9xUE/etA8opru91b2lUtu6GTwYh8zRUjS
         k1kG4TV4lY8FlVJxUNSAcmpi9sryB2KxLZHTyjHpG1W1wWJtyfVftioovXoIm/P50W77
         kk64ckShvw7OhLQtb1swToq3CVRrVMS/n+xj5eil3b1bHszCYzHHWl0vr+UzHN8SiQ3C
         fElv0gfxcwHBvhnZKghDJWbuSQPCeds+MvlHHk1I8kRyeA7gkW9Vq7ciY/g7iYSI8Bv6
         QnLA==
X-Gm-Message-State: ANoB5pmVL6j+DDsRAEE4kP1SIZuNUvA5RhHnmzEQyWCB5ZvdVO1Ow0jy
        Fl/bW0W5OP51JRuAImw7P6s=
X-Google-Smtp-Source: AA0mqf6SfVYhWPWFSmXZgMUDEYgeh//Ch89S4WClJdJLReB0bGvjBL3aIzmPYRi0FFtshEhJAG4pCA==
X-Received: by 2002:a1c:4b0f:0:b0:3cf:735c:9d5a with SMTP id y15-20020a1c4b0f000000b003cf735c9d5amr10377045wma.113.1669134774264;
        Tue, 22 Nov 2022 08:32:54 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id b8-20020adff908000000b0022ca921dc67sm14162699wrr.88.2022.11.22.08.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:32:53 -0800 (PST)
Message-ID: <de8a7833-6983-1d40-55b6-f985473d8201@gmail.com>
Date:   Tue, 22 Nov 2022 17:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 3/6] iommu/mediatek: Add error path for loop of
 mm_dts_parse
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
 <20221018024258.19073-4-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-4-yong.wu@mediatek.com>
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
> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if the i+1
> larb is parsed fail, we should put_device for the i..0 larbs.
> 
> There are two places need to comment:
> 1) The larbid may be not linear mapping, we should loop whole
>     the array in the error path.
> 2) I move this line position: "data->larb_imu[id].dev = &plarbdev->dev;"
>     before "if (!plarbdev->dev.driver)", That means set
>     data->larb_imu[id].dev before the error path. then we don't need
>     "platform_device_put(plarbdev)" again in probe_defer case. All depend
>     on "put_device" of the error path in error cases.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>


> ---
>   drivers/iommu/mtk_iommu.c | 27 ++++++++++++++++++++-------
>   1 file changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 38112ad87d70..912322494bc0 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1055,8 +1055,10 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		u32 id;
>   
>   		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> -		if (!larbnode)
> -			return -EINVAL;
> +		if (!larbnode) {
> +			ret = -EINVAL;
> +			goto err_larbdev_put;
> +		}
>   
>   		if (!of_device_is_available(larbnode)) {
>   			of_node_put(larbnode);
> @@ -1069,14 +1071,16 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   
>   		plarbdev = of_find_device_by_node(larbnode);
>   		of_node_put(larbnode);
> -		if (!plarbdev)
> -			return -ENODEV;
> +		if (!plarbdev) {
> +			ret = -ENODEV;
> +			goto err_larbdev_put;
> +		}
> +		data->larb_imu[id].dev = &plarbdev->dev;
>   
>   		if (!plarbdev->dev.driver) {
> -			platform_device_put(plarbdev);
> -			return -EPROBE_DEFER;
> +			ret = -EPROBE_DEFER;
> +			goto err_larbdev_put;
>   		}
> -		data->larb_imu[id].dev = &plarbdev->dev;
>   
>   		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>   		platform_device_put(plarbdev);
> @@ -1111,6 +1115,15 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		return -EINVAL;
>   	}
>   	return 0;
> +
> +err_larbdev_put:
> +	/* id may be not linear mapping, loop whole the array */
> +	for (i = MTK_LARB_NR_MAX - 1; i >= 0; i++) {
> +		if (!data->larb_imu[i].dev)
> +			continue;
> +		put_device(data->larb_imu[i].dev);
> +	}
> +	return ret;
>   }
>   
>   static int mtk_iommu_probe(struct platform_device *pdev)
