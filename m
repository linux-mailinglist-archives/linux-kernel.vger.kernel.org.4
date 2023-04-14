Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320076E21DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDNLOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjDNLOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:14:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A717D91
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:14:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d4so2436825lfv.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681470869; x=1684062869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCP7uzKaaXleul1h5NRBOZWggdFvVQLh2PRTfUPevlE=;
        b=Gw3JIq4TwS0OyaLLlVhQvleKAT9sqOlR4KMCDgysvcwqABawxcrMqBBPsDvQs1EsV3
         uRUJagqlukaa450ApAzeU/FHNh9j8unNCdRy1A8cos+8+xQkZQsvgs0zDcFnIUoYh0MK
         L/WOUBDH8yWGQ07lwd5H7TTKB/FLjbbOpXIQ9Ueu4L41t7Tzj5UDMXVFLXE0NryeCGF3
         P83Dqx0N5ukMFL0VnA2E9lebMqaHYxJCtRCkdKZF0ooEy6otekV+Vtnw+kO7dEnCW4Bl
         CFyhzNsWvVogWqXdOQZZiHrPcDblxVLanih+UL3Lrn4RQe72uijpZPBQjI+vQN47TLau
         /ERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470869; x=1684062869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCP7uzKaaXleul1h5NRBOZWggdFvVQLh2PRTfUPevlE=;
        b=YAuyoYPambhTTLwT0bZBcrSziKV8awh52ynQ+5PG/vJ6V1hRxcWBFi+gGTixVM7mR+
         QocnTJOBH/NNyIFE7M6KYC1VEcMN2HHvNLN/5weO4rldJLFEPL+Avpnsy5Fakx9qHai9
         MV28HtlHSMACZL6yxLcCpgu0Ffo+bM5nBwAh2GQxwR9AzgZf9EKdmhKQk/Sbq1qGZIIP
         mOnzit4OdDuzdtsrbMVsWzxsHCcPW2n28/PYJib28tRVJURkm/3nVRv3RGZ1jTzcM7WV
         4KOmF7o9BBYF4fxX8MoxI3rZN3XZYkOfWiSwP5M4kk5/9URZsBmicsKy/tK2z7M9g82E
         FciQ==
X-Gm-Message-State: AAQBX9e6weG5sVovElK2uBiS2oy9SwyQ+uP4+kl0oYCrtXC0wWLuu5O/
        y6tM+wV3EZrqWQIygmH0VFtm7w==
X-Google-Smtp-Source: AKy350ajyGff4BJxFlWFmId+REsisaKxDZG769Bylihlkj2zyBBIT3FFRpKGAq2lR2JQOi9b9OddGA==
X-Received: by 2002:ac2:442c:0:b0:4e0:ff8e:bbfe with SMTP id w12-20020ac2442c000000b004e0ff8ebbfemr1673450lfl.12.1681470869249;
        Fri, 14 Apr 2023 04:14:29 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id b14-20020ac2562e000000b004b57bbaef87sm741584lff.224.2023.04.14.04.14.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 04:14:28 -0700 (PDT)
Message-ID: <232e1687-7ad3-3cf9-1f0f-811e7d87b740@linaro.org>
Date:   Fri, 14 Apr 2023 13:14:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/2] clk: qcom: Introduce SM8350 VIDEOCC
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org>
 <20230413-topic-lahaina_vidcc-v1-2-134f9b22a5b3@linaro.org>
 <2f955dc3105570df0acc2695739183ed.sboyd@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2f955dc3105570df0acc2695739183ed.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.04.2023 21:04, Stephen Boyd wrote:
> Quoting Konrad Dybcio (2023-04-13 11:44:59)
>> diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc-sm8350.c
>> new file mode 100644
>> index 000000000000..186a5bd9e184
>> --- /dev/null
>> +++ b/drivers/clk/qcom/videocc-sm8350.c
>> @@ -0,0 +1,575 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Linaro Limited
>> + */
>> +

[...]

>> +enum {
>> +       P_BI_TCXO,
>> +       P_BI_TCXO_AO,
>> +       P_SLEEP_CLK,
>> +       P_VIDEO_PLL0_OUT_MAIN,
>> +       P_VIDEO_PLL1_OUT_MAIN,
>> +};
>> +
>> +static struct pll_vco lucid_5lpe_vco[] = {
> 
> const
> 
>> +       { 249600000, 1750000000, 0 },
>> +};
>> +
[...]

>> +static struct clk_alpha_pll video_pll0 = {
>> +       .offset = 0x42c,
>> +       .vco_table = lucid_5lpe_vco,
>> +       .num_vco = ARRAY_SIZE(lucid_5lpe_vco),
>> +       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
>> +       .clkr = {
>> +               .hw.init = &(struct clk_init_data){
> 
> const
Ack to both

[...]
>> +
>> +static int video_cc_sm8350_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
>> +       int ret;
>> +
>> +       pm_runtime_enable(&pdev->dev);
>> +
>> +       ret = devm_add_action_or_reset(&pdev->dev, video_cc_sm8350_pm_runtime_disable, &pdev->dev);
> 
> devm_pm_runtime_enable()?
Right.

Konrad
> 
>> +       if (ret)
>> +               return ret;
>> +
