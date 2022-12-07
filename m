Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8C9646206
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLGUEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGUEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:04:20 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499442F029
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:04:19 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id x28so13075248lfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 12:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3W4AXWAS24yUYVPMlcPiaqqG/pQP+BE1R3UfjzEdCQ=;
        b=Fs1+Z+Kws7zzF0olOZ8OzkKdCdQ0Mnb/kgdNkJrTGAXhdyZxDdzI/6FO7w4AdaaC94
         Tf5Dn7qOl/XN97QSdCz1mKdRYls82chj7JXgXYpf+rE4mxQTMX3BCqFcQWGXgNVbGqkb
         KoZuJYwDh3JKag9DKqgH8FLXBmIhJMmds1abSj4ragRYeQC2lmyqeOU+c0PJCjyqx4Y/
         lxJ2YUacvczwJIPm3HMMkBQGMPvnDgMY1juM9rrBILjWJkpSIsrsS0oH5qOOVklNbG52
         lFTOgdwH4zRKxOCx5Kqp4xHi02aixnSd05i+Q/PGSNmuwJa/GY85uPXJ1pL6JvWzDtwY
         KlZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3W4AXWAS24yUYVPMlcPiaqqG/pQP+BE1R3UfjzEdCQ=;
        b=g8BYoGv79IRg0vHjZRfs1/X/sU0P4952exCgvAvoe3q2mXMVTzqIbOyoXfHV5hcrFe
         9cSjGOHkyxUWLojsgHQfep9/srt3LOGEZ+kGib+kQZiaeY2Py+ZG0/vy2BuvFMY7ujR7
         FKOgFOCxOfVeUwjYXQc6G1xc18PkYvzU0ExyWH8lblX1ZlvvFq2Y4fHAPXGktJIIqTIV
         P7Vuk1JEerSLw87x+y17TqHM1vdN4ZQe3xFSE8Oa2wmYg8gPiWLDDnp5EYZKW49Y4Kac
         Ht2hC+Vp2nj3wKrIKwi6+v/IlRSbIcwp49pYUC2nQm5PveaRxcyPuUW+eb4JgjhvuJhY
         hVYA==
X-Gm-Message-State: ANoB5pm77yXe2PC2LquNRKTjI3Ego5k3HQ9eAArwRZSyjx31F07dQoAY
        PcQ7WFz5sEyHUAcXDeLMHpSSEg==
X-Google-Smtp-Source: AA0mqf7U3pgwgNVXnWuYdlHWRaFHTBavgDqmVajh1aIC4PNT3RriHB4hg+8UB2/l7yCEzpZ5R4gW0Q==
X-Received: by 2002:a05:6512:258a:b0:4b5:6fb9:708d with SMTP id bf10-20020a056512258a00b004b56fb9708dmr5129046lfb.300.1670443457554;
        Wed, 07 Dec 2022 12:04:17 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id c16-20020a056512325000b004994c190581sm2983236lfr.123.2022.12.07.12.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 12:04:17 -0800 (PST)
Message-ID: <de67c95a-d003-c4ef-64a4-c3565ce02b7a@linaro.org>
Date:   Wed, 7 Dec 2022 22:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 02/13] drm/msm/dpu: Introduce SC8280XP
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221205174433.16847-1-quic_bjorande@quicinc.com>
 <20221205174433.16847-3-quic_bjorande@quicinc.com>
 <0430d878-e0cd-3708-91a3-2eca66418386@linaro.org>
 <20221207162824.kyxecdz43v5ojatx@builder.lan>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221207162824.kyxecdz43v5ojatx@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 18:28, Bjorn Andersson wrote:
> On Wed, Dec 07, 2022 at 04:49:07PM +0200, Dmitry Baryshkov wrote:
>> On 05/12/2022 19:44, Bjorn Andersson wrote:
>>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> [..]
>>> +static const struct dpu_mdp_cfg sc8280xp_mdp[] = {
>>> +	{
>>> +	.name = "top_0", .id = MDP_TOP,
>>> +	.base = 0x0, .len = 0x494,
>>> +	.features = 0,
>>> +	.highest_bank_bit = 0x3, /* TODO: 2 for LP_DDR4 */
>>
>> ubwc_swizzle ? I'd suppose it's 6, but I'd bet on it.
>>
> 
> I don't see ubwc_swizzle defined for any other platform, and it seems to
> be unused for DPU_HW_UBWC_VER_40. Am I perhaps missing something?

Yes, it doesn't seem to be used for VER_40, just wanted to have it for 
the sake of completeness. See 
https://lore.kernel.org/linux-arm-msm/20221207142833.204193-4-dmitry.baryshkov@linaro.org/T/#u

> 
>>> +	.clk_ctrls[DPU_CLK_CTRL_VIG0] = { .reg_off = 0x2ac, .bit_off = 0},
>>> +	.clk_ctrls[DPU_CLK_CTRL_VIG1] = { .reg_off = 0x2b4, .bit_off = 0},
>>> +	.clk_ctrls[DPU_CLK_CTRL_VIG2] = { .reg_off = 0x2bc, .bit_off = 0},
>>> +	.clk_ctrls[DPU_CLK_CTRL_VIG3] = { .reg_off = 0x2c4, .bit_off = 0},
>>> +	.clk_ctrls[DPU_CLK_CTRL_DMA0] = { .reg_off = 0x2ac, .bit_off = 8},
>>> +	.clk_ctrls[DPU_CLK_CTRL_DMA1] = { .reg_off = 0x2b4, .bit_off = 8},
>>> +	.clk_ctrls[DPU_CLK_CTRL_CURSOR0] = { .reg_off = 0x2bc, .bit_off = 8},
>>> +	.clk_ctrls[DPU_CLK_CTRL_CURSOR1] = { .reg_off = 0x2c4, .bit_off = 8},
>>> +	.clk_ctrls[DPU_CLK_CTRL_REG_DMA] = { .reg_off = 0x2bc, .bit_off = 20},
>>> +	},
>>> +};
>>> +
>>>    static const struct dpu_mdp_cfg qcm2290_mdp[] = {
>>>    	{
>>>    	.name = "top_0", .id = MDP_TOP,
>>> @@ -648,6 +693,45 @@ static const struct dpu_ctl_cfg sc7180_ctl[] = {
>>>    	},
>>>    };
>>> +static const struct dpu_ctl_cfg sc8280xp_ctl[] = {
>>> +	{
>>> +	.name = "ctl_0", .id = CTL_0,
>>> +	.base = 0x15000, .len = 0x204,
>>> +	.features = BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG),
>>
>> Please use CTL_SC7270_MASK instead, unless you have a strong reasong not to
>> do it.
>>
> 
> No strong reason, will update.

Thanks. The logic for me is to be able to update a single mask when new 
features are added instead of going all over the code.

E.g. I think sc8280xp will benefit from hierarchical DSPP support, will 
it not?

> 
> Thanks,
> Bjorn

-- 
With best wishes
Dmitry

