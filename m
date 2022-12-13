Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCAD64B956
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiLMQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbiLMQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:13:18 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73371A05D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:13:16 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id bp15so5666766lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 08:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTHFFzZQr0D0s/TddQwmyWpE56rA5HP2motUuyby9M0=;
        b=ldysZifELvLGnjG6hYBNuNfpC+0HP54PjSah4EQ5n5X2+eeYz8u8jG0mPdZtK/eTmR
         4HsyVpMnS4Hxfp4lQatvpvMxOYxa9trXrlZFOp3HHk+D8XAAvZ2XbUVu/5QGMMYO0hh9
         5ga6z4Z6UG3fR2/sb9E2kVZMduFS7XzDYRwUj/Mc7TkkDQ3lf+r8Kb4ut27tEKvilYAp
         xpD80fhJvPlX/ScsqY3h3oQAOEYlB95wUJi961h8q4dMSAXzoTCqBnrMK3Y72yKhQL93
         gftJJvyhbUGZN37TsaSrpdiLbWALvHRXXn+DfJszgg4m2B3cZzlGaNxo4gFn1FiSLCaI
         GqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTHFFzZQr0D0s/TddQwmyWpE56rA5HP2motUuyby9M0=;
        b=ApkPY2vCi7mSPSZ+4FI97cmLajqmegVvgFAOr/8mDOWE32kqBWtz4f5hjwi7HvO0o5
         jAiXJ8NyLIPOJV8J0kqGww99uhKke82Bfg9etdnuSZsWzpGeAlq/jx6DIvH+Ozqs6GmF
         7nSmnW7kWhGmi/ReFzxWjesgIdMwSK6VcEuRcIhDi9IAbCybiMfq1sDdALYMTR9G+8K+
         cYIhJShxC3MxonDonNcU6ryYRyoQZOipchLwq5oeqM1OlmE1ZMiGKWpi2HO6mzF38fAW
         GJKsLCwhuKjwhGkGpm/dM4TLC3AAS5CjomFYzcw09Wv7g8t04ES+YICV2J8i89/FYvd/
         g+uQ==
X-Gm-Message-State: ANoB5pnegCOjD6VAmTropJpILYSsdnRe438NWPYmzYwU004qCoS8XJky
        6wYQbboyqfbrD2p1TAZfCVJ2LQ==
X-Google-Smtp-Source: AA0mqf56BC3tFEz26JjphXioBNUiiagbJ08QbY1qKzcbJQ8xTgAcKWEhWw0FXQonhqJWpolB6cPrcg==
X-Received: by 2002:a05:6512:6d1:b0:4b1:8830:85e8 with SMTP id u17-20020a05651206d100b004b1883085e8mr6855783lff.26.1670947995148;
        Tue, 13 Dec 2022 08:13:15 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a2-20020a2eb542000000b0026df5232c7fsm309641ljn.42.2022.12.13.08.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 08:13:14 -0800 (PST)
Message-ID: <183329b4-b99c-862b-02fe-651e5f68707e@linaro.org>
Date:   Tue, 13 Dec 2022 17:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 06/12] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
 <20221213154049.GA1426116-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213154049.GA1426116-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2022 16:40, Rob Herring wrote:
> On Mon, Dec 12, 2022 at 05:35:26PM +0100, Krzysztof Kozlowski wrote:
>> Merge Qualcomm MSM timer bindings into watchdog, because the timer
>> compatibles are already included here and the hardware is quite similar.
>>
>> While converting the MSM timer bindings, adjust clock-frequency
>> property to take only one frequency, instead of two, because:
>> 1. DT schema does not allow to frequencies,
>> 2. The Linux timer driver reads only first frequency.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/timer/qcom,msm-timer.txt         | 47 ------------------
>>  .../bindings/watchdog/qcom-wdt.yaml           | 49 +++++++++++++++++++
>>  2 files changed, 49 insertions(+), 47 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
>> deleted file mode 100644
>> index 5e10c345548f..000000000000
>> --- a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
>> +++ /dev/null
>> @@ -1,47 +0,0 @@
>> -* MSM Timer
>> -
>> -Properties:
>> -
>> -- compatible : Should at least contain "qcom,msm-timer". More specific
>> -               properties specify which subsystem the timers are paired with.
>> -
>> -               "qcom,kpss-timer" - krait subsystem
>> -               "qcom,scss-timer" - scorpion subsystem
>> -
>> -- interrupts : Interrupts for the debug timer, the first general purpose
>> -               timer, and optionally a second general purpose timer, and
>> -               optionally as well, 2 watchdog interrupts, in that order.
>> -
>> -- reg : Specifies the base address of the timer registers.
>> -
>> -- clocks: Reference to the parent clocks, one per output clock. The parents
>> -          must appear in the same order as the clock names.
>> -
>> -- clock-names: The name of the clocks as free-form strings. They should be in
>> -               the same order as the clocks.
>> -
>> -- clock-frequency : The frequency of the debug timer and the general purpose
>> -                    timer(s) in Hz in that order.
>> -
>> -Optional:
>> -
>> -- cpu-offset : per-cpu offset used when the timer is accessed without the
>> -               CPU remapping facilities. The offset is
>> -               cpu-offset + (0x10000 * cpu-nr).
>> -
>> -Example:
>> -
>> -       timer@200a000 {
>> -               compatible = "qcom,scss-timer", "qcom,msm-timer";
>> -               interrupts = <1 1 0x301>,
>> -                            <1 2 0x301>,
>> -                            <1 3 0x301>,
>> -                            <1 4 0x301>,
>> -                            <1 5 0x301>;
>> -               reg = <0x0200a000 0x100>;
>> -               clock-frequency = <19200000>,
>> -                                 <32768>;
>> -               clocks = <&sleep_clk>;
>> -               clock-names = "sleep";
>> -               cpu-offset = <0x40000>;
>> -       };
>> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> index b7fc57f4800e..697caf1937cc 100644
>> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
>> @@ -10,6 +10,9 @@ maintainers:
>>    - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>  
>>  properties:
>> +  $nodename:
>> +    pattern: "^(watchdog|timer)@[0-9a-f]+$"
>> +
>>    compatible:
>>      oneOf:
>>        - items:
>> @@ -48,6 +51,20 @@ properties:
>>    clocks:
>>      maxItems: 1
>>  
>> +  clock-names:
>> +    items:
>> +      - const: sleep
>> +
>> +  clock-frequency:
>> +    description:
>> +      The frequency of the general purpose timer in Hz in that order.
> 
> 'in that order'?

Left over, as I initial binding had here two frequencies. I'll remove it.

> 
>> +
>> +  cpu-offset:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description:
>> +      Per-CPU offset used when the timer is accessed without the CPU remapping
>> +      facilities. The offset is cpu-offset + (0x10000 * cpu-nr).
>> +
>>    interrupts:
>>      minItems: 1
>>      maxItems: 5
>> @@ -67,12 +84,27 @@ allOf:
>>              const: qcom,kpss-wdt
>>      then:
>>        properties:
>> +        clock-frequency: false
>> +        cpu-offset: false
>>          interrupts:
>>            minItems: 1
>>            items:
>>              - description: Bark
>>              - description: Bite
>>  
>> +    else:
>> +      properties:
>> +        interrupts:
>> +          minItems: 3
>> +          items:
>> +            - description: Debug
>> +            - description: First general purpose timer
>> +            - description: Second general purpose timer
>> +            - description: First watchdog
>> +            - description: Second watchdog
> 
> Okay, here they are. No need to set it to 2 then change to 5 in the 
> series.

My previous patch where you noticed the difference sets it to maxItems:5
in top-level and only specific variant has two described interrupts.

So if I understand your comment correctly, it is okay and I will just
fix the clock-frequency description ("in that order").

Best regards,
Krzysztof

