Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9EC73ADAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjFWAPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjFWAPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:15:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4107C7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:15:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f769c37d26so10908080e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 17:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687479314; x=1690071314;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mwHzVLTtnHqsMBGC/FQz0dqtXzYxkIgtPAX7zoSxuL4=;
        b=SoClXjsERx79ZMZPpfyw8UKuqcOCAxhoaAsSuKiUYGsU5CEqD/FsQwAwIeBgqEVWm4
         7yuyvJI7EegWt8ura5VIvwFTucZf1vsNs+ZnJUC+dv4oyMfA3JdH9bPj20gZ0s7jYtXB
         TTsfonEHK8sSKEmrZypHZvVnu9xTKWV7PHEd+wjG/YVoyCdX1qofBCti1dHwiymKAbgC
         X+ARR5ci6HHLktG1jM+f2bGCWo8EvlcQNU4V4H8g0BjCC07+PPInZ5K8TED2tsoNSl5+
         QZImD9QP4JAKa21SfeeKvq1JRENG/JBvsUmyB4X+SXPEgverM25ZlIPtcxSbNdvf090J
         aIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687479314; x=1690071314;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mwHzVLTtnHqsMBGC/FQz0dqtXzYxkIgtPAX7zoSxuL4=;
        b=GTbaM4cLvRbZI4CFKOkkG4mk8PDbvEemkTEzPZs+xWqOdlM/CR+dRoSy+oxCHmTeX8
         SVK1fnWwgR5yWvgBU3YrK/CV8prC5VRGBOWZhqpp5rtFLYoDD8x3axULA9v5wVUicQsj
         9q+/5tHpEKpfZJP427KhHo3z+thYUfKt6raEMayc0uB5Hc7h7FmcCugLHIueZN5bWlxq
         xXIMvnQHVzU+U8Wth/5re7AmUqr2n0ZAsMbeg5OHV9x7GCNffd9efc2ws/IWknbevTJ+
         yrA3BIv4XqcsDjxvAGrlHTAP/PImn+/kyUfCmD+IupC8F3osPyj1nSHOubqfJwmXLPp/
         Tvtw==
X-Gm-Message-State: AC+VfDyySkxOTehDyhXyqQO9qlAkPQPRRYf/w/6r/TTxM0YiTDSSWtR0
        GF4VpKavJJai3fKBRfkGKcAAZA==
X-Google-Smtp-Source: ACHHUZ4Jrm2gqG4uJaH179xMkyfeTBx4XcT8MrEfOAlu9CWo5wtOhHNGfL7MI1bnecP0/lwiYPT38A==
X-Received: by 2002:a19:6909:0:b0:4f8:7513:8cb0 with SMTP id e9-20020a196909000000b004f875138cb0mr7444566lfc.2.1687479313847;
        Thu, 22 Jun 2023 17:15:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y10-20020ac255aa000000b004f842478f9asm1242246lfg.88.2023.06.22.17.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 17:15:13 -0700 (PDT)
Message-ID: <a87e51e5-416f-307f-fe7c-368a5942e998@linaro.org>
Date:   Fri, 23 Jun 2023 03:15:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] drm/msm/dpu: Drop unused num argument from relevant
 macros
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Ryan McCann <quic_rmccann@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, quic_jesszhan@quicinc.com
References: <20230622-devcoredump_patch-v1-0-3b2cdcc6a576@quicinc.com>
 <20230622-devcoredump_patch-v1-2-3b2cdcc6a576@quicinc.com>
 <0d702a8d-c9fa-1fd4-1c2b-a1a10abca22f@linaro.org>
In-Reply-To: <0d702a8d-c9fa-1fd4-1c2b-a1a10abca22f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2023 02:57, Dmitry Baryshkov wrote:
> On 23/06/2023 02:48, Ryan McCann wrote:
>> Drop unused parameter "num" from VIG_SBLK_NOSCALE and DMA sub block
>> macros. Update calls to relevant macros to reflect change.
> 
> This is not relevant for this patchset.

Ok, after reviewing the rest of the patches, I see that it is indeed 
relevant. However could you please follow another path (outlined in the 
review for patch 6).

Note, that for the sake of subblock dumping we can ignore the issue with 
the names completely and drop them in the separate patchset.

