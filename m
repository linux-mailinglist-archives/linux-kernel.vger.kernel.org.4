Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8370CD72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbjEVWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVWDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:03:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131FF9E
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:03:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af1c884b08so51258191fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684793007; x=1687385007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U4Dct+KSj23BT1k7f2zFRKfGQUYVt8EbRMMwJrJugA=;
        b=q/Mkd9fHa/WWa9tCtv4ZW0ulNU569z+kPT49GWzVS4pS2BGtBTIjTSLCahYulrwpGQ
         KGccaRbvDqub1n9xdFWJjPt5QaqBEhlPnxYxN+o46haoHtUedmdAF9dcPn+RsRTvJfm5
         RpR/1WDkvRGNmi8IznLRT6yoz06wwvJx6Q6gGMY0HYW/T8PK93DSxEDVfVCCT0lSgkC0
         HSRP4VuQ8zrvvWUKjWcFrv/mm0m0j1OQ6tjhpdx+jLKKJIJkUQmdXtUBAdI9ett9xHHC
         Hg5KhKdvnbCNKeXYDWNHXr9COm2vFBcrKkmp1ZNs9yfr66+WHIGRXE+nIItfn4aKK11k
         Dy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684793007; x=1687385007;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0U4Dct+KSj23BT1k7f2zFRKfGQUYVt8EbRMMwJrJugA=;
        b=UZ7jJYkNqaZ4XH/E5ZgPbY1V1HZgCYTHdMT8Om1ExHbAVRlNcf05aQYjX7qrKRxcHw
         crBx5GRcIaruPc+aye0h61LkNF8RfUQrJVWEl0akyXprDtwSISstI+6naVkk165Fje+9
         Q0wn21Xj8713ATdOLlLUoRy14O/nOJQVj0VcDlU3Cq1hZ3Q08MV9MmZIg6MgkB0jBkeZ
         +81qkL1Ozo67/Og2BbcMisYqwIDpSo0+FACCnbu1P21B7O4NOJvmOJYEckBycRoHc2o0
         Hb1LfQoQzyVINxMhIV6XKSplsq+MoDXhdQah4Rv2WEW7cM26mGDuOAdAYthES7F9BhMH
         VUtQ==
X-Gm-Message-State: AC+VfDyq2x1JW/KX/VxcQrJ4pQ2X5SRL5X36xTv9eHZkGHCEJqLhlv2N
        zjN10y3x7SRy+Lh9GAXDSIcxxw==
X-Google-Smtp-Source: ACHHUZ5HjOTaiuYq6HeXYZmVyhwDkcc9oyIl3Ov1FSfqHJR0urcq+o8GGLKN/sCRUqyWZa0dM48Y4w==
X-Received: by 2002:a2e:9cce:0:b0:2ad:999b:3bd6 with SMTP id g14-20020a2e9cce000000b002ad999b3bd6mr3840820ljj.23.1684793007151;
        Mon, 22 May 2023 15:03:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id b23-20020a2e8497000000b002aa458a7a46sm1312275ljh.123.2023.05.22.15.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 15:03:26 -0700 (PDT)
Message-ID: <c4d6e019-1582-c94f-d56d-271c420d72ea@linaro.org>
Date:   Tue, 23 May 2023 01:03:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] drm/msm/dp: enable HDP plugin/unplugged interrupts at
 hpd_enable/disable
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org,
        marijn.suijten@somainline.org, quic_abhinavk@quicinc.com,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1684791092-1822-1-git-send-email-quic_khsieh@quicinc.com>
 <20230522220555.7ood44kavjzzg3lv@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230522220555.7ood44kavjzzg3lv@ripper>
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

