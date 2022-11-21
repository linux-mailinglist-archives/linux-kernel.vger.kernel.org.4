Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8E6320D1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiKULhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiKULhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:37:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146CB56D7C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:34:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d1so7288913wrs.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s7KJL1UHEfqYYcbaMMu5gVL2ZdsXqxCdHp8dhaDUxAc=;
        b=Y+Ao8Ssl/PgYRjHvOexJPzfy7W1t0Em4oDTazRT3OlL48rQbCyyXL4XV9iCYWsmAWS
         g6+Ror+18d/G4guu7r4mL85Ns1V0e/3tepmyBgdmbY1sw4vZ+AMi8MP7k7df5mVmTIm4
         E5iGtMfBpAPRXlFmQ+vXgQW2x25ZjYOk8s7XN/37Ta8nAz3bE1UnerJckAncdOekVGp9
         RLt51wg3RDsR7wxYPgTOEgVwmu7FHINeX0080MXpkBhVF4+T7Qij7FbHPx+26iG2sBxM
         C5KdS3pWdM/JHLGY4XNNU5lk9AL+ZvoFo429Jwk6ay6cZ6zu52S0pWKyQgxOQ7EnvZFW
         y3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s7KJL1UHEfqYYcbaMMu5gVL2ZdsXqxCdHp8dhaDUxAc=;
        b=C1zrp2F1+iuvrTsKJg/w3F00jKEWINSxyOaUXW84g8yBvyhhooF3R+ygyQ2LU1H8OF
         1cUAX6Rh1MhQXKFg/uiI0XCNVBI9PdMGP2gguIAXKZ16FJuOdpV4+0iQRiAlTBcpvmj1
         JqU6/kwBNzEpH4INC5hvfx9+tLuFx2E1IAY54PMnjxHFLoJ7w5QXAeqej3J0WLCaKtYi
         Zx2cr/8YNp/SKNMunIQB+3NMuuSkQF1pFHdcI1tFOYpSBAPaUCO36iPXdg3FSh1bgRdF
         bc13pGzDO4xEB7XyZ/FAE2sfCjBkCXpb05J4Knnl6ml5jcKiCz/GP+P/hg1I2WBiFnVV
         o1Qg==
X-Gm-Message-State: ANoB5pm4t/ukGbfalqji38tmeFP3xIhDZy63z+5FBe6k4Ul7M1rzIqMs
        NRzKjKPSx1AjjdljNDV2gKk4bg==
X-Google-Smtp-Source: AA0mqf6nLw/yNkmhj/joOo1kj7Xm2ofODX+FtF3VAPGcV8PO8nDaG2OLEHLL0Bz8ZeELKKo505+xBw==
X-Received: by 2002:adf:b606:0:b0:22e:2efe:3176 with SMTP id f6-20020adfb606000000b0022e2efe3176mr10610673wre.241.1669030489607;
        Mon, 21 Nov 2022 03:34:49 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id i3-20020adffc03000000b00241b2b23cd5sm13201902wrr.54.2022.11.21.03.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:34:49 -0800 (PST)
Message-ID: <005c42c1-226b-093d-c6f2-b3c850d31177@linaro.org>
Date:   Mon, 21 Nov 2022 11:34:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221119164425.86014-1-srinivas.kandagatla@linaro.org>
 <20221119164425.86014-4-srinivas.kandagatla@linaro.org>
 <Y3swkpNTE2EaNqDq@hovoldconsulting.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <Y3swkpNTE2EaNqDq@hovoldconsulting.com>
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

Thanks Johan,

On 21/11/2022 08:02, Johan Hovold wrote:
> On Sat, Nov 19, 2022 at 04:44:25PM +0000, Srinivas Kandagatla wrote:
>> Add support for SoundCard on X13s. This patch adds support for Headset
>> Playback, record and 2 DMICs on the Panel along with the regulators
>> required for powering up the LPASS codecs.
> 
> Subject prefix should include "x13s":
> 
> 	arm64: dts: qcom: sc8280xp-x13s: ...
> 
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 217 ++++++++++++++++++
>>   1 file changed, 217 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> index b2b744bb8a53..f1f93fc4fa2d 100644
>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> 
>> @@ -346,6 +378,163 @@ edp_bl_pwm: edp-bl-pwm-state {
>>   	};
>>   };
>>   
>> +&soc {
>> +	wcd938x: codec {
>> +		compatible = "qcom,wcd9380-codec";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&wcd_default>;
>> +		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
>> +		#sound-dai-cells = <1>;
>> +
>> +		vdd-buck-supply = <&vreg_s10b>;
>> +		vdd-rxtx-supply = <&vreg_s10b>;
>> +		vdd-io-supply = <&vreg_s10b>;
>> +		vdd-mic-bias-supply = <&vreg_bob>;
>> +		qcom,micbias1-microvolt = <1800000>;
>> +		qcom,micbias2-microvolt = <1800000>;
>> +		qcom,micbias3-microvolt = <1800000>;
>> +		qcom,micbias4-microvolt = <1800000>;
>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +		qcom,rx-device = <&wcd_rx>;
>> +		qcom,tx-device = <&wcd_tx>;
>> +	};
>> +};
> 
> Please move all the sound nodes above the "/* PINCTRL */" marker and try
> to maintain the sort order (by node name).

Yes, I did miss this indeed, its now fixed in v3.

Will send v3 along with other fixes.

--srini
> 
>> +
>> +&sound {
> 
> ...
> 
>> +};
>> +
>> +&swr0 {
>> +	left_spkr: wsa8830-left@0,1 {
>> +		compatible = "sdw10217020200";
>> +		reg = <0 1>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&spkr_1_sd_n_default>;
>> +		powerdown-gpios = <&tlmm 178 GPIO_ACTIVE_LOW>;
>> +		#thermal-sensor-cells = <0>;
>> +		sound-name-prefix = "SpkrLeft";
>> +		#sound-dai-cells = <0>;
>> +		vdd-supply = <&vreg_s10b>;
>> +	};
>> +
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
> Stray newline.
> 
>> +&swr1 {
>> +	status = "okay";
>> +
>> +	wcd_rx: wcd9380-rx@0,4 {
>> +		compatible = "sdw20217010d00";
>> +		reg = <0 4>;
>> +		qcom,rx-port-mapping = <1 2 3 4 5 6>;
>> +
> 
> Stray newline.
> 
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
> 
> Please try to keep the nodes sorted by name (i.e. move it last).
> 
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
>>   			pins = "gpio182";
> 
> Johan
