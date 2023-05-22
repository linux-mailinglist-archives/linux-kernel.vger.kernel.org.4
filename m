Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0970CAB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjEVURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjEVURE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:17:04 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E195BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:17:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af28303127so41826281fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684786619; x=1687378619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfxs3G9f7urtp3OVLQcht9ohbiXijf8vOGoPmlCZGcA=;
        b=c5i5R02gjqMmC2+O4d7D33Z5gkgFa0GBsESB5qrIrTcXkoY+nDKtmC7uqNJ9ebQ6fV
         pXCfyQIZNF12Kpo+8DRmI5Pv25nxFpVBcMDT829G3T6OJ4Od+WMDG+Yao4XRrAOx7Z45
         gHgC5rJ830A1YtFBOYO0mk/c2rbulBSs9ACskdY1IM1TJKo32jAxn0INV/Wg8AZtH625
         2RjLRRsWnzPwOSP97Dd7bAuaG8AYUXxqzgq5LyVSfd8N7C7illjTio6WKIC2pRGzZQjb
         lA/xBvmuKyEtnEp3GwofgBA4GdXzLDaN7uq6RxkOUDVUkWnGSHffgxWrEa+katndjMa5
         HnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786619; x=1687378619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfxs3G9f7urtp3OVLQcht9ohbiXijf8vOGoPmlCZGcA=;
        b=QCi1OWJK6jcMxwO0g9EWU/4gaifmWZkA9GQy/9jszfL+5PE8LFnQstn8PBlKcRqer8
         Wc/q2atTN/t/OrZE6XFMBbqM6402aCWLhtQyphRH65s4cfk/lCJvVXC2UyO4iAM06P04
         PPflQ2UmgQruV3nDLumfd+wAFgJaPMYCEIAYKatSPxx+nVEqY6Ibj/QfuHBAR8bVvFF8
         efcelyat0BIpB1f+R/yGze04JRkouz4JKdGg59eTqYpi+LPxUyHHbp1ECkLAmtEHXQ8X
         aSwD0L4jCDo0GO5ztjCO4pY6YISHlRTZtsT6lREh2jcMQaqEIZ+eBjtZrsXTYlxv8R45
         tQ7w==
X-Gm-Message-State: AC+VfDwyODOEEup5EBltJDk2Fm2gmp5+DZtSY9+3bR6Koy1Rc01KLIyb
        Od9ROOI9P/mJj7txboVNoAg6yA==
X-Google-Smtp-Source: ACHHUZ6POVng+YjkJ2k5Vx3jLXxeNpsZWnsSR+sp66BL8Sg6mY0z4Uftrv06UJz1AJ1+fuiH+MyGlw==
X-Received: by 2002:a2e:8709:0:b0:2ad:8a4b:6a9e with SMTP id m9-20020a2e8709000000b002ad8a4b6a9emr4209504lji.26.1684786618645;
        Mon, 22 May 2023 13:16:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id f24-20020a2e9198000000b002ab59a09d75sm1285368ljg.120.2023.05.22.13.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 13:16:58 -0700 (PDT)
Message-ID: <a67f3250-b1f1-88b7-65a3-17b7e1274a48@linaro.org>
Date:   Mon, 22 May 2023 23:16:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] drm/msm/dp: enable HDP plugin/unplugged interrupts at
 hpd_enable/disable
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        marijn.suijten@somainline.org
Cc:     quic_abhinavk@quicinc.com, quic_aravindh@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1684786117-16728-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1684786117-16728-1-git-send-email-quic_khsieh@quicinc.com>
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

On 22/05/2023 23:08, Kuogee Hsieh wrote:
> The internal_hpd flag was introduced to handle external DP HPD derived
> from GPIO pinmuxed into DP controller. HPD plug/unplug interrupts cannot
> be enabled until internal_hpd flag is set to true.
> At both bootup and resume time, the DP driver will enable external DP
> plugin interrupts and handle plugin interrupt accordingly.


