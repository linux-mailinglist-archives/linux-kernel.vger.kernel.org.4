Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0120B6C3415
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCUOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCUOYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:24:21 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3D1ACF7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so19355035lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679408626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zva7pNLmsdp/RMQSPrwmqUrYNtRIqOP5a4zLr3PoT04=;
        b=I0wVZ8I8q4aZnt+31KVvLFmPYpjg2ee/26mtd0DkXxOGrrfccusVRPAzDpeHZjN6u4
         uvfsu0NbMG4n214kfBQrFoGBdyBbdRFZyHK35ZU/wbwyJoW9W+OJg6yWlhR49yJDmQyc
         NBxaDrSMxd0Mw05IXc7GJn55XRymbO6gRhbAE6anO0gWFvMwkO8bC8EvbZAiIGVrhVF5
         CHO7EeBP2dv+rXea4P+GO1AUuOIrnu4EbqCq1TyHU0E28QCs+yZs0Dp3uCz3AiiiqtQQ
         iT06SqHBnX868/4lG8az3erWW71w4pSw9T31ZjA4Ntbcf79a4B7CHqv4AVC3bKlrx7ew
         sMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679408626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zva7pNLmsdp/RMQSPrwmqUrYNtRIqOP5a4zLr3PoT04=;
        b=fGBMmJVsgS0vFHbBqMU50M/yR2snQaA7Sl83jnkHPOfgp6e1+H+/raymgf277HbnRF
         WhTtmotHY6JG5qZKLRTSIq0TJvd4j1E8wxHX6b+DQt+zzCTt6ZoRzCYSizarb/ByfrPF
         v40k+D+avi3RzbhvKVIQShvwqyN78qtP+kgpqQUuXaH0+oTPHwRLftPgFRWAMTpki9Hu
         Tb+UQavth9C0n7qwMkCVoMtmXQ9elYf60CqQpd5IVIO0I/piBOdemN8VVKazIyx5ZzQ6
         l9A9pGohOq+tGU/AJKtLPVXe23s/k+PrODb8nGoivvgHRAZcZGHlgCFlrEZH1GDsJ5Ey
         PY4g==
X-Gm-Message-State: AO0yUKV7ezsF71XiIsHHXqL3etesiUlulaM4A22XA06wUDzmHwScxiaz
        E/p4bJao0j3y0REbiY7TBp8bOA==
X-Google-Smtp-Source: AK7set/tPyfbHh5kcNc0oI0w5nvcEIVgbbUVAyR/q4ce2hrnXbszCDa6McPsZi+MLC238+c8hgAbtA==
X-Received: by 2002:a19:7513:0:b0:4e9:609f:256d with SMTP id y19-20020a197513000000b004e9609f256dmr951609lfe.13.1679408626374;
        Tue, 21 Mar 2023 07:23:46 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id u8-20020a056512094800b004e7fa99f2b5sm2170794lft.186.2023.03.21.07.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:23:46 -0700 (PDT)
Message-ID: <101834f0-e00c-5469-c8a5-59a00a5160a5@linaro.org>
Date:   Tue, 21 Mar 2023 15:23:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 2/9] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Georgi Djakov <djakov@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-2-815606092fff@linaro.org>
 <2f54ae85-f7b9-4666-cc05-6aa034028789@kernel.org>
 <38fe0736-b566-9e1b-d7f3-71e3fcd01d90@linaro.org>
 <f8baed88-6a3b-17c5-4134-ce3917ee8632@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <f8baed88-6a3b-17c5-4134-ce3917ee8632@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 15:21, Georgi Djakov wrote:
> On 21.03.23 16:09, Konrad Dybcio wrote:
>>
>> On 21.03.2023 15:06, Georgi Djakov wrote:
>>> Hi Konrad,
>>>
>>> Thanks for the patch!
>>>
>>> On 8.03.23 23:40, Konrad Dybcio wrote:
>>>> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
>>>> one channel. This should be taken into account in bandwidth calcualtion,
>>>> as we're supposed to feed msmbus with the per-channel bandwidth. Add
>>>> support for specifying that and use it during bandwidth aggregation.
>>>>
>>>
>>> This looks good, but do you have any follow-up patch to use this and set
>>> the channels in some driver?
>> Yes, I have a couple of OOT drivers that are gonna make use of it.
>> TBF it should have been sent separately from the QoS mess, but I
>> don't think it's much of an issue to take it as-is.
>>
>> The aforementioned OOT drivers for MSM8998 and SM6375 will be
>> submitted after we reach a consensus on how we want to ensure
>> that each node is guaranteed to have its clocks enabled before
>> access, among some other minor things.
> 
> Yes, these QoS clocks are confusing. Maybe you can even submit them
> without configuring any QoS stuff in first place? Does enabling QoS
> actually show any benefits on these devices?
Haven't tested that thoroughly to be honest. But I'll try to get
some numbers.

Konrad
> 
> Thanks,
> Georgi
> 
>> Konrad
>>>
>>> BR,
>>> Georgi
>>>
>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>>>>    drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>> index 35fd75ae70e3..27c4c6497994 100644
>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>> @@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>>    {
>>>>        struct icc_node *node;
>>>>        struct qcom_icc_node *qn;
>>>> +    u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>>        int i;
>>>>          /* Initialise aggregate values */
>>>> @@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>>        list_for_each_entry(node, &provider->nodes, node_list) {
>>>>            qn = node->data;
>>>>            for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>>> -            agg_avg[i] += qn->sum_avg[i];
>>>> +            if (qn->channels)
>>>> +                sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>>>> +            else
>>>> +                sum_avg[i] = qn->sum_avg[i];
>>>> +            agg_avg[i] += sum_avg[i];
>>>>                agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>>>>            }
>>>>        }
>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>>>> index 8ba1918d7997..8aed5400afda 100644
>>>> --- a/drivers/interconnect/qcom/icc-rpm.h
>>>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>>>> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>>>>     * @id: a unique node identifier
>>>>     * @links: an array of nodes where we can go next while traversing
>>>>     * @num_links: the total number of @links
>>>> + * @channels: number of channels at this node (e.g. DDR channels)
>>>>     * @buswidth: width of the interconnect between a node and the bus (bytes)
>>>>     * @sum_avg: current sum aggregate value of all avg bw requests
>>>>     * @max_peak: current max aggregate value of all peak bw requests
>>>> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>>>>        u16 id;
>>>>        const u16 *links;
>>>>        u16 num_links;
>>>> +    u16 channels;
>>>>        u16 buswidth;
>>>>        u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>>        u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>>
>>>
> 
