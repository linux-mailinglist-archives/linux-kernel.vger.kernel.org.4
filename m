Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110B06A80C3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCBLKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCBLKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:10:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0B74393A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 03:10:09 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s22so21600860lfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 03:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677755407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jLx9avxHWMFo9m8Cakwwu6IFkI8mC4mkh3EVnergYg4=;
        b=dZw7muzgxk8EM4xDFHV4hoezFshmjMP5rFI6qRXc+B5qVko8we6VCj+px00AUcMGRw
         NiKXc2z7me/7c5wkpxtxfN+U7CywK4IcKGv4bFdQARcqMbsqlTOuKV0oDJEuu3OYbPiz
         OvkT9zATPyx0aPMiJ7XGQUroVX2VJk5XHLD+gOZ9RNSa/Uu8MA9tvC+G8Zq0FlSaFTde
         ATy/wgmmbJy+uLSCy4U/LHB2Caht4Sj1G3C2DOku4Tw16kQBOp7EyffZDnFvm+nplcq2
         Bd8X62Lskv3Jk69nIcMmx7LMS/xpL/NL/V05FlC4F2lxipa5SW7HBjzn9d3RuAHWWNF/
         d9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677755407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLx9avxHWMFo9m8Cakwwu6IFkI8mC4mkh3EVnergYg4=;
        b=q1Qvw+xHp2iw7wele540ldhSHJutepZQG0ri32uV1OJimWqZJWTGnQ9ZLR/Z/s7QT4
         OXBPTRABq0Wko+sXwrI2Uk2BPml1fsHDMIXi56SDxTYzD5Ni0xqESGTqK6U9CIQ9OyAS
         w+zHNkWPq2brg3gtzh8rjgBblmtnLo4dhNGwV2o71a53Fqtf0G4lA21ve2n/eH9dbf5+
         QkwxW9KKS54mwlQ9y3pFlu1f4te741RzamFyolm92Q60OWNVI4ql0yx2Ey2jUD2SqUfj
         mXfS6lGRco0PY8y5EXbbSSwXvuqT5Rj74BTm0U0HlJTQkFqQ/a5R0nWyUqnWTFVj6xgK
         Yd5w==
X-Gm-Message-State: AO0yUKWohRyxK7lXNK8IzOrbnmObGrHPfoJ4dpzzyrzlOaJr3tGEqGfV
        FskM9hdvJzDqebESSESYLVqGqg==
X-Google-Smtp-Source: AK7set8pREw9qmKUJyVQ4OQ6gBffpOoMg0smm5pEVnZ+i57S3X8MyumqQvPvO9DYd09iNVvK2NHkaQ==
X-Received: by 2002:ac2:4c25:0:b0:4a4:68b7:deab with SMTP id u5-20020ac24c25000000b004a468b7deabmr420289lfq.7.1677755407399;
        Thu, 02 Mar 2023 03:10:07 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id q20-20020ac24a74000000b004d5a6dcb94fsm2097650lfp.33.2023.03.02.03.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:10:07 -0800 (PST)
Message-ID: <5f23ddc7-1bbf-320b-cb5a-9b1bfde3dfff@linaro.org>
Date:   Thu, 2 Mar 2023 12:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/18] media: venus: hfi_venus: Sanitize venus_boot_core()
 per-VPU-version
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
 <20230228-topic-venus-v1-5-58c2c88384e9@linaro.org>
 <769b4971-aed8-ce6a-b77a-29660957ec38@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <769b4971-aed8-ce6a-b77a-29660957ec38@quicinc.com>
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



On 2.03.2023 12:00, Dikshita Agarwal wrote:
> 
> On 2/28/2023 8:54 PM, Konrad Dybcio wrote:
>> The current assumption of IS_V6 is overgeneralized. Adjust the logic
>> to take the VPU hardware version into account.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_venus.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 4ccf31147c2a..772e5e9cf127 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -448,20 +448,21 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>   {
>>       struct device *dev = hdev->core->dev;
>>       static const unsigned int max_tries = 100;
>> -    u32 ctrl_status = 0, mask_val;
>> +    u32 ctrl_status = 0, mask_val = 0;
>>       unsigned int count = 0;
>>       void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>>       void __iomem *wrapper_base = hdev->core->wrapper_base;
>>       int ret = 0;
>>         writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>> -    if (IS_V6(hdev->core)) {
>> +    if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
> 
> I think the IRIS1 check can be removed from here as we are not handling IRIS1 related things at other places.
> 
> we can add the required checks for IRIS1 when we add support for any IRIS1 based chipset.
Up to you really, I plan on getting IRIS1 (SM8150) supported and have
some mumbling going on for that on my local branch. FWIW these checks
are logically correct and I would personally prefer not to have to go
through each one of them and remove them just to bring them back soon.

Konrad
> 
> Thanks,
> 
> Dikshita
> 
>>           mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>>           mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
>>                     WRAPPER_INTR_MASK_A2HCPU_MASK);
>>       } else {
>>           mask_val = WRAPPER_INTR_MASK_A2HVCODEC_MASK;
>>       }
>> +
>>       writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>>       writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>>   @@ -480,10 +481,11 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>>       if (count >= max_tries)
>>           ret = -ETIMEDOUT;
>>   -    if (IS_V6(hdev->core)) {
>> +    if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>>           writel(0x1, cpu_cs_base + CPU_CS_H2XSOFTINTEN_V6);
>> +
>> +    if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>>           writel(0x0, cpu_cs_base + CPU_CS_X2RPMH_V6);
>> -    }
>>         return ret;
>>   }
>>
