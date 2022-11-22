Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3B763417A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbiKVQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbiKVQ3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:29:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F084140DE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:29:04 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id s5so8330114wru.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 08:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ri7F1S4pLcMxIqjAu0KioPz4x8UzFumJZoJlr3Ul9aA=;
        b=iL/3dbSN6JIadgGbQyFSPNrufc3sS6tL14gE5qWA17O3qnMAnv6s9s58mHJW0vJhc1
         I9iB0a8c/s821dbPo47o00RNEptev9gj4jjk96mgDX8AHw+1Kz3hWwYVgWg+qVpf5BfJ
         z+W/L1i5dCz7tjzVG+vRZUJoPSubD36hiUdokWG/EfAH0JYjxiy6FWF5lvDzx8YOpJQ6
         q7XyEVcymhYVAsc/w48eeZz15SNtkPNG3oMcQxDYsaageSkF73V+V82e6W8+I3DsU6zt
         snqM0RIseGnmnJXCSMFJtjtSYxsMKBtKhtt2unbslggojpPBqIHSGExVkBb25JaqKpKY
         K4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri7F1S4pLcMxIqjAu0KioPz4x8UzFumJZoJlr3Ul9aA=;
        b=3dfxOrJxUZ1QWnjTYO+EHFBjXAWWeu03eEuBzSz0xzkZvHQcFO50jXEz5/66PRlEuX
         wnn8r2fV1LyAz2iBLKbWpwKPqGHUSXkHrft7qx6Eqd95RDxVbPM6F7ocLggZBmoTakMk
         djj8uc4ZGbzFwIIMySlsSdPTgXZtqBfJN0EYX1h4GkN2KzAzkShG489Z6TqzTTF6udi/
         Q+nKS5dBXEJl1FWonrCrnM9T/2IYPKWCmNqj3V3u/ALpRYV402yS0mZk7sZG0vMitxmW
         FPSEyoFykMdkvO8+1FRHIGVx3wXfIhnTen9xhlM3h8OUaKFI+riGNCUXAOrzm7tzirQQ
         47eg==
X-Gm-Message-State: ANoB5plcitUyZsdCw/caPxdu/+f+/H54EkLATD0kSKd5CZrn317bzFeW
        ZsZORYqooOzQXGEd0msQSqg=
X-Google-Smtp-Source: AA0mqf4+ga2CUanb3QmE8qQV12cTEWEsslAcVL4sAJOytJ1vcghhfvz3fGBaJJDGVjoIHbM2vU2/Dg==
X-Received: by 2002:a5d:4568:0:b0:241:e8b0:cdcc with SMTP id a8-20020a5d4568000000b00241e8b0cdccmr640819wrc.581.1669134542632;
        Tue, 22 Nov 2022 08:29:02 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm19810612wmo.48.2022.11.22.08.29.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 08:29:01 -0800 (PST)
Message-ID: <451e69dc-ad89-9ffc-1e91-70796e908003@gmail.com>
Date:   Tue, 22 Nov 2022 17:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 2/6] iommu/mediatek: Use component_match_add
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
 <20221018024258.19073-3-yong.wu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221018024258.19073-3-yong.wu@mediatek.com>
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
> In order to simplify the error patch(avoid call of_node_put), Use
> component_match_add instead component_match_add_release since we are only
> interested in the "device" here. Then we could always call of_node_put in
> normal path.
> 
> Strictly this is not a fixes patch, but it is a prepare for adding the
> error path, thus I add a Fixes tag too.
> 
> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/iommu/mtk_iommu.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 3189b585725f..38112ad87d70 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1068,19 +1068,17 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   			id = i;
>   
>   		plarbdev = of_find_device_by_node(larbnode);
> -		if (!plarbdev) {
> -			of_node_put(larbnode);
> +		of_node_put(larbnode);
> +		if (!plarbdev)
>   			return -ENODEV;
> -		}
> +
>   		if (!plarbdev->dev.driver) {
> -			of_node_put(larbnode);
>   			platform_device_put(plarbdev);
>   			return -EPROBE_DEFER;
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
> -		component_match_add_release(dev, match, component_release_of,
> -					    component_compare_of, larbnode);
> +		component_match_add(dev, match, component_compare_dev, &plarbdev->dev);
>   		platform_device_put(plarbdev);
>   	}
>   
