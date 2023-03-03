Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621886AA18D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjCCVkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCCVkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:40:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905B62D8C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:40:49 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id r27so5313503lfe.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677879647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpIHZbqG4jOKBXQdLzNeYd9B0dvVAyQI3ZBvRIsc4hI=;
        b=ILL5my5lotlLpiq3EsEofQkisb/KeI2bI4YzQsZWffWvYqVS33LQXzQ87AmFuaB5t9
         In3Cdou4p+fabvzkmUkr1W0adtJatUJL8i8wh/PtnkGKyQnFDRiZWHI4lrlLzZhYjqS3
         KcL3SICclI6NLBp3/FCcg3YfDx8AAC/XIs49Wj73vaHvmgmsBvGuWfngbq9d7Ytd89+6
         M2VqD8KcnY1DsSwNQ4dVyBNy3pTuHxLSITLMjqSC4vbOSl/wS4k/yLoNftAYOEyaVlJM
         Gn0gFSo72NJqBUIc3/ATmKNwFZqi38/zVSalcjUzWyUTU8y2HECfjV7HKQBFtQrm9D3y
         lahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpIHZbqG4jOKBXQdLzNeYd9B0dvVAyQI3ZBvRIsc4hI=;
        b=3i1wv1ehhCWvv6Z7zx6V437X0E3v5MOAxxE2aZeMqJjY4LnFO+1GrM5He3AG+b3usE
         RCK8XZVDskvbqqBJbC6XACXVp1EVKg5jP4BXCRfj3j3t1tdrHKXyUpavus35VkXGuNV2
         CnamZOgOowOEA/0k9pNuEGrbz9CM5oc720jVBEUn7AGov+0giFQJH/QLnnIogj4D1EKK
         rtMO+w3o62aTeEoivcVaL7R84WQmofstWTXH+omT5ug6/fRmuyZrsR63oNNYZRCZaVIZ
         sJBQ8TmtSETVMQ6E3lfhHHgdXyQll+ooosnZyKM7NZjMNsew8dPWw7Nz6/k9eB87VdTM
         2HrQ==
X-Gm-Message-State: AO0yUKX25/xzB2AW2cPecXp48hn1YxrXTEXInkbMqsJqTSherrOCr4is
        JSAofWb1/JnsB/jPcNgJOMbnKeS6AOIa/J7uy/k=
X-Google-Smtp-Source: AK7set97JTTQCERdif8O22w1VHod9R3dHPKl/oTh+vyC+6i2IrX76Z+HQs5n+c2DhCn8OHTc4bv/qg==
X-Received: by 2002:ac2:53ac:0:b0:4dd:a772:8d24 with SMTP id j12-20020ac253ac000000b004dda7728d24mr859637lfh.32.1677879647628;
        Fri, 03 Mar 2023 13:40:47 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id a6-20020a056512020600b004bb766e01a4sm543005lfo.245.2023.03.03.13.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 13:40:47 -0800 (PST)
Message-ID: <e8abb887-821e-0a00-569a-1c00ca6ce758@linaro.org>
Date:   Fri, 3 Mar 2023 22:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
Content-Language: en-US
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
 <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
 <CAOX2RU7GBuDc-uh_EKmXZu57GvRzfwzwESqgts2tUDbDoik-JA@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOX2RU7GBuDc-uh_EKmXZu57GvRzfwzwESqgts2tUDbDoik-JA@mail.gmail.com>
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



On 3.03.2023 22:38, Robert Marko wrote:
> On Fri, 3 Mar 2023 at 21:46, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 3.03.2023 19:38, Robert Marko wrote:
>>> On Sat, 18 Feb 2023 at 21:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 18.02.2023 21:36, Dmitry Baryshkov wrote:
>>>>> On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 21.01.2023 12:29, Robert Marko wrote:
>>>>>>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
>>>>>>> after getting it via SMEM call but instead uses an enum to encode the
>>>>>>> matched SMEM ID to 2 variants of MSM8996 which are then used in
>>>>>>> qcom_cpufreq_kryo_name_version() to set the supported version.
>>>>>>>
>>>>>>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
>>>>>>> more than its name suggests, so lets make it just return the SoC ID
>>>>>>> directly which allows matching directly on the SoC ID and removes the need
>>>>>>> for msm8996_version enum which simplifies the driver.
>>>>>>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
>>>>>>>
>>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>>>> ---
>>>>>>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>>>>>>>  1 file changed, 12 insertions(+), 32 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>>> index da55d2e1925a..9deaf9521d6d 100644
>>>>>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>>> @@ -32,12 +32,6 @@
>>>>>>>
>>>>>>>  #include <dt-bindings/arm/qcom,ids.h>
>>>>>>>
>>>>>>> -enum _msm8996_version {
>>>>>>> -     MSM8996_V3,
>>>>>>> -     MSM8996_SG,
>>>>>>> -     NUM_OF_MSM8996_VERSIONS,
>>>>>>> -};
>>>>>>> -
>>>>>>>  struct qcom_cpufreq_drv;
>>>>>>>
>>>>>>>  struct qcom_cpufreq_match_data {
>>>>>>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>>>>>>>       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>>>>>>>  }
>>>>>>>
>>>>>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>>>>>>> +static int qcom_cpufreq_get_msm_id(void)
>>>>>> This should be u32 as info->id is __le32
>>>
>>> Nice catch.
>>>
>>>
>>>>>>
>>>>>> And please export this function from socinfo, it'll come in
>>>>>> useful for other drivers!
>>>
>>> I intentionally did not do that as socinfo is currently fully optional
>>> and I dont really like
>>> the idea of making it required for anything using SMEM.
>> "anything using SMEM"? As in the drivers, or SoCs?
>> If the former, I don't see how exporting a function from within
>> socid and using it here would make it required for other drivers.
>> If the latter, we're talking non-qcom SoCs. SMEM has been with
>> us forever.
> 
> I feel we have a misunderstanding,
> currently, cpufreq-nvmem does not depend on socinfo being built
> so I don't want to require it as a dependency in order to get the SMEM ID.
Okay yeah we simply weren't on the same page.

> 
> Granted, socinfo is useful on any QCA SoC so if adding new dependecies to
> cpufreq-nvmem is acceptable I am not against exporting it there.
IMO, it would be acceptable. Let's hear if others are on board too.

Konrad
>>
>>
>> I'm planning to reuse this for Adreno speedbin matching. It's one
>> of those blocks that don't have a revision and/or bin reigster
>> within themselves.
> 
> I understand the use case, I am sure it will be required in some other places
> sooner or later as well.
> 
> Regards,
> Robert
>>
>> Konrad
>>>
>>> Regards,
>>> Robert
>>>
>>>>
>>>> Konrad
>>>>>
