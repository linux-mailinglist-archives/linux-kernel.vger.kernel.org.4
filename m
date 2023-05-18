Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9A707D18
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjERJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjERJlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:41:47 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F5B1732
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:41:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so19801351fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684402903; x=1686994903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjqQeuYRpvMsut/c1evBJHvsSn9+lFSN53c//wdZ/FQ=;
        b=lxGL7xCqkfKsajfk0zq6AGTDZOJpoTin3Km9a2j2J7UCTAc/bm5lJlyD7dzpe7oVHw
         VHdmYA9VzOIDbztMGfrqrYPBFzMg+c+3Z15vl8v4yXx8Uwu08ELlxU00Gtrcyfo9ogQv
         2EkiZIACXYEcjBYBqD0OlyJZELInl7+SVqbJKHxD7ScYIvIujwiwCViNuOyeJTp5Fdyw
         kdxGwMNoaYtE/K+VjO4t84AnuvsgMsskyUcBb5yGxddAHj0lrbap0Khy5b16y1mqdp45
         8hDP4UZ4RMi4dtkYMrr4G9C6w4Iwk1kUVPtmnrvW4WcjCwwLAG43sFSCzf/Enot42haK
         wMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684402903; x=1686994903;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjqQeuYRpvMsut/c1evBJHvsSn9+lFSN53c//wdZ/FQ=;
        b=KqTDy7J3BTGq9VsTPJTtcrGIEdCQ6QwtjxvXQ2nJtrW+B/x6XmUGUrbEyMkWzV1sKD
         9OsMd6vABIgd3EdKNIeP5uChUlTJR/SknUw0LjLrd/9lrY8tLAB95EPqUChVw12Q3E3f
         pvb8pSwc+EmbWCugEtmC1BKkGHYFKtrVnb/R9AAQulJQEIuk1OkcXKArcgVJwAqWAG47
         65fASyFJan/IGT4LWxpue8tRTyH1Hua4oXbajmbRoYOrbT6MoS13k+nLrDVsbF/zxYld
         90g/b7LCpuxez5ICQPhsbfd8IKXmsz8VxCt14u2GPoPQ4IbLfOk7CuKlYNBbsdOnk3Te
         SIXw==
X-Gm-Message-State: AC+VfDyiDLpLurVAN5bx4CdT7b4FbQ2EI703zsd2Db/W8ADg3LslrkBF
        SDsTSFRH2mAPU/sfzWHQRbShDQ==
X-Google-Smtp-Source: ACHHUZ4UT5ZdWhf2s2u0WXN8DiysRHiC8lCqC2j57Z6hovVUBC2/syVJt56WBhEu8aTwXLHOQllPDw==
X-Received: by 2002:a05:651c:1047:b0:2ad:c1ec:fa3 with SMTP id x7-20020a05651c104700b002adc1ec0fa3mr8305804ljm.20.1684402902982;
        Thu, 18 May 2023 02:41:42 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id t16-20020a2e9d10000000b002aa3ad9014asm204808lji.54.2023.05.18.02.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:41:42 -0700 (PDT)
Message-ID: <b050f3c4-6ff0-d687-73bf-0f98a2e74bed@linaro.org>
Date:   Thu, 18 May 2023 11:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] arm64: dts: qcom: qrb4210-rb2: Add GPIO LEDs
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
 <20230515-topic-rb2-bits-v1-3-a52d154a639d@linaro.org>
 <20230518021307.z63xrx5v2lhd3byf@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230518021307.z63xrx5v2lhd3byf@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.05.2023 04:13, Bjorn Andersson wrote:
> On Mon, May 15, 2023 at 03:04:14PM +0200, Konrad Dybcio wrote:
>> Add the three LEDs (blue/yellow/green) connected to TLMM GPIOs.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 36 ++++++++++++++++++++++++++++++--
>>  1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> index 9b539720f05d..eeee268ebfe2 100644
>> --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
>> @@ -5,6 +5,7 @@
>>  
>>  /dts-v1/;
>>  
>> +#include <dt-bindings/leds/common.h>
>>  #include "sm4250.dtsi"
>>  
>>  / {
>> @@ -30,6 +31,38 @@ hdmi_con: endpoint {
>>  		};
>>  	};
>>  
>> +	leds {
>> +		compatible = "gpio-leds";
>> +
>> +		led-bt {
>> +			label = "blue:bt";
>> +			function = LED_FUNCTION_BLUETOOTH;
>> +			color = <LED_COLOR_ID_BLUE>;
>> +			gpios = <&tlmm 45 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "bluetooth-power";
>> +			default-state = "off";
>> +		};
>> +
>> +		led-user0 {
>> +			label = "green:user0";
>> +			function = LED_FUNCTION_INDICATOR;
>> +			color = <LED_COLOR_ID_GREEN>;
>> +			gpios = <&tlmm 52 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "none";
>> +			default-state = "off";
>> +			panic-indicator;
>> +		};
>> +
>> +		led-wlan {
>> +			label = "yellow:wlan";
>> +			function = LED_FUNCTION_WLAN;
>> +			color = <LED_COLOR_ID_YELLOW>;
>> +			gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "phy0tx";
>> +			default-state = "off";
>> +		};
>> +	};
>> +
>>  	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "VREG_HDMI_OUT_1P2";
>> @@ -385,8 +418,7 @@ &sleep_clk {
>>  };
>>  
>>  &tlmm {
>> -	gpio-reserved-ranges = <43 2>, <47 1>,
>> -			       <49 1>, <52 1>, <54 1>,
>> +	gpio-reserved-ranges = <43 2>, <49 1>, <54 1>,
> 
> How come pin 49 becomes inaccessible here? Was this intended for the
> previous patch?
It doesn't, the "remove" part of the diff is 2-lines.

This reserved-ranges is totally bogus since introduction.. I can send
a separate patch squaring it out.

Konrad

> 
> Regards,
> Bjorn
> 
>>  			       <56 3>, <61 2>, <64 1>,
>>  			       <68 1>, <72 8>, <96 1>;
>>  
>>
>> -- 
>> 2.40.1
>>
