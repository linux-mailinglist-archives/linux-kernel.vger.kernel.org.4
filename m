Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B66AA5E0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCCXxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCCXwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:52:54 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223681FC8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:52:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id ay14so12980234edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 15:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ds56s+08kdYvDMmH+33NMO0RlnG4QzULUhWsLzSvP4Q=;
        b=aT9YjIUpnXvrBXw15F7ekj0rJ1qxLOitv11dwxC+CTR2Np2hl4g+NviFNczwSDUbb3
         2PeAAOKONtU2ZzEW4x9EOCvPkGyDe5b7C9ibJQPXBJZvTs6cITfhLiPqoUFPBIX7AUxX
         LPWlXNpDebS7Y8cA/dEKg+bajpJWsyVX8i82XymLa6g8ohgpdyb/GCLsbojVOSbIFXi3
         ebGu6WEAnMYRLJh4UHMD5WAGfK2MJKP9wKkSU58iDkaSzSCHW78mEU0BGWqg+VU+i2u3
         qqtWU8VnJfNeCQRjADXYBHlIp2TmUUfKGK9k5QpHPgx7HwFhnN+KIM5ebtI+YSVMiio7
         9HrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ds56s+08kdYvDMmH+33NMO0RlnG4QzULUhWsLzSvP4Q=;
        b=xC8J9UmzEYCdt/rWHANntLehXMHJ5JzWtwTAz/Rd7Q9meG9PSeeom5NG9anJRnaJNb
         fj/Slifigt4qEEdigVI2SRdE5A2VgajeE4jW4ZLHoNvRoDYuIIHP2mARVFFvyqhkZJN9
         Lsb/b+dkqP5nDF5V1RxNAuwhkUd4SMYbaP01gykf+QqaR8rvH6Bg/pqD1z1gILI3GB/K
         oGyC/JintuumthUbZOyLDYxzSHr6ygaDHpFWPQaICY7HPjfm1/tr/jnDpfGGWq8fV7KO
         dncIGdvs5nRMh7IsITP+ZsAuhxg/O5uJDqDz/rTtDA3l5BCJ4DVe4qvfkHckWZu5EkGO
         KTZQ==
X-Gm-Message-State: AO0yUKV7CB3oZxOn2+r04YIRe5I4tBAFtBKqr3gcEeoz99ZlAvFJP3tm
        HfLqKOqFd5iEdgJny9ptylU32g==
X-Google-Smtp-Source: AK7set8Csku+IygSuZ94X43z6Yl9CT+uKiMOenYBeJySofzD5UzJFd3hGZHsrLwydnh1U+fiFp1coA==
X-Received: by 2002:a17:907:1905:b0:8a6:e075:e364 with SMTP id ll5-20020a170907190500b008a6e075e364mr3286199ejc.26.1677887569559;
        Fri, 03 Mar 2023 15:52:49 -0800 (PST)
Received: from [10.203.3.194] ([185.202.34.81])
        by smtp.gmail.com with ESMTPSA id ch10-20020a170906c2ca00b008cf8c6f5c43sm1454194ejb.83.2023.03.03.15.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 15:52:49 -0800 (PST)
Message-ID: <a9ae3a90-7712-54d1-fa8f-ca98b8c3093e@linaro.org>
Date:   Sat, 4 Mar 2023 01:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org>
 <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
 <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org>
 <CAOX2RU6vociXPTQE4tegQE8YXjHgQAHgdQWm3N9PPekgaw3ung@mail.gmail.com>
 <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2023 22:46, Konrad Dybcio wrote:
> 
> 
> On 3.03.2023 19:38, Robert Marko wrote:
>> On Sat, 18 Feb 2023 at 21:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>
>>>
>>>
>>> On 18.02.2023 21:36, Dmitry Baryshkov wrote:
>>>> On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 21.01.2023 12:29, Robert Marko wrote:
>>>>>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
>>>>>> after getting it via SMEM call but instead uses an enum to encode the
>>>>>> matched SMEM ID to 2 variants of MSM8996 which are then used in
>>>>>> qcom_cpufreq_kryo_name_version() to set the supported version.
>>>>>>
>>>>>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
>>>>>> more than its name suggests, so lets make it just return the SoC ID
>>>>>> directly which allows matching directly on the SoC ID and removes the need
>>>>>> for msm8996_version enum which simplifies the driver.
>>>>>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
>>>>>>
>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>>> ---
>>>>>>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>>>>>>   1 file changed, 12 insertions(+), 32 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> index da55d2e1925a..9deaf9521d6d 100644
>>>>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> @@ -32,12 +32,6 @@
>>>>>>
>>>>>>   #include <dt-bindings/arm/qcom,ids.h>
>>>>>>
>>>>>> -enum _msm8996_version {
>>>>>> -     MSM8996_V3,
>>>>>> -     MSM8996_SG,
>>>>>> -     NUM_OF_MSM8996_VERSIONS,
>>>>>> -};
>>>>>> -
>>>>>>   struct qcom_cpufreq_drv;
>>>>>>
>>>>>>   struct qcom_cpufreq_match_data {
>>>>>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>>>>>>        dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>>>>>>   }
>>>>>>
>>>>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>>>>>> +static int qcom_cpufreq_get_msm_id(void)
>>>>> This should be u32 as info->id is __le32
>>
>> Nice catch.
>>
>>
>>>>>
>>>>> And please export this function from socinfo, it'll come in
>>>>> useful for other drivers!
>>
>> I intentionally did not do that as socinfo is currently fully optional
>> and I dont really like
>> the idea of making it required for anything using SMEM.
> "anything using SMEM"? As in the drivers, or SoCs?
> If the former, I don't see how exporting a function from within
> socid and using it here would make it required for other drivers.
> If the latter, we're talking non-qcom SoCs. SMEM has been with
> us forever.
> 
> 
> I'm planning to reuse this for Adreno speedbin matching. It's one
> of those blocks that don't have a revision and/or bin reigster
> within themselves.

I have mixed feelings towards this. And anyway it might be better to add 
get_msm_id() function to SCM driver, rather than parsing the data here.


-- 
With best wishes
Dmitry

