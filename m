Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A966259A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiKKLmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiKKLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:42:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C4DFD39;
        Fri, 11 Nov 2022 03:42:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so3008077wmb.0;
        Fri, 11 Nov 2022 03:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZiZPd5oULqd/tLgR6S0NEVvIvyE2JnjYEORmvK53qK4=;
        b=GL+mJx3NYkYn7I7HcehCjjKhqePjdtGJlqcr7ZgBtejSn55iOB5ypZBvJF/JTqfdo7
         bc+e9eaefSDEmtdRDf2lrVm0Ojz/G5n/fE36CsrdBoKSstWOnNtJxkmXowvLe8EFo3cT
         U60GvjpGA1NcE0/Z00FozBdV/VSflcs30mMscT0pWC+egWSCmq9vxJyxbNghCGEjTqlX
         zKUSdm4/AnQBAKvn1H6vtIeNvwpBtB6CAswrdkR6EC4ajmoF2JGNaBMDls5i/nhm7btN
         sfJJx07OYwA2GSHqXPZZxCeKti/sQaApeWIu3sUwnGNekA2Hhk4lZafAMPaJ3hMUzHFV
         nWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZiZPd5oULqd/tLgR6S0NEVvIvyE2JnjYEORmvK53qK4=;
        b=rX/Ss9NuKpth/du1NAY8GisnAIZqmI0DwscnZnM9Pe65lxuHsN8Q+X1K6js3xILSMD
         YJglplSDhYONNgpfFwO1CQsTwVpSSa87/5hMbSlMTWPNMgDNCiLduf2tITxn/EOB/Zdb
         GqIi8Qm9Y/EwX4/ohmHjEKKmDJCofxGBNdFOGwNxGvb2p3q7X4ST5bVz9V34eOsY+Mu+
         0L22ZlbRqQ5MOp1MPD8wLVl4hZTxAiEUdLDkbhGzqb7YT8Y/V/eiNaZD+an1UMAiu1gK
         q+dPgAFm6sxWkjFWskNFHW8R7ZaY8ma3NIVivCOrAU0P2EaxEeEcQqPjM3GCRcSB35Or
         l39Q==
X-Gm-Message-State: ANoB5pkauhasZ72p4UzScHUWOZ6B0TleslMD1e2TUhF3A34w+LU8FYS5
        VuOsyj9Fedq1Bic8ENSvkco=
X-Google-Smtp-Source: AA0mqf6IgJ8vpxxZ6Jw7iq2LCaNjOG4CLjxbRyEOr2ygr+qxAFn1apb5f3P5YIELTnZyVYnu18S3+w==
X-Received: by 2002:a05:600c:1614:b0:3cf:615f:54fb with SMTP id m20-20020a05600c161400b003cf615f54fbmr945615wmn.76.1668166925622;
        Fri, 11 Nov 2022 03:42:05 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003c83465ccbfsm9569651wmp.35.2022.11.11.03.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 03:42:04 -0800 (PST)
Message-ID: <c3c7396c-de5b-1853-e914-9d8eabd31099@gmail.com>
Date:   Fri, 11 Nov 2022 12:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 5/6] drm/mediatek: add mediatek-drm of vdosys0 support
 for mt8195
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220927152704.12018-1-jason-jh.lin@mediatek.com>
 <20220927152704.12018-6-jason-jh.lin@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220927152704.12018-6-jason-jh.lin@mediatek.com>
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



