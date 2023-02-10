Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3EA692044
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjBJNyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBJNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:54:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951B2241FA
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:53:58 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id m2so16001678ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 05:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTgaNvNSBXacoigODkFGC4lM/nCnl6tx2W6/KFPue5E=;
        b=TBP/5WZs44JJu17WijTEUoTCSiV5LffIEdKbnA5WkCSsQfMx0VH3DZxnPlU6+FoI3t
         p23hA7dQE3PV/ry/MABbn05OvV0Uz8pja1+bIlySBJ0CEpt8gaJaaZMVLApXb/QwoLhz
         +NEbXbVgowHFKwHtZ5MX5j1aUmBQU1uc9DWGxTsdXNlDNjfK9anQOEUbak9xqKSUZ8f3
         Pm3rdVqhw2Yna8kXv6+R0eyuiWPE3C9Ih+MQfjKk8Qph+zDuEb/XCBBu/1gwA4ewISQX
         uDwue6aDcz2HSCHLgh+0CFk6MlZPObsP6stfjFYRh8sQJi/zJ/ANI6ll8KMshUp3I+Ng
         gshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wTgaNvNSBXacoigODkFGC4lM/nCnl6tx2W6/KFPue5E=;
        b=XvdA+uO0XWK5u2yi4WL70szA2vk4lZfwtkk8+densd7Ilde1Iqfd0d6NPT5Tmx8JLn
         5SipnK39f4tRhNnN8WmFE/2Xo0KXecSx75Ftj7jQljhPULS3LEsnVCTk/PzXc9wkv9ik
         mA3S36m0M+MYWeX2/kq5IFN0adr1vt+gTmkl7u/W/zOETc7GltXaM7OAcrwlNMbhJFYC
         7vwK2j7I8e3+EQ7m5s6Uvg5sG2e7DDo2IqP4m0qgjYUjjZGDI0gp0ONZtaDSfLOAKyT4
         OitX4TWFWt88JjdS3jmM5fX9FN+IF8f1zsTJQZ2TSe1zAVve1wEaMVOnMKTVWnfTuU26
         Aopg==
X-Gm-Message-State: AO0yUKVwpP11+tq8CUYZAo+7yqgmJ0q0n4z5UZl+VeofMxezqQ8QpAtZ
        P6C8VRW9eGCeBaSkueaEQiA1oA==
X-Google-Smtp-Source: AK7set98zYl2amDorB/c04/44wkpCjMLbHA3ZdridMJU7kVz2p/YRsGqCL7LbTKESHSin/DPZKCPkQ==
X-Received: by 2002:a17:906:1c90:b0:878:7291:d558 with SMTP id g16-20020a1709061c9000b008787291d558mr15473819ejh.34.1676037237153;
        Fri, 10 Feb 2023 05:53:57 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b0084d35ffbc20sm2399729ejo.68.2023.02.10.05.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 05:53:56 -0800 (PST)
Message-ID: <6942b30a-3d97-c306-a3c5-6b5adae5e814@linaro.org>
Date:   Fri, 10 Feb 2023 14:53:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add
 tri-state-key
Content-Language: en-US
To:     Gergo Koteles <soyer@irl.hu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
References: <20230209232556.91554-1-soyer@irl.hu>
 <dd77a886-5ab4-c6d3-bb84-5849c411aa7b@linaro.org>
 <59ea3842-1c9d-11d1-8dd9-17d5d2308357@irl.hu>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <59ea3842-1c9d-11d1-8dd9-17d5d2308357@irl.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 14:45, Gergo Koteles wrote:
> On 2023. 02. 10. 12:33, Krzysztof Kozlowski wrote:
>> On 10/02/2023 00:25, Gergo Koteles wrote:
>>> The tri-state-key is a sound profile switch found on the OnePlus 6,
>>> Android maps the states to "mute", "vibrate" and "ring". Expose them as
>>> ABS_SND_PROFILE events.
>>> The previous GPIO numbers were wrong. Update them to the correct
>>> ones.
>>>
>>> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
>>> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
>>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>>
>> Where are other patches? I got only 3/3.
>>
> Hi Krzysztof,
> 
> Sorry, I missed the --thread option for git format-patch.
> 
>>> ---
>>>   .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 ++++++++++++++++++-
>>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>>> index 64638ea94db7..e45d4fdead82 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
>>> @@ -52,6 +52,43 @@ key-vol-up {
>>>           };
>>>       };
>>>   +    tri-state-key {
>>> +        compatible = "gpio-keys";
>>> +        label = "Tri-state key";
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&tri_state_key_default>;
>>
>> Missing blank line.
>>
> 
> I'll add it to v3.
While at it, please put pinctrl-names after pinctrl-0.

> 
>>> +        state-top {
>>
>> Does not look like you tested the DTS against bindings. Please run `make
>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>> for instructions).
>>
> 
> I ran dtbs_check with DT_SCHEMA_FILES=Documentation/devicetree/bindings/arm/qcom.yaml. It only shows warnings for msm8996-oneplus3, but not for sdm845-oneplus phones. Is there anything else I need to check?
You're only checking against a schema file which validates msm-id and
machine compatibles. The goal is to not introduce *any* new warnings.

You want to run:

make (your make args) CHECK_DTBS=1 qcom/sdm845-oneplus-enchilada.dtb

pre and post your patch.

Konrad

> 
> 
> ...
> arch/arm64/boot/dts/qcom/msm8996-oneplus3.dtb: /: qcom,board-id: 'oneOf' conditional failed, one must be fixed:
>     [8, 0, 15801, 15, 8, 0, 15801, 16] is too long
>     From schema: /Documentation/devicetree/bindings/arm/qcom.yaml
> ...
>   DTC_CHK arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
>   DTC_CHK arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
> 
> 
> Thanks,
> Gergo
> 
>>
>> Best regards,
>> Krzysztof
>>
> 
