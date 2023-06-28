Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA696741208
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjF1NOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbjF1NOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:14:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDF6294E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:14:08 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso6502701e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687958046; x=1690550046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6viCOgG4sp4LSEgc4O1bPfBhiupPntM6FB5iNKFMAlg=;
        b=EmAyIxCioasbpN3otta6Nnn4lDgBD4FrOjdP6edUgz2CQDliCCuDIAuo/QIAGbbuRE
         D7YVTwNRwaT9tQQgXwxRvp3UWHURk52vJsOSemn0/YrPYcRpy7uw5jJz28Kv1WwyCIF1
         rrd9Bcpj5jntR44W4kh/BcYHXf5UEshadofhcTJ3kZqbxYcem7Dj44CbP8lDbisfsS1g
         gU9JaINbpQjqh6xsnJMZKHRgGRsoBBS1ZJkYkwWA6zu391G6qVvp7h7fZfo2KfxlskAB
         /wDhiqnid3rxlm21U6dZoSvEVBUaB4Lo/daNWVQeiOaX20pm0g2K88698XnlLaqud+F/
         klUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958046; x=1690550046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6viCOgG4sp4LSEgc4O1bPfBhiupPntM6FB5iNKFMAlg=;
        b=ZOVfl+RqOP3uGvjYN/9aGYnW1DP/7dY5RKppwCUFWriUnlb9x22tsJnFNInvF/vBsG
         /2JERSX8l3wRXb2/8jqDraSzDIvtXVXee3gw8NH/F8S/AKfiiLNG9rawiCopWieihDQ8
         lSJCOkMD/MXGLWvK3Ot4G3dzPHy8qad1GuBV+sAdL3tRB64qnHuXyaunYh/Ps6PGg/G3
         6jK4ozaGAmPzLjl3bFbjy2LxUR8QSWzAdGf8NnTC1g6E6oYywtQclplzFiR8Wh6eSOCr
         ZMJbIIZSh0c1rKB96GJNGYkJXheeZoDaTdgTjy44Bq+TE6aJ36pTtJIoV4fYwVH3RwhV
         SqRQ==
X-Gm-Message-State: AC+VfDxVuf32I5qEbhY6phm3FjvXV3aEnOzrXH70kdfJVgnLmObq0CyQ
        R10S0PrJpooUhJ74RxBRygEngw==
X-Google-Smtp-Source: ACHHUZ5rHPLrRU8/kDyX/6ZBhH+KbrmbSJ6pf0ikKhJimA9mXA5l0jp63+OklliKfxxLNCvUh3baWw==
X-Received: by 2002:ac2:4f0f:0:b0:4fb:8c2a:d43f with SMTP id k15-20020ac24f0f000000b004fb8c2ad43fmr2954905lfr.7.1687958046302;
        Wed, 28 Jun 2023 06:14:06 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a22-20020a19f816000000b004fb77d6cab3sm1099391lff.261.2023.06.28.06.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 06:14:05 -0700 (PDT)
Message-ID: <a16b57be-34cd-d093-ac63-d02aef049e51@linaro.org>
Date:   Wed, 28 Jun 2023 16:14:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/6] soc: qcom: Add LLCC support for multi channel DDR
Content-Language: en-GB
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230623141806.13388-1-quic_kbajaj@quicinc.com>
 <20230623141806.13388-6-quic_kbajaj@quicinc.com>
 <CAA8EJpoZiXWDHGEgBF6KuKruQigqdy37pLH1Q_AnXsN6iRPhyA@mail.gmail.com>
 <db8ea67e-529c-856b-026e-2435a2405f6b@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <db8ea67e-529c-856b-026e-2435a2405f6b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 28/06/2023 11:45, Komal Bajaj wrote:

No HTML emails on public mailing lists, please.

