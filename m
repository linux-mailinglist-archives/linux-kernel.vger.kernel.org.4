Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7046168CE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiKBQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiKBQ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:28:57 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF90DFF1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:24:52 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j6so12770911qvn.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tuoDnnVv76RyGEtzHMw//0KDleT7U6eMFG86EI/URpc=;
        b=Q8uIZ5gqMaQoPmhInawrziI+aObzfvod/P0ki9uNHkaYMiggqiYKtIH5UVGGbdw5fw
         GMJ35kWfPqUGigwxlhVKy/8WNyHCnuh1eXIk2y7Gzy+GiFvil+2o5quayd5OZWw1ntFM
         NnS6VYE9F/zxdxeNvc3EdbwHnRTgdTmjZ04rEZsvDuMriXN8XZMsF5wh5Yf7oSqT1nQo
         cR6JKfZtFrXxCrdYcR4JK/DewZqsqjLYB2EWKd5uktwXK3JXmMhCRjpZoQ8HMfVxCwDu
         iHQPPkjYhpK7H1tF0Iit4LxCM8YgppOsmoTNL3zfKffTqfFoCCC7liMUHwV2OqBxOd7a
         YRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuoDnnVv76RyGEtzHMw//0KDleT7U6eMFG86EI/URpc=;
        b=lpdVuCSdqmj0HjPQ9SrHUrecsQvoBIxtxcwBHV5Mdu1lgdAan+iLOfsAg1ocZ2aMhK
         mjz/jXp5apHBBjevbgiZbgxlZzvOrYnN+1jKyJJDlZmVEvlIA7odG+lI0GOay/7N0i1L
         iwKz66+17mdvtFCJdt4p2KnbFEA7ZAZjPTZRA+2SioeBjB6ZuKEfA6kokwJYrjnuik0C
         1kXTYe0T6SOG0spy+n5XSaNDCWdeB5mDtaSRRWLlmXMCYbhXrPMDLi8MLprmy6oFucx7
         NHZTA6Ihhrg2xclswSlgbjhVIA/gYFFfGjcjdiGvbwk0mDNNftE29ddwkt5WcZFYrTbp
         fH3w==
X-Gm-Message-State: ACrzQf2eCRYsEtaXcXOlVLWK83w6cYKOpWlqZfmekH+fW3SKnTtUHpYh
        4G4+BW9OYhTokuQuTde0zlxC7w==
X-Google-Smtp-Source: AMsMyM4zyn3gZcLVKtr11Kk1v4FVIyTwmw/ej5XrKzys8i6iKp6Jv77hCF3ggOpOKXs2+L2ZEMW/1Q==
X-Received: by 2002:a05:6214:2485:b0:4bb:68f6:afd3 with SMTP id gi5-20020a056214248500b004bb68f6afd3mr22083058qvb.1.1667406291858;
        Wed, 02 Nov 2022 09:24:51 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id t18-20020a05622a181200b003a527d29a41sm4311476qtc.75.2022.11.02.09.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 09:24:48 -0700 (PDT)
Message-ID: <9eaaf256-8de2-ddc9-ac95-aed9b0670f5e@linaro.org>
Date:   Wed, 2 Nov 2022 12:24:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: Add base QDU1000/QRU1000 DTSIs
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221026200429.162212-1-quic_molvera@quicinc.com>
 <20221026200429.162212-4-quic_molvera@quicinc.com>
 <ae4b2333-d243-17ee-1ebd-6b1c89eef9f3@linaro.org>
 <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d109cbdf-1b0e-ff67-879c-d0955da4898e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2022 17:49, Melody Olvera wrote:
