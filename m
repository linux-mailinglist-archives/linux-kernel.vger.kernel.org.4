Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBA06F3007
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjEAKAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAKAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:00:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52763E46
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:00:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so2335005a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682935236; x=1685527236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkOomt6tBl7+mC6uaUyDQKMgbw/xe1HKh6gjrCXxFHs=;
        b=tQsWhEw5bVJYgz0T81aKGWIMqfTt2Hl3bYAAPetvydYCQrz4Y5x3zn2yLB1oof9HIj
         0mQs57cjeI6fK8FpAcA8Ijp5ACB0Vw/Z8VYAa9TTaDNKD1oUB4h5t+tOR378qjrf3Lo8
         q9RT/kk/tEr3BBB3+uZtvVoiYqn3l+ix8xxz9JpnwXE/k7EV2s3Ok3QR1jinjgUxrKwQ
         MQ4KNt2ZNUTjOGTPGV0/ROE3mYkxY2Co/QP+tXsF0B2WmW3cWs2mfH4KmnMD84n3Adih
         VvP2Iuj3oq65T89i3DLEs/jq0y/qWJP+k3M+A2ZYwdOQ9Td+nnTKv2/oQ0zGBSkGuceG
         pIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682935236; x=1685527236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkOomt6tBl7+mC6uaUyDQKMgbw/xe1HKh6gjrCXxFHs=;
        b=l0RWqpDZleUM5RUDN1vAdI1gFQGeOOZ+7zdXcuoeuQHxDDDu7TsoR30EJKJ3oyMIiB
         7jjLsyns+io4Ul3Ztmg26lznQZ0NW4KJSdwQ7wwwUEdHfF5tA3RAjeykOoRwwxE0e8nU
         Lc6pgfMWxXJDwbnSJCv9E8xgsh+L+x4tJMB3mu5N4Q1fFBkpmOS6PIJjzZJ7SqKx9w+y
         R8iNU4tFxtQqka3PjUUKn6vkQ6Tny1niTFjvu/pQdpEsPeC8vS50WgC/2voR8ZwHs9aR
         XBL1T4CuSuRKVIb9DceTUN1UHyJbYxdOAaz6uifWesJFJIxRrAeDnGrWeDV5KssQTTOM
         kM5g==
X-Gm-Message-State: AC+VfDxcxaNecDOEWqurGN0b+Va/P/yyEoHjNwRl9byfTL9ZV7S69f7A
        EVR4MhcjYnWYfwuV5iHh8syN2g==
X-Google-Smtp-Source: ACHHUZ54UKkHxmw4nSTauFR9wUUVYcouhrju6Lh7lgnQ44osDZooe2HEmZy5gTOuUInPhe/L/FF8mQ==
X-Received: by 2002:aa7:d318:0:b0:501:d6c2:7439 with SMTP id p24-20020aa7d318000000b00501d6c27439mr5088432edq.37.1682935235399;
        Mon, 01 May 2023 03:00:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:637a:fd0c:58fd:9f00? ([2a02:810d:15c0:828:637a:fd0c:58fd:9f00])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402181200b004c2158e87e6sm11847552edy.97.2023.05.01.03.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 03:00:34 -0700 (PDT)
Message-ID: <87a3bb36-bb75-5c01-dbdc-ee91d6496321@linaro.org>
Date:   Mon, 1 May 2023 12:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC PATCH 2/2] arm64: dts: add support for C3 based Amlogic
 AW409
Content-Language: en-US
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230419073834.972273-1-xianwei.zhao@amlogic.com>
 <20230419073834.972273-3-xianwei.zhao@amlogic.com>
 <4e6469e5-0f6c-4150-4709-7459597f06cc@linaro.org>
 <5a11ccfd-eafa-391a-e2b9-d032510c9e7b@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5a11ccfd-eafa-391a-e2b9-d032510c9e7b@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 10:54, xianwei.zhao wrote:
> Hi Krzysztof,
> 
>          Thank you for your reply.
> 
> On 2023/4/19 15:48, Krzysztof Kozlowski wrote:
>> [你通常不会收到来自krzysztof.kozlowski@linaro.org  的电子邮件。请访问https://aka.ms/LearnAboutSenderIdentification，以了解这一点为什么很重要]
>>
>> [ EXTERNAL EMAIL ]
>>
>> On 19/04/2023 09:38, =Xianwei Zhao wrote:
>>> From: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>>
>>> Amlogic C3 is an advanced edge AI processor designed for smart IP camera
>>> applications.
>>>
>>> Add basic support for the C3 based Amlogic AW409 board, which describes
>>> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
>>> booting up into the serial console.
>>>
>>> Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
>>> ---
>>>   arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>>   .../amlogic/amlogic-c3-c302x-aw409-256m.dts   | 30 +++++++
>>>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi   | 87 +++++++++++++++++++
>>>   3 files changed, 118 insertions(+)
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>>   create mode 100644 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>>> index cd1c5b04890a..d2b5d0d750bc 100644
>>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>>> @@ -74,3 +74,4 @@ dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
>>>   dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
>>> +dtb-$(CONFIG_ARCH_AMLIPC) += amlogic-c3-c302x-aw409-256m.dtb
>>> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>> new file mode 100644
>>> index 000000000000..38ca98a32181
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3-c302x-aw409-256m.dts
>>> @@ -0,0 +1,30 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2021 Amlogic, Inc. All rights reserved.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +
>>> +#include "amlogic-c3.dtsi"
>>> +
>>> +/ {
>>> +     model = "Amlogic C302 aw409 Development Board";
>>> +     compatible = "amlogic,aw409", "amlogic,c3";
>> Undocumented compatibles. Run checkpatch and fix all warnings. Anyway, I
>> am not sure this warrants separate architecture. Isn't C3 standard Meson
>> SoC?
> The patch related to bindings is committed, see: 
> https://lore.kernel.org/all/20230407102704.1055152-1-kelvin.zhang@amlogic.com/

And how can we know this? There are no bindings in next, so you are
supposed to sent these together. At minimum link to the bindings patch.

Otherwise you will keep getting review comments.

Best regards,
Krzysztof

