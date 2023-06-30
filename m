Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668D74320C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjF3A75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjF3A7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:59:46 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A5C30DD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:59:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so2183287e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688086779; x=1690678779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoYdkdv2/OutCTcovec52gr8aSf/SvvOZ7kly3VUKmU=;
        b=URMpqQ/B0jODA46sLTtWGi7eA3FHVg3ysmasmi0uRNPCc40oB17iSbHkB9EuwXKqt6
         lYolEh1OHSBMobkDHS+p56nYa+2eEXpvzg58LPnBqrQobSvHfk9vHowK4ZOLwC4eJHxl
         K+SsmrU7drH4jBdt6ykcYnIvoxXMQ07XL+rWnAos8t8UA7CzrOV7DcrJrf1O22XTObvM
         J6ULBDd2HBuKqXhhnmV7qkzDP1+n6YZWR6YOQPTh+ITWXU5Dt1m4ZOMGhC7oqyoxoCte
         nXtf+Bq2GyCPC2A5OgMSlZWszvUiY8d5R+HQHKQ5gwmXPa10TI0XGCsAF15eRscufYsA
         px9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086779; x=1690678779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoYdkdv2/OutCTcovec52gr8aSf/SvvOZ7kly3VUKmU=;
        b=h2wnJHttj/STbDZ/ScKl3kvE7U86S3X5EJiBewJxjJRnwi8Mbr5VAe2JfpJfCo2wOJ
         06ytZPLTgAqn0sNj3ZVLIJlmAYYGA5jYNDjy6JlsVLx7tyTXJD7X1Ria8OzcXmJ4gJ00
         UJERgAFcb8layUMlK9OwAGf2+p7bCIbM9blWNvtbqBLYHFYnLww/v9vLZBas8qEAFj49
         eXzqEOBk0nWVckf4bnWj6262u7BZacpYvZBAjir1DxtT+1ZxwVuKvziltT7aIvEd+s/p
         VdtrWh0cjyo4655N1Apvvb7PqSFyeuuh2IyKPGN6JOa2Qr3FClpYEFWz9R9nrwdiF2rL
         FnyA==
X-Gm-Message-State: ABy/qLZvXfSFXb+nBQSQHdizgtcwicwF5FE/ZM/s2obF0TGfNqY7lr8V
        b7KfjsSRllpYtSZzxoMS0TaOow==
X-Google-Smtp-Source: APBJJlEg6iCQC+TSL2nuh3dd1+J655NCf9q2KkuUDaitZTBiZEIYObwaxIxm3gCm0H29/6bPnPfytg==
X-Received: by 2002:a05:6512:1094:b0:4f1:3d7d:409e with SMTP id j20-20020a056512109400b004f13d7d409emr1321712lfg.0.1688086779192;
        Thu, 29 Jun 2023 17:59:39 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q5-20020ac246e5000000b004fb94c6f5c4sm745002lfo.247.2023.06.29.17.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:59:38 -0700 (PDT)
Message-ID: <572ecc01-71c1-6f64-d26c-145b870584d1@linaro.org>
Date:   Fri, 30 Jun 2023 03:59:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v4 7/7] drm/msm/dpu: Use DRM solid_fill property
Content-Language: en-GB
To:     Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     quic_abhinavk@quicinc.com, ppaalanen@gmail.com,
        contact@emersion.fr, laurent.pinchart@ideasonboard.com,
        sebastian.wick@redhat.com, ville.syrjala@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        wayland-devel@lists.freedesktop.org
References: <20230404-solid-fill-v4-0-f4ec0caa742d@quicinc.com>
 <20230404-solid-fill-v4-7-f4ec0caa742d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230404-solid-fill-v4-7-f4ec0caa742d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 03:25, Jessica Zhang wrote:
> Drop DPU_PLANE_COLOR_FILL_FLAG and check the DRM solid_fill property to
> determine if the plane is solid fill. In addition drop the DPU plane
> color_fill field as we can now use drm_plane_state.solid_fill instead,
> and pass in drm_plane_state.alpha to _dpu_plane_color_fill_pipe() to
> allow userspace to configure the alpha value for the solid fill color.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Minor suggestion below.

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 4476722f03bb..11d4fb771a1f 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -42,7 +42,6 @@
>   #define SHARP_SMOOTH_THR_DEFAULT	8
>   #define SHARP_NOISE_THR_DEFAULT	2
>   
> -#define DPU_PLANE_COLOR_FILL_FLAG	BIT(31)
>   #define DPU_ZPOS_MAX 255
>   
>   /*
> @@ -82,7 +81,6 @@ struct dpu_plane {
>   
>   	enum dpu_sspp pipe;
>   
> -	uint32_t color_fill;
>   	bool is_error;
>   	bool is_rt_pipe;
>   	const struct dpu_mdss_cfg *catalog;
> @@ -606,6 +604,17 @@ static void _dpu_plane_color_fill_pipe(struct dpu_plane_state *pstate,
>   	_dpu_plane_setup_scaler(pipe, fmt, true, &pipe_cfg, pstate->rotation);
>   }
>   
> +static uint32_t _dpu_plane_get_fill_color(struct drm_solid_fill solid_fill)

Please consider accepting drm_plane_state instead and handling alpha 
here. Then _dpu_color_fill can accept rgba colour instead of separate 
RGB and alpha values.

> +{
> +	uint32_t ret = 0;
> +
> +	ret |= ((uint8_t) solid_fill.b) << 16;
> +	ret |= ((uint8_t) solid_fill.g) << 8;
> +	ret |= ((uint8_t) solid_fill.r);
> +
> +	return ret;
> +}
> +
>   /**
>    * _dpu_plane_color_fill - enables color fill on plane
>    * @pdpu:   Pointer to DPU plane object
> @@ -977,9 +986,9 @@ void dpu_plane_flush(struct drm_plane *plane)
>   	if (pdpu->is_error)
>   		/* force white frame with 100% alpha pipe output on error */
>   		_dpu_plane_color_fill(pdpu, 0xFFFFFF, 0xFF);
> -	else if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG)
> -		/* force 100% alpha */
> -		_dpu_plane_color_fill(pdpu, pdpu->color_fill, 0xFF);
> +	else if (drm_plane_solid_fill_enabled(plane->state))
> +		_dpu_plane_color_fill(pdpu, _dpu_plane_get_fill_color(plane->state->solid_fill),
> +				plane->state->alpha);
>   	else {
>   		dpu_plane_flush_csc(pdpu, &pstate->pipe);
>   		dpu_plane_flush_csc(pdpu, &pstate->r_pipe);
> @@ -1024,7 +1033,7 @@ static void dpu_plane_sspp_update_pipe(struct drm_plane *plane,
>   	}
>   
>   	/* override for color fill */
> -	if (pdpu->color_fill & DPU_PLANE_COLOR_FILL_FLAG) {
> +	if (drm_plane_solid_fill_enabled(plane->state)) {
>   		_dpu_plane_set_qos_ctrl(plane, pipe, false);
>   
>   		/* skip remaining processing on color fill */
> 

-- 
With best wishes
Dmitry

