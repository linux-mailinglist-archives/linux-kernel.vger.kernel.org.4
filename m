Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F867403D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjASRqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjASRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:46:34 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC34F87F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:46:33 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vw16so7621626ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5RJqblptK4/I1QKvuqzaQWihSAsPbhuGtEAuJnE228=;
        b=Y77KxKdd5+LbM3Jqo2daeLmZkrJEtmVGbVkERc+m3ZABiuK08Ggfh5tYOl5yrHIAY0
         q8h0Rbd9bnC4/j4epCuS9/EKfMUTYsHGmETd/hYNT84AaRTqRA7fKQRirwVelv4jSNX3
         D0U0wNKq98ejFHrPpzEwVWn9uYrt+VlhPLwCNqGH+3/xjAxYzPWcpBY+L4RhKSFNKwc3
         G6JOtiiycsBSWYxl8Oo87WnISdzCFI1qAic02InCukak2BLgrcwxiy0+/iFiNO5T3nKr
         +Ye08LjXgaDtOlw1NrlnJ2R6CSfR9h5aD76iEvdK7HxpKNexEOb8C4kGk32KXkROA3hC
         Optg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5RJqblptK4/I1QKvuqzaQWihSAsPbhuGtEAuJnE228=;
        b=OwUkkob7nWN95t/TdT05wxei1aCALBCDrYrx3IZXvgPqsVLic5VFdvqiGyuNYezmRk
         MyYX4xNTMqiBSV/R3+NTadNvXwGb5etJ8FYK8f4m0+sYMRxtvBeXfWBAcbFltwkrEc4l
         chL0FTKjK6pqUNPw5DB24aUja9dZVu2PBZC2szwqibTfsM7IAwgcrp1LpthRF/G5oCWS
         oobpNCkpBiQH17Vy8hk3+D0wkwiuniWInskhQiQl2Y6UUHAB0LZ471mLiFIz8oCBrlPe
         /EqmluVfvGemrT/zpb/FVK4TlZ5C4l+t0CmRDosRbFc3NkU00TXMUiS5q/f3050koWRA
         gdYg==
X-Gm-Message-State: AFqh2kre5StiSDzZ4Cfbtn3pGiCINvbJfF0V4z0cBEJXbMXCOtOK8wmn
        rcJH02r4ERpbf5W9mcqbrbU=
X-Google-Smtp-Source: AMrXdXsFka3LYJbePLZ9HkMmo1a+eUIgpgXI6HfcAEJAezkdgpKTPPfnMDNKcuy+udAxYwE3LwokhA==
X-Received: by 2002:a17:906:f49:b0:864:8c78:e7ff with SMTP id h9-20020a1709060f4900b008648c78e7ffmr7861249ejj.23.1674150391578;
        Thu, 19 Jan 2023 09:46:31 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0087276f66c6asm4487651ejf.115.2023.01.19.09.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:46:31 -0800 (PST)
Message-ID: <60759e5f-4760-1b0c-2848-06ec5a07b40a@gmail.com>
Date:   Thu, 19 Jan 2023 18:46:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: Add buck isolation setting
 in power domain
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230117032640.13504-1-allen-kh.cheng@mediatek.com>
 <20230117032640.13504-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230117032640.13504-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2023 04:26, Allen-KH Cheng wrote:
> In some chipsets, we need to disable EXT_BUCK_ISO before turning on the
> specific power pm-domains (mtcmos), such as ADSP in MT8192 and CAM_VCORE
> in MT8188.
> 
> Add the MTK_SCPD_EXT_BUCK_ISO flag to control the buck isolation setting
> in the mediatek power domain driver.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")

 From my understanding this patch does not fix anything. It's a feature needed 
for new HW not supported by the mentioned commit. I applied the patch but 
droppend the Fixes tag. If you do not agree, please explain why we need it.

Regards,
Matthias

> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 8 ++++++++
>   drivers/soc/mediatek/mtk-pm-domains.h | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 474b272f9b02..be972e35b26e 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -218,6 +218,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret)
>   		goto err_reg;
>   
> +	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
> +		regmap_clear_bits(scpsys->base, pd->data->ext_buck_iso_offs,
> +				  pd->data->ext_buck_iso_mask);
> +
>   	/* subsys power on */
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_BIT);
>   	regmap_set_bits(scpsys->base, pd->data->ctl_offs, PWR_ON_2ND_BIT);
> @@ -272,6 +276,10 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>   	if (ret < 0)
>   		return ret;
>   
> +	if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
> +		regmap_set_bits(scpsys->base, pd->data->ext_buck_iso_offs,
> +				pd->data->ext_buck_iso_mask);
> +
>   	clk_bulk_disable_unprepare(pd->num_subsys_clks, pd->subsys_clks);
>   
>   	/* subsys power off */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index a5f24c58e35a..5ec53ee073c4 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -10,6 +10,7 @@
>   #define MTK_SCPD_DOMAIN_SUPPLY		BIT(4)
>   /* can't set MTK_SCPD_KEEP_DEFAULT_OFF at the same time */
>   #define MTK_SCPD_ALWAYS_ON		BIT(5)
> +#define MTK_SCPD_EXT_BUCK_ISO		BIT(6)
>   #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>   
>   #define SPM_VDE_PWR_CON			0x0210
