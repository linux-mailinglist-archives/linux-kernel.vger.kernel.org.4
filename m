Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00F6BE01B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCQETA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCQES4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:18:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACF5211F8;
        Thu, 16 Mar 2023 21:18:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso3794411pjb.3;
        Thu, 16 Mar 2023 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679026733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EuTIcRDUqWKvYEoDWAPSBeY46ySNFISjMqGTJQVosW0=;
        b=GqGR26qwOEcUnwjsoHD7fbzqMkk70ZqdbXR5j68ArnJJxzR7vMjddICH9XA6H+ooLX
         XNy7w5QHTV3fyY2C+ONqiKZFoqduXKmq0E6pHF/pZRbOWRKc/AIHHgAq7mC22hTh9k49
         R5xqRxgJTwojQmGmpR13ff06A0EW9v7k0zWbZ95ngcIwXAqK/HgjF1UHh0cvcSAM5M1R
         GuEHBX4PClIv0TjbUydlaymR1lmipXU+vsYEkuI7kj0xw11QIMWnQCHQwq/3MMDYhdaC
         ZTVEmrx+L3pewXstyEFlSdIyu8MBGm4UKmErP+GXiuapCcM9bBGk1aMNOd0nXf+IzWdb
         Nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679026733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuTIcRDUqWKvYEoDWAPSBeY46ySNFISjMqGTJQVosW0=;
        b=tDE/yKu6t9KaU9Y5q3MuSSiLZ/rBefg+QG4xM9/PATLdZxUnTKH6hm27YPq+FmQQc5
         IXJeGMUlhHXH9/W2izRBCmc2dSS44qGljvdtGRM2vL9uOoM696K5CEagwdXTQA+nII1x
         5M5+4SQsWStagWQ4GZZ8070759tFOeIGjjMr5+DvKfcN2Bmuj4sNEZDEoR5tEmQjdasv
         iPfCKKnkTbr/BHoFwVzQ+Vy+R70PrebWmA0sb5ojsYPzono6e1O5LKK1SaG/4IhTdqRE
         GH0rwMuUCHLQWCnhIIHVsCRBSvelgHI1SHW5AS/drRTL1MkTBAUGbXOGOauNvTL0aPmS
         vPTQ==
X-Gm-Message-State: AO0yUKWz0C9AncZpTEhct1mslxzCCTWKotRjYmenvvvrF3yl1aeHRgpJ
        9fUFciXg3m9iBMfTJY6DnSs=
X-Google-Smtp-Source: AK7set/7n1Pek6SBN7TsVI5TShPwZwnI1bt88gulr9/lrV/k9FfuxOq/GEaUwI5ZI197Ab12IpcYaQ==
X-Received: by 2002:a17:90b:17cd:b0:23d:5485:b80e with SMTP id me13-20020a17090b17cd00b0023d5485b80emr6932629pjb.6.1679026733623;
        Thu, 16 Mar 2023 21:18:53 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d16-20020a63f250000000b004ff6b744248sm452538pgk.48.2023.03.16.21.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 21:18:53 -0700 (PDT)
Message-ID: <be253a29-2187-69a7-9909-49fdd073b010@gmail.com>
Date:   Fri, 17 Mar 2023 12:18:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/15] dt-bindings: serial: Document ma35d1 uart
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
 <20230315072902.9298-11-ychuang570808@gmail.com>
 <b4aa61fc-abd8-3287-83a3-beee2a06e628@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <b4aa61fc-abd8-3287-83a3-beee2a06e628@linaro.org>
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


On 2023/3/16 下午 03:40, Krzysztof Kozlowski wrote:
> On 15/03/2023 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add documentation to describe nuvoton ma35d1 uart driver bindings.
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.

I will fix it.

>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../serial/nuvoton,ma35d1-serial.yaml         | 52 +++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>> new file mode 100644
>> index 000000000000..9daa2efd4734
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/nuvoton,ma35d1-serial.yaml
>> @@ -0,0 +1,52 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/nuvoton,ma35d1-serial.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Universal Asynchronous Receiver/Transmitter (UART)
>> +
>> +maintainers:
>> +  - Min-Jen Chen <mjchen@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +allOf:
>> +  - $ref: "serial.yaml"
> Drop quotes. Use some recent bindings as your starting point, so we do
> not have to give comments for things which were already fixed.

Got it, I will remove the quotes.

>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-uart
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    aliases {
>> +        serial0 = &uart0;
>> +    };
> Drop aliases.

I will fix it.

>> +
>> +    uart0:serial@40700000 {
> Drop label

OK, I will remove the label.

>
> Best regards,
> Krzysztof
>

Best regards,

Jacky Huang