On 27/09/2022 17:27, Jason-JH.Lin wrote:
> Add driver data of mt8195 vdosys0 to mediatek-drm and the sub driver.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c |  6 +++++
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c   | 28 ++++++++++++++++++++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> index 2cb90466798c..66cdd0bc1311 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -374,6 +374,10 @@ static const struct mtk_disp_rdma_data mt8192_rdma_driver_data = {
>   	.fifo_size = 5 * SZ_1K,
>   };
>   
> +static const struct mtk_disp_rdma_data mt8195_rdma_driver_data = {
> +	.fifo_size = 1920,
> +};
> +
>   static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
>   	{ .compatible = "mediatek,mt2701-disp-rdma",
>   	  .data = &mt2701_rdma_driver_data},
> @@ -383,6 +387,8 @@ static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
>   	  .data = &mt8183_rdma_driver_data},
>   	{ .compatible = "mediatek,mt8192-disp-rdma",
>   	  .data = &mt8192_rdma_driver_data},
> +	{ .compatible = "mediatek,mt8195-disp-rdma",
> +	  .data = &mt8195_rdma_driver_data},
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index adc9a4f4085b..9b5a7a7ddde0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -195,6 +195,19 @@ static const enum mtk_ddp_comp_id mt8192_mtk_ddp_ext[] = {
>   	DDP_COMPONENT_DPI0,
>   };
>   
> +static const enum mtk_ddp_comp_id mt8195_mtk_ddp_main[] = {
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_COLOR0,
> +	DDP_COMPONENT_CCORR,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_GAMMA,
> +	DDP_COMPONENT_DITHER0,
> +	DDP_COMPONENT_DSC0,
> +	DDP_COMPONENT_MERGE0,
> +	DDP_COMPONENT_DP_INTF0,
> +};
> +
>   static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
>   	.main_path = mt2701_mtk_ddp_main,
>   	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
> @@ -253,6 +266,11 @@ static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.ext_len = ARRAY_SIZE(mt8192_mtk_ddp_ext),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
> +	.main_path = mt8195_mtk_ddp_main,
> +	.main_len = ARRAY_SIZE(mt8195_mtk_ddp_main),
> +};
> +
>   static int mtk_drm_kms_init(struct drm_device *drm)
>   {
>   	struct mtk_drm_private *private = drm->dev_private;
> @@ -470,12 +488,16 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DISP_DITHER },
>   	{ .compatible = "mediatek,mt8183-disp-dither",
>   	  .data = (void *)MTK_DISP_DITHER },
> +	{ .compatible = "mediatek,mt8195-disp-dsc",
> +	  .data = (void *)MTK_DISP_DSC },
>   	{ .compatible = "mediatek,mt8167-disp-gamma",
>   	  .data = (void *)MTK_DISP_GAMMA, },
>   	{ .compatible = "mediatek,mt8173-disp-gamma",
>   	  .data = (void *)MTK_DISP_GAMMA, },
>   	{ .compatible = "mediatek,mt8183-disp-gamma",
>   	  .data = (void *)MTK_DISP_GAMMA, },
> +	{ .compatible = "mediatek,mt8195-disp-merge",
> +	  .data = (void *)MTK_DISP_MERGE },
>   	{ .compatible = "mediatek,mt2701-disp-mutex",
>   	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt2712-disp-mutex",
> @@ -490,6 +512,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt8192-disp-mutex",
>   	  .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt8195-disp-mutex",
> +	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt8173-disp-od",
>   	  .data = (void *)MTK_DISP_OD },
>   	{ .compatible = "mediatek,mt2701-disp-ovl",
> @@ -524,6 +548,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DISP_RDMA },
>   	{ .compatible = "mediatek,mt8192-disp-rdma",
>   	  .data = (void *)MTK_DISP_RDMA },
> +	{ .compatible = "mediatek,mt8195-disp-rdma",
> +	  .data = (void *)MTK_DISP_RDMA },
>   	{ .compatible = "mediatek,mt8173-disp-ufoe",
>   	  .data = (void *)MTK_DISP_UFOE },
>   	{ .compatible = "mediatek,mt8173-disp-wdma",
> @@ -568,6 +594,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
>   	  .data = &mt8186_mmsys_driver_data},
>   	{ .compatible = "mediatek,mt8192-mmsys",
>   	  .data = &mt8192_mmsys_driver_data},
> +	{ .compatible = "mediatek,mt8195-vdosys0",
> +	  .data = &mt8195_vdosys0_driver_data},

To make this work with older device tree, we will need to provide the same 
driver data to the old compatible:

+	{ .compatible = "mediatek,,mt8195-mmsys",
+	  .data = &mt8195_vdosys0_driver_data},
+       }

Regards,
Matthias

>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
