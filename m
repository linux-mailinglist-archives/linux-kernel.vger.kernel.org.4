Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF056C9681
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjCZQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 12:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbjCZQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 12:01:42 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33B1FDD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:01:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id v5so874648ilj.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1679846500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBPQLVtRTjnAB/29HPxS5lW1N6PezRYFN9fRXipj1zY=;
        b=IGiB34vS5/NFCzkvrmmpWV1FXCX+vcbSUvukf//Yrmo/w3xr/brxT0aFRfmBytJu2z
         kWIn6H8dJC70+I4IScmGl/qhoLj/fBTIqQ/JmSeQc8s4/s9qg8UkMfxyCB+Do8LVoiVw
         8xoWLQBGWJIFWiHpnh6FqD07ADlAwtc94RQzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679846500;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBPQLVtRTjnAB/29HPxS5lW1N6PezRYFN9fRXipj1zY=;
        b=ruwub71Sd+xR9mMLGjPgHvDuFo1LH7pD0IqFmwtFVHbDLJK0969rf/zrX+MHfSuPsA
         1dRw8bAPidQqCx6utEtWnRsc0NqDhdzORQXl0qSg6uWjOCs5Xk8VzUdNpUTWDU5xK/Ef
         7tsLGsuozEJiWyAKzqf+dRpDRW0hC4aiD40GYnHwAMIzCBqru7RV7wFjeYkjd5OuVloH
         0A5mJS0fIZEgopgNdZhWeCCpO9Ss2roPlgVO3DJpWhCeIT8R1qfZExvKu1Xs7xFzZwUW
         gA4JnwjBHRQKANW5Mp9tgrjjybpac5/OM4susszim9dXlCKMOX8L37m/7xx2HoEmTmZU
         tygA==
X-Gm-Message-State: AAQBX9cZFByL7jexKmWu8CzJIVI02uyRdWXTH6m24omaioLpRgKzCzHZ
        yN99erHJQ5g2klbMtF0FZzx33A==
X-Google-Smtp-Source: AKy350aLi64HPF8IBNKNRoN2sbu8nNmpTqSJGlkD+X2Ash8ZjrX46m9n39Dwzfnepb6tUXXwstAZtA==
X-Received: by 2002:a92:c107:0:b0:323:338:cc3c with SMTP id p7-20020a92c107000000b003230338cc3cmr7123936ile.6.1679846499674;
        Sun, 26 Mar 2023 09:01:39 -0700 (PDT)
Received: from [10.211.55.3] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id b19-20020a92a053000000b00325db2dcb9dsm1976157ilm.4.2023.03.26.09.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 09:01:39 -0700 (PDT)
Message-ID: <82797190-5a83-53d5-47cd-0c62b3f7c6d8@ieee.org>
Date:   Sun, 26 Mar 2023 11:01:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
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

On 3/25/23 6:14 AM, Krzysztof Kozlowski wrote:
> On 24/03/2023 21:15, Alex Elder wrote:
>> Add IPA-related nodes and definitions to "sdx65.dtsi".  The SMP2P
>> nodes (ipa_smp2p_out and ipa_smp2p_in) are already present.
>>
>> Enable IPA in "sdx65-mtp.dts"; this GSI firmware is loaded by Trust
>> Zone on this platform.
>>
>> Tested-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>   arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>>   arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>>   2 files changed, 43 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index ed98c83c141fc..72e25de0db5fc 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>>   	status = "okay";
>>   };
>>   
>> +&ipa {
>> +	qcom,gsi-loader = "skip";
>> +	status = "okay";
>> +};
>> +
>>   &qpic_bam {
>>   	status = "okay";
>>   };
>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> index 192f9f94bc8b4..360d6dc144811 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> @@ -11,6 +11,7 @@
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>>   
>>   / {
>>   	#address-cells = <1>;
>> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>>   			#hwlock-cells = <1>;
>>   		};
>>   
>> +		ipa: ipa@3e04000 {
>> +			compatible = "qcom,sdx65-ipa";
>> +
>> +			iommus = <&apps_smmu 0x5e0 0x0>,
>> +				 <&apps_smmu 0x5e2 0x0>;
>> +			reg = <0x3f40000 0x10000>,
>> +			      <0x3f50000 0x5000>,
>> +			      <0x3e04000 0xfc000>;
>> +			reg-names = "ipa-reg",
>> +				    "ipa-shared",
>> +				    "gsi";
>> +
>> +			interrupts-extended = <&intc GIC_SPI 241 IRQ_TYPE_EDGE_RISING>,
>> +					      <&intc GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "ipa",
>> +					   "gsi",
>> +					   "ipa-clock-query",
>> +					   "ipa-setup-ready";
> 
> These look misaligned.

I believe this is the alignment convention used by all IPA nodes
in DTS files.  It's possible I'm not seeing something you are,
but...  what alignment should be used?  And if I change this,
should I change all others?

Thanks.

					-Alex

> 
> With above:
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> 
> Best regards,
> Krzysztof
> 

