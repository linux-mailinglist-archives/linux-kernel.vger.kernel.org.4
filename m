Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900AA6E8571
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 00:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjDSW6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 18:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjDSW6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:58:18 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F03A271
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:48 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8bb726210so1313831fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681945066; x=1684537066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6H/LYnyfLGm/DoukgK9NpNYbWYmIbzsuhsG4x6aqfO0=;
        b=d95jycfoquMsbvCNBZsD+R53bcwKu4ltXCCKtsAiMhe37b3X5S0PAFVXWS6MIiNeSn
         EIi+ntSjHkALdAq9gM/wPs/qvmo5VtgnRVxVJNM0ldaPrQEQF7Xn4qDw76pyNCUaz+KG
         xw5RRHryolS2b1HLj3D/sBS1zxHk2ps8JKJhMYgoms1Qk7flPnkrm9g6Nfw3YmYU7vpm
         gveYMXsGK0ixOhx/UDZeQ6AGQSQKGxwgwXWFedKHM0IRGa6e7Z3tkngE69W3hEA5rQiC
         P7sIcqnYhw8v7D/7Bj9kNIxUIwPFMDKZqd0H2pWntaH8VXpP+/UltTLtyrRAgaMwc02B
         Cx5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945066; x=1684537066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6H/LYnyfLGm/DoukgK9NpNYbWYmIbzsuhsG4x6aqfO0=;
        b=VBXR5A/RE2JPWg0y3wM7T2ekORJHpgMOZ+dC3eN58CilkMex/5BLryl9yhWxBGgDO3
         dMIXKyG/+5fvJFuRRNrseR2wsuc0inF3ke2J2bYXIKsQsr6NqbAoFrqXIVPjwUYIE0I2
         iNCaAWBFf1HYQrDmjafVUpR0vINtwdaQnTC+HFZHR+GjiueyzHJ8j68W8/KkyyJpfW9d
         qQ1dRQFoWMn9e0zhQ38WOC3SOn5Ts1Hqr87p4oNjtmrGYsBbnNHtxm8NsR6npoocdS3/
         H8Mvyj7nwqZ3CagdhUUOzXS9dm08aI67BH0K5H50SV26il3RiWNEYVXhYHH4HpF4sxeq
         rEoQ==
X-Gm-Message-State: AAQBX9e+g2NCRJw3mukNv5J0v7sriw2pTkFvcY+jLOYQWpA+jJI7CTAX
        MYXopa5O2SkNhuqql0extWrcHQ==
X-Google-Smtp-Source: AKy350bzMnus3MYUigW1S1+vwhc6Z356Eq7Qt6cwLue1vw/6zlq0YEry0wuo7kPvg7niC01KqaoiFw==
X-Received: by 2002:ac2:5611:0:b0:4ea:5902:5af1 with SMTP id v17-20020ac25611000000b004ea59025af1mr4917147lfd.52.1681945065677;
        Wed, 19 Apr 2023 15:57:45 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id m12-20020a056512014c00b004eed4c80b55sm32693lfo.156.2023.04.19.15.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 15:57:45 -0700 (PDT)
Message-ID: <25166f59-0a9f-9e81-fd71-18be51f078f2@linaro.org>
Date:   Thu, 20 Apr 2023 01:57:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 06/11] drm/msm/dpu: support cursor sspp hw blocks
Content-Language: en-GB
To:     Arnaud Vrac <avrac@freebox.fr>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230419-dpu-tweaks-v1-0-d1bac46db075@freebox.fr>
 <20230419-dpu-tweaks-v1-6-d1bac46db075@freebox.fr>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230419-dpu-tweaks-v1-6-d1bac46db075@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19/04/2023 17:41, Arnaud Vrac wrote:
> Cursor SSPP must be assigned to the last mixer stage, so we assign an
> immutable zpos property with a value higher than primary/overlay planes,
> to ensure it will always be on top.

The commit does more than is described in the commit message. Let's do 
it step by step. Please split into several patches. Also see below.

