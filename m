Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3A6CD615
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjC2JNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjC2JM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:12:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05261FD8;
        Wed, 29 Mar 2023 02:12:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so17929805pjp.1;
        Wed, 29 Mar 2023 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680081177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8Zkws+xWRTaYS/ZAzUFbnGxAmYvxcaqEtVBhFnWTyA=;
        b=jEs0Ev+2VuxncC2NHQn2BKc/0ZhuALWzlT8LxHS2+OBvyCXs1AnqBmdZHFhKF3Xusf
         jk3LIRU+S1zeFLtx2Nc28hft9VlceAp+7xp9jG7QaQSsGBFLYbSGPj1LsshMPs72DATM
         ngfQrpxJx+GELgcCdPI5aS+iE77mnTun+XoKNPgzHoOP7RvftwNor/iYEnk++9rt+rA9
         GKvAgsofAc0IC/IadpUQqKOgS06Ro+UdZTUH47YJYTPzTu2X3nH8v++LG3Qpzfh7yNzC
         8njLP8gKB11khswSQl6xi/1n8BairFLO+YVop/w/eO6PHCWjyoUScavei8MYeDjqB5ka
         ni1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680081177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8Zkws+xWRTaYS/ZAzUFbnGxAmYvxcaqEtVBhFnWTyA=;
        b=DVZqNUBRUUG0W55hHx4ZV65J4EZ56Gfcs31l6bWUcKWgvqgo5iW9pewpJOGSWAuhE2
         Tmga07NEr/r5oyasCCzazq7+CvtsdX7jaLGJEZRFXdLor3rVVjvgn0GZnnjBVeOJK8HF
         5IxMLuVslZ5+vMvqHxAba5OJjx/P+RrjYtibP+ZXb1HeuSaXkhcyx30BmoknVPpz5XDA
         VdLjbgRHZK7oUi7wGtD9VCA1x91oUeEe8RDS5uRMQ980qY9zUcs7qveDjQAPMeU/0FJN
         1pvSKjb9xkuAyyRXiEozHZG48JIC+KrhV+aEZEjswfOcUJUMhLYxPHDs64QwhqHgexWa
         6SIw==
X-Gm-Message-State: AAQBX9cWEvkE3O627LPMY/dNi+wxR8HOS5TxtKXQ9YtzIlZH7vDQv45y
        HcxXhb+5OV1nuyzUxEgDpUHcjwxEd8u1RQ==
X-Google-Smtp-Source: AKy350YncHX6Rvpv+z5oKzm7ebxFxwhDbtKH8f3BZMbuyOc4HIOf/MqAx2wyjrXHWKlD6dNZjXwMdg==
X-Received: by 2002:a17:902:f2ca:b0:1a1:c54c:1a36 with SMTP id h10-20020a170902f2ca00b001a1c54c1a36mr14960678plc.63.1680081176848;
        Wed, 29 Mar 2023 02:12:56 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b0019e5fc3c7e6sm22512327plg.101.2023.03.29.02.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:12:56 -0700 (PDT)
Message-ID: <1ddf53be-3c4f-3f24-de69-9475c82341b1@gmail.com>
Date:   Wed, 29 Mar 2023 17:12:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for
 ma35d1 IP reset control
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-5-ychuang570808@gmail.com>
 <96bbb16a-1748-c0cb-0fc6-90804eab01c1@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <96bbb16a-1748-c0cb-0fc6-90804eab01c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Krzysztof,


On 2023/3/29 下午 04:17, Krzysztof Kozlowski wrote:
> On 28/03/2023 04:19, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
>
> This is a friendly reminder during the review process.
>
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
>
> Thank you.
>
>> Add the dt-bindings header for Nuvoton ma35d1, that gets shared
>> between the reset controller and reset references in the dts.
>> Add documentation to describe nuvoton ma35d1 reset driver.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/reset/nuvoton,ma35d1-reset.yaml  |  44 +++++++
>>   .../dt-bindings/reset/nuvoton,ma35d1-reset.h  | 108 ++++++++++++++++++
>>   2 files changed, 152 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>>   create mode 100644 include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> new file mode 100644
>> index 000000000000..342717257e5c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> @@ -0,0 +1,44 @@
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
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # system reset controller node:
>> +  - |
>> +
>> +    system-management@40460000 {
>> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> +        reg = <0x40460000 0x200>;
>> +
>> +        reset-controller {
>> +            compatible = "nuvoton,ma35d1-reset";
>> +            #reset-cells = <1>;
> You do not take any resources here, thus this should be rather part of
> the parent node.

I will modify it as:
     sys: system-management@40460000 {
         compatible = "nuvoton,ma35d1-sys", "syscon",;
         reg = <0x0 0x40460000 0x0 0x200>;
         #reset-cells = <1>;
         };
     };


>> +        };
>> +    };
>> +...
>> +
>> diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>> new file mode 100644
>> index 000000000000..f3088bc0afec
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>> @@ -0,0 +1,108 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
> Weird license, why 2.0+?
>
> You already got here comment about license in previous version of this
> patch.
>

