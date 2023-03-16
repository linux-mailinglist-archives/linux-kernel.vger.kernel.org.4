Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122B86BC768
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjCPHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCPHjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:39:13 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D3513D5E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:39:03 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z21so3972761edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678952342;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L80D9NzBtpET8zgBI2TIGG8S31tA19Skk/lPpa1cvUU=;
        b=u//MdYRS0r42kik8XCyqsuBQFuINbDrXTIOJEKYnG3tqfPtBuC+KZc3T9jvFF7sXoW
         Bfbk+Cxi1ob15CQlMLw72r+YU4UWTpV8OuXwnFUJcFE0ecrEIBtjo7SkREW9IZl40GdX
         0SiHSaTaKGRxmspn7C7k8LApCCDVGhBWlfwZ06xuYTHRGyQLubIeKSjymrDZ001ZOZnO
         tpivkVMAeSKpUBEzRzI20Z8i7hBHLFmZtJXqlkVX7CVsBZ63Kbnm69DQAXEVJhQQRHA/
         3Au4GBk8DYzC6VQeLUh7FWA83riRgzb4WYD4zFjyNUoAuC05pJw8rjfOUs4DevZqg/Lh
         dbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678952342;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L80D9NzBtpET8zgBI2TIGG8S31tA19Skk/lPpa1cvUU=;
        b=C4Lk0iwRr0eLjyT5bsSER+Hx95hS5WchkthG7aCZHzFQ1mgLj8X8/GEUPPelVOcAgt
         wl3EoplOILMj6cEt0bbHoeq++3GlH1tO9TcFHpmwFI9vw1yagbQIEbJf4REN3psg+cGP
         H5TMYraynK+VPGQY9RiUwN8bAOasBqNVaD+1KCZsOHyyHzC4BTlxca2zLBwzHd6oLFS6
         pmV74EX9HXJXarBvnLFEntPaU6oRjVDQ/ggR9oDyBLYKFawNLyc5Sq3UDdR38RYlpFYG
         1JqCJGH2cLzJ2Nyu5y6I5zVJF1YCrbCVVw/3s8jVHW6mr5tE/UaptE58rgJkmt+A9EOs
         t6hA==
X-Gm-Message-State: AO0yUKVM7ynW4V+6xcI4pvzzAvrJ9/0y3G2BP4UdSkei2FLwUA2oxi14
        yE4/mhMw+EqB4b6EvjnhROk8pA==
X-Google-Smtp-Source: AK7set+X7bdwNzSqtxKylbf4V544my6LOLVFYGokzYyuR1B0XP1meCH+xiaR2+xKI0kHvIiNDxq3MA==
X-Received: by 2002:a05:6402:651:b0:4ef:9bf0:7177 with SMTP id u17-20020a056402065100b004ef9bf07177mr5564351edx.9.1678952342340;
        Thu, 16 Mar 2023 00:39:02 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id a1-20020a509b41000000b004fb00831851sm3424666edj.66.2023.03.16.00.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:39:02 -0700 (PDT)
Message-ID: <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
Date:   Thu, 16 Mar 2023 08:39:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-10-ychuang570808@gmail.com>
 <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
In-Reply-To: <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
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

On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
> 
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
> 
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>  .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> new file mode 100644
>> index 000000000000..f66c566c6dce
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Reset Controller
>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description:
>> +  The system reset controller can be used to reset various peripheral
>> +  controllers in MA35D1 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-reset
>> +
>> +  regmap:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: Phandle to the register map node.
> 
> You need to be specific what is this. As you can easily check, there is
> no such property in any devices. I don't understand why do you need it
> in the first place.
> 
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - regmap
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # system reset controller node:
>> +  - |
>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>> +
>> +    sys: system-management@40460000 {
>> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
> 
> And your patchset is not bisectable.... Test for bisectability before
> sending.

Ah, no, it's correct. I see the compatible in previous patch. You need
to clearly describe the dependencies and merging strategy/requirements
in cover letter.

Best regards,
Krzysztof

