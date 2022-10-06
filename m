Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E375F6ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiJFUUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJFUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:20:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2592DB489D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:20:29 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bu25so4404390lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lg2Ge2pvHw2Yt9X+k22wjzhBKqpfRYyWZvz0jY249f8=;
        b=oOEiiJtt+3NlVVoliUJoMJyab7ex+cGfsnDUh7SWRUoAQwY/uRs27ebDTjkwwAdDDb
         JvNvNIXnZh8NN8d3BvxJ6DuLcH57cym4PlK/jCtD2DelwJYx+cuGdzaQFZKN/yw9XDpc
         VsZXQMYcWgEu7v52XPWTjApc0bZFNkxWBrhCf5I+dxQq+oXIJCAYaA403w5q5KMEflkz
         NDWhsF0rQqJaU/p+UfW6YyJZodu9TGJouqq2aos2zUtBQ9WcBNXx956EecclO0w6Di6u
         iQH+OqZVhJDEqzS7t7bUufGe35OKboBnqpt/qSkaaw5eNK77/EflgR1da5T8+GOb/gee
         X4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lg2Ge2pvHw2Yt9X+k22wjzhBKqpfRYyWZvz0jY249f8=;
        b=7RmYhQo3lrIEi3sN7FPkDM7hNimHeP/mlHL+jIg/M9sfqcmUa6jxIiUIE5DYNEF3ah
         nvGEI5vt+aHlqaFcLjZjjj1RBef1wKVi7r81YuXTOpXw3ev2sV4wV3Jx/2jy9S+6fGxN
         wNSVdNG55zohr1/CFhijhryJ8/GmbW1Y0AwZXiqql3nQueQ5Ai3B++id0pVcBaNV0hrf
         3lN4Z1N4FcTrQsXgPNlL/4Jvgd228Xo6bBSksUBEkVuEKH7wYFwZ5IyTEzsaX5XE/sGu
         sI7GplugJ0cBgYjMNGYFf17h2qJ5UiH+zVgaS7QzgfcTz5l8mOvz6jBinsO0LBzJqJH6
         Bfvw==
X-Gm-Message-State: ACrzQf0ga/T/QP8FjvnZ6WMYXSMmSnsPOVsyl2r9HtHwV17MOZH+DQC+
        CuCFz85wbFs2d+vKaGuyxL7cgA==
X-Google-Smtp-Source: AMsMyM4wI342OUVOiJD/jCc9cO7qtnA8UniyTPwaHsw6EbTnMr5bYpdTUqU3j3CpDbNMDC/NL/rXNw==
X-Received: by 2002:ac2:4424:0:b0:4a2:4b01:8458 with SMTP id w4-20020ac24424000000b004a24b018458mr670092lfl.84.1665087627020;
        Thu, 06 Oct 2022 13:20:27 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k1-20020a2eb741000000b0026a92616cd2sm12077ljo.35.2022.10.06.13.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 13:20:26 -0700 (PDT)
Message-ID: <cef6b9a2-9753-d478-ab6a-444784a18576@linaro.org>
Date:   Thu, 6 Oct 2022 22:20:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: convert
 qcom,mdm9615-pinctrl.txt to dt-schema
Content-Language: en-US
To:     neil.armstrong@linaro.org,
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
 <5a669cee-55b2-f5cb-56f2-279003d08578@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5a669cee-55b2-f5cb-56f2-279003d08578@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/2022 18:20, Neil Armstrong wrote:
> Hi,
> 
> On 06/10/2022 13:09, Krzysztof Kozlowski wrote:
>> On 06/10/2022 11:57, Neil Armstrong wrote:
>>> Convert the MDM9515 pinctrl bindings to dt-schema.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      | 161 ---------------------
>>>   .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     | 101 +++++++++++++
>>>   2 files changed, 101 insertions(+), 161 deletions(-)
>>>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> -		};
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
>>> new file mode 100644
>>> index 000000000000..6a5966fc0098
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
>>> @@ -0,0 +1,101 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/pinctrl/qcom,mdm9615-pinctrl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm Technologies, Inc. MDM9615 TLMM block
>>> +
>>> +maintainers:
>>> +  - Bjorn Andersson <andersson@kernel.org>
>>> +
>>> +description: |
>>
>> No need for |
> 
> Ack
> 
>>
>>> +  This binding describes the Top Level Mode Multiplexer block found in the
>>> +  MDM9615 platform.
>>
>> Instead: "Top Level Mode Multiplexer pin controller node in Qualcomm
>> MDM9615 SoC."
>>
>> I see this pattern is coming from other file, so I will fix all of them.
> 
> Ack, wil use this.
> 
>>
>>> +
>>> +allOf:
>>> +  - $ref: "pinctrl.yaml#"
>>
>> Drop it, it's included from tlmm-common
> 
> Ack
> 
>>
>>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: qcom,mdm9615-pinctrl
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts: true
>>> +  interrupt-controller: true
>>> +  '#interrupt-cells': true
>>> +  gpio-controller: true
>>> +  '#gpio-cells': true
>>> +  gpio-ranges: true
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +patternProperties:
>>> +  '-state$':
>>
>> Use " as quotes
> 
> Ack
> 
>>
>>> +    oneOf:
>>> +      - $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
>>> +      - patternProperties:
>>> +          "-pins$":
>>> +            $ref: "#/$defs/qcom-mdm9615-pinctrl-state"
> 
> Interesting, if I add this subnode (that should be valid):
>        gsbi3-state {
>          pins = "gpio8", "gpio9", "gpio10", "gpio11";
>          function = "gsbi3";
>          drive-strength = <8>;
>          bias-disable;
>        };
> 
> then I get the following warning from dt_bindings_check:

First, your block for using defs/qcom-mdm9615-pinctrl-state is not
exactly like it should be, e.g. it misses additionalProperties: false.
Maybe it misses few things more. Please use one of my latest patches as
example, e.g.
https://lore.kernel.org/linux-devicetree/20221006144518.256956-1-krzysztof.kozlowski@linaro.org/T/#t

> 
> Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.example.dtb: pinctrl@1000000: gsbi3-state: More than one condition true in oneOf schema:
>          {'oneOf': [{'$ref': '#/$defs/qcom-mdm9615-pinctrl-state'},
>                     {'patternProperties': {'-pins$': {'$ref': '#/$defs/qcom-mdm9615-pinctrl-state'},
>                                            'pinctrl-[0-9]+': True},
>                      'properties': {'$nodename': True,
>                                     'phandle': True,
>                                     'pinctrl-names': True,
>                                     'secure-status': True,
>                                     'status': True}}]}
>  From schema: /Documentation/devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.yaml
> 
> And I don't understand why, the nodename should not match "-pins$" nor "pinctrl-[0-9]+'...

Hm, dunno... You have a trailing coma in enum with functions - maybe
remove it?

I looked briefly between your patch and mine for sm8150 and could not
find differences except that additionalProperties and coma.

Best regards,
Krzysztof

