Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032DE6AA0B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjCCUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCCUq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:46:28 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E762C8A57
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:46:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s22so5166177lfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677876385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRrrrOctENJ0lt9tDk9GeKvNtvGiQOfbknvvZ5bHUUY=;
        b=SezE0ABPAMRQQDhG5lpAx+yFoS1tjl5fLGBNxFmJhZrJDD1oDMuI+jC/ajzUTtfdgq
         O8ez6MXb1ei2lFVzaYghlM+h29N5lRdsTD2wZZGYW/z5li2AePkhTMqc+M323pDGLUzE
         HkVGLDsXXoQM4vNLYk9t2fLV4F47jH8ZxK3IxLhRB33XxNdfKkr5NE2KrmD2jtFmY68Y
         ibvna+xXf6osN0T3irYGHoZ91e6yY2bN7npQGSyStMoOABbQLFNtbIM5Od6ryf3PigOt
         jJmH4p4FcotQ1yhaGQouGz933kk7RMFDLM90sHLlE3Zv8HAz1evxv08p5r7vyhGlDQII
         i2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677876385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRrrrOctENJ0lt9tDk9GeKvNtvGiQOfbknvvZ5bHUUY=;
        b=nKapHQEoEaYdX2CJsgFFNptw5TWPLFRwTiwQ9jAThBWlANozH6S2XHNa3d5/EwJ0+s
         syHK6dU0Y1YAY3lcFLInfOHicj4RBIaKNUxKtSeCQbSetcPqgbq+xYq9X/R2wNWrCu1V
         rDFEaPHBZIuBxYbDRUUypfKI3+xRfM/XgbncqhCOw6OZ0KRe81ztopSOfGv/YLDUuQup
         Dkoc+90hJG2UE7itxGC47wsqAgEkWBCMfq46A4MZbTmeaxEjAVMUfHBh2Gf8Jcj7mhGW
         vwSCZG4tIAPDSP14qKl1pfn7rNL/+UGuXuBXBAbPj4T0FBa9PDZHo3KqwUr6xZZh4u++
         knkg==
X-Gm-Message-State: AO0yUKUYMCMXhNUvvmKKGiQi/3wdR1PO/usVs5f09OTIrTGXG3dlvhVT
        tkOdklIFSYgUObfpIxlR2Vup/Q==
X-Google-Smtp-Source: AK7set/QcaJ6OpTXM8OfQPl9HEMQXQ+LMjPG7w1tPxByoIzx/jFGhDFH4TMbPIUV1tVxI6TYyUrOaw==
X-Received: by 2002:ac2:5dcf:0:b0:4e0:2455:3ade with SMTP id x15-20020ac25dcf000000b004e024553ademr967637lfq.60.1677876385151;
        Fri, 03 Mar 2023 12:46:25 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h8-20020ac25968000000b004dc48d91061sm526214lfp.304.2023.03.03.12.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:46:24 -0800 (PST)
Message-ID: <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
Date:   Fri, 3 Mar 2023 21:46:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
To:     Robert Marko <robimarko@gmail.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
 <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
 <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org>
 <CAOX2RU6vociXPTQE4tegQE8YXjHgQAHgdQWm3N9PPekgaw3ung@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOX2RU6vociXPTQE4tegQE8YXjHgQAHgdQWm3N9PPekgaw3ung@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.03.2023 19:38, Robert Marko wrote:
> On Sat, 18 Feb 2023 at 21:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 18.02.2023 21:36, Dmitry Baryshkov wrote:
>>> On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 21.01.2023 12:29, Robert Marko wrote:
>>>>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
>>>>> after getting it via SMEM call but instead uses an enum to encode the
>>>>> matched SMEM ID to 2 variants of MSM8996 which are then used in
>>>>> qcom_cpufreq_kryo_name_version() to set the supported version.
>>>>>
>>>>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
>>>>> more than its name suggests, so lets make it just return the SoC ID
>>>>> directly which allows matching directly on the SoC ID and removes the need
>>>>> for msm8996_version enum which simplifies the driver.
>>>>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
>>>>>
>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>> ---
>>>>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>>>>>  1 file changed, 12 insertions(+), 32 deletions(-)
>>>>>
>>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>> index da55d2e1925a..9deaf9521d6d 100644
>>>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>> @@ -32,12 +32,6 @@
>>>>>
>>>>>  #include <dt-bindings/arm/qcom,ids.h>
>>>>>
>>>>> -enum _msm8996_version {
>>>>> -     MSM8996_V3,
>>>>> -     MSM8996_SG,
>>>>> -     NUM_OF_MSM8996_VERSIONS,
>>>>> -};
>>>>> -
>>>>>  struct qcom_cpufreq_drv;
>>>>>
>>>>>  struct qcom_cpufreq_match_data {
>>>>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>>>>>       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>>>>>  }
>>>>>
>>>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>>>>> +static int qcom_cpufreq_get_msm_id(void)
>>>> This should be u32 as info->id is __le32
> 
> Nice catch.
> 
> 
>>>>
>>>> And please export this function from socinfo, it'll come in
>>>> useful for other drivers!
> 
> I intentionally did not do that as socinfo is currently fully optional
> and I dont really like
> the idea of making it required for anything using SMEM.
"anything using SMEM"? As in the drivers, or SoCs?
If the former, I don't see how exporting a function from within
socid and using it here would make it required for other drivers.
If the latter, we're talking non-qcom SoCs. SMEM has been with
us forever.


I'm planning to reuse this for Adreno speedbin matching. It's one
of those blocks that don't have a revision and/or bin reigster
within themselves.

Konrad
> 
> Regards,
> Robert
> 
>>
>> Konrad
>>>
