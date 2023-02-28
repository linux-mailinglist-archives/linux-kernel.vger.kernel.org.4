Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479DA6A5CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjB1QFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjB1QFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:05:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCCE25B9F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:05:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s22so13858470lfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 08:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677600332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjoMqboHR+OmNdjSXfmG7uhDipuu/JuKIzoGyZRd+nM=;
        b=DibJWfF6KQ6o/ZOG/hk/SIQjR30CGIqNUAEUUOpXhmQaxcRZs0Hd4SfD1Bu+EN28yB
         OpB3kMFnEhUmuJChMlpsgKcJ00XRmYPuFlFcIvVmG+2bRSbK1vbUGkd+hm1kdITxvGHd
         P18eUsboai3VaGjk8x4oDnsVkWdaddWwmeHcCzKZbCZwNsKy3keJrvhv3A5o+7alrDmy
         O4Bz38artL/VvuWPR13MQu825aqJzwI5AVHoh94cDekNBpY8KAFLxNJGuL1/iib8M6gM
         OdESK2WIOL42/fFOuJe7CyuGifaKiwSlKMlVtzyTCDfwteGF6lAF/1/yBVo48e1MNVVX
         HZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677600332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjoMqboHR+OmNdjSXfmG7uhDipuu/JuKIzoGyZRd+nM=;
        b=JLGtZnwvuN748Tyxh1gK3KpQ2HROgiXQhjG6goauhIKaempNg7RNGFqmRFSdBzFaYp
         GiTmXN0wf22FxqDQSzKq9QZ8jXEhAZxIEzUrmt9nZiAwma/p4PSVH4fs1adGJ4w292qh
         Be8xv4yIz71W9wsfbExsKw3RSpfM0QDMfg/29s19jcUQqibTSU0icp1xk+AdatozyJMY
         fb1dBkPv8Jam1QmZd1J60rOm9qAo6qyWFxbmTa1xsJO1zFYaAv9mtpoov+494/ysbMnS
         ykEjaX1m5Z/FF4gVCBaWX5zPs8Wzc2fgVF/YYgZwEb1WsPZCiGD+5h3xRfOtrpMnIL+P
         sk1w==
X-Gm-Message-State: AO0yUKX1qMRZs7CeL6iyzrTYdRDgx1STdPAAdv3owG7QUkW5E/Gj8/dG
        EPv0ynHUkslTPicR/8Sbtudflw==
X-Google-Smtp-Source: AK7set9ZFGhH82AW1esRSzwgedkXyBcwWU/o6/4laXxMI1n5p23MRubwF7beikeFag6tLRWz8RFXeQ==
X-Received: by 2002:ac2:5317:0:b0:4dd:cc5e:e4f7 with SMTP id c23-20020ac25317000000b004ddcc5ee4f7mr817726lfh.55.1677600331761;
        Tue, 28 Feb 2023 08:05:31 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id y18-20020ac24472000000b004b55075f813sm1379479lfl.227.2023.02.28.08.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 08:05:31 -0800 (PST)
Message-ID: <24cfc366-e210-cdc3-519d-9a5ac0ae8bcb@linaro.org>
Date:   Tue, 28 Feb 2023 17:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] media: venus: Remap bufreq fields on HFI6XX
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-15-58c2c88384e9@linaro.org>
 <f215d875-4871-4d24-84ed-0703a28509d2@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f215d875-4871-4d24-84ed-0703a28509d2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.02.2023 16:51, Bryan O'Donoghue wrote:
> On 28/02/2023 15:24, Konrad Dybcio wrote:
>> Similarly to HFI4XX, the fields are remapped on 6XX as well. Fix it.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_helper.h | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
>> index d2d6719a2ba4..8d683a6e07af 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
>> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
>> @@ -1152,11 +1152,14 @@ struct hfi_buffer_display_hold_count_actual {
>>     /* HFI 4XX reorder the fields, use these macros */
>>   #define HFI_BUFREQ_HOLD_COUNT(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? 0 : (bufreq)->hold_count)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? 0 : (bufreq)->hold_count)
>>   #define HFI_BUFREQ_COUNT_MIN(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? (bufreq)->hold_count : (bufreq)->count_min)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? (bufreq)->hold_count : (bufreq)->count_min)
>>   #define HFI_BUFREQ_COUNT_MIN_HOST(bufreq, ver)    \
>> -    ((ver) == HFI_VERSION_4XX ? (bufreq)->count_min : 0)
>> +    ((ver) == HFI_VERSION_4XX || (ver) == HFI_VERSION_6XX \
>> +    ? (bufreq)->count_min : 0)
>>     struct hfi_buffer_requirements {
>>       u32 type;
>>
> 
> Doesn't this need a Fixes ?
Definitely could use some.. 

Konrad
> 
> ---
> bod
