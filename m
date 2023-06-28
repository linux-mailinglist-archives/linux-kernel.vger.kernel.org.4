Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1F8740FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjF1LNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1LNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:13:37 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48071AA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:13:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b5e7dba43cso62182961fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950813; x=1690542813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mxUjDgbY/jNz54AC4sl2RIErcdWqb2mUuJILzEKOlqM=;
        b=oaZ8tyOpIUvX+cCLzgWdNoY8qftM92bZWnYXHa1SrK1QcQPPtAxjE4Sc7rnvK6yo5E
         jFxzIDIPHv1HMLWARS/EKHXuxZ9f68yYnLRJDWTHzN5NpL4IVaLRwAMDZUFahEw9yNBB
         EWOP7DSP9oo5THMy3XEr08CZ+YzzpleUdQtab5olUQClRuBtSh7ZoTxbcfLjuYG//vYO
         73p49yKQ52BpY3azzO+z4MqRj4kmOVgaT/TV1auN55Gf01WwYad489xm+1Jgih7tx2ko
         S+Oc+Qi2zgCMmNQOpQxYjjZdb5XIejDQ7sGOQ0/mEA7peRKHrJlaiexutyvC62/xMhc4
         LiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950813; x=1690542813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxUjDgbY/jNz54AC4sl2RIErcdWqb2mUuJILzEKOlqM=;
        b=DfUlVOaxtwtR2gIgWMajpG8L/kSfgTTXaLFvq4ojxNRI58Kz9IFkYKyDc5WSts3CKo
         HdyneMzDtRqBOdktUHJR0CxuVD9FmGKck7u+F2/j6x6C/s6IacAF3S94p0eFqt9Vv0ZP
         VHMWdOCvTCT8UlnTVcX+iYNWkZHHKLoynvnMxWcmNF9ctuUkUf7ZGk6iZPk7cJfLSQCt
         +vi9jyOh87hqQ7KMTB+0b9+eOA0Dy7M2V5a/NDScYByJmKIX/5zLzdj6xYEc+vNL5sUu
         eOcZmzHCDrldWxCMqhsnGi9KqBAR/flq3K4UhttuuofNq2g1a/m3nO7rgta5NxJ2Wy/y
         aCtw==
X-Gm-Message-State: AC+VfDx/ZNb3sDvpKO4ReESrPy3EcNePcS5kypaS64UXRjniuUBbQnkX
        uylZH3v9DCriivUrTAuIsJtheQ==
X-Google-Smtp-Source: ACHHUZ7F1tJgooydEk02WTCZjUfRe7PKzXWFYzlX3R9hRMRIB9K95VGzrtXqoz4UshqPiLZ3IaK0qw==
X-Received: by 2002:a2e:8e8a:0:b0:2b4:8239:b132 with SMTP id z10-20020a2e8e8a000000b002b48239b132mr18914904ljk.22.1687950813572;
        Wed, 28 Jun 2023 04:13:33 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id d19-20020a2e3313000000b002b1e6a78d3esm2165609ljc.82.2023.06.28.04.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:13:33 -0700 (PDT)
Message-ID: <2dfa5bb8-3189-29f2-a85f-3dd392b27141@linaro.org>
Date:   Wed, 28 Jun 2023 13:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
 <b84b2bfc-6f8f-f50f-27b5-52a982ae30f2@linaro.org>
 <e80f0bd3-cf1e-dfed-bcc6-d22d4d934230@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e80f0bd3-cf1e-dfed-bcc6-d22d4d934230@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2023 10:52, Komal Bajaj wrote:
> 
> 
> On 6/23/2023 8:28 PM, Konrad Dybcio wrote:
>> On 23.06.2023 16:18, Komal Bajaj wrote:
>>> Add LLCC support for multi channel DDR configuration
>>> based on a feature register. Reading DDR channel
>>> confiuration uses nvmem framework, so select the
>>> dependency in Kconfig. Without this, there will be
>>> errors while building the driver with COMPILE_TEST only.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/Kconfig     |  2 ++
>>>   drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index a491718f8064..cc9ad41c63aa 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -64,6 +64,8 @@ config QCOM_LLCC
>>>       tristate "Qualcomm Technologies, Inc. LLCC driver"
>>>       depends on ARCH_QCOM || COMPILE_TEST
>>>       select REGMAP_MMIO
>>> +    select NVMEM
>>> +    select QCOM_SCM
>>>       help
>>>         Qualcomm Technologies, Inc. platform specific
>>>         Last Level Cache Controller(LLCC) driver for platforms such as,
>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>> index 6cf373da5df9..3c29612da1c5 100644
>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/mutex.h>
>>> +#include <linux/nvmem-consumer.h>
>>>   #include <linux/of.h>
>>>   #include <linux/of_device.h>
>>>   #include <linux/regmap.h>
>>> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>>>       return ret;
>>>   }
>>>   +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
>>> +    if (ret == -ENOENT) {
>>> +        *cfg_index = 0;
>>> +        return 0;
>>> +    }
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>>   {
>>>       /* Set the global pointer to a error code to avoid referencing it */
>>> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>>       struct device *dev = &pdev->dev;
>>>       int ret, i;
>>>       struct platform_device *llcc_edac;
>>> -    const struct qcom_llcc_config *cfg;
>>> +    const struct qcom_llcc_config *cfg, *entry;
>>>       const struct llcc_slice_config *llcc_cfg;
>>>       u32 sz;
>>> +    u8 cfg_index;
>>>       u32 version;
>>>       struct regmap *regmap;
>>> +    u32 num_entries = 0;
>>>         drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>>       if (!drv_data) {
>>> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>>         drv_data->version = version;
>>>   -    llcc_cfg = cfg[0]->sct_data;
>>> -    sz = cfg[0]->size;
>>> +    ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>>> +    if (ret)
>>> +        goto err;
>>> +
>>
>>> +    for (entry = cfg; entry->sct_data; entry++, num_entries++)
>>> +        ;
>>> +    if (cfg_index >= num_entries || cfg_index < 0) {
>> cfg_index is an unsigned variable, it can never be < 0
> 
> Okay, will remove this condition.
> 
>>
>>> +        ret = -EINVAL;
>>> +        goto err;
>>> +    }
>>> +
>> if (cfg_index >= entry->size)? With that, you can also keep the config
>> entries non-0-terminated in the previous patch, saving a whole lot of RAM.
> 
> entry->size represents the size of sct table whereas num_entries represents the number
> of sct tables that we can have. And by this check we are validating the value read from the
> fuse register. Am I understanding your comment correctly?
Oh you're right.

I still see room for improvement, though.

For example, you duplicate assigning need_llcc_cfg, reg_offset
and edac_reg_offset. You can add a new struct, like "sct_config" and add
a pointer to sct_config[] & the length of this array to qcom_llcc_config.

Konrad

> 
>>
>> Konrad
>>> +    llcc_cfg = cfg[cfg_index].sct_data;
>>> +    sz = cfg[cfg_index].size;
>>>         for (i = 0; i < sz; i++)
>>>           if (llcc_cfg[i].slice_id > drv_data->max_slices)
> 
