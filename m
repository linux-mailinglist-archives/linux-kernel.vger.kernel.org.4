Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65582682CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjAaMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjAaMiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:38:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385243EC63
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:38:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gr7so16570673ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKxbXbEULBKOHnps7S4m6S4/h0JUMvMF27+rV1zb/eY=;
        b=KoQK4BP+iUuerkkYupPQ6Mfvtfw+GCDZgMZNWp3fj+UhiBjoITRpmFXWpZIkOqIu3o
         Lc2EsgPGLh6reRhpPZY0PcmnKo2V5l2pcLIkTEXKZRWFBbaKBJBUy9uO+44HiqM1dIgt
         uJ8gqAa5NcErmSLuyDIPhKk3VLZQ7M+eCBFNN/OwqhBIdkUU0rzR24l6fgcZp6VhWsU0
         cBsEc7T5tmSExLTiC3LmqVuqvGqFAwG+EWBw9KEbP1xBWsra6fGUuQIYtnfeFPuDdi9n
         m2TMoX/uXM80Nva6rNxYmJcnoZ1dBNOrEur5JIhiPMmvi0IrJ9+/0d/Rl0aPR9Jv/Sch
         DMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKxbXbEULBKOHnps7S4m6S4/h0JUMvMF27+rV1zb/eY=;
        b=L8wVzQ7VD3f0FNDLCCk/RtzkGDe6jPCumO4VumTGKwRYcm2+xfKOzZPNwgp0957z7H
         NOUSBKfvlWVDYUdoS03qQ/HShqfUnSemRFStLVL334BPAG9za37Yf/n9mi4taXp6mGce
         OZ0dDFkrna6FQyZh1Opmj3kDzswO7i/O8FwcDOpVoH/k6vUHGOzX1xb++a2WCOP0C+s0
         8VEcOMlnEKMuQ0FA8Eph218UImr80cz+JBccMkNi9wzXptmYlIv7KXfhtzv5PmHzdRJ5
         F3GVOLeaXTf44YXLhYvZ6mKNYk21SXGjilQziWVOFRTTjDf0xwcAT+H+XRfcLReGNqKH
         vpsg==
X-Gm-Message-State: AO0yUKWLi1eXLKHLcvN+nEY2UgdfUY5PEoTOOjTggdBDdC6x6HGkj0V7
        Kkb8uS0zkWHGM6cwgp2lXgEyoA==
X-Google-Smtp-Source: AK7set+tpLdZpV3Lq1clFGcWzNITzxmhts98f/KIaiISBd86thLtpFk5vBVlowdEYD8yiRezgckW1Q==
X-Received: by 2002:a17:907:1c84:b0:889:b6ae:75fe with SMTP id nb4-20020a1709071c8400b00889b6ae75femr3706521ejc.61.1675168681710;
        Tue, 31 Jan 2023 04:38:01 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906a18900b0088519b92074sm4504437ejy.128.2023.01.31.04.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:38:01 -0800 (PST)
Message-ID: <8e11a80c-8056-e226-e051-c01b82f29d05@linaro.org>
Date:   Tue, 31 Jan 2023 13:37:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 4/8] clk: qcom: Add GPU clock controller driver for
 SM6125
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230130235926.2419776-1-konrad.dybcio@linaro.org>
 <20230130235926.2419776-5-konrad.dybcio@linaro.org>
 <ac2d458c-3cb9-9117-82ca-b025b92073df@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ac2d458c-3cb9-9117-82ca-b025b92073df@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2023 10:00, Dmitry Baryshkov wrote:
> On 31/01/2023 01:59, Konrad Dybcio wrote:
>> Add support for the GPU clock controller found on SM6125.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
[...]

>> +    /* Set recommended WAKEUP/SLEEP settings for the gpu_cc_cx_gmu_clk */
>> +    regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, CBCR_WAKEUP, 0xf);
>> +    regmap_update_bits(regmap, gpu_cc_cx_gmu_clk.clkr.enable_reg, CBCR_SLEEP, 0xf);
> 
> I think you have to use FIELD_PREP here. regmap_update_bits doesn't shift the value according to the mask, does it?
> 
You're right.

Konrad
>> +
>> +    qcom_branch_set_force_mem_core(regmap, gpu_cc_gx_gfx3d_clk.halt_reg, true);
>> +    qcom_branch_set_force_periph_on(regmap, gpu_cc_gx_gfx3d_clk.halt_reg, true);
>> +
>> +    return qcom_cc_really_probe(pdev, &gpu_cc_sm6125_desc, regmap);
>> +}
>> +
>> +static struct platform_driver gpu_cc_sm6125_driver = {
>> +    .probe = gpu_cc_sm6125_probe,
>> +    .driver = {
>> +        .name = "gpucc-sm6125",
>> +        .of_match_table = gpu_cc_sm6125_match_table,
>> +    },
>> +};
>> +module_platform_driver(gpu_cc_sm6125_driver);
>> +
>> +MODULE_DESCRIPTION("QTI GPUCC SM6125 Driver");
>> +MODULE_LICENSE("GPL");
> 
