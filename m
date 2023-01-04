Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5918A65D004
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbjADJzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjADJyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:54:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7F1A210
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:54:46 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bq39so41872625lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lGymOcmvjztFSrsDIPPnkc9ypwqNV4szFQWVAo+Nv0=;
        b=wrLrTmawq1oU2fiT7/gDOjYH3EBDHAg0Zf6LWP+1d6Jkwxtwx2XoB4DxXq11DnuHcx
         qtaOQkktOqmZVAAyMfdpPQuWAzMS6wyD3Hu64VAMmRaFwLwkuxT287PQ/bD+qmxsfyJR
         lSkq225UmE1e5sCSd8w884NWquG7X8Vk3CrKOtk2WZ8jfl4CoopoDY8l193ZIpJ4I7SU
         3SSL1c9e0J2QlylIpiYm9jrw75H94t5otKYVv2/w4w7CSaZhlfYuBALQt0L6fGI/6loI
         yfm8uJxKCeiMlNTvsZwXN4fcPbRw9872X/ZsignjBA3pmEqDf702JkmVPIcZ4kidgaMK
         iT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4lGymOcmvjztFSrsDIPPnkc9ypwqNV4szFQWVAo+Nv0=;
        b=oiCaCqXOtg0rCl/9pwzZajf6LSntnd/+heb0LpV88K4ptSptf8f8by4rKj4Q2nAWP/
         BlCrOACn1G19fvX6jQq8xTSJ6fLcst7ADWQYSGhwvLxN9t7TNVixkmyP3fZgmHxjAssW
         XHq/9l2pwIpN2Let41UeGjLN0c5GePfSmBGv5mpTC6lpeZN2KnjcrifgpbymrCLmm1D2
         0MDkbunU445/TpV7107AS5HXLLwqfJN7v+rKbCE/gnFpFHcztujQ0Y+EBPDBEshNFFjb
         JuoeJ2o3Um1nTWuJK2/DHtOsKa+m47Dtt5T1xKKzdxRzj1dvpRY+VBWTTfgtjlp0paNk
         +kIA==
X-Gm-Message-State: AFqh2koGoThgI10/+3bIdJpK06fXY/RXKjwHfhRspDqWPKSZ8nidXbEw
        hJ1Q02/Z+mhnU0em5ZiCtaldfQ==
X-Google-Smtp-Source: AMrXdXuMRvcW9cAuZpYschkUp+WliOChT7va8boh/7yy0fIGJjXZrFJ0PPnG4SqQ6e1hWEgzSodGNg==
X-Received: by 2002:a05:6512:33c4:b0:4cc:53e2:5387 with SMTP id d4-20020a05651233c400b004cc53e25387mr287330lfg.50.1672826085086;
        Wed, 04 Jan 2023 01:54:45 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u5-20020a056512040500b004cb0d7804a7sm3293699lfk.192.2023.01.04.01.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 01:54:44 -0800 (PST)
Message-ID: <d34852d2-3c6f-02fc-280a-d679600a32ea@linaro.org>
Date:   Wed, 4 Jan 2023 11:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 6/6] drm/msm/dsi: add support for DSI 2.7.0
Content-Language: en-GB
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-mdss-dsi-v1-0-9ccd7e652fcd@linaro.org>
 <20230103-topic-sm8550-upstream-mdss-dsi-v1-6-9ccd7e652fcd@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v1-6-9ccd7e652fcd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/2023 11:08, Neil Armstrong wrote:
> Add support for DSI 2.7.0 (block used on sm8550).
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 16 ++++++++++++++++
>   drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
>   2 files changed, 17 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

