Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA8A6E099B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjDMJDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDMJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:02:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE8CE7D;
        Thu, 13 Apr 2023 02:02:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v6so13455720wrv.8;
        Thu, 13 Apr 2023 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681376548; x=1683968548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldTjgbcAixArTLp8Y3OwHiWDDm8sGdVLf5wYTEAfqeg=;
        b=Sq5siWuukFu2ZV2SC5RtzEOr90Zr3KADENV26Bcj0bkBKMEDDDiM4JLiedIbsGmM6/
         BpcIyDVkAfqs0T5sp4+dhaJ/a8fvtOtLU/dVNXQtVb6muPxOUfylQpCtAPUnf9ZDnD1N
         OUsXuUxo4AcxJGPKCiv29bMPXUeeKmzTa5jzzYG9xelseWYh7pI/mtRJw26RhA9rqU+6
         PQMoTZ4VJX8y2aAEA4TQrdn8lu4dKPxyjcspBIKNTkRnc21PjvOPW2Z8ABijJgHRH18k
         VV9O2EQfumjBnwcdMIxGuo+bLSkMnncdkcRHP6m4jYcMjXXD2cjI1EktepxPYL6li4Nc
         I5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681376548; x=1683968548;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldTjgbcAixArTLp8Y3OwHiWDDm8sGdVLf5wYTEAfqeg=;
        b=UqyrWmPJViVS2lBDrhIO6sa1QqH/jdcnhhvhAcqeuCa7MFdXw/3WqGer6wdVVk+2vz
         Qn3Hf+oGv7GEBbO6NoErP8p40Oeg9B8L/hcCUH5efV5VB6kLJCMzlHss1dM6fmKwIZKJ
         lHhtumNd6TR749DmmhPJaDBwc8na25opacyniL5M0uUq/leUtK0ROA7bbw3XzzrxGNea
         h32IEnnTkK9Jj2mxx0VlVjhHDsPw7UCP4is2MZOfGIeKiR8Wt4n2kcQurdrJ/zDRitzm
         4bELhsC7MgLQVZOf4raWUkP6w26Aa/LUCSvDpwZO0eVj4y98heHToYfIHW1stKMznLsj
         JBwA==
X-Gm-Message-State: AAQBX9cvFPdxBH0g3i7YooZgRlXDtsTQeVICRLsxH4ln/XhbxjMPz8uV
        Sg10xHAuVbVJJanP0lVec1w=
X-Google-Smtp-Source: AKy350asP4+G83mAEIf1p9IarcfPfSoPgb5XVETZON+sPwEmFsRqvaVHYjROuiy2L1CPru9rX5YgVQ==
X-Received: by 2002:a5d:4d0c:0:b0:2ce:fd37:938c with SMTP id z12-20020a5d4d0c000000b002cefd37938cmr907993wrt.50.1681376548080;
        Thu, 13 Apr 2023 02:02:28 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id r16-20020a056000015000b002f21a96c161sm820964wrx.70.2023.04.13.02.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 02:02:27 -0700 (PDT)
Message-ID: <b986d097-6cb4-cbde-3cd1-b8d68d222d9d@gmail.com>
Date:   Thu, 13 Apr 2023 11:02:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/3] drm/mediatek: Add mt8188 dsi compatible to mtk_dsi.c
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jitao.shi@mediatek.com, shuijing.li@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
 <1681366162-4949-3-git-send-email-xinlei.lee@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1681366162-4949-3-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2023 08:09, xinlei.lee@mediatek.com wrote:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add the compatible because there are different definitions for cmdq
> register bit control in mt8188.
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 ++
>   drivers/gpu/drm/mediatek/mtk_dsi.c     | 8 ++++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index a13b36ac03a1..9ba05961479d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -654,6 +654,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
>   	  .data = (void *)MTK_DSI },
>   	{ .compatible = "mediatek,mt8186-dsi",
>   	  .data = (void *)MTK_DSI },
> +	{ .compatible = "mediatek,mt8188-dsi",
> +	  .data = (void *)MTK_DSI },
>   	{ }
>   };
>   
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 7d5250351193..500a3054282d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1208,6 +1208,12 @@ static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
>   	.has_size_ctl = true,
>   };
>   
> +static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
> +	.reg_cmdq_off = 0xd00,
> +	.has_shadow_ctl = true,
> +	.has_size_ctl = true,
> +};
> +
>   static const struct of_device_id mtk_dsi_of_match[] = {
>   	{ .compatible = "mediatek,mt2701-dsi",
>   	  .data = &mt2701_dsi_driver_data },
> @@ -1217,6 +1223,8 @@ static const struct of_device_id mtk_dsi_of_match[] = {
>   	  .data = &mt8183_dsi_driver_data },
>   	{ .compatible = "mediatek,mt8186-dsi",
>   	  .data = &mt8186_dsi_driver_data },
> +	{ .compatible = "mediatek,mt8188-dsi",
> +	  .data = &mt8188_dsi_driver_data },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
