Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C72E6E60F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDRMQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDRMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:16:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48DE12C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:16:22 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a10so13378700ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820181; x=1684412181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XX1i/yeoDeRIIb+tuN/yL3o9liaUx0NOEsvlCs+hWSw=;
        b=ADdRNlqa1sra/8NblQZeDa7fr4Kc/wfyeowYFPe5Ih+94UeIOREGXol2bBqTyIYZ45
         tMJ6WbBjncFMB5kAMDxjihNDMACWyXSGlWzrVZFcL/gXauLjEie1WvdIrvFEdo8MFtLX
         YVwYKNMkkR0IE4Ogxnd2Kv+jAutnOWJbhFm52/vtWINfYOmILXbJHB2MNAWfUfNkQLJb
         BH6JTc07GGI0NWcUypuK2DZkh9tMumZhFC0pze54uRuqHWKnBvKMloEmgt4uvKvqUpNS
         8Y2E8AZUPfQIj8ZivAIZDyuALi3hW+LLxFzepe8oI5SqbZjTNeFbn6v0D6a9sko+AMRm
         IsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820181; x=1684412181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XX1i/yeoDeRIIb+tuN/yL3o9liaUx0NOEsvlCs+hWSw=;
        b=jFSpDkUSxSVgk8DES3IqdkpZRnHf5RmyE6q7S8wmSm+ToIumFgBGq81qzYby8A6diW
         oA9JaoACAfWbrZM5xuWLMf8hojzbmJuiiBhX7PtJeFTGT7KgW3FpPEfepf6O8jV59QiS
         ah6GKO8LJYJlZhde1EKId7sYaLkIp6JIxfGuLPuqeRDkv2Qu7USy9C/qjOM00/BB5dJQ
         NKdDNVQtopg7V4I2dLaAprBeBnnKGoA0jF/72yT39bPnsv0R9ZO63pR/osqTiDoynurO
         yNuCCoClI38VjAMiM6i73QSiKj7tKDRNPuwzC+8ycCNN/205n1pWoQC+WmY1cMpdc5Rm
         abNg==
X-Gm-Message-State: AAQBX9eosYghlpv7dow94zJXyWcHDLvxKtduojN3TZsGyj3cwLMvUK7a
        zQPDomJO4BdnuG8eh5rAwL2jHQ==
X-Google-Smtp-Source: AKy350Yh9Uvcd0+WLOCAvVHVJ6awV7tS+tbQC5rN0VRmo2dayoiz3MPRd6eKa8mZ/4lISrvpmpKcZg==
X-Received: by 2002:a2e:be9c:0:b0:2a8:be0a:9c52 with SMTP id a28-20020a2ebe9c000000b002a8be0a9c52mr685651ljr.21.1681820180924;
        Tue, 18 Apr 2023 05:16:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w19-20020a2e9993000000b002a483f01d9csm2548884lji.85.2023.04.18.05.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:16:20 -0700 (PDT)
Message-ID: <ed82c2b0-497c-7273-5010-30eb3ef29290@linaro.org>
Date:   Tue, 18 Apr 2023 14:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 02/17] drm/msm/dpu: Remove TE2 block and feature from
 DPU >= 7.0.0 hardware
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
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-2-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-2-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 22:21, Marijn Suijten wrote:
> No hardware beyond kona (sm8250) defines the TE2 PINGPONG sub-block
> offset downstream.  Even though neither downstream nor upstream utilizes
> these registers in any way, remove the erroneous specification for
> SC8280XP, SM8350 and SM8450 to prevent confusion.
> 
> Note that downstream enables the PPSPLIT (split-FIFO) topology (single
> LM for 2 PP and 2 INTF) based on the presence of a TE2 block.
> 
> Fixes: f0a1bdf64dd7 ("drm/msm/dpu: Introduce SC8280XP")
> Fixes: 0a72f23f6ef8 ("drm/msm/dpu: Add SM8350 to hw catalog")
> Fixes: 8cbbc3396065 ("drm/msm/dpu: add support for SM8450")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h   |  4 ++--
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h | 12 ++++++------
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h   |  4 ++--
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> index ca107ca8de46..41ef0c8fc993 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h
> @@ -127,10 +127,10 @@ static const struct dpu_dspp_cfg sm8350_dspp[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sm8350_pp[] = {
> -	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
>  	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sdm845_pp_sblk,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> index 9aab110b8c44..12c14d15e386 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h
> @@ -121,17 +121,17 @@ static const struct dpu_dspp_cfg sc8280xp_dspp[] = {
>  };
>  
>  static const struct dpu_pingpong_cfg sc8280xp_pp[] = {
> -	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8), -1),
> -	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9), -1),
> -	PP_BLK_TE("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10), -1),
> -	PP_BLK_TE("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11), -1),
> -	PP_BLK_TE("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30), -1),
> -	PP_BLK_TE("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sdm845_pp_sblk,
>  		  DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31), -1),
>  };
>  
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> index 02a259b6b426..e409c119b0a2 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h
> @@ -128,10 +128,10 @@ static const struct dpu_dspp_cfg sm8450_dspp[] = {
>  };
>  /* FIXME: interrupts */
>  static const struct dpu_pingpong_cfg sm8450_pp[] = {
> -	PP_BLK_TE("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sdm845_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 12)),
> -	PP_BLK_TE("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk_te,
> +	PP_BLK("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sdm845_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 13)),
>  	PP_BLK("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sdm845_pp_sblk,
> 
