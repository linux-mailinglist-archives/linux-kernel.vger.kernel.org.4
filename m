Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995BE6287A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiKNR6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiKNR61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:58:27 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D8838B3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:58:25 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v28so11705566pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM6+24y8Nx3+npt1PEW0fItw8sDTfZ+qONmMgpVZl5A=;
        b=H1AMWfgOmUXklUoGpLcyUuiDFNdK9NWhlBr2OEuVs518AU/1QltaKC5OXiRcehIJ+L
         7FAmo/zgqVfOBmvHeyvG+iMeI9I4quYcwz7HxWsroRthizOTg+frkHZ53dxDfpwdcisO
         TuV442iBqSExcZzGz+XefGAhGPWAw1Endr/fa7MvgPyNvAcSSKhvqoTePSXbKYYpokJi
         e0hMAtDkCq5mAutKNQMwBtrRlcyrOUSPNigYq2srS9Iu0sn/yy9Vi25aKipT+O34WZz+
         bsf+DcQspiSBIEjUulnhdJtvQjGDRTFQnhZF74hUt62IQm78bjSaUWUH8IYuz5cLI1Pt
         t0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM6+24y8Nx3+npt1PEW0fItw8sDTfZ+qONmMgpVZl5A=;
        b=2EDY8UZdWToUnmBTAmCs2wLfRD3PLKEZClkC0FyC5apJPbk96TGBt/r0XW3WUZoG83
         Dp61pQzNN6jUi5ct6MbeNoCFg9CH/oWNMSl1wDxIJ2IBOSNeVyi0MJ0glN5ZlFtk+Bje
         neCNSA9n4O0r+3Ydp+7lzk6Yua7O+sUuTCVXNFX6fG3D2GDNhqK6MyhAx4CUyubMbsEQ
         rW1LJ9GTh1kH0DiMyw8SZ8eU4k42JfK+VpZidh1tBX0kC0PFZFT+Usm1EyygDkUZjbVv
         quVZszpQkEH8NwOujfLeyVAPlms4JidMW6gjSSh6te9mus62biGYTVuEJWZ5T2aXFkUF
         lYGQ==
X-Gm-Message-State: ANoB5pnXiyeSCJ+pxYbdBEoViaocVp4W7tCJP83ukxf49a7IQXsTj23Z
        /tdh3yXp1sjNyqx2CXjmq6N8Lw==
X-Google-Smtp-Source: AA0mqf54BjCniGJIMYLtI7O1hO+BWbvCMtZQ7exEQKMlm38GqyDvLxaIt7Y/hS857rv+Y/u+L5PpEg==
X-Received: by 2002:a63:ce04:0:b0:46f:1081:f517 with SMTP id y4-20020a63ce04000000b0046f1081f517mr12869227pgf.297.1668448704779;
        Mon, 14 Nov 2022 09:58:24 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id v1-20020a17090a7c0100b001f94d25bfabsm9933621pjf.28.2022.11.14.09.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:58:24 -0800 (PST)
Message-ID: <19c2513f-4a6f-ba20-b8f0-b97e14d36053@9elements.com>
Date:   Mon, 14 Nov 2022 23:28:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v9 1/2] dt-bindings: mfd: Add dt-schema MAX5970 and
 MAX5978
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221114075739.4117439-1-Naresh.Solanki@9elements.com>
 <20221114075739.4117439-2-Naresh.Solanki@9elements.com>
 <3fd5b40f-25eb-7ce3-0e23-84c35962e6e1@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <3fd5b40f-25eb-7ce3-0e23-84c35962e6e1@linaro.org>
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

On 14-11-2022 01:40 pm, Krzysztof Kozlowski wrote:
> On 14/11/2022 08:57, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
> 
> Subject: I asked to drop the redundant words, but you re-added now in
> different form. So again, drop "dt-schema".
Sure
> 
>>
>> The MAX597x is a hot swap controller with configurable fault protection.
>> It also has 10bit ADC for current & voltage measurements.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/mfd/maxim,max5970.yaml           | 172 ++++++++++++++++++
>>   1 file changed, 172 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> new file mode 100644
>> index 000000000000..a93b6e009b9a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>> @@ -0,0 +1,172 @@
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
>> +  "#io-channel-cells":
>> +    const: 1
>> +
>> +  regulators:
>> +    type: object
>> +    description:
>> +      Properties for regulator.
> 
> That's not correct description. This is not one regulator.
Sure. Will add description something like:
Properties for both regulators. Also specify value for shunt resistor 
used for current sense.
> 
>> +
>> +    patternProperties:
>> +      "^sw[0-1]$":
>> +        $ref: /schemas/regulator/regulator.yaml#
>> +        type: object
> 
> unevaluatedProperties: false
Sure will add this.
> 
>> +        properties:
>> +          shunt-resistor-micro-ohms:
>> +            description: |
>> +              The value of curent sense resistor in microohms.
> 
> Typo: current
Sure. will fix this.
> 
>> +
>> +        required:
>> +          - shunt-resistor-micro-ohms
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
>> +      properties:
>> +        io-channels:
>> +          items:
>> +            - description: voltage first channel
>> +            - description: current first channel
>> +            - description: voltage second channel
>> +            - description: current second channel
>> +          description: |
>> +            Voltage and current for first and second channel.
>> +      required:
>> +        - vss2-supply
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Comment was:
> "Also, add it in the existing example."
This property isn't used. hence will remove in next version.
> 
>> +    else:
>> +      properties:
>> +        io-channels:
>> +          items:
>> +            - description: voltage first channel
>> +            - description: current first channel
>> +          description: |
>> +            Voltage and current for first channel.
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        regulator@3a {
>> +           compatible = "maxim,max5978";
>> +           reg = <0x3a>;
>> +           vss1-supply = <&p3v3>;
>> +
>> +           regulators {
>> +               sw0_ref_0: sw0 {
>> +                      regulator-compatible = "SW0";
> 
> Use 4 spaces for example indentation.
Yeah. some place have 3 spaces instead. Will fix in next version for sure.
> 
>> +                      shunt-resistor-micro-ohms = <12000>;
>> +               };
>> +           };
>> +
>> +           leds {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +               led@0 {
>> +                   reg = <0>;
>> +                   label = "led0";
>> +                   default-state = "on";
>> +               };
>> +               led@1 {
>> +                   reg = <1>;
>> +                   label = "led1";
>> +                   default-state = "on";
>> +               };
>> +           };
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
>> +                    shunt-resistor-micro-ohms = <12000>;
>> +                };
>> +                sw1_ref_1: sw1 {
>> +                    regulator-compatible = "SW1";
>> +                    shunt-resistor-micro-ohms = <10000>;
>> +                };
>> +            };
>> +        };
>> +    };
>> +...
> 
> Best regards,
> Krzysztof
> 

Regards,
Naresh
