Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069F37431DD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 02:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjF3AoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 20:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjF3AoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 20:44:06 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD623593
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:43:55 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so1626665e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 17:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688085833; x=1690677833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3qjm9bsLZw72FoLoVYfydukfevECHErFvLnVeSIAhVQ=;
        b=NZ5lpaDUaeMv44a3yVZ1nMGDCrikyLMIPSqUHvPJjMHWGMe6RqM6btppqrDCKH7qk5
         pgnR6PBMPk5sL1/FRg6bNnjuCGThQPNV3kejm6hM8hPhbzagV6B/KGd0QPRVMUkmvFU+
         DV97Eu7P4qtbuoadwArP3kZ0hOmF0JtAC70qSVHdCDZcbfJr+lvvhFyeGCZhZQSBxMmA
         tI3yrRSI0AUw/+Ui9JB5MTcQPcH9DCrxduugb4gMLdaMFIVcgs/sxijWUZic2hmv8y8D
         jFy9rogtoJcOK4BYNLBcWc0VfolywAV7n3+1VMyyvZVcSmvosbuhCvRZDu3ojPlnijn/
         ynew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688085833; x=1690677833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qjm9bsLZw72FoLoVYfydukfevECHErFvLnVeSIAhVQ=;
        b=hufnsQg9K2g3MRoPZkZXM2HDYprFyQH3wnGjrQJWVI/UpTRIgmSfyCWghTmF+qX8j0
         MjiEEOkhwTLUyPEwYyTrayobVhUfcGzmFUfPL/qeMKi3IogG6pjd4HlqivUE/E7oRpkb
         PPG8QfKp3yT38dfbyLuy/FbwFkLG82LETSbY7W09bRGZBcmq7CpG+Dfl2KAmFeSe7N6A
         GofimMgLHhWEZiHEsbCGL1nRK+Q4Z35ENcEd97YkoPFKRlAT9CPR5ureAaPBcOh11eD7
         a6SJmMccCTDJuB/xtMyG4GwPLdWdjAv0e5W6th3hXQQOOVqxrJ9Q5PBomL/M1EZEtbeo
         655Q==
X-Gm-Message-State: AC+VfDzLnn3AZOUoTWyPdWzMhmRujnqpN456B2m+o1sbdbi6GSYgen9/
        RfbqfEAKaGiSBgS1QRVwjd097A==
X-Google-Smtp-Source: ACHHUZ4n2nq7exXxWcoNCfFWdfw3wDzWC7Oc3ufl+zBvSHS1VA+HuuZIE1FXuNdyTzCxIeKmI1yLwQ==
X-Received: by 2002:a05:6512:220d:b0:4fb:7371:3db6 with SMTP id h13-20020a056512220d00b004fb73713db6mr2108800lfu.29.1688085833576;
        Thu, 29 Jun 2023 17:43:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m15-20020a19520f000000b004fb88fffd19sm1127741lfb.146.2023.06.29.17.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 17:43:53 -0700 (PDT)
