Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A26883B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBBQIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjBBQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:08:05 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5648A4A1F6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:07:56 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gr7so7348471ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ag2PAuDWK0xJDjx0Dz1G8siIr398zPG0JUR9wP2tdSM=;
        b=MAnvAtw0Mu7853Dl/ymO1cF1tA+56s2b2/PDyvZjGnne11RYR7UKNOa1YH2u9YoqDj
         pLSHn0ulZjrYHLm7BqzOFnweq14h4jc1qPRNZGGbcWaWfSS2bEQzchFeAUQMS9ie0/w2
         R/L4I9Lrd/zgo2S8PGbP1v7xPsUImVriky3PtZFOf6eKX6ehwGrya1zjSgNsNbBhKWsO
         TBfku3wZT8VXV/yKeRrXHfp/l4X26+iLUEqoNFurFUnx9CZpKSkHWZpE2SZt8GP6BWv4
         lL3qLtmv6xm5tLBdGgC8t+qopsmTxjLjHxi41pmCiz++thY/Bb3C6jRX2a31bcUIXGse
         LkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ag2PAuDWK0xJDjx0Dz1G8siIr398zPG0JUR9wP2tdSM=;
        b=uihycqYepWPwLh5Xj6X/E91kVmaf35PCFB2KeB7fhugbpIMFMD5mB6sPclCnB53/eR
         LMEhSAdwZo1pcX/pxjbTq863kyaKka2ERjGyA7ukJyuzCwWSG6ak4Ae2KJjmL8TSx/xh
         6Fzsi9hsyLYCsWQETcM+5RuMW/kfYDeifdXEy6xK2uItAK5tcer/Kbh8JXVoQbUCTGfs
         b7p0RA3EffYdwz5j6K5qmt240NzsRqfYREfinA1XGw3WfMrozU7iyoBIhvTkcl06P5ss
         hf3DprMRQPL+NSVRNwi57mhAv6Rc9DYSpF7/vYD+duiUNvl4i8Lxj60gkDlOFTzGwwYh
         lO1Q==
X-Gm-Message-State: AO0yUKUEnhgjf2ftLrMis/CXVDQI+29RQypZNazUBber7llR97v/TTPH
        Nek2H50djd2jg/r1pFMhTRBTR/2Y2x/GN+UP
X-Google-Smtp-Source: AK7set8ZhNHF5l0Xm2gmRt/hHGJJPQI3vwqC/Jr1DB7im2azln99tAWGaeWuwEWrOU6K856BNR2Txw==
X-Received: by 2002:a17:906:bc8d:b0:88a:a335:4921 with SMTP id lv13-20020a170906bc8d00b0088aa3354921mr7656976ejb.56.1675353408739;
        Thu, 02 Feb 2023 07:56:48 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id h11-20020aa7de0b000000b004a21304f5a0sm9632443edv.72.2023.02.02.07.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:56:48 -0800 (PST)
Message-ID: <1948642d-dab9-4f20-9408-de7c952b9109@linaro.org>
Date:   Thu, 2 Feb 2023 16:56:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/6] clk: qcom: apss-ipq-pll: refactor the driver to
 accommodate different PLL types
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202145208.2328032-1-quic_kathirav@quicinc.com>
 <20230202145208.2328032-2-quic_kathirav@quicinc.com>
 <97e9ae36-6736-0db8-4044-4e874c5af5f4@linaro.org>
 <9ebaa72c-e4d5-ddb4-9d3c-f0d669465991@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9ebaa72c-e4d5-ddb4-9d3c-f0d669465991@quicinc.com>
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



