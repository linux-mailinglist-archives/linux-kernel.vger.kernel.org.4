Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275916A756A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCAUet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCAUen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:34:43 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B44390F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:34:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so19344147lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+Bio1FwTDmP6s7PTwzBTwNIhmdqRI0BuWFvXKEttprg=;
        b=aVRw5XH4e4ZsXHGPWey9j2dwR1mj5fvYCRcfXpp8GcWGLzJi0BTzSgJWyTroC6FWO+
         h5Xy3baWKbCp7i96d/5XgzwFBoHBZ/Hew4tfvOGKjctwwKe/qStsSlJFIFXLOQtsMljm
         ze8ktmjdEr2WeHLBvUqR45qewSI5k+LP7ju0UBqUbbO5qAyrIf1RuhpHbKEprM4IsGbC
         wUTTWu8bcM4oOkJym+Nof8vok/XGJcyAv06fuJZr3JWrU2EiagbPe3nJyvd0BfRwj12v
         Qc2Un9NBjsBpEKDXtE2qCeBnoNTXukIKDx+q0kVEwDLX/koUKlVDyPY8Khvj6FWaHjar
         pLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Bio1FwTDmP6s7PTwzBTwNIhmdqRI0BuWFvXKEttprg=;
        b=guUdP/tgnpZ6o2ftlw4Yrm+3A2uHGkq/Zm5tFynm+DNJ/+0sO8yOUwpqi41PeXuav3
         YSksgYpucBI6AgvAwzlQF1WvRnTmjgTezh55PtU969CIUW+E44Hopvwbfj0K+K0eD4Ej
         MNO0fY+RGDPrp7M1mxlg+nHEMziZ4BLNJfhvamm0a2nLWjNcimZ61+EU9NpY9PfWiktO
         y9BBzXQXwIz6UyOuLQIDOnNmxOFMbP+yyWR8wJqk5vJEbciLjHSJilE6aOo7sItRbqkA
         kL+CVbfiFqo1ktayLnzq1+p+7fnsp6CMNCB3BDO2zUJPQBGxTouugL0ZYQta/sQTSMow
         /Bmw==
X-Gm-Message-State: AO0yUKUMrg4ir8Zfl8fj6DCDVquD793FDs9wIDKjT6tgYt3TP6FHuzYE
        J81IRA3lm1SV6RMvAax6YbTkEg==
X-Google-Smtp-Source: AK7set9b0BaIdg1nOPIO+w/NWAwnjqGRwXBsgcVyCcbR8P+jKeVTalGz+f01nJKceWfJPSvHQWOkXA==
X-Received: by 2002:ac2:46d9:0:b0:4b5:83b8:2c49 with SMTP id p25-20020ac246d9000000b004b583b82c49mr2038723lfo.1.1677702878022;
        Wed, 01 Mar 2023 12:34:38 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id d13-20020ac25ecd000000b004dd7f2854efsm1848676lfq.251.2023.03.01.12.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 12:34:37 -0800 (PST)
Message-ID: <05e59001-7ba8-ef31-552a-df23f37028f2@linaro.org>
Date:   Wed, 1 Mar 2023 22:34:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v13 00/13] Add PSR support for eDP
Content-Language: en-GB
To:     Doug Anderson <dianders@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        swboyd@chromium.org, quic_kalyant@quicinc.com,
        quic_khsieh@quicinc.com, quic_vproddut@quicinc.com,
        quic_bjorande@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1676219337-6526-1-git-send-email-quic_vpolimer@quicinc.com>
 <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAD=FV=XvjFQ-7KNsW2YQQ-LzJonCcHz_rj-oOhB0jh_99ficKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 21:06, Doug Anderson wrote:
> Hi,
> 
> On Sun, Feb 12, 2023 at 8:29 AM Vinod Polimera
> <quic_vpolimer@quicinc.com> wrote:
>>
>> Changes in v2:
>>    - Use dp bridge to set psr entry/exit instead of dpu_enocder.
>>    - Don't modify whitespaces.
>>    - Set self refresh aware from atomic_check.
>>    - Set self refresh aware only if psr is supported.
>>    - Provide a stub for msm_dp_display_set_psr.
>>    - Move dp functions to bridge code.
>>
>> Changes in v3:
>>    - Change callback names to reflect atomic interfaces.
>>    - Move bridge callback change to separate patch as suggested by Dmitry.
>>    - Remove psr function declaration from msm_drv.h.
>>    - Set self_refresh_aware flag only if psr is supported.
>>    - Modify the variable names to simpler form.
>>    - Define bit fields for PSR settings.
>>    - Add comments explaining the steps to enter/exit psr.
>>    - Change DRM_INFO to drm_dbg_db.
>>
>> Changes in v4:
>>    - Move the get crtc functions to drm_atomic.
>>    - Add atomic functions for DP bridge too.
>>    - Add ternary operator to choose eDP or DP ops.
>>    - Return true/false instead of 1/0.
>>    - mode_valid missing in the eDP bridge ops.
>>    - Move the functions to get crtc into drm_atomic.c.
>>    - Fix compilation issues.
>>    - Remove dpu_assign_crtc and get crtc from drm_enc instead of dpu_enc.
>>    - Check for crtc state enable while reserving resources.
>>
>> Changes in v5:
>>    - Move the mode_valid changes into a different patch.
>>    - Complete psr_op_comp only when isr is set.
>>    - Move the DP atomic callback changes to a different patch.
>>    - Get crtc from drm connector state crtc.
>>    - Move to separate patch for check for crtc state enable while
>> reserving resources.
>>
>> Changes in v6:
>>    - Remove crtc from dpu_encoder_virt struct.
>>    - fix crtc check during vblank toggle crtc.
>>    - Misc changes.
>>
>> Changes in v7:
>>    - Add fix for underrun issue on kasan build.
>>
>> Changes in v8:
>>    - Drop the enc spinlock as it won't serve any purpose in
>> protetcing conn state.(Dmitry/Doug)
>>
>> Changes in v9:
>>    - Update commit message and fix alignment using spaces.(Marijn)
>>    - Misc changes.(Marijn)
>>
>> Changes in v10:
>>    - Get crtc cached in dpu_enc during obj init.(Dmitry)
>>
>> Changes in v11:
>>    - Remove crtc cached in dpu_enc during obj init.
>>    - Update dpu_enc crtc state on crtc enable/disable during self refresh.
>>
>> Changes in v12:
>>    - Update sc7180 intf mask to get intf timing gen status
>> based on DPU_INTF_STATUS_SUPPORTED bit.(Dmitry)
>>    - Remove "clear active interface in the datapath cleanup" change
>> as it is already included.
>>
>> Changes in v13:
>>    - Move core changes to top of the series.(Dmitry)
>>    - Drop self refresh aware disable change after psr entry.(Dmitry)
>>
>> Vinod Polimera (13):
>>    drm: add helper functions to retrieve old and new crtc
>>    drm/bridge: use atomic enable/disable callbacks for panel bridge
>>    drm/bridge: add psr support for panel bridge callbacks
>>    drm/msm/disp/dpu: check for crtc enable rather than crtc active to
>>      release shared resources
>>    drm/msm/disp/dpu: get timing engine status from intf status register
>>    drm/msm/disp/dpu: wait for extra vsync till timing engine status is
>>      disabled
>>    drm/msm/disp/dpu: reset the datapath after timing engine disable
>>    drm/msm/dp: use atomic callbacks for DP bridge ops
>>    drm/msm/dp: Add basic PSR support for eDP
>>    drm/msm/dp: use the eDP bridge ops to validate eDP modes
>>    drm/msm/disp/dpu: use atomic enable/disable callbacks for encoder
>>      functions
>>    drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver
>>    drm/msm/disp/dpu: update dpu_enc crtc state on crtc enable/disable
>>      during self refresh
> 
> I'm curious what the plan is for landing this series. I could land the
> first two in drm-misc if you want, but I'm a lowly committer and so I
> couldn't make an immutable branch for you nor can I officially Ack the
> changes to land in your branch. That means you'd be blocked for an
> extra version. Do you already have a plan? If not, then maybe we need
> to get in touch with one of the maintainers [1] of drm-misc? That's
> documented [2] to be in their set of responsibilities. 
> 
> [1] https://drm.pages.freedesktop.org/maintainer-tools/repositories.html#drm-misc-repository
> [2] https://drm.pages.freedesktop.org/maintainer-tools/maintainer-drm-misc.html#maintainer-s-duties

My plan was to ask Thomas or Daniel to make an immutable branch. I just 
didn't want to ping them before rc1.

> 
> -Doug

-- 
With best wishes
Dmitry

