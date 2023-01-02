Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5665B3E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbjABPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjABPMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:12:40 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C3283
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:12:38 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x37so22369153ljq.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USo7+f3T6DM+ZVI1Q+GwfwQEAaSUYJI+HYovM9KD9X8=;
        b=IxTwI1VBTqMyZCdsAhJiIEqmhedNzotq8y48+Toig6Nlo59NwtQvcktscc/3uTwAno
         0UC+y8d8BRXwNE/flgO5mX5QHQP1KvxPcppqphf3AG5VKPrQx3RPH/R0qVd2ObzAHj3I
         +SLky2QP6qRlWjjmwWMFL6TYgUiex8SwUoDd37S9CD7q2or6fL70c3hIciZtebAG0SJD
         v2+2ygFtmQ2tL2WNTyN6IQ/7Pd4TB5QBe0LBy8zdwTslFwfDDl50UmXRFyL/GouXuSrV
         aH7/300h8/QUQqW9QaeS3Vq57LFxVQqDJ0wR7gqiXP1KH1HRVW4tqKQvQYr17vagnQQc
         PL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USo7+f3T6DM+ZVI1Q+GwfwQEAaSUYJI+HYovM9KD9X8=;
        b=7Ym0C9DRXZsNqiZyq5gKuizbkfdFikAvo523KUsRY6MMgRuzrjIxlrQYvasGDid2b4
         NWv0U/CYcjaqo5+p3pBAp/PD4RileqT1nGAe/LLnSQzNjKIN4/VqXhkdSKUDbWSXgINO
         8XepLMkddepCNRnqzLqBYKzRbQeRsIJDMiK+FH1ZgTbwG+uIjpz6XuwTFlSMJ0F+vfzY
         dhuZ0RTZ2hiJd78R5sUxPnqVj0eQB4GNalg17VgmJvW40wyDOW6U3TuqKUtNKngFAqq7
         Lt97qLsddJ2WRlsoHG/F/P5Qdzutmu5QXnXoSStaE/Mo2/UAe5oorQrWldVYnGakAlB5
         BJhQ==
X-Gm-Message-State: AFqh2koZvSTKHvn4W6TIoI3SVMHA25RBhNa0Z4q+KaUtEgSlrdKvmGFU
        KxxbZ0cGhSmh5fPkvPREqeIfxQ==
X-Google-Smtp-Source: AMrXdXt+Qpu9ExRxv+oDn9n7W2hxpye50tkuldJ/5Sbg4docnm2onzmpd0cC/78DTUaEKVpRm1oOhA==
X-Received: by 2002:a05:651c:1073:b0:27f:e3af:8aae with SMTP id y19-20020a05651c107300b0027fe3af8aaemr3077259ljm.16.1672672357332;
        Mon, 02 Jan 2023 07:12:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w5-20020ac254a5000000b004b4bb6286d8sm4474057lfk.84.2023.01.02.07.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:12:36 -0800 (PST)
Message-ID: <81e3994e-49d9-ea5b-b055-cbcc737a6e37@linaro.org>
Date:   Mon, 2 Jan 2023 16:12:35 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7LzJ+RRzDNRf3jR@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:07, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 01:25:38PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 11:50, Johan Hovold wrote:
>>> Driver support for the X13s soundcard is not yet in place so disable it
>>> for now to avoid probe failures such as:
>>>
>>> [   11.077727] qcom-prm gprsvc:service:2:2: DSP returned error[100100f] 1
>>> [   11.077926] rx_macro: probe of 3200000.rxmacro failed with error -22
>>> [   21.221104] platform 3210000.soundwire-controller: deferred probe pending
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts  | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> index 0201c6776746..97ff74d5095e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
>>> @@ -649,6 +649,8 @@ wcd938x: codec {
>>>  		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>>>  		qcom,rx-device = <&wcd_rx>;
>>>  		qcom,tx-device = <&wcd_tx>;
>>> +
>>> +		status = "disabled";
>>>  	};
>>>  };
>>>  
>>> @@ -669,6 +671,8 @@ &sound {
>>>  		"TX DMIC2", "MIC BIAS3",
>>>  		"TX SWR_ADC1", "ADC2_OUTPUT";
>>>  
>>> +	status = "disabled";
>>> +
>>>  	wcd-playback-dai-link {
>>>  		link-name = "WCD Playback";
>>>  		cpu {
>>> @@ -731,6 +735,8 @@ codec {
>>>  };
>>>  
>>>  &swr0 {
>>> +	status = "disabled";
>>> +
>>>  	left_spkr: wsa8830-left@0,1 {
>>>  		compatible = "sdw10217020200";
>>>  		reg = <0 1>;
>>> @@ -757,7 +763,7 @@ right_spkr: wsa8830-right@0,2{
>>>  };
>>>  
>>>  &swr1 {
>>> -	status = "okay";
>>> +	status = "disabled";
>>>  
>>>  	wcd_rx: wcd9380-rx@0,4 {
>>>  		compatible = "sdw20217010d00";
>>> @@ -767,7 +773,7 @@ wcd_rx: wcd9380-rx@0,4 {
>>>  };
>>>  
>>>  &swr2 {
>>> -	status = "okay";
>>> +	status = "disabled";
>>
>> That's a double disable.
>>
>>>  
>>>  	wcd_tx: wcd9380-tx@0,3 {
>>>  		compatible = "sdw20217010d00";
>>> @@ -781,6 +787,8 @@ &vamacro {
>>>  	pinctrl-names = "default";
>>>  	vdd-micb-supply = <&vreg_s10b>;
>>>  	qcom,dmic-sample-rate = <600000>;
>>> +
>>> +	status = "disabled";
>>
>> That's a double disable.
> 
> Yes, that's on purpose. We're temporarily disabling these nodes instead
> of reverting the series which should not have been merged.

I don't get why disabling something twice is anyhow related to
"temporarily disable". One disable is enough for temporary or permanent
disables.

> 
> Once we have driver support, these properties will be updated again.

Linux kernel is not the only consumer of DTS, thus having or not having
the support in the kernel is not reason to disable pieces of it.
Assuming the DTS is correct, of course, because maybe that's the problem?

Best regards,
Krzysztof

