Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260C7359CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFSOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjFSOiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:38:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F723AF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:38:00 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso503227766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687185479; x=1689777479;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNW3reGV/XRZqX6WFGDhTYzLr+D0q7GoDZXAaMep3AU=;
        b=P8B+nP6jdFAB8e69jCe//s9YtT6mI/mxLxBitrI8kqFNtFgK/u3D0xtmWdzo82RoOK
         wtohMHJeeoxWayGaqwkPb2MCKIbSCMGJ77LbDKYCN11rXrszKnYRWOlGSsox4xyR53Xj
         /44SveX6KX3IN4JYe1nSzhipo172nb4Df1lkZSApi5ckvK1t1XmnFjDZFHxv1REXi+9/
         8CkOvLjm8lZutT3RsZ5f8CZVf1LuoK45Sp9f1ztnFm/k+a6FQGnFFzSg+Tmtqlj08bHB
         lV91hj84stcqgntUEYsmfwKhoxeGQ1wOumPLTGuxSKI8Bv+nMK1oHKf8or9JNB7KySq+
         pKMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687185479; x=1689777479;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNW3reGV/XRZqX6WFGDhTYzLr+D0q7GoDZXAaMep3AU=;
        b=lRElCMuhMz5EcvrU9qV4PFcZVFTP4LEb4hUybrbfwBlSdJ55jueuiGndG/QFjRMYEz
         Eh9Wgynz6P0gepIBWEpOlr2KvZFiEbb3RHUJXDN6USpOF72GviKS6pCRgn3xvpuVHC1T
         c68zGlLkiNaMTtLpg2dzp2WRi6Q0LK0a6XBz2HC8boPUkrDfc42hOXkmW8p8MpP0HckZ
         cE1VxNxKV1OBi0+0/jSTgUuA+lQTWluQv6GOuVh7SZJ6nwE9J8ezO+ArkTYHLsJaqZLL
         OkflN9zeGrzGV6Agjf2p/ZYxNB1CGeHa5Vj+GvQyuiPldD/4uFZerHbMoCzCrET8QWPC
         UkAQ==
X-Gm-Message-State: AC+VfDyKir8grWtdIq6TfccaUHQFuglnc3/6SThQ6aqaWeVaJDSpnVEr
        YnYEq2Q6q1XeN/nMLVQolurwvw==
X-Google-Smtp-Source: ACHHUZ49iPgSSrqnUIvN833fl7nNwv0Iul5ZFNaIPnDA8P9wzXaKEMYDSsE9eWk1PC762ePKU0Q2cA==
X-Received: by 2002:a17:907:7dab:b0:96b:4ed5:a1c9 with SMTP id oz43-20020a1709077dab00b0096b4ed5a1c9mr9521227ejc.51.1687185478974;
        Mon, 19 Jun 2023 07:37:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kf12-20020a17090776cc00b009888eda6b0asm2027257ejc.170.2023.06.19.07.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 07:37:58 -0700 (PDT)
Message-ID: <1dfcc1cd-3e71-8d02-5d5e-4b501d7ada50@linaro.org>
Date:   Mon, 19 Jun 2023 16:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8350: add APR and LPASS TLMM
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616190222.2251186-1-krzysztof.kozlowski@linaro.org>
 <20230616190222.2251186-3-krzysztof.kozlowski@linaro.org>
 <4e558ea5-84cf-c7d4-19c2-f6e72f497c74@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4e558ea5-84cf-c7d4-19c2-f6e72f497c74@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 15:24, Konrad Dybcio wrote:
> On 16.06.2023 21:02, Krzysztof Kozlowski wrote:
>> Add audio-related nodes: the APR in the ADSP (same as on SM8250) and
>> LPASS TLMM pin controller.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Bindings for SM8350:
>> https://lore.kernel.org/linux-arm-msm/20230616185742.2250452-1-krzysztof.kozlowski@linaro.org/T/#t
>> ---
>>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 82 ++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> index 33b7ef8fd78a..9650cecb1370 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
>> @@ -15,7 +15,9 @@
>>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>>  #include <dt-bindings/power/qcom-rpmpd.h>
>> +#include <dt-bindings/soc/qcom,apr.h>
>>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,q6afe.h>
>>  #include <dt-bindings/thermal/thermal.h>
>>  #include <dt-bindings/interconnect/qcom,sm8350.h>
>>  
>> @@ -1780,6 +1782,20 @@ tcsr_mutex: hwlock@1f40000 {
>>  			#hwlock-cells = <1>;
>>  		};
>>  
>> +		lpass_tlmm: pinctrl@33c0000 {
>> +			compatible = "qcom,sm8350-lpass-lpi-pinctrl";
>> +			reg = <0 0x033c0000 0x0 0x20000>,
> '0' for addr, '0x0' for size :/
> 
> The rest of the file uses '0', please do that
It's a mixture but mostly 0x0 in both places. I don't mind switching to 0.

> 
>> +			      <0 0x03550000 0x0 0x10000>;
>> +
>> +			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
>> +				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
>> +			clock-names = "core", "audio";
>> +
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
>> +		};
>> +
>>  		gpu: gpu@3d00000 {
>>  			compatible = "qcom,adreno-660.1", "qcom,adreno";
>>  
>> @@ -3189,6 +3205,72 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>>  				label = "lpass";
>>  				qcom,remote-pid = <2>;
>>  
>> +				apr {
>> +					compatible = "qcom,apr-v2";
>> +					qcom,glink-channels = "apr_audio_svc";
>> +					qcom,domain = <APR_DOMAIN_ADSP>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					service@3 {
>> +						reg = <APR_SVC_ADSP_CORE>;
>> +						compatible = "qcom,q6core";
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
>> +					};
>> +
>> +					q6afe: service@4 {
>> +						compatible = "qcom,q6afe";
>> +						reg = <APR_SVC_AFE>;
>> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> Missing newline before subnodes

acks

Best regards,
Krzysztof

