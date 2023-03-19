Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF5D6C00AD
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCSLF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjCSLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:05:24 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9251234D0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:05:19 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so36395448edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679223918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oz7Mn5Slt/oCZXIyID1LQ+0ctRwDR+H2/7RiKV/KiC8=;
        b=z9Ary3jPwxWtnf6V3vNq0eQZ+9bqPM/Bmrbyxfk9GUbrahRuXb97qVmkFUmRYa+xxt
         qhxjdZkanTFpgKwk3LMFZGwT2krOqdSJTTd89h8jm1Ukus9cQ+uXQu0/ys8Xz1Z92NRb
         3gRq0JyWpgV72Tez7iS2oLGKsS1QH6vKeeZ0NUUbJpGm88JDLx5NLWIFiZiXJisNgFTx
         fWy9a6H+0Np2gR8nFkyHjMJ8xJP2Wwkmp5Bkf3bitmkacsmQY6nOvlu0K6TpkaBnIuIu
         qY4YhIT+o/gQme3tKSptm/4YKxG5u7+uK+tOffmdCMIhsbM5d6rsaFIz+uTHFIa8XpRM
         jd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679223918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oz7Mn5Slt/oCZXIyID1LQ+0ctRwDR+H2/7RiKV/KiC8=;
        b=us/vydB66IIC1ocMZTQiaOjM0Zd8USCbXs1+MXV0Im2+jyb1sPYkXslF9xHJVxNT7t
         ycDPWWbcEjCezNAHez0Mei1arMsOM8YqGfBNoxFx9rTYA8YuydTpPraIYj6IUyc8SYFW
         rrzo4pjffRkSm6FnhY3PiymRegXTNDqdfsXQh5uC+iL7PY+ZBsf1rgHjrnoyjNMA91PJ
         WS2K6TM9yppg+6acIAOPuMhdyVhOZAsvYFInVsOGwXQXUd0hJ77D9wTFK4ctHJqkRWau
         +4NGX68BsUOwp3QrH6CcF1D3nwDe/qw+e51i9E7hEbtdypb7GrPz7Y+zpenyExkTImQo
         LQ/w==
X-Gm-Message-State: AO0yUKX71aDRXbLG7SQA62/HD/KcrLi8nCppkVIbO4SYaSV0appIED9C
        HdZH+4nw+fDvBnIkzw8DwKIqUmKZ07Fe8601B2g=
X-Google-Smtp-Source: AK7set8iyweCO1S8OBE+lR0gDceMHD0ysV/bfRKB03FfwieiyiZ/Nrqp+yiz4a4BU9OPNpb08OMDEg==
X-Received: by 2002:a17:906:4ed3:b0:932:2282:dbd6 with SMTP id i19-20020a1709064ed300b009322282dbd6mr6255501ejv.5.1679223917979;
        Sun, 19 Mar 2023 04:05:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b0093048a8bd31sm3138943ejb.68.2023.03.19.04.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 04:05:17 -0700 (PDT)
Message-ID: <fd0cb506-707a-4f5d-b917-de6a03787f6a@linaro.org>
Date:   Sun, 19 Mar 2023 12:05:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 09/15] dt-bindings: reset: Document ma35d1 reset
 controller bindings
Content-Language: en-US
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
 <b9f93711-7302-4ed6-3f71-7bb792507136@linaro.org>
 <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4d62376f-1b33-62ac-2ed9-6b71ae7485a2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2023 05:30, Jacky Huang wrote:
> Dear Krzysztof,
> 
> 
> Thanks for your advice.
> 
> 
> On 2023/3/16 下午 03:39, Krzysztof Kozlowski wrote:
>> On 16/03/2023 08:37, Krzysztof Kozlowski wrote:
>>> On 15/03/2023 08:28, Jacky Huang wrote:
>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>
>>>> Add documentation to describe nuvoton ma35d1 reset driver bindings.
>>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>>> prefix is already stating that these are bindings.
> 
> 
> OK, I will fix it.
> 
> 
>>>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>>>> ---
>>>>   .../bindings/reset/nuvoton,ma35d1-reset.yaml  | 50 +++++++++++++++++++
>>>>   1 file changed, 50 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>> new file mode 100644
>>>> index 000000000000..f66c566c6dce
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>>> @@ -0,0 +1,50 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Nuvoton MA35D1 Reset Controller
>>>> +
>>>> +maintainers:
>>>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>>>> +  - Jacky Huang <ychuang3@nuvoton.com>
>>>> +
>>>> +description:
>>>> +  The system reset controller can be used to reset various peripheral
>>>> +  controllers in MA35D1 SoC.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: nuvoton,ma35d1-reset
>>>> +
>>>> +  regmap:
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +    description: Phandle to the register map node.
>>> You need to be specific what is this. As you can easily check, there is
>>> no such property in any devices. I don't understand why do you need it
>>> in the first place.
> 
>          reset: reset-controller {
>              compatible = "nuvoton,ma35d1-reset";
>              regmap = <&sys>;
>              #reset-cells = <1>;
>          };
> 
> The dt_binding_check check report an error about the above "regmap".
> 
> I found that add this can pass the test.

Do not add properties to bindings to "pass the test". That's not the
goal of bindings. Add there properties because they make sense...

Anyway, you did not answer my question at all. So one by one - address them:
1. As you can easily check, there is no such property in any devices.
Explanation: do you see it anywhere in existing bindings?

2. I don't understand why do you need it in the first place.
Explanation: your binding suggest this is not needed. If you think
otherwise, you need to provide rationale.



Best regards,
Krzysztof

