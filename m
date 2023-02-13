Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5A66940C3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMJUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjBMJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:20:11 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07142C644
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:10 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qb15so28109894ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2B8hEewNdWItES2Vk29WXwOiP9ExfRXkG3vUZylcjnI=;
        b=fDPeHCwymJuXaomVmuNcELmz4BTu3Po7zo35vRtJoat49C817xe4vwrPpNiHE8lvcj
         R11vG0kF41QQVQPsz0YR81WBm9OeSllCOF2wX2E+mFlJeK79ra3meEs+IBZVv280etJa
         phr3gG8arHT4J3nRqitP0loLTyGflzhfSVXXcD4BxygFd3PcSmfrT5mddq8y13AlNB6K
         oKz95CwXKrFUcvQFpuvplXwgVai51kJrouyD9F675MI28amyTwnY5SH3sqlNFZk5ovqU
         VQE0eVxosSd7WlQ+6YktaM/iiDtFp/70qC3JI8SRXVPT6tSpNna8o2Rw5JtYnqIhAfKd
         yDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2B8hEewNdWItES2Vk29WXwOiP9ExfRXkG3vUZylcjnI=;
        b=4ngDwRI4a4BjYCsOHidhDA8aezzKoE+6248RH1QCitpCzHwl9rGIov40GuloYuBvaZ
         l6Sb6MjfC0Jmi6doaFRbjBkqOMVEtNQOiS5EtqBv/qtTTm/AQGNSeGxIMFZhAHuEGVly
         UbdJwBrXbvWxJ+0tkzd9sA9lLNautrNmE3YnWHytAg8zczd/wCwXCS4pw9u3eXuXh7lf
         P+HMbOM0sk6h2ttNSeis4KnjRaIBbD6aOF5ZD5HbjBug0nJo2eDXWKdI6TGaPVHVSM8m
         H+2x+kANcfAugEXyBkrRjuqUe0PUHlZIyKyZGW6LAoRBdFuX5qI0TxKSHnLrbG+TkLkP
         iv0A==
X-Gm-Message-State: AO0yUKWgirHph6ZGwAdUdUhjd3WOmdKNHDTj5lKWW0IRwDR8ognDiGsg
        OJMqUqXXimM5UgBJyWdfF/66Rg==
X-Google-Smtp-Source: AK7set/QGO1LlISCYWrHaC02unkuGVbkXMOVdwAdsc7iMg78GSqaXpmFnQsSNAbDFs1i4lYBTixMog==
X-Received: by 2002:a17:906:dc89:b0:8af:54d0:181d with SMTP id cs9-20020a170906dc8900b008af54d0181dmr12459486ejc.35.1676280008570;
        Mon, 13 Feb 2023 01:20:08 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id n16-20020a1709062bd000b008af2a7438acsm6493157ejg.188.2023.02.13.01.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:20:08 -0800 (PST)
Message-ID: <9e3316e5-df2f-7fdd-fc51-fe702a041129@linaro.org>
Date:   Mon, 13 Feb 2023 10:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 05/10] drm/msm/dsi: dsi_cfg: Deduplicate identical structs
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Harigovindan P <harigovi@codeaurora.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230211115110.1462920-1-konrad.dybcio@linaro.org>
 <20230211115110.1462920-6-konrad.dybcio@linaro.org>
 <fc29d13c-28bf-5090-bfaa-52ec6b3860e1@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <fc29d13c-28bf-5090-bfaa-52ec6b3860e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.02.2023 16:52, Dmitry Baryshkov wrote:
> On 11/02/2023 13:51, Konrad Dybcio wrote:
>> Some structs were defined multiple times for no apparent reason.
>> Deduplicate them.
>>
>> Fixes: 3f3c8aff1f8f ("drm/msm/dsi: Add configuration for 8x76")
>> Fixes: 3a3ff88a0fc1 ("drm/msm/dsi: Add 8x96 info in dsi_cfg")
>> Fixes: 6125bd327e16 ("drm/msm: add DSI support for sc7180")
>> Fixes: 65c391b31994 ("drm/msm/dsi: Add DSI support for SC7280")
> 
> I think we should drop these Fixes headers. There are no issues to be fixed in those versions. The code was inefficient and resulted in duplication of data, but that's all.
I see. I won't object!

