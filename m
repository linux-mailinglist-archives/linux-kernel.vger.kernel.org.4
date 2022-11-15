Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7407A62A306
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbiKOUdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKOUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:33:06 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E6B3122E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:30:49 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w23so7784082ply.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VruM4CbTIOWzFMx0rxGuqPrwzvP7mA2aTck9eYJcn90=;
        b=fVp5FfgiqCHuyKWQmSsmfW7fMN91QNmKjM9t974RJ3KQETVgnF5Ot05IHAT+MJsK3q
         o6mwyQJXySlCDrk8IHbxo/Z+yUCD0f7YXhZ2tr0atS0gt6JFjeHPSbuT+dsChQ9nQemU
         YpuzBhYuOhH1sTIC8zGOlpLVk+5bd8WUjf2qQszSIf7+Fe237qpMsbbpu8KSUUOyXW6y
         MdPspjl83T1AFlAS/U0YSYxKhwwkASS00Sw5HnsxNlVRDYR3tOz8flE3EMnliljdcAeQ
         10dIVmo+NXpBsoVfwAXiAcQAXJNrPwi4elvMhsFmtjPG9gQZhkUBN6OfeQQSfMBVlqMA
         dDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VruM4CbTIOWzFMx0rxGuqPrwzvP7mA2aTck9eYJcn90=;
        b=ffpPdc/Arc9DxR3YusP8fN7P5EUXslq7oO/8Ec9sBaaMEyycvlZt8e+i16QvasK6vM
         qgcNlPvWsUt4n7TAlpOOzKF48z/7t9qxyvqNyGk4XwZdFZGCGLDoFLm9GGHqsQka/e9e
         6r29IAg5dgsI/Ep+PczGhPl3zBKW9GSxmtez+mUPzMCzativ3AKGfjRWQs5tvtqagnqS
         elshGnZs9mYzdtf+BxZ9ypQgFyG1dZX0RcbnpjB1UOte0Rxstn2lYuWtSl38+NrX/Rt8
         QC1Df6TYoqkJzG8sUmuMkKnfKeZX+5Tjy34PFH2LIxnhv9HG4cSQrvUMsIVSk0X53KVx
         VXHA==
X-Gm-Message-State: ANoB5pkGC4jLk0Db1nP/2xbw4pZ4PIKWoTOlkbScZPwCGshQi/mtOSk0
        5EQnyYiOAJZtEaWVrPahoKSPNA==
X-Google-Smtp-Source: AA0mqf6L/z5lIHZ+hIvsUNv+f/79D0F3jpzeUa0ZxfrVTezdYuEwUbgVfpAzAN5Ftu/o/J2nL/G+RA==
X-Received: by 2002:a17:902:e483:b0:188:b44b:598 with SMTP id i3-20020a170902e48300b00188b44b0598mr5754384ple.54.1668544248651;
        Tue, 15 Nov 2022 12:30:48 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id y188-20020a6364c5000000b00451f4071151sm7985842pgb.65.2022.11.15.12.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:30:48 -0800 (PST)
Message-ID: <d6be0d25-b7a2-fe6a-f653-d3b583c7202a@9elements.com>
Date:   Wed, 16 Nov 2022 02:00:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v10 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221115110932.637091-1-Naresh.Solanki@9elements.com>
 <20221115110932.637091-2-Naresh.Solanki@9elements.com>
 <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <87ba1b05-5b10-1925-838e-0099dabe0703@linaro.org>
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

Hi Krzysztof,

On 15-11-2022 07:34 pm, Krzysztof Kozlowski wrote:
> On 15/11/2022 12:09, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> The MAX597x is a hot swap controller with configurable fault protection.
>> It also has 10bit ADC for current & voltage measurements.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/mfd/maxim,max5970.yaml           | 154 ++++++++++++++++++
>>   1 file changed, 154 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> new file mode 100644
>> index 000000000000..edf0c23db4ca
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> @@ -0,0 +1,154 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/maxim,max5970.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Regulator for MAX5970 smart switch from Maxim Integrated.
>> +
>> +maintainers:
>> +  - Patrick Rudolph <patrick.rudolph@9elements.com>
>> +
>> +description: |
>> +  The smart switch provides no output regulation, but independent fault protection
>> +  and voltage and current sensing.
>> +  Programming is done through I2C bus.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
>> +    https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max5970
>> +      - maxim,max5978
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  leds:
>> +    type: object
>> +    description:
>> +      Properties for four LEDS.
>> +
>> +    properties:
>> +      "#address-cells":
>> +        const: 1
>> +
>> +      "#size-cells":
>> +        const: 0
>> +
>> +    patternProperties:
>> +      "^led@[0-3]$":
>> +        $ref: /schemas/leds/common.yaml#
>> +        type: object
>> +
>> +    additionalProperties: false
>> +
>> +  vss1-supply:
>> +    description: Supply of the first channel.
>> +
>> +  vss2-supply:
>> +    description: Supply of the second channel.
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      Properties for both regulators. Also set value for shunt resistor used.
> 
> You should explain not the syntax,  but what part of hardware this nodes
> represents. Therefore "Also set value" does not fit at all. Hardware
> sets value?
You mean something like: Properties for power switch
> 
> I looked at datasheets to figure it out but they do not refer to any
> configurable regulator, LDO nor "sw0/sw1/sw2". Therefore I have no clue
> what to expect here...
Yes this is for power switch part of max5970/8
> 
>> +
>> +    patternProperties:
>> +      "^sw[0-1]$":
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        type: object
>> +        properties:
>> +          shunt-resistor-micro-ohms:
>> +            description: |
>> +              The value of current sense resistor in microohms.
>> +
>> +        required:
>> +          - shunt-resistor-micro-ohms
>> +
>> +      unevaluatedProperties: false
> 
> I don't think it has proper indentation. Did you test the binding?
Definitely tested the bindings before I push the patch.
> 
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - regulators
>> +  - vss1-supply
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - maxim,max5970
>> +    then:
>> +      required:
>> +        - vss2-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        regulator@3a {
>> +            compatible = "maxim,max5978";
>> +            reg = <0x3a>;
>> +            vss1-supply = <&p3v3>;
>> +
>> +            regulators {
>> +                sw0_ref_0: sw0 {
>> +                    regulator-compatible = "SW0";
>> +                    shunt-resistor-micro-ohms = <12000>;
>> +                };
>> +            };
>> +
>> +            leds {
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                led@0 {
>> +                    reg = <0>;
>> +                    label = "led0";
>> +                    default-state = "on";
>> +                };
>> +                led@1 {
>> +                    reg = <1>;
>> +                    label = "led1";
>> +                    default-state = "on";
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        regulator@3a {
>> +            compatible = "maxim,max5970";
>> +            reg = <0x3a>;
>> +            vss1-supply = <&p3v3>;
>> +            vss2-supply = <&p5v>;
>> +
>> +            regulators {
>> +                sw0_ref_1: sw0 {
>> +                    regulator-compatible = "SW0";
> 
> This property is deprecated, isn't it? Again - did you test this?
Yes tested.
> 
> Best regards,
> Krzysztof
> 

Regards,
Naresh
