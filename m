Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF97198A6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbjFAKM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjFAKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:11:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3BF2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:10:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso679536e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614224; x=1688206224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kqBUjWI+76doHr5EZbuN0w++X2mptcw1EOdERwsqZMk=;
        b=tGlEWfzHXwI8csw7I0/6zpQywGAXQmwQBh67RP4VvvY1Kz7affgds8Jjj2BUw5HMSq
         568Kg48IQ3dMI5jBQ8w4r3Co6WseG6peFqrj8X0FnsDMsvhsfoNUS21Sb47ObcoOqd5v
         tzmGV8iAedamcBPTek2ixsmyW9xz9qtv6Po8qTn3FrVrVKJFRV9k8BlxYF5PJHeiFvV7
         XUsMdB4ecMHk8Yea1IIVegHOaK9d8RmMa5IGxapLpFfBkN0JuAf+ytqylxPQ9LB2G/rv
         q5kydcM/l7E9QZAcyYbU8BlcFAvCf6GIDkCUVFUwvJ5C9qFRT+GWjyoDppegVrWr+SVS
         rt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614224; x=1688206224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqBUjWI+76doHr5EZbuN0w++X2mptcw1EOdERwsqZMk=;
        b=J/d7NoxDAjbq1JkgnIYdiecF0MnvTJXo8WsDGqPgLdpG8bfXlwERKAt9YlgIQcvI8r
         dYvQQ3mmuQz7ZRNx9FRIoJB/MOZwnMG9Pun978CTRQU7Y5kqoDIM5jA5J6b9X+WQrtL7
         6mmoZc+rNKWXBJfsZO4Tv3ZMFw+WyhcVKePd8VpHRm3EzglqHRpKcMsKDIPXFcJioisP
         j4Ww/tQv97lXo1VzXaLJ05JnUanKgvwTaD31ms90fW0AHsqysNaCeHA7gg5VTymG/GfG
         2qc7hD48gY00ntFZdS85N8yqgSozMdJJe186Pf/DLyMQbKRekWzopyhctLQWLQjiLMXT
         GHxQ==
X-Gm-Message-State: AC+VfDxCLfCUN3MPL1kBzZracvyqXgSipkBQgZEJfdrJVH/DUQcbtlaj
        Iaq+qWy4C2GuQ+0/VsxbVGIBUA==
X-Google-Smtp-Source: ACHHUZ6506Dfb6uP1jcUIzwaAwoWPuKSwW81TagN3mRlUf1Uc5rUF5OrMryQMtKo5gbRRtVwJndhLA==
X-Received: by 2002:ac2:5471:0:b0:4db:964:51b5 with SMTP id e17-20020ac25471000000b004db096451b5mr1059510lfn.41.1685614224236;
        Thu, 01 Jun 2023 03:10:24 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id x9-20020ac24889000000b004ec8b638115sm1028119lfc.193.2023.06.01.03.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:10:23 -0700 (PDT)
Message-ID: <8cb8b647-8efb-e140-5575-52785b4e93d3@linaro.org>
Date:   Thu, 1 Jun 2023 12:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 12/20] interconnect: qcom: msm8996: Hook up RPM bus clk
 definitions
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
 <20230526-topic-smd_icc-v1-12-1bf8e6663c4e@linaro.org>
 <62eaf77a-94c4-0a48-e335-83664fe343db@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <62eaf77a-94c4-0a48-e335-83664fe343db@linaro.org>
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



On 1.06.2023 12:08, Dmitry Baryshkov wrote:
> On 30/05/2023 13:20, Konrad Dybcio wrote:
>> Assign the necessary definitions to migrate to the new bus clock
>> handling mechanism.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/interconnect/qcom/msm8996.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>> index 1f7e88a37acd..a596f4035d2e 100644
>> --- a/drivers/interconnect/qcom/msm8996.c
>> +++ b/drivers/interconnect/qcom/msm8996.c
>> @@ -1840,6 +1840,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = a1noc_nodes,
>>       .num_nodes = ARRAY_SIZE(a1noc_nodes),
>> +    .bus_clk_desc = &aggre1_branch_clk,
>>       .regmap_cfg = &msm8996_a1noc_regmap_config
>>   };
>>   @@ -1861,6 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = a2noc_nodes,
>>       .num_nodes = ARRAY_SIZE(a2noc_nodes),
>> +    .bus_clk_desc = &aggre2_branch_clk,
>>       .intf_clocks = a2noc_intf_clocks,
>>       .num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>>       .regmap_cfg = &msm8996_a2noc_regmap_config
>> @@ -1889,6 +1891,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
>>       .type = QCOM_ICC_BIMC,
>>       .nodes = bimc_nodes,
>>       .num_nodes = ARRAY_SIZE(bimc_nodes),
>> +    .bus_clk_desc = &bimc_clk,
>>       .regmap_cfg = &msm8996_bimc_regmap_config
>>   };
>>   @@ -1947,6 +1950,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = cnoc_nodes,
>>       .num_nodes = ARRAY_SIZE(cnoc_nodes),
>> +    .bus_clk_desc = &bus_2_clk,
>>       .regmap_cfg = &msm8996_cnoc_regmap_config
>>   };
>>   @@ -2000,6 +2004,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = mnoc_nodes,
>>       .num_nodes = ARRAY_SIZE(mnoc_nodes),
>> +    .bus_clk_desc = &mmaxi_0_clk,
> 
> What about an ahb_clk_src here?
This should be remodeled to MNoC (MMAXI clk) + MNoC_AHB (ahb_clk_src).

I can fix this after this series.

Konrad
> 
>>       .intf_clocks = mm_intf_clocks,
>>       .num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>>       .regmap_cfg = &msm8996_mnoc_regmap_config
>> @@ -2038,6 +2043,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = pnoc_nodes,
>>       .num_nodes = ARRAY_SIZE(pnoc_nodes),
>> +    .bus_clk_desc = &bus_0_clk,
>>       .regmap_cfg = &msm8996_pnoc_regmap_config
>>   };
>>   @@ -2082,6 +2088,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
>>       .type = QCOM_ICC_NOC,
>>       .nodes = snoc_nodes,
>>       .num_nodes = ARRAY_SIZE(snoc_nodes),
>> +    .bus_clk_desc = &bus_1_clk,
>>       .regmap_cfg = &msm8996_snoc_regmap_config
>>   };
>>  
> 
