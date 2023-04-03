Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6C66D41B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjDCKRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjDCKRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:17:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CAE72B7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:17:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h25so37369193lfv.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680517060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYWunT6ljLivd4wOmJltu2pTDnUfXFoW1kvmT3KC1QE=;
        b=CJvXvyFr0yjtxSqivXbkpCcvc0H/CT5Eonky3l6Mk2azf7riTYbT0oGepNmOI5QSO2
         tvM80d2CMcceuNCXKmGgPLz8IRukbwQe1e31W0LUXMvs6giQbKJvWRqO5BtHwA+Np/uq
         grWXum+E2Enovwah7JyDoAn5cKkG6x5kMNLSXezWYvF8p2fewdS1idyv1c9h8ssYOo5e
         hysZIAcY33b8LZMGAmwNsEOz81sxCq0IRvoKX3XcgA9/4uIv8l85EeX7Xrk07v3qY2Fg
         t4kM9anM315HOmrHtSAifarscYiTw2qNpyLUzZ+GNMLLB7q/QyFrJYyfAFL3D2kxWlts
         kx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517060;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYWunT6ljLivd4wOmJltu2pTDnUfXFoW1kvmT3KC1QE=;
        b=0qDjParitqFO0eVvna8KCrV5yuYdU88ioOYRHsLIy8ws0jha+iNPHQ0FejTSX90H9Y
         l8ez4iiVD5hS/jM6V/Ez4lXlBbAAtd2DDvJT6XB3XnTYMgCpinXxREMDcfJy0+Ms6pjG
         8pUSaTBD4Q0BZdW9Lqx51gnlYsAIjXIMorbkyGxxUs7/V2+Xk15ZloC74I6Vkq3o9qVv
         +wbjSkh0VXvbMtNelvrxMGJrrMrm85UTH1jwkgN8pV0oSlerK6QMrmr4eZMTxJrqOHrQ
         rfuQbtsTdL79uV87vcbRfCnsR3LszBW+HwcQx13v2KAPfo850lwfyKL9IcMAucUu7Muv
         IZrA==
X-Gm-Message-State: AAQBX9eeeR2Nm9i5yjRIa6AHeYnHeNBRbJ2868ll2fKHK6N8PxxG1AjU
        ni6ZcOwJDLMsvG92zK8AeiJFUg==
X-Google-Smtp-Source: AKy350YJmY7LxwUOQLiwMFFgX8lclMVAm4rfogfN3uFeeeJtrG3sPerJemo+C2+/Lq4iTju333wZBw==
X-Received: by 2002:a05:6512:4dd:b0:4eb:c24:2066 with SMTP id w29-20020a05651204dd00b004eb0c242066mr7869572lfq.68.1680517060196;
        Mon, 03 Apr 2023 03:17:40 -0700 (PDT)
Received: from [192.168.1.101] (abxj135.neoplus.adsl.tpnet.pl. [83.9.3.135])
        by smtp.gmail.com with ESMTPSA id u26-20020ac2519a000000b004e8483bff82sm1709319lfi.271.2023.04.03.03.17.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:17:39 -0700 (PDT)
Message-ID: <97316d33-29b9-700f-8766-df538b133f35@linaro.org>
Date:   Mon, 3 Apr 2023 12:17:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8350-nagara: Unify status
 property placement
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
 <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
 <i5tsdvn45peivo7tegmg3q4mhsz2ly2kfs64kezeykn2bbosd5@ugfqrjqumljd>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <i5tsdvn45peivo7tegmg3q4mhsz2ly2kfs64kezeykn2bbosd5@ugfqrjqumljd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.04.2023 17:19, Marijn Suijten wrote:
> On 2023-03-21 23:12:31, Konrad Dybcio wrote:
> 
> When you get to resending this, change sm8350-nagara in the title to
> sm8350-sagami :)
Even I confuse them, they just look too alike! ;)

