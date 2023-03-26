Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555D06C969C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjCZQFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjCZQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:04:51 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37FF4229
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:04:22 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so26277802edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679846661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qlCkeJgW3mVdh/0eT8pyaphF08RZSTIB3iRCwBVYpLw=;
        b=G3rzxWZpyXJuLljg3vzsoZBHx+KC0mggEg9XPc0IEsVnjlCZRfV76nppFwg7LMsTFt
         4l61aom9HRVJiYTQNGR5ZJsVdfwXRHl4pQMiOvfSxHoWimrs9HTQWq47voCv/KUVg2gE
         leeLiGlGByE491CHvwxrPmuz9BGRpz6f9lxJm0rGN4OLpAHDMcem9byC+NQIZioZ/TkM
         MryXd/ercqgUzCWfoKS70M+z8QsCy8pFMmbBQrk6GlLBOTRDtd9SZ69OUX7NSGxU27Sr
         RHoujmEviOi9MakYbmJlzeshsj5QMNB9jXmq9kCdN2Z1RBq5SgfnJpSOpKc+Q3aIWuZ9
         PDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlCkeJgW3mVdh/0eT8pyaphF08RZSTIB3iRCwBVYpLw=;
        b=L7MVJycR45PMKOgEQv4xO8Fby3BiiDAYXQd0OYN3uRUzawiKnB07ApkWLohVa1eN7R
         d77aW5fHI/+AhKnH8PwsH4aLywYFPx5g4VsP7j2IMcuYBWmObCe33wO79C5g7w2b8ywb
         FEhpA/hHxHxu1HXsM0oz8IdmtwPph0ARhkWc5omGKhOrKHE7DjGS2ke6y/WKPyKUnRS8
         f9C8XkJODuHfOVqogBxmb+0H7SA258cF2RbMlQ2+HoG5doUJEii2chYHra30T6GYVbhe
         79ICyo6O260gEkZryXeqsnCUDRklXKYl1LmRMp0i+FN9Z3/lwykj5nMSYtptQr1Ow4yS
         S3qg==
X-Gm-Message-State: AO0yUKW+u0WC9z3//KqJySAOftwK5w7EHAAtSSCQ8I8Kgzonk7TXRakm
        5xhXDulZVkqWw/hyObFeVA6BWw==
X-Google-Smtp-Source: AK7set9rWPLBX9fuj2+oYAYrlmSCGKLQh1+m2VEKnNQWXSSpm8ulEDCe6we5h+Xa6nQ1ObV+tRWTmA==
X-Received: by 2002:a05:6402:944:b0:4ad:f811:e267 with SMTP id h4-20020a056402094400b004adf811e267mr15670897edz.12.1679846660905;
        Sun, 26 Mar 2023 09:04:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669? ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id kg6-20020a17090776e600b008b904cb2bcdsm13222129ejc.11.2023.03.26.09.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 09:04:20 -0700 (PDT)
Message-ID: <80e9a424-1d5b-5402-4567-c489204869b6@linaro.org>
Date:   Sun, 26 Mar 2023 18:04:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Alex Elder <elder@ieee.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324201528.2540564-1-elder@linaro.org>
 <20230324201528.2540564-2-elder@linaro.org>
 <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
 <82797190-5a83-53d5-47cd-0c62b3f7c6d8@ieee.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <82797190-5a83-53d5-47cd-0c62b3f7c6d8@ieee.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 18:01, Alex Elder wrote:
> On 3/25/23 6:14 AM, Krzysztof Kozlowski wrote:
>> On 24/03/2023 21:15, Alex Elder wrote:
>>> Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
>>> nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.
>>>
>>> Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
>>> Zone on this platform.
>>>
>>> Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>> ---
>>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>>>   arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>>>   2 files changed, 43 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>> index ed98c83c141fc..72e25de0db5fc 100644
>>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>>>   	status = "okay";
>>>   };
>>>   
>>> +&ipa {
>>> +	qcom,gsi-loader = "skip";
>>> +	status = "okay";
>>> +};
>>> +
>>>   &qpic_bam {
>>>   	status = "okay";
>>>   };
>>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> index 192f9f94bc8b4..360d6dc144811 100644
>>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>> @@ -11,6 +11,7 @@
>>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>>>   
>>>   / {
>>>   	#address-cells = <1>;
>>> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>>>   			#hwlock-cells = <1>;
>>>   		};
>>>   
>>> +		ipa: ipa@3e04000 {
>>> +			compatible = "qcom,sdx65-ipa";
>>> +
>>> +			iommus = <&apps_smmu 0x5e0 0x0>,
>>> +				 <&apps_smmu 0x5e2 0x0>;
>>> +			reg = <0x3f40000 0x10000>,
>>> +			      <0x3f50000 0x5000>,
>>> +			      <0x3e04000 0xfc000>;
>>> +			reg-names = "ipa-reg",
>>> +				    "ipa-shared",
>>> +				    "gsi";
>>> +
>>> +			interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
>>> +					      <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
>>> +					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>>> +					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>>> +			interrupt-names = "ipa",
>>> +					   "gsi",
>>> +					   "ipa-clock-query",
>>> +					   "ipa-setup-ready";
>>
>> These look misaligned.
> 
> I believe this is the alignment convention used by all IPA nodes
> in DTS files.  It's possible I'm not seeing something you are,
> but...  what alignment should be used?  And if I change this,
> should I change all others?

If this is aligned, then fine. The diff points it is not, but the diff
might be a bit tricky sometimes.

Alignment is till " in previous line. For example sdm845 looks fine.


Best regards,
Krzysztof

