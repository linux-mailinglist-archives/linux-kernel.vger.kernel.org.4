Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0A05F57C1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 17:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJEPpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 11:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJEPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 11:45:48 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8E78BE3;
        Wed,  5 Oct 2022 08:45:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s206so15578827pgs.3;
        Wed, 05 Oct 2022 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=4ocK21qCE+ifPjNwPNOiAwnsHm5lGw5iKFsiqu1JLn8=;
        b=Rj5uwLDtTU7pO5v33Wy4z5iQ9J2OFhmRl1p2mlvHdkAxAsJNzr9y+yErv0K7J6VCcE
         eXwHocTpFFmy76Id9BSrnjDI35G3oUSAXPx4f8cvfCkVxRDUdN9JRmv1xd6yokLTLhfO
         w9AzHVwSFojT/Rm12GlRAHF1ZvHUDTTWjy2KQIRN3MYWFGZ81Pvjt1+O7lS0qBMO9TAy
         J/1rS1YSmdb5pn7hhRslX2Y2pg1l2CwMhK1JQFE4Bg+JCIaXVfuYe4ERr98rvjGK9VKB
         PebLO9MW0TC0nUhjYEpXHytsb7u60HXHb6lAdmSbwDO4AireNvUHErSzypyUQBQOTJVS
         eAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4ocK21qCE+ifPjNwPNOiAwnsHm5lGw5iKFsiqu1JLn8=;
        b=jQ8YQNF+XiNnrX4+94gJ8IUxu8p2XraIKYFJTiZ8AmJkTVOFzSqZ+rwdTRQfgoUtee
         LRv+9/dtsa5FKNb7DYdLiYYITC4gI5wl4wKGG0HVkDCoa7e7fNU9xTaeWZEnAIrZgr6e
         U2UvtN+A/GUlLNFqxUN1lLmaoGQKALzi8jgamAJh/1U5D+1+KFWZbXTl2dD9OVAeAE/S
         jEZhA5Nx7uUCiicjo6k+mPqN6PwbXBujCcippprNVA4XjREMpDQ5y8o+7HG3lEAKMKHv
         srGhbR0IJ2Csyp8HqkteBFE33tx7WmpHf6HEFkKXtH4UrsOvXtSvP/gkplPsJ5DjtS2m
         VgYw==
X-Gm-Message-State: ACrzQf2UB18HZdBgR1vyFN+AUHiDvrDNDR1zSE11498OaEZLfeY3HtcO
        iGWt3fyT/Jy0sPpk9XflJvY=
X-Google-Smtp-Source: AMsMyM7W8Te7qSDT7fHm1KWxUdnPzpYZPEKY6+L5cGx9bM1aHOLKCoiSaRUol9IK6VNNxZgqDCgvEQ==
X-Received: by 2002:a63:c14:0:b0:456:d887:c83 with SMTP id b20-20020a630c14000000b00456d8870c83mr383920pgl.53.1664984746289;
        Wed, 05 Oct 2022 08:45:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h7-20020a631207000000b0041cd2417c66sm9938151pgl.18.2022.10.05.08.45.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 08:45:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55a3f673-c204-f2b1-22bc-bf311a505adf@roeck-us.net>
Date:   Wed, 5 Oct 2022 08:45:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20220922050718.1079651-1-Naresh.Solanki@9elements.com>
 <20220922050718.1079651-2-Naresh.Solanki@9elements.com>
 <20220929193251.GA2606428-robh@kernel.org>
 <CABqG17hf7QhJuHO60V=ue8ev7cSnikr0nntkLAQkqnfyPc31xQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Add binding for max6639
In-Reply-To: <CABqG17hf7QhJuHO60V=ue8ev7cSnikr0nntkLAQkqnfyPc31xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 06:16, Naresh Solanki wrote:
> Hi Rob,
> 
> I can add common fan bindings.
> Below are the properties that I can think of:
> max-rpm, pulse-per-revolution
> Let me know what you think.
> 

For max6650, we have:

     maxim,fan-microvolt = <12000000>;
     maxim,fan-prescale = <4>;
     maxim,fan-target-rpm = <1200>;

The voltage can be handled with a regulator, so that won't be necessary.
Prescale (fan divider) values and target rpm seem relevant, though.
The sysfs ABI also permits a minimum rpm which also seems relevant
(lower speeds would indicate fan failures).

Then there are pwm specific parameters for pwm controlled fans.
     pwm polarity
     pwm frequency
     pwm mode (direct current or pulse-width modulation)

Guenter

> Regards,
> Naresh Solanki
> 
> 
> 
> On Fri, 30 Sept 2022 at 01:02, Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu, Sep 22, 2022 at 07:07:17AM +0200, Naresh Solanki wrote:
>>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>>
>>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>>> monitor with PWM fan-speed controller.
>>>
>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   .../bindings/hwmon/maxim,max6639.yaml         | 112 ++++++++++++++++++
>>>   1 file changed, 112 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> new file mode 100644
>>> index 000000000000..c845fb989af2
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>> @@ -0,0 +1,112 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +
>>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Maxim max6639
>>> +
>>> +maintainers:
>>> +  - Roland Stigge <stigge@antcom.de>
>>> +
>>> +description: |
>>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>>> +  fan-speed controller.  It monitors its own temperature and one external
>>> +  diode-connected transistor or the temperatures of two external diode-connected
>>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>>> +
>>> +  Datasheets:
>>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - maxim,max6639
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  '#address-cells':
>>> +    const: 1
>>> +
>>> +  '#size-cells':
>>> +    const: 0
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - "fan@0"
>>> +  - "fan@1"
>>> +
>>> +additionalProperties: false
>>> +
>>> +patternProperties:
>>> +  "^fan@[0-1]$":
>>> +    type: object
>>> +    description: |
>>> +      Represents the two fans and their specific configuration.
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: |
>>> +          The fan number.
>>
>> Addresses are a property of the parent (the fan controller), not the
>> fan.
>>
>>> +        items:
>>> +          minimum: 0
>>> +          maximum: 1
>>> +
>>> +      pwm-polarity:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        enum: [0, 1]
>>> +        default: 1
>>> +        description:
>>> +          PWM output is low at 100% duty cycle when this bit is set to zero. PWM
>>> +          output is high at 100% duty cycle when this bit is set to 1.
>>
>> IIRC, the PWM binding provides for this. The parent should probably be a
>> PWM provider.
>>
>>> +
>>> +      pulses-per-revolution:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        enum: [1, 2, 3, 4]
>>> +        default: 2
>>> +        description:
>>> +          Value specifying the number of pulses per revolution of the controlled
>>> +          FAN.
>>> +
>>> +      maxim,rpm-range:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +        enum: [2000, 4000, 8000, 16000]
>>> +        default: 4000
>>> +        description:
>>> +          Scales the tachometer counter by setting the maximum (full-scale) value
>>> +          of the RPM range for max6639.
>>
>> Is this a property of the fan? How is this maxim specific?
>>
>>
>> The bigger issue here is we need a common fan binding. I'm not inclined
>> to accept any more fan controller bindings with fan properties until we
>> do.
>>
>> Rob

