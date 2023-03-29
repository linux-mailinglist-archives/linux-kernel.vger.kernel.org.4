Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282DE6CCF40
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjC2BMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjC2BMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:12:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3C2685
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:12:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bi9so18114132lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680052363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bD0WuHcqP0jnnIO4Z4zALTMiyM+BdS1Or/XHCneUJyo=;
        b=PP5AoEw3qY9FLNfDXALB5T16AgDALGWht16Gax2DfReMMcjQK6ybgazwrEgRO3EALx
         TCKvNk/f1a4BGLG0tSLayZNqPA4+0BKCVru9vzqn9YOjGGoQm8UVy4iFh++Cx3D2z6dP
         l7wpp0uryBScnRDjyn7PiuSBLYP36LuPi9dFzkvop19TP1vpL/Joll8uAEkmLa/NwEQ9
         Bf1G+ejesGbwF2JL+7CEvUPYHDtjA4/JxZSbFMwHcJXCjSn4F+W7X1MTy0obur1NkgpX
         0EmB3lwdP+n/BNJ/OngJV3RN9517o1ezJQnuRHLbNFSuXivUAJI+Kmj2ugkn0E99MpwS
         /6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680052363;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bD0WuHcqP0jnnIO4Z4zALTMiyM+BdS1Or/XHCneUJyo=;
        b=KJF5EBresgDNJAmkgyY0WqG865s3O2H+POOgO6jf0jvRj72Yi8XDmrEJTwx6uwOuKV
         fT8o1y4EoSgCwUeleselviKHHIvmWLCAVniK6jM1J43XhJvPuMUuq43Nquq4QeMhDNXK
         MJ40QtZ+UrDpYeSmYb9pKmPFxgqCowWl12ys0RIEDhnmBP8OIJqcf6FkfF6ePi3f3A53
         ZNx+dQIyfgg0/tdxaAQqsmri7ckc9fIZCqPCj6yII8ANTg0800kph2bOInj9rz5Cs+3W
         o2kf/JpomcMGrvnq5seShUyWvjNLLhgOJD0VenignPhTr7wVrDmw251KDB5KDtPfmbPl
         6Zkw==
X-Gm-Message-State: AAQBX9c79dDuC65oGpKReZzp3Dd6e4ZnGDmpB1srH7T1ErZJbykGGMaB
        giFPssaey45xXndUfILK4RmICg==
X-Google-Smtp-Source: AKy350YJxJitwRKp+/SoxvP/GkKDIa3U96VIE10QYl7FOdWMNj3XVj2T6lVGbXyC/FJT0lsMV0oaBw==
X-Received: by 2002:ac2:5fa5:0:b0:4dd:9e4a:4c3b with SMTP id s5-20020ac25fa5000000b004dd9e4a4c3bmr4107519lfe.17.1680052363332;
        Tue, 28 Mar 2023 18:12:43 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b004dc53353d15sm5248519lft.281.2023.03.28.18.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 18:12:42 -0700 (PDT)
