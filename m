Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA377431F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjF3Awo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjF3Awm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:52:42 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380452112
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:52:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b6afc1ceffso21602671fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688086358; x=1690678358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t2vB8BmxULVJxmGOs9rdQlX1X8v8wP+ERA+PGWKm9bI=;
        b=B+RbpntmLf1ZO/+/u6up7RLJJOiQT2qo2NGUayWP5pfz8vNrY6iOdIMyWg6ALk1q8D
         ExuHYvHZd9Ja4V3Cidf7tK29t0cYzWm3uGuVsNrZv/+O11ycJmmU1rMZgFXgNbtm/Vwl
         0sYJ8bTmc+Sw7fgu/mUagOfuPKhFG9DYSWQTOAuQbwL6CcNbeNiCJ5aFmJRcD/dvUhaK
         p8ytdfkrh6HlxL4OltQ/0Ua/2aXAkFoQxfLAzsu0w1h12lq7gVB+c0aJ0WHdQJC9UmRk
         7r5taS6gfcsDglpzezGQmLSb+p0i5ZQCJyOAjxxrG4lnSiflvw76O0SaFAgxcdeFWLCY
         46eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688086358; x=1690678358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2vB8BmxULVJxmGOs9rdQlX1X8v8wP+ERA+PGWKm9bI=;
        b=Zxdz1QW/HeSiTuO06cIUCeR7eX+k4+1QWgXumOmgDh0ooKcUHS+GlX5P7ppQ7cBB9e
         9s+/3xzEBZaNUVj01lRIB7vNdplVjm98gIwwuIvRg3A0TIU7FPwM74xGtTf+zZwKwEnh
         vdnw/uJnB9SDeGoPMuR1ETn+zwKBs5YIQ5wyuBZ6Ju11EemEym3+GJ3AZooK8ajDQElk
         5fyogpKlNuAF5KnJsghPGrgXbteaGJKYaO9af64nazD3+tGHfNJHgARANEpuFu2nFMun
         lgbVAYmJP3nCpfJW+MnbKDlMWv5R9M5e+JuTfZYr5pe4/QGWgfbdWMQXNBTkB5qlbhZo
         2vkA==
X-Gm-Message-State: ABy/qLYEuQBynBFOPdIlGX3fwTut4rPxIyZzavC/jj3JqibYvCrIV5iQ
        v7mhmnXyudHWQfOzOgFOxSKnhw==
X-Google-Smtp-Source: APBJJlE1c5o3D3G6GvcZOs3abDtDqQuFd80Fa6AQStxZs3COu7E6O54u1yjuPmHUE/Sodiwo+pWWtg==
X-Received: by 2002:a05:6512:2397:b0:4fb:a0ec:983f with SMTP id c23-20020a056512239700b004fba0ec983fmr1366668lfv.14.1688086358424;
        Thu, 29 Jun 2023 17:52:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a11-20020a056512020b00b004f875a919a6sm1086476lfo.293.2023.06.29.17.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:52:37 -0700 (PDT)
Message-ID: <cca48c01-b84a-dff6-57ae-356971edacf3@linaro.org>
Date:   Fri, 30 Jun 2023 03:52:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v4 6/7] drm/msm/dpu: Allow NULL FBs in atomic commit
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
 <20230404-solid-fill-v4-6-f4ec0caa742d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230404-solid-fill-v4-6-f4ec0caa742d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 03:25, Jessica Zhang wrote:
> Since solid fill planes allow for a NULL framebuffer in a valid commit,
> add NULL framebuffer checks to atomic commit calls within DPU.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  |  9 ++++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 45 +++++++++++++++++++------------
>   2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index 1edf2b6b0a26..d1b37d2cc202 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -451,6 +451,7 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   	struct drm_plane_state *state;
>   	struct dpu_crtc_state *cstate = to_dpu_crtc_state(crtc->state);
>   	struct dpu_plane_state *pstate = NULL;
> +	const struct msm_format *fmt;
>   	struct dpu_format *format;
>   	struct dpu_hw_ctl *ctl = mixer->lm_ctl;
>   
> @@ -470,7 +471,13 @@ static void _dpu_crtc_blend_setup_mixer(struct drm_crtc *crtc,
>   		pstate = to_dpu_plane_state(state);
>   		fb = state->fb;
>   
> -		format = to_dpu_format(msm_framebuffer_format(pstate->base.fb));
> +		if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb)
> +			fmt = msm_framebuffer_format(pstate->base.fb);
> +		else
> +			fmt = dpu_get_msm_format(&_dpu_crtc_get_kms(crtc)->base,
> +					DRM_FORMAT_RGBA8888, 0);

