Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFFC76BF7BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 05:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjCREaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 00:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCREaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 00:30:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A663B0CE;
        Fri, 17 Mar 2023 21:30:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so7318741pjb.0;
        Fri, 17 Mar 2023 21:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679113808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J606gWJ17gh5ZShf0JviIKqHN/EVKTqXlnaFTD9hk8w=;
        b=LVomUSz/r6q+IsmVYfx6G5zErL2/9e4j5uuZdkV+zM7igOLaAdsH9Fk5Th7c+mPjdd
         3qKdSMwvaWsESHPJa5X5QSo3cXsEUw7TlpDz4NDZhs+4UNg0y2tONSZ+2LuqSuHw3JxD
         dLb5hxpCJbVnccP4zWNE9sCf0kmiyxRy+jEKipbKFUry/OiOf7JzNhI96kPjEIiwle++
         Z/JRAQJv0LdbvjDQt9pAPPuPdGZSZgbhk6DBGVS3VbtMKr/XCxBbBzBBBZCsf2yhh262
         a1GG9ntYKZBbxqu2r04ZywdyIR36r75UEZOrIgY7Jlk5yfmANiqrGidn0HPajmCX4BXC
         A1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679113808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J606gWJ17gh5ZShf0JviIKqHN/EVKTqXlnaFTD9hk8w=;
        b=aBYpqgapLsxxeybFcCRGxWnQfp0gNLatC40QJQpGS8rJpQ51dvXcAOLtgEEmYBKCC/
         lhydYmyQFfhT/ihivaZx3Dl4H/V/BQh0p8Jsme1WlUiLix8tZIJeELa4jbSR01YsRR5C
         b24yvQSQOuYv0tULl0rDDoYr19cy9N3QsaS9b10keZiSDWBClR1JFGUjXjQ9Y1zJEJ8f
         j4JDfQCXUq7Je1jbfDXg1EMeAY8J673EWtK0zD1ZPIIbgRmTVq2hZZpSPVuhr2ASWxt8
         OOoBZDqoKFVPYamVDzLy2Pr+KEVZ1KHL5KVE8sSIR5MYRn4lQI2Lfd/RnzhruQMfV+SE
         KoQg==
X-Gm-Message-State: AO0yUKWIdWZOfBXQOR0X++0Wdj2lvxqcTvYqFtaB7z5DBFvKh2KpW1Jk
        i6JM0znq8zqLhWckvBhRuiU=
X-Google-Smtp-Source: AK7set+eU1cUOzicD8Shx0GvXIPvtb5jxOLtJcbk6O7QjRYc2Kn1YLw1V58mmlO5gx/X+NgeKaPuUA==
X-Received: by 2002:a17:90b:4b90:b0:23c:fea5:74ca with SMTP id lr16-20020a17090b4b9000b0023cfea574camr10542485pjb.23.1679113808561;
        Fri, 17 Mar 2023 21:30:08 -0700 (PDT)
Received: from [192.168.1.101] (1-160-164-133.dynamic-ip.hinet.net. [1.160.164.133])
        by smtp.gmail.com with ESMTPSA id gt17-20020a17090af2d100b0023f355a0bb5sm2193788pjb.14.2023.03.17.21.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 21:30:08 -0700 (PDT)
Message-ID: <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
Date:   Sat, 18 Mar 2023 12:30:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-10-ychuang570808@gmail.com>
 <cee0497e-c441-3937-07ec-0b6c4621f4e4@linaro.org>
 <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


Thanks for your advice.


On 2023/3/16 下午 03:39, Krzysztof Kozlowski wrote:
> On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
>> On 15/03/2023 08:28, Jacky Huang wrote:
>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>
>>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.


OK, I will fix it.


>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>> ---
>>>   .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>>   1 file changed, 50 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>> new file mode 100644
>>> index 000000000000..f66c566c6dce
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>> @@ -0,0 +1,50 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Nuvoton MA35D1 Reset Controller
>>> +
>>> +maintainers:
>>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>>> +  - Jacky Huang <ychuang3@nuvoton.com>
>>> +
>>> +description:
>>> +  The system reset controller can be used to reset various peripheral
>>> +  controllers in MA35D1 SoC.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: nuvoton,ma35d1-reset
>>> +
>>> +  regmap:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description: Phandle to the register map node.
>> You need to be specific what is this. As you can easily check, there is
>> no such property in any devices. I don't understand why do you need it
>> in the first place.

         reset: reset-controller {
             compatible = "nuvoton,ma35d1-reset";
             regmap = <&sys>;
             #reset-cells = <1>;
         };

The dt_binding_check check report an error about the above "regmap".

I found that add this can pass the test.



>>> +
>>> +  '#reset-cells':
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - regmap
>>> +  - '#reset-cells'
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  # system reset controller node:
>>> +  - |
>>> +    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
>>> +
>>> +    sys: system-management@40460000 {
>>> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> And your patchset is not bisectable.... Test for bisectability before
>> sending.
> Ah, no, it's correct. I see the compatible in previous patch. You need
> to clearly describe the dependencies and merging strategy/requirements
> in cover letter.
>
> Best regards,
> Krzysztof

Sorry for the confusion.

I will add history to the cover letter.


Best regards,

Jacky Huang