Message-ID: <911d3f32-b020-94f7-2ac5-5d72b35ba901@linaro.org>
Date:   Wed, 29 Mar 2023 03:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 00/14] GMU-less A6xx support (A610, A619_holi)
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230223-topic-gmuwrapper-v4-0-e987eb79d03f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 16:28, Konrad Dybcio wrote:
> v3 -> v4:
> - Drop the mistakengly-included and wrong A3xx-A5xx bindings changes
> - Improve bindings commit messages to better explain what GMU Wrapper is
> - Drop the A680 highest bank bit value adjustment patch
> - Sort UBWC config variables in a reverse-Christmass-tree fashion [4/14]
> - Don't alter any UBWC config values in [4/14]
>   - Do so for a619_holi in [8/14]
> - Rebase on next-20230314 (shouldn't matter at all)
After Johan's recent runtime PM fix, this kinda broke..
When entering the error-fail-retry path (e.g. when not embedding
the firmware in initrd, then starting a DE and letting the kernel
get the fw from the root partition), the GPU does not wake up fully:

[   24.744344] msm_dpu 5e01000.display-controller: [drm:adreno_wait_ring] *ERROR* timeout waiting for space in ringbuffer 0
[   25.744343] [drm:a6xx_idle] *ERROR* A619: a6xx_hw_init: timeout waiting for GPU to idle: status 00800005 irq 00800000 rptr/wptr 12/12
[   25.744401] msm_dpu 5e01000.display-controller: [drm:adreno_load_gpu] *ERROR* gpu hw init failed: -22
[   25.744494] adreno 5900000.gpu: [drm:a6xx_irq] *ERROR* gpu fault ring 0 fence ffffff00 status 00800005 rb 000c/000c ib1 0000000000000000/0000 ib2 0000000000000000/0000
[   25.744544] msm_dpu 5e01000.display-controller: [drm:recover_worker] *ERROR* A619: hangcheck recover!


Adding a random 1s sleep in hw_init() fixes it. Because of course it does.
Investigating that, merging this will be suboptimal until then..

Konrad
> 
> v3: https://lore.kernel.org/r/20230223-topic-gmuwrapper-v3-0-5be55a336819@linaro.org
> 
> v2 -> v3:
> New dependencies:
> - https://lore.kernel.org/linux-arm-msm/20230223-topic-opp-v3-0-5f22163cd1df@linaro.org/T/#t
> - https://lore.kernel.org/linux-arm-msm/20230120172233.1905761-1-konrad.dybcio@linaro.org/
> 
> Sidenote: A speedbin rework is in progress, the of_machine_is_compatible
> calls in A619_holi are ugly (but well, necessary..) but they'll be
> replaced with socid matching in this or the next kernel cycle.
> 
> Due to the new way of identifying GMU wrapper GPUs, configuring 6350
> to use wrapper would cause the wrong fuse values to be checked, but that
> will be solved by the conversion + the ultimate goal is to use the GMU
> whenever possible with the wrapper left for GMU-less Adrenos and early
> bringup debugging of GMU-equipped ones.
> 
> - Ship dt-bindings in this series as we're referencing the compatible now
> 
> - "De-staticize" -> "remove static keyword" [3/15]
> 
> - Track down all the values in [4/15]
> 
> - Add many comments and explanations in [4/15]
> 
> - Fix possible return-before-mutex-unlock [5/15]
> 
> - Explain the GMU wrapper a bit more in the commit msg [5/15]
> 
> - Separate out pm_resume/suspend for GMU-wrapper GPUs to make things
>   cleaner [5/15]
> 
> - Don't check if `info` exists, it has to at this point [5/15]
> 
> - Assign gpu->info early and clean up following if statements in
>   a6xx_gpu_init [5/15]
> 
> - Determine whether we use GMU wrapper based on the GMU compatible
>   instead of a quirk [5/15]
> 
> - Use a struct field to annotate whether we're using gmu wrapper so
>   that it can be assigned at runtime (turns out a619 holi-ness cannot
>   be determined by patchid + that will make it easier to test out GMU
>   GPUs without actually turning on the GMU if anybody wants to do so)
>   [5/15]
> 
> - Unconditionally hook up gx to the gmu wrapper (otherwise our gpu
>   will not get power) [5/15]
> 
> - Don't check for gx domain presence in gmu_wrapper paths, it's
>   guaranteed [5/15]
> 
> - Use opp set rate in the gmuwrapper suspend path [5/15]
> 
> - Call opp functions on the GPU device and not on the DRM device of
>   mdp4/5/DPU1 half the time (WHOOOOPS!) [5/15]
> 
> - Disable the memory clock in a6xx_pm_suspend instead of enabling it
>   (moderate oops) [5/15]
> 
> - Call the forgotten clk_bulk_disable_unprepare in a6xx_pm_suspend [5/15]
> 
> - Set rate to FMIN (a6xx really doesn't like rate=0 + that's what
>   msm-5.x does anyway) before disabling core clock [5/15]
> 
> - pm_runtime_get_sync -> pm_runtime_resume_and_get [5/15]
> 
> - Don't annotate no cached BO support with a quirk, as A619_holi is
>   merged into the A619 entry in the big const struct - this means
>   that all GPUs operating in gmu wrapper configuration will be
>   implicitly treated as if they didn't have this feature [7/15]
> 
> - Drop OPP rate & icc related patches, they're a part of a separate
>   series now; rebase on it
> 
> - Clean up extra parentheses [8/15]
> 
> - Identify A619_holi by checking the compatible of its GMU instead
>   of patchlevel [8/15]
> 
> - Drop "Fix up A6XX protected registers" - unnecessary, Rob will add
>   a comment explaining why
> 
> - Fix existing UBWC values for A680, new patch [10/15]
> 
> - Use adreno_is_aXYZ macros in speedbin matching [13/15] - new patch
> 
> v2: https://lore.kernel.org/linux-arm-msm/20230214173145.2482651-1-konrad.dybcio@linaro.org/
> 
> v1 -> v2:
> - Fix A630 values in [2/14]
> - Fix [6/14] for GMU-equipped GPUs
> 
> Link to v1: https://lore.kernel.org/linux-arm-msm/20230126151618.225127-1-konrad.dybcio@linaro.org/
> 
> This series concludes my couple-weeks-long suffering of figuring out
> the ins and outs of the "non-standard" A6xx GPUs which feature no GMU.
> 
> The GMU functionality is essentially emulated by parting out a
> "GMU wrapper" region, which is essentially just a register space
> within the GPU. It's modeled to be as similar to the actual GMU
> as possible while staying as unnecessary as we can make it - there's
> no IRQs, communicating with a microcontroller, no RPMh communication
> etc. etc. I tried to reuse as much code as possible without making
> a mess where every even line is used for GMU and every odd line is
> used for GMU wrapper..
> 
> This series contains:
> - plumbing for non-GMU operation, if-ing out GMU calls based on
>   GMU presence
> - GMU wrapper support
> - A610 support (w/ speedbin)
> - A619 support (w/ speedbin)
> - couple of minor fixes and improvements
> - VDDCX/VDDGX scaling fix for non-GMU GPUs (concerns more than just
>   A6xx)
> - Enablement of opp interconnect properties
> 
> A619_holi works perfectly fine using the already-present A619 support
> in mesa. A610 needs more work on that front, but can already replay
> command traces captures on downstream.
> 
> NOTE: the "drm/msm/a6xx: Add support for A619_holi" patch contains
> two occurences of 0x18 used in place of a register #define, as it's
> supposed to be RBBM_GPR0_CNTL, but that will only be present after
> mesa-side changes are merged and headers are synced from there.
> 
> Speedbin patches depend on:
> https://lore.kernel.org/linux-arm-msm/20230120172233.1905761-1-konrad.dybcio@linaro.org/
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (14):
>       dt-bindings: display/msm: gpu: Document GMU wrapper-equipped A6xx
>       dt-bindings: display/msm/gmu: Add GMU wrapper
>       drm/msm/a6xx: Remove static keyword from sptprac en/disable functions
>       drm/msm/a6xx: Extend and explain UBWC config
>       drm/msm/a6xx: Introduce GMU wrapper support
>       drm/msm/a6xx: Remove both GBIF and RBBM GBIF halt on hw init
>       drm/msm/adreno: Disable has_cached_coherent in GMU wrapper configurations
>       drm/msm/a6xx: Add support for A619_holi
>       drm/msm/a6xx: Add A610 support
>       drm/msm/a6xx: Fix some A619 tunables
>       drm/msm/a6xx: Use "else if" in GPU speedbin rev matching
>       drm/msm/a6xx: Use adreno_is_aXYZ macros in speedbin matching
>       drm/msm/a6xx: Add A619_holi speedbin support
>       drm/msm/a6xx: Add A610 speedbin support
> 
>  .../devicetree/bindings/display/msm/gmu.yaml       |  49 +-
>  .../devicetree/bindings/display/msm/gpu.yaml       |  57 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |  57 ++-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   2 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 494 ++++++++++++++++++---
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  14 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |  17 +-
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  33 +-
>  9 files changed, 632 insertions(+), 92 deletions(-)
> ---
> base-commit: 647ef0d33d52a103b50469d7109b63d453686c11
> change-id: 20230223-topic-gmuwrapper-b4fff5fd7789
> 
> Best regards,
