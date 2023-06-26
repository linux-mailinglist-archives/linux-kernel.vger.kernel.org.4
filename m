Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485F73DBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjFZJrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjFZJrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:47:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32192E4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:47:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb7589b187so930886e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687772869; x=1690364869;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FL2w3500sIslMCHjh74BxBfG9msGNmWLpgO8tAAcfcI=;
        b=IpGFfzmRPNNLymcJjxeMhezDqYfxivyGGAzIj7wGdCaoEpQCgUsUFdTar0gVG72y5W
         S0rfK+siR5sRdmxukIQ7GWUtJFds/eHGFzW3p4hicLiZppEvUcIWtR/51WMXA7IE7h0I
         jnHR2/POnbhZ1wpP2eIu8o+k3dFa3ldov1HxZV/PF0/e9oV7MzuUmdM92SKa08QIuvaT
         ypyZ9Uw8gZ4qZvD16VVuX4/KgmqxqYqbN2lqDb9Kg5+rcdpgRWZHDPsED23ckMWJqFAI
         a2si5U4IQanSmDD5Br+Oq+y4Tti/7FX75PHYCBzqr5s+xaQLggLGB/ZTMZV0dDKjFyKu
         aV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687772869; x=1690364869;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL2w3500sIslMCHjh74BxBfG9msGNmWLpgO8tAAcfcI=;
        b=JaCLfwfLT9/t/kzyy9Q4znZ712ULfgtNC3GUnA+nE2cV8bLDwv5LLdHWr4vcXSQcIX
         dKs84jjCTktTM+Dq5qsUFweogQIuRa7cMfrhn6KszlkHsE0J1ph4P0n89SwBEkj/bh7z
         u2yLa9qTgPvBNVHWIadip1+8QjgEJ7xUZUUg7+DpRW7Bfq+IOQ9DeT6ANA44t4Fr0Yqe
         mK9aUXG5CAILG5RkQUX4f26Xrsi+j94AK3uBKM4qFqgaVaBCD0z40ue2JA2A+fOOKGsx
         1acH0TRrmhq/+V4OEQ6hSPT43uwef2+KXiI4eK3tqOyykDrYDNrLGR4I8aj1/qm3UmXY
         3aDA==
X-Gm-Message-State: AC+VfDzfaLkR43WdxKfIJEAx1K4vQixRgOGnNbWsPhV7xfwAdFyYCHyX
        oa/RZv4Oi2SE/g+d1lFId8oZqg==
X-Google-Smtp-Source: ACHHUZ5rZsKDrCepmuT9s/sabNf4DTSFXD6dlVhcagGc7ZJz0fxvXb7tpjWKJRXQTQbqS6gKnHcWHA==
X-Received: by 2002:a19:9106:0:b0:4f9:54f0:b6db with SMTP id t6-20020a199106000000b004f954f0b6dbmr9983688lfd.13.1687772869510;
        Mon, 26 Jun 2023 02:47:49 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id q12-20020ac24a6c000000b004fb7b4c803esm54882lfp.180.2023.06.26.02.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 02:47:49 -0700 (PDT)
Message-ID: <863e04e8-3e14-d8bc-f9b4-8e184b545767@linaro.org>
Date:   Mon, 26 Jun 2023 11:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFT PATCH] arm64: dts: qcom: sdm850-c630: add missing panel
 supply
Content-Language: en-US
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171512.286795-1-krzysztof.kozlowski@linaro.org>
 <52dbabb2-8cc1-5579-8c83-adcc7a699222@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <52dbabb2-8cc1-5579-8c83-adcc7a699222@linaro.org>
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

On 24.06.2023 16:56, Caleb Connolly wrote:
> 
> 
> On 17/06/2023 17:15, Krzysztof Kozlowski wrote:
>> Panel bindings (boe,nv133fhm-n61) require supply which here actually can
>> be turned on/off via GPIO control:
>>
>>   sdm850-lenovo-yoga-c630.dtb: panel: 'power-supply' is a required property
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I've been running an equivalent patch for a while, so
> 
> Tested-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> The dsi bridge vcc and vcca supplies are also missing, they're powered
> from vreg_l2a_1p2 and controlled by pm8998_gpio 9.
Mind submitting an incremental patch?

Konrad
>>
>> ---
>>
>> Not tested on hardware
>> ---
>>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 20 +++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
>> index cfbc4fc1eba9..3d871567cf81 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
>> +++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
>> @@ -87,6 +87,25 @@ sn65dsi86_refclk: sn65dsi86-refclk {
>>  		clock-frequency = <19200000>;
>>  	};
>>  
>> +	vph_pwr: regulator-vph-pwr {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vph_pwr";
>> +		regulator-min-microvolt = <3700000>;
>> +		regulator-max-microvolt = <3700000>;
>> +	};
>> +
>> +	vlcm_3v3: regulator-vlcm-3v3 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vlcm_3v3";
>> +
>> +		vin-supply = <&vph_pwr>;
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +	};
>> +
>>  	backlight: backlight {
>>  		compatible = "pwm-backlight";
>>  		pwms = <&sn65dsi86 1000000>;
>> @@ -419,6 +438,7 @@ aux-bus {
>>  			panel: panel {
>>  				compatible = "boe,nv133fhm-n61";
>>  				backlight = <&backlight>;
>> +				power-supply = <&vlcm_3v3>;
>>  
>>  				port {
>>  					panel_in_edp: endpoint {
> 
