Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4CD6E86F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 02:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDTAu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 20:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjDTAuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 20:50:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A05FE9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:49:34 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h4so1013284ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681951771; x=1684543771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBTNgbwSnEqrTM/8Zo3F3tUjXoH2/yS/Mjd7eOQXnxA=;
        b=d4mVL2ra6uk1DxPznvuIlP+NohLtEcADu43dZmKn68AbF9I1zDQUZtYdsL9Ka0fhK3
         yBoz6Y7I3MnVwjpbhFc9Th4t+ZXspnyWt7Lc6y12HI5yaJ6oqi4MJEWpl1d7uYP8stbM
         LNKY3VIrY9nuQjCTDZIOnB5RGi61FRnWR7cQ4mUK/Zf7IQ/ucseIb93BUhbJqZoJKQ/m
         z7tRSVl+KOi6Rk5qzuPo+pDa1Dr99MX2uMLjhsgfGnfHbDtTrro1EULq4qpm9VahfKvA
         VpcozY7D8YtZNPLSSDC+bUNOOjPLdDTCgCy4RrCInmG9axwD2Gd/JZj5qr3K9X17LUen
         jbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681951771; x=1684543771;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBTNgbwSnEqrTM/8Zo3F3tUjXoH2/yS/Mjd7eOQXnxA=;
        b=OcRMczysmgOKmZPQn2t/AiV8J/UEaFNt3P+T0EF3sFr6u7RkgC81RBrb4yMZSAp2im
         A/ulMD0qRaQSS2L0xYJ8jZqvAHcxVFP8pv1eqYA5mJkrzWlcR1eWFZUMIo0YD7+X6BUz
         F65wGEVcr8mRYwKqWLh9nRgoDJAQKjtGM2wMEV3wWUo3aZNnbhF+Ijc+hBAq/Mo4M/bd
         3A61HqrRL1CmJ8dvZIGDz8Ohia3owp7zQS/9SyiZ+Ydy1DVez1xlKyG9cgQ4zJjvyoh3
         ZNISEK/0hZdYExTKnJVKtRzfdvyN/dqHZ7+qIqa7HRlSwv2BNIZY15tROtMnYtoK2tXZ
         G2dA==
X-Gm-Message-State: AAQBX9cBuPEx2VrywZ2WKDNwH8tCbK3f5wTw4JQTRmF+2HB73DymkMxu
        0UaGloW9RGonkMCA9M/zxx0Wfg==
X-Google-Smtp-Source: AKy350a58zmn+YohNF/dZT6zaO4ejf273w1HbL0Zriw2gCHMn/70LvEy/Q0m9ouzpmYgb6kSJCE2QA==
X-Received: by 2002:a2e:6e0f:0:b0:2a8:bd3a:d418 with SMTP id j15-20020a2e6e0f000000b002a8bd3ad418mr2264178ljc.52.1681951771044;
        Wed, 19 Apr 2023 17:49:31 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w4-20020a2e9584000000b002a8bae7f9e8sm17599ljh.129.2023.04.19.17.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:49:30 -0700 (PDT)
Message-ID: <c4344301-2c89-3b8b-2a5c-e6523f078fd9@linaro.org>
Date:   Thu, 20 Apr 2023 03:49:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 09/17] drm/msm/dpu: Move autorefresh disable from CMD
 encoder to pingpong
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Adam Skladowski <a39.skl@gmail.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Robert Foss <rfoss@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Archit Taneja <architt@codeaurora.org>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>
References: <20230411-dpu-intf-te-v2-0-ef76c877eb97@somainline.org>
 <20230411-dpu-intf-te-v2-9-ef76c877eb97@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230411-dpu-intf-te-v2-9-ef76c877eb97@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2023 23:21, Marijn Suijten wrote:
> This autorefresh disable logic in the physical command-mode encoder
> consumes three callbacks to the pingpong block, and will explode in
> unnecessary complexity when the same callbacks need to be called on the
> interface block instead to accommodate INTF TE support.  To clean this
> up, move the logic into the pingpong block under a disable_autorefresh
> callback, replacing the aforementioned three get_autorefresh,
> setup_autorefresh and get_vsync_info callbacks.
> 
> The same logic will have to be replicated to the interface block when it
> receives INTF TE support, but it is less complex than constantly
> switching on a "has_intf_te" boolean to choose a callback.
> 
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   | 60 ++--------------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    | 47 +++++++++++++++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    | 25 ++-------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |  4 ++
>   4 files changed, 57 insertions(+), 79 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