Konrad
> 
> Other than that:
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 77 +++++++++++--------------------
>>   1 file changed, 26 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> index 5f62c563bd1c..860681bfc084 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> @@ -47,41 +47,32 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
>>       },
>>   };
>>   -static const char * const dsi_8916_bus_clk_names[] = {
>> +static const char * const dsi_v1_3_1_clk_names[] = {
>>       "mdp_core", "iface", "bus",
>>   };
>>   -static const struct regulator_bulk_data msm8916_dsi_regulators[] = {
>> +static const struct regulator_bulk_data dsi_v1_3_1_regulators[] = {
>>       { .supply = "vdda", .init_load_uA = 100000 },    /* 1.2 V */
>>       { .supply = "vddio", .init_load_uA = 100000 },    /* 1.8 V */
>>   };
>>     static const struct msm_dsi_config msm8916_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>> -    .regulator_data = msm8916_dsi_regulators,
>> -    .num_regulators = ARRAY_SIZE(msm8916_dsi_regulators),
>> -    .bus_clk_names = dsi_8916_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
>> +    .regulator_data = dsi_v1_3_1_regulators,
>> +    .num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
>> +    .bus_clk_names = dsi_v1_3_1_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
>>       .io_start = {
>>           { 0x1a98000, 0 },
>>       },
>>   };
>>   -static const char * const dsi_8976_bus_clk_names[] = {
>> -    "mdp_core", "iface", "bus",
>> -};
>> -
>> -static const struct regulator_bulk_data msm8976_dsi_regulators[] = {
>> -    { .supply = "vdda", .init_load_uA = 100000 },    /* 1.2 V */
>> -    { .supply = "vddio", .init_load_uA = 100000 },    /* 1.8 V */
>> -};
>> -
>>   static const struct msm_dsi_config msm8976_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>> -    .regulator_data = msm8976_dsi_regulators,
>> -    .num_regulators = ARRAY_SIZE(msm8976_dsi_regulators),
>> -    .bus_clk_names = dsi_8976_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
>> +    .regulator_data = dsi_v1_3_1_regulators,
>> +    .num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
>> +    .bus_clk_names = dsi_v1_3_1_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
>>       .io_start = {
>>           { 0x1a94000, 0x1a96000, 0 },
>>       },
>> @@ -107,10 +98,6 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
>>       },
>>   };
>>   -static const char * const dsi_8996_bus_clk_names[] = {
>> -    "mdp_core", "iface", "bus", "core_mmss",
>> -};
>> -
>>   static const struct regulator_bulk_data msm8996_dsi_regulators[] = {
>>       { .supply = "vdda", .init_load_uA = 18160 },    /* 1.25 V */
>>       { .supply = "vcca", .init_load_uA = 17000 },    /* 0.925 V */
>> @@ -121,8 +108,8 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>>       .regulator_data = msm8996_dsi_regulators,
>>       .num_regulators = ARRAY_SIZE(msm8996_dsi_regulators),
>> -    .bus_clk_names = dsi_8996_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
>> +    .bus_clk_names = dsi_6g_bus_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>>       .io_start = {
>>           { 0x994000, 0x996000, 0 },
>>       },
>> @@ -167,24 +154,20 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>>       },
>>   };
>>   -static const char * const dsi_sdm845_bus_clk_names[] = {
>> +static const char * const dsi_v2_4_clk_names[] = {
>>       "iface", "bus",
>>   };
>>   -static const char * const dsi_sc7180_bus_clk_names[] = {
>> -    "iface", "bus",
>> -};
>> -
>> -static const struct regulator_bulk_data sdm845_dsi_regulators[] = {
>> +static const struct regulator_bulk_data dsi_v2_4_regulators[] = {
>>       { .supply = "vdda", .init_load_uA = 21800 },    /* 1.2 V */
>>   };
>>     static const struct msm_dsi_config sdm845_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>> -    .regulator_data = sdm845_dsi_regulators,
>> -    .num_regulators = ARRAY_SIZE(sdm845_dsi_regulators),
>> -    .bus_clk_names = dsi_sdm845_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>> +    .regulator_data = dsi_v2_4_regulators,
>> +    .num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
>> +    .bus_clk_names = dsi_v2_4_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>       .io_start = {
>>           { 0xae94000, 0xae96000, 0 },
>>       },
>> @@ -198,32 +181,24 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>>       .regulator_data = sm8550_dsi_regulators,
>>       .num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
>> -    .bus_clk_names = dsi_sdm845_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>> +    .bus_clk_names = dsi_v2_4_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>       .io_start = {
>>           { 0xae94000, 0xae96000, 0 },
>>       },
>>   };
>>   -static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
>> -    { .supply = "vdda", .init_load_uA = 21800 },    /* 1.2 V */
>> -};
>> -
>>   static const struct msm_dsi_config sc7180_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>> -    .regulator_data = sc7180_dsi_regulators,
>> -    .num_regulators = ARRAY_SIZE(sc7180_dsi_regulators),
>> -    .bus_clk_names = dsi_sc7180_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
>> +    .regulator_data = dsi_v2_4_regulators,
>> +    .num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
>> +    .bus_clk_names = dsi_v2_4_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>       .io_start = {
>>           { 0xae94000, 0 },
>>       },
>>   };
>>   -static const char * const dsi_sc7280_bus_clk_names[] = {
>> -    "iface", "bus",
>> -};
>> -
>>   static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
>>       { .supply = "vdda", .init_load_uA = 8350 },    /* 1.2 V */
>>   };
>> @@ -232,8 +207,8 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>>       .io_offset = DSI_6G_REG_SHIFT,
>>       .regulator_data = sc7280_dsi_regulators,
>>       .num_regulators = ARRAY_SIZE(sc7280_dsi_regulators),
>> -    .bus_clk_names = dsi_sc7280_bus_clk_names,
>> -    .num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
>> +    .bus_clk_names = dsi_v2_4_clk_names,
>> +    .num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>       .io_start = {
>>           { 0xae94000, 0xae96000, 0 },
>>       },
> 