> 
> With https://patchwork.freedesktop.org/patch/534745/?series=116851&rev=2 
> in place, VIG_SBLK and VIG_SBLK_ROT should also stop using num. But 
> let's probably take another step forward and drop both arguments and use 
> just a single instance of sblk per platform. I'll send a patch for it.
> 
>>
>> Signed-off-by: Ryan McCann <quic_rmccann@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 22 
>> +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c 
>> b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> index 0de507d4d7b7..69200b4cf210 100644
>> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
>> @@ -288,7 +288,7 @@ static const uint32_t wb2_formats[] = {
>>       .rotation_cfg = rot_cfg, \
>>       }
>> -#define _DMA_SBLK(num, sdma_pri) \
>> +#define _DMA_SBLK(sdma_pri) \
>>       { \
>>       .maxdwnscale = SSPP_UNITY_SCALE, \
>>       .maxupscale = SSPP_UNITY_SCALE, \
>> @@ -323,10 +323,10 @@ static const struct dpu_sspp_sub_blks 
>> sdm845_vig_sblk_2 =
>>   static const struct dpu_sspp_sub_blks sdm845_vig_sblk_3 =
>>                   _VIG_SBLK("3", 8, DPU_SSPP_SCALER_QSEED3);
>> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_0 = 
>> _DMA_SBLK("8", 1);
>> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_1 = 
>> _DMA_SBLK("9", 2);
>> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_2 = 
>> _DMA_SBLK("10", 3);
>> -static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = 
>> _DMA_SBLK("11", 4);
>> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_0 = _DMA_SBLK(1);
>> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_1 = _DMA_SBLK(2);
>> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_2 = _DMA_SBLK(3);
>> +static const struct dpu_sspp_sub_blks sdm845_dma_sblk_3 = _DMA_SBLK(4);
>>   #define SSPP_BLK(_name, _id, _base, _len, _features, \
>>           _sblk, _xinid, _type, _clkctrl) \
>> @@ -365,11 +365,11 @@ static const struct dpu_sspp_sub_blks 
>> sm8550_vig_sblk_1 =
>>   static const struct dpu_sspp_sub_blks sm8550_vig_sblk_2 =
>>                   _VIG_SBLK("2", 9, DPU_SSPP_SCALER_QSEED4);
>>   static const struct dpu_sspp_sub_blks sm8550_vig_sblk_3 =
>> -                _VIG_SBLK("3", 10, DPU_SSPP_SCALER_QSEED4);
>> -static const struct dpu_sspp_sub_blks sm8550_dma_sblk_4 = 
>> _DMA_SBLK("12", 5);
>> -static const struct dpu_sspp_sub_blks sm8550_dma_sblk_5 = 
>> _DMA_SBLK("13", 6);
>> +                _VIG_SBLK(10, DPU_SSPP_SCALER_QSEED4);
>> +static const struct dpu_sspp_sub_blks sm8550_dma_sblk_4 = _DMA_SBLK(5);
>> +static const struct dpu_sspp_sub_blks sm8550_dma_sblk_5 = _DMA_SBLK(6);
>> -#define _VIG_SBLK_NOSCALE(num, sdma_pri) \
>> +#define _VIG_SBLK_NOSCALE(sdma_pri) \
>>       { \
>>       .maxdwnscale = SSPP_UNITY_SCALE, \
>>       .maxupscale = SSPP_UNITY_SCALE, \
>> @@ -380,8 +380,8 @@ static const struct dpu_sspp_sub_blks 
>> sm8550_dma_sblk_5 = _DMA_SBLK("13", 6);
>>       .virt_num_formats = ARRAY_SIZE(plane_formats), \
>>       }
>> -static const struct dpu_sspp_sub_blks qcm2290_vig_sblk_0 = 
>> _VIG_SBLK_NOSCALE("0", 2);
>> -static const struct dpu_sspp_sub_blks qcm2290_dma_sblk_0 = 
>> _DMA_SBLK("8", 1);
>> +static const struct dpu_sspp_sub_blks qcm2290_vig_sblk_0 = 
>> _VIG_SBLK_NOSCALE(2);
>> +static const struct dpu_sspp_sub_blks qcm2290_dma_sblk_0 = _DMA_SBLK(1);
>>   /*************************************************************
>>    * MIXER sub blocks config
>>
> 

-- 
With best wishes
Dmitry