> However
> dp_bridge_hpd_enable() bridge ops function was called to set internal_hpd
> to true later than where DP driver expected during both bootup and resume
> time.

Excuse me, can't parse this.

> This prevent DP driver from detecting external plugin interrupt due
> to HPD related interrupts are not enabled on time. Hence external display

prevents
not being enabled

> can not be lit up properly.
> 
> Move HPD related interrupts control of both enable/disable HDP hardware
> block and setup individual interrupt mask bits to dp_bridge_hpd_enable()
> and dp_bridge_hpd_disable().
> 
> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>

This looks pretty good to me, minor nit below.

> ---
>   drivers/gpu/drm/msm/dp/dp_catalog.c | 19 ++++++----
>   drivers/gpu/drm/msm/dp/dp_catalog.h |  2 +-
>   drivers/gpu/drm/msm/dp/dp_display.c | 70 +++++++++++--------------------------
>   3 files changed, 35 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
> index 7a8cf1c..1da711e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
> @@ -620,19 +620,26 @@ void dp_catalog_hpd_config_intr(struct dp_catalog *dp_catalog,
>   				config & DP_DP_HPD_INT_MASK);
>   }
>   
> -void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
> +void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog, bool enable)

Could you please split it into _enable and _disable functions? Having 
dp_catalog_ctrl_hpd_config(.., false) doesn't sound logical.

