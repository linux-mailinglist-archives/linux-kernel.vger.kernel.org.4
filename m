Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E026BDFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCQDrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCQDru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:47:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF706F60B;
        Thu, 16 Mar 2023 20:47:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so3699167pjt.5;
        Thu, 16 Mar 2023 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679024864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LG/DIr+0K1JSvKnn3E0g/U/IiefLZ8MeJXvgz55e+Co=;
        b=JHFY2mxbdZE3lOuV3TABXI8LL88x9fGsLHq4RckyUgR6FnaGBbl8qcEWmSSeVd6mlL
         ZdHh4myNyvs38ncf4uA2QRqaDmwwXdtOq8LlFGG0e55StIstl9aPNBnxtFtA8G3ue8h7
         xt8GBOv4u7UZore8ZQNDJpMDgpI300qsX6OqBG+BEwkRfeZQwvma87r9AQ+++3u5CCTI
         b3ytFV5Bz6AjgBtfYaUw63tuKYmlhHcsyMpYEa23PRL/ytwdKLV2NJDr/KIOU06Swkab
         qOKQb43qRmGgVBMjpHB4Ds6FatIMePTJNnsaRrojqra2U8buIH+E1tZutuyjfL+o7bHI
         j2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679024864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LG/DIr+0K1JSvKnn3E0g/U/IiefLZ8MeJXvgz55e+Co=;
        b=O6UU4NWlwicVHEJmy3uPmr7vXw8jzkT++NA8Wa9WP2qYctP3lFWXH2j+79wVuyUrgR
         hxrKM3yz0Gm3kx+hroPM6/nTSe8iqyLIjqF4NdhziQU/IrbaV9XKXZKLkSh6Bx5Ap+yj
         dY8RgSxsHDSF+UFLyO5AhIA+5S2OQEdIlZWrr8whdEXSP+flxXzHe7AI2qSYKn4Vvkix
         oIhPzWH2w19xOqJd0BeBjH+6wdZxkyLFF8mB1RCK6DRD1keWZ0qQ8f+hXHBTZ43vmH1e
         zRGLfv9GM6gBa2N5X/OaagXYDGHN0J6l2vjTMs4/SLfv/n1rVtnfQSTOiknvEqKY7s4p
         tg9A==
X-Gm-Message-State: AO0yUKUv8+Q02ioE+Isw55pTNJ5UK6B+5W0gd0L5VFT0BQOGyiO2t2+4
        yo1shDWp3CWghFbeJIotBLzidxl4B5gthQ==
X-Google-Smtp-Source: AK7set9scFjLx3oPVd1sEXeKPMhCR0g28jWfgBdfuKIlw+b6CoX6JkvRT1QclDB3lwYhqB/LZnMJrg==
X-Received: by 2002:a17:90b:1b4a:b0:23c:61f:2be4 with SMTP id nv10-20020a17090b1b4a00b0023c061f2be4mr6603439pjb.20.1679024864498;
        Thu, 16 Mar 2023 20:47:44 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902728300b0019c32968271sm456594pll.11.2023.03.16.20.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 20:47:44 -0700 (PDT)
Message-ID: <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
Date:   Fri, 17 Mar 2023 11:47:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
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
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
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


On 2023/3/16 下午 03:35, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 clock driver bindings.
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.

Got it, thanks.

>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/clock/nuvoton,ma35d1-clk.yaml    | 83 +++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> new file mode 100644
>> index 000000000000..5c2dea071b38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Clock Controller Module Binding
>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description: |
>> +  The MA35D1 clock controller generates clocks for the whole chip,
>> +  including system clocks and all peripheral clocks.
>> +
>> +  See also:
>> +    include/dt-bindings/clock/ma35d1-clk.h
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: nuvoton,ma35d1-clk
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: clk_hxt
> Drop clock-names. You do not need it for one clock.

I will remove it.

>
>
>> +
>> +  assigned-clocks:
>> +    maxItems: 5
>> +
>> +  assigned-clock-rates:
>> +    maxItems: 5
> Drop both properties, you do not need them in the binding.

I will drop them.

>
>> +
>> +  nuvoton,pll-mode:
>> +    description:
>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>> +      spectrum mode.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 5
>> +    items:
>> +      minimum: 0
>> +      maximum: 2
> Why exactly this is suitable for DT?

I will use strings instead.

>
>> +
>> +  nuvoton,sys:
>> +    description:
>> +      Phandle to the system management controller.
>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> Drop quotes.
>
> You need here constraints, look for existing examples.
>

I would like to modify this as:


   nuvoton,sys:
     description:
       Use to unlock and lock some clock controller registers. The lock
       control register is in system controller.
     $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to the system controller.


>
> Best regards,
> Krzysztof
>

Best regards,

Jacky Huang
