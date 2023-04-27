Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193546F08EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbjD0QAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244291AbjD0QAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:00:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A82D72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:00:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f09b4a1527so88926375e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 09:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682611204; x=1685203204;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1edwTAlOGdUcjUasfNIwKzBkUgMe+1OvvOQnccGDSQo=;
        b=X9Clxz9CTJxFewizQdXEjuXGVevpYlQ0XdcdYggHj6wfz7/tnwXgix8NPZtlE7EIam
         D79fn7SCBX8EiHbFWcMXWv3nMM342yRzSO06ZLVGwoevNCD6EfSBajDZO4a6H4mo6Th8
         7uk6GLFh+GLzYvI1Cz88AVrfiSFYupwRelZSZOb00sMNk5E/2VGH38xwm0d2C6hKVFNA
         Pwif0W6Za5pQH//kfb4Im46mHoyj+zwOOFTcBK9v9jbQhPZYfzbedxbvEjPRsbyrLG2Z
         NwH7UVWISl0/NeXCzK+gtjgROCMiW69Lgz+5zQ6Lp3fAc7duSa8FMDIcURAxdtcDtuRK
         cAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611204; x=1685203204;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1edwTAlOGdUcjUasfNIwKzBkUgMe+1OvvOQnccGDSQo=;
        b=LB35NGP6YrAjsMJeef521CfrLBRZbxbZd9H1KyG9JFjw1D85N0vacwTfroKCksPjK1
         gjppgVGMZGOx5S+c3GQhyIxFqszFLhioSW5ZHGEvLB5SHM0r49D1pm9FPQfINmZ5FZML
         5DY8VrBqB+D9UKckbBqhy9r1GIpdjWv0tyooBK864I4cIjJdA969j/LknkeqrWAD4/Ud
         asMh29R82cPZ9ZYx8cn8KIehHvCvvGZ6QPtfd06hzjhI2QspnqQawLFy7oBFYc2PSQKY
         LvDu3l2AoM0bzLQaIWbmeUUZJ+m06q/c8rSNvFxkYPa6/bfXp2Vux6qQnpmwXXr5DAot
         2NPw==
X-Gm-Message-State: AC+VfDx44m2oMaEYff/YHTjIw2iTv8NQuUaM7KZUURJ+3pj7AFhHvpho
        vFr0PkwaqjAQL2lnq8tYa4Fc9w==
X-Google-Smtp-Source: ACHHUZ7H30e1t1K6DVQdQBF3WYCIxTCqth9Tu+VwVRg5BvWr+UNsm7utSdu6adjpmripyNKnDfM+UA==
X-Received: by 2002:a7b:c015:0:b0:3f1:91c6:c794 with SMTP id c21-20020a7bc015000000b003f191c6c794mr1911742wmb.5.1682611204022;
        Thu, 27 Apr 2023 09:00:04 -0700 (PDT)
Received: from [172.23.2.82] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003f195d540d9sm17404024wmo.14.2023.04.27.09.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 09:00:03 -0700 (PDT)
Message-ID: <f60354ae-0573-039f-3b3b-cfd6abe3066b@linaro.org>
Date:   Thu, 27 Apr 2023 18:00:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 05/22] drm/msm/dpu: Fix PP_BLK_DIPHER -> DITHER typo
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20230411-dpu-intf-te-v4-0-27ce1a5ab5c6@somainline.org>
 <20230411-dpu-intf-te-v4-5-27ce1a5ab5c6@somainline.org>
Organization: Linaro Developer Services
In-Reply-To: <20230411-dpu-intf-te-v4-5-27ce1a5ab5c6@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 00:37, Marijn Suijten wrote:
> SM8550 exclusively has a DITHER sub-block inside the PINGPONG block and
> no other registers, hence the DITHER name of the macro and a
> corresponding PINGPONG block length of zero.  However, the PP_BLK_ macro
> name was typo'd to DIPHER rather than DITHER.
> 
> Fixes: efcd0107727c ("drm/msm/dpu: add support for SM8550")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 16 ++++++++--------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c         |  2 +-
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index 9e403034093fd..d0ab351b6a8b9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -132,28 +132,28 @@ static const struct dpu_dspp_cfg sm8550_dspp[] = {
>   		 &sm8150_dspp_sblk),
>   };
>   static const struct dpu_pingpong_cfg sm8550_pp[] = {
> -	PP_BLK_DIPHER("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sc7280_pp_sblk,
>   			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>   			-1),
> -	PP_BLK_DIPHER("pingpong_6", PINGPONG_6, 0x66000, MERGE_3D_3, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_6", PINGPONG_6, 0x66000, MERGE_3D_3, sc7280_pp_sblk,
>   			-1,
>   			-1),
> -	PP_BLK_DIPHER("pingpong_7", PINGPONG_7, 0x66400, MERGE_3D_3, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_7", PINGPONG_7, 0x66400, MERGE_3D_3, sc7280_pp_sblk,
>   			-1,
>   			-1),
>   };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 03f162af1a50b..ca8a02debda98 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -491,7 +491,7 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>   	.len = 0x20, .version = 0x20000},
>   };
>   
> -#define PP_BLK_DIPHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
> +#define PP_BLK_DITHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>   	{\
>   	.name = _name, .id = _id, \
>   	.base = _base, .len = 0, \
> 

Sorry for the typo!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
