Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0285969418D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjBMJmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBMJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:42:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00610D53D
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:41:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so30348891ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhV/lgBcxmp588yoG0cchGbb23rkyYFRgFUbItbxHyQ=;
        b=HN9fgH136xBbk9W5zA8768QWCBFLzWCwE+FABZNSHLAWjYAn7ZLOXEGI4LG5wHQkOj
         PN6Lu3D5M/FgH671PTqX6FEsWmx1XWo4p5D2Rig/q7W19m/k+yGnop38irdEE48r8n6m
         ZO+QXVOfmidGtDb8jzEUYRkgovzTlOkVLHC5DQlaX0wLIQV7ZoDv1NLMj7L0Ke/2h1bH
         yyWFD3NwUmqRlM1W80fT3KfMnnu27xfL2fG8h/+I8fN3Z3L6uPG05Sa4uLNc+iNMUgG5
         s7VxNxBTOZa8vMrrshnR4tQMztaDU5F55/k/cypDOpkUCUD7AfWvZx4DZwi8grQDNIJe
         PItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhV/lgBcxmp588yoG0cchGbb23rkyYFRgFUbItbxHyQ=;
        b=J8xz2fUZLNu+ctkfOoPMDYhHJ2Kl6pgVqmxfGPzDtR79cWEOibBJDaztEwLQ5/Y6Ze
         6RJNNi6j4+4j7qlwfoA4/zfSq9HB4lzq/4HqaSlkYhMmJQj+M12PWjxjrrvA1Ob3af/f
         W0suyWyJ0wVnczo1yCrq6sRBRT0CrWleS4+JS5fLw2nWxi8EtI+URmxeNjWJKRsR6d71
         luZGtCkxbGuPd7x9rN3wVNNXNKyKYzxBOd68RZ88SavqYhYqMbR+AV8CrBw5uN1XubVV
         vqqiQ5EfjF10uLoRWe3GWyJlqfVDaAAsilSaSoDd1tER3sftFPxp3bSFf4/GPJX8bQYS
         9EXA==
X-Gm-Message-State: AO0yUKUUJ2WhrlLNzfosWUeJaRDunnqk+loXm+M0HZ40004W0DB+fwOV
        YivCPOKkImRejpxLMS6wmGLIPw==
X-Google-Smtp-Source: AK7set8gyMk1PxBOkoOKDBcUforPwrXhkQ2RKuDM7ZIBuYomMiSi2tJjVFpxBE7JqtDcjdID5NheLg==
X-Received: by 2002:a17:906:75b:b0:87d:f32b:4108 with SMTP id z27-20020a170906075b00b0087df32b4108mr24110827ejb.42.1676281291697;
        Mon, 13 Feb 2023 01:41:31 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id cp17-20020a17090793d100b00889c115cf6asm6567873ejc.145.2023.02.13.01.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:41:31 -0800 (PST)
Message-ID: <0d40ef9f-3880-ff27-02f4-133695ef888c@linaro.org>
Date:   Mon, 13 Feb 2023 10:41:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/10] drm/msm/dpu: Allow variable SSPP/INTF_BLK size
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <rfoss@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211122656.1479141-1-konrad.dybcio@linaro.org>
 <20230211122656.1479141-6-konrad.dybcio@linaro.org>
 <290ce9fc-8285-94ff-7649-e1791de42f81@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <290ce9fc-8285-94ff-7649-e1791de42f81@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.02.2023 18:00, Dmitry Baryshkov wrote:
