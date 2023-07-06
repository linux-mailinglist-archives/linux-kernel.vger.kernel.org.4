Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F30749A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjGFLAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGFLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:00:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C7A10C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:00:03 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f954d7309fso672937e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688641201; x=1691233201;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIw6Fh9Mzt0uuZnHYmQ6kni+b2Er6GLAtWhId9yQcDE=;
        b=WKVo/plSKMi13tRj/JX9hrD0Ny1/RzNyA9DJEu7sJqN92ZK/+XXOVe3Y2N/sf09N76
         /lbFYd/kfRn/rDvlUrNaE2cROLYFpmiStxAx8jy4w/V8OhJzMuTGCpPOH+mRP+0pGOvT
         HOAfJwfBITqVe/BwmL7KhRaty++mQQLZnP9sEsBCBxhXbaSryovAJ5L+KntqVC0iuexR
         GKbAqP/vBASQTxjbL4KoeQAkrpoiksVWDEqr3HClCGSR45sq4/5uEdTbU8BFGfzlPdkW
         OYIaug2eQKkPCSApWswUJ6vK6bu0/OpZH4BhkEMZriJxkyQPj1Oi6Nv/EsZI8PSEhfU8
         8V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688641201; x=1691233201;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIw6Fh9Mzt0uuZnHYmQ6kni+b2Er6GLAtWhId9yQcDE=;
        b=QzuqZ37c4TL9iYeW1Ae7gDxyLMoqzSK6HGpsJ2w/rb7McQp2Ya5c0LADsBAyEgUD36
         BCjY6WyyFl2Uk+KoDQJOiMGdAE8BpwMPnHHTDUno85o5ls9vuRiUGCi+TwIdxnNUvWPX
         Ak1yo9igBn+CA3jVGh2x/yIq4T7JdIrb8gT2W+ls4ihtueH8YzAAT/9qO3XvZlJUYMvG
         uq46SXqDhMHhMtlzVhh3O9MBK7dKP60JwWXPIL7T7IbUm4nDGzV5c43xSdE2ZLykAEI8
         e8gx3AKwW8nLm4hen4wlwIlWscvMx8ddhLoUnYGVeIr8b7UFVf9h9/0/sidVrn1yXP+a
         qHbg==
X-Gm-Message-State: ABy/qLa5Me987gai6lixkvHJ7EBZxuSxyFJ056GcRPC2ymJBcPSR1R6C
        Z7o5NBTmNFOHwCozGV5p/4/2UQ==
X-Google-Smtp-Source: APBJJlEeR6VMWmejmvNVUZu+unOnt/o8L01nB45AxLDcceq0HjTX1E1PmEtdRuS8Nyp0f4jOGiHjvg==
X-Received: by 2002:a05:6512:10c3:b0:4f8:6253:540 with SMTP id k3-20020a05651210c300b004f862530540mr705957lfg.19.1688641201536;
        Thu, 06 Jul 2023 04:00:01 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id v12-20020ac2560c000000b004fb64600e5dsm201639lfd.219.2023.07.06.04.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 04:00:01 -0700 (PDT)
Message-ID: <7d335f1d-ef2c-ffe6-e364-c3dc47479929@linaro.org>
Date:   Thu, 6 Jul 2023 12:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230628092837.3090801-1-quic_imrashai@quicinc.com>
 <20230628092837.3090801-4-quic_imrashai@quicinc.com>
 <afde2981-3801-a93e-3cf2-2ab5d24ee3e1@linaro.org>
 <05f3459f-a2cd-3e4d-bbc6-f0109dbae778@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH V2 3/5] clk: qcom: gcc-qdu1000: Update GCC clocks as per
 the latest hw version
In-Reply-To: <05f3459f-a2cd-3e4d-bbc6-f0109dbae778@quicinc.com>
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

On 6.07.2023 12:51, Imran Shaik wrote:
> 
> 
> On 6/28/2023 4:36 PM, Konrad Dybcio wrote:
>> On 28.06.2023 11:28, Imran Shaik wrote:
>>> Add support for gcc_ddrss_ecpri_gsi_clk and update the GCC clkref clocks
>>> as per the latest hardware version of QDU1000 and QRU100 SoCs.
>>>
>>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>>> ---
[...]

>>>           .enable_reg = 0x9c004,
>>>           .enable_mask = BIT(0),
>>>           .hw.init = &(const struct clk_init_data) {
>>>               .name = "gcc_pcie_0_clkref_en",
>>> -            .ops = &clk_branch_ops,
>>> +            .ops = &clk_branch2_ops,
>> This sounds like a separate fix, clk_branch_ops seems to only concern
>> 10+yo chips.
>>
>> Konrad
> 
> Sure, will split this patch and push the next series.
One more nit, I noticed that a lot of QUIC folks respond to the comments
to their revision-N and send revision-(N+1) like 5 seconds later..

This maybe does not concern this message, as all you did is said "ok willfix",
but if you have some sort of a company-wide "upstream best practices" board,
you may add something like "wait a bit to let others respond to your email"

Konrad

> 
> Thanks,
> Imran
> 
>>>           },
>>>       },
>>>   };
>>> @@ -2274,14 +2293,13 @@ static struct clk_branch gcc_tsc_etu_clk = {
>>>     static struct clk_branch gcc_usb2_clkref_en = {
>>>       .halt_reg = 0x9c008,
>>> -    .halt_bit = 31,
>>> -    .halt_check = BRANCH_HALT_ENABLE,
>>> +    .halt_check = BRANCH_HALT,
>>>       .clkr = {
>>>           .enable_reg = 0x9c008,
>>>           .enable_mask = BIT(0),
>>>           .hw.init = &(const struct clk_init_data) {
>>>               .name = "gcc_usb2_clkref_en",
>>> -            .ops = &clk_branch_ops,
>>> +            .ops = &clk_branch2_ops,
>>>           },
>>>       },
>>>   };
>>> @@ -2523,6 +2541,8 @@ static struct clk_regmap *gcc_qdu1000_clocks[] = {
>>>       [GCC_AGGRE_NOC_ECPRI_GSI_CLK] = &gcc_aggre_noc_ecpri_gsi_clk.clkr,
>>>       [GCC_PCIE_0_PHY_AUX_CLK_SRC] = &gcc_pcie_0_phy_aux_clk_src.clkr,
>>>       [GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
>>> +    [GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
>>> +    [GCC_DDRSS_ECPRI_GSI_CLK] = &gcc_ddrss_ecpri_gsi_clk.clkr,
>>>   };
>>>     static const struct qcom_reset_map gcc_qdu1000_resets[] = {
