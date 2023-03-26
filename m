Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7218A6C96A1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjCZQGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjCZQEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:04:53 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD864ED1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:04:26 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h7so3442806ila.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1679846665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLUV32TFJ1PBsRP4JRwHZ1TsUoT8zxPU9gMsdTVjtMI=;
        b=OtD/D0AhwXys72VxWf5Pa7p27bCAloMtPV/TlsO+HLfyaee80Lvpgnb4rJWR6EyxUp
         DQMJ4cVz8I7w1VqnjH4bQijDRTy7bW4P60WkmPgdxQRm5CLbJVyBDfdawlxARm3qsw5/
         4jA6N8V9eDWFd8DyzMTKQwU/esRetldF2ax58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLUV32TFJ1PBsRP4JRwHZ1TsUoT8zxPU9gMsdTVjtMI=;
        b=WBMW/9H6lvdJncCZxb1PPMFS/CBhNvCwZ58zTYyaexQIPPDyoK/6r9RpnL4NgKJwzU
         KuRFlcJbCe0oY1ryfTgeSU3To1N0vuxoevSiiDAvdRVKf+uLgokzUI3rmo6IjykjPdf8
         AU9GDSqByX+YvEJT3deXjKHGsT7K/4C80+H7MI6RTZkOetfpBio4SlNyaQhqhPyiAPVo
         iZbIfFZOmLBohpexGJ2EwlQIOjAHqXLfhi+vAA08t7QaYx3ooj7RwUxyRCdRWDxXVSmS
         CXQyCW3FQEBWLmP9DG2TSVWZqCOKVcgDCnjtEH4uuZOG8P6/47TQp+6yTxn9/uHGx/pv
         ibhw==
X-Gm-Message-State: AAQBX9dT8HbZn6Gdzovb6Z/RT/PXvqIdyAaARtJ1AKfb+ZZZosAlODfe
        v/dE0A2lBTlvHqCQfWAP1RMqBg==
X-Google-Smtp-Source: AKy350YT5l7cjYXaNvQzx6EZReyPIuE1rGnu4arDQ3k/L9D77LZfGAtDrGEM+GG5dwc+svYj+0/6eg==
X-Received: by 2002:a92:c688:0:b0:315:3d99:bbd3 with SMTP id o8-20020a92c688000000b003153d99bbd3mr7262477ilg.8.1679846664942;
        Sun, 26 Mar 2023 09:04:24 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id q3-20020a5e9403000000b007594a835232sm2092375ioj.13.2023.03.26.09.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 09:04:24 -0700 (PDT)
Message-ID: <5f825218-c583-7ccd-6845-684a4b166abe@ieee.org>
Date:   Sun, 26 Mar 2023 11:04:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alex Elder <elder@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
        agross@kernel.org
Cc:     quic_rohiagar@quicinc.com, caleb.connolly@linaro.org,
        mka@chromium.org, evgreen@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230324201528.2540564-1-elder@linaro.org>
 <20230324201528.2540564-2-elder@linaro.org>
 <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
 <f600869e-0fd8-ca19-1baf-d23f7a9103d6@linaro.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <f600869e-0fd8-ca19-1baf-d23f7a9103d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 7:12 AM, Konrad Dybcio wrote:
> 
> 
> On 25.03.2023 12:14, Krzysztof Kozlowski wrote:
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
>>
>> With above:
>>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> With this and moving iommus below interconnect:

Is there guidance somewhere that states what order should be
used for these properties?  Why should iommus be below
interconnects?

As I said to Krzysztof, I *think* all of the IPA nodes look
like this; should all of them be updated to follow whatever
the preferred convention is?

Thanks.

					-Alex


> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
>>
>>
>> Best regards,
>> Krzysztof
>>

