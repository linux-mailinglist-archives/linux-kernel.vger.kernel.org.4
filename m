Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8465CAC8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 01:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjADAZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 19:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbjADAZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 19:25:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A2D17588
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 16:25:21 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so48177134lfb.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 16:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lHvYK3MFqjttdQWMiOHkYctTXu2WUFxG+8qUCFSB91A=;
        b=FWXlyH0DAQ3qjP4Q2pgF0o5aG6p4f7qR3FOS2CBLCo1QzxsiBPk7duiTskSFrNN1Kb
         RgpUWyJLf4huPnauN9j6DAk1jZr4qSTitFN47DiHK7pAHjDN8rM0KEQ1JIRYhs1UHqfQ
         ieXQ8J1Y9gDKxl3n8vY8zrLhJ4LVy3iDdU9Ive6Wv4TWIe7cQNgpO1NsE3jS6Fri0bMr
         FlvRjORSjmBgWs9LVilG47sy3nKVh+ix1RH/CnC8xiuxOZpmVwelEz0JI3s/O8eAYiqo
         TmUoz+vTTgDQ/Jmpq8DUpJ8nxkiSpm8cLLGTsudLURsQr8OcVOmKvATN7FWPaYogOJa9
         9ESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lHvYK3MFqjttdQWMiOHkYctTXu2WUFxG+8qUCFSB91A=;
        b=BNe63wZdJwlqAyn03LtMw3kZs1j3+Lk6WiMvCd62p+eNg/PFL1ut5vjz9hwV84IAl7
         7ceaszA4UE8/9emtr8RN8Fu+XFFQa5X6wP1wxGKO/fWxkweU3tXQmyP+YNBtzfRYjc5/
         9kkWjGSRMN6o5jbK9as1xeyuXpI0TjRrkcwF1uG/OGuZyBB2xcg2wnjy5MIvA3Fi7CSo
         mVA3+II56lL4SVDBZTC5oAvlpJCOibUaMaswLRRc53Nyn6oSO/oOf60VhgW8hyqGKHJV
         poGSJaDgWNn0UuCjAohFg53o9KKPtxRlFAoN8H+O7xGd0RH8KufV/Ka6qeZMjAxU+KMF
         sYIA==
X-Gm-Message-State: AFqh2kqLoA61uAlM8BCzsKbcbZP2gAKhr1bONTDXBhdrgAIHJGh6tyoH
        Dr5wy1fO3Ph0Roado+v79eR8XQ==
X-Google-Smtp-Source: AMrXdXtuuKCKPyNVd7CcOz8YCpIOur3HAg7vUMbcUsAGJKMF6k4Cmoo7HHKVO8xqJ066BUBm3YOLqg==
X-Received: by 2002:a05:6512:3d9f:b0:4a4:68b7:f878 with SMTP id k31-20020a0565123d9f00b004a468b7f878mr19118870lfv.28.1672791919499;
        Tue, 03 Jan 2023 16:25:19 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id f2-20020a056512228200b004ca0ea7af24sm4969112lfu.174.2023.01.03.16.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 16:25:19 -0800 (PST)
Message-ID: <14e06574-f95e-8960-0243-8c95a1c294e9@linaro.org>
Date:   Wed, 4 Jan 2023 01:25:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/4] interconnect: qcom: rpm: Don't set QoS params before
 non-zero bw is requested
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
 <735088f7-2888-04b1-7751-a3ad7e13a857@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <735088f7-2888-04b1-7751-a3ad7e13a857@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4.01.2023 00:07, Bryan O'Donoghue wrote:
> On 03/01/2023 17:30, Konrad Dybcio wrote:
>> Until now, the icc-rpm driver unconditionally set QoS params, even on
>> empty requests. This is superfluous and the downstream counterpart does
>> not do it. Follow it by doing the same.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
>> index 43b9ce0dcb6a..06e0fee547ab 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.c
>> +++ b/drivers/interconnect/qcom/icc-rpm.c
>> @@ -193,6 +193,12 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
>>       struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>>       struct qcom_icc_node *qn = node->data;
>>   +    /* Defer setting QoS until the first non-zero bandwidth request. */
>> +    if (!(node->avg_bw || node->peak_bw)) {
>> +        dev_dbg(node->provider->dev, "NOT Setting QoS for %s\n", qn->name);
>> +        return 0;
>> +    }
>> +
>>       dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
>>         switch (qp->type) {
> 
> Doesn't downstream clear the registers on a zero allocation request ?
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1302
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1318
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1367
> 
> msm_bus_bimc_set_qos_bw()
> {
>     /* Only calculate if there's a requested bandwidth and window */
>     if (qbw->bw && qbw->ws) {
>     }else
>         /* Clear bandwidth registers */
>         set_qos_bw_regs(base, mas_index, 0, 0, 0, 0, 0);
> }
Yes, looks like that's the case, but also it's only for BIMC, not
for NOC:

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_noc.c#L246

Moreover, it only concerns QoS parameters that are not supported on
mainline (Grant Period, Grant Count, Threshold Lo/Me/Hi) [1], so that
pretty much addresses your worries, I think..

And FWIW that's definitely not the case anymore for QNOC (and BIMC
for that matter) on msm-5.4:

https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.9.14.r1/drivers/interconnect/qcom/icc-rpm.c#L217


Konrad

[1] Note: msm8939 seems to be a somewhat heavy user of these properties,
maybe it would be worth looking into implementing them?
> 
> ---
> bod
