Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F81614269
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 01:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiKAAqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 20:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKAAqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 20:46:08 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FAE13F3A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:46:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id b9so3831761ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 17:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EArgov1X4gC3+dL4gkFRc7cqQE/ITXTDW6MPfiwBrSw=;
        b=rSH48XY/CPCA2gnjl1xJ+JY8ET4dFqjPIulTNTlhE+pBDGbNpXw5OheBHqtdnFA4tD
         Tu40Dmmf3CBU4/IAOUBn/OnUFDDf2qf7Nmq6+p5KmGlvkGuH+UMbsQofaBRyvQod1GQA
         ip3OABTYPyxh2DEVe7LjzXaez73qQwnyOOdow7Pq9rGM3SYAYJCUZ7TbnzZgteV7JWIY
         /HrKvf92vi9UKWdFTJB+/IQ2ruvH1I8ng+fESq5NKFtvOuu7qZIe9TH0607ncJqyMOF7
         K6xKuBIRv06jzk7th5N20V/KjhSHgtngajUSyEryRC7YRIKB7NpJPfyzTNCafx0ay2AW
         Jh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EArgov1X4gC3+dL4gkFRc7cqQE/ITXTDW6MPfiwBrSw=;
        b=yuxT5wNadUAG/50aoS7Yka2fhhfONFNQsAFxyTeECM7G0KuURR3XsAH72u1/fVsNci
         MUzwnYxpKkjqJWVB5bQjiBBRLM+2HIo6ZbwmzVItSgNWQ+U/oQrkYzISrxzwQCf25E/r
         0AvwsBSNq/A4NE3OM9oJ1KhNZPB4G0DrnMmHOrMQ+QU08NfNPRBCqcmePH8+1D2nwfpX
         Dxjj09qAdcg6tYZ86aIoIEVetD6jDi/WbdJp9i4l27MCTnbKdHN1TNlEyK2SLBf7HU8f
         oyn0iHSm7TEAmXGLg08h6rkezwgVvxvuD4wSWf0qGO7a9Tp3mzaFhGB6mkQFdQwfNP0n
         AA4Q==
X-Gm-Message-State: ACrzQf3/Gigg7ijn+UbvBI+5WG3o9g0J4A0GCNAE5wkmt8DRdTqifCeu
        SsVUrPNDod6a3VfY9rD9Wi16xw==
X-Google-Smtp-Source: AMsMyM4h6felVH/qGl4RpJK6aD+raP0pmoOvXFggZk3REUimptdDjbfd+YAfJHqzP0isLFRSn0uWcQ==
X-Received: by 2002:a05:651c:1306:b0:277:5cb3:7f11 with SMTP id u6-20020a05651c130600b002775cb37f11mr2627329lja.207.1667263563231;
        Mon, 31 Oct 2022 17:46:03 -0700 (PDT)
Received: from [10.27.10.248] ([195.165.23.90])
        by smtp.gmail.com with ESMTPSA id s23-20020a2e1517000000b0026dd4d3fe2asm1570196ljd.91.2022.10.31.17.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 17:46:02 -0700 (PDT)
Message-ID: <80465042-9e29-b496-78c3-70ac8f356869@linaro.org>
Date:   Tue, 1 Nov 2022 03:46:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] drm/msm/adreno: Simplify read64/write64 helpers
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221031225414.1280169-1-robdclark@gmail.com>
 <20221031225414.1280169-2-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221031225414.1280169-2-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2022 01:54, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The _HI reg is always following the _LO reg, so no need to pass these
> offsets seprately.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/a4xx_gpu.c       |  3 +--
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c       | 27 ++++++++-------------
>   drivers/gpu/drm/msm/adreno/a5xx_preempt.c   |  4 +--
>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c       | 24 ++++++------------
>   drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  3 +--
>   drivers/gpu/drm/msm/msm_gpu.h               | 12 ++++-----
>   6 files changed, 27 insertions(+), 46 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

