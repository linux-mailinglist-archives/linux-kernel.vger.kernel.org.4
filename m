Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5771F5E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 00:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjFAWTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 18:19:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AC2189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:19:04 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso1836611e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685657943; x=1688249943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzXpUnDvZMIGNay0Hjx0EQuMfpTuFoMlesIC5F6AUvE=;
        b=kkhGZhP5XYy2HzmNIbLeUTEFhbvL2oQoZdvdAI05ZtUBwV3q5x/VU0GV1R3T9qZODl
         Dm+cctRk1I2y2IwihBvGoQDFXqC2kMkKIPU2uxpiZ4KBHZaXech2/+rpMV8wCwfo/8kU
         mhbWvU54ao/wpEDJoIztIre3a2004KfIjMYKCWyDxXzOhSV7mfvmGDu7D1/V2kBiNAwq
         yuK+R850oz/AG2rENm8K36Wg2Oozrly5S+LqBCwTzdLVmr20hEdqF3qyrDSGLfie8Y0A
         jYem+IJBXXhiaucCcB6zFtJvmYfv303ldkko5SgNfy96NbcGNvgAVaL7/D3E75w88cZe
         3A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685657943; x=1688249943;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzXpUnDvZMIGNay0Hjx0EQuMfpTuFoMlesIC5F6AUvE=;
        b=T8YLw1jeBh0Dql1FPsizByq9qj5Mw4g9swsQsAv8kXMWBHc3g36j3u3Fgwonq8AoJQ
         9VNNo8JO7z++6icsEnsRMAxux31O5M7ThPperZIs658Lz8yaJbITKonNw+ZRTO7kt5g9
         3JCNVWFutiMOEyjulyEZzpv839rVVVs5tfCEoOQZWvGd6XWM3fM2nTOUX9l2n0ujmoab
         XvlaKo0QIGkuLZmnPpzAc/S3SiW9WAgfGhQFBGVE85dByrQ3n6Fxu/BdcLRsAJ57qn7m
         +BpIwGhlSJ2HC6YdZuXzvz9AO04WR0T1+nPLBB+ayPS/6FUzibxVi3Z0ZVrhoOmf5Dv/
         Dfgg==
X-Gm-Message-State: AC+VfDyGSxPA/kubaQNPD+ea/PDJxs6kvknF4lt8PZdRkEUQGrHVf8Ew
        fvzb76ILFJGqaqOCJqCliEBMEQ==
X-Google-Smtp-Source: ACHHUZ4bdEmvTLb553Q5+iyY77wpuuXKmGQSlgIhZOEtsTYnzLDj9i2MCBGiPRL4H9ECBwrf05q6wA==
X-Received: by 2002:ac2:5a06:0:b0:4f4:b28f:6b9c with SMTP id q6-20020ac25a06000000b004f4b28f6b9cmr783852lfn.29.1685657943086;
        Thu, 01 Jun 2023 15:19:03 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id r2-20020a056512102200b004f25c1e2cf5sm1210004lfr.173.2023.06.01.15.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 15:19:02 -0700 (PDT)
Message-ID: <4011108d-1c1a-c648-244f-5414e9465d80@linaro.org>
Date:   Fri, 2 Jun 2023 01:19:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] drm/msm/dpu: retrieve DSI DSC struct at
 atomic_check()
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, marijn.suijten@somainline.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1685657331-23280-1-git-send-email-quic_khsieh@quicinc.com>
 <1685657331-23280-2-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1685657331-23280-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 01:08, Kuogee Hsieh wrote:
> At current implementation, DSI DSC struct is populated at display setup
> during system bootup. This mechanism works fine with embedded display.
> But will run into problem with plugin/unplug oriented external display,
> such as DP, due to DSC struct will become stale once external display
> unplugged. New DSC struct has to be re populated to reflect newer external
> display which just plugged in. Move retrieving of DSI DSC struct to
> atomic_check() so that same mechanism will work for both embedded display
> and external plugin/unplug oriented display.
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3b416e1..5c440a0 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -604,7 +604,7 @@ static int dpu_encoder_virt_atomic_check(
>   	struct drm_display_mode *adj_mode;
>   	struct msm_display_topology topology;
>   	struct dpu_global_state *global_state;
> -	int i = 0;
> +	int index, i = 0;
>   	int ret = 0;
>   
>   	if (!drm_enc || !crtc_state || !conn_state) {
> @@ -639,6 +639,10 @@ static int dpu_encoder_virt_atomic_check(
>   		}
>   	}
>   
> +	index = dpu_enc->disp_info.h_tile_instance[0];
> +        if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI)
> +		dpu_enc->dsc = msm_dsi_get_dsc_config(priv->dsi[index]);

As discussed previously, one should not write to non-state objects from 
atomic_check. This chunk does.

Not to mention that this will start exploding once you try adding DP 
next to it.

Please abstain from posting next revisions until the discussions on the 
previous one are more or less finished. For now this is NAK.

Not to mention that this patch doesn't pass checkpatch.pl.

> +
>   	topology = dpu_encoder_get_topology(dpu_enc, dpu_kms, adj_mode, crtc_state);
>   
>   	/*
> @@ -1034,7 +1038,7 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   	struct dpu_hw_blk *hw_dsc[MAX_CHANNELS_PER_ENC];
>   	int num_lm, num_ctl, num_pp, num_dsc;
>   	unsigned int dsc_mask = 0;
> -	int i;
> +	int index, i;
>   
>   	if (!drm_enc) {
>   		DPU_ERROR("invalid encoder\n");
> @@ -1055,6 +1059,10 @@ static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
>   
>   	trace_dpu_enc_mode_set(DRMID(drm_enc));
>   
> +	index = dpu_enc->disp_info.h_tile_instance[0];
> +        if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI)
> +		dpu_enc->dsc = msm_dsi_get_dsc_config(priv->dsi[index]);

Doesn't this seem 100% same as the previous chunk? Doesn't it plead to 
be extracted to a helper function?

> +
>   	/* Query resource that have been reserved in atomic check step. */
>   	num_pp = dpu_rm_get_assigned_resources(&dpu_kms->rm, global_state,
>   		drm_enc->base.id, DPU_HW_BLK_PINGPONG, hw_pp,
> @@ -2121,8 +2129,10 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
>   					phys_enc->hw_pp->merge_3d->idx);
>   	}
>   
> -	if (dpu_enc->dsc)
> +	if (dpu_enc->dsc) {
>   		dpu_encoder_unprep_dsc(dpu_enc);
> +		dpu_enc->dsc = NULL;
> +	}
>   
>   	intf_cfg.stream_sel = 0; /* Don't care value for video mode */
>   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);

-- 
With best wishes
Dmitry

