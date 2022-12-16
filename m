Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E8064EB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLPMic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPMia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:38:30 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA7931ED0;
        Fri, 16 Dec 2022 04:38:28 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso1338415wmb.1;
        Fri, 16 Dec 2022 04:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lao9rYbp3jaFrYZTl4u8VT5iiT2JXYCWdbPZpYAQt0U=;
        b=BMepz24nDZZivPME5G/0rC1h5CJlQGZ54ruWBy6dX64Uk4SGIMuaySv/EHqCMmDFlm
         Yt9nWGzwjDylHxA/fIa2fvjPi6RXfFyVUAIQolxl5XVaWYg1gM+KXekgc8Neuxg7UImG
         Q1/TALmidY2sa0We5LCCnwckFy8EU3QcGgZ77y2K4z44V9M8HzAvZ56MfbmVIWN86HOr
         ZfQGtdlBVm0Mb1IhxMtSuqxX3apL13OZa167PAtE2JL2UdUXPcVrcjtTMTz8z1sHDyrV
         dsnyRfEDInrgB2XauxVK2QY8R9RSBu26Y3CKnrjUhLrJPqvcU7Yhr6de6bMR0FDNlfrP
         ezLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lao9rYbp3jaFrYZTl4u8VT5iiT2JXYCWdbPZpYAQt0U=;
        b=0lQ+BMFUK2fPyl7nLU2wVzU4jx1iI8K7E6FoaLFhJYmihvbOUJd6fY9Co0nPCsHEPF
         ucSH8MCgstG8PcmCFenWqXKLYgLhECYB1/z+0gbqMxICRiTXR1Mn0M2qfEZNSZ0IYs0o
         MMATFDWcYHw2LngZjOj5oWP2Iv9E9pH7pdOQqssUV4TbCVHwncVG1nr6fOPRH6q3ysjD
         H6mSvCb1MXTMMEwiTChqv2/DU8ne2WNJ4rqpTlvp7UDiY1tCNXr57o29j9WzySzYMLOz
         39gy5lizOq9v3CX1lQFyCRRPZIUORe8kg05N7oBWBiFtp56xUD04xgSP7i+CcCyJROmt
         fIrw==
X-Gm-Message-State: ANoB5pmoY9zmDuKWX9HB3dklbRiu+gj2VmcAA3Cw00Wrx64XDB4A3h1W
        M8qJP/TMA4Qxi2SES+s+aBc=
X-Google-Smtp-Source: AA0mqf4IPAGnw9/UVoqBz48bhA1Ot5/RTaWfHDozeIuCkpkpk9odgAvJId8q9jxV10vVOZPzlZhGJw==
X-Received: by 2002:a05:600c:34cb:b0:3d1:f16d:5848 with SMTP id d11-20020a05600c34cb00b003d1f16d5848mr24918840wmq.26.1671194307387;
        Fri, 16 Dec 2022 04:38:27 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id cl4-20020a5d5f04000000b00242209dd1ffsm2259107wrb.41.2022.12.16.04.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:38:26 -0800 (PST)
Message-ID: <9a839b69-d798-0957-bb94-7d009fdcceec@gmail.com>
Date:   Fri, 16 Dec 2022 13:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 6/6] drm/mediatek: add mediatek-drm of vdosys0 support
 for mt8188
Content-Language: en-US
To:     "nathan.lu" <nathan.lu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, lancelot.wu@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        amy zhang <Amy.Zhang@mediatek.com>
References: <20221206020046.11333-1-nathan.lu@mediatek.com>
 <20221206020046.11333-7-nathan.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221206020046.11333-7-nathan.lu@mediatek.com>
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



On 06/12/2022 03:00, nathan.lu wrote:
> From: Nathan Lu <nathan.lu@mediatek.com>
> 
> add driver data of mt8188 vdosys0 to mediatek-drm and the sub driver.
> 
> Signed-off-by: amy zhang <Amy.Zhang@mediatek.com>
> Signed-off-by: Nathan Lu <nathan.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index b12e5b977c50..8058a5ec2f1d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -176,6 +176,18 @@ static const enum mtk_ddp_comp_id mt8186_mtk_ddp_ext[] = {
>   	DDP_COMPONENT_DPI0,
>   };
>   
> +static const enum mtk_ddp_comp_id mt8188_mtk_ddp_main[] = {
> +	DDP_COMPONENT_OVL0,
> +	DDP_COMPONENT_RDMA0,
> +	DDP_COMPONENT_COLOR0,
> +	DDP_COMPONENT_CCORR,
> +	DDP_COMPONENT_AAL0,
> +	DDP_COMPONENT_GAMMA,
> +	DDP_COMPONENT_POSTMASK0,
> +	DDP_COMPONENT_DITHER0,
> +	DDP_COMPONENT_DP_INTF0,
> +};
> +
>   static const enum mtk_ddp_comp_id mt8192_mtk_ddp_main[] = {
>   	DDP_COMPONENT_OVL0,
>   	DDP_COMPONENT_OVL_2L0,
> @@ -259,6 +271,11 @@ static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
>   	.ext_len = ARRAY_SIZE(mt8186_mtk_ddp_ext),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
> +	.main_path = mt8188_mtk_ddp_main,
> +	.main_len = ARRAY_SIZE(mt8188_mtk_ddp_main),
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.main_path = mt8192_mtk_ddp_main,
>   	.main_len = ARRAY_SIZE(mt8192_mtk_ddp_main),
> @@ -516,6 +533,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt8186-disp-mutex",
>   	  .data = (void *)MTK_DISP_MUTEX },
> +	{ .compatible = "mediatek,mt8188-disp-mutex",
> +	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt8192-disp-mutex",
>   	  .data = (void *)MTK_DISP_MUTEX },
>   	{ .compatible = "mediatek,mt8195-disp-mutex",
> @@ -600,6 +619,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
>   	  .data = &mt8183_mmsys_driver_data},
>   	{ .compatible = "mediatek,mt8186-mmsys",
>   	  .data = &mt8186_mmsys_driver_data},
> +	{ .compatible = "mediatek,mt8188-vdosys0",
> +	  .data = &mt8188_vdosys0_driver_data},
>   	{ .compatible = "mediatek,mt8192-mmsys",
>   	  .data = &mt8192_mmsys_driver_data},
>   	{ .compatible = "mediatek,mt8195-mmsys",