The DRM_FORMAT_RGBA8888 should be defined somewhere in patch 1 as format 
for the solid_fill, then that define can be used in this patch.

> +
> +		format = to_dpu_format(fmt);
>   
>   		if (pstate->stage == DPU_STAGE_BASE && format->alpha_enable)
>   			bg_alpha_enable = true;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> index 5f0984ce62b1..4476722f03bb 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
> @@ -837,8 +837,10 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>   
>   	pipe_cfg->dst_rect = new_plane_state->dst;
>   
> -	fb_rect.x2 = new_plane_state->fb->width;
> -	fb_rect.y2 = new_plane_state->fb->height;
> +	if (new_plane_state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && new_plane_state->fb) {
> +		fb_rect.x2 = new_plane_state->fb->width;
> +		fb_rect.y2 = new_plane_state->fb->height;
> +	}
>   
>   	/* Ensure fb size is supported */
>   	if (drm_rect_width(&fb_rect) > MAX_IMG_WIDTH ||
> @@ -848,10 +850,13 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
>   		return -E2BIG;
>   	}
>   
> -	fmt = to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
> -
>   	max_linewidth = pdpu->catalog->caps->max_linewidth;
>   
> +	if (drm_plane_solid_fill_enabled(new_plane_state))
> +		fmt = dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
> +	else
> +		fmt = to_dpu_format(msm_framebuffer_format(new_plane_state->fb));
> +
>   	if (drm_rect_width(&pipe_cfg->src_rect) > max_linewidth) {
>   		/*
>   		 * In parallel multirect case only the half of the usual width
> @@ -1082,21 +1087,32 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
>   	struct drm_crtc *crtc = state->crtc;
>   	struct drm_framebuffer *fb = state->fb;
>   	bool is_rt_pipe;
> -	const struct dpu_format *fmt =
> -		to_dpu_format(msm_framebuffer_format(fb));
> +	const struct dpu_format *fmt;
>   	struct dpu_sw_pipe_cfg *pipe_cfg = &pstate->pipe_cfg;
>   	struct dpu_sw_pipe_cfg *r_pipe_cfg = &pstate->r_pipe_cfg;
>   	struct dpu_kms *kms = _dpu_plane_get_kms(&pdpu->base);
>   	struct msm_gem_address_space *aspace = kms->base.aspace;
>   	struct dpu_hw_fmt_layout layout;
>   	bool layout_valid = false;
> -	int ret;
>   
> -	ret = dpu_format_populate_layout(aspace, fb, &layout);
> -	if (ret)
> -		DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> -	else
> -		layout_valid = true;
> +	if (state->pixel_source == DRM_PLANE_PIXEL_SOURCE_FB && fb) {
> +		int ret;
> +
> +		fmt = to_dpu_format(msm_framebuffer_format(fb));
> +
> +		ret = dpu_format_populate_layout(aspace, fb, &layout);
> +		if (ret)
> +			DPU_ERROR_PLANE(pdpu, "failed to get format layout, %d\n", ret);
> +		else
> +			layout_valid = true;
> +
> +		DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
> +				", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> +				crtc->base.id, DRM_RECT_ARG(&state->dst),
> +				(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> +	} else {
> +		fmt = dpu_get_dpu_format(DRM_FORMAT_ABGR8888);
> +	}
>   
>   	pstate->pending = true;
>   
> @@ -1104,11 +1120,6 @@ static void dpu_plane_sspp_atomic_update(struct drm_plane *plane)
>   	pstate->needs_qos_remap |= (is_rt_pipe != pdpu->is_rt_pipe);
>   	pdpu->is_rt_pipe = is_rt_pipe;
>   
> -	DPU_DEBUG_PLANE(pdpu, "FB[%u] " DRM_RECT_FP_FMT "->crtc%u " DRM_RECT_FMT
> -			", %4.4s ubwc %d\n", fb->base.id, DRM_RECT_FP_ARG(&state->src),
> -			crtc->base.id, DRM_RECT_ARG(&state->dst),
> -			(char *)&fmt->base.pixel_format, DPU_FORMAT_IS_UBWC(fmt));
> -
>   	dpu_plane_sspp_update_pipe(plane, pipe, pipe_cfg, fmt,
>   				   drm_mode_vrefresh(&crtc->mode),
>   				   layout_valid ? &layout : NULL);
> 

-- 
With best wishes
Dmitry

