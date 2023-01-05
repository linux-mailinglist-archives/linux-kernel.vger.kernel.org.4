Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F281C65ECA9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 14:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjAENQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 08:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbjAENQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 08:16:17 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431795AC6B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 05:16:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b3so54986229lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 05:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxxqW2U4VV6Fh7w9J7Z3fimLOgBH/JK80j7RpKFTc0s=;
        b=PTD+Rt+3JSezzXjzDA6SPux9bO6VcdDD8B2UgufvaMXU3gdVRYcPaslvOzToI9taoV
         WAzYP6ZU2BVVl6y0U6c/lxb7XMIp3KC9LOyYTzs7WFpTu2XSyJKULd04UAMcecEvZGPc
         8WMunjDLIltqmrGC+q2GTZ8ZvlrrBfyd4aYv5D728gGh4DTTZ6InRTDX1N16v2LjkJFO
         SYeTQp73rcmExGawY3JyaASMUhtjV6KmGmx8eO5wGfMRO7cX1KJ1gThqY76yARojMNa2
         sZL918uFGQcoBmSeWxfluV9RNSLALNZ1iriTGu1mE5oCjv6gPw6qfidt4XlfeDrduZ/S
         PaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JxxqW2U4VV6Fh7w9J7Z3fimLOgBH/JK80j7RpKFTc0s=;
        b=470Wj7iYrBuM/tOT/xQiw8xodj7o+kHXNWi85v6eQHX9/43Z+WitKYjF52XRIvlNeo
         JIlFdS3teRhcPN1uMDVR58K9I1+HHgS6P/b+97glKfVGdPCF/Ltt8veSEtyBKNva23FX
         yt6Uf/2sMxcIJOJYQMV7u8f/sfqFONs3IPJuJ+VlS5zfsun6eC2UQRnL6QKBvBIzGZss
         Ss0utZAdIh6Eytv2bDZWth0RZV1tnGYuTf0Bdtu5xpAfNrESjKpHZsn7z9bcyBZWu4dn
         9NnrUZo+PN9BZ5VADK5g1lZEmaZz2AjMr+VLKhcSdfS7ZOX5aTMMpWiOlsSb0O+kDI/c
         J9MA==
X-Gm-Message-State: AFqh2konmwoGl77RhDmczo5p+ygd1YFqljhp+r+7vJxohu9e2Zb34GxB
        LzlsDF/Dti6bGYa4t7TI/qP5tA==
X-Google-Smtp-Source: AMrXdXvbg2vxFXLTao4kRQnA/Il84ArFmU6NTMdpRsur7+pI2j1P8LoLMHueA5P1bWzcYWx6nOx5tw==
X-Received: by 2002:ac2:4c8e:0:b0:4b6:ee97:36d2 with SMTP id d14-20020ac24c8e000000b004b6ee9736d2mr14003242lfl.40.1672924572561;
        Thu, 05 Jan 2023 05:16:12 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id o5-20020ac24e85000000b004c2e1d7d9a3sm5469102lfr.146.2023.01.05.05.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 05:16:12 -0800 (PST)
Message-ID: <47cd5078-f994-e05a-624c-4e221dc74294@linaro.org>
Date:   Thu, 5 Jan 2023 15:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 08/15] drm/bridge: add psr support for panel bridge
 callbacks
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        quic_kalyant@quicinc.com, quic_sbillaka@quicinc.com,
        quic_bjorande@quicinc.com, quic_abhinavk@quicinc.com,
        quic_vproddut@quicinc.com, quic_khsieh@quicinc.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        quic_aravindh@quicinc.com, swboyd@chromium.org
References: <1671012352-1825-1-git-send-email-quic_vpolimer@quicinc.com>
 <1671012352-1825-9-git-send-email-quic_vpolimer@quicinc.com>
 <Y7bMcLHr79uhfJv2@phenom.ffwll.local>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y7bMcLHr79uhfJv2@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 15:11, Daniel Vetter wrote:
> On Wed, Dec 14, 2022 at 03:35:45PM +0530, Vinod Polimera wrote:
>> This change will handle the psr entry exit cases in the panel
>> bridge atomic callback functions. For example, the panel power
>> should not turn off if the panel is entering psr.
>>
>> Signed-off-by: Sankeerth Billakanti <quic_sbillaka@quicinc.com>
>> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> 
> I think this is all a nice integration of the sr helpers and bridge stuff
> and makes sense to me. For the 2 bridge patches and the drm core atomic
> patch:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thank you! I was looking at the patchset and wondering if anybody from 
drm core can actually review the core bits.

Could you please send all r-b letters, so that we don't loose them when 
applying the patches from patchwork?

> 
>> ---
>>   drivers/gpu/drm/bridge/panel.c | 48 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
>> index 3558cbf..5e77e38 100644
>> --- a/drivers/gpu/drm/bridge/panel.c
>> +++ b/drivers/gpu/drm/bridge/panel.c
>> @@ -113,6 +113,18 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
>>   				struct drm_bridge_state *old_bridge_state)
>>   {
>>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
>> +	struct drm_encoder *encoder = bridge->encoder;
>> +	struct drm_crtc *crtc;
>> +	struct drm_crtc_state *old_crtc_state;
>> +
>> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
>> +	if (!crtc)
>> +		return;
>> +
>> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
>> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
>> +		return;
>>   
>>   	drm_panel_prepare(panel_bridge->panel);
>>   }
>> @@ -121,6 +133,18 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
>>   				struct drm_bridge_state *old_bridge_state)
>>   {
>>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
>> +	struct drm_encoder *encoder = bridge->encoder;
>> +	struct drm_crtc *crtc;
>> +	struct drm_crtc_state *old_crtc_state;
>> +
>> +	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
>> +	if (!crtc)
>> +		return;
>> +
>> +	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
>> +	if (old_crtc_state && old_crtc_state->self_refresh_active)
>> +		return;
>>   
>>   	drm_panel_enable(panel_bridge->panel);
>>   }
>> @@ -129,6 +153,18 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
>>   				struct drm_bridge_state *old_bridge_state)
>>   {
>>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
>> +	struct drm_encoder *encoder = bridge->encoder;
>> +	struct drm_crtc *crtc;
>> +	struct drm_crtc_state *new_crtc_state;
>> +
>> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
>> +	if (!crtc)
>> +		return;
>> +
>> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
>> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
>> +		return;
>>   
>>   	drm_panel_disable(panel_bridge->panel);
>>   }
>> @@ -137,6 +173,18 @@ static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
>>   				struct drm_bridge_state *old_bridge_state)
>>   {
>>   	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
>> +	struct drm_atomic_state *atomic_state = old_bridge_state->base.state;
>> +	struct drm_encoder *encoder = bridge->encoder;
>> +	struct drm_crtc *crtc;
>> +	struct drm_crtc_state *new_crtc_state;
>> +
>> +	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
>> +	if (!crtc)
>> +		return;
>> +
>> +	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
>> +	if (new_crtc_state && new_crtc_state->self_refresh_active)
>> +		return;
>>   
>>   	drm_panel_unprepare(panel_bridge->panel);
>>   }
>> -- 
>> 2.7.4
>>
> 

-- 
With best wishes
Dmitry

