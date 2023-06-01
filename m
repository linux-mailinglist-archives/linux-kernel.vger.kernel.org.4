Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8007198E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjFAKQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbjFAKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:16:01 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54771212D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:13:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f4f757d575so943724e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614396; x=1688206396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNiz1qh0Dz04mEFis12wdHfY4TpJ/qR3Xr+9NO3Cn50=;
        b=YEaX4/1bNNNVMcVj6YNYk7x7+f19Xh87Mh0CIEhj/frpcOfg8lYZ4WukEYRtiGQY6v
         W20qtAwofYDFJNluC8vLxnn80NJ9pkxjWkZN7Q9XgHI+DoSV9X4zcDiNpt1sWAS/Hj1j
         YKhke4AQG6yN1u/VOlNKAzlgmoQcLlEdLax6ZmPNYvIV7zG1uuNqH2ml17hrLGEAD20U
         BgE07ald3NS6V9Hl7HkwUYApnzKAjqNvXdJUteC1BO+PPKjY94ZN56gufL9D+FfJ3ZL1
         NR3axVud8Cyn78879u8DK2/VczR1L/bbBxUrI3fn536O33kYS14+E6sDXhxjoxtCYxtD
         0rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614396; x=1688206396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNiz1qh0Dz04mEFis12wdHfY4TpJ/qR3Xr+9NO3Cn50=;
        b=VMxm/p8dOGgRwCaZQ7c81tT/qAil6tlC4IB2xWwDaZnlue/BPwfpkKDZfKG/dLVk+C
         Rc5IeOYZ2Pdnyq7pIN6MWTo8pGawvgx5vMqmWVMen39azsoGV+m9Cw9U79cmHEldX91i
         OL2eLJ5Bqeeo53FLm6noauTh/8DWdTFaCenQYMw7Mv3bvzGjFOSWGoRhDTCRyNYFi9UG
         yytU+Pl5B3ejpqnc2VydDU/oGSWoFGi2qxKvPc2V77B3EXyPN/Tc1g6vQVKk+7IPkdz0
         jWI+IARDaVabnIoHJKhQHVxjPpqCxWFSxJo5pCi1wTItk95QF0wwCAno6KaCqtrbc++U
         stCw==
X-Gm-Message-State: AC+VfDwBB9V3lVZwGSCDhA5SNtYRKasn6sSbMfS5L/2jLd5wChqDobZj
        c9Rh3qvzSdpL1ZwLJWurVkg02Q==
X-Google-Smtp-Source: ACHHUZ4yXApq7ihqpZV3EVd32XzLX9NHCuZdFl/cH8PMru4YHFKTNYrojqdU1+JqbuOKQriMVZqyTQ==
X-Received: by 2002:a05:6512:11c1:b0:4ed:d5ce:7dea with SMTP id h1-20020a05651211c100b004edd5ce7deamr355244lfr.27.1685614395863;
        Thu, 01 Jun 2023 03:13:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id j13-20020a19f50d000000b004f19bfdfef9sm1040399lfb.21.2023.06.01.03.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:13:15 -0700 (PDT)
Message-ID: <cfe55011-b21d-18ae-88b7-f13d3359ec8f@linaro.org>
Date:   Thu, 1 Jun 2023 12:13:14 +0200
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
 <8cb8b647-8efb-e140-5575-52785b4e93d3@linaro.org>
 <1e846ba0-c8dc-5a93-538e-42457c557580@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1e846ba0-c8dc-5a93-538e-42457c557580@linaro.org>
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



On 1.06.2023 12:11, Dmitry Baryshkov wrote:
> On 01/06/2023 13:10, Konrad Dybcio wrote:
>>
>>
>> On 1.06.2023 12:08, Dmitry Baryshkov wrote:
>>> On 30/05/2023 13:20, Konrad Dybcio wrote:
>>>> Assign the necessary definitions to migrate to the new bus clock
>>>> handling mechanism.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>>>    drivers/interconnect/qcom/msm8996.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
>>>> index 1f7e88a37acd..a596f4035d2e 100644
>>>> --- a/drivers/interconnect/qcom/msm8996.c
>>>> +++ b/drivers/interconnect/qcom/msm8996.c
>>>> @@ -1840,6 +1840,7 @@ static const struct qcom_icc_desc msm8996_a1noc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = a1noc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(a1noc_nodes),
>>>> +    .bus_clk_desc = &aggre1_branch_clk,
>>>>        .regmap_cfg = &msm8996_a1noc_regmap_config
>>>>    };
>>>>    @@ -1861,6 +1862,7 @@ static const struct qcom_icc_desc msm8996_a2noc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = a2noc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(a2noc_nodes),
>>>> +    .bus_clk_desc = &aggre2_branch_clk,
>>>>        .intf_clocks = a2noc_intf_clocks,
>>>>        .num_intf_clocks = ARRAY_SIZE(a2noc_intf_clocks),
>>>>        .regmap_cfg = &msm8996_a2noc_regmap_config
>>>> @@ -1889,6 +1891,7 @@ static const struct qcom_icc_desc msm8996_bimc = {
>>>>        .type = QCOM_ICC_BIMC,
>>>>        .nodes = bimc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(bimc_nodes),
>>>> +    .bus_clk_desc = &bimc_clk,
>>>>        .regmap_cfg = &msm8996_bimc_regmap_config
>>>>    };
>>>>    @@ -1947,6 +1950,7 @@ static const struct qcom_icc_desc msm8996_cnoc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = cnoc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(cnoc_nodes),
>>>> +    .bus_clk_desc = &bus_2_clk,
>>>>        .regmap_cfg = &msm8996_cnoc_regmap_config
>>>>    };
>>>>    @@ -2000,6 +2004,7 @@ static const struct qcom_icc_desc msm8996_mnoc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = mnoc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(mnoc_nodes),
>>>> +    .bus_clk_desc = &mmaxi_0_clk,
>>>
>>> What about an ahb_clk_src here?
>> This should be remodeled to MNoC (MMAXI clk) + MNoC_AHB (ahb_clk_src).
>>
>> I can fix this after this series.
> 
> As long as it doesn't result in a regression.
"works on my machine".. We've not been setting the rate on it
before and it's currently turned on by being an intf_clock, so
I think it doesn't even change the behavior.

Konrad
> 
>> Konrad
>>>
>>>>        .intf_clocks = mm_intf_clocks,
>>>>        .num_intf_clocks = ARRAY_SIZE(mm_intf_clocks),
>>>>        .regmap_cfg = &msm8996_mnoc_regmap_config
>>>> @@ -2038,6 +2043,7 @@ static const struct qcom_icc_desc msm8996_pnoc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = pnoc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(pnoc_nodes),
>>>> +    .bus_clk_desc = &bus_0_clk,
>>>>        .regmap_cfg = &msm8996_pnoc_regmap_config
>>>>    };
>>>>    @@ -2082,6 +2088,7 @@ static const struct qcom_icc_desc msm8996_snoc = {
>>>>        .type = QCOM_ICC_NOC,
>>>>        .nodes = snoc_nodes,
>>>>        .num_nodes = ARRAY_SIZE(snoc_nodes),
>>>> +    .bus_clk_desc = &bus_1_clk,
>>>>        .regmap_cfg = &msm8996_snoc_regmap_config
>>>>    };
>>>>   
>>>
> 
