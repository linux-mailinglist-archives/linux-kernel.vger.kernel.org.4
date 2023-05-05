Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208FF6F895B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjEETOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjEETN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:13:57 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBA11A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:13:55 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac7462d9f1so24902491fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 12:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683314034; x=1685906034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1uiHv6Rjx9RmhAtMOeCupnfCeV+0+9ZAJ8QhFdnnhsM=;
        b=gdfZG3IOhspBJ3Y2UgRJHChE2z7GPBjPW+I4nyJTpxqWCuJoNQzf7eCDVz2YqxCGqc
         bY2WoZxIUvbnoLjW2p5xT7Y4bNPPrjDOt1ZUOIvDYoVujg67N1aeQlGFjPyrdc25GrWD
         cj/fCRK9rByHprvBdvM9ca6y/8BGyz4tOC6QBwMkJ6HfQOUApqMclDyRJUbXYjDDkqP7
         2Cd3jLqquJ8dTVGPJxVeVtfo5nNwPHBqeA2oH3/CUQ7jCYGykFeSEZyOg/Tzr3oP5eDy
         IhJMIZlqzL+c2moTPkLfNi8Ia57FcA2VgiQwtk6Gi+wCCjz9NZbFhxQI1GyBPUA0t32B
         WUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314034; x=1685906034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uiHv6Rjx9RmhAtMOeCupnfCeV+0+9ZAJ8QhFdnnhsM=;
        b=aPTH9JFnOwRWschR0sYtV0CuBFGVAlDuuXpJ7DTwLLw77Lrax1eWy7CCdXxcnFinG/
         BIpBQeJm2s9mG7dXWgJE0RkIMgEB93yDnZJ9Q75Z/PAq1q48S238lKV5D8oYpDnMH59R
         KV+oGLQBaNZaOH/dHg96zbQ9aGrxrqBFCmkachCIm/g3+7fo1RHdxJxayx0Wj7br2odf
         n2alQlMDFtc1nsA10cQn0JVwynYThIA5zg2t/8iWC0co1OFSQqdz3RuXutMiJEPqEFAU
         aNtUXbK2EigJwvpyJIazQpSqHEPdj5AjnoFPzLcJn1BX8edq7ZTRg0YdoWOVsxmRnVjE
         ZTGw==
X-Gm-Message-State: AC+VfDxMi1otn/K9SC17qQ7oeye+UduI+nW9mibhW+VOcocoVN4IrGnQ
        RNlnqzOa/0B3xYCA4JucXHaVJg==
X-Google-Smtp-Source: ACHHUZ4n6UfwT8Y1sd5n1OOKml66UbhNAGyQeO8/d75kprGdH26iUhSYRF0awpPYBCFTxZLP1LS+WA==
X-Received: by 2002:a2e:9e0f:0:b0:2a8:b37c:17f0 with SMTP id e15-20020a2e9e0f000000b002a8b37c17f0mr781950ljk.4.1683314034080;
        Fri, 05 May 2023 12:13:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id r28-20020ac252bc000000b004eb00c0d417sm380395lfm.130.2023.05.05.12.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 12:13:53 -0700 (PDT)
Message-ID: <83e70f8b-0b90-c840-f669-1d5376be0f21@linaro.org>
Date:   Fri, 5 May 2023 21:13:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 10/18] media: venus: hfi_venus: Fix version checks in
 venus_isr()
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v2-0-d95d14949c79@linaro.org>
 <20230228-topic-venus-v2-10-d95d14949c79@linaro.org>
 <0e517661-a8eb-d30e-8fe4-bf929ab40ee1@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <0e517661-a8eb-d30e-8fe4-bf929ab40ee1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5.05.2023 15:29, Vikash Garodia wrote:
> 
> On 5/4/2023 1:31 PM, Konrad Dybcio wrote:
>> IS_V6 was used there IS_IRIS2(_1) should have been and the !IS_V6
>> condition was only correct by luck and for now. Replace them both
>> with VPU version checks.
> 
> Existing video driver supports IRIS2(_1) under V6 category. What is meant by
> 
> !IS_V6 condition was correct by luck ?
Right, I didn't quite think of it this way. I probably meant "it works
just because there are no other HFIv6 cores supported", but that might
have just as well been a design choice. I'll reword and drop fixes.

Konrad
> 
> -Vikash
> 
>> Fixes: 24fcc0522d87 ("media: venus: hfi: Add 6xx interrupt support")
>> Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index ca56b1a8eb71..6d5906fab800 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -1130,7 +1130,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
>>       wrapper_base = hdev->core->wrapper_base;
>>         status = readl(wrapper_base + WRAPPER_INTR_STATUS);
>> -    if (IS_V6(core)) {
>> +    if (IS_IRIS2(core) || IS_IRIS2_1(core)) {
>>           if (status & WRAPPER_INTR_STATUS_A2H_MASK ||
>>               status & WRAPPER_INTR_STATUS_A2HWD_MASK_V6 ||
>>               status & CPU_CS_SCIACMDARG0_INIT_IDLE_MSG_MASK)
>> @@ -1142,7 +1142,7 @@ static irqreturn_t venus_isr(struct venus_core *core)
>>               hdev->irq_status = status;
>>       }
>>       writel(1, cpu_cs_base + CPU_CS_A2HSOFTINTCLR);
>> -    if (!IS_V6(core))
>> +    if (!(IS_AR50_LITE(core) || IS_IRIS2(core) || IS_IRIS2_1(core)))
>>           writel(status, wrapper_base + WRAPPER_INTR_CLEAR);
>>         return IRQ_WAKE_THREAD;
>>
