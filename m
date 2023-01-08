Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B45661B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 00:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjAHXYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 18:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjAHXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 18:23:59 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C179FB49A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 15:23:57 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m6so10443475lfj.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 15:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb1YtbYSknpUZJ7taGZJai9/UTm81zSKRw9ScghBwuI=;
        b=fSQifwdN0bWp8uieWo5bqmziJqqydtl+a1YUYcE6IiF98/drVb2LRKbEPFU51n1u1J
         tYkcLEvoCABv5Ks5O3Pzl8LNBtIgyhJacU3hkjLilrfvc2/8MjF/19aI4Ckr0QN32xj0
         r5R47ciOEfo58JQuZmMH37lCzx7Z2/R8EWxSxPcJ5vG4qHFNcIttBnG9bEy+3FUllTKG
         7uryRLP3TTU6SZSQtE9r2bfEx8WHjus6OPo5obxciRqG+T+VG1Ze63Zh0kQ0sgleEX5N
         yChw4EwqOEnkcXQeQFUcHkZgYoYsGBDdHqG7J3Kgi+ZoAOZwdBMT5+DoSN7WvnzOZmxb
         /tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb1YtbYSknpUZJ7taGZJai9/UTm81zSKRw9ScghBwuI=;
        b=BYPVv+hQB8FrACO2jgnFGMbrmaIneivs8r0fVYJYIp4umXHugPz6zfDDo6aIf7sh7Y
         FhfhEXgCQZZw80IkP6E5Z6UWgrkDD41lS2r8PoDDldjrBZlnXBnFPQCW5m/ZXyPA6VPk
         G5u9wl55XZU2t5ssT/Us4e/RfISGEXfFTCXDMCdwvH79NdxcA2TvzBF1EV1FtAvxjD+4
         pU4xA77b+GjbiBYIFFbjqFy9Cvblaa2NF8HZi5S7J7OV90T3h9HZbRip40BMs6eCcH1O
         eJ42Wf6AJWwU8mgWOj3aQxi+KNzQg/2mG0JwCpqJQvo2dltb1SQLJfBz/ymnODTZ65Zw
         +rsw==
X-Gm-Message-State: AFqh2ko6qxtgdP9kUeEfDcrOsnlLPJ9kwCnuT8bQ57imSFtE1iaXpmmb
        uLcjSMb0eg2zNGvCh4/bD2QjVA==
X-Google-Smtp-Source: AMrXdXv/HATGy+NUozlcwwF4SbLVOvtl1Sm77XfQlFbdyZrpwOZ3MaNXumdn5iaXjBcdh/HQwjKKtA==
X-Received: by 2002:ac2:5307:0:b0:4a4:68b8:9c4e with SMTP id c7-20020ac25307000000b004a468b89c4emr15251767lfh.54.1673220236191;
        Sun, 08 Jan 2023 15:23:56 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id r12-20020ac252ac000000b004aab0ca795csm1280794lfm.211.2023.01.08.15.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 15:23:55 -0800 (PST)
Message-ID: <169840b1-0c9f-fa14-a904-68679671bdf7@linaro.org>
Date:   Mon, 9 Jan 2023 01:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/8] drm/msm/dpu: Wire up DSC mask for active CTL
 configuration
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
 <20221221231943.1961117-2-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221221231943.1961117-2-marijn.suijten@somainline.org>
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
> Active CTLs have to configure what DSC block(s) have to be enabled, and
> what DSC block(s) have to be flushed; this value was initialized to zero
> resulting in the necessary register writes to never happen (or would
> write zero otherwise).  This seems to have gotten lost in the DSC v4->v5
> series while refactoring how the combination with merge_3d was handled.
> 
> Fixes: 58dca9810749 ("drm/msm/disp/dpu1: Add support for DSC in encoder")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c | 1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

