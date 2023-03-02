Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0801C6A814D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCBLiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjCBLhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:37:45 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA80334338
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:37:19 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id j17so17228609ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677757023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2zzBwGydj/jVUfE783k7jdgPSx/pI0yeSTeEHixMGQ=;
        b=LDdgyllj8HvV5hO3W9MjES48NqzBVMrJYguvQJsB5MEpiWMIJZs7B78gFhKoFFSyCl
         dYIw8OnzSXhv+OdVELSlNGEZtxGdQPkj0JrsXIgQe5VVH0JPgsF10+jAmdK+2b4GVG9+
         pvqMf2M2VVM//+SmljFJUt7R4u8TgugB1tMCbThc6K63HYyLa35u5kszQjm8Qunw2TA4
         +eP3aVp0GoymBh/KnyYaA2feTj4Yg0x7rdM3CB7HXUhwzoWydqkgkEnx3ZLwETmGVKv+
         SinfPj5V9eyy2amS4gvSN1ux+BmCrR2FxWTfLAnxNYMwi/kkvJ7jHpnLBJ+bqJ15LOV9
         FK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677757023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2zzBwGydj/jVUfE783k7jdgPSx/pI0yeSTeEHixMGQ=;
        b=DtSxFS/pTWbUgr4HpVvx5WG6f/9It6ZX7R8NGkm1hZ+U60cwtIiJkJfY4aJOfTvHqi
         XnuBPZpxHoqfEu7C/V6ZfEOGFCiWbKfhy2MMQ0Euw0EnJ/ZQJ4WwtQtLqCWjarDK022P
         iQms3TfJmgo4lMwgDK0tzr/YmHiQ9MXovlTZz52SbZ4BvabBN4ooAPK/lxXsn2OYUFmS
         7fKXwCCci1Jrqmo3QeujrauA6UNbHesZqYNE/D9LN197BF5uFOErw3G3+fCa0DIh9fAm
         fe+LaZAn3mbGNratE6iPCtzD12DYXKLm7R7vmG/sJUeTqm+zhzGCIUjT3AN6wyYIUknh
         76Qw==
X-Gm-Message-State: AO0yUKWyARj5TXLFlG6GEit2Tr6Y2Gfzydcb45KEPqY1sAycdwlrOYiP
        FdDedh1LuJ0Xn48kfzsCaeTmnw==
X-Google-Smtp-Source: AK7set8YkHTIxaWwO2nJGzfyFsP9rbhGpNsDsbsH8fPEKB6ol0zfB1QWROm4BljU008zZe2mpFUGvQ==
X-Received: by 2002:a2e:9415:0:b0:291:90bf:1cc4 with SMTP id i21-20020a2e9415000000b0029190bf1cc4mr2738036ljh.26.1677757022719;
        Thu, 02 Mar 2023 03:37:02 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id u28-20020a2ea17c000000b002934b5d6a61sm2064610ljl.121.2023.03.02.03.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:37:02 -0800 (PST)
Message-ID: <f8833364-854e-3f04-db7a-82a29682b0c9@linaro.org>
Date:   Thu, 2 Mar 2023 12:37:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/18] media: venus: Introduce VPU version distinction
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-2-58c2c88384e9@linaro.org>
 <cf2eee18-a6c9-2a9b-84fa-3e2351c413e8@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <cf2eee18-a6c9-2a9b-84fa-3e2351c413e8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.03.2023 08:12, Dikshita Agarwal wrote:
> 
> On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
>> The Video Processing Unit hardware version is the differentiator,
>> based on which we should decide which code paths to take in hw
>> init. Up until now, we've relied on HFI versions, but that was
>> just a happy accident between recent SoCs. Add a field in the
>> res struct and add correlated definitions that will be used to
>> account for the aforementioned differences.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 32551c2602a9..4b785205c5b1 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -48,6 +48,14 @@ struct bw_tbl {
>>       u32 peak_10bit;
>>   };
>>   +enum vpu_version {
>> +    VPU_VERSION_AR50, /* VPU4 */
>> +    VPU_VERSION_AR50_LITE, /* VPU4.4 */
>> +    VPU_VERSION_IRIS1, /* VPU5 */
>> +    VPU_VERSION_IRIS2,
>> +    VPU_VERSION_IRIS2_1,
>> +};
>> +
>>   struct venus_resources {
>>       u64 dma_mask;
>>       const struct freq_tbl *freq_tbl;
>> @@ -71,6 +79,7 @@ struct venus_resources {
>>       const char * const resets[VIDC_RESETS_NUM_MAX];
>>       unsigned int resets_num;
>>       enum hfi_version hfi_version;
>> +    enum vpu_version vpu_version;
>>       u8 num_vpp_pipes;
>>       u32 max_load;
>>       unsigned int vmem_id;
>> @@ -473,6 +482,12 @@ struct venus_inst {
>>   #define IS_V4(core)    ((core)->res->hfi_version == HFI_VERSION_4XX)
>>   #define IS_V6(core)    ((core)->res->hfi_version == HFI_VERSION_6XX)
>>   +#define IS_AR50(core)        ((core)->res->vpu_version == VPU_VERSION_AR50)
>> +#define IS_AR50_LITE(core)    ((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
>> +#define IS_IRIS1(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS1)
>> +#define IS_IRIS2(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS2)
>> +#define IS_IRIS2_1(core)    ((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
>> +
>>   #define ctrl_to_inst(ctrl)    \
>>       container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
>>   
> 
> Adding VPU version check seems a good idea to me. Can we remove HFI Version checks now?
If all implementations using VPU x.y *always* use the
same HFI generation for given x, y, we could.

That said, I think keeping it as-is would be convenient
from the maintainability standpoint if nothing else.. For
example functions that only appear in ancient msm-3.10
releases can be easily guarded with IS_V1 or what have you
without having to dig up all n VPU revisions.

Konrad
> 
