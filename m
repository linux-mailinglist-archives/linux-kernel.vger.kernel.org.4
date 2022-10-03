Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2B5F2BA7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiJCIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJCIXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:23:22 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4108352827
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 00:57:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o7so8141428lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e+d4ET8o0OR3zkYPmo0OiA0V7nJoYuTIpSvqddCGg2c=;
        b=R0uolEhXPYHlOkbpdEwgd0q8JDwITwNZDD4RiaZh9VzFiGQ1+7uddkAn60vv2QfEsh
         dJHCuGUVH8vixuLxJ8rhw6lAcFR8+0gue6ODTnpmlHm3KCzWaswse9eliQ9FaUcOXEiT
         tumjtGZrZMCtqbmWGrUu0eECHmdXMPSIOReL/zp9+w2H15Ex9Wv8OhOTOj4PublUQGc3
         gVGqEUoPDxKVjClpad0HBSrQINg3cKOjByEGvTaAiMPPY5Fcu1geWjc7sM/8npj8Dfv6
         hx9Nir45c/cCYIe3WMFU14EmyOyN8i7QGf3BZTDV3cAabSrp7EmSC0segR3GmoK2hQUC
         MEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e+d4ET8o0OR3zkYPmo0OiA0V7nJoYuTIpSvqddCGg2c=;
        b=xHYQc8AWQiI4Ux0GFhMx1TCWUHq1LFIzlVss+ek7QXaCnGDwU9Ooiv4fdYX+X0DVVU
         p9CSiCG1Cb4y7mDJqfgKg5jNDU+DYuNBWsEy7TudFRbh+JM/aT2bLFKmcmACvtrJxVvJ
         4lhbYC3H7u9QGvV8AG3DTy6glFpzqN3+kEhvvw5/GyunfoeBCul8vaazoUQ2Lw+08/XW
         OMHM0kNznghSfwoRz2++24U2CWMxPaRM/9DR9iyNad3QnlAaavrwdXzAg4W/I+FB+0ik
         cQ4IA74bym4V6Ibbdy+0Dv21TAvdvnSPMna9WRkHGcHaxULT5IPDLvrgOkj6DfLRZ388
         emgg==
X-Gm-Message-State: ACrzQf1fkuSmcNn0FQYiuUlZD0+aD3rRB3jDHWzHQlpFPaVT4jdJacFD
        xmQf1WCshRPMGk9pQ5hMxXwM3w==
X-Google-Smtp-Source: AMsMyM7PSSOenEuZQsvZRhSFXDEbLKt8lATbuzMcI5SNjafctLlLh2cJSlVjaoKlsZp3GxRj/we9qg==
X-Received: by 2002:a05:6512:5d5:b0:4a2:3a71:16f7 with SMTP id o21-20020a05651205d500b004a23a7116f7mr1871650lfo.168.1664783796119;
        Mon, 03 Oct 2022 00:56:36 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p4-20020a05651212c400b00497ac6b2b15sm1347904lfg.157.2022.10.03.00.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:56:35 -0700 (PDT)
Message-ID: <89533acf-b741-f587-d2d4-0f5bc534e3ee@linaro.org>
Date:   Mon, 3 Oct 2022 09:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v9 1/3] dt-bindings: mfd: Convert atmel-flexcom to
 json-schema
Content-Language: en-US
To:     Kavyasree.Kotagiri@microchip.com, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     robh+dt@kernel.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Sergiu.Moga@microchip.com, robh@kernel.org
References: <20220916075744.1879428-1-kavyasree.kotagiri@microchip.com>
 <20220916075744.1879428-2-kavyasree.kotagiri@microchip.com>
 <PH0PR11MB48728124A13E40C1E5F4198F924D9@PH0PR11MB4872.namprd11.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <PH0PR11MB48728124A13E40C1E5F4198F924D9@PH0PR11MB4872.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 07:27, Kavyasree.Kotagiri@microchip.com wrote:
>> Convert the Atmel flexcom device tree bindings to json schema.
>>
>> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>> v8 -> v9:
>>  - Use full schema path for i2c bindings.
>>
>> Changing reference to SPI yaml bindings is covered in below patch series:
>> https://lore.kernel.org/linux-arm-kernel/20220913142205.162399-6-
>> sergiu.moga@microchip.com/
>> https://lore.kernel.org/linux-arm-kernel/dad37ca0-a44b-59ec-0be9-
>> fb121de12244@linaro.org/
>>
>> v7 -> v8:
>>  - Added back patternProperties for child nodes.
>>
>> v6 -> v7:
>>  - Change filename to atmel,sama5d2-flexcom.yaml
>>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
>>
>> v5 -> v6:
>>  - Removed spi node from example as suggested by Rob and
>>    also pattern properties(spi dt-bindings conversion to yaml patch is under
>> review).
>>    Once that is accepted, I will add back spi example through new patch.
>>
>> v4 -> v5:
>>  - Fixed indentations.
>>
>> v3 -> v4:
>>  - Corrected format of enum used for compatible string.
>>
>> v2 -> v3:
>>  - used enum for compatible string.
>>  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
>>  - fixed dtschema errors.
>>
>> v1 -> v2:
>>  - Fix title.
>>
>>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 92 +++++++++++++++++++
>>  .../devicetree/bindings/mfd/atmel-flexcom.txt | 63 -------------
>>  2 files changed, 92 insertions(+), 63 deletions(-)
>>  create mode 100644
>> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
>> flexcom.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml
>> new file mode 100644
>> index 000000000000..f28522cd987a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/atmel,sama5d2-
>> flexcom.yaml
>> @@ -0,0 +1,92 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Atmel Flexcom (Flexible Serial Communication Unit)
>> +
>> +maintainers:
>> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
>> +
>> +description:
>> +  The Atmel Flexcom is just a wrapper which embeds a SPI controller,
>> +  an I2C controller and an USART. Only one function can be used at a
>> +  time and is chosen at boot time according to the device tree.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - atmel,sama5d2-flexcom
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges:
>> +    description:
>> +      One range for the full I/O register region. (including USART,
>> +      TWI and SPI registers).
>> +    items:
>> +      maxItems: 3
>> +
>> +  atmel,flexcom-mode:
>> +    description: |
>> +      Specifies the flexcom mode as follows:
>> +      1: USART
>> +      2: SPI
>> +      3: I2C.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [1, 2, 3]
>> +
>> +patternProperties:
>> +  "^serial@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Child node describing USART. See atmel-usart.txt for details
>> +      of USART bindings.
>> +
>> +  "^spi@[0-9a-f]+$":
>> +    type: object
>> +    description:
>> +      Child node describing SPI. See ../spi/spi_atmel.txt for details
>> +      of SPI bindings.
>> +
>> +  "^i2c@[0-9a-f]+$":
>> +    $ref: /schemas/i2c/atmel,at91sam-i2c.yaml
> 
> 
> Hi Krzysztof,
> 
> I added full schema path for i2c bindings in v9. Please let me know your comments.
> 

You sent the patch on 16th, pinged on 19th. Wait around two weeks before
pinging.

You got here Rob's review, what is missing? Why do you ping us?

Best regards,
Krzysztof

