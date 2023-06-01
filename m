Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F2E719CF6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjFANIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjFANIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:08:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9AD13E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 06:08:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4b0a0b557so984978e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 06:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685624894; x=1688216894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5IIBl0dvYa4DXOxyKvBLrHF+Hn/13dJzqu7UmnvgUvk=;
        b=S7sqv8ewF/+tzxN0VJ8w76lxBSH6NzqklCa3h278TYq7Ez/g/fWODcvi1/oUJZniw1
         Herw8zng9sct3W2vBrDvCfib3k95+JP95ZcXZiiXcrZQbROMtP1IIt2opxRXUDv/wwNZ
         YBMpg93xXLu6qaJ4cm435ZDYQXiyYv5sG+vqouBwQmKMGtHoW2qb/uKkBaPyT4x/gdNM
         vyw+oxK+tU4dgDKDbuhIZp9zirel8wVGPuHCcc6Qv1+bCKCTAnjkQsNWPTo11q1ayeff
         TkFI8eJ2gzDAXatQ+oopCzqRRVdFQJvCEwUqEPJMbT9Xr/NaQqHzSsyDlaABa8RlVTF1
         ANng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685624894; x=1688216894;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IIBl0dvYa4DXOxyKvBLrHF+Hn/13dJzqu7UmnvgUvk=;
        b=IYGCCZH/N+kdRjXCVvdoIqZPEus8Hct78Y40hDrws5gduaG8ZHoh2BD93o4JdX2QMb
         YWHUWjBewR/CeyGmMKGWz+3wZC3jHvmCi2Zjzrnx0cwVVmVtYQhyj3Iq2EQq4u0iJ/+I
         KOcLRATQC04XQ5IppYdIacfGeaUDfcO+RkjUX+YMm9xPpPyyQP7xg1rldovsBm0NBF32
         VkiRSAceK9AWpfrtui2lkxAhoC25sLwv5WqMozmiM4z848Q5GaPPrK9SvmcnyAyI9iF1
         3GvbJC63eLmrChf4iWHv8Exnx/W7rgGdpg2+YZDrBdNRpZLAp8ldbY0OC1bH0TFKYheR
         2mQw==
X-Gm-Message-State: AC+VfDyLhc+0epPHrltl/5w5teKmdXkV9KG25kIMB3z8HFdsI5L22J4+
        SIiA035eBMU4mECkmTXhUSESkA==
X-Google-Smtp-Source: ACHHUZ4MoPPF7vdClhBdM5pQxqQmcghl0Ido4hG6FsSZ2cDuYwlx+98yWJSj1q/VXia18+DfOcytRg==
X-Received: by 2002:ac2:4f90:0:b0:4f1:4504:2679 with SMTP id z16-20020ac24f90000000b004f145042679mr1526311lfs.41.1685624894001;
        Thu, 01 Jun 2023 06:08:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id c28-20020ac2531c000000b004f4b3e9e0cesm1073690lfh.297.2023.06.01.06.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:08:13 -0700 (PDT)
Message-ID: <5eb55596-4961-2cc0-e44f-c33c80db38ef@linaro.org>
Date:   Thu, 1 Jun 2023 15:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for
 IPQ8074
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230530165807.642084-1-robimarko@gmail.com>
 <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 14:55, Kathiravan T wrote:
> 
> On 5/30/2023 10:28 PM, Robert Marko wrote:
>> IPQ8074 comes in 2 families:
>> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
>> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
>>
>> So, in order to be able to share one OPP table lets add support for IPQ8074
>> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
>>
>> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
>> will get created by NVMEM CPUFreq driver.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>> Changes in v2:
>> * Print an error if SMEM ID is not part of the IPQ8074 family
>> and restrict the speed to Acorn variant (1.4GHz)
>> ---
>>   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
>>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 43 ++++++++++++++++++++++++++++
>>   2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
>> index ea86c9f3ed7a..78f6ff933f93 100644
>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[] __initconst = {
>>       { .compatible = "ti,am62a7", },
>>         { .compatible = "qcom,ipq8064", },
>> +    { .compatible = "qcom,ipq8074", },
>>       { .compatible = "qcom,apq8064", },
>>       { .compatible = "qcom,msm8974", },
>>       { .compatible = "qcom,msm8960", },
>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> index a88b6fe5db50..ce444b5962f2 100644
>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>> @@ -31,6 +31,9 @@
>>     #include <dt-bindings/arm/qcom,ids.h>
>>   +#define IPQ8074_HAWKEYE_VERSION        BIT(0)
>> +#define IPQ8074_ACORN_VERSION        BIT(1)
>> +
>>   struct qcom_cpufreq_drv;
>>     struct qcom_cpufreq_match_data {
>> @@ -204,6 +207,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>       return ret;
>>   }
>>   +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>> +                         struct nvmem_cell *speedbin_nvmem,
>> +                         char **pvs_name,
>> +                         struct qcom_cpufreq_drv *drv)
> 
> 
> Most of the IPQ SoCs also supports the fuse based frequency selection. Can we rename the function name to generic so that all the IPQ chips can use the same function?
This should stay SoC-specific as we can't really share the speedbin
bit vals reasonably, unless you do something like:

case QCOM_ID_FOO:
case QCOM_ID_BAR:
	drv->versions = SPEED_BIN_0; // BIT(0)
	break;
case QCOM_ID_BAZ:
	drv->versions = SPEED_BIN_1; // BIT(1)

Konrad
> 
> 
>> +{
>> +    u32 msm_id;
> 
> 
> soc_id please...?
> 
> 
>> +    int ret;
>> +    *pvs_name = NULL;
>> +
>> +    ret = qcom_smem_get_soc_id(&msm_id);
>> +    if (ret)
>> +        return ret;
>> +
>> +    switch (msm_id) {
>> +    case QCOM_ID_IPQ8070A:
>> +    case QCOM_ID_IPQ8071A:
>> +        drv->versions = IPQ8074_ACORN_VERSION;
>> +        break;
>> +    case QCOM_ID_IPQ8072A:
>> +    case QCOM_ID_IPQ8074A:
>> +    case QCOM_ID_IPQ8076A:
>> +    case QCOM_ID_IPQ8078A:
>> +        drv->versions = IPQ8074_HAWKEYE_VERSION;
>> +        break;
>> +    default:
>> +        dev_err(cpu_dev,
>> +            "SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
>> +            msm_id);
>> +        drv->versions = IPQ8074_ACORN_VERSION;
>> +        break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static const struct qcom_cpufreq_match_data match_data_kryo = {
>>       .get_version = qcom_cpufreq_kryo_name_version,
>>   };
>> @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>>       .genpd_names = qcs404_genpd_names,
>>   };
>>   +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>> +    .get_version = qcom_cpufreq_ipq8074_name_version,
>> +};
>> +
>>   static int qcom_cpufreq_probe(struct platform_device *pdev)
>>   {
>>       struct qcom_cpufreq_drv *drv;
>> @@ -363,6 +405,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>>       { .compatible = "qcom,msm8996", .data = &match_data_kryo },
>>       { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>>       { .compatible = "qcom,ipq8064", .data = &match_data_krait },
>> +    { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>>       { .compatible = "qcom,apq8064", .data = &match_data_krait },
>>       { .compatible = "qcom,msm8974", .data = &match_data_krait },
>>       { .compatible = "qcom,msm8960", .data = &match_data_krait },
