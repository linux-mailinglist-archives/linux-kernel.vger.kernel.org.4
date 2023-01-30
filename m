Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A753681FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjA3Xur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjA3Xup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:50:45 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AD32E0F8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:50:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so36898057ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CdvsgrA7Oj6v+pII1HiNSeqEHAP6/ZI2lwGFyGvAsVo=;
        b=tVYM9mla89v6h9OfFJ28dH2M4ZDks3lAvzO9SVJu1Ka6s/vkom70IHE0p5q49UOCFF
         lcan7e2Gj5FSDUDe2P24iDG8tXKJK4xIldHuQXaBUZR8D8e2aSW9xfFPy/vRgfJ2Zbv5
         WlmReiaewmzxqZg6myB8M6amgfobV8b09t2C7G/uZnKexMDy6fz8Jfcjmii33nUgzWA3
         8hW9Ih1KamU9QEUl0rLPXbzqPG0fBg1FLI9Q2tfo3EsA0uK7jC+/VJi7tz9cLmVuH9/9
         uryy7MUv/uPnQN1totDd2kaiTGpSyHKD9zDuFnqD99oJt7Y7yDnVN45hhWiX+M9IcEnD
         hobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CdvsgrA7Oj6v+pII1HiNSeqEHAP6/ZI2lwGFyGvAsVo=;
        b=a9dVNOCw8iaLG3Jx+EuJkwoTsA5aZXtC77WzBDukEkQd3Nk8r0en/1W0WN7uv0U6sh
         he1BPbwF7/dhar6De8FFm0YKrraxji91blVmNcy45O71B+3bjQA/VCnpe+q+K8h54rYu
         Ie7zM+PKuu5G0412H+wE3lr3vzHpA+TvErFJfChp0W3e4Q5dxFruUK+XTHiaEW7KC/Vp
         AQAvpxhRXlXtCwzCAUglHQ+bsuO6yL3g5Mzwd2bgxR1/BX1358iRjeSxfvs9fDuqrHly
         qbWcymQwhTwDZ+Y+EdYeeCDhDKJdnkZQsiS/aoVRBUMY1Mo6HJSUdVMK3sqVXi3ip9sa
         0CAQ==
X-Gm-Message-State: AO0yUKXcJJxOTmEngaeJSGu8SQVGGznd2HMB2+JibWmULRPudx5nc/XR
        HegCeM0y1DHrYBfW/alK6ivNMA==
X-Google-Smtp-Source: AK7set/R03RcQsWZDYsuBbf4+cDKPgc0v65LKBW157TWbbBEU6KqM2q+lfaQITm6rV7drKYB4ApuwQ==
X-Received: by 2002:a17:906:58d6:b0:878:5372:a34b with SMTP id e22-20020a17090658d600b008785372a34bmr25791758ejs.45.1675122639006;
        Mon, 30 Jan 2023 15:50:39 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id w9-20020a170906184900b007c0f217aadbsm7421143eje.24.2023.01.30.15.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 15:50:38 -0800 (PST)
Message-ID: <f3f70ac2-d097-b6ee-22d3-92fcfdd7c53f@linaro.org>
Date:   Tue, 31 Jan 2023 00:50:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [RFC PATCH 1/2] dt-bindings: pincfg-node: Introduce an
 overridable way to set bias on pins
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230130165435.2347569-1-konrad.dybcio@linaro.org>
 <CACRpkdZjAyLUg3V7ZTzeMfUOTrndLrRX_gTFdO+amSmZkzB72Q@mail.gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CACRpkdZjAyLUg3V7ZTzeMfUOTrndLrRX_gTFdO+amSmZkzB72Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31.01.2023 00:10, Linus Walleij wrote:
> On Mon, Jan 30, 2023 at 5:54 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> 
>> We came to a point where we sometimes we support a few dozen boards
>> with a given SoC. Sometimes, we have to take into consideration
>> configurations which deviate rather significatly from the reference
>> or most common designs. In the context of pinctrl, this often comes
>> down to wildly different pin configurations. While pins, function and
>> drive-strength are easily overridable, the (mostly) boolean properties
>> associated with setting bias, aren't. This wouldn't be much of a
>> problem if they didn't differ between boards so often, preventing us
>> from having a "nice" baseline setup without inevitably having to go
>> with an ugly /delete-property/.
> 
> I see what the problem is.
> 
> Have you considered pulling out *all* the pin config for a certain
> reference design into its own .dtsi file, simply? And then not include
> that to the next product.
> 
> This pattern is pretty common.
It's *a* solution, but we already have some soc-pmics.dtsi-s which
include PMICs and reference regulator-to-peripherals assignments.
Adding another soc-reference-pins.dtsi would open the doors for
other soc-abcxyz.dtsi-s which would in turn lead to exchanging the
problem of redefining the same sets of properties 50 times to
having to include 20 device trees for each and every device. Allow
that and we basically have msm-3.10 except in torvalds/linux.

Adding to that, some devices are 98% compliant with the reference
designs, but randomly swap out one pin etc.

> 
>> Introduce bias-type, a bias-type-
>> specific property and clone the pinconf-generic type enum into
>> dt-bindings to allow for setting the bias in an easily overridable
>> manner such as:
>>
>> // SoC DT
>> i2c0_pin: i2c0-pin-state {
>>         pins = "gpio10";
>>         function = "gpio";
>>         bias-type = <BIAS_PULL_UP>;
>> };
>>
>> // Deviant board DT
>> &i2c0_pin {
>>         bias-type = <BIAS_HIGH_IMPEDANCE>;
>> };
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> The idea is pretty straight-forward.
> 
> But it applies to systems already using the bool flags. So what do
> we do the day we manage to have:
> 
> {
>     bias-type = <BIAS_HIGH_IMPEDANCE>;
>     bias-pull-up;
> };
> 
> As you see this makes it necessary to author some really nasty
> YAML to make sure this cannot happen or everyone has to make
> a runtime check for it.
oneOf:
- bias-type
- enum:
    - bias-pull-down
    - bias-...

Doesn't seem really nasty to me.. And a runtime check is basically
in place, as I made sure the code in 2/2 prefers bias-type and falls
back to the existing mechanism if it's not found.

> 
> Another problem is that I was just discussing with Bjorn for some
> specific i2c pull-up, was actually using the argument for
> bias-pull-up with a parameter:
> 
> bias-pull-up = <8000000>;  // 8kOhm pull-up
This is an easy fix. Count the elements and if there's more than
one, pass the second one as a value. Both of these things already
have common of_ functions made just for that.

> 
> Not to mention that other platforms than qcom use this and
> qcom use it for drive-strength I think?
> 
> +#define DRIVE_STRENGTH                 9
> +#define DRIVE_STRENGTH_UA              10
> 
> drive-strength = <8>; // 8mA drive strength
> 
> bias-type = <DRIVE_STRENGTH>;
> 
> OK where do I put my 8 mA now?
If you look at the 2/2 patch, this property only reads BIAS_
values, which can't coexist anyway. I copied the entire enum
for completeness. But if we were to go with this approach,
having one for (in|out)put-*, where only having one of them
at a time makes sense could be beneficial too..

Konrad
> 
> Yours,
> Linus Walleij
