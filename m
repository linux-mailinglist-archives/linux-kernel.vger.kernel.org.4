Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7256D7401
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236926AbjDEFzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjDEFzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:55:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1841198C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:55:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so138266518edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 22:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680674101;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3QuqF+VUImX1V5KpitdapwWJCPNXUqbEanRNw7dR5I=;
        b=mGgBLifE2V3m6QfJ3/xgYZp6oJDkrqAEJQhU01ExR+0FTmcJL5AxKvR6LGIu96DeXv
         9/iI1w6f5DDmpwJPEClgomFqQOwvYaHzWUzjae1itmsulZZ6y9M7A0tZy2FwQAZlrHZw
         EPkFyTPOHHlf1OZ0Pf6yQiwACv4m6WUdTPJqN1WK756K47vba3oFg74pzaLRiu72xsB/
         3ODGSzc3o/kPPnypNx3JZQAa4nlv2AxgFfn3KUTQ6CzdJOn9z2nRHS2ZQj8eLX7TfQSO
         yq46+6ClvuMTigEpSSTJs/v276FbRBYXWQBFg8KdQWwq9m+Wi8zCL6wfGOnlEHWQcQ/+
         IKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680674101;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3QuqF+VUImX1V5KpitdapwWJCPNXUqbEanRNw7dR5I=;
        b=Q8aJW82qWFsoytBpgOc+6G4/koqmpFNOEadalrdAki2lDSbHWIxD/RRckWMncdEOtY
         WKlqQOBxjn08pm+JWlUzTuMPYMDCmZAUF88omA4BD8v46YM0dtJbEyXRa7ikj9YMezDD
         7ZxNAoXe3YrH8XkThChh0lDCQjG79eQKo944EOLumP7Nq1kGmwqVsSitO2u/vlwn3uWz
         zF3fjE35uJDf8UCAOiguUKJlXWs2bPE4bnYEZjpDqWUwAeMXJRElyhhK3MXIGazU2WWU
         d5j8J59lPVV6lYv6xPjkwAE84qXNtanOXIq2aAOuwwFLo/rWTImxA9ptpt/LdXbR00i2
         z+Pg==
X-Gm-Message-State: AAQBX9chH0pj81oByMcqJDABPU1Aon2cekHo/vdPTETzAD1g+gLE2+to
        GkdcSxxbBLgwVCF8PSCHfbJoAPc4mAAutHLwRvs=
X-Google-Smtp-Source: AKy350arSlAk4kVthIv++2B8xcUpK5sIrMPiq3sRcfqef32uwJ6Np+4A7B049HjtI6zQ3Wj6ymq+xA==
X-Received: by 2002:a17:906:d929:b0:92c:8e4a:1a42 with SMTP id rn9-20020a170906d92900b0092c8e4a1a42mr1902655ejb.32.1680674101329;
        Tue, 04 Apr 2023 22:55:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id tq24-20020a170907c51800b00947abb70c93sm6555688ejc.112.2023.04.04.22.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 22:55:00 -0700 (PDT)
Message-ID: <c49a2dbf-ea5a-f70f-1508-47e821942c9d@linaro.org>
Date:   Wed, 5 Apr 2023 07:54:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550: add Soundwire controllers
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230404073915.61779-1-krzysztof.kozlowski@linaro.org>
 <305fcdae-84f5-7edb-26e4-588162fed018@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <305fcdae-84f5-7edb-26e4-588162fed018@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 19:55, Konrad Dybcio wrote:
> 
> 
> On 4.04.2023 09:39, Krzysztof Kozlowski wrote:
>> Add nodes for LPASS Soundwire v2.0.0 controllers.  Use labels with
>> indices matching downstream DTS, to make any comparisons easier.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Correct IO range length.
>>
>> The bindings and driver are here:
>> https://lore.kernel.org/linux-arm-msm/20230403132503.62090-1-krzysztof.kozlowski@linaro.org/T/#t
>> ---
>>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 109 +++++++++++++++++++++++++++
>>  1 file changed, 109 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> index dc6150e97d46..14e4de7a1a0e 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
>> @@ -2004,6 +2004,33 @@ lpass_wsa2macro: codec@6aa0000 {
>>  			#sound-dai-cells = <1>;
>>  		};
>>  
>> +		/* WSA2 */
>> +		swr3: soundwire-controller@6ab0000 {
>> +			compatible = "qcom,soundwire-v2.0.0";
>> +			reg = <0 0x06ab0000 0 0x10000>;
>> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&lpass_wsa2macro>;
>> +			clock-names = "iface";
>> +
> Any reason this and swr0 have comments instead of labels?

Actually no, I can go with label consistently. It's not actually used
for anything...

> 
>> +			qcom,din-ports = <4>;
>> +			qcom,dout-ports = <9>;
>> +
>> +			qcom,ports-sinterval =		<0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x18f 0xff 0xff 0x0f 0x0f 0xff 0x31f>;
>> +			qcom,ports-offset1 =		/bits/ 8 <0x01 0x03 0x05 0x02 0x04 0x15 0x00 0xff 0xff 0x06 0x0d 0xff 0x00>;
>> +			qcom,ports-offset2 =		/bits/ 8 <0xff 0x07 0x1f 0xff 0x07 0x1f 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-hstart =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
>> +			qcom,ports-hstop =		/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x0f>;
>> +			qcom,ports-word-length =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0x18>;
>> +			qcom,ports-block-pack-mode =	/bits/ 8 <0x00 0x01 0x01 0x00 0x01 0x01 0x00 0x00 0x00 0x01 0x01 0x00 0x00>;
>> +			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +			qcom,ports-lane-control =	/bits/ 8 <0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff 0xff>;
>> +
>> +			#address-cells = <2>;
>> +			#size-cells = <0>;
>> +			#sound-dai-cells = <1>;
>> +			status = "disabled";
>> +		};
> [...]
> 
> 
>> +		swr2: soundwire-controller@6d30000 {
>> +			compatible = "qcom,soundwire-v2.0.0";
>> +			reg = <0 0x06d30000 0 0x10000>;
>> +			interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
>> +					      <&intc GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
> There's no different interrupt-parent, so -extended seems excessive.
> Unless that was maybe supposed to use some PDC-mapped irq?
> 

Eh, apparently copy-pasta. Thanks,


Best regards,
Krzysztof

