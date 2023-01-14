Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37BF66A869
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 02:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjANBk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 20:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjANBkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 20:40:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88FC7F462
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:40:22 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id r2so22566040wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3BE2U/BpfWFrvPlxtKLOz5b9WboEgquhdVC53R/Grpo=;
        b=sBi00uOOOpjs7dkU85dc73iWeJm+lQFX0AKJT0bZrc75jRgWd/4cqYKlZDA9xvDOFV
         PGs9BvGgFtGtSAC4rkH3Ik8f1VvHJWOR/x6oTlXOH2mZZnk2lZbbSwmZzpdTSKZuhsxm
         xyYk1B0uHP0r9TMZcyhyi+ybTtYMt0jg7E9P0fj8YMHjkyV/2xhWcZ8UNKOBFXt6TVxU
         L6ffL96s55WMBtyOll6X6qkHIMUNgqBqGbOAFI+k68T0J7EcJdPE/XZtSGTf+ZGczbKC
         FTIHB8JljNBOejqJyTGNO/N2NOtuXx2sFlwjqh02wfKoSTGX6jFfVJNZer5zZQtPdLYY
         mTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3BE2U/BpfWFrvPlxtKLOz5b9WboEgquhdVC53R/Grpo=;
        b=1/02uvYRx+HJFzSXiEJ0+it6d1DIYMU1nQCEM7bhqWIOZCfFeK/esIn0ECpNbENw+0
         dLETLtyvNLw4K23z2UamoEeU6qtvUpwwv1Xw6kK+A3PiSI70vn2c7Jriq/tPyBZDlsoD
         PwTY9qvhMDt5TGzwQKsfTgg5fBUiLtkDxfHvGvi16NofidW9FPuFbR2Nir7YeufHQpXL
         PDtxAZUATBd2mFO6xcDgKZo3aXpfNrTVkh8xaQTWwdW53fRgZgIpGg0um51GLlsAn3ps
         Ifqc+sKSB4yHiTndNtYSyIZTpfk/yqHBgWXhJ8tOwON1mzyk2IdnYPU2I4h4+cyIP/yp
         nCdg==
X-Gm-Message-State: AFqh2kqze1IP/iglaQk0WUbeU+xcS2CoTdaeTT8qTVaCW3m3tsTsnZN0
        Gvl98j9gw9KUxf6c13MMWUNIzQ==
X-Google-Smtp-Source: AMrXdXv6kNTDJkTh0x9q4QGdu19j8o8OqwfCJeVEjhLQXiN/T/cqO7FZPfw3a9NeKphGoHPb8VcHTA==
X-Received: by 2002:adf:f1c6:0:b0:2bb:c50f:6381 with SMTP id z6-20020adff1c6000000b002bbc50f6381mr17515639wro.6.1673660421170;
        Fri, 13 Jan 2023 17:40:21 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d14-20020adffbce000000b002bddd75a83fsm3061349wrs.8.2023.01.13.17.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 17:40:20 -0800 (PST)
Message-ID: <5e1f37ba-494a-19d2-e412-7631508ab142@linaro.org>
Date:   Sat, 14 Jan 2023 01:40:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] interconnect: Skip call into provider if initial bw is
 zero
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Vivek Aknurwar <quic_viveka@quicinc.com>, djakov@kernel.org
Cc:     quic_mdtipton@quicinc.com, quic_okukatla@quicinc.com,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1673647679-15216-1-git-send-email-quic_viveka@quicinc.com>
 <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
In-Reply-To: <83a7bfed-3b16-3d01-b1b2-f197252bd0b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2023 01:24, Bryan O'Donoghue wrote:
> On 13/01/2023 22:07, Vivek Aknurwar wrote:
>> Currently framework sets bw even when init bw requirements are zero 
>> during
>> provider registration, thus resulting bulk of set bw to hw.
>> Avoid this behaviour by skipping provider set bw calls if init bw is 
>> zero.
>>
>> Signed-off-by: Vivek Aknurwar <quic_viveka@quicinc.com>
>> ---
>>   drivers/interconnect/core.c | 17 ++++++++++-------
>>   1 file changed, 10 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 25debde..43ed595 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -977,14 +977,17 @@ void icc_node_add(struct icc_node *node, struct 
>> icc_provider *provider)
>>       node->avg_bw = node->init_avg;
>>       node->peak_bw = node->init_peak;
>> -    if (provider->pre_aggregate)
>> -        provider->pre_aggregate(node);
>> -
>> -    if (provider->aggregate)
>> -        provider->aggregate(node, 0, node->init_avg, node->init_peak,
>> -                    &node->avg_bw, &node->peak_bw);
>> +    if (node->avg_bw || node->peak_bw) {
>> +        if (provider->pre_aggregate)
>> +            provider->pre_aggregate(node);
>> +
>> +        if (provider->aggregate)
>> +            provider->aggregate(node, 0, node->init_avg, 
>> node->init_peak,
>> +                        &node->avg_bw, &node->peak_bw);
>> +        if (provider->set)
>> +            provider->set(node, node);
>> +    }
>> -    provider->set(node, node);
>>       node->avg_bw = 0;
>>       node->peak_bw = 0;
> 
> I have the same comment/question for this patch that I had for the qcom 
> arch specific version of it. This patch seems to be doing at a higher 
> level what the patch below was doing at a lower level.
> 
> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m0c90588d0d1e2ab88c39be8f5f3a8f0b61396349
> 
> what happens to earlier silicon - qcom silicon which previously made 
> explicit zero requests ?
> 
> https://lore.kernel.org/lkml/1039a507-c4cd-e92f-dc29-1e2169ce5078@linaro.org/T/#m589e8280de470e038249bb362634221771d845dd
> 
> https://lkml.org/lkml/2023/1/3/1232
> 
> Isn't it a better idea to let lower layer drivers differentiate what 
> they do ?
> 
> For example on pre 5.4 qcom kernel silicon we might choose to set the 
> value to zero "because that's what the reference code did" but on newer 
> silicon we might opt to skip the zero configuration ?
> 
> I'm happy to be shown the error of my ways but, absent testing to *show* 
> it doesn't impact existing legacy silicon, I think we should be wary of 
> this change.
> 
> ---
> bod

Oh, and what is the effect on Samsung and i.MX silicon interconnect 
providers of skipping the zero set ?

---
bod
