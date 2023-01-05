Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7C365EC93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjAENLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjAENLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:11:18 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C92F7B6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:11:16 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id ja17so27969418wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epo4NuCr+R0WCc3ZS+TmM2VQF2a+mloAFRnhMBihugE=;
        b=duzWfuiaiDnHSzdqXc0CHu1JETDMs23u6PwEyxrReeZ2pcHD7wg36yyPob3yPiqF79
         p54dRd8VgvKhNpXBOqzbFJi/g/7LyHax6lWVK1NSkr/W7Ij8PDWdyUJy/MzUqA5quR/p
         C2lyEJ1rIOxvNJHCw636pxMWbETY1v5kfnHM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=epo4NuCr+R0WCc3ZS+TmM2VQF2a+mloAFRnhMBihugE=;
        b=0L+o0amQziTIb8/lrvPWbYgWgfPq/FCJd2H4ZV6hGZ5yHO6PSQtT/38LXkaPcXN2cw
         6R2yQqA44LB5HqqPiooaDrQph/qMh/qYKCH3T4ZDUf3OTJNrkscRG0yIcO1Lk+0KxFjp
         wUNayTMx2S92/Zx/6qv8zdro6jP/EWVdeSceHCQO4jX8DycRP+xvWmficBpxNXfdvkrE
         CW8mr5s6tYBTHIeIU0WcO0pxACuVriYPcQFqB0HS1/p2zEaKuH3WX+6u0vxnDJlNRUw8
         OVFT1kDDjcCn2jSJ6GbMysiE4CF4xglEkqBTGCYP1D8UMMU4RpmVi94Pp2sQcc+M+xk8
         C8wA==
X-Gm-Message-State: AFqh2kpSWEAVxjzE37L/8T62s3FwFUXHmSque6OI4lQw6XGekSZRK3k2
        6ePFJrgX1dS2tPYZyHjPTiFgYA==
X-Google-Smtp-Source: AMrXdXv/jh051xUt17UFK3vfd0Ya/xZZjvYng3OETahVuoWkb274Fuqt6WI0eN29vKK3LjAETkh/8g==
X-Received: by 2002:a05:600c:1f0e:b0:3cf:497c:c59e with SMTP id bd14-20020a05600c1f0e00b003cf497cc59emr37030168wmb.6.1672924275463;
        Thu, 05 Jan 2023 05:11:15 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003d1f2c3e571sm2634955wmq.33.2023.01.05.05.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 05:11:14 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:11:12 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_bjorande@quicinc.com, quic_abhinavk@quicinc.com,
        quic_vproddut@quicinc.com, quic_khsieh@quicinc.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, quic_aravindh@quicinc.com,
        swboyd@chromium.org
Subject: Re: [PATCH v9 08/15] drm/bridge: add psr support for panel bridge
 callbacks
Message-ID: <Y7bMcLHr79uhfJv2@phenom.ffwll.local>
Mail-Followup-To: Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_bjorande@quicinc.com, quic_abhinavk@quicinc.com,
        quic_vproddut@quicinc.com, quic_khsieh@quicinc.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        dmitry.baryshkov@linaro.org, quic_aravindh@quicinc.com,
        swboyd@chromium.org
References: <1671012352-1825-1-git-send-email-quic_vpolimer@quicinc.com>
 <1671012352-1825-9-git-send-email-quic_vpolimer@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671012352-1825-9-git-send-email-quic_vpolimer@quicinc.com>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 03:35:45PM +0530, Vinod Polimera wrote:
> This change will handle the psr entry exit cases in the panel
> bridge atomic callback functions. For example, the panel power
> should not turn off if the panel is entering psr.
> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

I think this is all a nice integration of the sr helpers and bridge stuff
and makes sense to me. For the 2 bridge patches and the drm core atomic
patch:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/bridge/panel.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 3558cbf..5e77e38 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -113,6 +113,18 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>  				struct drm_bridge_state *old_bridge_state)
>  {
>  	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state;
> +
> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
> +	if (!crtc)
> +		return;
> +
> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
> +		return;
>  
>  	drm_panel_prepare(panel_bridge->panel);
>  }
> @@ -121,6 +133,18 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
>  				struct drm_bridge_state *old_bridge_state)
>  {
>  	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *old_crtc_state;
> +
> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
> +	if (!crtc)
> +		return;
> +
> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
> +		return;
>  
>  	drm_panel_enable(panel_bridge->panel);
>  }
> @@ -129,6 +153,18 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
>  				struct drm_bridge_state *old_bridge_state)
>  {
>  	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
> +	if (!crtc)
> +		return;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
> +		return;
>  
>  	drm_panel_disable(panel_bridge->panel);
>  }
> @@ -137,6 +173,18 @@ static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
>  				struct drm_bridge_state *old_bridge_state)
>  {
>  	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
> +	struct drm_encoder *encoder = bridge->encoder;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *new_crtc_state;
> +
> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
> +	if (!crtc)
> +		return;
> +
> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
> +		return;
>  
>  	drm_panel_unprepare(panel_bridge->panel);
>  }
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
