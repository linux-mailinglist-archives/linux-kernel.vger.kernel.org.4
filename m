Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0946AE179
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCGNzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCGNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:54:52 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ED82728
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:54:46 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m6so17162212lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678197284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aPmjHWuFuv6F58SfS5GxDfQIhMMuuYwG2pBnFif7yZ0=;
        b=srAh3UY2X3KYEtRhNoUJNsIrQDH4MKtAoQSMWOyGQ9+J9yhh6E1rNbNOegLd2Xy9qO
         iOcikU8KOQLt4BePPYM2r6pDvf9DUjhTjTp/Vpl7+RNgpGldmQPgGFO8VYDrUQaQ/Bor
         4lElfdkPTR31BgJO+cm2Hy1HdwhJvGpnnMIyDI7aCQ8h0/eHgYFLPK19weJyCk5RKf42
         BJ24ZBBU+ZBGz9wX6LyMKKuhasggHPa5SqbCIh2naFmay6qtL803A7QVfuAEuA89Az5z
         Xta002DhwcEhIatRtC8tL24u7YpJ2ZxqJixKXndSwTuNS5uK/vom3SF90yba8fSStgI0
         u6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678197284;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPmjHWuFuv6F58SfS5GxDfQIhMMuuYwG2pBnFif7yZ0=;
        b=GHYDk8+hCFij6CCmhIfrTiVp0xyESCQxbpRUnIn0d+p+GTtn866HY6TojT0AWJznPP
         v+2YHRyC/eVrTGiXmP48S9fXZtL3CdIxipQUIOct234Q8QkMhJM2p8OpVQ5UguY4V8FO
         tA06OGAbgaMLtGVnIVBbu0EfbPjabED3SrgCc92p9Hd8IyurMDd3WjJQlDTPFQkMQtIX
         U4cqhMPh8jA3+gffVswMExGVovYkzxNundx4jTe8Nqr8xuutciNqlgp1MzIQJ7PtgNou
         0PyJFebFjSuP8dhRlgGeriTzMQi/hbUtTAr6dnYcmVvSs3B0qFWoadvh8380iL6kPGsy
         uWtQ==
X-Gm-Message-State: AO0yUKWWoIPDytxyLCQ3wCtNQeNwbWnHqj6gsIZaPmfplrqZNTuGSaSH
        G7itYvVHyZw0sGRQMzXRcSfs+g==
X-Google-Smtp-Source: AK7set+rcXfy6mfYYqPaxyRmMJjEFrUAW5fRIvhtFGjTsQMKNImU//9d5pU6vay7STdcZ6FJNJgaHg==
X-Received: by 2002:ac2:46c8:0:b0:4e0:6e01:7ebe with SMTP id p8-20020ac246c8000000b004e06e017ebemr4171993lfo.36.1678197284220;
        Tue, 07 Mar 2023 05:54:44 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q9-20020ac25149000000b004dda74eccafsm2054843lfd.68.2023.03.07.05.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 05:54:43 -0800 (PST)
Message-ID: <b3d3a70a-6f6b-e7ff-cf0c-cb0093212a3b@linaro.org>
Date:   Tue, 7 Mar 2023 15:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v14 00/14] Add PSR support for eDP
Content-Language: en-GB
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, quic_bjorande@quicinc.com,
        quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
References: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1677774797-31063-1-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David, Daniel & other drm maintainers,

On 02/03/2023 18:33, Vinod Polimera wrote:

[skipped the changelog]

> Vinod Polimera (14):
>    drm: add helper functions to retrieve old and new crtc
>    drm/bridge: use atomic enable/disable callbacks for panel bridge
>    drm/bridge: add psr support for panel bridge callbacks

The first three patches are generic. How do we merge this series? I 
think these three patches should be merged into an immutable branch at 
drm-misc (or any other drm tree), which we can then merge into msm-next. 
What do you think?

>    drm/msm/disp/dpu: check for crtc enable rather than crtc active to
>      release shared resources
>    drm/msm/disp/dpu: get timing engine status from intf status register
>    drm/msm/disp/dpu: wait for extra vsync till timing engine status is
>      disabled
>    drm/msm/disp/dpu: reset the datapath after timing engine disable
>    drm/msm/dp: use atomic callbacks for DP bridge ops
>    drm/msm/dp: Add basic PSR support for eDP
>    drm/msm/dp: use the eDP bridge ops to validate eDP modes
>    drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
>      functions
>    drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
>    drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable
>      during self refresh
>    drm/msm/dp: set self refresh aware based on psr support
> 
>   drivers/gpu/drm/bridge/panel.c                     |  68 +++++++-
>   drivers/gpu/drm/drm_atomic.c                       |  60 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |  40 ++++-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  26 +++-
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  22 +++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   3 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |  12 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   8 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +-
>   drivers/gpu/drm/msm/dp/dp_catalog.c                |  80 ++++++++++
>   drivers/gpu/drm/msm/dp/dp_catalog.h                |   4 +
>   drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  80 ++++++++++
>   drivers/gpu/drm/msm/dp/dp_ctrl.h                   |   3 +
>   drivers/gpu/drm/msm/dp/dp_display.c                |  36 +++--
>   drivers/gpu/drm/msm/dp/dp_display.h                |   2 +
>   drivers/gpu/drm/msm/dp/dp_drm.c                    | 173 ++++++++++++++++++++-
>   drivers/gpu/drm/msm/dp/dp_drm.h                    |   9 +-
>   drivers/gpu/drm/msm/dp/dp_link.c                   |  36 +++++
>   drivers/gpu/drm/msm/dp/dp_panel.c                  |  22 +++
>   drivers/gpu/drm/msm/dp/dp_panel.h                  |   6 +
>   drivers/gpu/drm/msm/dp/dp_reg.h                    |  27 ++++
>   include/drm/drm_atomic.h                           |   7 +
>   22 files changed, 683 insertions(+), 43 deletions(-)
> 

-- 
With best wishes
Dmitry

