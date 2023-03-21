Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39756C33BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjCUOJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjCUOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:09:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3383B0C6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:09:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q14so1266869ljm.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679407753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q1UPEKYsCEIQfSc6MFeQtLNdtOY2okvAXDN+byESpbg=;
        b=ZssqnmZXo+gW38EhylEnNKyKU6fbUd12pD8iWQye119sxKASgzQJGlaZsKgDQUUXvP
         mEh9EJQyRtPVEEWBmAYtpCOnWqoN4zg72ihMtbL3/S/AASV2L5czbq3ooHZmhIe1QI1G
         9O6OhbWpz9/iVRYRdkmr7mBR2bslUbNaHEasP0eBrx5yqRWECPKnlGpVFPbmk5PtfLhm
         6Z0x+F0EU2n5qhXNwhikPBC4lGh+iGeGF45NOyFLG/cLYfZ9Sa5sWtByGX8Zon4gbzs7
         YbOZ+PrBfl6QGO74ARbUbY9KYt1N4kTRSNEV3YOiUkc9e0cNww03ChZHcF/qDvnuWhlz
         31nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q1UPEKYsCEIQfSc6MFeQtLNdtOY2okvAXDN+byESpbg=;
        b=qz5wXJR6PCKuEIKDh446aXM2FBCzQl512gT+fhdkQArKZQhO1NPN6kWdUF4k6adAtQ
         Hg++I+L64gwfOvTS/xXcAumzH7bfQpXE7NmtCOq48Whzlz9ZJ0iTPSz/uoDxliKaZr8X
         YRFeDZ/q5BBy6XUpAjUSyEj12EAOhwqsAA+DwmAB58Sld8BrhJkAzls8Kt1PXmtPiiaB
         ANpzKihSsJzR3eaMhRqshg/R3ZFgU+/p40l78XVoUkPihmn86sk35y6hdyyMV1y1AtMc
         lbQcR1G6ueJJgNVMCLBT8WWg8qMtNY8NVxiSpw2uPiAAI6yoKMRbu1iJww4S5ZyC/NDf
         N6Bg==
X-Gm-Message-State: AO0yUKVwepSur2FlEXbQiEsBB7iPFhRLpCuf73c9GWBnYxqSmgekZSp+
        urK6hPDbo2aOKas0ss+Wqy6VMA==
X-Google-Smtp-Source: AK7set9Fr6gl7pn4u71ZDmPex4iGOgTzKttYY/W4ZNLlQINYHh30hvDV/C0EF0diC7OiAmAMy9TS8A==
X-Received: by 2002:a05:651c:1050:b0:298:9fb5:9f20 with SMTP id x16-20020a05651c105000b002989fb59f20mr952022ljm.26.1679407753344;
        Tue, 21 Mar 2023 07:09:13 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e9d43000000b0029347612e94sm2228895ljj.123.2023.03.21.07.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 07:09:12 -0700 (PDT)
Message-ID: <38fe0736-b566-9e1b-d7f3-71e3fcd01d90@linaro.org>
Date:   Tue, 21 Mar 2023 15:09:11 +0100
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2f54ae85-f7b9-4666-cc05-6aa034028789@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.03.2023 15:06, Georgi Djakov wrote:
> Hi Konrad,
> 
> Thanks for the patch!
> 
> On 8.03.23 23:40, Konrad Dybcio wrote:
>> Some nodes, like EBI0 (DDR) or L3/LLCC, may be connected over more than
>> one channel. This should be taken into account in bandwidth calcualtion,
>> as we're supposed to feed msmbus with the per-channel bandwidth. Add
>> support for specifying that and use it during bandwidth aggregation.
>>
> 
> This looks good, but do you have any follow-up patch to use this and set
> the channels in some driver?
Yes, I have a couple of OOT drivers that are gonna make use of it.
TBF it should have been sent separately from the QoS mess, but I
don't think it's much of an issue to take it as-is.

The aforementioned OOT drivers for MSM8998 and SM6375 will be
submitted after we reach a consensus on how we want to ensure
that each node is guaranteed to have its clocks enabled before
access, among some other minor things.

Konrad
> 
> BR,
> Georgi
> 
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 7 ++++++-
>>   drivers/interconnect/qcom/icc-rpm.h | 2 ++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 35fd75ae70e3..27c4c6497994 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -317,6 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>   {
>>       struct icc_node *node;
>>       struct qcom_icc_node *qn;
>> +    u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
>>       int i;
>>         /* Initialise aggregate values */
>> @@ -334,7 +335,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>>       list_for_each_entry(node, &provider->nodes, node_list) {
>>           qn = node->data;
>>           for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
>> -            agg_avg[i] += qn->sum_avg[i];
>> +            if (qn->channels)
>> +                sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>> +            else
>> +                sum_avg[i] = qn->sum_avg[i];
>> +            agg_avg[i] += sum_avg[i];
>>               agg_peak[i] = max_t(u64, agg_peak[i], qn->max_peak[i]);
>>           }
>>       }
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 8ba1918d7997..8aed5400afda 100644
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
>>
> 