> On 11/02/2023 14:26, Konrad Dybcio wrote:
>> These blocks are of variable length on different SoCs. Set the
>> correct values where I was able to retrieve it from downstream
>> DTs and leave the old defaults (0x1c8 for sspp and 0x280 for
>> intf) otherwise.
> 
> Could you please add FIXMEs close to the values where we are unsure?
> 
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    | 242 +++++++++---------
>>   1 file changed, 121 insertions(+), 121 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 802050118345..d9ef1e133c1e 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -1167,11 +1167,11 @@ static const struct dpu_sspp_sub_blks sdm845_dma_sblk_1 = _DMA_SBLK("9", 2);
>>   static const struct dpu_sspp_sub_blks sdm845_dma_sblk_2 = _DMA_SBLK("10", 3);
>>   static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK("11", 4);
>>   -#define SSPP_BLK(_name, _id, _base, _features, \
>> +#define SSPP_BLK(_name, _id, _base, _len, _features, \
>>           _sblk, _xinid, _type, _clkctrl) \
>>       { \
>>       .name = _name, .id = _id, \
>> -    .base = _base, .len = 0x1c8, \
>> +    .base = _base, .len = _len, \
>>       .features = _features, \
>>       .sblk = &_sblk, \
>>       .xin_id = _xinid, \
>> @@ -1180,40 +1180,40 @@ static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK("11", 4);
>>       }
>>     static const struct dpu_sspp_cfg msm8998_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_MSM8998_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x184, VIG_MSM8998_MASK,
> 
> 0x1ac ? Not completely sure though.
(To be clear, "ack" in this review = "I checked deeper and agree
with what you found")

Ack

> 
>>           msm8998_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_MSM8998_MASK,
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x184, VIG_MSM8998_MASK,
>>           msm8998_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_MSM8998_MASK,
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x184, VIG_MSM8998_MASK,
>>           msm8998_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_MSM8998_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x184, VIG_MSM8998_MASK,
>>           msm8998_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_MSM8998_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x184, DMA_MSM8998_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_MSM8998_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x184, DMA_MSM8998_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_MSM8998_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x184, DMA_CURSOR_MSM8998_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000,  DMA_CURSOR_MSM8998_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x184, DMA_CURSOR_MSM8998_MASK,
>>           sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>     static const struct dpu_sspp_cfg sdm845_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SDM845_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1c8, VIG_SDM845_MASK,
>>           sdm845_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SDM845_MASK,
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x1c8, VIG_SDM845_MASK,
>>           sdm845_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_SDM845_MASK,
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x1c8, VIG_SDM845_MASK,
>>           sdm845_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_SDM845_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x1c8, VIG_SDM845_MASK,
>>           sdm845_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1c8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1c8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1224,13 +1224,13 @@ static const struct dpu_sspp_sub_blks sc7280_vig_sblk_0 =
>>               _VIG_SBLK_ROT("0", 4, DPU_SSPP_SCALER_QSEED4, &dpu_rot_sc7280_cfg_v2);
>>     static const struct dpu_sspp_cfg sc7180_sspp[] = {
> 
> 0x1f8
Ack.

> 
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SC7180_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1c8, VIG_SC7180_MASK,
>>           sc7180_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1c8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1238,9 +1238,9 @@ static const struct dpu_sspp_sub_blks sm6115_vig_sblk_0 =
>>                   _VIG_SBLK("0", 2, DPU_SSPP_SCALER_QSEED3LITE);
>>     static const struct dpu_sspp_cfg sm6115_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SM8250_MASK,
>>           sm6115_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>>   };
>>   @@ -1254,21 +1254,21 @@ static const struct dpu_sspp_sub_blks sm8250_vig_sblk_3 =
>>                   _VIG_SBLK("3", 8, DPU_SSPP_SCALER_QSEED3LITE);
>>     static const struct dpu_sspp_cfg sm8250_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_SM8250_MASK,
>>           sm8250_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x1f8, VIG_SM8250_MASK,
>>           sm8250_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x1f8, VIG_SM8250_MASK,
>>           sm8250_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x1f8, VIG_SM8250_MASK,
>>           sm8250_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1f8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1f8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x1f8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1282,21 +1282,21 @@ static const struct dpu_sspp_sub_blks sm8450_vig_sblk_3 =
>>                   _VIG_SBLK("3", 8, DPU_SSPP_SCALER_QSEED3LITE);
>>     static const struct dpu_sspp_cfg sm8450_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SC7180_MASK,
>> -        sm8450_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SC7180_MASK,
>> -        sm8450_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_SC7180_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x328, VIG_SC7180_MASK,
>> +        sm8450_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x328, VIG_SC7180_MASK,
>> +        sm8450_vig_sblk_1, 4, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x328, VIG_SC7180_MASK,
>>           sm8450_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_SC7180_MASK,
>> -        sm8450_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x328, VIG_SC7180_MASK,
>> +        sm8450_vig_sblk_3, 12, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x328, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x328, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x328, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x328, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1312,36 +1312,36 @@ static const struct dpu_sspp_sub_blks sm8550_dma_sblk_4 = _DMA_SBLK("12", 5);
>>   static const struct dpu_sspp_sub_blks sd8550_dma_sblk_5 = _DMA_SBLK("13", 6);
>>     static const struct dpu_sspp_cfg sm8550_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SC7180_MASK,
>> -        sm8550_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SC7180_MASK,
>> -        sm8550_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_SC7180_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x344, VIG_SC7180_MASK,
>> +        sm8550_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x344, VIG_SC7180_MASK,
>> +        sm8550_vig_sblk_1, 4, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x344, VIG_SC7180_MASK,
>>           sm8550_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_SC7180_MASK,
>> -        sm8550_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x344, VIG_SC7180_MASK,
>> +        sm8550_vig_sblk_3, 12, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x344, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x344, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x344, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA2),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x344, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA3),
>> -    SSPP_BLK("sspp_12", SSPP_DMA4, 0x2c000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_12", SSPP_DMA4, 0x2c000, 0x344, DMA_CURSOR_SDM845_MASK,
>>           sm8550_dma_sblk_4, 14, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_13", SSPP_DMA5, 0x2e000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_13", SSPP_DMA5, 0x2e000, 0x344, DMA_CURSOR_SDM845_MASK,
>>           sd8550_dma_sblk_5, 15, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>     static const struct dpu_sspp_cfg sc7280_sspp[] = {
> 
> 0x1f8
Ack.

> 
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SC7280_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1c8, VIG_SC7280_MASK,
>>           sc7280_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1c8, DMA_SDM845_MASK,
>>           sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000,  DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x1c8, DMA_CURSOR_SDM845_MASK,
>>           sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1355,21 +1355,21 @@ static const struct dpu_sspp_sub_blks sc8280xp_vig_sblk_3 =
>>                   _VIG_SBLK("3", 8, DPU_SSPP_SCALER_QSEED3LITE);
>>     static const struct dpu_sspp_cfg sc8280xp_sspp[] = {
> 
> Any particular source for 0x280? I'd assume it is also 0x328 with a FIXME
0x1c8 with a FIXME, this is a SSPP_BLK. I must have copypasted
the old default value for INTF_BLK here.

> 
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_SM8250_MASK,
>> -         sc8280xp_vig_sblk_0, 0,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, VIG_SM8250_MASK,
>> -         sc8280xp_vig_sblk_1, 4,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> -    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, VIG_SM8250_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x280, VIG_SM8250_MASK,
>> +         sc8280xp_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> +    SSPP_BLK("sspp_1", SSPP_VIG1, 0x6000, 0x280, VIG_SM8250_MASK,
>> +         sc8280xp_vig_sblk_1, 4, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG1),
>> +    SSPP_BLK("sspp_2", SSPP_VIG2, 0x8000, 0x280, VIG_SM8250_MASK,
>>            sc8280xp_vig_sblk_2, 8, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG2),
>> -    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, VIG_SM8250_MASK,
>> -         sc8280xp_vig_sblk_3, 12,  SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_3", SSPP_VIG3, 0xa000, 0x280, VIG_SM8250_MASK,
>> +         sc8280xp_vig_sblk_3, 12, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG3),
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x280, DMA_SDM845_MASK,
>>            sdm845_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>> -    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_9", SSPP_DMA1, 0x26000, 0x280, DMA_SDM845_MASK,
>>            sdm845_dma_sblk_1, 5, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA1),
>> -    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_10", SSPP_DMA2, 0x28000, 0x280, DMA_CURSOR_SDM845_MASK,
>>            sdm845_dma_sblk_2, 9, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR0),
>> -    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, DMA_CURSOR_SDM845_MASK,
>> +    SSPP_BLK("sspp_11", SSPP_DMA3, 0x2a000, 0x280, DMA_CURSOR_SDM845_MASK,
>>            sdm845_dma_sblk_3, 13, SSPP_TYPE_DMA, DPU_CLK_CTRL_CURSOR1),
>>   };
>>   @@ -1390,9 +1390,9 @@ static const struct dpu_sspp_sub_blks qcm2290_vig_sblk_0 = _VIG_SBLK_NOSCALE("0"
>>   static const struct dpu_sspp_sub_blks qcm2290_dma_sblk_0 = _DMA_SBLK("8", 1);
>>     static const struct dpu_sspp_cfg qcm2290_sspp[] = {
>> -    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, VIG_QCM2290_MASK,
>> +    SSPP_BLK("sspp_0", SSPP_VIG0, 0x4000, 0x1f8, VIG_QCM2290_MASK,
>>            qcm2290_vig_sblk_0, 0, SSPP_TYPE_VIG, DPU_CLK_CTRL_VIG0),
>> -    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000,  DMA_SDM845_MASK,
>> +    SSPP_BLK("sspp_8", SSPP_DMA0, 0x24000, 0x1f8, DMA_SDM845_MASK,
>>            qcm2290_dma_sblk_0, 1, SSPP_TYPE_DMA, DPU_CLK_CTRL_DMA0),
>>   };
>>   @@ -1848,10 +1848,10 @@ static struct dpu_dsc_cfg sm8150_dsc[] = {
>>   /*************************************************************
>>    * INTF sub blocks config
>>    *************************************************************/
>> -#define INTF_BLK(_name, _id, _base, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
>> +#define INTF_BLK(_name, _id, _base, _len, _type, _ctrl_id, _progfetch, _features, _reg, _underrun_bit, _vsync_bit) \
>>       {\
>>       .name = _name, .id = _id, \
>> -    .base = _base, .len = 0x280, \
>> +    .base = _base, .len = _len, \
>>       .features = _features, \
>>       .type = _type, \
>>       .controller_id = _ctrl_id, \
>> @@ -1861,85 +1861,85 @@ static struct dpu_dsc_cfg sm8150_dsc[] = {
>>       }
>>     static const struct dpu_intf_cfg msm8998_intf[] = {
> 
> 0x280? I'm not sure here though
Yep, I blame a certain Italian for messing with my go-to downstream.. :P

> 
>> -    INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_HDMI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_0", INTF_0, 0x6A000, 0x268, INTF_DP, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x268, INTF_DSI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x6B000, 0x268, INTF_DSI, 1, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x6B800, 0x268, INTF_HDMI, 0, 25, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     static const struct dpu_intf_cfg sdm845_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 1, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_0", INTF_0, 0x6A000, 0x280, INTF_DP, 0, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x280, INTF_DSI, 0, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x6B000, 0x280, INTF_DSI, 1, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x6B800, 0x280, INTF_DP, 1, 24, INTF_SDM845_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     static const struct dpu_intf_cfg sc7180_intf[] = {
> 
> 0x2b8
Ack

> 
>> -    INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_0", INTF_0, 0x6A000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x280, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>>   };
>>     static const struct dpu_intf_cfg sm8150_intf[] = {
> 
> 0x2b8
Ack

> 
>> -    INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_0", INTF_0, 0x6A000, 0x280, INTF_DP, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x280, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x6B000, 0x280, INTF_DSI, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x6B800, 0x280, INTF_DP, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     static const struct dpu_intf_cfg sc7280_intf[] = {
> 
> 0x2c4
Ack

> 
>> -    INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_5", INTF_5, 0x39000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>> +    INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x35000, 0x280, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_5", INTF_5, 0x39000, 0x280, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>>   };
>>     static const struct dpu_intf_cfg sm8350_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x36000, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x37000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_0", INTF_0, 0x34000, 0x2c4, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x35000, 0x2c4, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x36000, 0x2c4, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x37000, 0x2c4, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     static const struct dpu_intf_cfg sc8180x_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x6A000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x6B000, INTF_DSI, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_0", INTF_0, 0x6A000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x280, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x6B000, 0x280, INTF_DSI, 1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>>       /* INTF_3 is for MST, wired to INTF_DP 0 and 1, use dummy index until this is supported */
>> -    INTF_BLK("intf_3", INTF_3, 0x6B800, INTF_DP, 999, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> -    INTF_BLK("intf_4", INTF_4, 0x6C000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
>> -    INTF_BLK("intf_5", INTF_5, 0x6C800, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>> +    INTF_BLK("intf_3", INTF_3, 0x6B800, 0x280, INTF_DP, 999, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_4", INTF_4, 0x6C000, 0x280, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
>> +    INTF_BLK("intf_5", INTF_5, 0x6C800, 0x280, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>>   };
>>     /* TODO: INTF 3, 8 and 7 are used for MST, marked as INTF_NONE for now */
>>   static const struct dpu_intf_cfg sc8280xp_intf[] = {
> 
> I'd also suppose this is 0x2c4
No data, for now it's a 0x280 (with a FIXME though).

Konrad

> 
>> -    INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x36000, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x37000, INTF_NONE, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> -    INTF_BLK("intf_4", INTF_4, 0x38000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
>> -    INTF_BLK("intf_5", INTF_5, 0x39000, INTF_DP, MSM_DP_CONTROLLER_3, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>> -    INTF_BLK("intf_6", INTF_6, 0x3a000, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 16, 17),
>> -    INTF_BLK("intf_7", INTF_7, 0x3b000, INTF_NONE, MSM_DP_CONTROLLER_2, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 18, 19),
>> -    INTF_BLK("intf_8", INTF_8, 0x3c000, INTF_NONE, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 12, 13),
>> +    INTF_BLK("intf_0", INTF_0, 0x34000, 0x280, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x35000, 0x280, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x36000, 0x280, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x37000, 0x280, INTF_NONE, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_4", INTF_4, 0x38000, 0x280, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 20, 21),
>> +    INTF_BLK("intf_5", INTF_5, 0x39000, 0x280, INTF_DP, MSM_DP_CONTROLLER_3, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 22, 23),
>> +    INTF_BLK("intf_6", INTF_6, 0x3a000, 0x280, INTF_DP, MSM_DP_CONTROLLER_2, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 16, 17),
>> +    INTF_BLK("intf_7", INTF_7, 0x3b000, 0x280, INTF_NONE, MSM_DP_CONTROLLER_2, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 18, 19),
>> +    INTF_BLK("intf_8", INTF_8, 0x3c000, 0x280, INTF_NONE, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 12, 13),
>>   };
>>     static const struct dpu_intf_cfg qcm2290_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x00000, INTF_NONE, 0, 0, 0, 0, 0, 0),
>> -    INTF_BLK("intf_1", INTF_1, 0x6A800, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_0", INTF_0, 0x00000, 0x2b8, INTF_NONE, 0, 0, 0, 0, 0, 0),
>> +    INTF_BLK("intf_1", INTF_1, 0x6A800, 0x2b8, INTF_DSI, 0, 24, INTF_SC7180_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>>   };
>>     static const struct dpu_intf_cfg sm8450_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> -    INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x36000, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x37000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_0", INTF_0, 0x34000, 0x2c4, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_1", INTF_1, 0x35000, 0x2c4, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x36000, 0x2c4, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x37000, 0x2c4, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     static const struct dpu_intf_cfg sm8550_intf[] = {
>> -    INTF_BLK("intf_0", INTF_0, 0x34000, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>> +    INTF_BLK("intf_0", INTF_0, 0x34000, 0x300, INTF_DP, MSM_DP_CONTROLLER_0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 24, 25),
>>       /* TODO TE sub-blocks for intf1 & intf2 */
>> -    INTF_BLK("intf_1", INTF_1, 0x35000, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> -    INTF_BLK("intf_2", INTF_2, 0x36000, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> -    INTF_BLK("intf_3", INTF_3, 0x37000, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>> +    INTF_BLK("intf_1", INTF_1, 0x35000, 0x300, INTF_DSI, 0, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 26, 27),
>> +    INTF_BLK("intf_2", INTF_2, 0x36000, 0x300, INTF_DSI, 1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 28, 29),
>> +    INTF_BLK("intf_3", INTF_3, 0x37000, 0x300, INTF_DP, MSM_DP_CONTROLLER_1, 24, INTF_SC7280_MASK, MDP_SSPP_TOP0_INTR, 30, 31),
>>   };
>>     /*************************************************************
> 
