Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4D6A50A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1BZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjB1BZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:25:09 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462819F3F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:25:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f18so11134578lfa.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghYbiuae4Giu+YY0fM4G+aB2s++oD+nzVOPNd25Xma4=;
        b=ZsNE9/X4m10iwSCMrF45bZNPFSRZQ4XC2BhOn+5am/qoDxM1N+MUMpIqxtyahf+Zdf
         Z2QTGpvwr3BkO5dpBpjzXq/jFtiS+bfmDcmyKBdMH9MaleR2/R4QuTKvscdD93fjYVZ2
         XFRIy4bU/FvS39m2fbfxas4tjymDj0EmH+qhvghhmhcuquWYcYZhfLgyHVEaFpIcAatG
         r4iI/3de3AjNEWUXONWJLYbya0WWdON5VXajSU9XNpVv3vi44+ya3zEp9pSuah1Os713
         Qaw6IfL32ckKBryHSL1ZM3+/RFT9zLRjNgbMzTb8WMu/tLiF/Vf1Hr9DYkmhHfO/Ytd+
         OlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghYbiuae4Giu+YY0fM4G+aB2s++oD+nzVOPNd25Xma4=;
        b=gyKfL710W7Uo5QZxxTAlC0soULelNq7QGA2NON+bBCCJ5yY/686bJXxz1y/Y0SoZEg
         eCG9ksIcH7dyQMIljGLDjz+pWXfCRYnjlfBi/q8lzxcjoptSNt0CyJdc2lI5grVEKWF/
         gCW8+PEpbPdkH909+BKJ3EK1ZOI5CEYU9WtYwZFFJLLKiLtsROuO0A86lEWkRgmakRdQ
         T8H16g+Azzna1aox87QIcVuM1euWHFuVHzOWp8a74iq2epwIv2vmv+Ma3A2d6zdGW0a7
         dSaFLruz5i0LS6kcjbz6ALhMZYdjU/jIW/nnTS3ZUqrtjf8ppxFyciGHAJuAv5rGV7vl
         +p0A==
X-Gm-Message-State: AO0yUKV9xx8bLkI8/A+5Yz0Wiqif1NeFeZrWCdfkfO1PVUXNhISmO+RW
        mKzmhhf7GHAeeLBZV4IenoM2bg==
X-Google-Smtp-Source: AK7set9Roec5f/bQctSsNwIs9OaAY+Pi+BG6vxc3tJornTJbXlbPWDeaF84mA+daLoyX75ZJopcF6Q==
X-Received: by 2002:a19:f610:0:b0:4db:5122:2099 with SMTP id x16-20020a19f610000000b004db51222099mr128874lfe.32.1677547503901;
        Mon, 27 Feb 2023 17:25:03 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id b10-20020a056512024a00b004db3890cb4bsm1114243lfo.94.2023.02.27.17.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 17:25:03 -0800 (PST)
Message-ID: <259334b9-b255-004a-9772-8b252579a37c@linaro.org>
Date:   Tue, 28 Feb 2023 03:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RFT PATCH v2 1/3] drm/bridge: tc358762: Set
 pre_enable_prev_first
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230131141756.RFT.v2.1.I723a3761d57ea60c5dd754c144aed6c3b2ea6f5a@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 00:18, Douglas Anderson wrote:
> Set the "pre_enable_prev_first" as provided by commit 4fb912e5e190
> ("drm/bridge: Introduce pre_enable_prev_first to alter bridge init
> order"). This should allow us to revert commit ec7981e6c614
> ("drm/msm/dsi: don't powerup at modeset time for parade-ps8640") and
> commit 7d8e9a90509f ("drm/msm/dsi: move DSI host powerup to modeset
> time").
> 
> Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