In fact, I always be confused with the license.
It should be right if I just copy one from the same directory 
/include/dt-bindings/reset/.
But, when I find there are several versions there, I was confused and 
just select one of them.

/* SPDX-License-Identifier: GPL-2.0-only */
/* SPDX-License-Identifier: GPL-2.0+ */
/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

So, should I fix the license as

/* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */

just remove the '+' ?

>> +/*
>> + * Copyright (C) 2023 Nuvoton Technologies.
>> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
>> + *
>> + * Device Tree binding constants for MA35D1 reset controller.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_RESET_MA35D1_H
>> +#define __DT_BINDINGS_RESET_MA35D1_H
>> +
>> +#define MA35D1_RESET_CHIP	0
>> +#define MA35D1_RESET_CA35CR0	1
>> +#define MA35D1_RESET_CA35CR1	2
>> +#define MA35D1_RESET_CM4	3
>> +#define MA35D1_RESET_PDMA0	4
>> +#define MA35D1_RESET_PDMA1	5
>> +#define MA35D1_RESET_PDMA2	6
>> +#define MA35D1_RESET_PDMA3	7
>> +#define MA35D1_RESET_DISP	9
>> +#define MA35D1_RESET_VCAP0	10
>> +#define MA35D1_RESET_VCAP1	11
>> +#define MA35D1_RESET_GFX	12
>> +#define MA35D1_RESET_VDEC	13
>> +#define MA35D1_RESET_WHC0	14
>> +#define MA35D1_RESET_WHC1	15
>> +#define MA35D1_RESET_GMAC0	16
>> +#define MA35D1_RESET_GMAC1	17
>> +#define MA35D1_RESET_HWSEM	18
>> +#define MA35D1_RESET_EBI	19
>> +#define MA35D1_RESET_HSUSBH0	20
>> +#define MA35D1_RESET_HSUSBH1	21
>> +#define MA35D1_RESET_HSUSBD	22
>> +#define MA35D1_RESET_USBHL	23
>> +#define MA35D1_RESET_SDH0	24
>> +#define MA35D1_RESET_SDH1	25
>> +#define MA35D1_RESET_NAND	26
>> +#define MA35D1_RESET_GPIO	27
>> +#define MA35D1_RESET_MCTLP	28
>> +#define MA35D1_RESET_MCTLC	29
>> +#define MA35D1_RESET_DDRPUB	30
>> +#define MA35D1_RESET_TMR0	34
>> +#define MA35D1_RESET_TMR1	35
>> +#define MA35D1_RESET_TMR2	36
>> +#define MA35D1_RESET_TMR3	37
>> +#define MA35D1_RESET_I2C0	40
>> +#define MA35D1_RESET_I2C1	41
>> +#define MA35D1_RESET_I2C2	42
>> +#define MA35D1_RESET_I2C3	43
>> +#define MA35D1_RESET_QSPI0	44
>> +#define MA35D1_RESET_SPI0	45
>> +#define MA35D1_RESET_SPI1	46
>> +#define MA35D1_RESET_SPI2	47
>> +#define MA35D1_RESET_UART0	48
>> +#define MA35D1_RESET_UART1	49
>> +#define MA35D1_RESET_UART2	50
>> +#define MA35D1_RESET_UAER3	51
>> +#define MA35D1_RESET_UART4	52
>> +#define MA35D1_RESET_UART5	53
>> +#define MA35D1_RESET_UART6	54
>> +#define MA35D1_RESET_UART7	55
>> +#define MA35D1_RESET_CANFD0	56
>> +#define MA35D1_RESET_CANFD1	57
>> +#define MA35D1_RESET_EADC0	60
> Why do you have gaps here? These should be IDs, not register offsets.
>
> Best regards,
> Krzysztof
>

The reset controller registers are composed of four 32-bits register.
And the ID will be translated into the corresponding bit of these register.
Each ID is mapped to a unique bit position.


Best regards,
Jacky Huang

