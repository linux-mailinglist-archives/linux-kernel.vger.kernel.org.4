Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8389E65B433
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjABP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjABP3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:29:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645D395BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:28:59 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bq39so34177309lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bwDErGdBpmuiNKoW53vnLaoISxeVPepRqpcp3byIgrc=;
        b=zQ37cJqIGFZgYeNttB09p0D/zQMq/WRthRYlZyHof2Aw2mA8cmR9o/6DUyuQjTJdYD
         BU+sMO79M40IrcjK0kvtFTUyACkUDKrn4aEcu1R2d6wA+yuEJZT/8pP85OGlYTrnwj0B
         N+lFwDftNw8H1G1IQZq6CNxpFO2D9O+TyCbJRASejR5LmSXv9Zrrlr8C94Z6Cl70k5Uf
         iKXunshdHsS41x2dO6vOc2mD+XqYm76u2HuwQcPsybL7Ed2O6s3A4m+BXTaBuYP/lfeY
         dlDhIDsk0vgpy/W60dLe0t/t9xKtlmdIYUZvhAR82+a3s53E9kohBjllC2QROv/3gcA9
         oogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwDErGdBpmuiNKoW53vnLaoISxeVPepRqpcp3byIgrc=;
        b=QuoCPqkheeQvUDpXY/4iaUo4dXvUs+9sMja8vB7ZnQkqOuNB5VUsJMON+4KLNFfuNC
         KmmFclNba7TkbrjDd3azd7+LsKV1sBxT6mkv+3d73M7UQGA/b1rk1jJBhczb6xuntdZE
         zZRcjfOs8SndZU57Gcbomx2vwKYGrQQ7Zfnmi964Sw43kVnzLsqDSnQcT8xdXqtzcU1q
         zu7Gvmb/qx/eBWa1q7OF+X3FtSjbtMqmQ64t3XkzCTTpLC/3aZdaV/l2s4Xe8iLUNxMp
         gnwlvZ3m1OiJetmocZMVyrQwXmQuOAXx9Kv5ZX4d0DGy1Q9TLhKzMSh/hKNbyWfBNS/E
         Eerw==
X-Gm-Message-State: AFqh2koWAOTsYZrwkGktSieKkG0yRrxRIGrlD1egOAYz4k2aooPACFTc
        HonXZ0SnHp3dU4/Uj5T6MrTZ6A==
X-Google-Smtp-Source: AMrXdXszHQueNaTzZwrBeQjoxwaFFPYI4ApLyoBCjQ4k585w0vQD7yleclFaFXqUtgh+cg1Cd7u+yg==
X-Received: by 2002:a05:6512:3f9c:b0:4b6:e4e7:624c with SMTP id x28-20020a0565123f9c00b004b6e4e7624cmr12904602lfa.0.1672673337741;
        Mon, 02 Jan 2023 07:28:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c8-20020a056512324800b00499aefcf68esm4522757lfr.292.2023.01.02.07.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:28:57 -0800 (PST)
Message-ID: <8bd6487a-3ae7-f7c1-e478-1effd68700d3@linaro.org>
Date:   Mon, 2 Jan 2023 16:28:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] arm64: dts: qcom: sc8280xp-x13s: disable soundcard
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-2-johan+linaro@kernel.org>
 <fc42801a-55d9-90b9-f7f0-48657ec7a373@linaro.org>
 <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
 <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
 <Y7L3OTs/u8FsH8o2@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7L3OTs/u8FsH8o2@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:24, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 04:12:35PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 16:07, Johan Hovold wrote:
>>> On Mon, Jan 02, 2023 at 01:25:38PM +0100, Krzysztof Kozlowski wrote:
>>>> On 02/01/2023 11:50, Johan Hovold wrote:
>>>>> Driver support for the X13s soundcard is not yet in place so disable it
>>>>> for now to avoid probe failures such as:
>>>>>
>>>>> [   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
>>>>> [   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
>>>>> [   21.221104] platform 3210000.soundwire-controller: deferred probe pending
>>>>>
>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>> ---
>>>>>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
>>>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>>>> index 0201c6776746..97ff74d5095e 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>>>> @@ -649,6 +649,8 @@ wcd938x: codec {
>>>>>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>>>>>  		qcom,rx-device = <&wcd_rx>;
>>>>>  		qcom,tx-device = <&wcd_tx>;
>>>>> +
>>>>> +		status = "disabled";
>>>>>  	};
>>>>>  };
>>>>>  
>>>>> @@ -669,6 +671,8 @@ &sound {
>>>>>  		"TX DMIC2", "MIC BIAS3",
>>>>>  		"TX SWR_ADC1", "ADC2_OUTPUT";
>>>>>  
>>>>> +	status = "disabled";
>>>>> +
>>>>>  	wcd-playback-dai-link {
>>>>>  		link-name = "WCD Playback";
>>>>>  		cpu {
>>>>> @@ -731,6 +735,8 @@ codec {
>>>>>  };
>>>>>  
>>>>>  &swr0 {
>>>>> +	status = "disabled";
>>>>> +
>>>>>  	left_spkr: wsa8830-left@0,1 {
>>>>>  		compatible = "sdw10217020200";
>>>>>  		reg = <0 1>;
>>>>> @@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
>>>>>  };
>>>>>  
>>>>>  &swr1 {
>>>>> -	status = "okay";
>>>>> +	status = "disabled";
>>>>>  
>>>>>  	wcd_rx: wcd9380-rx@0,4 {
>>>>>  		compatible = "sdw20217010d00";
>>>>> @@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
>>>>>  };
>>>>>  
>>>>>  &swr2 {
>>>>> -	status = "okay";
>>>>> +	status = "disabled";
>>>>
>>>> That's a double disable.
>>>>
>>>>>  
>>>>>  	wcd_tx: wcd9380-tx@0,3 {
>>>>>  		compatible = "sdw20217010d00";
>>>>> @@ -781,6 +787,8 @@ &vamacro {
>>>>>  	pinctrl-names = "default";
>>>>>  	vdd-micb-supply = <&vreg_s10b>;
>>>>>  	qcom,dmic-sample-rate = <600000>;
>>>>> +
>>>>> +	status = "disabled";
>>>>
>>>> That's a double disable.
>>>
>>> Yes, that's on purpose. We're temporarily disabling these nodes instead
>>> of reverting the series which should not have been merged.
>>
>> I don't get why disabling something twice is anyhow related to
>> "temporarily disable". One disable is enough for temporary or permanent
>> disables.
> 
> It clearly shows that this was done on purpose and indicates which
> properties need to be changed to "okay" once we have actual support.

No, it shows nothing clearly as from time to time we got duplicated
properties and it's a simply mistake. The double disable without any
comment looks like mistake, not intentional code.

>  
>>>
>>> Once we have driver support, these properties will be updated again.
>>
>> Linux kernel is not the only consumer of DTS, thus having or not having
>> the support in the kernel is not reason to disable pieces of it.
>> Assuming the DTS is correct, of course, because maybe that's the problem?
> 
> Okay, let's revert these sound dts changes then until we have support.
> We have no idea if the dts changes are correct as sound still depends
> on out-of-tree hacks.
> 
> People are using -next for development and I don't want to see them
> toast their speakers because we failed get the dependencies merged
> before merging the dts changes which is how we normally do this.

If the error is in DTS, yeah, revert or disable is a way. But if the
issue is in the incomplete or broken Linux drivers, then these should be
changed, e.g. intentionally fail probing, skip new devices, drop new
compatible etc.

> So shall I just send a revert instead? I really don't care as long as
> this is disabled again today.


Best regards,
Krzysztof