Message-ID: <49be4c4c-8143-a3bf-ddbd-364a2be81e4f@linaro.org>
Date:   Fri, 30 Jun 2023 03:43:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v4 3/7] drm/atomic: Move framebuffer checks to helper
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
 <20230404-solid-fill-v4-3-f4ec0caa742d@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230404-solid-fill-v4-3-f4ec0caa742d@quicinc.com>
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
> Currently framebuffer checks happen directly in
> drm_atomic_plane_check(). Move these checks into their own helper
> method.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
>   drivers/gpu/drm/drm_atomic.c | 130 ++++++++++++++++++++++++-------------------
>   1 file changed, 74 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index b4c6ffc438da..404b984d2d9f 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -580,6 +580,76 @@ plane_switching_crtc(const struct drm_plane_state *old_plane_state,
>   	return true;
>   }
>   
> +static int drm_atomic_check_fb(const struct drm_plane_state *state)
> +{
> +	struct drm_plane *plane = state->plane;
> +	const struct drm_framebuffer *fb = state->fb;
> +	struct drm_mode_rect *clips;
> +
> +	uint32_t num_clips;
> +	unsigned int fb_width, fb_height;
> +	int ret;
> +
> +	/* Check whether this plane supports the fb pixel format. */
> +	ret = drm_plane_check_pixel_format(plane, fb->format->format,
> +					   fb->modifier);
> +
> +	if (ret) {
> +		drm_dbg_atomic(plane->dev,
> +			       "[PLANE:%d:%s] invalid pixel format %p4cc, modifier 0x%llx\n",
> +			       plane->base.id, plane->name,
> +			       &fb->format->format, fb->modifier);
> +		return ret;
> +	}
> +
> +	fb_width = fb->width << 16;
> +	fb_height = fb->height << 16;
> +
> +	/* Make sure source coordinates are inside the fb. */
> +	if (state->src_w > fb_width ||
> +	    state->src_x > fb_width - state->src_w ||
> +	    state->src_h > fb_height ||
> +	    state->src_y > fb_height - state->src_h) {
> +		drm_dbg_atomic(plane->dev,
> +			       "[PLANE:%d:%s] invalid source coordinates "
> +			       "%u.%06ux%u.%06u+%u.%06u+%u.%06u (fb %ux%u)\n",
> +			       plane->base.id, plane->name,
> +			       state->src_w >> 16,
> +			       ((state->src_w & 0xffff) * 15625) >> 10,
> +			       state->src_h >> 16,
> +			       ((state->src_h & 0xffff) * 15625) >> 10,
> +			       state->src_x >> 16,
> +			       ((state->src_x & 0xffff) * 15625) >> 10,
> +			       state->src_y >> 16,
> +			       ((state->src_y & 0xffff) * 15625) >> 10,
> +			       fb->width, fb->height);
> +		return -ENOSPC;
> +	}
> +
> +	clips = __drm_plane_get_damage_clips(state);
> +	num_clips = drm_plane_get_damage_clips_count(state);
> +
> +	/* Make sure damage clips are valid and inside the fb. */
> +	while (num_clips > 0) {
> +		if (clips->x1 >= clips->x2 ||
> +		    clips->y1 >= clips->y2 ||
> +		    clips->x1 < 0 ||
> +		    clips->y1 < 0 ||
> +		    clips->x2 > fb_width ||
> +		    clips->y2 > fb_height) {
> +			drm_dbg_atomic(plane->dev,
> +				       "[PLANE:%d:%s] invalid damage clip %d %d %d %d\n",
> +				       plane->base.id, plane->name, clips->x1,
> +				       clips->y1, clips->x2, clips->y2);
> +			return -EINVAL;
> +		}
> +		clips++;
> +		num_clips--;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * drm_atomic_plane_check - check plane state
>    * @old_plane_state: old plane state to check
> @@ -596,9 +666,6 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   	struct drm_plane *plane = new_plane_state->plane;
>   	struct drm_crtc *crtc = new_plane_state->crtc;
>   	const struct drm_framebuffer *fb = new_plane_state->fb;
> -	unsigned int fb_width, fb_height;
> -	struct drm_mode_rect *clips;
> -	uint32_t num_clips;
>   	int ret;
>   
>   	/* either *both* CRTC and FB must be set, or neither */
> @@ -625,17 +692,6 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   		return -EINVAL;
>   	}
>   
> -	/* Check whether this plane supports the fb pixel format. */
> -	ret = drm_plane_check_pixel_format(plane, fb->format->format,
> -					   fb->modifier);
> -	if (ret) {
> -		drm_dbg_atomic(plane->dev,
> -			       "[PLANE:%d:%s] invalid pixel format %p4cc, modifier 0x%llx\n",
> -			       plane->base.id, plane->name,
> -			       &fb->format->format, fb->modifier);
> -		return ret;
> -	}
> -
>   	/* Give drivers some help against integer overflows */
>   	if (new_plane_state->crtc_w > INT_MAX ||
>   	    new_plane_state->crtc_x > INT_MAX - (int32_t) new_plane_state->crtc_w ||
> @@ -649,49 +705,11 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   		return -ERANGE;
>   	}
>   
> -	fb_width = fb->width << 16;
> -	fb_height = fb->height << 16;
>   
> -	/* Make sure source coordinates are inside the fb. */
> -	if (new_plane_state->src_w > fb_width ||
> -	    new_plane_state->src_x > fb_width - new_plane_state->src_w ||
> -	    new_plane_state->src_h > fb_height ||
> -	    new_plane_state->src_y > fb_height - new_plane_state->src_h) {
> -		drm_dbg_atomic(plane->dev,
> -			       "[PLANE:%d:%s] invalid source coordinates "
> -			       "%u.%06ux%u.%06u+%u.%06u+%u.%06u (fb %ux%u)\n",
> -			       plane->base.id, plane->name,
> -			       new_plane_state->src_w >> 16,
> -			       ((new_plane_state->src_w & 0xffff) * 15625) >> 10,
> -			       new_plane_state->src_h >> 16,
> -			       ((new_plane_state->src_h & 0xffff) * 15625) >> 10,
> -			       new_plane_state->src_x >> 16,
> -			       ((new_plane_state->src_x & 0xffff) * 15625) >> 10,
> -			       new_plane_state->src_y >> 16,
> -			       ((new_plane_state->src_y & 0xffff) * 15625) >> 10,
> -			       fb->width, fb->height);
> -		return -ENOSPC;
> -	}
> -
> -	clips = __drm_plane_get_damage_clips(new_plane_state);
> -	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
> -
> -	/* Make sure damage clips are valid and inside the fb. */
> -	while (num_clips > 0) {
> -		if (clips->x1 >= clips->x2 ||
> -		    clips->y1 >= clips->y2 ||
> -		    clips->x1 < 0 ||
> -		    clips->y1 < 0 ||
> -		    clips->x2 > fb_width ||
> -		    clips->y2 > fb_height) {
> -			drm_dbg_atomic(plane->dev,
> -				       "[PLANE:%d:%s] invalid damage clip %d %d %d %d\n",
> -				       plane->base.id, plane->name, clips->x1,
> -				       clips->y1, clips->x2, clips->y2);
> -			return -EINVAL;
> -		}
> -		clips++;
> -		num_clips--;
> +	if (fb) {

This doesn't only move code, but also changes semantics, making the 
checks optional if no FB is provided. Consider moving the condition to 
the next patch. Otherwise LGTM.

> +		ret = drm_atomic_check_fb(new_plane_state);
> +		if (ret)
> +			return ret;
>   	}
>   
>   	if (plane_switching_crtc(old_plane_state, new_plane_state)) {
> 

-- 
With best wishes
Dmitry

