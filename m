Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6E16C8DE2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjCYMMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjCYMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:12:22 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF085113FA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:12:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t11so5515862lfr.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679746339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mx5GKFNJIsSUryNV2aWwLZ8jV1O9SFf3vbPq664rBAE=;
        b=XKXucM7jXM1x4OMWNfXoq1MPrMiNYQLUQvME3Ywl3Z1iOFCzZrhOvPU7S4kt3zZyWU
         9ly8j2CE5F4SZ0pvkzMNh9AmSRr5ES+BlEvcehK3uW3IRmNfIn/oZ9j+4u9kfLWywKNq
         0DBCB5G8x1MaKvVcVfUz4MebYt9Rq8K39AyomJjnAs72fp9sV76/CTM8aUdII4rIHEPj
         YSk+/QkGd8ECm8TgzvhM8Rfu3V5Q8DUuNMVJUpQXXW6CgKZDMcdb1UZZV4Xs63QGz/vV
         qXMwLPswRsGAE9afmRepGQPaqh7CrTSNLuMfMBQ8C5YB/6x1YINl2cWTDYQpyFLhZveX
         bH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746339;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mx5GKFNJIsSUryNV2aWwLZ8jV1O9SFf3vbPq664rBAE=;
        b=ksphZsvaAWzBY+4B2MBVAN6CozS3NKNd9ubtsiFeQPEHLsEgsd8viueQMfE5KYtXzT
         YzaiA1JuQ8Qzn0KsNjFby5puLT/93hDV42wywVD0CZLLlOLrn3BFzxVf9qPSH9FHeKcF
         R4iYachQmlYHwvleadbyROXkfi3wZbEFtEhS6VSasDrUlnBjK6590YmRWXVyyOUt7Dvq
         RVmRo2RDS63Tg3xDZ2lWo5sfnWxJ9XizS2dUegf6u3Z/i1i0zVlHARYmuzA6/FyaU+fy
         3/gpHX7Nc1WGBxeCB+NJnvHfxRM9MWJifDkpF3T2utFqCKoKN/RSwb1/bRsByoNSAbxy
         YqKA==
X-Gm-Message-State: AAQBX9dMZL3mywpPRqSHS7pWKnuu4zh0rebY/hCFYr/q79TV0VTI7Qhz
        vvLOKryVkZFzshoCbHy1HtE7lA==
X-Google-Smtp-Source: AKy350aF/hWJDU6/B+zXSPwlitxzpBseuHLcNf7bdpQocER3sjipiZaGiW6Mg0s5VGAVbSocSqvQOA==
X-Received: by 2002:ac2:5a4b:0:b0:4ea:918a:4b97 with SMTP id r11-20020ac25a4b000000b004ea918a4b97mr1925641lfn.63.1679746339021;
        Sat, 25 Mar 2023 05:12:19 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b004e1b880ba20sm3798241lfm.292.2023.03.25.05.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 05:12:18 -0700 (PDT)
Message-ID: <f600869e-0fd8-ca19-1baf-d23f7a9103d6@linaro.org>
Date:   Sat, 25 Mar 2023 13:12:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] ARM: dts: qcom: sdx65: add IPA information
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
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
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <98fcbdd4-77b3-5b17-7102-c590f1a5a63e@kernel.org>
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



On 25.03.2023 12:14, Krzysztof Kozlowski wrote:
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
>>  arch/arm/boot/dts/qcom-sdx65-mtp.dts |  5 ++++
>>  arch/arm/boot/dts/qcom-sdx65.dtsi    | 38 ++++++++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/qcom-sdx65-mtp.dts b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> index ed98c83c141fc..72e25de0db5fc 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> +++ b/arch/arm/boot/dts/qcom-sdx65-mtp.dts
>> @@ -245,6 +245,11 @@ &blsp1_uart3 {
>>  	status = "okay";
>>  };
>>  
>> +&ipa {
>> +	qcom,gsi-loader = "skip";
>> +	status = "okay";
>> +};
>> +
>>  &qpic_bam {
>>  	status = "okay";
>>  };
>> diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> index 192f9f94bc8b4..360d6dc144811 100644
>> --- a/arch/arm/boot/dts/qcom-sdx65.dtsi
>> +++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
>> @@ -11,6 +11,7 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/interconnect/qcom,sdx65.h>
>>  
>>  / {
>>  	#address-cells = <1>;
>> @@ -299,6 +300,43 @@ tcsr_mutex: hwlock@1f40000 {
>>  			#hwlock-cells = <1>;
>>  		};
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
> 
> With above:
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
With this and moving iommus below interconnect:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> 
> Best regards,
> Krzysztof
> 
