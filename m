Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0326F714A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjE2NeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjE2NeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:34:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17360DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:34:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2af2e908163so35272941fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685367248; x=1687959248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUA07q7mYkXN8wVPChZecILFUwJ1RMa5CnZ3abb0nMY=;
        b=pkW7Z1cVHEOnlVLJkBjNzjkkiO8NM2vYMLg6yPxEdMZ2a07USLAPzWdhHOB5ViPxJs
         TZTkzfHOA6Nd8C9lsl7ldEAWItXSrez20w7NBPuJ+jjjdgAD6OCqoSP/2HGemsEenIoV
         84kGCeEAAGsLW9TilZsnBUf1CVYKxcl6lNSSsgy+A1vPyw7uRrmk3a8zKsfVfeKpCjU4
         YM3I1qjSzuUNl+hcZ+nLIqAc62tuJSGaaKwfvRxTuYI5AR2MkbLTSNdQ37r+qEPUjXhn
         AJdqqJUcI7AMDVk4VlFrnSiKCVD43MaykDtFwJbScMgPLoCmpoz4B9EwLBTl9e1XTBlz
         C9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685367248; x=1687959248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUA07q7mYkXN8wVPChZecILFUwJ1RMa5CnZ3abb0nMY=;
        b=QBJz87CpT+0jcWjnYg3baHlab3TaG+FAs4n/L2TDXIzgWpH3hbfHzYKzResJJRXRtc
         L0/bPIn77qEvJiUejBBTOA9fp40CXgj/IwTlEGisLCHLhfMGEyOwrlmCSw4+KW7xtbZY
         fo5yyMv3FCT6XLnTxgA4kDI284AoSS6Ahm1hJoWaNrejZx0uMH1aXRJD5dwQuC4eNwYq
         743X5TTPH+T9npQEGrldypmuUAV2eeuGNqDgWLVhJbLjbq1Ako68NPMkCGxESTs9e01q
         NAnLOGR/i4JJdUs0jfG58f5MPWfh0Rq8+aDS7bXn2uwwcOFks4iwdqGdtXx7WYpRfc/z
         0oFQ==
X-Gm-Message-State: AC+VfDxvPI1ESCN73FP5Rpl7OGCIq/jEH8uy/1ZAxT+ZXahwu8+e8kya
        km6sPVyNyWiA4QEcaeMH5XIRkw==
X-Google-Smtp-Source: ACHHUZ4fjkUlyAONcCrJHEq5VFwORiOBYxD/b92R5rW/39PS7RVBLgtIWEXQkKEJ6aKOtUeVzkpq+g==
X-Received: by 2002:a2e:b6c2:0:b0:2ac:8486:e318 with SMTP id m2-20020a2eb6c2000000b002ac8486e318mr3473659ljo.35.1685367248247;
        Mon, 29 May 2023 06:34:08 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id i10-20020a2e808a000000b002adc2fe3fc8sm2450984ljg.4.2023.05.29.06.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:34:07 -0700 (PDT)
Message-ID: <419972e3-3052-87ae-a471-5fcf0a01f7da@linaro.org>
Date:   Mon, 29 May 2023 16:34:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/7] drm/msm/mdp5: Add MDP5 configuration for MSM8226
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-4-679f335d3d5b@z3ntu.xyz>
 <9858de8d-54ae-aa0c-35d8-fe8c1c8473b7@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9858de8d-54ae-aa0c-35d8-fe8c1c8473b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2023 14:59, Konrad Dybcio wrote:
> 
> 
> On 29.05.2023 11:44, Luca Weiss wrote:
>> Add the required config for the v1.1 MDP5 found on MSM8226.
>>
>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>> ---
>>   drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 82 ++++++++++++++++++++++++++++++++
>>   1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>> index 2eec2d78f32a..694d54341337 100644
>> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
>> @@ -103,6 +103,87 @@ static const struct mdp5_cfg_hw msm8x74v1_config = {
>>   	.max_clk = 200000000,
>>   };
>>   
>> +static const struct mdp5_cfg_hw msm8x26_config = {
> Luca, this patch looks good as-is (without diving into the values).
> 
> Dmitry, I see some things that we may improve here..
> 
> 1. Rename msm8xab to msm89ab or something, it's really inconsistent
>     with other drivers
> 
> 2. Some values seem very common / always constant.. perhaps we could
>     add some #defines like we do in DPU?

I really would not like to go the DPU way here. Maybe we can define the 
'full-featured' masks, while leaving the older hardware intact.

> 3. Can we add some magic defines to make flush_hw_mask non-cryptic?

Sounds like a good idea, especially since we have all the defines. I'll 
tend to it after landing 8226.

> 
> 4. We can probably use pointers in data structs and deduplicate identical
>     blocks!

Let's see.

> 
> Konrad
>> +	.name = "msm8x26",
>> +	.mdp = {
>> +		.count = 1,
>> +		.caps = MDP_CAP_SMP |
>> +			0,
>> +	},
>> +	.smp = {
>> +		.mmb_count = 7,
>> +		.mmb_size = 4096,
>> +		.clients = {
>> +			[SSPP_VIG0] =  1,
>> +			[SSPP_DMA0] = 4,
>> +			[SSPP_RGB0] = 7,
>> +		},
>> +	},
>> +	.ctl = {
>> +		.count = 2,
>> +		.base = { 0x00500, 0x00600 },
>> +		.flush_hw_mask = 0x0003ffff,
>> +	},
>> +	.pipe_vig = {
>> +		.count = 1,
>> +		.base = { 0x01100 },
>> +		.caps = MDP_PIPE_CAP_HFLIP |
>> +			MDP_PIPE_CAP_VFLIP |
>> +			MDP_PIPE_CAP_SCALE |
>> +			MDP_PIPE_CAP_CSC   |
>> +			0,
>> +	},
>> +	.pipe_rgb = {
>> +		.count = 1,
>> +		.base = { 0x01d00 },
>> +		.caps = MDP_PIPE_CAP_HFLIP |
>> +			MDP_PIPE_CAP_VFLIP |
>> +			MDP_PIPE_CAP_SCALE |
>> +			0,
>> +	},
>> +	.pipe_dma = {
>> +		.count = 1,
>> +		.base = { 0x02900 },
>> +		.caps = MDP_PIPE_CAP_HFLIP |
>> +			MDP_PIPE_CAP_VFLIP |
>> +			0,
>> +	},
>> +	.lm = {
>> +		.count = 2,
>> +		.base = { 0x03100, 0x03d00 },
>> +		.instances = {
>> +				{ .id = 0, .pp = 0, .dspp = 0,
>> +				  .caps = MDP_LM_CAP_DISPLAY, },
>> +				{ .id = 1, .pp = -1, .dspp = -1,
>> +				  .caps = MDP_LM_CAP_WB },
>> +			     },
>> +		.nb_stages = 2,
>> +		.max_width = 2048,
>> +		.max_height = 0xFFFF,
>> +	},
>> +	.dspp = {
>> +		.count = 1,
>> +		.base = { 0x04500 },
>> +	},
>> +	.pp = {
>> +		.count = 1,
>> +		.base = { 0x21a00 },
>> +	},
>> +	.intf = {
>> +		.base = { 0x00000, 0x21200 },
>> +		.connect = {
>> +			[0] = INTF_DISABLED,
>> +			[1] = INTF_DSI,
>> +		},
>> +	},
>> +	.perf = {
>> +		.ab_inefficiency = 100,
>> +		.ib_inefficiency = 200,
>> +		.clk_inefficiency = 125
>> +	},
>> +	.max_clk = 200000000,
>> +};
>> +
>>   static const struct mdp5_cfg_hw msm8x74v2_config = {
>>   	.name = "msm8x74",
>>   	.mdp = {
>> @@ -1236,6 +1317,7 @@ static const struct mdp5_cfg_hw sdm660_config = {
>>   
>>   static const struct mdp5_cfg_handler cfg_handlers_v1[] = {
>>   	{ .revision = 0, .config = { .hw = &msm8x74v1_config } },
>> +	{ .revision = 1, .config = { .hw = &msm8x26_config } },
>>   	{ .revision = 2, .config = { .hw = &msm8x74v2_config } },
>>   	{ .revision = 3, .config = { .hw = &apq8084_config } },
>>   	{ .revision = 6, .config = { .hw = &msm8x16_config } },
>>

-- 
With best wishes
Dmitry

