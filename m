Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA502645D4A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLGPKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiLGPKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:10:20 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB595B84E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 07:10:19 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 1so15539057lfz.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gz835eZGCRh+WN94zvl6mcTbQaOnylgv5MAXmXuctaA=;
        b=hLy25wjMTZVgYcoxzL3Cb7C8Pugw+mR3COLvCuzmqQrdWLQsAKElUAskEgYL8f7PWF
         U97C2da1LE1ja5UO+VT/v+WwoJKFBQUZC3GD/8oJH5ilIwgO7WuD0ehxLPSxyYuPuAL6
         WUgi843gP1R2xX5Y6RWNJq0hsS9tLn8UZQY8+0ejRyQzYTggH9SvG+r5AVhwE8MgJqPo
         Uk6/J4rgvut0WCS+AcPZ3M0eSQBSpPZVuzzX8lmyEJkTH8+Y8BVJv2CzJ7VDvCWHbWeC
         La2ZO0fBZS11c78YGu8OLRWALizkVgfvCd12ggGikVcFPl+zIUt5Q2us/g1l6JRRs8qP
         B1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gz835eZGCRh+WN94zvl6mcTbQaOnylgv5MAXmXuctaA=;
        b=one86VuZuvTsjvWFVOdKA+arPcRtFj4JO3l9bchFdH+OBCTdiKA+uj9vDceYwYhzN/
         rS7QRk2qV3/Fay2qd+xM/HGiNGWYOdzLiE26vhdL3WOAdCk3K2qC4bqE/MQkppwBi58t
         z32Ahtty0B7YJrXS21S53WP2EPRW8WnWL/G12lEfbNJGFa4o5psohO8Bb9vXiQPB4tDq
         hd3SDO8V7BnE5MLppD6MKcXsNONfQaI7yuXY/hSxb9+A5+xdhgW7ipIrs+fte6NGjTF0
         nJ9yKUwbGSqBnqfZXN8WT/zVzCuNRW+gmRBtGVxDl5cmVnGezERnKFgFyF95Pbl8ldn0
         XULQ==
X-Gm-Message-State: ANoB5pn7fMaTOpsaUaudTq+tRttlTKD1kV8K9V2MED065d58hUKsY7M/
        LLxI5ccjFms6tvj4EbEx/Q0AVg==
X-Google-Smtp-Source: AA0mqf6OCTBZrdnGnAV0vkexyBgE3U7veOZQevyMSaWAqlIRtTzXIxeaaUlEaUEDfDoQYoVt0dwl3Q==
X-Received: by 2002:a19:4f4a:0:b0:4b5:5c01:76c4 with SMTP id a10-20020a194f4a000000b004b55c0176c4mr6570229lfk.56.1670425817552;
        Wed, 07 Dec 2022 07:10:17 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b0049fff3f645esm2877310lfa.70.2022.12.07.07.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:10:17 -0800 (PST)
Message-ID: <67c99b1b-5da1-861e-f5ad-d8db3e06b866@linaro.org>
Date:   Wed, 7 Dec 2022 17:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 2/3] drm/msm/disp/dpu1: add helper to know if display
 is builtin
Content-Language: en-GB
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, quic_abhinavk@quicinc.com
References: <1669021695-4397-1-git-send-email-quic_kalyant@quicinc.com>
 <1669021695-4397-3-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1669021695-4397-3-git-send-email-quic_kalyant@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 11:08, Kalyan Thota wrote:
> Since DRM encoder type for few encoders can be similar
> (like eDP and DP), get the connector type for a given
> encoder to differentiate between builtin and pluggable
> displays.
> 
> Changes in v1:
> - add connector type in the disp_info (Dmitry)
> - add helper functions to know encoder type
> - update commit text reflecting the change
> 
> Changes in v2:
> - avoid hardcode of connector type for DSI as it may not be true (Dmitry)
> - get the HPD information from encoder bridge
> 
> Changes in v3:
> - use connector type instead of bridge ops in determining
> connector (Dmitry)
> 
> Changes in v4:
> - get type from the drm connector rather from bridge connector (Dmitry)
> 
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 26 ++++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  6 ++++++
>   2 files changed, 32 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

