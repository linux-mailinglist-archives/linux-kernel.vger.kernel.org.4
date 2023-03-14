Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154C06B9288
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjCNMCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjCNMCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:02:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B30CC19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:01:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id br6so1505487lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678795291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxdl5EaWW37f/EaoWMzEiM+MDiQ+bRe3oc7oUW6vU3I=;
        b=xTaL5bWALtWMcWnGtP773pjTvoRnANAUPQsn4XcYFjc8/zqRJsx6TtUYWqSoqERUHi
         uoDrJx9M9FCI3B6TuBejWMYKN1AyLGKQv5bT61sswdp68OqbodO+/hZlw7AWeQ3fKiJA
         UoNjzx1AzJYwL6uTbLgKnRKXyT/tRH+XsarLdRIE1b1zcjru9aVX8m9Ms6JdVhiWHoXT
         VWjBf/fEdzAZhE0kRCtSDn4JynOBQuL79/bn/1FbR1HnFZXMbAcHuOLzkcvudoRWUJvR
         XliLM43MDSM3vpQwQ89KIMXqyfUWAs7ZeLbiFH6FZBLb0ROjufDvDza6rZFniWoibbq0
         AoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxdl5EaWW37f/EaoWMzEiM+MDiQ+bRe3oc7oUW6vU3I=;
        b=Y5e9HKj6zYkhGs5+FU/BRd3N5BM0aUfZvckuxW6eGf7NDZdWKBuTmfZ4dZ1ohSWtOR
         4NZ5VtQg8d6siX2Q23JfM2WeAStuMLhv5CW77kBRpm/2B2miBewKlNakP4tgO+FhP75o
         Vb8uS9QdSCiXtraxsZ9QZ7Xnc6fB3WhVJyOaCVWjK93oVcI2oSxqKlKwv30aftXmyv02
         l9EdTxk964XjHYrlVEO9D2ozKQv0Z9GJAuT8XRKEfoP5q6QoetUqTaBfhvGtQORr9rP3
         sdkjBQMdmhK8WEC12OfULcxrnHxToQ8s7EX9cWw0SuONbZevCbAX/yY8PvVGLNB6j/dv
         2Y6w==
X-Gm-Message-State: AO0yUKVRVdzG5yOFRhhgrtIcdEOQLAprx02XsafJA0B54ljrPQMk5Avj
        5rkVws3tZi9jsPy3UM04LJMErw==
X-Google-Smtp-Source: AK7set/k/n+CZueG3A0weqw5lpWKf9Y03en5sKrbyHi7IfWC18kdA/dqCvr/rAZCPbuIpQkzDLq4VQ==
X-Received: by 2002:ac2:55b3:0:b0:4b5:936e:69df with SMTP id y19-20020ac255b3000000b004b5936e69dfmr613091lfg.53.1678795291354;
        Tue, 14 Mar 2023 05:01:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id r6-20020ac25a46000000b004e849f6836csm376886lfn.167.2023.03.14.05.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:01:30 -0700 (PDT)
Message-ID: <6a07da47-fcaa-c7e6-36f8-96c055bee0f0@linaro.org>
Date:   Tue, 14 Mar 2023 13:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 04/10] drm/msm/dsi: dsi_cfg: Deduplicate identical
 structs
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-4-8bd7e1add38a@linaro.org>
 <20230313235550.zo243m5qn23yadey@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230313235550.zo243m5qn23yadey@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 00:55, Marijn Suijten wrote:
> On 2023-03-07 14:01:42, Konrad Dybcio wrote:
>> Some structs were defined multiple times for no apparent reason.
>> Deduplicate them.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Seems a bit inconsistent to name some of these with their DSI host
> revision, and keep some named after the SoC.  Also in the name of
> msm_dsi_config.  Regardless:
> 
> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
I think it's a good indicator of whether it's shared or used
by just one platform. Truth be told, some of the entries *are*
actually SoC-specific (think 8996 and its magic MMAGIC additions)

Konrad

