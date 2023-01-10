Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA731665018
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjAJX4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjAJXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:55:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1DA55663
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:55:50 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id bn6so14313428ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxJysdNIrmRjvFROtnsTQyJodAB8veehuxuxefoCP2c=;
        b=rnirWVpiSpr6VhSQDQNoXvUVHyHeD6YL7RiNWjVUPzCzzsLSz550ShP6bkCBgPAnXE
         wZla1NaYrRHdDwOsR4FCEL70oxKgSUwchWimZR2Zp5JkFCr8B20Pbz6aZlr0KjnB9l9E
         t63pNJYKu02yjJDXV4Zwt5yyOP0J178b7wGbe2lf6rJSMKZL3vKHrkdvS77i/lqEyLWJ
         xFIOIu/+qvLa7WfAjhvWYVgAcYxhX96XmjwVEptuPUhGKGf/0HL5gBRhPdxrVy/hTaAO
         qfxScAkoWpyglZhuhCqxOA7fJmIDWWYgDWK/T6u99x8Vhc84fLWpFYq84tDeJgYEHYyI
         h5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxJysdNIrmRjvFROtnsTQyJodAB8veehuxuxefoCP2c=;
        b=hOQZsZ4dz2B/W9oVVvjQnBuaxYn5VThfaHVY3jzTBhc2+/m9BogclHVn5NE1mt0jNf
         LMHo15SMgW3oWrMiqZMXysWnF931dkrTe9hMVqgcdF6DJfc0Dc+Q3cUWWW1doZf6qQoq
         vIBNbMUn2Uxf9iqSYKSe/IOqOcc7eN5N5Lk/OvYpkKRrz3kMQVmGan4vhOmcvmmNoOfZ
         pDFxdIAteplQ6tzlvJSFLsU9mlHU9Gca6ZLlPsO2DEnVvrdYQs5b5JYomUDg/Q/2jOj3
         hL4rgaQIOWLVMbxWAsJhxKccEbTldtbkBSxvJMCH4MotUETauQBmtToyl+ezswMBfGcQ
         4jBw==
X-Gm-Message-State: AFqh2kq3isS3gNLI7HvJ0IXVEhy6wPAWeFcCKr94tYIaE6/iV3JCbX6Q
        iJBWPjdi3ztGMHi53jKbqGj+Tw==
X-Google-Smtp-Source: AMrXdXvWmU7sFzczcSVAcrS3tPmjKi3xby5j/0HDBfUoxMpFagyASGgQ61GU7Mn7Siaeag8qYSfcgA==
X-Received: by 2002:a2e:3211:0:b0:27f:c428:c5ec with SMTP id y17-20020a2e3211000000b0027fc428c5ecmr18754489ljy.28.1673394949087;
        Tue, 10 Jan 2023 15:55:49 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id a1-20020a2eb541000000b002770fb5722fsm1513208ljn.123.2023.01.10.15.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:55:48 -0800 (PST)
Message-ID: <bdff84b5-0531-909e-43ed-5cc1eda64f17@linaro.org>
Date:   Wed, 11 Jan 2023 00:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 04/10] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-5-konrad.dybcio@linaro.org>
 <4a30931b-ef94-df2f-2e89-1028bf9510ce@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <4a30931b-ef94-df2f-2e89-1028bf9510ce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.01.2023 00:44, Bryan O'Donoghue wrote:
> On 10/01/2023 13:21, Konrad Dybcio wrote:
>> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
>> one channel. This should be taken into account in bandwidth calcualtion,
> calculation
> 
>> as we're supposed to feed msmbus with the per-channel bandwidth. Add
>> support for specifying that and use it during bandwidth aggregation.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 0516b74abdc7..3207b4c99d04 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -336,6 +336,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>   {
>>       struct icc_node *node;
>>       struct qcom_icc_node *qn;
>> +    u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>       int i;
>>         /* Initialise aggregate values */
>> @@ -353,7 +354,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>       list_for_each_entry(node, &provider->nodes, node_list) {
>>           qn = node->data;
>>           for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>> -            agg_avg[i] += qn->sum_avg[i];
>> +            if (qn->channels)
> 
> when do you actually populate channels ?
> 
> I had a quick scan of your series, I didn't see it..
I use this field in the upcoming MSM8998 and SM6375 drivers,
which both require some part of this series to be merged.

If I'm not mistaken, this is essentially what downstream
calls qcom,agg-ports. 8996 should also use it, but I think
I'll add that in a separate series.

Other SoCs that I can see have a non-1 value here in various
downstream trees I have on my PC that don't necessarily have
interconnect drivers at the moment:

msm8976
sdm660
mdm9607
msm8953/sdm429
qcs405
msm8952

and a whole bunch of RPMh SoCs that already take care of this.

Konrad

> 
>> +                sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>> +            else
>> +                sum_avg[i] = qn->sum_avg[i];
>> +            agg_avg[i] += sum_avg[i];
>>               agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>>           }
>>       }
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 3762648f9d47..eb51680f890d 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -66,6 +66,7 @@ struct qcom_icc_qos {
>>    * @id: a unique node identifier
>>    * @links: an array of nodes where we can go next while traversing
>>    * @num_links: the total number of @links
>> + * @channels: number of channels at this node (e.g. DDR channels)
>>    * @buswidth: width of the interconnect between a node and the bus (bytes)
>>    * @sum_avg: current sum aggregate value of all avg bw requests
>>    * @max_peak: current max aggregate value of all peak bw requests
>> @@ -78,6 +79,7 @@ struct qcom_icc_node {
>>       u16 id;
>>       const u16 *links;
>>       u16 num_links;
>> +    u16 channels;
>>       u16 buswidth;
>>       u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>       u64 max_peak[QCOM_ICC_NUM_BUCKETS];
> 
