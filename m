Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91B6CD685
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjC2Jdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjC2Jdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:33:54 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC5A3AB4;
        Wed, 29 Mar 2023 02:33:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso15536024pjb.3;
        Wed, 29 Mar 2023 02:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680082431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gr/78HIaajnUF9/cak/2wkXNZKj3qszn9NpHtXjqQdg=;
        b=HNxzupGDFMLA9nI2VBIs9DC1vS8AUhUX59Le7Chbeuu2UBSKc2MGG/JOiztQdOBwtF
         iFN3iRZE/QnFshphc1iAh+jp6qbKcoanAINGv1TTc6BUn32eM3XLl1OepkSbaWJNYXxY
         GbH96VB2GYYZ9aORpiSSoHVWQ/XrDgm0poNhWYCN/Ca8JTOIaK+vDBlbCBR1ALZiASvo
         dQFtwiImHBn6Ng5WOiSifAjQDKzxfiBpu0Q87EVMldTz+kB+0eRp/ny5Iv1gmlRR7mPM
         yXiG4Wo6/Xclt+kXMbDmkyMo5vW7Wte89Ny/7v8gmZSbD4riyw0YGmKH0AGWocYdytMo
         VfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082431;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr/78HIaajnUF9/cak/2wkXNZKj3qszn9NpHtXjqQdg=;
        b=YtE8Vw0RW33W/GcczuqKV6e63gjzO+6AbE5xZLSABJRhQGlHjoek43XLL2vYq8dL3S
         URBNU/bV2OoCnDhJl63b2asfu0IeJ5DuyMqLIFV6BItHqlHQMUo+rmWOdh4/EXxW0lrH
         CMVyLeeyvN08Bi+ApSAj2JNLkf+xBGhKvjMNPI41w7ZVUB1EPlzMfw9aB0T2KsRrRS4l
         GsgzBOchYmWg4YbgncleEoaMkM1i8XSC8db6toQHW5jExENcezzpCQn2coyRdHNfmalS
         0QIcEyHkaZ9cNYWJLeW37abnyYF145a1oDIga5cRhm/i0pHSpeJeuwmjOX8T4AVYdqSL
         EPKw==
X-Gm-Message-State: AAQBX9fML/Pd+DUnyCYElNbs7TX7QlOPTq6D7kShf3ZltIPxj7O1qgj3
        Tp2fyrB61Mtksu8An+xZ9+nt7qyRE2m3ZA==
X-Google-Smtp-Source: AKy350YoyctsUx+sCnjK+I+mqn9x4QmnZbBZOnPl92t0xgUd6AioGmwsz7MZ92v/3pa9ppwtZH4VOQ==
X-Received: by 2002:a17:90b:1c02:b0:23d:1f95:de1c with SMTP id oc2-20020a17090b1c0200b0023d1f95de1cmr20376272pjb.28.1680082430744;
        Wed, 29 Mar 2023 02:33:50 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 63-20020a17090a0fc500b0023493354f37sm1015321pjz.26.2023.03.29.02.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:33:50 -0700 (PDT)
Message-ID: <38f73fc7-8906-89d1-a649-a183ea80a4e0@gmail.com>
Date:   Wed, 29 Mar 2023 17:33:46 +0800
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
 <1ddf53be-3c4f-3f24-de69-9475c82341b1@gmail.com>
 <d69a2d6a-bf59-ad4c-2d6b-e520fe9d174d@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <d69a2d6a-bf59-ad4c-2d6b-e520fe9d174d@linaro.org>
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