> 
>> ---
>>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 77 +++++++++++++--------------------------
>>  1 file changed, 26 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> index 6c192963c100..d39521850018 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> @@ -47,41 +47,32 @@ static const struct msm_dsi_config msm8974_apq8084_dsi_cfg = {
>>  	},
>>  };
>>  
>> -static const char * const dsi_8916_bus_clk_names[] = {
>> +static const char * const dsi_v1_3_1_clk_names[] = {
>>  	"mdp_core", "iface", "bus",
>>  };
>>  
>> -static const struct regulator_bulk_data msm8916_dsi_regulators[] = {
>> +static const struct regulator_bulk_data dsi_v1_3_1_regulators[] = {
>>  	{ .supply = "vdda", .init_load_uA = 100000 },	/* 1.2 V */
>>  	{ .supply = "vddio", .init_load_uA = 100000 },	/* 1.8 V */
>>  };
>>  
>>  static const struct msm_dsi_config msm8916_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>> -	.regulator_data = msm8916_dsi_regulators,
>> -	.num_regulators = ARRAY_SIZE(msm8916_dsi_regulators),
>> -	.bus_clk_names = dsi_8916_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_8916_bus_clk_names),
>> +	.regulator_data = dsi_v1_3_1_regulators,
>> +	.num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
>> +	.bus_clk_names = dsi_v1_3_1_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
>>  	.io_start = {
>>  		{ 0x1a98000 },
>>  	},
>>  };
>>  
>> -static const char * const dsi_8976_bus_clk_names[] = {
>> -	"mdp_core", "iface", "bus",
>> -};
>> -
>> -static const struct regulator_bulk_data msm8976_dsi_regulators[] = {
>> -	{ .supply = "vdda", .init_load_uA = 100000 },	/* 1.2 V */
>> -	{ .supply = "vddio", .init_load_uA = 100000 },	/* 1.8 V */
>> -};
>> -
>>  static const struct msm_dsi_config msm8976_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>> -	.regulator_data = msm8976_dsi_regulators,
>> -	.num_regulators = ARRAY_SIZE(msm8976_dsi_regulators),
>> -	.bus_clk_names = dsi_8976_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_8976_bus_clk_names),
>> +	.regulator_data = dsi_v1_3_1_regulators,
>> +	.num_regulators = ARRAY_SIZE(dsi_v1_3_1_regulators),
>> +	.bus_clk_names = dsi_v1_3_1_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v1_3_1_clk_names),
>>  	.io_start = {
>>  		{ 0x1a94000, 0x1a96000 },
>>  	},
>> @@ -107,10 +98,6 @@ static const struct msm_dsi_config msm8994_dsi_cfg = {
>>  	},
>>  };
>>  
>> -static const char * const dsi_8996_bus_clk_names[] = {
>> -	"mdp_core", "iface", "bus", "core_mmss",
>> -};
>> -
>>  static const struct regulator_bulk_data msm8996_dsi_regulators[] = {
>>  	{ .supply = "vdda", .init_load_uA = 18160 },	/* 1.25 V */
>>  	{ .supply = "vcca", .init_load_uA = 17000 },	/* 0.925 V */
>> @@ -121,8 +108,8 @@ static const struct msm_dsi_config msm8996_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>>  	.regulator_data = msm8996_dsi_regulators,
>>  	.num_regulators = ARRAY_SIZE(msm8996_dsi_regulators),
>> -	.bus_clk_names = dsi_8996_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_8996_bus_clk_names),
>> +	.bus_clk_names = dsi_6g_bus_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_6g_bus_clk_names),
>>  	.io_start = {
>>  		{ 0x994000, 0x996000 },
>>  	},
>> @@ -167,24 +154,20 @@ static const struct msm_dsi_config sdm660_dsi_cfg = {
>>  	},
>>  };
>>  
>> -static const char * const dsi_sdm845_bus_clk_names[] = {
>> +static const char * const dsi_v2_4_clk_names[] = {
>>  	"iface", "bus",
>>  };
>>  
>> -static const char * const dsi_sc7180_bus_clk_names[] = {
>> -	"iface", "bus",
>> -};
>> -
>> -static const struct regulator_bulk_data sdm845_dsi_regulators[] = {
>> +static const struct regulator_bulk_data dsi_v2_4_regulators[] = {
>>  	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
>>  };
>>  
>>  static const struct msm_dsi_config sdm845_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>> -	.regulator_data = sdm845_dsi_regulators,
>> -	.num_regulators = ARRAY_SIZE(sdm845_dsi_regulators),
>> -	.bus_clk_names = dsi_sdm845_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>> +	.regulator_data = dsi_v2_4_regulators,
>> +	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
>> +	.bus_clk_names = dsi_v2_4_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>  	.io_start = {
>>  		{ 0xae94000, 0xae96000 },
>>  	},
>> @@ -198,32 +181,24 @@ static const struct msm_dsi_config sm8550_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>>  	.regulator_data = sm8550_dsi_regulators,
>>  	.num_regulators = ARRAY_SIZE(sm8550_dsi_regulators),
>> -	.bus_clk_names = dsi_sdm845_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_sdm845_bus_clk_names),
>> +	.bus_clk_names = dsi_v2_4_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>  	.io_start = {
>>  		{ 0xae94000, 0xae96000 },
>>  	},
>>  };
>>  
>> -static const struct regulator_bulk_data sc7180_dsi_regulators[] = {
>> -	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
>> -};
>> -
>>  static const struct msm_dsi_config sc7180_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>> -	.regulator_data = sc7180_dsi_regulators,
>> -	.num_regulators = ARRAY_SIZE(sc7180_dsi_regulators),
>> -	.bus_clk_names = dsi_sc7180_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_sc7180_bus_clk_names),
>> +	.regulator_data = dsi_v2_4_regulators,
>> +	.num_regulators = ARRAY_SIZE(dsi_v2_4_regulators),
>> +	.bus_clk_names = dsi_v2_4_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>  	.io_start = {
>>  		{ 0xae94000 },
>>  	},
>>  };
>>  
>> -static const char * const dsi_sc7280_bus_clk_names[] = {
>> -	"iface", "bus",
>> -};
>> -
>>  static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
>>  	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
>>  };
>> @@ -232,8 +207,8 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>>  	.io_offset = DSI_6G_REG_SHIFT,
>>  	.regulator_data = sc7280_dsi_regulators,
>>  	.num_regulators = ARRAY_SIZE(sc7280_dsi_regulators),
>> -	.bus_clk_names = dsi_sc7280_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_sc7280_bus_clk_names),
>> +	.bus_clk_names = dsi_v2_4_clk_names,
>> +	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>  	.io_start = {
>>  		{ 0xae94000, 0xae96000 },
>>  	},
>>
>> -- 
>> 2.39.2
>>
