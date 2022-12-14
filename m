Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0664CF89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbiLNSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiLNSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:40:10 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DA15807
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:40:08 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id cf42so11980714lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=84PVzy06Jez7WrqpA7scvmaFQfIAuLwwfaDiUooPlFI=;
        b=gR3RUbdtP2h5rhjbu9ETN1ccQZp6hk7IaSQibahbKZZXwXTSnp2ECnJDrlylJ+3Pss
         3v4rTXnsLW1NgvfHGi1LkaSvMo65xG1F1zka65Yiszsmd2AePNGZH1GkKM1OgvbKJ/1t
         oGmX0Fy5dluJbI+LK9yOhT2hO6h36iaiuPHxXifUHvV71nucTO83hZChn6a71Z6sgeVz
         SW5u/8R2anqRl+qwBkF44JOBU9ewze/ElC2l5Vu8BXLv7wXLhOqpU0USfBkxVO1O67RZ
         cKyMrT7oGQ6jCy0oUw+B2UuuoJ753yzWd/JI9P7frzi9p9xwfUY0x7zNAeyulvEFyeDu
         Ewzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84PVzy06Jez7WrqpA7scvmaFQfIAuLwwfaDiUooPlFI=;
        b=vn9Zoz3rb4s3yjxf2nkndbVyFzAPURqOJOHTyeSLMra0O8dJwSJXnkK3GE5jImamsD
         XNtQqbnGM8b0mcdH1HXPPmlBX2KFcThc2oEdapoNAyDeljy18s0HMK4N6FtPU/kSWX5k
         4F6n39uzPqiQ5B+IAu/P8Z9vbtylxjmmm9MXsMKnEoUVv8A1w6UtDSpMtfmvAOMi5R5P
         bEC64jTQu+kPCnzNQ9gIw2EdlVi8vvS3Cf7SaTGK3SCCiO3rY1m17beq4EWSt5NXC0fE
         fUphj+tFV484w3C1mvUYRcOh7n5bMiAIuokQSdmSEyo7URMOkrqrgg3Ox6gLPbpWnzU1
         8HKQ==
X-Gm-Message-State: ANoB5pk02zJ8Y9d0Zr7gvwETnHImjBUhsw8xXE/u0auNfGf/ds7TD1Nw
        9LwFW8rLzKYZ6RLP84RKlURFdw==
X-Google-Smtp-Source: AA0mqf5huwxvJLpqWw8CtVjdxW1TVZkauT4Q4In5DVwTzyMs2NKw3KRNjJwviMs2hFfphsK4vzn7Pw==
X-Received: by 2002:ac2:4f0e:0:b0:4a4:68b9:19e1 with SMTP id k14-20020ac24f0e000000b004a468b919e1mr7586088lfr.9.1671043207234;
        Wed, 14 Dec 2022 10:40:07 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a23-20020a19f817000000b0049465afdd38sm901628lff.108.2022.12.14.10.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:40:06 -0800 (PST)
Message-ID: <154b2e08-25a0-c8b7-1dc8-2d41b8787f05@linaro.org>
Date:   Wed, 14 Dec 2022 20:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 0/6] drm/msm: DSC Electric Boogaloo for sm8[12]50
Content-Language: en-GB
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jani Nikula <jani.nikula@intel.com>,
        sunliming <sunliming@kylinos.cn>,
        Sam Ravnborg <sam@ravnborg.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Douglas Anderson <dianders@chromium.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221213232207.113607-1-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221213232207.113607-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 01:22, Marijn Suijten wrote:
> This preliminary Display Stream Compression support package for
> (initially tested on) sm8[12]50 is based on comparing DSC behaviour
> between downstream and mainline.  Some new callbacks are added (for
> binding blocks on active CTLs), logic bugs are corrected, zeroed struct
> members are now assigned proper values, and RM allocation and hw block
> retrieval now hand out (or not) DSC blocks without causing null-pointer
> dereferences.
> 
> Unfortunately it is not yet enough to get rid of completely corrupted
> display output on the boards I tested here:
> - Sony Xperia 1 (sm8150), 1644x3840 or 1096x2560 pixels;
> - Sony Xperia 5II (sm8250), 1080x2520, at 60 or 120Hz;
> - (can include more Xperia boards if desired)
> 
> Both devices use the DUALPIPE_DSCMERGE topology downstream: dual LM, PP
> and DSC, but only a single INTF/encoder/DSI-link.
> 
> Hopefully this spawns some community/upstream interest to help rootcause
> our corruption issues (after we open a drm/msm report on GitLab for more
> appropriate tracking).
> 
> The Sony Xperia XZ3 (sdm845) was fully tested and validated with this
> series to not cause any regressions (an one of the math fixes now allows
> us to change slice_count in the panel driver, which would corrupt
> previously).
> 
> Marijn Suijten (6):
>    drm/msm/dpu1: Implement DSC binding to PP block for CTL V1
>    drm/msm/dpu1: Add DSC config for sm8150 and sm8250
>    drm/msm/dpu1: Wire up DSC mask for active CTL configuration
>    drm/msm/dsi: Use DSC slice(s) packet size to compute word count
>    drm/msm/dsi: Flip greater-than check for slice_count and
>      slice_per_intf
>    drm/msm/dpu: Disallow unallocated (DSC) resources to be returned

General comment: patches with Fixes ideally should come first. Usually 
they are picked into -fixes and/or stable kernels. If the Fixes patches 
are in the middle of the series, one can not be sure that they do not 
have dependencies on previous patches. If there is one, it should 
probably be stated clearly to ease work on backporting them.

> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  3 +++
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  |  1 +
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |  1 +
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  2 ++
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 23 +++++++++++-----
>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  9 +++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.c    | 27 +++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_dsc.h    |  4 +++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c        | 10 +++++++
>   drivers/gpu/drm/msm/dsi/dsi_host.c            |  6 ++---
>   10 files changed, 77 insertions(+), 9 deletions(-)
> 
> --
> 2.38.1
> 

-- 
With best wishes
Dmitry

