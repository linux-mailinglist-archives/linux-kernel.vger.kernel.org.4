Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D51F6C96A9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjCZQIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjCZQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:08:30 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8D46BB
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:08:28 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id j6so3440497ilr.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1679846907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmWU3HOEJbbXWYXoBYPRgRHzG+SKRTnqVA9N2/ofI1w=;
        b=Wg1QM8/YMpRaCJAOuR5alIpWbx1ppfnISy8H69O/NgeWor6SkELX53FXVONDqvbgaJ
         dvyYSRVBWRpSsU4Ng3rsEBIYRgiGJQ7cTWUVhcOsqPAueVjAUmrohSU8xzErX2+h/5V3
         BPkx7vDU8MmGMnyv6weBP7LGEQdPKDJZkR9BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmWU3HOEJbbXWYXoBYPRgRHzG+SKRTnqVA9N2/ofI1w=;
        b=zGgZlmKpZ+C/EN1ztaTWwLdzbGheShd5mVSRmXAWqfmL7MfNbG2YSwSUQMX+3gbWw6
         TIEo2CAxxyuJuKnC67b6n0nagkS+Emtu92yemSamR8W/nc2QrIqIfXRwMihjLFg5lerX
         3gRw0uMetnSOUNAIocKUpE3zi2vMtmWBCKD8u1mZgQOxi880Pir/Wnk4Cz57lE2o7l/h
         eix4nQDpd1+t4Cqpy/WHassUUvl/DeHbrDX9nz0x3zafk5s1HSJsf4KtKb0MvUUhlOtm
         GRxE4HyFGhnJuAkb4LDev23Q+40sbi87DtnRWT3Qzfak9Z+lzFIyXFGmFH7JRFM4P1z3
         VsAA==
X-Gm-Message-State: AAQBX9cheJ8LwzFDmn3gQeU1FT13SRDEq4S/WC6jB7oU2gidLKgRMp9Q
        x8ZYIyIe3+k9kZgHm9YY1QGZrw==
X-Google-Smtp-Source: AKy350aARNmNflI3UCZ68ajxhsC+vG7Qt5H0cyHaRefnTQANxcoOs7ReJ3N0PLwHez+XrcbZplDziQ==
X-Received: by 2002:a92:dd03:0:b0:316:e6e4:570b with SMTP id n3-20020a92dd03000000b00316e6e4570bmr6771010ilm.11.1679846907463;
        Sun, 26 Mar 2023 09:08:27 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id f15-20020a056e0212af00b00313fa733bcasm7294385ilr.25.2023.03.26.09.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 09:08:26 -0700 (PDT)
Message-ID: <a7d15a55-131a-4edb-8ace-2e35d3488ae8@ieee.org>
Date:   Sun, 26 Mar 2023 11:08:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
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
 <80e9a424-1d5b-5402-4567-c489204869b6@linaro.org>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <80e9a424-1d5b-5402-4567-c489204869b6@linaro.org>
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

On 3/26/23 11:04 AM, Krzysztof Kozlowski wrote:
> On 26/03/2023 18:01, Alex Elder wrote:
>> On 3/25/23 6:14 AM, Krzysztof Kozlowski wrote:
>>> On 24/03/2023 21:15, Alex Elder wrote:
>>>> Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
>>>> nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.
>>>>
>>>> Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
>>>> Zone on this platform.
>>>>
>>>> Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> Signed-off-by: Alex Elder <elder@linaro.org>
>>>> ---
>>>>    arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>>>>    arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>>>>    2 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> index ed98c83c141fc..72e25de0db5fc 100644
>>>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>>>> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>>>>    	status = "okay";
>>>>    };
>>>>    
>>>> +&ipa {
>>>> +	qcom,gsi-loader = "skip";
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>>    &qpic_bam {
>>>>    	status = "okay";
>>>>    };
>>>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> index 192f9f94bc8b4..360d6dc144811 100644
>>>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>>>> @@ -11,6 +11,7 @@
>>>>    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>>    #include <dt-bindings/power/qcom-rpmpd.h>
>>>>    #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>>> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>>>>    
>>>>    / {
>>>>    	#address-cells = <1>;
>>>> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>>>>    			#hwlock-cells = <1>;
>>>>    		};
>>>>    
>>>> +		ipa: ipa@3e04000 {
>>>> +			compatible = "qcom,sdx65-ipa";
>>>> +
>>>> +			iommus = <&apps_smmu 0x5e0 0x0>,
>>>> +				 <&apps_smmu 0x5e2 0x0>;
>>>> +			reg = <0x3f40000 0x10000>,
>>>> +			      <0x3f50000 0x5000>,
>>>> +			      <0x3e04000 0xfc000>;
>>>> +			reg-names = "ipa-reg",
>>>> +				    "ipa-shared",
>>>> +				    "gsi";
>>>> +
>>>> +			interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
>>>> +					      <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
>>>> +					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>>>> +					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>>>> +			interrupt-names = "ipa",
>>>> +					   "gsi",
>>>> +					   "ipa-clock-query",
>>>> +					   "ipa-setup-ready";
>>>
>>> These look misaligned.
>>
>> I believe this is the alignment convention used by all IPA nodes
>> in DTS files.  It's possible I'm not seeing something you are,
>> but...  what alignment should be used?  And if I change this,
>> should I change all others?
> 
> If this is aligned, then fine. The diff points it is not, but the diff
> might be a bit tricky sometimes.
> 
> Alignment is till " in previous line. For example sdm845 looks fine.

OK thank you.  I will send v2 of this series after I hear back
from Konrad, adding your reviewed-by, and will double-check
the alignment as well.

					-Alex

> 
> 
> Best regards,
> Krzysztof
> 