On 23/05/2023 01:05, Bjorn Andersson wrote:
> On Mon, May 22, 2023 at 02:31:32PM -0700, Kuogee Hsieh wrote:
>> The internal_hpd flag is set to true by dp_bridge_hpd_enable() and set to
>> false by dp_bridge_hpd_disable() to handle GPIO pinmuxed into DP controller
>> case. HDP related interrupts can not be enabled until internal_hpd is set
>> to true. At current implementation dp_display_config_hpd() will initialize
>> DP host controller first followed by enabling HDP related interrupts if
>> internal_hpd was true at that time. Enable HDP related interrupts depends on
>> internal_hpd status may leave system with DP driver host is in running state
>> but without HDP related interrupts being enabled. This will prevent external
>> display from being detected. Eliminated this dependency by moving HDP related
>> interrupts enable/disable be done at dp_bridge_hpd_enable/disable() directly
>> regardless of internal_hpd status.
>>
> 
> Thanks Kuogee, this looks quite good to me. But...
> 
>> Changes in V3:
>> -- dp_catalog_ctrl_hpd_enable() and dp_catalog_ctrl_hpd_disable()
>> -- rewording ocmmit text
>>
>> Fixes: cd198caddea7 ("drm/msm/dp: Rely on hpd_enable/disable callbacks")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_catalog.c | 15 +++++++-
>>   drivers/gpu/drm/msm/dp/dp_catalog.h |  3 +-
>>   drivers/gpu/drm/msm/dp/dp_display.c | 70 +++++++++++--------------------------
>>   3 files changed, 37 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.c b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> index 7a8cf1c..5142aeb 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.c
>> @@ -620,7 +620,7 @@ void dp_catalog_hpd_config_intr(struct dp_catalog *dp_catalog,
>>   				config & DP_DP_HPD_INT_MASK);
>>   }
>>   
>> -void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>> +void dp_catalog_ctrl_hpd_enable(struct dp_catalog *dp_catalog)
>>   {
>>   	struct dp_catalog_private *catalog = container_of(dp_catalog,
>>   				struct dp_catalog_private, dp_catalog);
>> @@ -635,6 +635,19 @@ void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog)
>>   	dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, DP_DP_HPD_CTRL_HPD_EN);
>>   }
>>   
>> +void dp_catalog_ctrl_hpd_disable(struct dp_catalog *dp_catalog)
>> +{
>> +	struct dp_catalog_private *catalog = container_of(dp_catalog,
>> +				struct dp_catalog_private, dp_catalog);
>> +
>> +	u32 reftimer = dp_read_aux(catalog, REG_DP_DP_HPD_REFTIMER);
>> +
>> +	reftimer &= ~DP_DP_HPD_REFTIMER_ENABLE;
>> +	dp_write_aux(catalog, REG_DP_DP_HPD_REFTIMER, reftimer);
>> +
>> +	dp_write_aux(catalog, REG_DP_DP_HPD_CTRL, 0);
>> +}
>> +
>>   static void dp_catalog_enable_sdp(struct dp_catalog_private *catalog)
>>   {
>>   	/* trigger sdp */
>> diff --git a/drivers/gpu/drm/msm/dp/dp_catalog.h b/drivers/gpu/drm/msm/dp/dp_catalog.h
>> index 82376a2..38786e8 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_catalog.h
>> +++ b/drivers/gpu/drm/msm/dp/dp_catalog.h
>> @@ -104,7 +104,8 @@ bool dp_catalog_ctrl_mainlink_ready(struct dp_catalog *dp_catalog);
>>   void dp_catalog_ctrl_enable_irq(struct dp_catalog *dp_catalog, bool enable);
>>   void dp_catalog_hpd_config_intr(struct dp_catalog *dp_catalog,
>>   			u32 intr_mask, bool en);
>> -void dp_catalog_ctrl_hpd_config(struct dp_catalog *dp_catalog);
>> +void dp_catalog_ctrl_hpd_enable(struct dp_catalog *dp_catalog);
>> +void dp_catalog_ctrl_hpd_disable(struct dp_catalog *dp_catalog);
>>   void dp_catalog_ctrl_config_psr(struct dp_catalog *dp_catalog);
>>   void dp_catalog_ctrl_set_psr(struct dp_catalog *dp_catalog, bool enter);
>>   u32 dp_catalog_link_is_connected(struct dp_catalog *dp_catalog);
>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>> index 3e13acdf..69bbc5f 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>> @@ -615,12 +615,6 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
>>   		dp->hpd_state = ST_MAINLINK_READY;
>>   	}
>>   
>> -	/* enable HDP irq_hpd/replug interrupt */
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog,
>> -					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
>> -					   true);
>> -
>>   	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
>>   			dp->dp_display.connector_type, state);
>>   	mutex_unlock(&dp->event_mutex);
>> @@ -658,12 +652,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>>   	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>>   			dp->dp_display.connector_type, state);
>>   
>> -	/* disable irq_hpd/replug interrupts */
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog,
>> -					   DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_REPLUG_INT_MASK,
>> -					   false);
>> -
>>   	/* unplugged, no more irq_hpd handle */
>>   	dp_del_event(dp, EV_IRQ_HPD_INT);
>>   
>> @@ -687,10 +675,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>>   		return 0;
>>   	}
>>   
>> -	/* disable HPD plug interrupts */
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, false);
>> -
>>   	/*
>>   	 * We don't need separate work for disconnect as
>>   	 * connect/attention interrupts are disabled
>> @@ -706,10 +690,6 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
>>   	/* signal the disconnect event early to ensure proper teardown */
>>   	dp_display_handle_plugged_change(&dp->dp_display, false);
>>   
>> -	/* enable HDP plug interrupt to prepare for next plugin */
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_PLUG_INT_MASK, true);
>> -
>>   	drm_dbg_dp(dp->drm_dev, "After, type=%d hpd_state=%d\n",
>>   			dp->dp_display.connector_type, state);
>>   
>> @@ -1082,26 +1062,6 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
>>   	mutex_unlock(&dp_display->event_mutex);
>>   }
>>   
>> -static void dp_display_config_hpd(struct dp_display_private *dp)
>> -{
>> -
>> -	dp_display_host_init(dp);
>> -	dp_catalog_ctrl_hpd_config(dp->catalog);
>> -
>> -	/* Enable plug and unplug interrupts only if requested */
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog,
>> -				DP_DP_HPD_PLUG_INT_MASK |
>> -				DP_DP_HPD_UNPLUG_INT_MASK,
>> -				true);
>> -
>> -	/* Enable interrupt first time
>> -	 * we are leaving dp clocks on during disconnect
>> -	 * and never disable interrupt
>> -	 */
>> -	enable_irq(dp->irq);
> 
> ...we need dp->irq enabled for handling the other interrupts, otherwise
> e.g. AUX transfers will time out.
> 
> I added enable_irq(dp_priv->irq) to the EV_HPD_INIT_SETUP case below,
> just for testing, and with that the patch seems to be working fine.
> 
> 
> Is there any reason why we need to delay its enablement to after we
> unmask the HPD interrupts?

