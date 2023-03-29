Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE1A6CD663
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjC2J1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2J1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:27:19 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E526AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:27:17 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e21so15383094ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 02:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680082036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4E1ihT1bk7FJWhZsymYfujANMixRZZjQV1eBAivQbCc=;
        b=IIssgv4Nws9KMkhlj1SWdiTR8QeRnUyggLWHGk9OtquP6r1Ty66EXdDq+4yGO82O04
         xb3pACE4ORMwgSdGT3zziPccod8yVO18IqGIP7m8Edr3VbipssR/2d8YKR/vh+fgZWgE
         /FRqSX71P0xAbFyKEMCfRGnu5NLyiCOtQC8jPefeqgSjCCaWxu4D4NVzkQZXZCNX9GOg
         O470eDDSqMC8uhdKs8jex4FJ/yYr/3S9V4Go6a6jdXxJx3td7U7DdAxZlKR/4DzsfzOc
         hlTXVR2NHvsN1b9eS3LOTAj4rCdvPOGT6kBlLwqxd+5mGiXwviHoffNSVfQlAkUvb3V8
         6wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082036;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4E1ihT1bk7FJWhZsymYfujANMixRZZjQV1eBAivQbCc=;
        b=iMfUmhhdKIaOh8EViFIEBgSK3PyzuDrvpKXcqoTx24F648/pbOpoMy1cr4FPKy8J+6
         aLU2oZl8uk+Acownxx5Y/7UPB2sHjJm8FLLs/SVU+5RCtC0Oz7ETODNVoWU1PhdwjcRu
         H8zMMn4/1YuDSky8rlzu0Hmw+z0qsIEJouhifBJn4VZzW/5OfRXm+8JFLe8V7ndt2ehc
         UmgdouXa3uZrgtlpTvbfHKHeOHVHEY9GAVV3qWhGDLD6OLMRsaYO5ANPJn5vvPub/Si+
         AD0QBWjKbrN06x37J+P4bKHYsu4NfQY/ShxpXGPKSwx/t11y5cQPy4HmGSWKEOrXAOlJ
         G0LA==
X-Gm-Message-State: AAQBX9fx4dnm2kbnN+i3MqOyBifnugPeid+LsKTWxdNpI8yGcb7hJinf
        Dsa/deyjaG9zvQLNO+WfrIUAzg==
X-Google-Smtp-Source: AKy350a3WPd3nLMEIos8we3J7fDWmZ6UZx92CCwawDT5W787jUpRWjhmYBrGbnekUlPP6v6UTiX2Ow==
X-Received: by 2002:a05:651c:446:b0:29c:88a7:9a96 with SMTP id g6-20020a05651c044600b0029c88a79a96mr6297508ljg.46.1680082036048;
        Wed, 29 Mar 2023 02:27:16 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s18-20020a2e9c12000000b00295765966d9sm5406109lji.86.2023.03.29.02.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 02:27:15 -0700 (PDT)
Message-ID: <d69a2d6a-bf59-ad4c-2d6b-e520fe9d174d@linaro.org>
Date:   Wed, 29 Mar 2023 11:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for
 ma35d1 IP reset control
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-5-ychuang570808@gmail.com>
 <96bbb16a-1748-c0cb-0fc6-90804eab01c1@linaro.org>
 <1ddf53be-3c4f-3f24-de69-9475c82341b1@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1ddf53be-3c4f-3f24-de69-9475c82341b1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 11:12, Jacky Huang wrote:
