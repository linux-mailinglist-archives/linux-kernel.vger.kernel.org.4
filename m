Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42FE6E9F99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjDTXFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjDTXFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:05:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81773C3A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:05:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so984249e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682031908; x=1684623908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqd+EzF+urhH7274oBdY5LeIrEsmRsb7t4mEa/XIYp0=;
        b=S7zDyEf5tCKQLqvuPV5ndaSog2rzyXIjoV4QCmjb6xgWweA6A7KLQPYIbZiIujDGRs
         v+jDXH/ln08L5oWKwUHqa7RUbbHj5zJdicidd1MbvoGbLzWJN2jEoRdOD/fRp/fGe6Bh
         0bo/MM6UcrYXPged8PYlB+WCl2oeEJheV+qAK9YgetNDkRmjPZag0Cguuo24kMOMPVYS
         YiFeYnXJ18W2/KatirKERn5tsLYm6jXRHNnEbZ0vqJJoqIkz9peaih4NehsDh5IEJ0ro
         PDCm+iurHkBDlgMQB2J3wAGFph/dkN9MvEWylSjqbuJBTs2T0fiB9AzZQq/JHMweFUx+
         CFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682031908; x=1684623908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqd+EzF+urhH7274oBdY5LeIrEsmRsb7t4mEa/XIYp0=;
        b=BTF9P+3VhcAcuaMe/YsP4mTOIUzHTmVNGlAwMkIF1NPhw24eVf0CZAiEc7QkJiuppA
         WTfWod8bY/ZDJGNXDBd64X/SIYEu1pSsDV/zr+I/UVt+mu/NW7Q2Qm7sfiFWTDGR6kBk
         k1og45ry9bh0OyRrr/vHpr65G5ejyQbSOdBNfcTfPg9p96SkqquCxcvZgefI+oYSwNPP
         hwSNpOsP+gYbx9xaXv40YSiF4EbAyuWGWeZ07K0ZeD62+It7ESzUlVDjl/+G5dXFHZnx
         wbNJ8pyYZgloZ1+C7jBJ0palIJb1X3XZHcRex5sbCSRv0t5HufAyERvjWXeQ0iYMdkBr
         gMgQ==
X-Gm-Message-State: AAQBX9eVFQjpwF2K8qrVC/K+DM/uESZnlPd+aKy2cKK1RgIDOuQN9xPg
        wvadpVpuIHq8jk7Vt+CAY5IkTA==
X-Google-Smtp-Source: AKy350ZHc2Xi6EPcoQf0P4AaMLxpmSmhZfjLaOk3eFSroDuI7EfjamGYtrWg1XBq+nfojw2H8m5eJQ==
X-Received: by 2002:a19:ac0a:0:b0:4ed:c64c:37b with SMTP id g10-20020a19ac0a000000b004edc64c037bmr808138lfc.62.1682031908053;
        Thu, 20 Apr 2023 16:05:08 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id v6-20020ac25586000000b004eafa77e435sm357347lfg.146.2023.04.20.16.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 16:05:07 -0700 (PDT)
Message-ID: <4da9bd19-9403-812e-4554-847b18df78c9@linaro.org>
Date:   Fri, 21 Apr 2023 01:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 07/13] drm/msm/dpu: Add SM6350 support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
 <20230411-topic-straitlagoon_mdss-v2-7-5def73f50980@linaro.org>
 <fd2f43eb-aa10-eaf4-62f8-945a3152a28a@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fd2f43eb-aa10-eaf4-62f8-945a3152a28a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.04.2023 00:41, Dmitry Baryshkov wrote:
> On 21/04/2023 01:31, Konrad Dybcio wrote:
>> Add SM6350 support to the DPU1 driver to enable display output.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>> +
>> +static const struct dpu_sspp_cfg sm6350_sspp[] = {
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SC7180_MASK,
>> +         sc7180_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
>> +         sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_CURSOR_SDM845_MASK,
>> +         sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
> 
> DPU_CLK_CTRL_DMA0
> 
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
>> +         sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
> 
> DPU_CLK_CTRL_DMA2
_DMA1?


> 
> 
>> +};
>> +

>> +static const struct dpu_qos_lut_entry sm6350_qos_linear_macrotile[] = {
>> +    {.fl = 0, .lut = 0x0011223344556677 },
>> +    {.fl = 0, .lut = 0x0011223445566777 },
> 
> Do we need two equal entries here?
Hmm.. looks like the SDE driver dropped the fill level
logic in 4.19 times and that might have thrown me off
when porting this Since the [0] entry has what looks
like a lower LUT value, should I give it .fl=1?


> 
> Also please push the qos to the dpu_hw_catalog.c, I want to take another look at these structures and it is easier if all of them are beneath one's eyes.
Will do.

> 
>> +};
>> +
>> +static const struct dpu_perf_cfg sm6350_perf_data = {
>> +    .max_bw_low = 4200000,
>> +    .max_bw_high = 5100000,
>> +    .min_core_ib = 2500000,
>> +    .min_llcc_ib = 0,
>> +    .min_dram_ib = 1600000,
>> +    .min_prefill_lines = 35,
>> +    /* TODO: confirm danger_lut_tbl */
>> +    .danger_lut_tbl = {0xffff, 0xffff, 0x0, 0x0, 0xffff},
[...]


>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
>> @@ -320,6 +320,8 @@ enum dpu_qos_lut_usage {
>>       DPU_QOS_LUT_USAGE_LINEAR,
>>       DPU_QOS_LUT_USAGE_MACROTILE,
>>       DPU_QOS_LUT_USAGE_NRT,
>> +    DPU_QOS_LUT_USAGE_CWB,
>> +    DPU_QOS_LUT_USAGE_MACROTILE_QSEED,
> 
> This should probably be removed. It would be nice to clean these things up, but not as a part of sm6350.
Well, I won't be able to fill in the danger LUT table otherwise!

Konrad
> 
>>       DPU_QOS_LUT_USAGE_MAX,
>>   };
>>   @@ -880,6 +882,7 @@ extern const struct dpu_mdss_cfg dpu_sc8180x_cfg;
>>   extern const struct dpu_mdss_cfg dpu_sm8250_cfg;
>>   extern const struct dpu_mdss_cfg dpu_sc7180_cfg;
>>   extern const struct dpu_mdss_cfg dpu_sm6115_cfg;
>> +extern const struct dpu_mdss_cfg dpu_sm6350_cfg;
>>   extern const struct dpu_mdss_cfg dpu_qcm2290_cfg;
>>   extern const struct dpu_mdss_cfg dpu_sm8350_cfg;
>>   extern const struct dpu_mdss_cfg dpu_sc7280_cfg;
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> index 0e7a68714e9e..46be7ad8d615 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
>> @@ -1286,6 +1286,7 @@ static const struct of_device_id dpu_dt_match[] = {
>>       { .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
>>       { .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
>>       { .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
>> +    { .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
>>       { .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
>>       { .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
>>       { .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
>>
> 