> 
> Signed-off-by: Arnaud Vrac <avrac@freebox.fr>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c   | 19 ++++++++++++++-----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 26 +++++++++++++++++++++++---
>   2 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> index 0e7a68714e9e1..6cce0f6cfcb01 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> @@ -738,13 +738,22 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
>   	for (i = 0; i < catalog->sspp_count; i++) {
>   		enum drm_plane_type type;
>   
> -		if ((catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR))
> -			&& cursor_planes_idx < max_crtc_count)
> -			type = DRM_PLANE_TYPE_CURSOR;
> -		else if (primary_planes_idx < max_crtc_count)
> +		if (catalog->sspp[i].features & BIT(DPU_SSPP_CURSOR)) {
> +			if (cursor_planes_idx < max_crtc_count) {
> +				type = DRM_PLANE_TYPE_CURSOR;
> +			} else if (catalog->sspp[i].type == SSPP_TYPE_CURSOR) {
> +				/* Cursor SSPP can only be used in the last
> +				 * mixer stage, so it doesn't make sense to
> +				 * assign two of those to the same CRTC */
> +				continue;
> +			} else {
> +				type = DRM_PLANE_TYPE_OVERLAY;
> +			}
> +		} else if (primary_planes_idx < max_crtc_count) {
>   			type = DRM_PLANE_TYPE_PRIMARY;
> -		else
> +		} else {
>   			type = DRM_PLANE_TYPE_OVERLAY;
> +		}

Ack. I'm not sure how compositors will cope if we have two planes with 
immutable zpos set to the same value. Also I'd prefer to have this as a 
separate commit.

>   
>   		DPU_DEBUG("Create plane type %d with features %lx (cur %lx)\n",
>   			  type, catalog->sspp[i].features,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 128ecdc145260..5a7bb8543866c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -881,7 +881,14 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>   	r_pipe->multirect_mode = DPU_SSPP_MULTIRECT_NONE;
>   	r_pipe->sspp = NULL;
>   
> -	pstate->stage = DPU_STAGE_BASE + pstate->base.normalized_zpos;
> +	if (pipe_hw_caps->type == SSPP_TYPE_CURSOR) {
> +		/* enforce cursor sspp to use the last mixer stage */

I'd add here 'we know that it is the last plane in the stack because of 
zpos property ranges'

> +		pstate->stage = DPU_STAGE_BASE +
> +			pdpu->catalog->caps->max_mixer_blendstages;
> +	} else {
> +		pstate->stage = DPU_STAGE_BASE + pstate->base.normalized_zpos;
> +	}
> +
>   	if (pstate->stage > DPU_STAGE_BASE + pdpu->catalog->caps->max_mixer_blendstages) {
>   		DPU_ERROR("> %d plane mixer stages assigned\n",
>   			  pdpu->catalog->caps->max_mixer_blendstages);
> @@ -1463,6 +1470,7 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
>   	struct msm_drm_private *priv = dev->dev_private;
>   	struct dpu_kms *kms = to_dpu_kms(priv->kms);
>   	struct dpu_hw_sspp *pipe_hw;
> +	const uint64_t *format_modifiers;
>   	uint32_t num_formats;
>   	uint32_t supported_rotations;
>   	int ret = -EINVAL;
> @@ -1489,15 +1497,27 @@ struct drm_plane *dpu_plane_init(struct drm_device *dev,
>   	format_list = pipe_hw->cap->sblk->format_list;
>   	num_formats = pipe_hw->cap->sblk->num_formats;
>   
> +	if (pipe_hw->cap->type == SSPP_TYPE_CURSOR)
> +		format_modifiers = NULL;
> +	else
> +		format_modifiers = supported_format_modifiers;
> +
>   	ret = drm_universal_plane_init(dev, plane, 0xff, &dpu_plane_funcs,
>   				format_list, num_formats,
> -				supported_format_modifiers, type, NULL);
> +				format_modifiers, type, NULL);


Separate commit please

>   	if (ret)
>   		goto clean_plane;
>   
>   	pdpu->catalog = kms->catalog;
>   
> -	ret = drm_plane_create_zpos_property(plane, 0, 0, DPU_ZPOS_MAX);
> +	if (pipe_hw->cap->type == SSPP_TYPE_CURSOR) {
> +		/* cursor SSPP can only be used in the last mixer stage,
> +		 * enforce it by maxing out the cursor plane zpos */
> +		ret = drm_plane_create_zpos_immutable_property(plane, DPU_ZPOS_MAX);
> +	} else {
> +		ret = drm_plane_create_zpos_property(plane, 0, 0, DPU_ZPOS_MAX - 1);
> +	}
> +
>   	if (ret)
>   		DPU_ERROR("failed to install zpos property, rc = %d\n", ret);
>   
> 

-- 
With best wishes
Dmitry