On 2023/3/29 下午 05:27, Krzysztof Kozlowski wrote:
> On 29/03/2023 11:12, Jacky Huang wrote:
>>>> +        };
>>>> +    };
>>>> +...
>>>> +
>>>> diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>>>> new file mode 100644
>>>> index 000000000000..f3088bc0afec
>>>> --- /dev/null
>>>> +++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>>>> @@ -0,0 +1,108 @@
>>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
>>> Weird license, why 2.0+?
>>>
>>> You already got here comment about license in previous version of this
>>> patch.
>>>
>> In fact, I always be confused with the license.
>> It should be right if I just copy one from the same directory
>> /include/dt-bindings/reset/.
>> But, when I find there are several versions there, I was confused and
>> just select one of them.
>>
>> /* SPDX-License-Identifier: GPL-2.0-only */
>> /* SPDX-License-Identifier: GPL-2.0+ */
>> /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
>> /* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>> /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>
>> So, should I fix the license as
>>
>> /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>>
>> just remove the '+' ?
> The simplest is to use the same license as your binding, so
> (GPL-2.0-only OR BSD-2-Clause) .

OK, I got it. Thank you very much.

>>>> +/*
>>>> + * Copyright (C) 2023 Nuvoton Technologies.
>>>> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
>>>> + *
>>>> + * Device Tree binding constants for MA35D1 reset controller.
>>>> + */
>>>> +
>>>> +#ifndef __DT_BINDINGS_RESET_MA35D1_H
>>>> +#define __DT_BINDINGS_RESET_MA35D1_H
>>>> +
>>>> +#define MA35D1_RESET_CHIP	0
>>>> +#define MA35D1_RESET_CA35CR0	1
>>>> +#define MA35D1_RESET_CA35CR1	2
>>>> +#define MA35D1_RESET_CM4	3
>>>> +#define MA35D1_RESET_PDMA0	4
>>>> +#define MA35D1_RESET_PDMA1	5
>>>> +#define MA35D1_RESET_PDMA2	6
>>>> +#define MA35D1_RESET_PDMA3	7
>>>> +#define MA35D1_RESET_DISP	9
>>>> +#define MA35D1_RESET_VCAP0	10
>>>> +#define MA35D1_RESET_VCAP1	11
>>>> +#define MA35D1_RESET_GFX	12
>>>> +#define MA35D1_RESET_VDEC	13
>>>> +#define MA35D1_RESET_WHC0	14
>>>> +#define MA35D1_RESET_WHC1	15
>>>> +#define MA35D1_RESET_GMAC0	16
>>>> +#define MA35D1_RESET_GMAC1	17
>>>> +#define MA35D1_RESET_HWSEM	18
>>>> +#define MA35D1_RESET_EBI	19
>>>> +#define MA35D1_RESET_HSUSBH0	20
>>>> +#define MA35D1_RESET_HSUSBH1	21
>>>> +#define MA35D1_RESET_HSUSBD	22
>>>> +#define MA35D1_RESET_USBHL	23
>>>> +#define MA35D1_RESET_SDH0	24
>>>> +#define MA35D1_RESET_SDH1	25
>>>> +#define MA35D1_RESET_NAND	26
>>>> +#define MA35D1_RESET_GPIO	27
>>>> +#define MA35D1_RESET_MCTLP	28
>>>> +#define MA35D1_RESET_MCTLC	29
>>>> +#define MA35D1_RESET_DDRPUB	30
>>>> +#define MA35D1_RESET_TMR0	34
>>>> +#define MA35D1_RESET_TMR1	35
>>>> +#define MA35D1_RESET_TMR2	36
>>>> +#define MA35D1_RESET_TMR3	37
>>>> +#define MA35D1_RESET_I2C0	40
>>>> +#define MA35D1_RESET_I2C1	41
>>>> +#define MA35D1_RESET_I2C2	42
>>>> +#define MA35D1_RESET_I2C3	43
>>>> +#define MA35D1_RESET_QSPI0	44
>>>> +#define MA35D1_RESET_SPI0	45
>>>> +#define MA35D1_RESET_SPI1	46
>>>> +#define MA35D1_RESET_SPI2	47
>>>> +#define MA35D1_RESET_UART0	48
>>>> +#define MA35D1_RESET_UART1	49
>>>> +#define MA35D1_RESET_UART2	50
>>>> +#define MA35D1_RESET_UAER3	51
>>>> +#define MA35D1_RESET_UART4	52
>>>> +#define MA35D1_RESET_UART5	53
>>>> +#define MA35D1_RESET_UART6	54
>>>> +#define MA35D1_RESET_UART7	55
>>>> +#define MA35D1_RESET_CANFD0	56
>>>> +#define MA35D1_RESET_CANFD1	57
>>>> +#define MA35D1_RESET_EADC0	60
>>> Why do you have gaps here? These should be IDs, not register offsets.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> The reset controller registers are composed of four 32-bits register.
>> And the ID will be translated into the corresponding bit of these register.
>> Each ID is mapped to a unique bit position.
> That's not the usual way. IDs start from 0 or 1 and gets incremented by
> 1, without gaps. Remember that IDs cannot change and your register bits
> could have some changes (e.g. HW errata).
>
>
> Best regards,
> Krzysztof
>

OK, I will modify the ID as contiguous number, and create a lookup table 
to translate
ID into bitmap.


Best Regards,
Jacky Huang



