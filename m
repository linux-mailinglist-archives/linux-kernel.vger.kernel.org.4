Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175A66D02C3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjC3LPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjC3LPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:15:34 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C340DC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:15:32 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h11so17060998lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680174930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwvbvPXxPR5P20tad4wCr/Qfgy5335Pq0zA9tfCxpKA=;
        b=bkwQUmdxhpi3uUU2Y7ja2F5fdp36Y7SeDu1dPbTtby9zQ0qSkBTwFD07jJpv9NZjHz
         gGe0IGcRJlBporhV+Z7MFmrhZuOatgn533LRXq1l17e1mdaqYcyFBZoVGJjuGsy7rbVp
         tjuzhLD9OEkwDlvxoNwVymXmdbSdwzx/CSQhQ008qPqgdP9TnEBkedk10kh1W93eiHfE
         7V88RcMkuCrmsHr8gmvuXHl3h8RitZuTb94MVmtpey0Vg1CSVXPcEhrZuVjsYz3YpTR8
         ooQfexdx/5Gr7jEdNzj4/cAATF2XbZg2YNKhYDll85BhcrF2tc/EUz+De3pUJVABxFBr
         uWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680174930;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwvbvPXxPR5P20tad4wCr/Qfgy5335Pq0zA9tfCxpKA=;
        b=BNct9zH5Q5pmR9+BR+ef+r6xjPI1vgHb2O3W8iqvW5CHdNcV/Vm/2GaujcGONl7qRn
         eqk2IuLMC6S4uyPVBvHcC3QX71a/47eZZdxyOuSjzajrMS5anJPuJge6cnw2rJM9AiPS
         ZYMLhrKQOxjS0JczJv7tVo8pXFx08M1TfD0AHkSTtz8XCrR0xL1/yg2t9TjbgmX7qt2j
         XklZiFNIbNRGMAL9u1e5D6d10VR3LF+MHFLtcK1IlYPX73o4qelFwAVUkFYlaslMlbpe
         FiRTSNhKH4cN/QopYXHtcN+5+fsYAVV95YdrTalrDIiDof3Q9kgV9QtkqiGyVr9ezHN4
         c/5Q==
X-Gm-Message-State: AAQBX9cgNd2iJpWAoKGbydq+7w3Vgoc7sdy+rSUPmpK+a90JuEdP/Ja6
        dh9z4mgm+ITi+dVR2oA/cShBRw==
X-Google-Smtp-Source: AKy350bTOJ6lsUvwVh84YWuxK0Emo+2xVWmF9qOLHP6Qocwsnd7NzOt+vZ6c9SDIhu9IYzkj9Q6Iiw==
X-Received: by 2002:ac2:482d:0:b0:4dd:9f86:859d with SMTP id 13-20020ac2482d000000b004dd9f86859dmr6189857lft.13.1680174930341;
        Thu, 30 Mar 2023 04:15:30 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id y28-20020ac255bc000000b004e846990cf0sm5864650lfg.11.2023.03.30.04.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 04:15:29 -0700 (PDT)
Message-ID: <58b9c5bb-e70c-67b3-e0d9-9aaaa4d4caf5@linaro.org>
Date:   Thu, 30 Mar 2023 13:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/18] media: venus: Introduce VPU version distinction
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
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
 <f8833364-854e-3f04-db7a-82a29682b0c9@linaro.org>
 <0e85caec-f6ec-fbd4-1815-8df9769bffcf@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0e85caec-f6ec-fbd4-1815-8df9769bffcf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.03.2023 13:02, Vikash Garodia wrote:
> On 3/2/2023 5:07 PM, Konrad Dybcio wrote:
>>
>> On 2.03.2023 08:12, Dikshita Agarwal wrote:
>>> On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
>>>> The Video Processing Unit hardware version is the differentiator,
>>>> based on which we should decide which code paths to take in hw
>>>> init. Up until now, we've relied on HFI versions, but that was
>>>> just a happy accident between recent SoCs. Add a field in the
>>>> res struct and add correlated definitions that will be used to
>>>> account for the aforementioned differences.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/media/platform/qcom/venus/core.h | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>>>> index 32551c2602a9..4b785205c5b1 100644
>>>> --- a/drivers/media/platform/qcom/venus/core.h
>>>> +++ b/drivers/media/platform/qcom/venus/core.h
>>>> @@ -48,6 +48,14 @@ struct bw_tbl {
>>>>        u32 peak_10bit;
>>>>    };
>>>>    +enum vpu_version {
>>>> +    VPU_VERSION_AR50, /* VPU4 */
>>>> +    VPU_VERSION_AR50_LITE, /* VPU4.4 */
>>>> +    VPU_VERSION_IRIS1, /* VPU5 */
> 
> There was Venus3X, followed by a different generation of video hardware. Driver just extended the versions for next generation incrementally.
> 
> Existing versions in driver are not the VPU versions, so we can drop them from comments.
Ack!

> 
>>>> +    VPU_VERSION_IRIS2,
>>>> +    VPU_VERSION_IRIS2_1,
>>>> +};
>>>> +
>>>>    struct venus_resources {
>>>>        u64 dma_mask;
>>>>        const struct freq_tbl *freq_tbl;
>>>> @@ -71,6 +79,7 @@ struct venus_resources {
>>>>        const char * const resets[VIDC_RESETS_NUM_MAX];
>>>>        unsigned int resets_num;
>>>>        enum hfi_version hfi_version;
>>>> +    enum vpu_version vpu_version;
>>>>        u8 num_vpp_pipes;
>>>>        u32 max_load;
>>>>        unsigned int vmem_id;
>>>> @@ -473,6 +482,12 @@ struct venus_inst {
>>>>    #define IS_V4(core)    ((core)->res->hfi_version == HFI_VERSION_4XX)
>>>>    #define IS_V6(core)    ((core)->res->hfi_version == HFI_VERSION_6XX)
>>>>    +#define IS_AR50(core)        ((core)->res->vpu_version == VPU_VERSION_AR50)
>>>> +#define IS_AR50_LITE(core)    ((core)->res->vpu_version == VPU_VERSION_AR50_LITE)
>>>> +#define IS_IRIS1(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS1)
>>>> +#define IS_IRIS2(core)        ((core)->res->vpu_version == VPU_VERSION_IRIS2)
>>>> +#define IS_IRIS2_1(core)    ((core)->res->vpu_version == VPU_VERSION_IRIS2_1)
>>>> +
>>>>    #define ctrl_to_inst(ctrl)    \
>>>>        container_of((ctrl)->handler, struct venus_inst, ctrl_handler)
>>>>    
>>> Adding VPU version check seems a good idea to me. Can we remove HFI Version checks now?
>> If all implementations using VPU x.y *always* use the
>> same HFI generation for given x, y, we could.
> 
> HFIs generally does not change, so we can be sure that they would always use the same HFI.
> 
> We might add a new interface (HFI) for a feature requirement, but always support the existing ones.
Okay, will do. Thanks!

Konrad
> 
>>
>> That said, I think keeping it as-is would be convenient
>> from the maintainability standpoint if nothing else.. For
>> example functions that only appear in ancient msm-3.10
>> releases can be easily guarded with IS_V1 or what have you
>> without having to dig up all n VPU revisions.
>>
>> Konrad
