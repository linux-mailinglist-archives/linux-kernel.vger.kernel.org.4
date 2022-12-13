Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229D664B40A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiLMLU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiLMLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:20:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE192E4F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:20:21 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x28so4362569lfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLFxPFNWjIj4ZBxPSnXyiFyU0tfel3refSqsW9jEGvc=;
        b=f8d7jTuiJHqiz27UEXrHgx2ge0rv4eph4e/P4OuMN9N1dxlAlwxnq1XuTgeZDjO98t
         gvsdOloXDH82NmlhpQUJMGF3THi4UClS40mT7mXdLfUOAhmzjGWYwvsm6sPHLaCF2FLx
         p1BZJNYnr78e6p+KNKnXhEDVlyYlOLDHHdX4Kj3aGtwUMp0k/pZmWH8Rf/TUKEVFN8Ar
         qiKUsbv+U1bsJ6/sSPwZjfVvk4vRcytO6SCh1vlVryw+iCDCtpyqLGbAJB4fLJQ6CkfS
         pURjUdGFzZeqNUNc4rI8diG01djNbaFmHuySGVg+ph+DpnJUPpYKX4ZOUag6sUa6GjgX
         MCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLFxPFNWjIj4ZBxPSnXyiFyU0tfel3refSqsW9jEGvc=;
        b=BUW+fhCjcMJHt7siYE3cCrJQ78Rxyho7ksSEU3SKwRZeQBLMn34BLc5eO9WljuGi2R
         55r8/6GmUIvkBjomKHxBxO9pXpHY4DWZBUozsrKcO9cjx2WmmHDUwHKMvnmpBxd9Ewfz
         qistdP/mWxk3EpcYRxzxkCu3OcR3bF4Twf8B1n1YG4RRPajItevI5jb0O7SIRMDW+nob
         zwAlfjLgQSA/f0CP4VPrDv/n1EYhae7xYuA+yXzSxZs9YeBbINSd4AL2Q5B6ANQr5vkI
         mVkzOxFUvQ5OAYpWmKHoyYEgKZCZCCL86zpEhda31f/QasiEYpQ/ejSePqv0sHeJbkLp
         N14g==
X-Gm-Message-State: ANoB5pksAP5BKtKx5TrL/LY41UniBmuWgZchDg7CesXiENKUE9wZDcFE
        hpU7+csBSHmMYgiZ+d4hyzzJOg==
X-Google-Smtp-Source: AA0mqf7clquZNGkxhrTM3z0CD1eyfqyo0U313kqearEe+5JyXR5Xn2idQjFjifdJecX3syn6zM+n7w==
X-Received: by 2002:a19:7004:0:b0:4b5:834b:9f82 with SMTP id h4-20020a197004000000b004b5834b9f82mr5507150lfc.58.1670930420084;
        Tue, 13 Dec 2022 03:20:20 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id e29-20020a19691d000000b004b19f766b07sm328942lfc.91.2022.12.13.03.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 03:20:19 -0800 (PST)
Message-ID: <8299b28c-a2ca-2f6a-ee9a-20f19e2236aa@linaro.org>
Date:   Tue, 13 Dec 2022 12:20:18 +0100
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
 <0c6bad50-500c-00b0-30c3-853b0c0a6d5e@linaro.org>
 <20221213111119.g3lzt5heevfarvf7@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221213111119.g3lzt5heevfarvf7@SoMainline.org>
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



On 13.12.2022 12:11, Marijn Suijten wrote:
> On 2022-12-13 11:23:12, Konrad Dybcio wrote:
>>
>>
>> On 13.12.2022 10:03, Marijn Suijten wrote:
>>> On 2022-12-10 14:38:50, Konrad Dybcio wrote:
>>>> With enough pins set properly, the hardware buttons now also work
>>>> like a charm.
>>>>
>>>> Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>
>>> Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III
>>>
>>> However I also tested this on Xperia 1 III, and...
>>>
>>>> ---
>>>>  .../qcom/sm8350-sony-xperia-sagami-pdx214.dts | 24 ++++++++++
>>>>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 47 ++++++++++++++++++-
>>>>  2 files changed, 70 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>>>> index e6824c8c2774..6fa830bdc6bd 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
>>>> @@ -10,6 +10,20 @@
>>>>  / {
>>>>  	model = "Sony Xperia 5 III";
>>>>  	compatible = "sony,pdx214-generic", "qcom,sm8350";
>>>> +
>>>> +	gpio-keys {
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
>>>> +
>>>> +		key-google-assist {
>>>> +			label = "Google Assistant Key";
>>>> +			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
>>>> +			linux,code = <KEY_LEFTMETA>;
>>>> +			debounce-interval = <15>;
>>>> +			linux,can-disable;
>>>> +			gpio-key,wakeup;
>>>> +		};
>>>> +	};
>>>
>>> ... please move this to board DTS.  Xperia 1 III would also like to have
>>> it mapped.  Downstream DT indicates, and my local testing confirms, that
>>> it is identical to Xperia 5 III (i.e. common to the Sagami board).
>>>
>>> The other buttons work great on both devices!
>> While I'd agree that having it like that would be nice for completeness,
>> it's:
>>
>> - not necessary, as the button is not physically there, so the user will
>> never come into contact with it
> 
> I have the device in my hand right now and, unless I take an angle
> grinder to it, it has this button.
> 
> How else did you expect me to successfully test it?
> 
> Maybe you are confused with Xperia 1 IV, which does _not_ have the
> button.  Nor does Xperia 1 II, for that matter.
Lol yes I did, will send a v2..

Konrad
> 
> - Marijn
> 
>> - it will leak power, the plan is to park all unused pins after we get
>> "good enough" support for our devices (not now, so as not to mess with
>> ourselves in the dev process)
>>
>> Konrad