> 
> 
> On 10/27/2022 8:21 AM, Krzysztof Kozlowski wrote:
>> On 26/10/2022 16:04, Melody Olvera wrote:
>>> Add the base DTSI files for QDU1000 and QRU1000 SoCs, including base
>>> descriptions of CPUs, GCC, RPMHCC, QUP, TLMM, and interrupt-controller
>>> to boot to shell with console on these SoCs.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1406 +++++++++++++++++++++++++
>> Please use scripts/get_maintainers.pl to get a list of necessary people
>> and lists to CC.  It might happen, that command when run on an older
>> kernel, gives you outdated entries.  Therefore please be sure you base
>> your patches on recent Linux kernel.
> Sure thing; we talked about this on a different patch.
>>
>>>  arch/arm64/boot/dts/qcom/qru1000.dtsi |   27 +
>>>  2 files changed, 1433 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qru1000.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>> new file mode 100644
>>> index 000000000000..76474106e931
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
>>> @@ -0,0 +1,1406 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>> (...)
>>
>>> +
>>> +	soc: soc@0 {
>>> +		#address-cells = <2>;
>>> +		#size-cells = <2>;
>>> +		ranges = <0 0 0 0 0x10 0>;
>>> +		dma-ranges = <0 0 0 0 0x10 0>;
>>> +		compatible = "simple-bus";
>>> +
>>> +		gcc: clock-controller@80000 {
>>> +			compatible = "qcom,gcc-qdu1000", "syscon";
>>> +			reg = <0x0 0x80000 0x0 0x1f4200>;
>>> +			#clock-cells = <1>;
>>> +			#reset-cells = <1>;
>>> +			#power-domain-cells = <1>;
>>> +			clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>>> +			clock-names = "bi_tcxo", "sleep_clk";
>>> +		};
>>> +
>>> +		gpi_dma0: dma-controller@900000  {
>>> +			compatible = "qcom,sm6350-gpi-dma";
>> You should add here a specific compatible as well. Same in other places.
>> All places. I had impression we talked about this few times, so I don't
>> know what is missing on your side.
>>
>> This must be:
>> "qcom,qdu1000-gpi-dma", "qcom,sm6350-gpi-dma"
> Got it. I talked to Stephan and he said either your suggestion or just using
> preexisting compatibles would be ok. I thought it might be cleaner to not
> have the qdu compats, but I'm fine either way.
>>
>>> +			#dma-cells = <3>;
>>> +			reg = <0x0 0x900000 0x0 0x60000>;
>>> +			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
>>> +				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
>>> +			dma-channels = <12>;
>>> +			dma-channel-mask = <0x3f>;
>>> +			iommus = <&apps_smmu 0xf6 0x0>;
>>> +		};
>>> +
>> (...)
>>
>>
>>> +
>>> +		tlmm: pinctrl@f000000 {
>>> +			compatible = "qcom,qdu1000-tlmm";
>>> +			reg = <0x0 0xf000000 0x0 0x1000000>;
>>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			interrupt-controller;
>>> +			#interrupt-cells = <2>;
>>> +			gpio-ranges = <&tlmm 0 0 151>;
>>> +			wakeup-parent = <&pdc>;
>>> +
>>> +			qup_uart0_default: qup-uart0-default-state {
>>> +				pins = "gpio6", "gpio7", "gpio8", "gpio9";
>>> +				function = "qup00";
>>> +			};
>>> +
>>> +			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
>>> +				pins = "gpio10", "gpio11";
>>> +				function = "qup01";
>>> +				drive-strength = <2>;
>> Can we have some generic agreement where to put drive-strengths and bias?
>>
>> See also:
>> https://lore.kernel.org/linux-devicetree/20221026200357.391635-2-krzysztof.kozlowski@linaro.org/
>>
>> https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
> Not sure how much two-sense I have for the conversation at large, but generally I agree with Doug's
> point in the first paragraph. Pulls for this soc are consistent across boards so I don't think it makes
> sense to move them to the board files here. I vote that these stay here.
>>

I would be great if Konrad and Bjorn shared their opinion on this... but
wait, you did not Cc all maintainers... Eh.

Best regards,
Krzysztof