>   {
>   	struct dp_catalog_private *catalog = container_of(dp_catalog,
>   				struct dp_catalog_private, dp_catalog);
>   
>   	u32 reftimer = dp_read_aux(catalog, REG_DP_DP_HPD_REFTIMER);
>   
> -	/* Configure REFTIMER and enable it */
> -	reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
> -	dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
> +	if (enable) {
> +		/* Configure REFTIMER and enable it */
> +		reftimer |= DP_DP_HPD_REFTIMER_ENABLE;
> +		dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
> +
> +		/* Enable HPD */
> +		dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
> +	} else {
> +		reftimer &= ~DP_DP_HPD_REFTIMER_ENABLE;
> +		dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
>   
> -	/* Enable HPD */
> -	dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
> +		dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, 0);
> +	}
>   }
>   
>   static void dp_catalog_enable_sdp(struct dp_catalog_private *catalog)
> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
> index 82376a2..818c036 100644
> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
> @@ -104,7 +104,7 @@ bool dp_catalog_ctrl_mainlink_ready(struct dp_catalog *dp_catalog);
>   void dp_catalog_ctrl_enable_irq(struct dp_catalog *dp_catalog, bool enable);
>   void dp_catalog_hpd_config_intr(struct dp_catalog *dp_catalog,
>   			u32 intr_mask, bool en);
> -void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog);
> +void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog, bool enable);
>   void dp_catalog_ctrl_config_psr(struct dp_catalog *dp_catalog);
>   void dp_catalog_ctrl_set_psr(struct dp_catalog *dp_catalog, bool enter);
>   u32 dp_catalog_link_is_connected(struct dp_catalog *dp_catalog);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3e13acdf..fee23e5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -615,12 +615,6 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>   		dp->hpd_state = ST_MAINLINK_READY;
>   	}
>   
> -	/* enable HDP irq_hpd/replug interrupt */
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog,
> -					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
> -					   true);
> -
>   	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
>   			dp->dp_display.connector_type, state);
>   	mutex_unlock(&dp->event_mutex);
> @@ -658,12 +652,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>   			dp->dp_display.connector_type, state);
>   
> -	/* disable irq_hpd/replug interrupts */
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog,
> -					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
> -					   false);
> -
>   	/* unplugged, no more irq_hpd handle */
>   	dp_del_event(dp, EV_IRQ_HPD_INT);
>   
> @@ -687,10 +675,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   		return 0;
>   	}
>   
> -	/* disable HPD plug interrupts */
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
> -
>   	/*
>   	 * We don't need separate work for disconnect as
>   	 * connect/attention interrupts are disabled
> @@ -706,10 +690,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>   	/* signal the disconnect event early to ensure proper teardown */
>   	dp_display_handle_plugged_change(&dp->dp_display, false);
>   
> -	/* enable HDP plug interrupt to prepare for next plugin */
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
> -
>   	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
>   			dp->dp_display.connector_type, state);
>   
> @@ -1082,26 +1062,6 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>   	mutex_unlock(&dp_display->event_mutex);
>   }
>   
> -static void dp_display_config_hpd(struct dp_display_private *dp)
> -{
> -
> -	dp_display_host_init(dp);
> -	dp_catalog_ctrl_hpd_config(dp->catalog);
> -
> -	/* Enable plug and unplug interrupts only if requested */
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog,
> -				DP_DP_HPD_PLUG_INT_MASK |
> -				DP_DP_HPD_UNPLUG_INT_MASK,
> -				true);
> -
> -	/* Enable interrupt first time
> -	 * we are leaving dp clocks on during disconnect
> -	 * and never disable interrupt
> -	 */
> -	enable_irq(dp->irq);
> -}
> -
>   void dp_display_set_psr(struct msm_dp *dp_display, bool enter)
>   {
>   	struct dp_display_private *dp;
> @@ -1176,7 +1136,7 @@ static int hpd_event_thread(void *data)
>   
>   		switch (todo->event_id) {
>   		case EV_HPD_INIT_SETUP:
> -			dp_display_config_hpd(dp_priv);
> +			dp_display_host_init(dp_priv);
>   			break;
>   		case EV_HPD_PLUG_INT:
>   			dp_hpd_plug_handle(dp_priv, todo->data);
> @@ -1394,13 +1354,8 @@ static int dp_pm_resume(struct device *dev)
>   	/* turn on dp ctrl/phy */
>   	dp_display_host_init(dp);
>   
> -	dp_catalog_ctrl_hpd_config(dp->catalog);
> -
> -	if (dp->dp_display.internal_hpd)
> -		dp_catalog_hpd_config_intr(dp->catalog,
> -				DP_DP_HPD_PLUG_INT_MASK |
> -				DP_DP_HPD_UNPLUG_INT_MASK,
> -				true);
> +	if (dp_display->is_edp)
> +		dp_catalog_ctrl_hpd_config(dp->catalog, true);
>   
>   	if (dp_catalog_link_is_connected(dp->catalog)) {
>   		/*
> @@ -1568,7 +1523,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>   
>   	if (aux_bus && dp->is_edp) {
>   		dp_display_host_init(dp_priv);
> -		dp_catalog_ctrl_hpd_config(dp_priv->catalog);
> +		dp_catalog_ctrl_hpd_config(dp_priv->catalog, true);
>   		dp_display_host_phy_init(dp_priv);
>   		enable_irq(dp_priv->irq);
>   
> @@ -1801,16 +1756,33 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>   {
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>   	struct msm_dp *dp_display = dp_bridge->dp_display;
> +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +	mutex_lock(&dp->event_mutex);
> +	dp_catalog_ctrl_hpd_config(dp->catalog, true);
> +
> +	/* enable HDP interrupts */
> +	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, true);
> +
> +	enable_irq(dp->irq);
>   
>   	dp_display->internal_hpd = true;
> +	mutex_unlock(&dp->event_mutex);
>   }
>   
>   void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>   {
>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>   	struct msm_dp *dp_display = dp_bridge->dp_display;
> +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
> +
> +	mutex_lock(&dp->event_mutex);
> +	/* disable HDP interrupts */
> +	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
> +	dp_catalog_ctrl_hpd_config(dp->catalog, false);
>   
>   	dp_display->internal_hpd = false;
> +	mutex_unlock(&dp->event_mutex);
>   }
>   
>   void dp_bridge_hpd_notify(struct drm_bridge *bridge,

-- 
With best wishes
Dmitry