As I wrote, I'd probably prefer to see enable_irq() and disable_irq() 
calls gone.

> 
> Regards,
> Bjorn
> 
>> -}
>> -
>>   void dp_display_set_psr(struct msm_dp *dp_display, bool enter)
>>   {
>>   	struct dp_display_private *dp;
>> @@ -1176,7 +1136,7 @@ static int hpd_event_thread(void *data)
>>   
>>   		switch (todo->event_id) {
>>   		case EV_HPD_INIT_SETUP:
>> -			dp_display_config_hpd(dp_priv);
>> +			dp_display_host_init(dp_priv);
>>   			break;
>>   		case EV_HPD_PLUG_INT:
>>   			dp_hpd_plug_handle(dp_priv, todo->data);
>> @@ -1394,13 +1354,8 @@ static int dp_pm_resume(struct device *dev)
>>   	/* turn on dp ctrl/phy */
>>   	dp_display_host_init(dp);
>>   
>> -	dp_catalog_ctrl_hpd_config(dp->catalog);
>> -
>> -	if (dp->dp_display.internal_hpd)
>> -		dp_catalog_hpd_config_intr(dp->catalog,
>> -				DP_DP_HPD_PLUG_INT_MASK |
>> -				DP_DP_HPD_UNPLUG_INT_MASK,
>> -				true);
>> +	if (dp_display->is_edp)
>> +		dp_catalog_ctrl_hpd_enable(dp->catalog);
>>   
>>   	if (dp_catalog_link_is_connected(dp->catalog)) {
>>   		/*
>> @@ -1568,7 +1523,7 @@ static int dp_display_get_next_bridge(struct msm_dp *dp)
>>   
>>   	if (aux_bus && dp->is_edp) {
>>   		dp_display_host_init(dp_priv);
>> -		dp_catalog_ctrl_hpd_config(dp_priv->catalog);
>> +		dp_catalog_ctrl_hpd_enable(dp_priv->catalog);
>>   		dp_display_host_phy_init(dp_priv);
>>   		enable_irq(dp_priv->irq);
>>   
>> @@ -1801,16 +1756,33 @@ void dp_bridge_hpd_enable(struct drm_bridge *bridge)
>>   {
>>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>>   	struct msm_dp *dp_display = dp_bridge->dp_display;
>> +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
>> +
>> +	mutex_lock(&dp->event_mutex);
>> +	dp_catalog_ctrl_hpd_enable(dp->catalog);
>> +
>> +	/* enable HDP interrupts */
>> +	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, true);
>> +
>> +	enable_irq(dp->irq);
>>   
>>   	dp_display->internal_hpd = true;
>> +	mutex_unlock(&dp->event_mutex);
>>   }
>>   
>>   void dp_bridge_hpd_disable(struct drm_bridge *bridge)
>>   {
>>   	struct msm_dp_bridge *dp_bridge = to_dp_bridge(bridge);
>>   	struct msm_dp *dp_display = dp_bridge->dp_display;
>> +	struct dp_display_private *dp = container_of(dp_display, struct dp_display_private, dp_display);
>> +
>> +	mutex_lock(&dp->event_mutex);
>> +	/* disable HDP interrupts */
>> +	dp_catalog_hpd_config_intr(dp->catalog, DP_DP_HPD_INT_MASK, false);
>> +	dp_catalog_ctrl_hpd_disable(dp->catalog);
>>   
>>   	dp_display->internal_hpd = false;
>> +	mutex_unlock(&dp->event_mutex);
>>   }
>>   
>>   void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>> -- 
>> 2.7.4
>>

-- 
With best wishes
Dmitry