>>> +        };
>>> +    };
>>> +...
>>> +
>>> diff --git a/include/dt-bindings/reset/nuvoton,ma35d1-reset.h b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>>> new file mode 100644
>>> index 000000000000..f3088bc0afec
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/nuvoton,ma35d1-reset.h
>>> @@ -0,0 +1,108 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
>> Weird license, why 2.0+?
>>
>> You already got here comment about license in previous version of this
>> patch.
>>
> 
> In fact, I always be confused with the license.
> It should be right if I just copy one from the same directory 
> /include/dt-bindings/reset/.
> But, when I find there are several versions there, I was confused and 
> just select one of them.
> 
> /* SPDX-License-Identifier: GPL-2.0-only */
> /* SPDX-License-Identifier: GPL-2.0+ */
> /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
> /* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> 
> So, should I fix the license as
> 
> /* SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
> 
> just remove the '+' ?

The simplest is to use the same license as your binding, so
(GPL-2.0-only OR BSD-2-Clause) .

> 
>>> +/*
>>> + * Copyright (C) 2023 Nuvoton Technologies.
>>> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
>>> + *
>>> + * Device Tree binding constants for MA35D1 reset controller.
>>> + */
>>> +
>>> +#ifndef __DT_BINDINGS_RESET_MA35D1_H
>>> +#define __DT_BINDINGS_RESET_MA35D1_H
>>> +
>>> +#define MA35D1_RESET_CHIP	0
>>> +#define MA35D1_RESET_CA35CR0	1
>>> +#define MA35D1_RESET_CA35CR1	2
>>> +#define MA35D1_RESET_CM4	3
>>> +#define MA35D1_RESET_PDMA0	4
>>> +#define MA35D1_RESET_PDMA1	5
>>> +#define MA35D1_RESET_PDMA2	6
>>> +#define MA35D1_RESET_PDMA3	7
>>> +#define MA35D1_RESET_DISP	9
>>> +#define MA35D1_RESET_VCAP0	10
>>> +#define MA35D1_RESET_VCAP1	11
>>> +#define MA35D1_RESET_GFX	12
>>> +#define MA35D1_RESET_VDEC	13
>>> +#define MA35D1_RESET_WHC0	14
>>> +#define MA35D1_RESET_WHC1	15
>>> +#define MA35D1_RESET_GMAC0	16
>>> +#define MA35D1_RESET_GMAC1	17
>>> +#define MA35D1_RESET_HWSEM	18
>>> +#define MA35D1_RESET_EBI	19
>>> +#define MA35D1_RESET_HSUSBH0	20
>>> +#define MA35D1_RESET_HSUSBH1	21
>>> +#define MA35D1_RESET_HSUSBD	22
>>> +#define MA35D1_RESET_USBHL	23
>>> +#define MA35D1_RESET_SDH0	24
>>> +#define MA35D1_RESET_SDH1	25
>>> +#define MA35D1_RESET_NAND	26
>>> +#define MA35D1_RESET_GPIO	27
>>> +#define MA35D1_RESET_MCTLP	28
>>> +#define MA35D1_RESET_MCTLC	29
>>> +#define MA35D1_RESET_DDRPUB	30
>>> +#define MA35D1_RESET_TMR0	34
>>> +#define MA35D1_RESET_TMR1	35
>>> +#define MA35D1_RESET_TMR2	36
>>> +#define MA35D1_RESET_TMR3	37
>>> +#define MA35D1_RESET_I2C0	40
>>> +#define MA35D1_RESET_I2C1	41
>>> +#define MA35D1_RESET_I2C2	42
>>> +#define MA35D1_RESET_I2C3	43
>>> +#define MA35D1_RESET_QSPI0	44
>>> +#define MA35D1_RESET_SPI0	45
>>> +#define MA35D1_RESET_SPI1	46
>>> +#define MA35D1_RESET_SPI2	47
>>> +#define MA35D1_RESET_UART0	48
>>> +#define MA35D1_RESET_UART1	49
>>> +#define MA35D1_RESET_UART2	50
>>> +#define MA35D1_RESET_UAER3	51
>>> +#define MA35D1_RESET_UART4	52
>>> +#define MA35D1_RESET_UART5	53
>>> +#define MA35D1_RESET_UART6	54
>>> +#define MA35D1_RESET_UART7	55
>>> +#define MA35D1_RESET_CANFD0	56
>>> +#define MA35D1_RESET_CANFD1	57
>>> +#define MA35D1_RESET_EADC0	60
>> Why do you have gaps here? These should be IDs, not register offsets.
>>
>> Best regards,
>> Krzysztof
>>
> 
> The reset controller registers are composed of four 32-bits register.
> And the ID will be translated into the corresponding bit of these register.
> Each ID is mapped to a unique bit position.

That's not the usual way. IDs start from 0 or 1 and gets incremented by
1, without gaps. Remember that IDs cannot change and your register bits
could have some changes (e.g. HW errata).


Best regards,
Krzysztof