Konrad
> 
> - Marijn
> 
>> As we're heading towards getting the status property last everywhere,
>> take care of it for SM8350 SONY Sagami.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++------------
>>  1 file changed, 14 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> index b2baa81baf5e..95b1ba4ce470 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> @@ -189,8 +189,8 @@ vph_pwr: vph-pwr-regulator {
>>  };
>>  
>>  &adsp {
>> -	status = "okay";
>>  	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
>> +	status = "okay";
>>  };
>>  
>>  &apps_rsc {
>> @@ -542,27 +542,27 @@ pmr735a_l7: ldo7 {
>>  };
>>  
>>  &cdsp {
>> -	status = "okay";
>>  	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
>> +	status = "okay";
>>  };
>>  
>>  &i2c1 {
>> -	status = "okay";
>>  	clock-frequency = <1000000>;
>> +	status = "okay";
>>  
>>  	/* Some subset of SONY IMX663 camera sensor @ 38 */
>>  };
>>  
>>  &i2c4 {
>> -	status = "okay";
>>  	clock-frequency = <400000>;
>> +	status = "okay";
>>  
>>  	/* Samsung Touchscreen (needs I2C GPI DMA) @ 48 */
>>  };
>>  
>>  &i2c11 {
>> -	status = "okay";
>>  	clock-frequency = <1000000>;
>> +	status = "okay";
>>  
>>  	cs35l41_l: speaker-amp@40 {
>>  		compatible = "cirrus,cs35l41";
>> @@ -596,31 +596,31 @@ cs35l41_r: speaker-amp@41 {
>>  };
>>  
>>  &i2c12 {
>> -	status = "okay";
>>  	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>>  	clock-frequency = <100000>;
>> +	status = "okay";
>>  
>>  	/* AMS TCS3490 RGB+IR color sensor @ 72 */
>>  };
>>  
>>  &i2c13 {
>> -	status = "okay";
>>  	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
>>  	clock-frequency = <100000>;
>> +	status = "okay";
>>  
>>  	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
>>  };
>>  
>>  &i2c15 {
>> -	status = "okay";
>>  	clock-frequency = <400000>;
>> +	status = "okay";
>>  
>>  	/* NXP SN1X0 NFC @ 28 */
>>  };
>>  
>>  &i2c17 {
>> -	status = "okay";
>>  	clock-frequency = <1000000>;
>> +	status = "okay";
>>  
>>  	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
>>  };
>> @@ -652,8 +652,8 @@ mdss_dp_altmode: endpoint {
>>  };
>>  
>>  &mpss {
>> -	status = "okay";
>>  	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
>> +	status = "okay";
>>  };
>>  
>>  &pm8350_gpios {
>> @@ -719,8 +719,8 @@ &pon_pwrkey {
>>  };
>>  
>>  &pon_resin {
>> -	status = "okay";
>>  	linux,code = <KEY_VOLUMEUP>;
>> +	status = "okay";
>>  };
>>  
>>  &qupv3_id_0 {
>> @@ -748,8 +748,8 @@ &sdhc_2 {
>>  };
>>  
>>  &slpi {
>> -	status = "okay";
>>  	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
>> +	status = "okay";
>>  };
>>  
>>  &spi14 {
>> @@ -1038,16 +1038,14 @@ usb_1_dwc3_ss: endpoint {
>>  };
>>  
>>  &usb_1_hsphy {
>> -	status = "okay";
>> -
>>  	vdda-pll-supply = <&pm8350_l5>;
>>  	vdda18-supply = <&pm8350c_l1>;
>>  	vdda33-supply = <&pm8350_l2>;
>> +	status = "okay";
>>  };
>>  
>>  &usb_1_qmpphy {
>> -	status = "okay";
>> -
>>  	vdda-phy-supply = <&pm8350_l6>;
>>  	vdda-pll-supply = <&pm8350_l1>;
>> +	status = "okay";
>>  };
>>
>> -- 
>> 2.40.0
>>
