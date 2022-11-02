Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810CA616B24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiKBRqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiKBRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:45:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D7D2DAAD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:45:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z30so12226336qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhdA4rQr0h0JHz2jK1i63BpkMkxoHoWynIDjwqEDB+E=;
        b=Ko/XhEQEVy8vhYi2Chd7g4Pc0uL+vmvOn2/a6NXdhPxD2Y7c8T1GRvqkhcePqP6v/C
         KLGb7mu3ves6N3Sx1yUfZfbnaF2wU/711K+xEuKHUASt6+29rrP28EY9hHdrKuuOIhy5
         a9CSzAxaZ7LELJwoIV0rMLCfYh9e/MfHxveo1REl/smgiJtM9XSqtld5USHvUGRTJ4Iv
         xxkKn3vNy7LVeLayEBbnx8rf4XXvSAgVFTELg+/7hthlCWVxAkmV0MzVEqaycWV7zeW2
         YRaBdci6hXeARGPC74Jj0C7PRcMAkLxAq4YaZIpP/1kahrnu7N9eyfTlz8ORW7qBvnk1
         dFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhdA4rQr0h0JHz2jK1i63BpkMkxoHoWynIDjwqEDB+E=;
        b=6VqPmXYodm+TgIn6kjO8hsa3Xl/CsNYtW6BF8W0A0tKtfWPMyDhlo6f9zF0xL7CA6J
         HK8gc1LrzXWZD62C4BCdHTYnQ8sNA7BqIcr/vYU/kwkkR4lLeHa0wHMnaD4lPVCMRL4h
         JgWYW3YY+lsFXvFqErmpcpVF0HGOq1S8E5hU65960G2c+aPAnBIVLZ/snVqFqqS4+x8V
         klWGHu3YlgfWrJOADS3nXAJ01muyRkmm5ADuNmHQJqvQzEs1699jRntvJkx4YhdqH4PS
         GcUYYBkkCztjcW/uNTOVxDljbubYnWLdtV8iTf5A1emjLImS0igIcYLuRQxFSBYWFYND
         8LmQ==
X-Gm-Message-State: ACrzQf0in70uThHFj3gHM3wLKNoJS/4H3k4yrT+if0iGSF8b4O2jCyAO
        UGemBc+cNtGheJEs9xc5py5H/w==
X-Google-Smtp-Source: AMsMyM6laFDeCzjGMT0dXXGw/q7TuqBxY7XkgJLdR16KWV3Gda6y3n78BNcHzkdRgFQNIQWU4LmdSg==
X-Received: by 2002:a37:de04:0:b0:6f9:386a:f58d with SMTP id h4-20020a37de04000000b006f9386af58dmr18367578qkj.166.1667411152458;
        Wed, 02 Nov 2022 10:45:52 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85916000000b003a4f0bad332sm6947256qty.66.2022.11.02.10.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 10:45:51 -0700 (PDT)
Message-ID: <2a2baeb6-d1ae-b564-d20b-039832156121@linaro.org>
Date:   Wed, 2 Nov 2022 13:45:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: power: supply: expect specific type for
 monitored-battery
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221028231255.565363-1-krzysztof.kozlowski@linaro.org>
 <20221031192617.GA3283833-robh@kernel.org>
 <20221031225635.ntziphignf7m4h3w@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221031225635.ntziphignf7m4h3w@mercury.elektranox.org>
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

On 31/10/2022 18:56, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 31, 2022 at 02:26:17PM -0500, Rob Herring wrote:
>> On Fri, Oct 28, 2022 at 07:12:55PM -0400, Krzysztof Kozlowski wrote:
>>> Core schema does not define type of monitored-battery, so the schemas
>>> are expected to reference proper type.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml    | 2 +-
>>>  .../devicetree/bindings/power/supply/ingenic,battery.yaml      | 1 +
>>>  .../devicetree/bindings/power/supply/rohm,bd99954.yaml         | 1 +
>>>  .../devicetree/bindings/power/supply/sc2731-charger.yaml       | 2 +-
>>>  Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml  | 3 ++-
>>>  5 files changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
>>> index 65fc6049efc1..b04c86ed0f58 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
>>> @@ -59,6 +59,7 @@ properties:
>>>      description: integer, I2C address of the fuel gauge.
>>>  
>>>    monitored-battery:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>      description: |
>>>         phandle of battery characteristics node.
>>>         The fuel gauge uses the following battery properties:
>>> @@ -66,7 +67,6 @@ properties:
>>>         - charge-full-design-microamp-hours
>>>         - voltage-min-design-microvolt
>>>         Both or neither of the *-full-design-*-hours properties must be set.
>>> -       See Documentation/devicetree/bindings/power/supply/battery.yaml
>>>  
>>>    power-supplies: true
>>>  
>>> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
>>> index 46527038bf22..8bdacc30e9d8 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
>>> @@ -27,6 +27,7 @@ properties:
>>>      const: battery
>>>  
>>>    monitored-battery:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>
>> We should not have a type definition multiple times for the same 
>> property. We need to add a common schema defining the type instead.
> 
> I suppose monitored-battery should become part of
> Documentation/devicetree/bindings/power/supply/power-supply.yaml

I'll send a v2.

Best regards,
Krzysztof

