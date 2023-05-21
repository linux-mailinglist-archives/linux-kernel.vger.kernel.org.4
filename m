Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D370ABB6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjEUABt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjEUABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 20:01:44 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6D6EA
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 17:01:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af24ee004dso24207341fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684627298; x=1687219298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhHFF+I9itHk7q02MfL6eP2c+lYCwKwlb36uQkoEo9A=;
        b=V0qSG1ktvYe9blNJveMjWucQJZVwefISdU363LoGwpFPPLCa/JY6/4ZtlJ1WhzrGep
         zzxVpl1XBD4rzvZjuMyKob2BXOnxvYBmYrRZHZkethyBmzmSwRzezd982JBHb7z830OA
         LWnBAozc/VQNi7DvxiEl0LrI6VEg3Aax7fwbP5quFwR8GasL9xKwY8F0bQvvTyzFUmKf
         loQhcHnvoaESMwzAZ8/Ttt3ok8a+s0NwufZqxA3SWA+VySDN9I/j0vAdK4pnOZGn9/CC
         jmpoFyNSG+fIcbvWyB0WFUYxRzlzbTqc8f+CXpJ6RaRLbvf907U6ipWBZ9CnhuvzzQwK
         JjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684627298; x=1687219298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhHFF+I9itHk7q02MfL6eP2c+lYCwKwlb36uQkoEo9A=;
        b=gEze9w223ynJgdoXzCtOkGDmjC/VLNRrM32mFRsWQ1yLimmG1rxZejcCbx8fnuxWIL
         FfYazgEpJtDwCiItsK/NARArHrfLm5CU0ARMfqpDHuCX1Ge0V9RJBO/ExD3c9y2xKvN3
         qSu2b2lrzf7L02VtcD3HixQNC6r0fgn3PcibRSw6AmB7YweLPY6+AVVflVOObzFfx2Vq
         LQW8JY4Nb2ZKz/EIg6J2JNHawO4MUTiqWHzQLiSSXZachVpLjEcWjaZ/rAM1eLpEZvlm
         +ceEnp1B4i1b+L3BqIkz30i2rgBnWB3tFbZOA14FpdanpQ8U21RVkyoNFMVlaEZNSqP5
         bagA==
X-Gm-Message-State: AC+VfDyefeoyK35iUxKstMLMKN43E8ybtcE6IsQHdapp51N4R0pf0AYC
        asqdmMGSmNcBlatCj5nCXWAfKA==
X-Google-Smtp-Source: ACHHUZ44FKOqvfM6G1aCOIoZiD/9C+PWsjCp90qta9Eul9ReiyZmASMzYYR/LuQJRg0F9rAZ5txxWA==
X-Received: by 2002:a2e:9c0e:0:b0:2af:3f7:53fe with SMTP id s14-20020a2e9c0e000000b002af03f753femr2059520lji.50.1684627298093;
        Sat, 20 May 2023 17:01:38 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id q7-20020a2e9147000000b002ad9057fd00sm491399ljg.85.2023.05.20.17.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 May 2023 17:01:37 -0700 (PDT)
Message-ID: <115de0ee-f0bb-84e2-9bb7-00e23641bcb7@linaro.org>
Date:   Sun, 21 May 2023 03:01:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 9/9] drm/msm: Wire up comm/cmdline override for fdinfo
Content-Language: en-GB
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230515143023.801167-1-robdclark@gmail.com>
 <20230515143023.801167-10-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230515143023.801167-10-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 17:30, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Also store the override strings in drm_file so that fdinfo can display
> them.  We still need to keep our original copy as we could need these
> override strings after the device file has been closed and drm_file
> freed.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_gpu.c | 24 +++++++++++++++++++++++-
>   drivers/gpu/drm/msm/msm_drv.c           |  2 ++
>   drivers/gpu/drm/msm/msm_gpu.h           | 10 ++++++++++
>   3 files changed, 35 insertions(+), 1 deletion(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

