Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD16A44D7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjB0Olb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjB0Ol2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:41:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E9D20564
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:41:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az36so4406097wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1ciYzjzBy3gfz4y6Y2JrahH5KBtu69kG00GA/F52AY=;
        b=galyeW3Y/ZKXfxjNntAQk6EiQUOCJT4CyWMa7zLNmhh+PaDRlUOlTGF0/7YLf/KEOT
         hCjDk4RMDE3fr5z3FvT+qolNVLqKXIzYk2jfteD4dboVs8vDZsEpYpW2OLZ3bK4KjN3+
         KX/Z7GrtOFfvmR8JtbRCISD8i2IsYxyXFwP0xcOxQKsSiCjDXnr8czZaqyvZSWe+Zpob
         cVjKD+4+kkKIkFHp8nPosGGa/JXYM/5haHtGN8UK2PjebfKSB2Z3Alk69TpyF7iudX/L
         rKWdHm4q6kIG/X2O6V5f+mRWH7V7/Wb68SFEVwPnUZvls7p5mX/sn6Ih7F5qvXYHtUXt
         Y8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1ciYzjzBy3gfz4y6Y2JrahH5KBtu69kG00GA/F52AY=;
        b=JuGtUvyohjVdix7Bm3WwdWH/etxX3vzBrImZOFYfEVDHK3eJADk7sgKxmGWgchKGPi
         JrOQmFZXr7hAIzKQv6Pq/m52Gz9QqntwqM6ix7b1spwD6cxYcgZdDuV9t0hrSfRgulaj
         gbePbuB2SR+t/pgr52KNz7ISmnIe6rnS6VHKlV+YCK11b/UVtb+AP+Pr0Ri0HJ/e5xdv
         KzF9hlPGkfTwl6AuAaCn3/MHkc5zcBOZ+kNrrEaa14p93e07YLiltyG5+ft9/k2VRU65
         xRarRoRWREOe+C1H1DwVNzBNRzHlTuQXXJ5Iu4EpojpILZEuA+uzTeICnt0LUe76EaFO
         hi7w==
X-Gm-Message-State: AO0yUKVhFBL0OUzw2Er481hhoZECnubwhtApUWOk3CmcXKwTpetuylIs
        stKkW7SfAsRdV1qUGIol3Uk3pw==
X-Google-Smtp-Source: AK7set9HRlUGJup0r4UlH2WAr4w4xlP49Ruq+BeYt0uYrYvow/OWiJSmb8hqYYmcCG6hIUXk8Ad0FQ==
X-Received: by 2002:a05:600c:ccc:b0:3df:db20:b0ae with SMTP id fk12-20020a05600c0ccc00b003dfdb20b0aemr6859368wmb.17.1677508886098;
        Mon, 27 Feb 2023 06:41:26 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d51c5000000b002c70d97af78sm7386052wrv.85.2023.02.27.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:41:25 -0800 (PST)
Message-ID: <a652dd51-34c8-f493-1827-710f9b82bf5c@linaro.org>
Date:   Mon, 27 Feb 2023 15:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] arch/arm: dts: introduce meson-a1 device tree
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Alexey Romanov <avromanov@sberdevices.ru>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <20230222115020.55867-4-avromanov@sberdevices.ru>
 <bc514ba7-406e-bca8-4d3a-4f8997cd3241@linaro.org>
 <d5d9a1fe-2f66-66e3-d88a-76a12f2ec55e@linaro.org>
 <20230227143929.h2lppesdiaj7l3gn@CAB-WSD-L081021>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227143929.h2lppesdiaj7l3gn@CAB-WSD-L081021>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 15:39, Dmitry Rokosov wrote:
> Hello Krzysztof!
> 
> On Thu, Feb 23, 2023 at 10:09:25AM +0100, Krzysztof Kozlowski wrote:
> 
> [...]
> 
>>>> describes following compontents: CPU, GIC, IRQ, Timer, UART,
>>>> PIN controller. It's capable of booting up into
>>>> the serial console.
>>>>
>>>> This is based on arm64 version of meson-a1.dtsi.
>>>>
>>>> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>>>> ---
>>>>  arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++
>>>
>>> There is such file and there is such DTS/hardware support. I don't see
>>> any reason why entire DTSI should be duplicated. What's more, your
>>> commit does not explain it - does not justify duplication.
>>
>> One more comment - I think you just added dead code. It's
>> uncompilable/untestable. Otherwise, please share how to build this DTSI
>> without DTS.
> 
> You are right, Alexey doesn't provide any exact *.dts file for any
> board, and *.dtsi file should be included somewhere, otherwise this is
> dead code.
> Unfortunately, our internal board *.dts file is useless for kernel
> community, cause there is not any chance to burn locally compiled kernel
> to our product due to secureboot protection.
> But I think there is one possible option. We have reference Amlogic
> boards somewhere in the office. So we can test 32-bit configuration on
> it and prepare proper *.dts file for that. What do you think, it
> reasanoble?

You just need to provide valid board which works in 32-bit mode. Anyway
duplicating DTSI is a no-go and we do not do it in other platforms.


Best regards,
Krzysztof

