Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B046C3844
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCURd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCURdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:33:54 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63823A7F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e11so7691096lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679420017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDwSwzPjD3OmF84qtgDXFqEH88rRTxQOUzKCvWTZg7o=;
        b=Nuj2JeD4rsGzzlDo9UKgA4bvRT01eirRyUTYHHwsc+ua4RG/H6RTxWwwUX/VoOF1JQ
         7LNmg/FqYH3ASWg9k77e8ut/0/rAZZTlDhSJ4P4Gc6xlWdlRx2jNcNNW1/JioFZxOG/F
         /JBq/CwCeSO47RYdKCTsRd77dXUqgSio8i+HeWZ57nUra1tCn7B6nmeTJmt2qzBbbTcY
         EQ1dmdjel1rb0hQAEk03dPGujuTy8YR35Dws1Gz2WK+QBgkTH/sOzvrmXDivMMAZmExS
         RKSvg03OzB/szl2vgDBhGyhYoH7tyyskFzffPTE3qRYct7KjBuevQp9fA6oGAP6IRLvO
         /PGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679420017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDwSwzPjD3OmF84qtgDXFqEH88rRTxQOUzKCvWTZg7o=;
        b=Yw3mgkU94xKl1IWDjMrgJlR3M/Drnx5tsZXu9Og1LFTfbbUNiObsa2dsG/wRf1EbZy
         6iJJfPF8Ap1Mmcb7/TlmAitdRR3uKywa/qCcVTVbPSPG5KymzA84CyZKX1fhFav2Pmj/
         CcgFiYJOoTrLenPScAW8vAI+r1eAN3AQPO0fNoSjubxR9KB72l1dwGiYz85ovT2yERHL
         eBR/7NmMFgQxlhIga8OaI7pwm1XvdWIih+SnAQo0REWT/j8b/14VO2RpJYy+yz55ZqtP
         hkR26sUEMYRyz2izMtvsF/cec3HOStEzMO9aJzbh6cJvLGG8R7R7mZ9TE3w+SMEVsGa/
         FPqg==
X-Gm-Message-State: AO0yUKX2lCiGnKFj4p5NxVIcnyDLKXzUyhVlbviUpKXd88PUdOjF0Lts
        afbLsabdoyIYY8AEMyZkNsyBRA==
X-Google-Smtp-Source: AK7set9oLoBN5qVhPyUil9/Rg3m9u1I4YYDTnxm3ahqrTYWVm7mtVqkYbJ3Og4n7B59zrYisKgcJFA==
X-Received: by 2002:a05:651c:10e:b0:29b:d436:5c91 with SMTP id a14-20020a05651c010e00b0029bd4365c91mr1158228ljb.4.1679420017283;
        Tue, 21 Mar 2023 10:33:37 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id u5-20020ac24c25000000b004e7a0f67490sm2220806lfq.110.2023.03.21.10.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:33:36 -0700 (PDT)
Message-ID: <564e5b54-66a5-2cb8-5bfc-b13b08f5eb6e@linaro.org>
Date:   Tue, 21 Mar 2023 18:33:35 +0100
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
 <101834f0-e00c-5469-c8a5-59a00a5160a5@linaro.org>
 <b3ef4fb6-91c7-1730-ceef-22fa3ef08e4e@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b3ef4fb6-91c7-1730-ceef-22fa3ef08e4e@kernel.org>
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



On 21.03.2023 15:49, Georgi Djakov wrote:
> On 21.03.23 16:23, Konrad Dybcio wrote:
>>
>>
>> On 21.03.2023 15:21, Georgi Djakov wrote:
>>> On 21.03.23 16:09, Konrad Dybcio wrote:
>>>>
>>>> On 21.03.2023 15:06, Georgi Djakov wrote:
>>>>> Hi Konrad,
>>>>>
>>>>> Thanks for the patch!
>>>>>
>>>>> On 8.03.23 23:40, Konrad Dybcio wrote:
>>>>>> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
>>>>>> one channel. This should be taken into account in bandwidth calcualtion,
>>>>>> as we're supposed to feed msmbus with the per-channel bandwidth. Add
>>>>>> support for specifying that and use it during bandwidth aggregation.
>>>>>>
>>>>>
>>>>> This looks good, but do you have any follow-up patch to use this and set
>>>>> the channels in some driver?
>>>> Yes, I have a couple of OOT drivers that are gonna make use of it.
>>>> TBF it should have been sent separately from the QoS mess, but I
>>>> don't think it's much of an issue to take it as-is.
>>>>
>>>> The aforementioned OOT drivers for MSM8998 and SM6375 will be
>>>> submitted after we reach a consensus on how we want to ensure
>>>> that each node is guaranteed to have its clocks enabled before
>>>> access, among some other minor things.
>>>
>>> Yes, these QoS clocks are confusing. Maybe you can even submit them
>>> without configuring any QoS stuff in first place? Does enabling QoS
>>> actually show any benefits on these devices?
>> Haven't tested that thoroughly to be honest. But I'll try to get
>> some numbers.
> 
> I expect this to have impact only on some latency sensitive stuff like
> modem or when there is heavy traffic flows. Maybe we can start without
> QoS first and then add it on top as a next step?
I only now remembered why I didn't do that.. Adding QoS at a later time
will break older DTs, as with QoS we need to pass some clocks to the driver.

Konrad
> 
> BR,
> Georgi
> 
>>
>> Konrad
>>>
>>> Thanks,
>>> Georgi
>>>
>>>> Konrad
>>>>>
>>>>> BR,
>>>>> Georgi
>>>>>
>>>>>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>>     drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>>>>>>     drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>>>>>     2 files changed, 8 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>>>>>> index 35fd75ae70e3..27c4c6497994 100644
>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.c
>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>>>>>> @@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>>>>     {
>>>>>>         struct icc_node *node;
>>>>>>         struct qcom_icc_node *qn;
>>>>>> +    u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>>>>         int i;
>>>>>>           /* Initialise aggregate values */
>>>>>> @@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>>>>>         list_for_each_entry(node, &provider->nodes, node_list) {
>>>>>>             qn = node->data;
>>>>>>             for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>>>>>> -            agg_avg[i] += qn->sum_avg[i];
>>>>>> +            if (qn->channels)
>>>>>> +                sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>>>>>> +            else
>>>>>> +                sum_avg[i] = qn->sum_avg[i];
>>>>>> +            agg_avg[i] += sum_avg[i];
>>>>>>                 agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>>>>>>             }
>>>>>>         }
>>>>>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>>>>>> index 8ba1918d7997..8aed5400afda 100644
>>>>>> --- a/drivers/interconnect/qcom/icc-rpm.h
>>>>>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>>>>>> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>>>>>>      * @id: a unique node identifier
>>>>>>      * @links: an array of nodes where we can go next while traversing
>>>>>>      * @num_links: the total number of @links
>>>>>> + * @channels: number of channels at this node (e.g. DDR channels)
>>>>>>      * @buswidth: width of the interconnect between a node and the bus (bytes)
>>>>>>      * @sum_avg: current sum aggregate value of all avg bw requests
>>>>>>      * @max_peak: current max aggregate value of all peak bw requests
>>>>>> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>>>>>>         u16 id;
>>>>>>         const u16 *links;
>>>>>>         u16 num_links;
>>>>>> +    u16 channels;
>>>>>>         u16 buswidth;
>>>>>>         u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>>>>>         u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>>>>>>
>>>>>
>>>
> 
