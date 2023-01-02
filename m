Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD465AF79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjABKUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjABKTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:19:52 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E421A114E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:19:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f34so40976994lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWPTy4A7mxL/uLlMfV1TgQ2kHwhzQq4um9qbIMfROls=;
        b=kTMfbkgF1czSvlzfxUKF9wDWoIw+rp+/126ZSwAwXmXF9xXRZ2doP7cKaUV6kwCzMp
         y7vGx1owfIoWAgkLVY4ce9VJr8wfkPYJMKZabd8IhlcoyATDUCRxjH2XLJY5NnW0Bhx9
         gxcrDi5Edjhyhv4IUGzEEetpHlu+fdxDG2AQoF1+KbBGYn9iTBkuHMAz6wLmPOMokjR5
         O0ErHoeekSiksto2KCewM/dX2wQbBNZVduHxYWVmZfOSsgh+WWFcRTilyWM/Wqx4m51Y
         53C4zszAxmJPGdfHEfpQM3DdLPIebJi16NYowizexj5yBqOpBwCpG9N8SndLW8DuBahM
         6xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWPTy4A7mxL/uLlMfV1TgQ2kHwhzQq4um9qbIMfROls=;
        b=LgY15mLcE7yIXIkUNbEB51HIr9ZFz8IED95Maacd08hVV+G3ufM6NXZG5ktomcNmXJ
         S9BbRU9d3k0+411mVkCVOHSRVt6r+vOQUjgu3qQGGzTb2TAoqmy7y7jrmoJ/jpxPGphx
         LWX9KMZ4UY0b+KFgZ9eNMuwuFcb+4GPISEUUTWvlAkhdRkXRz36KTUgjR9V7IY+f81Zp
         T6MM8iYNf0ER0AAqDMIqzktLidlxP+aRszoGGRUynv7jVYi199O9AJcL1x2qhgxEhdgH
         9IxreK++iGLaKE8SRuJtfa+fxhvoG5R9Te3fyGxmoRtg/+9Vm5Sb7dSsu4lOxmTLkmzO
         u9dg==
X-Gm-Message-State: AFqh2kp5xP880RaAJQthDzid3QPhr+i4gGZoOgu8w4ns0lEfEvpU24Iz
        6/FGXhQroKdeYLq6hO0kk3kGeg==
X-Google-Smtp-Source: AMrXdXvnS5rTlMASPz5KKnRRRrXVCvZXyiQQ8S/ynKxvkXLoM3ZDr1mAnqExJhIcf640fdD/j4N0CA==
X-Received: by 2002:a19:a40c:0:b0:4b5:b705:8491 with SMTP id q12-20020a19a40c000000b004b5b7058491mr10115410lfc.9.1672654787211;
        Mon, 02 Jan 2023 02:19:47 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id k9-20020ac257c9000000b004947a12232bsm4385122lfo.275.2023.01.02.02.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 02:19:46 -0800 (PST)
Message-ID: <3fb3359e-fc19-1ffd-47d1-e79744981bcd@linaro.org>
Date:   Mon, 2 Jan 2023 11:19:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 3/7] drm/msm/dpu: Disable MDP vsync source selection
 on DPU 5.0.0 and above
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kalyan Thota <quic_kalyant@quicinc.com>
References: <20221231215006.211860-1-marijn.suijten@somainline.org>
 <20221231215006.211860-4-marijn.suijten@somainline.org>
 <20221231215254.pqaegrmldufi7ugo@SoMainline.org>
 <853cbc6e-ae49-b2be-fb64-43f5171b74e8@linaro.org>
 <20230102101812.2zo6z57mdhdjueqb@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230102101812.2zo6z57mdhdjueqb@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 11:18, Marijn Suijten wrote:
> On 2023-01-02 10:30:58, Konrad Dybcio wrote:
>>
>>
>> On 31.12.2022 22:52, Marijn Suijten wrote:
>>> On 2022-12-31 22:50:02, Marijn Suijten wrote:
>>>> Since hardware revision 5.0.0 the TE configuration moved out of the
>>>> PINGPONG block into the INTF block, including vsync source selection
>>>> that was previously part of MDP top.  Writing to the MDP_VSYNC_SEL
>>>> register has no effect anymore and is omitted downstream via the
>>>> DPU/SDE_MDP_VSYNC_SEL feature flag.  This flag is only added to INTF
>>>> blocks used by hardware prior to 5.0.0.
>>>>
>>>> The code that writes to these registers in the INTF block will follow in
>>>> subsequent patches.
>>>>
>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>> ---
>>>>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 33 ++++++++++--
>>>>  .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  1 +
>>>>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    | 52 +++++++++++++------
>>>>  3 files changed, 66 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>> index 39d4b293710c..1cfe94494135 100644
>>>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>>>> @@ -407,7 +407,7 @@ static const struct dpu_mdp_cfg msm8998_mdp[] = {
>>>>  	{
>>>>  	.name = "top_0", .id = MDP_TOP,
>>>>  	.base = 0x0, .len = 0x458,
>>>> -	.features = 0,
>>>> +	.features = BIT(DPU_MDP_VSYNC_SEL),
>>>>  	.highest_bank_bit = 0x2,
>>>>  	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
>>>>  			.reg_off = 0x2AC, .bit_off = 0},
>>>> @@ -436,7 +436,7 @@ static const struct dpu_mdp_cfg sdm845_mdp[] = {
>>>>  	{
>>>>  	.name = "top_0", .id = MDP_TOP,
>>>>  	.base = 0x0, .len = 0x45C,
>>>> -	.features = BIT(DPU_MDP_AUDIO_SELECT),
>>>> +	.features = BIT(DPU_MDP_AUDIO_SELECT) | BIT(DPU_MDP_VSYNC_SEL),
>>>>  	.highest_bank_bit = 0x2,
>>>>  	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
>>>>  			.reg_off = 0x2AC, .bit_off = 0},
>>>> @@ -512,6 +512,31 @@ static const struct dpu_mdp_cfg sm6115_mdp[] = {
>>>>  	},
>>>>  };
>>>>  
>>>> +static const struct dpu_mdp_cfg sdm8150_mdp[] = {
>>>
>>> Sometimes it is only possible to spot such things _after_ sending,
>>> probably the thing that makes us human :)
>>>
>>> sm8150_mdp*, not sdm.
>>>
>>> - Marijn
>>>
>>>> +	{
>>>> +	.name = "top_0", .id = MDP_TOP,
>>>> +	.base = 0x0, .len = 0x45C,
>>>> +	.features = BIT(DPU_MDP_AUDIO_SELECT),
>>>> +	.highest_bank_bit = 0x2,
>>>> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = {
>>>> +			.reg_off = 0x2AC, .bit_off = 0},
>> Keeping the hex values lowercase would be nice.
> 
> Ack, this was copied verbatim from sdm845_mdp but will cleanup as we go.
> Looks like this file has a mixed approach towards lower and uppercase,
> when does the normalization patch land?
Rob was against changing everything in one commit, as that would mess
with git blame, so we settled on preventing adding new uppercase hex
for now (outside of #defines ofc).

Konrad
> 
> - Marijn
