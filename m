Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3A71985E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjFAKHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFAKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:06:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F18B10C3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:04:30 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so679706e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613869; x=1688205869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJNiN9Rgdn8mkSyiQ9RDe5Olir1iLjIg26HV2Np6PqM=;
        b=ADC1swmq9bOiBCrK0nfN4az8lJN0QZSH8DBLKxmGshsZR9Q0wpXlm3AMDsqcILYQrP
         UCeq/X5wy4zBs1lrKPo4GtLC2+lSuYgrZHjHmRHedzcbmpXu6lBOQJV3BQeCZfKEe8JP
         q99J4MnMxmB9v+lVo1IDCWRA2APJLumW22kpqdU2QHxW9AMNS8T2+fg+88eBI0qgWBnu
         IL22HlEWXCuao/l7pNo6t5ecZ+B1D1IDby+xGKatIoi8blFqJOUHxXf1k9GHfuqE2NSt
         t0rx/+Sw72o92e+oCIqG5jSTZbxEMnIu/R0HJ1nO/xoL7kpnnPQcHh0wKwtaVy6vBGn2
         E51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613869; x=1688205869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJNiN9Rgdn8mkSyiQ9RDe5Olir1iLjIg26HV2Np6PqM=;
        b=R8fVo0+Xz7BSQr3geubcEeCOGOrGnqAA3cWg+8LA9dg1ROfbF/cK/xAFe5E5fS/4SR
         5Z98uZNsH0o+lS7mh5hh6SbgTX/evWzQ175v45F4Ya7yEXJEV3kfOvWnX2l2xJK9gccS
         SVvbJqza5mHDKdvMLoSoMuYCx7oJatFRyXoGVVvngiXj3eklN3LWHWZbP6aZEL4/Kxjg
         nk/XHnooawnOfFbHyQ18mAxQViAcMFlm+v015QWm5mRJCvqkwzvPdXnwxwPz9ZVn9K1O
         0OgyWLQgOf9Nd9COox0wOXdh27w531NQG98eGcCgx7VQt5FlyTAglMXBlRwLU8iQ5UFP
         yKhA==
X-Gm-Message-State: AC+VfDwNNrXLFHT+qtY2lOvdGmaaZz8KrG1ARI9SzdrHZRyxpdMctr4r
        cFTWWSjuA2Gbteb1mRqfOSUjuA==
X-Google-Smtp-Source: ACHHUZ7gSDrgFnWeGzUS2259K0tpwtH5wQZuAKNxVTYHRCXKEvICWt9quSoLJ6SwcEnIDmtaycD2Ng==
X-Received: by 2002:ac2:518f:0:b0:4f3:bad8:b7fc with SMTP id u15-20020ac2518f000000b004f3bad8b7fcmr991475lfi.29.1685613868703;
        Thu, 01 Jun 2023 03:04:28 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id r11-20020ac25a4b000000b004f3a90b195esm1037722lfn.51.2023.06.01.03.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:04:27 -0700 (PDT)
Message-ID: <926cfda5-199c-4207-3d0c-952be9c9597a@linaro.org>
Date:   Thu, 1 Jun 2023 12:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 08/20] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-8-1bf8e6663c4e@linaro.org>
 <011a8584-b92e-2b80-3b0b-f6af21d23ef9@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <011a8584-b92e-2b80-3b0b-f6af21d23ef9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.06.2023 12:01, Dmitry Baryshkov wrote:
