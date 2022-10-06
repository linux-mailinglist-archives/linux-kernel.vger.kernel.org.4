Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753D5F6B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiJFQUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 12:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJFQUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 12:20:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7575237436
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:20:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b4so3507187wrs.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=MLUoGUi48ONllxDe+DGzRO52aIDPM4laO+reVTlYbgc=;
        b=mQEmmTqBEwxwi1SSuizetewcTH7yu3yF6YuxaHSNlUjPWyOESnd1dJEzmydeTBCptw
         kBfIrsBLmfT2TobCw6055RV+gcz6Z5BsU3eb/niGuVMvRsWFdlbsDVeEL7vhvlLI3uuk
         TGyRRH6iH7c/hxTb4OumXUsV8gU0/ijBGMHN5N9HIlYQ7odTODW30OMtcC81A/Grt90t
         wKhWy7WH5Qfh3Hw1KoOTBWldfbyhghs2X5uZWd8y9sZPGkOOhehulqcG4aa9pESrA868
         DJCWGOMKdWPoOQagNEIG5DZ7B94qDU+ui+Do3Gbm0GdxmT738soKemqMucl5EuuYSeph
         uJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=MLUoGUi48ONllxDe+DGzRO52aIDPM4laO+reVTlYbgc=;
        b=4DG3yE4HvkU5A0ew833Ncomkye2uVMqiGrWEunnb/KCArY0szhR11qRBEh9DX9bhsg
         eP5syULR/3pJS2k/ztIKwL13DJOkbyxahDzTuHD7uxRqUE7hRki50PVASXUzUH6F593W
         jW5AwBIY1fiNCm6inG85Mj4eAY3TCI4ZGe5whjSpZZ5Uon4Ah6XB2+weDp0wotFJcFQZ
         auNwUZ1m3I+fKy37g62UsqzN3ITzoVh57gvkYnrvLqy1Qftcu7oHH7kQKOq2WarzBYn6
         268bZr3UEhX/vr0ry7s6FMnsOV179g6k5GXsk2AjNgSsR+O0GB+h9Id7BlAKbzF9H9Rt
         hMSQ==
X-Gm-Message-State: ACrzQf3W80A6vmkP9pSjIZ1tfb/ZeKdHlWGE/Gyggz8ZyKo7XbOhWvqw
        Y4zPS5ldO6ze4PaWG3KpH52aBA==
X-Google-Smtp-Source: AMsMyM6zFZxHV62NEiB4FXmfIrJrKbM41PVxdxdCf9MoLg7M4bRVLwLYLy5AkYr+P+tnPfIyPF1KtQ==
X-Received: by 2002:a5d:47c7:0:b0:22e:37c6:3d7d with SMTP id o7-20020a5d47c7000000b0022e37c63d7dmr499637wrc.163.1665073205842;
        Thu, 06 Oct 2022 09:20:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e032:72ae:542:774? ([2a01:e0a:982:cbb0:e032:72ae:542:774])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d5606000000b00228d52b935asm18779235wrv.71.2022.10.06.09.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 09:20:05 -0700 (PDT)
Message-ID: <5a669cee-55b2-f5cb-56f2-279003d08578@linaro.org>
Date:   Thu, 6 Oct 2022 18:20:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>, Lee Jones <lee@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v1-1-0cbc006e2a30@linaro.org>
 <8213587e-681a-a948-42a6-2b1632b47ac0@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <8213587e-681a-a948-42a6-2b1632b47ac0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/10/2022 13:09, Krzysztof Kozlowski wrote:
> On 06/10/2022 11:57, Neil Armstrong wrote:
>> Convert the MDM9515 pinctrl bindings to dt-schema.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
>>   .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
>>   2 files changed, 101 insertions(+), 161 deletions(-)
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> -		};
>> -	};
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..6a5966fc0098
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
>> @@ -0,0 +1,101 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9615-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. MDM9615 TLMM block
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +
>> +description: |
> 
> No need for |

Ack

> 
>> +  This binding describes the Top Level Mode Multiplexer block found in the
>> +  MDM9615 platform.
> 
> Instead: "Top Level Mode Multiplexer pin controller node in Qualcomm
> MDM9615 SoC."
> 
> I see this pattern is coming from other file, so I will fix all of them.

Ack, wil use this.

> 
>> +
>> +allOf:
>> +  - $ref: "pinctrl.yaml#"
> 
> Drop it, it's included from tlmm-common

Ack

> 
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,mdm9615-pinctrl
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts: true
>> +  interrupt-controller: true
>> +  '#interrupt-cells': true
>> +  gpio-controller: true
>> +  '#gpio-cells': true
>> +  gpio-ranges: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  '-state$':
> 
> Use " as quotes

Ack

> 
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-mdm9615-pinctrl-state"

Interesting, if I add this subnode (that should be valid):
       gsbi3-state {
         pins = "gpio8", "gpio9", "gpio10", "gpio11";
         function = "gsbi3";
         drive-strength = <8>;
         bias-disable;
       };

then I get the following warning from dt_bindings_check:

Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.example.dtb: pinctrl@1000000: gsbi3-state: More than one condition true in oneOf schema:
         {'oneOf': [{'$ref': '#/$defs/qcom-mdm9615-pinctrl-state'},
                    {'patternProperties': {'-pins$': {'$ref': '#/$defs/qcom-mdm9615-pinctrl-state'},
                                           'pinctrl-[0-9]+': True},
                     'properties': {'$nodename': True,
                                    'phandle': True,
                                    'pinctrl-names': True,
                                    'secure-status': True,
                                    'status': True}}]}
 From schema: /Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml

And I don't understand why, the nodename should not match "-pins$" nor "pinctrl-[0-9]+'...

>> +
>> +'$defs':
> 
> No need for quotes
> 
>> +  qcom-mdm9615-pinctrl-state:
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
> 
> No need for quotes

Ack

> 
>> +
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in this
>> +          subnode.
>> +        items:
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-7][0-9]|8[0-7])$"
> 
> No sd-like functions? If so, then drop oneOf

Ack

> 
>> +        minItems: 1
>> +        maxItems: 16
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +        enum: [ gpio, gsbi2_i2c, gsbi3, gsbi4, gsbi5_i2c, gsbi5_uart,
>> +                sdc2, ebi2_lcdc, ps_hold, prim_audio, sec_audio, cdc_mclk, ]
>> +
>> +      bias-disable: true
>> +      bias-pull-down: true
>> +      bias-pull-up: true
>> +      drive-strength: true
>> +      output-high: true
>> +      output-low: true
>> +      input-enable: true
>> +
>> +    required:
>> +      - pins
>> +      - function
>> +
>> +    additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +        #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +        tlmm: pinctrl@1000000 {
> 
> Use 4 spaces indentation.
> 
>> +          compatible = "qcom,mdm9615-pinctrl";
>> +          reg = <0x01000000 0x300000>;
>> +          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +          gpio-controller;
>> +          gpio-ranges = <&msmgpio 0 0 88>;
>> +          #gpio-cells = <2>;
>> +          interrupt-controller;
>> +          #interrupt-cells = <2>;
> 
> Add example of -state with and without -pins node.
> 
> You dropped it with conversion.

Ack, done but I have a weird warning, see upper.

> 
> 
>> +        };
>>
> 
> Best regards,
> Krzysztof
> 

Thanks,
Neil
