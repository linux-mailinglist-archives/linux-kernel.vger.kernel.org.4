Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720070DD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbjEWM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 08:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjEWM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 08:57:32 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E237BFF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:57:29 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af2db78b38so41865211fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684846588; x=1687438588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpPwKZ/pHSK5WOwFpXpf+dWli/bJbY6VBZD/E/hAP6M=;
        b=b3DIamYxTi/v51EdZ7SDh+hBPqRnIDi2rx+vibVvM23RP7rzyneyxLRB/Axlc5MBzO
         utZ0ym+QKi6LRKwRFLZYT8kMmOsYe7sNQSOdPupxujrdTkT5+ZtDJuXI0VxaI9ncg4/b
         uwRF+nGfeB+kjW6kraUREcEDLqyR5WP476SDCyqVXEHpSUBmhotJySJ7QCSqJe35hCgh
         urAll0vklxPAr1SBcoP9YhVG9VUv8SAFXYePLOpCKrIsG4r/+X/NYx13/EH668fJo+eo
         NL1NZvXZJUO7+EssMt5Pi+VZfbFtHMgoTYSLvrTR71YMvYnH0srbD/ZyIzqWgZBaj6d8
         8O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684846588; x=1687438588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpPwKZ/pHSK5WOwFpXpf+dWli/bJbY6VBZD/E/hAP6M=;
        b=J9JB5itLQtg6BRr8Ro6yK5iiEWIrGuXcYK69xjB5UqfRENMtqmBJvhUjwC2rLPuy+l
         f2thXLQor7cssRbc16PPROYkfM9K/BLij4XxQFzNL3n8sED7Kohu4jkssr1+esrfsu0L
         nymo2Ta1fy4zwRfwqmFxU6Av3HzFfCo6tlCcYmgN3/Ky6lkWSgfjD7e1XhGP/+25VwhY
         st9U7/4Y58izQWQqJ6Ppxbi5nXT4y8q7c33OxVkronGzD40cj+0rGOaMBjQpt6cFvMmC
         ZSEJloROm2fSOedBEI0IJFIQ5eyqmSKkxOD+0Z2fY18hXBHvxk8otak5L86jrpwhLBhp
         0zXg==
X-Gm-Message-State: AC+VfDxVNC3JuQ/y0uMm7hqa3esxHH0AcqUSrm2BySEIvTCktIpHqHLp
        M2+Ls00eGeGcTwh5MId1XrvbNw==
X-Google-Smtp-Source: ACHHUZ6c/kauyo/sRXK7gC6gSHRvq37cCYQro1FP0DCL+bzRiQxIwgpFpYqew7cK1BFsw+yt12lPGQ==
X-Received: by 2002:a2e:b1c4:0:b0:2af:22a0:81fd with SMTP id e4-20020a2eb1c4000000b002af22a081fdmr4691128lja.11.1684846588241;
        Tue, 23 May 2023 05:56:28 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id a19-20020a2e9813000000b002a7746800d0sm1605159ljj.130.2023.05.23.05.56.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 05:56:27 -0700 (PDT)
Message-ID: <19f30d4c-d879-ce2f-1cd7-ebcb941bbcec@linaro.org>
Date:   Tue, 23 May 2023 14:56:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Enable GPU related
 nodes
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org
References: <20230523011522.65351-1-quic_bjorande@quicinc.com>
 <20230523011522.65351-4-quic_bjorande@quicinc.com>
 <1669ecc5-1845-e671-83f4-19ee14d37ce5@linaro.org>
 <20230523122842.cueyeovuzpx63def@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230523122842.cueyeovuzpx63def@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.05.2023 14:28, Bjorn Andersson wrote:
