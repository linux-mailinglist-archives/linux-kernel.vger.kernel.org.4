Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4D8661B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjAHX3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjAHX3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:29:19 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538731004A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 15:29:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so10463900lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 15:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LuTC2ch7lBeZqWq+4sA1VXQap+WvF8VB8BdbUaWqcHE=;
        b=CiuDQBy/qJQ87Xz9VOezGSflqPnj3lXtvtt7iDr+c8eky0iXrkd/ssxJDRvHuhLpXv
         9YLK0p+b1zqAlvG+/kIHdXFdW65Tznz3XJTqmiPB20M8CwSh8GV2RLbwOtplHGn/WImv
         HsJ+dtiXAJP9IwxDjcYDCCIeDpvSwBxsh5fI2fWET8Y9bUyr30bp6uc/TEBSUfttvTd/
         Stg4mG7kChcSNPn51POGjV5/jEl/q2I/q3rgWByVEg6tp8bcv8CmbBVIRTaaK20Oz8gV
         VzNINsauGqt2hsJKATn9KmVqsnGxyai84XgZ7vQiX4ddCrhxjawWojXMYxTz+HARzYyh
         5AXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuTC2ch7lBeZqWq+4sA1VXQap+WvF8VB8BdbUaWqcHE=;
        b=fxsULe8ntfzHzm1uue7aSMCQZYUWnBcnjqSZHVf75IahX/QECfRyADx91w2lQnuOax
         GdQ6BttKbS0WO9sLtBa8E0e9hMhAgs9jh0n5jWOtdXkmMO70/vsGAjPDy9ZbK902AT3L
         QKg57knk+NjfRcIAy1Prq3Xf45TaZYBbgBDdq2jNEVVsLddenD7sVI8DTwSP1/qDYTWl
         hgsJgib6LCErjgx3+AtWf4wVvTYgO7KHwxf4BHUO/LiPHrFTiFPzFmiT+pG9HXMCw/dX
         sIzORNYmffIzWhSty9E2XJNd7Q/NxKJovOq2q4QuSRPRo6u9xXFxo/F6CuEV3RMzTcrF
         bOfA==
X-Gm-Message-State: AFqh2kqxMX4xHW4mZCIFrNgfJWOKBTKj14I3QYTyS96o8cLTjuRSnPsd
        CuV1x12U66g49BYJVglYGJSn1g==
X-Google-Smtp-Source: AMrXdXu8t5pfKS4rJQB9w2fmYZWbGOdVt9Co/jrV0noSh0NCRbIwq1U+45wR8Qydaxpx9ytF9YSmoQ==
X-Received: by 2002:a05:6512:22d0:b0:4c0:5798:38df with SMTP id g16-20020a05651222d000b004c0579838dfmr21545854lfu.27.1673220556738;
        Sun, 08 Jan 2023 15:29:16 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651220d200b00494a603953dsm1283513lfr.89.2023.01.08.15.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 15:29:16 -0800 (PST)
Message-ID: <06eab036-7c0f-55d5-2ad1-cfaf5dc0cc8d@linaro.org>
Date:   Mon, 9 Jan 2023 01:29:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 5/8] drm/msm/dpu: Reject topologies for which no DSC
 blocks are available
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
References: <20221221231943.1961117-1-marijn.suijten@somainline.org>
 <20221221231943.1961117-6-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221221231943.1961117-6-marijn.suijten@somainline.org>
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

On 22/12/2022 01:19, Marijn Suijten wrote:
> Resource allocation of DSC blocks should behave more like LMs and CTLs
> where NULL resources (based on initial hw_blk creation via definitions
> in the catalog) are skipped ^1.  The current hardcoded mapping of DSC
> blocks however means that resource allocation shouldn't succeed at all
> when the DSC block on the corresponding index doesn't exist, rather than
> searching for the next free block.
> 
> This hardcoded mapping should be loosened separately as DPU 5.0.0
> introduced a crossbar where DSC blocks can be "somewhat" freely bound to
> any PP and CTL (in proper pairs).
> 
> ^1: which, on hardware that supports DSC, can happen after a git rebase
> ended up moving additions to _dpu_cfg to a different struct which has
> the same patch context.
> 
> Fixes: f2803ee91a41 ("drm/msm/disp/dpu1: Add DSC support in RM")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

