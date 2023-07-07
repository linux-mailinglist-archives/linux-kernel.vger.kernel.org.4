Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1272E74A8D8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 04:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGGCUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 22:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGGCUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 22:20:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5A4E3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 19:20:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fbcbf4375dso1472380e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688696398; x=1691288398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tWbvWe+wSPpAfUuNVCuRaGwVFU2OOSKw8sDylC+/9ng=;
        b=vw4y9fB1R04uqObICIbb69PADoZ+3DDeXGN55GlLzH7uFxQY+cZSypMdOA+GX3BbZB
         QAMuaN7H9j/xyhtuzMQi7Vi5YVCJzgZpC38onAmDoqnGxNB5+unBSSOPdPCZdZQaIKoZ
         MQ1psFgz1B4JMV03yurACg/KBtTXD2lbsjBb56ZxY1cWrUx8JLIYFfE1Ge6pK/xj8dtx
         AF2ebNqyQB49MVCLyLO44PRCHj1Svgma/mjMWzpyDqhG0PQKpzCWi0ePzwGOHwGyWUbw
         QElOiQLJvTndEZ6g0QzlxaEJAjIrUQjeaZWCO0EqJHHaC8hBiROnFJZChr1cW9p6dFdQ
         hTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688696398; x=1691288398;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWbvWe+wSPpAfUuNVCuRaGwVFU2OOSKw8sDylC+/9ng=;
        b=dM6lQlZiwKtdb7dgqEpuqc+tVeJDfRbdx2UnanxlkR+fpfnY1RWoVVmkKc2ejIfpCJ
         Jh+iocC+LrFq8Gepan59T0iGF/nZrBwnVSINRq1WvwUM5ilNGmA/TdHaVlXXXaBFaPGw
         YsQ9Gq/YUNngy3kROoRJZLMBn7JmFZ5Bm4t3Cikg/I3v7qlV3nrOAvpxmfWlYOpOtWbN
         6Ia1iG2NjU7hTUul6Y3s0VB+IVoGyy/R54w1hnhA4pC12vcXnOBc6qZsCXhZt2vGrsrj
         yUGTnIrsdJPrwr6musM3guq7sa4XeAIssnEdPYz9JNXDZ4eckNdSyD6Q+CLLbMsmz5Nw
         S+nQ==
X-Gm-Message-State: ABy/qLY5Tx+EVYVw38KaAPH9H/wh44UiDzSkI38W6ZI7BXhSv5EN59QE
        /eOyD7mqPi1Ogfr+8gc4EZGF7w==
X-Google-Smtp-Source: APBJJlHk2zZh/rSPQ2vvGPduKoXp+HDbbEegqAUjUdE8Yj9pQfmDCdPP4rQ+d736yonYTnqVAXEaTg==
X-Received: by 2002:a05:6512:b8b:b0:4fb:bd93:b239 with SMTP id b11-20020a0565120b8b00b004fbbd93b239mr2874790lfv.13.1688696398511;
        Thu, 06 Jul 2023 19:19:58 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id l11-20020ac2430b000000b004fb99da37e3sm474865lfh.220.2023.07.06.19.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 19:19:58 -0700 (PDT)
Message-ID: <dc937077-91bd-8c4f-b220-82df11efd215@linaro.org>
Date:   Fri, 7 Jul 2023 05:19:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/6] drm/msm/dpu: Refactor printing of main blocks in
 device core dump
Content-Language: en-GB
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
References: <20230622-devcoredump_patch-v4-0-e304ddbe9648@quicinc.com>
 <20230622-devcoredump_patch-v4-5-e304ddbe9648@quicinc.com>
 <deb38d54-bf7f-f42a-8b61-f6c8f46370b0@linaro.org>
 <da04a824-b44c-d6a0-3dfc-f1b8e8272195@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <da04a824-b44c-d6a0-3dfc-f1b8e8272195@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 03:16, Abhinav Kumar wrote:
> 
> 
> On 7/6/2023 5:07 PM, Dmitry Baryshkov wrote:
>> On 06/07/2023 23:48, Ryan McCann wrote:
>>> Currently, the names of main blocks are hardcoded into the
>>> msm_disp_snapshot_add_block function rather than using the name that
>>> already exists in the catalog. Change this to take the name directly 
>>> from
>>> the catalog instead of hardcoding it.
>>>
>>> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
>>> ---
>>>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 32 
>>> ++++++++++++++++----------------
>>>   1 file changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c 
>>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> index aa8499de1b9f..70dbb1204e6c 100644
>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>>> @@ -899,38 +899,38 @@ static void dpu_kms_mdp_snapshot(struct 
>>> msm_disp_state *disp_state, struct msm_k
>>>       /* dump CTL sub-blocks HW regs info */
>>>       for (i = 0; i < cat->ctl_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len,
>>> -                dpu_kms->mmio + cat->ctl[i].base, "ctl_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->ctl[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->ctl[i].base, cat->ctl[i].name);
>>
>> Splitting on the `+' sign is a bad idea. It makes it harder to read 
>> the code. Please keep the first line as is, it is perfectly fine on 
>> its own, and do just what you have stated in the commit message: 
>> change printed block name.
>>
> 
> Actually, I asked Ryan to fix the indent here in the same patch as he 
> was touching this code anyway.
> 
> So you would prefer thats left untouched?

Yes. The current one was definitely better than splitting in the middle 
of a statement.

> 
>>>       /* dump DSPP sub-blocks HW regs info */
>>>       for (i = 0; i < cat->dspp_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len,
>>> -                dpu_kms->mmio + cat->dspp[i].base, "dspp_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->dspp[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->dspp[i].base, cat->dspp[i].name);
>>>       /* dump INTF sub-blocks HW regs info */
>>>       for (i = 0; i < cat->intf_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->intf[i].len,
>>> -                dpu_kms->mmio + cat->intf[i].base, "intf_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->intf[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->intf[i].base, cat->intf[i].name);
>>>       /* dump PP sub-blocks HW regs info */
>>>       for (i = 0; i < cat->pingpong_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->pingpong[i].len,
>>> -                dpu_kms->mmio + cat->pingpong[i].base, 
>>> "pingpong_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, 
>>> cat->pingpong[i].len, dpu_kms->mmio +
>>> +                        cat->pingpong[i].base, cat->pingpong[i].name);
>>>       /* dump SSPP sub-blocks HW regs info */
>>>       for (i = 0; i < cat->sspp_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len,
>>> -                dpu_kms->mmio + cat->sspp[i].base, "sspp_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->sspp[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->sspp[i].base, cat->sspp[i].name);
>>>       /* dump LM sub-blocks HW regs info */
>>>       for (i = 0; i < cat->mixer_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len,
>>> -                dpu_kms->mmio + cat->mixer[i].base, "lm_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->mixer[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->mixer[i].base, cat->mixer[i].name);
>>>       /* dump WB sub-blocks HW regs info */
>>>       for (i = 0; i < cat->wb_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->wb[i].len,
>>> -                dpu_kms->mmio + cat->wb[i].base, "wb_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->wb[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->wb[i].base, cat->wb[i].name);
>>>       if (cat->mdp[0].features & BIT(DPU_MDP_PERIPH_0_REMOVED)) {
>>>           msm_disp_snapshot_add_block(disp_state, MDP_PERIPH_TOP0,
>>> @@ -944,8 +944,8 @@ static void dpu_kms_mdp_snapshot(struct 
>>> msm_disp_state *disp_state, struct msm_k
>>>       /* dump DSC sub-blocks HW regs info */
>>>       for (i = 0; i < cat->dsc_count; i++)
>>> -        msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len,
>>> -                dpu_kms->mmio + cat->dsc[i].base, "dsc_%d", i);
>>> +        msm_disp_snapshot_add_block(disp_state, cat->dsc[i].len, 
>>> dpu_kms->mmio +
>>> +                        cat->dsc[i].base, cat->dsc[i].name);
>>>       pm_runtime_put_sync(&dpu_kms->pdev->dev);
>>>   }
>>>
>>

-- 
With best wishes
Dmitry