> On Tue, May 23, 2023 at 10:04:40AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 23.05.2023 03:15, Bjorn Andersson wrote:
>>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>
>>> Add memory reservation for the zap-shader and enable the Adreno SMMU,
>>> GPU clock controller, GMU and the GPU nodes for the SC8280XP CRD and the
>>> Lenovo ThinkPad X13s.
>>>
>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>
>>> Changes since v1:
>>> - None
>>>
>>>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     | 26 +++++++++++++++++++
>>>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 26 +++++++++++++++++++
>>>  2 files changed, 52 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> index 5b25d54b9591..547277924ea3 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>>> @@ -210,6 +210,11 @@ vreg_wwan: regulator-wwan {
>>>  	};
>>>  
>>>  	reserved-memory {
>>> +		gpu_mem: gpu-mem@8bf00000 {
>> The ZAP region is very seldom moved around, and I wouldn't expect it
>> to be uncommon among the very usecase-specific 8280 machines.
>>
>>> +			reg = <0 0x8bf00000 0 0x2000>;
>>> +			no-map;
>>> +		};
>>> +
>>>  		linux,cma {
>>>  			compatible = "shared-dma-pool";
>>>  			size = <0x0 0x8000000>;
>>> @@ -259,6 +264,10 @@ usb1_sbu_mux: endpoint {
>>>  	};
>>>  };
>>>  
>>> +&adreno_smmu {
>>> +	status = "okay";
>>> +};
>> Ugh. Should definitely be enabled by default.
>>
>>> +
>>>  &apps_rsc {
>>>  	regulators-0 {
>>>  		compatible = "qcom,pm8350-rpmh-regulators";
>>> @@ -376,6 +385,23 @@ &dispcc0 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&gmu {
>>> +	status = "okay";
>>> +};
>> You can keep the GMU enabled by default as well, it won't "probe" on
>> its own (the GPU's hw_init calls its registration)
>>
>>> +
>>> +&gpu {
>>> +	status = "okay";
>>> +
>>> +	zap-shader {
>>> +		memory-region = <&gpu_mem>;
>>> +		firmware-name = "qcom/sc8280xp/qcdxkmsuc8280.mbn";
>>> +	};
>>> +};
>>> +
>>> +&gpucc {
>>> +	status = "okay";
>>> +};
>> Clock controllers have no reason to be off by default.
>>
> 
> On sa8295p/sa8540p the GPU is powered differently, so if I leave it
> enabled by default I need to disable it (or configure it) for those, or
> they won't boot.
Another "messed up automotive forks" situation, eh..
Would it take a lot of new code to configure these platforms correctly?

Konrad
> 
> Regards,
> Bjorn
> 
>> Konrad
>>> +
>>>  &mdss0 {
>>>  	status = "okay";
>>>  };
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> index bdcba719fc38..5ef3f4c07d75 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> @@ -264,6 +264,11 @@ vreg_wwan: regulator-wwan {
>>>  	};
>>>  
>>>  	reserved-memory {
>>> +		gpu_mem: gpu-mem@8bf00000 {
>>> +			reg = <0 0x8bf00000 0 0x2000>;
>>> +			no-map;
>>> +		};
>>> +
>>>  		linux,cma {
>>>  			compatible = "shared-dma-pool";
>>>  			size = <0x0 0x8000000>;
>>> @@ -359,6 +364,10 @@ usb1_sbu_mux: endpoint {
>>>  	};
>>>  };
>>>  
>>> +&adreno_smmu {
>>> +	status = "okay";
>>> +};
>>> +
>>>  &apps_rsc {
>>>  	regulators-0 {
>>>  		compatible = "qcom,pm8350-rpmh-regulators";
>>> @@ -518,6 +527,23 @@ &dispcc0 {
>>>  	status = "okay";
>>>  };
>>>  
>>> +&gmu {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&gpu {
>>> +	status = "okay";
>>> +
>>> +	zap-shader {
>>> +		memory-region = <&gpu_mem>;
>>> +		firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcdxkmsuc8280.mbn";
>>> +	};
>>> +};
>>> +
>>> +&gpucc {
>>> +	status = "okay";
>>> +};
>>> +
>>>  &mdss0 {
>>>  	status = "okay";
>>>  };
