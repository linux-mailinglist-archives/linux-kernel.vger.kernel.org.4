Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349986A50A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjB1BZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjB1BZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:25:32 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5371B573
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:25:27 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id j17so8478786ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYhTvYPZzEGeLer7Re++n35w5MO/ZTMPUdgfAcWFn1w=;
        b=v42k3Bh9dpaRO9B1/X2b+EafrIJH25nyylYb9uEeTMHwUmeDxzFb2v1wOjsFhQZu2L
         +/lrdJ8bmA008gaVIAql6wsluwF4SQDvXmkILCEWCi4iyxCa5/NMzBJClkHhpAibUT/v
         c3ReZEazhCOQ+93Zy70u2uaWYIrmXbbF6M89ho0LVixs3Z7+moMkvSz3X1x/yuvTqPQa
         QVaJnLuOcvErKkgakWleHuoNCBE1HXjQOEv7JKQ23p8+QuVIaAdKqiwxF0RPO25i/fju
         /Ouvlha2GNxmRQDjrG2t7DI+PY/BqEy+3Q0h93dGKOM8Tz+dlmpsrsmpuo0pY/kEXpAU
         Cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYhTvYPZzEGeLer7Re++n35w5MO/ZTMPUdgfAcWFn1w=;
        b=pyZYKureDAJnbZGvID66GzoX5TIeHctojqGzjxHwCUjAeuUhoJAbbGfyxq33bAjHha
         Vq/XsyOAsNrBubxENgVoyDcGppQPQ5xACraXZ9i6yw4P5qD3ZRHm3dhS32ah/phygcNc
         xZ2v67ggbdmNNhwsianbIjPw+GPUDgnfwsg6jzkLFgM1yAuFyZ5A9ND0/hFv1qjgcwel
         HmbzqVPN0bupofatQ2gHl31GJc1JsdwoEJMECAvXzgoI0IWJP6IFTT2D2UIy150t6yum
         /nZYEyjBnTunCdtracq8Qy/6TenJgNNatcM7vVvMP0ZyHzT/9+wH/eSXsv0tDS4nDk27
         tq9w==
X-Gm-Message-State: AO0yUKUHtCbtsWqEDIqjs+F+73efiqC1gwbRNc6yB0eD/kjVAYGH/0Zm
        aI4+OhCol2G8T4alvxaXoZcdAA==
X-Google-Smtp-Source: AK7set8HWt0poqpEBnvKA789YwYaRsFJySTc6+Gq7FqVYPdnZoSOcIZFSf8cJ9a6tUbKysL80soD+w==
X-Received: by 2002:a2e:8687:0:b0:295:9f20:bcdf with SMTP id l7-20020a2e8687000000b002959f20bcdfmr317412lji.9.1677547526235;
        Mon, 27 Feb 2023 17:25:26 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id 3-20020a2e0503000000b002959aecb63bsm977824ljf.53.2023.02.27.17.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:25:25 -0800 (PST)
Message-ID: <6d2a2647-9df7-5f32-20be-d54450e058b3@linaro.org>
Date:   Tue, 28 Feb 2023 03:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFT PATCH v2 2/3] drm/msm/dsi: Stop unconditionally powering up
 DSI hosts at modeset
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        Vinod Koul <vkoul@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        freedreno@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org
References: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
 <20230131141756.RFT.v2.2.I4cfeab9d0e07e98ead23dd0736ab4461e6c69002@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230131141756.RFT.v2.2.I4cfeab9d0e07e98ead23dd0736ab4461e6c69002@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 00:18, Douglas Anderson wrote:
> In commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> time"), we moved powering up DSI hosts to modeset time. This wasn't
> because it was an elegant design, but there were no better options.
> 
> That commit actually ended up breaking ps8640, and thus was born
> commit ec7981e6c614 ("drm/msm/dsi: don't powerup at modeset time for
> parade-ps8640") as a temporary hack to un-break ps8640 by moving it to
> the old way of doing things. It turns out that ps8640 _really_ doesn't
> like its pre_enable() function to be called after
> dsi_mgr_bridge_power_on(). Specifically (from experimentation, not
> because I have any inside knowledge), it looks like the assertion of
> "RST#" in the ps8640 runtime resume handler seems like it's not
> allowed to happen after dsi_mgr_bridge_power_on()
> 
> Recently, Dave Stevenson's series landed allowing bridges some control
> over pre_enable ordering. The meaty commit for our purposes is commit
> 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to alter
> bridge init order"). As documented by that series, if a bridge doesn't
> set "pre_enable_prev_first" then we should use the old ordering.
> 
> Now that we have the commit ("drm/bridge: tc358762: Set
> pre_enable_prev_first") we can go back to the old ordering, which also
> allows us to remove the ps8640 special case.
> 
> One last note is that even without reverting commit 7d8e9a90509f
> ("drm/msm/dsi: move DSI host powerup to modeset time"), if you _just_
> revert the ps8640 special case and try it out then it doesn't seem to
> fail anymore. I spent time bisecting / debugging this and it turns out
> to be mostly luck, so we still want this patch to make sure it's
> solid. Specifically the reason it sorta works these days is because
> we implemented wait_hpd_asserted() in ps8640 now, plus the magic of
> "pm_runtime" autosuspend. The fact that we have wait_hpd_asserted()
> implemented means that we actually power the bridge chip up just a wee
> bit earlier and then the bridge happens to stay on because of
> autosuspend and thus ends up powered before dsi_mgr_bridge_power_on().
> 
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

