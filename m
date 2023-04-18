Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9AF6E60FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDRMR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjDRMRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 08:17:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE94565B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:17:17 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4edc114c716so1712931e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681820236; x=1684412236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GVRsjaRsIonMFl6duGqwi/hSLT82+JYeVQ472VvmnvA=;
        b=uSC5tADOilhzZ3cCvrYl5beBipKrfMF6mxHAalDeRqlF3I33Gj6ICma3sZx+0Q5mpF
         8QEBMwqojjKdUrnXRpXd7f7qMpsRNQ9dE3aVVE8fK+Nuhn3nmbyu6D6kwDpN9JMhRSeE
         RE/3jojZ0dbXQEBbOFCf0cPE9SOWWuMDqzk0cwfLhDDG3js0dKeanxkW+i9gfmo9uboj
         VP7+GIcvh3P1OQGn207NB+b63E76KGlIsV4YVA4Y2+CqSEA9kfycyeSt9BYgLdZvM0DI
         UtmwaDT13Ija+j3robnfPiLR17C5UKSLx/Fots8s0ZavsJMAQy0F5bGdMi16NeillLF7
         OBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681820236; x=1684412236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVRsjaRsIonMFl6duGqwi/hSLT82+JYeVQ472VvmnvA=;
        b=KXgJ3kmZ0hSpIRk2+4zYrq/D7lIymUz6rG6n8mfva6KmaemGvFxtLuT7AegzzOLkWG
         JZWiwFtt1UL8TJuSdKbdxeNGhf/dWc6vftkszx5Dk5w76r+TpmMw9VrOsufq1U3Kkule
         JbGMctyzSpXlJbaARuNVJ6an3rPyQvOERwGhPUHwgquUr1rMyHLb17HPri4e8957m8mx
         wiOn67GrTFKcfnb8zOngLPo1OjjWNvCM1WMCRWwiZ4YuMjrvaY9I8I0c8LWbQ//o1ymz
         0Zg/GQ9KuXFR+MOUJOXDve55/29leyu9kxElo0h7naq7foSdS/VQvO93PdgLrSLwD4/F
         KxvA==
X-Gm-Message-State: AAQBX9fGjqUtU1DcrgNpyJr/PEh4w+nh60/7fhYJd/1gp7vDJXsLfGNQ
        fyle0MqPlGJBOUYnuIpkOLnQqg==
X-Google-Smtp-Source: AKy350YJba71ByK73D5tSNH7lhJ8kYY1bATGp9wNcQ8mHpzqKYvaXqYb5t+m1CVVN2h2CONtJ4DXMg==
X-Received: by 2002:ac2:4186:0:b0:4dd:ac8d:671f with SMTP id z6-20020ac24186000000b004ddac8d671fmr3154544lfh.34.1681820236212;
        Tue, 18 Apr 2023 05:17:16 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id q13-20020ac25a0d000000b004eafa060a6fsm2351324lfn.145.2023.04.18.05.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 05:17:15 -0700 (PDT)
Message-ID: <49faf870-0445-6797-97be-890f94bfab60@linaro.org>
Date:   Tue, 18 Apr 2023 14:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 04/17] drm/msm/dpu: Fix PP_BLK_DIPHER -> DITHER typo
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
 <20230411-dpu-intf-te-v2-4-ef76c877eb97@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-4-ef76c877eb97@somainline.org>
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
> SM8550 only comes with a DITHER subblock inside the PINGPONG block,
> hence the name and a block length of zero.  However, the PP_BLK macro
> name was typo'd to DIPHER rather than DITHER.
> 
> Fixes: efcd0107727c ("drm/msm/dpu: add support for SM8550")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
lol

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 16 ++++++++--------
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c         |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> index 9e403034093f..d0ab351b6a8b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h
> @@ -132,28 +132,28 @@ static const struct dpu_dspp_cfg sm8550_dspp[] = {
>  		 &sm8150_dspp_sblk),
>  };
>  static const struct dpu_pingpong_cfg sm8550_pp[] = {
> -	PP_BLK_DIPHER("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_0", PINGPONG_0, 0x69000, MERGE_3D_0, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 8),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_1", PINGPONG_1, 0x6a000, MERGE_3D_0, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 9),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_2", PINGPONG_2, 0x6b000, MERGE_3D_1, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 10),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_3", PINGPONG_3, 0x6c000, MERGE_3D_1, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 11),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_4", PINGPONG_4, 0x6d000, MERGE_3D_2, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 30),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_5", PINGPONG_5, 0x6e000, MERGE_3D_2, sc7280_pp_sblk,
>  			DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR2, 31),
>  			-1),
> -	PP_BLK_DIPHER("pingpong_6", PINGPONG_6, 0x66000, MERGE_3D_3, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_6", PINGPONG_6, 0x66000, MERGE_3D_3, sc7280_pp_sblk,
>  			-1,
>  			-1),
> -	PP_BLK_DIPHER("pingpong_7", PINGPONG_7, 0x66400, MERGE_3D_3, sc7280_pp_sblk,
> +	PP_BLK_DITHER("pingpong_7", PINGPONG_7, 0x66400, MERGE_3D_3, sc7280_pp_sblk,
>  			-1,
>  			-1),
>  };
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index 03f162af1a50..ca8a02debda9 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -491,7 +491,7 @@ static const struct dpu_pingpong_sub_blks sc7280_pp_sblk = {
>  	.len = 0x20, .version = 0x20000},
>  };
>  
> -#define PP_BLK_DIPHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
> +#define PP_BLK_DITHER(_name, _id, _base, _merge_3d, _sblk, _done, _rdptr) \
>  	{\
>  	.name = _name, .id = _id, \
>  	.base = _base, .len = 0, \
> 
