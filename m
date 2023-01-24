Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6E678CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 01:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjAXAVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 19:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjAXAVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 19:21:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C19367F3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:21:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt14so34980767ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 16:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1wYlx73ujIc03aLbIMy4S9L0WlkfJ5aBBwkYUdL0VU=;
        b=W3pRtozuEw22Ofz1sCIuaQPIaG5s8FK4dbiF2+v+VdWiiGpFCG/47106flIneIJC03
         ildCvhDocHvLXeNGvY66souszencKWTv6oossoIs7xVegsdPM47aUhvjcr8lUiV81zDA
         5Gp7n8UN+xTnjvw4izAJ34xcSzW9EZFYHroJI8GVnCuWeG0TS2nM4EYSKaxES5RUbHGf
         v8HXOyJcwYfQtBE1X1YkK6861UEf4eE1ZO7T4c18I2JFsWlj4l/qQKq9VgV6Cd8Cfciv
         y4Sy9UosK89Bg5rFjLIjf4NFsuN16E67vsF2B3ycxn2GJr8Tml6PPjKyJ2tm1kC3KXwI
         LlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1wYlx73ujIc03aLbIMy4S9L0WlkfJ5aBBwkYUdL0VU=;
        b=pA6HKBXFDDKOJTyxRuNdduUKKjcrGvX1gu1Fbhc2MbvTPjcvGDPaCwJ+0s2MYw3ePE
         +76xeiQM0L+97LNGrpI4F9VNcuATisd0nvVsBrIScpBowukU2lX2CbXPITvznPc6lfpA
         N1IjBrM+EXbVTPVTntv0o+t7+twj2xhV4xF++MBk6y+nVQyw2yQV5r0LmJBDrfJY1UBy
         m0xBaUyBRP5tJYI09321yC12VmDTLod8wP86aLp7BchtDPsmxnhsnjAK7bku0upbvJy2
         R2mvhqK31XbvXlt6j7nN0Cc2LHe9rrWKowsdlwEjw0MMz0mw9Tl8u5c1UB0t7D7qJvlP
         6kWA==
X-Gm-Message-State: AFqh2kqlHkeFScvQ89FoOg5QqSn2D3gYoLpajjwd+U4P44NN7a3ykHeT
        K0yWBAMTmng0LohE6gwSayKRBg==
X-Google-Smtp-Source: AMrXdXvHiDSRRHLza5foZbT3vHZ+0V20XWWoZvJruV/9eM/tLp5IVtr2pG9fLVD1jDlP7r7JcDK6ZQ==
X-Received: by 2002:a17:906:c283:b0:86a:833d:e7d8 with SMTP id r3-20020a170906c28300b0086a833de7d8mr26918175ejz.17.1674519693000;
        Mon, 23 Jan 2023 16:21:33 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709065fcb00b0087190b46ab0sm127620ejv.76.2023.01.23.16.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 16:21:32 -0800 (PST)
Message-ID: <4a359748-e53c-a178-de09-2c999eb69013@linaro.org>
Date:   Tue, 24 Jan 2023 02:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH Resend v11 05/15] drm/msm/dp: disable self_refresh_aware
 after entering psr
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com
References: <1674138393-475-1-git-send-email-quic_vpolimer@quicinc.com>
 <1674138393-475-6-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1674138393-475-6-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 16:26, Vinod Polimera wrote:
> From: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> 
> Updated frames get queued if self_refresh_aware is set when the
> sink is in psr. To support bridge enable and avoid queuing of update
> frames, reset the self_refresh_aware state after entering psr.

I'm not convinced by this change. E.g. analogix code doesn't do this. 
Could you please clarify, why do you need to toggle the 
self_refresh_aware flag?

> 
> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_drm.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 029e08c..92d1a1b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -134,6 +134,8 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   	struct drm_crtc_state *old_crtc_state;
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state = NULL;
>   
>   	/*
>   	 * Check the old state of the crtc to determine if the panel
> @@ -150,10 +152,22 @@ static void edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>   
>   	if (old_crtc_state && old_crtc_state->self_refresh_active) {
>   		dp_display_set_psr(dp, false);
> -		return;
> +		goto psr_aware;
>   	}
>   
>   	dp_bridge_atomic_enable(drm_bridge, old_bridge_state);
> +
> +psr_aware:
> +	connector = drm_atomic_get_new_connector_for_encoder(atomic_state,
> +							drm_bridge->encoder);
> +	if (connector)
> +		conn_state = drm_atomic_get_new_connector_state(atomic_state,
> +								connector);
> +
> +	if (conn_state) {
> +		conn_state->self_refresh_aware = dp->psr_supported;
> +	}

No need to wrap a single line statement in brackets.

> +
>   }
>   
>   static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
> @@ -164,6 +178,14 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>   	struct drm_crtc_state *new_crtc_state = NULL, *old_crtc_state = NULL;
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
>   	struct msm_dp *dp = dp_bridge->dp_display;
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state = NULL;
> +
> +	connector = drm_atomic_get_old_connector_for_encoder(atomic_state,
> +							drm_bridge->encoder);
> +	if (connector)
> +		conn_state = drm_atomic_get_new_connector_state(atomic_state,
> +								connector);
>   
>   	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state,
>   						   drm_bridge->encoder);
> @@ -190,6 +212,9 @@ static void edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
>   	 * when display disable occurs while the sink is in psr state.
>   	 */
>   	if (new_crtc_state->self_refresh_active) {
> +		if (conn_state)
> +			conn_state->self_refresh_aware = false;
> +
>   		dp_display_set_psr(dp, true);
>   		return;
>   	} else if (old_crtc_state->self_refresh_active) {

-- 
With best wishes
Dmitry