> On 30/05/2023 13:20, Konrad Dybcio wrote:
>> Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
>> clock resources within the interconnect framework. This lets us greatly
>> simplify all of the code handling, as setting the rate comes down to:
>>
>> u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
>> write_to_rpm(clock.description, rate_khz);
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
>>   drivers/interconnect/qcom/smd-rpm.c | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
>> index 9b4ea4e39b9f..aec192321411 100644
>> --- a/drivers/interconnect/qcom/icc-rpm.h
>> +++ b/drivers/interconnect/qcom/icc-rpm.h
>> @@ -22,6 +22,18 @@ enum qcom_icc_type {
>>       QCOM_ICC_QNOC,
>>   };
>>   +/**
>> + * struct rpm_clk_resource - RPM bus clock resource
>> + * @resource_type: RPM resource type of the clock resource
>> + * @clock_id: index of the clock resource of a specific resource type
>> + * @branch: whether the resource represents a branch clock
>> +*/
>> +struct rpm_clk_resource {
>> +    u32 resource_type;
>> +    u32 clock_id;
>> +    bool branch;
>> +};
>> +
>>   #define NUM_BUS_CLKS    2
>>     /**
>> @@ -47,6 +59,7 @@ struct qcom_icc_provider {
>>       int qos_offset;
>>       u64 bus_clk_rate[NUM_BUS_CLKS];
>>       struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
>> +    const struct rpm_clk_resource *bus_clk_desc;
>>       struct clk_bulk_data *intf_clks;
>>       bool keep_alive;
>>       bool is_on;
>> @@ -104,6 +117,7 @@ struct qcom_icc_desc {
>>       struct qcom_icc_node * const *nodes;
>>       size_t num_nodes;
>>       const char * const *bus_clocks;
>> +    const struct rpm_clk_resource *bus_clk_desc;
>>       const char * const *intf_clocks;
>>       size_t num_intf_clocks;
>>       bool keep_alive;
>> @@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
>>     bool qcom_icc_rpm_smd_available(void);
>>   int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
>> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate);
>>     #endif
>> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
>> index b0183262ba66..6c51e346b326 100644
>> --- a/drivers/interconnect/qcom/smd-rpm.c
>> +++ b/drivers/interconnect/qcom/smd-rpm.c
>> @@ -16,6 +16,7 @@
>>   #include "icc-rpm.h"
>>     #define RPM_KEY_BW        0x00007762
>> +#define QCOM_RPM_SMD_KEY_RATE    0x007a484b
> 
> Nit: can we move all RPM keys to some common header?
They're quite scattered across subsystems so I think it'd be a separate
topic.. Also I think we could think about migrating to stringified raw
values like we have in RPMh - they keys are LE 4-char, non-NULL-terminated
strings (e.g. this one is 'KHz')

> 
>>     static struct qcom_smd_rpm *icc_smd_rpm;
>>   @@ -44,6 +45,38 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>>   }
>>   EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>>   +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate)
>> +{
>> +    struct clk_smd_rpm_req req = {
>> +        .key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
>> +        .nbytes = cpu_to_le32(sizeof(u32)),
>> +    };
>> +    int ret;
>> +
>> +    /* Branch clocks are only on/off */
>> +    if (clk->branch) {
>> +        active_rate = !!active_rate;
>> +        sleep_rate = !!sleep_rate;
>> +    }
>> +
>> +    req.value = cpu_to_le32(active_rate);
>> +    ret = qcom_rpm_smd_write(icc_smd_rpm,
>> +                 QCOM_SMD_RPM_ACTIVE_STATE,
>> +                 clk->resource_type,
>> +                 clk->clock_id,
>> +                 &req, sizeof(req));
>> +    if (ret)
>> +        return ret;
>> +
>> +    req.value = cpu_to_le32(sleep_rate);
>> +    return qcom_rpm_smd_write(icc_smd_rpm,
>> +                  QCOM_SMD_RPM_SLEEP_STATE,
>> +                  clk->resource_type,
>> +                  clk->clock_id,
>> +                  &req, sizeof(req));
>> +}
>> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
>> +
>>   static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
>>   {
>>       icc_smd_rpm = NULL;
>> @@ -60,6 +93,10 @@ static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
>>           return -ENODEV;
>>       }
>>   +    /* We need the clock driver to kick things off first to avoid ugly races */
>> +    if (!qcom_smd_rpm_scaling_available())
>> +        return -EPROBE_DEFER;
> 
> 
> This should not be a part of this commit.
"eeh", it makes no functional difference, as if this patch is the HEAD,
we're still consuming the clocks via CCF, which guarantees this is always
true.. I can move it if you wish.

Konrad
> 
>> +
>>       return 0;
>>   }
>>  
> 
