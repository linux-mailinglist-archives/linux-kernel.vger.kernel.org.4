Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD6864CFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 19:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiLNS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 13:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiLNS4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 13:56:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0429819
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:56:33 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so12003719lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAXgv0FqZPp6QIE1p4AggR6c0tBhwxedxuB4UjUwAYk=;
        b=pAuFjz4IygxgeJ/oxxYilAxz9gu8rxLLD9Abptoxz/z4g5C3oh01+sDNMD4EQjHl8I
         7SffwShxzO/Yrkx10FvA4FfHt94r7pRmhR144YjqKE807AH157g3nzvv81MKPv+kS2Aa
         kNb9r2UVZ3su2RjugjW8eTrUPslchCeRVJJmSSoPxRJ0lR6YJLpin7/NCycvQQh2lFS9
         FXNr4KhaPAqsOKcy0iJDpo+6mgxQgFJagtaJInGlDaWWJj6Yt/OkYuepwDAXh279/59m
         HfhS4/e/YrJS0V8beZmuFG+Sl6K+ec6myLTFXUqR7qBWRbTetiC03RKEs6T7zkfHcTyh
         LLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAXgv0FqZPp6QIE1p4AggR6c0tBhwxedxuB4UjUwAYk=;
        b=xi7NHB6xb9AEWFmJLSo5WxVLbrZXkcO2Hop3fRS2UoPCIquxzC24X3kzIKxfXCX9yV
         sZXP4KdIEj9EZZm28rXGn8Ke57osuksoulbOSRDDzFwU8kh1qbJNJptQmWBc8vnlmCPC
         InCmiiCcMAXSsL58TUdrCnYIzQpLL2GM2r9qijy7JsWkdYb9RDHLpzeUSNo/u//vETSY
         ILhee0Dy1tyC4Mq5fwRUediGddKTSeH1Ide5HBaNbFoyhZsR3C9XW4W58tzUVB4AKUhr
         eibCcS5gfeHp39SUG9+wMnofyZHw9LCJ7N23f1KzRP8xAb8HH1ZGLkdcptZWE0o0cuev
         LrLw==
X-Gm-Message-State: ANoB5pk9RthKoUiuf0Em/NJRcDjKcSGc52NZia637BXmLIWpuJVXsV8j
        D8R2G5iFwWAZ4CiHmG8YREyXLQ==
X-Google-Smtp-Source: AA0mqf7tKHFcQgUDMIF6sSNxIcU2Z7dQJ6Y3iG+hcEiC2wXXGP4cyEjDdrTcg35JQSrt56nDMeQuWA==
X-Received: by 2002:a05:6512:1308:b0:4a4:68b8:9c35 with SMTP id x8-20020a056512130800b004a468b89c35mr8293375lfu.29.1671044191866;
        Wed, 14 Dec 2022 10:56:31 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id h18-20020a19ca52000000b004b18163476esm895588lfj.112.2022.12.14.10.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 10:56:31 -0800 (PST)
Message-ID: <4b7b4fb0-b99b-1022-b0f6-e91a84e8d082@linaro.org>
Date:   Wed, 14 Dec 2022 20:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RFC PATCH 6/6] drm/msm/dpu: Disallow unallocated (DSC) resources
 to be returned
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
 <20221213232207.113607-7-marijn.suijten@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221213232207.113607-7-marijn.suijten@somainline.org>
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
> In the event that the topology requests resources that have not been
> created by the system (because they are typically not represented in
> dpu_mdss_cfg ^1), the resource(s) in global_state (in this case DSC
> blocks) remain NULL but will still be returned out of
> dpu_rm_get_assigned_resources, where the caller expects to get an array
> containing num_blks valid pointers (but instead gets these NULLs).
> 
> To prevent this from happening, where null-pointer dereferences
> typically result in a hard-to-debug platform lockup, num_blks shouldn't
> increase past NULL blocks and will print an error and break instead.
> After all, max_blks represents the static size of the maximum number of
> blocks whereas the actual amount varies per platform.
> 
> In the specific case of DSC initial resource allocation should behave
> more like LMs and CTLs where NULL resources are skipped.  The current
> hardcoded mapping of DSC blocks should be loosened separately as DPU
> 5.0.0 introduced a crossbar where DSC blocks can be "somewhat" freely
> bound to any PP and CTL, but that hardcoding currently means that we
> will return an error when the topology reserves a DSC that isn't
> available, instead of looking for the next free one.
> 
> ^1: which can happen after a git rebase ended up moving additions to
> _dpu_cfg to a different struct which has the same patch context.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index 73b3442e7467..dcbf03d2940a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -496,6 +496,11 @@ static int _dpu_rm_reserve_dsc(struct dpu_rm *rm,
>   
>   	/* check if DSC required are allocated or not */
>   	for (i = 0; i < num_dsc; i++) {
> +		if (!rm->dsc_blks[i]) {
> +			DPU_ERROR("DSC %d does not exist\n", i);
> +			return -EIO;
> +		}
> +
>   		if (global_state->dsc_to_enc_id[i]) {
>   			DPU_ERROR("DSC %d is already allocated\n", i);
>   			return -EIO;
> @@ -660,6 +665,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
>   				  blks_size, enc_id);
>   			break;
>   		}
> +		if (!hw_blks[i]) {
> +			DPU_ERROR("No more resource %d available to assign to enc %d\n",
> +				  type, enc_id);
> +			break;
> +		}
>   		blks[num_blks++] = hw_blks[i];
>   	}
>  

These two chunks should come as two separate patches, each having it's 
own Fixes tag.

-- 
With best wishes
Dmitry