> 
> 
> On 6/23/2023 7:56 PM, Dmitry Baryshkov wrote:
>> On Fri, 23 Jun 2023 at 17:19, Komal Bajaj<quic_kbajaj@quicinc.com>  wrote:
>>> Add LLCC support for multi channel DDR configuration
>>> based on a feature register. Reading DDR channel
>>> confiuration uses nvmem framework, so select the
>>> dependency in Kconfig. Without this, there will be
>>> errors while building the driver with COMPILE_TEST only.
>>>
>>> Signed-off-by: Komal Bajaj<quic_kbajaj@quicinc.com>
>>> ---
>>>   drivers/soc/qcom/Kconfig     |  2 ++
>>>   drivers/soc/qcom/llcc-qcom.c | 33 ++++++++++++++++++++++++++++++---
>>>   2 files changed, 32 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>> index a491718f8064..cc9ad41c63aa 100644
>>> --- a/drivers/soc/qcom/Kconfig
>>> +++ b/drivers/soc/qcom/Kconfig
>>> @@ -64,6 +64,8 @@ config QCOM_LLCC
>>>          tristate "Qualcomm Technologies, Inc. LLCC driver"
>>>          depends on ARCH_QCOM || COMPILE_TEST
>>>          select REGMAP_MMIO
>>> +       select NVMEM
>> No need to select NVMEM. The used functions are stubbed if NVMEM is disabled
> 
> With the previous patch, where this config was not selected, below error 
> was flagged by kernel test robot -
> 
>     drivers/soc/qcom/llcc-qcom.c: In function 'qcom_llcc_get_cfg_index':
>      >> drivers/soc/qcom/llcc-qcom.c:951:15: error: implicit declaration
>     of function 'nvmem_cell_read_u8'; did you mean
>     'nvmem_cell_read_u64'? [-Werror=implicit-function-declaration]
>           951 |         ret = nvmem_cell_read_u8(&pdev->dev,
>     "multi_chan_ddr", cfg_index);
>               |               ^~~~~~~~~~~~~~~~~~
>               |               nvmem_cell_read_u64
>         cc1: some warnings being treated as errors

Judging from the rest of nvmem-consumer.h, it appears that not having 
stubs for this function is an omission. Please fix the header instead.

> 
>>> +       select QCOM_SCM
>>>          help
>>>            Qualcomm Technologies, Inc. platform specific
>>>            Last Level Cache Controller(LLCC) driver for platforms such as,
>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>> index 6cf373da5df9..3c29612da1c5 100644
>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/kernel.h>
>>>   #include <linux/module.h>
>>>   #include <linux/mutex.h>
>>> +#include <linux/nvmem-consumer.h>
>>>   #include <linux/of.h>
>>>   #include <linux/of_device.h>
>>>   #include <linux/regmap.h>
>>> @@ -943,6 +944,19 @@ static int qcom_llcc_cfg_program(struct platform_device *pdev,
>>>          return ret;
>>>   }
>>>
>>> +static int qcom_llcc_get_cfg_index(struct platform_device *pdev, u8 *cfg_index)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = nvmem_cell_read_u8(&pdev->dev, "multi-chan-ddr", cfg_index);
>>> +       if (ret == -ENOENT) {
>> || ret == -EOPNOTSUPP ?
> 
> Okay
> 
>>> +               *cfg_index = 0;
>>> +               return 0;
>>> +       }
>>> +
>>> +       return ret;
>>> +}
>>> +
>>>   static int qcom_llcc_remove(struct platform_device *pdev)
>>>   {
>>>          /* Set the global pointer to a error code to avoid referencing it */
>>> @@ -975,11 +989,13 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>>          struct device *dev = &pdev->dev;
>>>          int ret, i;
>>>          struct platform_device *llcc_edac;
>>> -       const struct qcom_llcc_config *cfg;
>>> +       const struct qcom_llcc_config *cfg, *entry;
>>>          const struct llcc_slice_config *llcc_cfg;
>>>          u32 sz;
>>> +       u8 cfg_index;
>>>          u32 version;
>>>          struct regmap *regmap;
>>> +       u32 num_entries = 0;
>>>
>>>          drv_data = devm_kzalloc(dev, sizeof(*drv_data), GFP_KERNEL);
>>>          if (!drv_data) {
>>> @@ -1040,8 +1056,19 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>>
>>>          drv_data->version = version;
>>>
>>> -       llcc_cfg = cfg[0]->sct_data;
>>> -       sz = cfg[0]->size;
>>> +       ret = qcom_llcc_get_cfg_index(pdev, &cfg_index);
>>> +       if (ret)
>>> +               goto err;
>>> +
>>> +       for (entry = cfg; entry->sct_data; entry++, num_entries++)
>>> +               ;
>> Please add num_cfgs to the configuration data instead.
> 
> Shall I create a new wrapper struct having a field num_cfg and a pointer 
> to those cfgs
> because configuration data is itself an instance of "struct 
> qcom_llcc_config" and
> we can have multiple instances of it.

A wrapper struct is a better approach in my opinion.

> 
> 
>>> +       if (cfg_index >= num_entries || cfg_index < 0) {
>> cfg_index is unsigned, so it can not be less than 0.
> 
> Okay.
> 
>>> +               ret = -EINVAL;
>>> +               goto err;
>>> +       }
>>> +
>>> +       llcc_cfg = cfg[cfg_index].sct_data;
>>> +       sz = cfg[cfg_index].size;
>>>
>>>          for (i = 0; i < sz; i++)
>>>                  if (llcc_cfg[i].slice_id > drv_data->max_slices)
>>> --
>>> 2.40.1
>>>
> 

-- 
With best wishes
Dmitry

