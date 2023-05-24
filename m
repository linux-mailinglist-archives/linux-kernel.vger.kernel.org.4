Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DE070FDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbjEXS1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 14:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjEXS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 14:27:09 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3A598
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:27:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af2db78b38so16199941fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 11:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684952826; x=1687544826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfKnZIxC0JL8VLQrcWzDaxmhfBN8ntq0FbYcgqoCQhc=;
        b=CF1PzLA2QoGZkxxXO74l+SIe9Dc15AdAkdOyw5EphMID+DJlECU3Pa2TnDHM229WY4
         E6O5d+1RSEnM94pf0w1LhcOgnQOR9rM5VEuTzqKtODerUnXpZLBygmfZfVP3Wwb1KnHw
         9gakozGT7CqyMm5DtBdp+axBPaaMDMVUNploEzqwK7jO6RGvvi+pVGZVd88JLmjEIFNj
         q9ws1at8E/Vzaquhg2Eq139aytsNENUmVMzjY8+Bul0so6asKF1aoGfyxPKgARe8yRhN
         THSSqW9DPpN5wit2iJoIzHg0ElyvEJpcY5wVHbPDzH1QYVlHiTRchcYaYCPw4PhDkgQS
         mV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684952826; x=1687544826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfKnZIxC0JL8VLQrcWzDaxmhfBN8ntq0FbYcgqoCQhc=;
        b=kO7WmT622Z5ugKTiJnw2bpTdsNSwBR7YPOmo5vr3t57f4DD14Tt+7MOTrcTD1b4iY1
         ccnyCj5Szh07M50fB6EqJzitBq7/d+QSsiT1w30oJPY19BnLregj5ODdmqH0VsUN9hEs
         qEkBYkdDXzGzLGaRcOwuV+IfyC2T9XVfgKCI+vwSINrqUHrBX4BldzbH28cWB/vbLRXo
         wTbWxemXgyij7oGYmF06AuSJaNwrFA+OgLZENAEc8UGv8c7gYVrJQxRh0yMDOWGXDiLd
         LkZcbu0/7+qffW1dHiHibj3hQ1iOIk69sFoB4ydnxaaKdaHoj28zLjrl+4IfeQPD06ga
         Jfjg==
X-Gm-Message-State: AC+VfDyrOofj64dAKbktZlKheiv26ouiLgFVkIP3BAwG6htM/YcrKeZx
        06RWYCgqkKHWU12/Nel4FtOozQ==
X-Google-Smtp-Source: ACHHUZ53s+1JYl6CEH3ubn0GSuqkpR8K2gcslO9ixtAuphFogsYm2SvEIOGtYxAddznY9XafHuL+QQ==
X-Received: by 2002:a2e:87ce:0:b0:2ad:9c36:d4aa with SMTP id v14-20020a2e87ce000000b002ad9c36d4aamr223186ljj.17.1684952826029;
        Wed, 24 May 2023 11:27:06 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id k23-20020a2e2417000000b002ab1536377fsm2088738ljk.105.2023.05.24.11.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 11:27:05 -0700 (PDT)
Message-ID: <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
Date:   Wed, 24 May 2023 20:27:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
To:     Trilok Soni <quic_tsoni@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-2-robimarko@gmail.com>
 <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
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



On 24.05.2023 20:16, Trilok Soni wrote:
> On 5/24/2023 9:23 AM, Robert Marko wrote:
>> Introduce a helper to return the SoC SMEM ID, which is used to identify the
>> exact SoC model as there may be differences in the same SoC family.
>>
>> Currently, cpufreq-nvmem does this completely in the driver and there has
>> been more interest expresed for other drivers to use this information so
>> lets expose a common helper to prevent redoing it in individual drivers
>> since this field is present on every SMEM table version.
>>
>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>> ---
>>   drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
>>   include/linux/soc/qcom/smem.h |  2 ++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
>> index 6be7ea93c78c..0d6ba9bce8cb 100644
>> --- a/drivers/soc/qcom/smem.c
>> +++ b/drivers/soc/qcom/smem.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/sizes.h>
>>   #include <linux/slab.h>
>>   #include <linux/soc/qcom/smem.h>
>> +#include <linux/soc/qcom/socinfo.h>
>>     /*
>>    * The Qualcomm shared memory system is a allocate only heap structure that
>> @@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>>   }
>>   EXPORT_SYMBOL(qcom_smem_virt_to_phys);
>>   +/**
>> + * qcom_smem_get_msm_id() - return the SoC ID
>> + *
>> + * Look up SoC ID from HW/SW build ID and return it.
>> + */
>> +int qcom_smem_get_msm_id(void)
On top of Trilok's point, this should return le32, or at least unsigned int.

Konrad
>> +{
>> +    size_t len;
>> +    struct socinfo *info;
>> +
>> +    info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>> +    if (IS_ERR(info))
>> +        return PTR_ERR(info);
>> +
>> +    return __le32_to_cpu(info->id);
>> +}
>> +EXPORT_SYMBOL(qcom_smem_get_msm_id);
> 
> EXPORT_SYMBOL_GPL please?
> 
> Please change it for other symbols in the driver as well w/ separate patch.
> 
> ---Trilok Soni
> 
> 