On 2.02.2023 16:37, Kathiravan T wrote:
> 
> On 2/2/2023 8:45 PM, Konrad Dybcio wrote:
>>
>> On 2.02.2023 15:52, Kathiravan T wrote:
>>> APSS PLL found on the IPQ8074 and IPQ6018 are of type Huayra PLL. But,
>>> IPQ5332 APSS PLL is of type Stromer Plus. To accommodate both these PLLs,
>>> refactor the driver to take the clk_alpha_pll, alpha_pll_config via device
>>> data.
>>>
>>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>>> ---
>>>   drivers/clk/qcom/apss-ipq-pll.c | 55 +++++++++++++++++++++------------
>>>   1 file changed, 36 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
>>> index a5aea27eb867..6e815e8b7fe4 100644
>>> --- a/drivers/clk/qcom/apss-ipq-pll.c
>>> +++ b/drivers/clk/qcom/apss-ipq-pll.c
>>> @@ -8,20 +8,22 @@
>>>     #include "clk-alpha-pll.h"
>>>   -static const u8 ipq_pll_offsets[] = {
>>> -    [PLL_OFF_L_VAL] = 0x08,
>>> -    [PLL_OFF_ALPHA_VAL] = 0x10,
>>> -    [PLL_OFF_USER_CTL] = 0x18,
>>> -    [PLL_OFF_CONFIG_CTL] = 0x20,
>>> -    [PLL_OFF_CONFIG_CTL_U] = 0x24,
>>> -    [PLL_OFF_STATUS] = 0x28,
>>> -    [PLL_OFF_TEST_CTL] = 0x30,
>>> -    [PLL_OFF_TEST_CTL_U] = 0x34,
>>> +static const u8 ipq_pll_offsets[][PLL_OFF_MAX_REGS] = {
>>> +    [CLK_ALPHA_PLL_TYPE_HUAYRA] =  {
>> Is it really huayra? The definition in clk-alpha-pll.c is
>> different..
> 
> 
> As per the HW document, yes it is Huayra. When you say "different", I understand these offsets are not matching with the one in clk-alpha-pll.c right? I checked with the sub system owner and they said it is expected since these PLLs are specific to each subsystem(A53 and GCC), so the offsets are different.
Okay, that makes sense. Could you please leave a comment about this
in the code?

Konrad
> 
> 
> Thanks,
> 
> Kathiravan T.
> 
> 
>>
>>
>> Konrad
>>> +        [PLL_OFF_L_VAL] = 0x08,
>>> +        [PLL_OFF_ALPHA_VAL] = 0x10,
>>> +        [PLL_OFF_USER_CTL] = 0x18,
>>> +        [PLL_OFF_CONFIG_CTL] = 0x20,
>>> +        [PLL_OFF_CONFIG_CTL_U] = 0x24,
>>> +        [PLL_OFF_STATUS] = 0x28,
>>> +        [PLL_OFF_TEST_CTL] = 0x30,
>>> +        [PLL_OFF_TEST_CTL_U] = 0x34,
>>> +    },
>>>   };
>>>   -static struct clk_alpha_pll ipq_pll = {
>>> +static struct clk_alpha_pll ipq_pll_huayra = {
>>>       .offset = 0x0,
>>> -    .regs = ipq_pll_offsets,
>>> +    .regs = ipq_pll_offsets[CLK_ALPHA_PLL_TYPE_HUAYRA],
>>>       .flags = SUPPORTS_DYNAMIC_UPDATE,
>>>       .clkr = {
>>>           .enable_reg = 0x0,
>>> @@ -61,6 +63,21 @@ static const struct alpha_pll_config ipq8074_pll_config = {
>>>       .test_ctl_hi_val = 0x4000,
>>>   };
>>>   +struct apss_pll_data {
>>> +    struct clk_alpha_pll *pll;
>>> +    const struct alpha_pll_config *pll_config;
>>> +};
>>> +
>>> +static struct apss_pll_data ipq8074_pll_data = {
>>> +    .pll = &ipq_pll_huayra,
>>> +    .pll_config = &ipq8074_pll_config,
>>> +};
>>> +
>>> +static struct apss_pll_data ipq6018_pll_data = {
>>> +    .pll = &ipq_pll_huayra,
>>> +    .pll_config = &ipq6018_pll_config,
>>> +};
>>> +
>>>   static const struct regmap_config ipq_pll_regmap_config = {
>>>       .reg_bits        = 32,
>>>       .reg_stride        = 4,
>>> @@ -71,7 +88,7 @@ static const struct regmap_config ipq_pll_regmap_config = {
>>>     static int apss_ipq_pll_probe(struct platform_device *pdev)
>>>   {
>>> -    const struct alpha_pll_config *ipq_pll_config;
>>> +    const struct apss_pll_data *data;
>>>       struct device *dev = &pdev->dev;
>>>       struct regmap *regmap;
>>>       void __iomem *base;
>>> @@ -85,23 +102,23 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
>>>       if (IS_ERR(regmap))
>>>           return PTR_ERR(regmap);
>>>   -    ipq_pll_config = of_device_get_match_data(&pdev->dev);
>>> -    if (!ipq_pll_config)
>>> +    data = of_device_get_match_data(&pdev->dev);
>>> +    if (!data)
>>>           return -ENODEV;
>>>   -    clk_alpha_pll_configure(&ipq_pll, regmap, ipq_pll_config);
>>> +    clk_alpha_pll_configure(data->pll, regmap, data->pll_config);
>>>   -    ret = devm_clk_register_regmap(dev, &ipq_pll.clkr);
>>> +    ret = devm_clk_register_regmap(dev, &data->pll->clkr);
>>>       if (ret)
>>>           return ret;
>>>         return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
>>> -                       &ipq_pll.clkr.hw);
>>> +                       &data->pll->clkr.hw);
>>>   }
>>>     static const struct of_device_id apss_ipq_pll_match_table[] = {
>>> -    { .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
>>> -    { .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
>>> +    { .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_data },
>>> +    { .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_data },
>>>       { }
>>>   };
>>>   MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
