Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B0D5FB8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJKQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJKQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:54:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903F71183A;
        Tue, 11 Oct 2022 09:54:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c20so4181478plc.5;
        Tue, 11 Oct 2022 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sMzI9+OaDvcpj7FaffFnxmnsgehAD2eJ0gWU0iCg7nA=;
        b=nhVS2wqyN/9hPFe85hZ3vn2SwpzV7oFg9VdcG7yoLkD316RWKlIP+8FkvZJ6Zoz4s9
         4Mc5aPpl1g9yvfLpkDKAfw06HCSYzx8CVqODGVok3GpU6AABF/dsglUD33hGzOusK0lr
         dVTx3Oza2i74Woxc6ZeknCmT2L2Ut+5C776fCX1NQBUtzYF6qITlj303mtYUvmIv/wKV
         YSUmdnAjTtMyMfiJJ3djnVe1tgvRz+EDBK8/8Awm8hPFa/OX8IiW7uyTocOOVWnpSX/Y
         VFWtefqMRf56xw7K4bUERvq2BKO8c+Gv4sCn+uS94G72drJumaXS4r80XhYDv4Jeh7+g
         AmVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMzI9+OaDvcpj7FaffFnxmnsgehAD2eJ0gWU0iCg7nA=;
        b=4ieOCoESg7qlKx1xhqZv77pxe7BbMXEllgBRWHII3AQWQG34oHViqz2+1a/aT7V6UX
         5i4pGnTAn9nd6zrimgTLm4y22cveHsE//MgWzHiFIq41nHl8+ULYyBEuRfZ8ScGJI4Hd
         wKbge5Ftjzj+yPfTuDssoKpQN1w9lpJeCkclvFz76YPwRp82UsIT7gzhx4Ty75NuYGTF
         7kJS1ehtXnaKDzMRIP/Bv9EqQrgdZ4qlP5TlW8x6E4clvYYVq0N+I2FESN1hJ3L/9zsh
         BqXK31gjjWMCog73VS4/GWamo3sWLdNBYFA5Dt9yDreJSclk9L0PeT1bNCwMjC/SrvMr
         0JNQ==
X-Gm-Message-State: ACrzQf0y7B0NL7ZTZRRz+opXkkCAdtyHuo6C/aJ9OCqANwFcK1CXcdfL
        Fm60HP1bUwSjHmjzotSpkxw=
X-Google-Smtp-Source: AMsMyM5nnDvGQ+iPaeOERvCjB9lMfxpLws3nWOvz56Xuxgbp6oPRFCbZpmnvKkzmNePMnyRaZbsvjQ==
X-Received: by 2002:a17:902:9048:b0:17f:93a5:4638 with SMTP id w8-20020a170902904800b0017f93a54638mr24781693plz.108.1665507292009;
        Tue, 11 Oct 2022 09:54:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o8-20020a170902d4c800b00179c81f6693sm8918889plg.264.2022.10.11.09.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:54:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2e3c55a0-256d-f318-a983-17ad3f8e8909@roeck-us.net>
Date:   Tue, 11 Oct 2022 09:54:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] dt-bindings: hwmon: Add binding for max6639
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roland Stigge <stigge@antcom.de>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-3-Naresh.Solanki@9elements.com>
 <b0519e16-7826-a043-d0a4-7a2f43d0ae94@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <b0519e16-7826-a043-d0a4-7a2f43d0ae94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 09:28, Krzysztof Kozlowski wrote:
> On 11/10/2022 06:47, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> Add Devicetree binding documentation for Maxim MAX6639 temperature
>> monitor with PWM fan-speed controller.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/hwmon/maxim,max6639.yaml         | 116 ++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> new file mode 100644
>> index 000000000000..bbefb0a57ab3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +
>> +$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Maxim max6639
>> +
>> +maintainers:
>> +  - Roland Stigge <stigge@antcom.de>
>> +
>> +description: |
>> +  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
>> +  fan-speed controller.  It monitors its own temperature and one external
>> +  diode-connected transistor or the temperatures of two external diode-connected
>> +  transistors, typically available in CPUs, FPGAs, or GPUs.
>> +
>> +  Datasheets:
>> +    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - maxim,max6639
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +patternProperties:
>> +  "^ot[0-1]_indication$":
> 
> No underscores in names.
> 
>> +    type: boolean
>> +    default: false
>> +    description:
>> +      If true then enable OT pin indication.
> 
> Description copies the name of property. Not really useful. Describe
> that it does.
> 
> Why this has 0 and 1 numbers? Isn't it connected with fan?
> 

I had to look up the suggested code to understand what it means.
All the _indication properties actually configure the chip
to enable or disable various alarm output pins (ALERT, OT,
THERM, and FANFAIL). I for my part find the therm "indication"
quite confusing.

Guenter

>> +
>> +  "^therm[0-1]_indication$":
>> +    type: boolean
>> +    default: false
>> +    description:
>> +      If true then enable THERM pin indication.
> 
> Ditto
> 
>> +
>> +  "^fan@[0-1]$":
> 
> [01]
> The same in other cases.
> 
>> +    type: object
>> +    description: |
>> +      Represents the two fans and their specific configuration.
>> +
>> +    $ref: fan-common.yaml#
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          The fan number.
>> +        items:
>> +          minimum: 0
>> +          maximum: 1
>> +
>> +      maxim,fan-spin-up:
>> +        type: boolean
>> +        description:
>> +          If true then whnever the fan starts up from zero drive, it
> 
> whenever
> run spell-check
> 
>> +          is driven with 100% duty cycle for 2s to ensure that it
>> +          starts.
>> +
>> +      maxim,full-speed-on-therm:
>> +        type: boolean
>> +        description:
>> +          If true then force fan to full speed if THERM pin goes low.
>> +
>> +      maxim,fanfail_indication:
> 
> No underscores
> 
>> +        type: boolean
>> +        description:
>> +          If true then enable fanfail pin indication.
> 
> Missing blank line
> 
>> +    required:
>> +      - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      max6639@10 {
> 
> Node names should be generic.
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
>> +        compatible = "maxim,max6639";
>> +        reg = <0x10>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        fan@0 {
>> +          reg = <0x0>;
>> +          pulses-per-revolution = <2>;
>> +          max-rpm = <4000>;
>> +          pwm-frequency = <25000>;
>> +        };
>> +
>> +        fan@1 {
>> +          reg = <0x1>;
>> +          pulses-per-revolution = <2>;
>> +          max-rpm = <32000>;
>> +          pwm-frequency = <25000>;
>> +        };
>> +      };
>> +    };
>> +...
> 
> Best regards,
> Krzysztof
> 

