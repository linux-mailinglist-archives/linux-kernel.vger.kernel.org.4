Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9E06DE72B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjDKWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDKWWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:22:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ED840C1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:22:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d7so23374690lfj.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 15:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681251722; x=1683843722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bnJqJOHWM+i9yYeCdM/t4B9MeXWhn4I1ekLcXvd6lHg=;
        b=TtLJ4EI/MxAfwkyCoXHF6vMi538qX4N5Eh3lSLgwY9Hp1V9UsojQVkDRy6sCgac936
         uFPQGqPqWZyNDJLjGGmOWGvAvMGfrGZX8sOkuHeW0zbTJSYTISU1XlVRGlOxGxWj3Sdu
         neoJIWVtsAJztSlAfPxqyDVnYf3Z0p2Oj9ZXnjvQOl/pETNgaGclKKusfcjB96RcV3xo
         mpSQ4GjnUCMdcBtJ4qRcJSHycsfbM83mYhLTn7l5B7GEE8VKwNi4ihda3PuJKsyHMZLe
         BZ32ZRjiM1vFkTmvAiWeMM6tuKCDUbixQBJgpsYtiZlfNFxXsM+Jho5t4XBYk7t2fY5U
         ZcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681251722; x=1683843722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bnJqJOHWM+i9yYeCdM/t4B9MeXWhn4I1ekLcXvd6lHg=;
        b=nDXsV8DIQKIiH4TdBG/EyoB4UJWoj5ntGQof1xRjHY+YrdAfpqHyTp+lD5LMpgmG8R
         kTLlK6lYsWdu70U4tWOmk8xCRIbMdAhB31stohcM9okQTEE+Zoj2JI9Mp5QWLpRd0Mn6
         2yuaryMsAwUcs2qIY+sw/kREClLP+vCSt+BK+Q3rt16d1hrKdoadk48AtzZA5feh6++E
         reTjDnwwjKq/GkWchZIbYbWAAeAy5PEj8Wb2FFqycL7gJk/i2ieOzlVTU5jfRS4rT4Ek
         UhNvKZ3kzX3ZmZQ+VAr/13+CeMm3HEBY091xFgLZmW+UsiBipUvMksWsIqecoTUQyiRg
         VlWw==
X-Gm-Message-State: AAQBX9dcUmylZhA4oYdKAJznHTWt+/c1QlZ+NR3KiUiVgjaBC1Z4KA76
        YqKckygl/cE5s3Si6SkgBRoCwQ==
X-Google-Smtp-Source: AKy350YCVh8sqlclvyGDYItY0bdZX5DwXT15GKdMRT6i4yqUjFGy9SGZz1hBjSstG6Pnf62SBVGXeg==
X-Received: by 2002:ac2:4315:0:b0:4ec:8e83:dafd with SMTP id l21-20020ac24315000000b004ec8e83dafdmr133404lfh.19.1681251722273;
        Tue, 11 Apr 2023 15:22:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c11-20020ac244ab000000b004e792045b3dsm2706181lfm.106.2023.04.11.15.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 15:22:01 -0700 (PDT)
Message-ID: <cfb8b5c2-f5e0-48b3-fab2-9708190df1c3@linaro.org>
Date:   Wed, 12 Apr 2023 01:22:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/dpu: add DSC range checking during resource
 reservation
Content-Language: en-GB
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1681247380-1607-1-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 00:09, Kuogee Hsieh wrote:
> Perform DSC range checking to make sure correct DSC is requested before
> reserve resource for it.
> 
> Fixes: c985d7bb64ff ("drm/msm/disp/dpu1: Add DSC support in RM")

$ git log -p -1 c985d7bb64ff
fatal: ambiguous argument 'c985d7bb64ff': unknown revision or path not 
in the working tree.

I assume this was generated against some internal tree. Please. Please. 
Don't do this again. I hoped that this was pointed out ages ago, but 
probably not. No fixes, commits, tests against internal trees, no matter 
how precious they are to you.

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index f4dda88..95e58f1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #define pr_fmt(fmt)	"[drm:%s] " fmt, __func__
> @@ -250,6 +251,11 @@ int dpu_rm_init(struct dpu_rm *rm,
>   		struct dpu_hw_dsc *hw;
>   		const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
>   
> +		if (dsc->id < DSC_0 || dsc->id >= DSC_MAX) {
> +			DPU_ERROR("skip dsc %d with invalid id\n", dsc->id);
> +			continue;
> +		}
> +
>   		hw = dpu_hw_dsc_init(dsc->id, mmio, cat);
>   		if (IS_ERR_OR_NULL(hw)) {
>   			rc = PTR_ERR(hw);
> @@ -557,8 +563,10 @@ static int _dpu_rm_make_reservation(
>   	}
>   
>   	ret  = _dpu_rm_reserve_dsc(rm, global_state, enc, &reqs->topology);
> -	if (ret)
> +	if (ret) {
> +		DPU_ERROR("unable to find appropriate DSC\n");
>   		return ret;
> +	}
>   
>   	return ret;
>   }

-- 
With best wishes
Dmitry

