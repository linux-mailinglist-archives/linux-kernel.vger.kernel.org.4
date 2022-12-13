Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86EB64B329
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLMKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbiLMKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:23:16 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B8EF69
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:23:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b13so4159135lfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8phRAs4VxLeXM30VhIXOVy1FLv/sabkEs4Ulbx1ACsk=;
        b=DoZbYrm+mRTsgJ4Opi835UDO6x0OjpVpH8BGmOvYOmdBFEvU4g7qe6xLhrBSgVuvJx
         QV9adWHfXYwluoopDA7m/uQV/JuujSURodWNm2QiJmtGHvlmfvAo+8vpzTMLnEZGvdFR
         KUedqUcS2NWlr1fG5pOjRuL2aJ9aw6aggm3RmJtZIUzmV6bARHYfCZP1Lc0EPZef0tG2
         mnQKPTCHDdXkYVy1a5cwLlVQV8LucKSfA5yUo+jS872q7Hkr6Csu6dT0580tbbnLHvIo
         84ABO9LZhqlsl95e8zXjNg+ixEijeVOqobfmmqqlRt3WrdgQOlNTP0GmdJTQcA+xKxN7
         MSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8phRAs4VxLeXM30VhIXOVy1FLv/sabkEs4Ulbx1ACsk=;
        b=vM9oWV5Lz2zfHTeGFEYjYNgkS8yC7C8iUXuH1WfSKktI+mnmlwEBLjiceg+pcJNlTd
         KXBRGT/2aFa98j5lH56VluBJxIBBDFMSiPIcoNYz+iHCzSZiPq9j68vK5DXHndP6bJof
         lwDDWJkiI4kJEECIUPv1QD5MAbOcRO+0eLKhTfnt6t9l2k5KxCdKH8QUJwqxfUsI328g
         xYquJmmR1UXsxZkKdItpkcwYnEo0oJbliz8MntFgjbLadzQdPnYLJPwP4mNvbtvQ6wYa
         UmUhINW1xqGp4HzcLkLZSiWwA9w5iY8cZxd22A7UQe4r+kadsW/xXX893ztYGEcL5UWT
         kTUA==
X-Gm-Message-State: ANoB5pnx//h/bbWGJgdsTgS0uf7MeObwKwe7wfSL18f1RmDcteLI7dat
        VxRIaS0MNLVYcdoBVLRnNSMwkQ==
X-Google-Smtp-Source: AA0mqf4yVNrMzZx2LkTnhWlkRn7FFmzl2kpkpB79EgBT+uPRPx2bRUhMAQ+fS0Jw4Q9bLlnC9FOubw==
X-Received: by 2002:ac2:4151:0:b0:4b6:f4bb:e53b with SMTP id c17-20020ac24151000000b004b6f4bbe53bmr759084lfi.36.1670926993995;
        Tue, 13 Dec 2022 02:23:13 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id v11-20020ac258eb000000b004b5831b69dcsm300899lfo.140.2022.12.13.02.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 02:23:13 -0800 (PST)
Message-ID: <0c6bad50-500c-00b0-30c3-853b0c0a6d5e@linaro.org>
Date:   Tue, 13 Dec 2022 11:23:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221210133850.3664-1-konrad.dybcio@linaro.org>
 <20221213090349.bvatkmozbf5tjsxc@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213090349.bvatkmozbf5tjsxc@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 10:03, Marijn Suijten wrote:
> On 2022-12-10 14:38:50, Konrad Dybcio wrote:
>> With enough pins set properly, the hardware buttons now also work
>> like a charm.
>>
>> Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III
> 
> However I also tested this on Xperia 1 III, and...
> 
>> ---
>>  .../qcom/sm8350-sony-xperia-sagami-pdx214.dts | 24 ++++++++++
>>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 47 ++++++++++++++++++-
>>  2 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>> index e6824c8c2774..6fa830bdc6bd 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>> @@ -10,6 +10,20 @@
>>  / {
>>  	model = "Sony Xperia 5 III";
>>  	compatible = "sony,pdx214-generic", "qcom,sm8350";
>> +
>> +	gpio-keys {
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
>> +
>> +		key-google-assist {
>> +			label = "Google Assistant Key";
>> +			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
>> +			linux,code = <KEY_LEFTMETA>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			gpio-key,wakeup;
>> +		};
>> +	};
> 
> ... please move this to board DTS.  Xperia 1 III would also like to have
> it mapped.  Downstream DT indicates, and my local testing confirms, that
> it is identical to Xperia 5 III (i.e. common to the Sagami board).
> 
> The other buttons work great on both devices!
While I'd agree that having it like that would be nice for completeness,
it's:

- not necessary, as the button is not physically there, so the user will
never come into contact with it

- it will leak power, the plan is to park all unused pins after we get
"good enough" support for our devices (not now, so as not to mess with
ourselves in the dev process)

Konrad
> 
>>  };
>>  
>>  &framebuffer {
>> @@ -18,6 +32,16 @@ &framebuffer {
>>  	stride = <(1080 * 4)>;
>>  };
>>  
>> +&pm8350_gpios {
>> +	g_assist_n: g-assist-n-state {
>> +		pins = "gpio9";
>> +		function = "normal";
>> +		power-source = <1>;
>> +		bias-pull-up;
>> +		input-enable;
>> +	};
>> +};
>> +
> 
> (And this too, of course)
> 
> - Marijn
> 
>>  &pm8350b_gpios {
>>  	gpio-line-names = "NC", /* GPIO_1 */
>>  			  "NC",
>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> index d73e1f3fa501..557b4538a031 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
>> @@ -49,7 +49,26 @@ framebuffer: framebuffer@e1000000 {
>>  	gpio-keys {
>>  		compatible = "gpio-keys";
>>  
>> -		/* For reasons still unknown, GAssist key and Camera Focus/Shutter don't work.. */
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n>;
>> +
>> +		key-camera-focus {
>> +			label = "Camera Focus";
>> +			linux,code = <KEY_CAMERA_FOCUS>;
>> +			gpios = <&pm8350b_gpios 8 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			gpio-key,wakeup;
>> +		};
>> +
>> +		key-camera-snapshot {
>> +			label = "Camera Snapshot";
>> +			linux,code = <KEY_CAMERA>;
>> +			gpios = <&pm8350b_gpios 5 GPIO_ACTIVE_LOW>;
>> +			debounce-interval = <15>;
>> +			linux,can-disable;
>> +			gpio-key,wakeup;
>> +		};
>>  
>>  		key-vol-down {
>>  			label = "Volume Down";
>> @@ -547,11 +566,37 @@ &pm8350_gpios {
>>  			  "PM8350_OPTION"; /* GPIO_10 */
>>  };
>>  
>> +&pm8350b_gpios {
>> +	snapshot_n: snapshot-n-state {
>> +		pins = "gpio5";
>> +		function = "normal";
>> +		power-source = <0>;
>> +		bias-pull-up;
>> +		input-enable;
>> +	};
>> +
>> +	focus_n: focus-n-state {
>> +		pins = "gpio8";
>> +		function = "normal";
>> +		power-source = <0>;
>> +		input-enable;
>> +		bias-pull-up;
>> +	};
>> +};
>> +
>>  &pmk8350_gpios {
>>  	gpio-line-names = "NC", /* GPIO_1 */
>>  			  "NC",
>>  			  "VOL_DOWN_N",
>>  			  "PMK8350_OPTION";
>> +
>> +	vol_down_n: vol-down-n-state {
>> +		pins = "gpio3";
>> +		function = "normal";
>> +		power-source = <0>;
>> +		bias-pull-up;
>> +		input-enable;
>> +	};
>>  };
>>  
>>  &pmk8350_rtc {
>> -- 
>> 2.38.1
>>
