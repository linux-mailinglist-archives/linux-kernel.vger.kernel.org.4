Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27FE632006
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiKULNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiKULNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:13:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72AAB406D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:08:52 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso8733049wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ldIw3qE7TcfeO+CMNZSZzhqJXxqw8uTyqxjG7TVKHRA=;
        b=a1X2OKkvQNOYrg2Ho4tHtXzbCVjjPjCnUbH2he6Lu/0a/dCxUbCFQkuAi+REPRzjZz
         vew6pHKduwMkWoIO0JFU/eotkrhuRQxO8RvUdmBEVw0/WoucoCNxVQzaQOcy+BZvY8C8
         GRXQvw3iqKXinlhtPt5/9ltQQ/0PUY7scXsvM8uqGRZH042S/gLyz+3gVZlo3U85Pe7Q
         i49pKaEMahMQ4i5dqU8ErKx69bt0GMoWN77LXNtlSYWfYChkgCpTk1FhUPJlU1VToP/m
         ETVt06vLHRXdNlEG6t2QPZWo2cw0QSiIORrkjxqTuoGXdFjZoeUFWeFkVtHZvRMmGqQR
         LLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldIw3qE7TcfeO+CMNZSZzhqJXxqw8uTyqxjG7TVKHRA=;
        b=i4BSxAlE7PWMKMDmyRGBtabBr90Exeqyp9alqofgo5YUvRth4jSUpyzV1HBMY99VuU
         XSZ91PK1rzSFKvLPuOAoBsk9K9cMg2+CddEW/Ff9OAPQKRoyX3wbVDUMpkA3CChYfesy
         Vydda7Ko8lgSrGCS/oNlZFA+9PxW1Uz8E5k8hX5tSFYbfIV3I5vK7aGJaBsAyKql4Ha8
         fQ40tOVZl/IH5MiRmbazuAztn9bvykLe8UblnY2cbG5DcsYuO/oIYajqsy2qILvsjcFI
         Ep3mJ3kUZ5pSv/p+YK+TlCnfN06ozs0eFV8f/HMILTGjGGaCCDY30eAhPg3yTUHHBuKE
         YMNw==
X-Gm-Message-State: ANoB5plNTeb+PlwcIGOl9AUdMGFjIgxd5l0YXXwNe10m2M/7Ah74ZLwX
        cg88CkC58hxYZWpMolqZeQ1UoQ==
X-Google-Smtp-Source: AA0mqf4890BbDvUAZKyzdiBlp8Yumr3tgn5xlZULQw9eYNuxY4HTyXVcYs/0E8kBvE+LhjlPgDChug==
X-Received: by 2002:a05:600c:4c21:b0:3b4:8fd4:293e with SMTP id d33-20020a05600c4c2100b003b48fd4293emr15856331wmp.46.1669028924530;
        Mon, 21 Nov 2022 03:08:44 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id fc10-20020a05600c524a00b003cf9bf5208esm19606724wmb.19.2022.11.21.03.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:08:43 -0800 (PST)
Message-ID: <74e3582e-ac89-b81d-fe0e-c3f63d3e7985@linaro.org>
Date:   Mon, 21 Nov 2022 11:08:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
 <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
 <1353266c-2d95-6c68-5288-c405231a37f1@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1353266c-2d95-6c68-5288-c405231a37f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Krzysztof,

On 21/11/2022 08:34, Krzysztof Kozlowski wrote:
> On 19/11/2022 17:44, Srinivas Kandagatla wrote:
>> Add support for SoundCard on X13s. This patch adds support for Headset
>> Playback, record and 2 DMICs on the Panel along with the regulators
>> required for powering up the LPASS codecs.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +	right_spkr: wsa8830-right@0,2{
>> +		compatible = "sdw10217020200";
>> +		reg = <0 2>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&spkr_2_sd_n_default>;
>> +		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_LOW>;
>> +		#thermal-sensor-cells = <0>;
>> +		sound-name-prefix = "SpkrRight";
>> +		#sound-dai-cells = <0>;
>> +		vdd-supply = <&vreg_s10b>;
>> +	};
>> +};
>> +
>> +
> 
> Only one blank line.
> 
>> +&swr1 {
>> +	status = "okay";
>> +
>> +	wcd_rx: wcd9380-rx@0,4 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 4>;
>> +		qcom,rx-port-mapping = <1 2 3 4 5 6>;
> 
> No improvements: Still looks too long.
Yep we only have 5 out ports.

> 
>> +
> 
> Drop empty line.

Looks like I had to many stray lines :-)

will fix this in next spin.

>> +	};
>> +};
>> +
>> +&swr2 {
>> +	status = "okay";
>> +
>> +	wcd_tx: wcd9380-tx@0,3 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 3>;
>> +		qcom,tx-port-mapping = <1 1 2 3>;
>> +	};
>> +};
>> +
>> +&vamacro {
>> +	pinctrl-0 = <&dmic01_default>, <&dmic02_default>;
>> +	pinctrl-names = "default";
>> +	vdd-micb-supply = <&vreg_s10b>;
>> +	qcom,dmic-sample-rate = <600000>;
>> +};
>> +
>>   &tlmm {
>>   	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
>>   
>> @@ -369,6 +558,14 @@ reset {
>>   		};
>>   	};
>>   
>> +	wcd_default: wcd-default-state {
>> +		reset-pins {
>> +			pins = "gpio106";
>> +			function = "gpio";
>> +			bias-disable;
>> +		};
>> +	};
>> +
>>   	qup0_i2c4_default: qup0-i2c4-default-state {
>>   		pins = "gpio171", "gpio172";
>>   		function = "qup4";
>> @@ -383,6 +580,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
>>   		drive-strength = <16>;
>>   	};
>>   
>> +	spkr_1_sd_n_default: spkr-1-sd-n-default-state {
>> +		perst-n-pins {
>> +			pins = "gpio178";
>> +			function = "gpio";
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>> +	spkr_2_sd_n_default: spkr-2-sd-n-default-state {
>> +		perst-n-pins {
>> +			pins = "gpio179";
>> +			function = "gpio";
>> +			drive-strength = <16>;
>> +			bias-disable;
>> +			output-high;
>> +		};
>> +	};
>> +
>>   	tpad_default: tpad-default-state {
>>   		int-n {
> 
> This won't apply cleanly. You need to base your patches on recent trees.

Yes, I will rebase this on top of 
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/log/?h=arm64-for-6.2

--srini
> 
> Best regards,
> Krzysztof
> 
