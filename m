Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8C7682CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjAaMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbjAaMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:38:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F794105
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:38:40 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qw12so25268051ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CAwB84/ZLTKABeybjLHE8x7NDspYcIkJgFYz/67K4gc=;
        b=chcRZipYoaLZqFyu8QtBoDIK4eDRDkKc87Ye/C504U3KX+pu3Rid+dR3sIfQCnnr1I
         k1p0K42YK3qTbpwcXzw0RVhXiN7vY5lDWp7mM3kHqFRO9zy+gbpUSYtNW2OfCQ4ya6V5
         ixAvVthPzBUZrDyDmq15ylsDPsfVeUHUSPcfIWXCwiKlnmkJhD3Mi9MgnTZY9hZT37lM
         UGgC/e5xNokrtn3rGoT05oj+Zo7ikaTppjSvS/7dEyZG3/Yk4c6qkxcSZBbKIvzcm+gm
         /VwTLbRB4aMChhmiJNo3tuZUoSqcA/IoHikVvTj5orSqfHjPXtc38mQqrWQKHSjxS9WC
         hTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAwB84/ZLTKABeybjLHE8x7NDspYcIkJgFYz/67K4gc=;
        b=A326XKGorYAd6FiWfkz7CoRqhkNJldPi9WD0t+1nS7uVS549Gwdo+jQkouoE2uAYJT
         o20aOls6SirWVwKnuv5PdAW2M8mLlpvpAeZ7pfYOPH3xVY6FtVAhYXdb4JpDYekJ9Cy5
         eA0323yKB3GHCFcbwI282ltyWBqkRBURAqpg4DAaim05Hs0gl+4kdJHEGcoxK1LuTt7I
         HKkfZKHj8IndS1Qen8mVDZM14GS2hGSkWKgnD9gUECxX0ms1zXiQ5ahGqTEAV+lwtike
         IOzbarpMKATlVVvJJ3gOVEDMJvgCv+UurqcfhkSrn9Alc8ePd/Nq2nOspR79CjHTtTSa
         PoIA==
X-Gm-Message-State: AO0yUKUua+0Pdv/ewzMcH2xka5316XK7FwgmQdcnYqcJV679XmHShlsw
        Ke/O3I6OwbEixee08ewuxm6b3w==
X-Google-Smtp-Source: AK7set//+6SOcbEvweNAhtm7cKrmpGTRGAFTiADDWw09PueMUKZRe3XT1Rbro1Vh+6lBe83Na++5PA==
X-Received: by 2002:a17:906:28d2:b0:87d:f29:3a14 with SMTP id p18-20020a17090628d200b0087d0f293a14mr15839280ejd.68.1675168719766;
        Tue, 31 Jan 2023 04:38:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id kv11-20020a17090778cb00b0088a2397cb2csm2310925ejc.143.2023.01.31.04.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:38:39 -0800 (PST)
Message-ID: <d5a37ebd-6614-be91-f500-46ba7be1bed6@linaro.org>
Date:   Tue, 31 Jan 2023 13:38:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 8/8] clk: qcom: Add GPU clock controller driver for
 SM6115
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230130235926.2419776-1-konrad.dybcio@linaro.org>
 <20230130235926.2419776-9-konrad.dybcio@linaro.org>
 <550dd5e8-6238-0e48-bac7-7c9b6e67cb00@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <550dd5e8-6238-0e48-bac7-7c9b6e67cb00@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2023 10:25, Dmitry Baryshkov wrote:
> On 31/01/2023 01:59, Konrad Dybcio wrote:
>> Add support for the GPU clock controller found on SM6115.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/clk/qcom/Kconfig        |   9 +
>>   drivers/clk/qcom/Makefile       |   1 +
>>   drivers/clk/qcom/gpucc-sm6115.c | 512 ++++++++++++++++++++++++++++++++
>>   3 files changed, 522 insertions(+)
>>   create mode 100644 drivers/clk/qcom/gpucc-sm6115.c
> 
> [skipped]
> 
>> +static int gpu_cc_sm6115_probe(struct platform_device *pdev)
>> +{
>> +    struct regmap *regmap;
>> +    unsigned int value, mask;
>> +
>> +    regmap = qcom_cc_map(pdev, &gpu_cc_sm6115_desc);
>> +    if (IS_ERR(regmap))
>> +        return PTR_ERR(regmap);
>> +
>> +    clk_alpha_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
>> +    clk_alpha_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
>> +
>> +    /* Recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
>> +    mask = CX_GMU_CBCR_WAKE_MASK << CX_GMU_CBCR_WAKE_SHIFT;
>> +    mask |= CX_GMU_CBCR_SLEEP_MASK << CX_GMU_CBCR_SLEEP_SHIFT;
>> +    value = 0xf << CX_GMU_CBCR_WAKE_SHIFT | 0xf << CX_GMU_CBCR_SLEEP_SHIFT;
>> +    regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, mask, value);
>> +
>> +    /* Set up PERIPH/MEM retain on the GPU core clock */
>> +    regmap_update_bits(regmap, gpu_cc_gx_gfx3d_clk.halt_reg,
>> +               (BIT(14) | BIT(13)), (BIT(14) | BIT(13)));
> 
> But you have your new helpers to set these values, don't you?
Welp, that's what I get for managing 3 almost-identical drivers
at once ;) Will fix.

Konrad
> 
>> +
>> +    return qcom_cc_really_probe(pdev, &gpu_cc_sm6115_desc, regmap);
>> +}
>> +
>> +static struct platform_driver gpu_cc_sm6115_driver = {
>> +    .probe = gpu_cc_sm6115_probe,
>> +    .driver = {
>> +        .name = "sm6115-gpucc",
>> +        .of_match_table = gpu_cc_sm6115_match_table,
>> +    },
>> +};
>> +module_platform_driver(gpu_cc_sm6115_driver);
>> +
>> +MODULE_DESCRIPTION("QTI GPU_CC SM6115 Driver");
>> +MODULE_LICENSE("GPL");
> 
