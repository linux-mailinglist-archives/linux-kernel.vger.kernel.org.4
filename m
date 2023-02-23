Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCE46A0482
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjBWJJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjBWJJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:09:34 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469154C03
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:09:31 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id eg37so35872635edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTHH9zlDbccoeTvmUDLrTEqObJ4nge6CNLgpKIfq2Nc=;
        b=L0TWocZdfOWbL96bTpIQDkvaSs7o3o4cO16HwuUxwlTvaIlvDlGhPqNlwkQFCz2BZH
         tbmfoULCqeCg9jidx+1+SLITPxcXi0ZzwEjg8Ue9fKJcw9dRqMcNmrSoIr+EHp3gEr9+
         GkOWxjHXVtSPWqXFyuQ4zjDCqG2G07kCCPXr2gttwyBYdchCl3x0vUoc3XDrN0vcV+Tw
         p8sXVg4Ic+4PJsZuJsOpHdLmiJ5RsJoXOmGTt60sx6qtXKQI4r2VU5NRT9w90aEOSHaS
         3clRGn+HvwmrCabpgXVtqto8lUvXDB7rwOcvTA3x2WSJDeCMeLzMDCmH64BaYoTUrUaC
         PMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WTHH9zlDbccoeTvmUDLrTEqObJ4nge6CNLgpKIfq2Nc=;
        b=BzpTwA7ZhJBk0kn0gNfd1bijvfajOMEEJH9CobAIRcDWGugAkTuQECdHOOX1d20sCi
         YRVW4n+pbzfYQJa+emQ1UjyF4gOkjn3oYG4PfGCrfrNt1XM9YfMM+rfiQBIqMqFXBOAR
         Kna237eyyUHcmQdQChe9gMnaHFh3d5+q8nIlk9xBGzG09DEHzPpcNPM5Z8kXaIw10RZb
         LfMv/alrDtRgkdPl1fHMp0s9DBkQxkDlZcX9PoZy6BeD6A0PBCLs6XAn/va25YWaFAJC
         kfM4dUEws835Rf3Bm2hgNCq6jpZ2R4/P/ydWaJfVe2ZyQWNqwykbncEkKSveJQv0wPJk
         3aZA==
X-Gm-Message-State: AO0yUKWr0Shx1yKGrm2ohbykoWbG8+I3a391oI2k9+FLzFZnZAXReksU
        +rADmW3NrFcqRIQqGwIUcAxHJw==
X-Google-Smtp-Source: AK7set9zgkcJ/Ydry/Spnvy0EWMQ98kUtwo44jN+5Rz6tMBQUI/yAHDbBTpVQg27blmc1k0bmHFKng==
X-Received: by 2002:aa7:c98a:0:b0:4ae:eb17:3afc with SMTP id c10-20020aa7c98a000000b004aeeb173afcmr11652406edt.7.1677143369613;
        Thu, 23 Feb 2023 01:09:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b15-20020a1709062b4f00b008db605598b9sm3847171ejg.67.2023.02.23.01.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:09:27 -0800 (PST)
Message-ID: <d5d9a1fe-2f66-66e3-d88a-76a12f2ec55e@linaro.org>
Date:   Thu, 23 Feb 2023 10:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] arch/arm: dts: introduce meson-a1 device tree
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alexey Romanov <avromanov@sberdevices.ru>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <20230222115020.55867-4-avromanov@sberdevices.ru>
 <bc514ba7-406e-bca8-4d3a-4f8997cd3241@linaro.org>
In-Reply-To: <bc514ba7-406e-bca8-4d3a-4f8997cd3241@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 10:08, Krzysztof Kozlowski wrote:
> On 22/02/2023 12:50, Alexey Romanov wrote:
>> Add basic support for the 32-bit Amlogic A1. This device tree
> 
> Use subject prefixes matching the subsystem (which you can get for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching).
> 
>> describes following compontents: CPU, GIC, IRQ, Timer, UART,
>> PIN controller. It's capable of booting up into
>> the serial console.
>>
>> This is based on arm64 version of meson-a1.dtsi.
>>
>> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
>> ---
>>  arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++
> 
> There is such file and there is such DTS/hardware support. I don't see
> any reason why entire DTSI should be duplicated. What's more, your
> commit does not explain it - does not justify duplication.

One more comment - I think you just added dead code. It's
uncompilable/untestable. Otherwise, please share how to build this DTSI
without DTS.

Best regards,
Krzysztof

