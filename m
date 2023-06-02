Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1364F71FCDA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjFBI6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbjFBI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:57:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B610DB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 01:57:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f4f8b94c06so2418467e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685696251; x=1688288251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eaozavS8Dw9G07q3WIthaz1oxPUnWkRUgVfQ/uWKK+o=;
        b=k+L76lILkvNpMK5eJwtttR1ZvSPzVJjxvKM2Uf6nqssGPPfOz3NLOtmL75ANFbc53R
         DlX2NzD2i1CraPX/uYoKH6qnECz9eU1Z8pbQhl6DBpA6YRZuSzQh/YKaqfPYRQwiKI6P
         SE6S4mV6cOWjRibdDHXVhVTadG0O4BmMZ5pr9ir9Fvh260aUzngk9xM6Ao60QAD0Ej6r
         mhiJds4K3j/QaeW+CRqGZX60SsXq1nIN/hcGjwv/UpwyiM9iIr7h5Ym3uBq2VcBal+F7
         nXMpo9rrWgMsMW6AytdRAMQYqXcWtGgd59xS5K/CA0EbgepAo5GyAp8YPgKbzo2TP8Fn
         p2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685696251; x=1688288251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaozavS8Dw9G07q3WIthaz1oxPUnWkRUgVfQ/uWKK+o=;
        b=gAYT8sdo8/P5r46NJ+KnIzIDrNKo3dd3QreE6CDCM8Z8X2pufEqkwRXp21awUxif78
         aOcydwQjx0/QmUM5H+rC5eyH7lucwtZWYhN6VrbVs5JSg/GpnuAr9OwN6t1XIyttPjOA
         snCkJVKR+bX1fYZzMXprzueJEb2Obj4ASSxylSaoZerROsB0MzinqOg5si542/bs1JVp
         KODS6YL0Va8xqQiFRamDWMHN/Jo99Bc7gvnaNZ6iuzjnJXd6M8Gs/dUlYeRJi5syfykr
         35lQuuTxPMd7hyGMb/PYRd0+c4pN4bS0HNc67jzbxBpn/IsCPjo9hCZwvAIWHAq9DYQi
         oldw==
X-Gm-Message-State: AC+VfDxm5g0QofPQXE9qwGBjGhC5cR6WPfOKchBsdebcfn71dBq+p04U
        CmrqsCXxn+kMNTlXTY6KJ7w/xA==
X-Google-Smtp-Source: ACHHUZ5eY5OrhtEFe+ABmF8b5ll+9yOH8otZRhdWVPdyaCx97VYsne4VKioFkB97qFTdvzfJMaOylQ==
X-Received: by 2002:ac2:4246:0:b0:4f4:d538:3450 with SMTP id m6-20020ac24246000000b004f4d5383450mr1182657lfl.49.1685696251372;
        Fri, 02 Jun 2023 01:57:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id w13-20020a05651203cd00b004ef11b30a17sm94809lfp.91.2023.06.02.01.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 01:57:30 -0700 (PDT)
Message-ID: <5ab92f01-720d-1a27-3ab5-1af1d63bd139@linaro.org>
Date:   Fri, 2 Jun 2023 10:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for
 IPQ8074
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ansuelsmth@gmail.com
References: <20230530165807.642084-1-robimarko@gmail.com>
 <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
 <CAOX2RU6ay_Bc0JYQ6rBcTRadm-71Jie5YH9B0J_1UywkcyqZ8g@mail.gmail.com>
 <70de3314-766d-4c7f-5b1a-41740cfeac8c@quicinc.com>
 <2a78c9ce-f631-53fd-581f-2e8c906be989@quicinc.com>
 <CAOX2RU4k4bDvtU8m4cxA=9x6b2B0mwiKsBWXFV3TY+jvk49vwg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAOX2RU4k4bDvtU8m4cxA=9x6b2B0mwiKsBWXFV3TY+jvk49vwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 16:55, Robert Marko wrote:
> On Thu, 1 Jun 2023 at 16:49, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>>
>>
>> On 6/1/2023 6:54 PM, Kathiravan T wrote:
>>>
>>> On 6/1/2023 6:40 PM, Robert Marko wrote:
>>>> On Thu, 1 Jun 2023 at 14:57, Kathiravan T <quic_kathirav@quicinc.com>
>>>> wrote:
>>>>>
>>>>> On 5/30/2023 10:28 PM, Robert Marko wrote:
>>>>>> IPQ8074 comes in 2 families:
>>>>>> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
>>>>>> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
>>>>>>
>>>>>> So, in order to be able to share one OPP table lets add support for
>>>>>> IPQ8074
>>>>>> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
>>>>>>
>>>>>> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq
>>>>>> device
>>>>>> will get created by NVMEM CPUFreq driver.
>>>>>>
>>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>>>>> ---
>>>>>> Changes in v2:
>>>>>> * Print an error if SMEM ID is not part of the IPQ8074 family
>>>>>> and restrict the speed to Acorn variant (1.4GHz)
>>>>>> ---
>>>>>>    drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>>>>>>    drivers/cpufreq/qcom-cpufreq-nvmem.c | 43
>>>>>> ++++++++++++++++++++++++++++
>>>>>>    2 files changed, 44 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
>>>>>> b/drivers/cpufreq/cpufreq-dt-platdev.c
>>>>>> index ea86c9f3ed7a..78f6ff933f93 100644
>>>>>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>>>>>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>>>>>> @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[]
>>>>>> __initconst = {
>>>>>>        { .compatible = "ti,am62a7", },
>>>>>>
>>>>>>        { .compatible = "qcom,ipq8064", },
>>>>>> +     { .compatible = "qcom,ipq8074", },
>>>>>>        { .compatible = "qcom,apq8064", },
>>>>>>        { .compatible = "qcom,msm8974", },
>>>>>>        { .compatible = "qcom,msm8960", },
>>>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> index a88b6fe5db50..ce444b5962f2 100644
>>>>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>>>>> @@ -31,6 +31,9 @@
>>>>>>
>>>>>>    #include <dt-bindings/arm/qcom,ids.h>
>>>>>>
>>>>>> +#define IPQ8074_HAWKEYE_VERSION              BIT(0)
>>>>>> +#define IPQ8074_ACORN_VERSION                BIT(1)
>>>>>> +
>>>>>>    struct qcom_cpufreq_drv;
>>>>>>
>>>>>>    struct qcom_cpufreq_match_data {
>>>>>> @@ -204,6 +207,41 @@ static int
>>>>>> qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>>>>>        return ret;
>>>>>>    }
>>>>>>
>>>>>> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>>>>>> +                                          struct nvmem_cell
>>>>>> *speedbin_nvmem,
>>>>>> +                                          char **pvs_name,
>>>>>> +                                          struct qcom_cpufreq_drv
>>>>>> *drv)
>>>>>
>>>>> Most of the IPQ SoCs also supports the fuse based frequency selection.
>>>>> Can we rename the function name to generic so that all the IPQ chips
>>>>> can
>>>>> use the same function?
>>>> Well, the only speedbin fuse I was able to dig from downstream is the
>>>> one from
>>>> CPR driver and that one is 0 on all devices so it's not helpful.
>>>> Do you maybe know if there is one in the IPQ8074 family?
>>>
>>>
>>> Let me check on this and get back to you probably by tomorrow...
>>
>>
>> Robert, checked with the team and IPQ807x doesn't use fuse to determine
>> the CPU freq limits. Current approach (SoC ID based) should be fine.
>> BTW, are the DTS changes already posted or yet to be posted?
> 
> Thanks for checking,
> DTS changes are not posted as CPR support is required in order for scaling to
> properly work, otherwise, all I could do is try and guess some safe voltages.
> There was an effort to get CPR upstreamed, but I think that stalled out for now.
As much as I don't like it, yes it's stalled.. I have to get some bigger
fish out of my queue first.

Konrad
> 
> Regards,
> Robert
>>
>>
>>>
>>>
>>>>
>>>> Function is not supposed to be shared between SoC-s, so I dont see a
>>>> point in it
>>>> having a generic name cause for example IPQ6018 has a working fuse
>>>> and its logic
>>>> is completely different for setting the versioning than IPQ8074, I
>>>> dont think having a
>>>> catch-all would work here.
>>>
>>>
>>> Makes sense, thanks Robert and Konrad.
>>>
>>>
>>>>
>>>>>
>>>>>> +{
>>>>>> +     u32 msm_id;
>>>>>
>>>>> soc_id please...?
>>>> Sure, that is more suitable.
>>>>
>>>> Regards,
>>>> Robert
>>>>>
>>>>>> +     int ret;
>>>>>> +     *pvs_name = NULL;
>>>>>> +
>>>>>> +     ret = qcom_smem_get_soc_id(&msm_id);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     switch (msm_id) {
>>>>>> +     case QCOM_ID_IPQ8070A:
>>>>>> +     case QCOM_ID_IPQ8071A:
>>>>>> +             drv->versions = IPQ8074_ACORN_VERSION;
>>>>>> +             break;
>>>>>> +     case QCOM_ID_IPQ8072A:
>>>>>> +     case QCOM_ID_IPQ8074A:
>>>>>> +     case QCOM_ID_IPQ8076A:
>>>>>> +     case QCOM_ID_IPQ8078A:
>>>>>> +             drv->versions = IPQ8074_HAWKEYE_VERSION;
>>>>>> +             break;
>>>>>> +     default:
>>>>>> +             dev_err(cpu_dev,
>>>>>> +                     "SoC ID %u is not part of IPQ8074 family,
>>>>>> limiting to 1.4GHz!\n",
>>>>>> +                     msm_id);
>>>>>> +             drv->versions = IPQ8074_ACORN_VERSION;
>>>>>> +             break;
>>>>>> +     }
>>>>>> +
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>>    static const struct qcom_cpufreq_match_data match_data_kryo = {
>>>>>>        .get_version = qcom_cpufreq_kryo_name_version,
>>>>>>    };
>>>>>> @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data
>>>>>> match_data_qcs404 = {
>>>>>>        .genpd_names = qcs404_genpd_names,
>>>>>>    };
>>>>>>
>>>>>> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>>>>>> +     .get_version = qcom_cpufreq_ipq8074_name_version,
>>>>>> +};
>>>>>> +
>>>>>>    static int qcom_cpufreq_probe(struct platform_device *pdev)
>>>>>>    {
>>>>>>        struct qcom_cpufreq_drv *drv;
>>>>>> @@ -363,6 +405,7 @@ static const struct of_device_id
>>>>>> qcom_cpufreq_match_list[] __initconst = {
>>>>>>        { .compatible = "qcom,msm8996", .data = &match_data_kryo },
>>>>>>        { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>>>>>>        { .compatible = "qcom,ipq8064", .data = &match_data_krait },
>>>>>> +     { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>>>>>>        { .compatible = "qcom,apq8064", .data = &match_data_krait },
>>>>>>        { .compatible = "qcom,msm8974", .data = &match_data_krait },
>>>>>>        { .compatible = "qcom,msm8960", .data = &match_data_krait },
