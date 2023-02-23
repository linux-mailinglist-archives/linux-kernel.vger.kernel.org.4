Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C336A047C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBWJIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjBWJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:08:13 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4635A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:08:06 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id ck15so40921837edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmC8rU/r/vCYcTCassjtbwxQQmvscPWPC8NwoK8nv6Y=;
        b=yXHwG+9zDhuVZ2TCZZ4Z30RxvwOLheweftDdXO1MbTiq4GvnDaonuOL5PDrPpEMpdk
         mRiEcZ/44ZPPwvrGQ2FLuwMO4+0KXmQ5KzWof+9uprrkevZkwltts+56/Or9kfsf81iy
         x/TNi+MZI/eSSvB9TSvpMfRtTEe7K9dCoEC8eeHVMsMWmddeiKOV1po+0vR4/WOwghUm
         GXvTvMYFT8O3Qv2uOIryrT40DyUDESsePbbCr8K1ALlP4amRrO0gsEFPWT966ebb5PEa
         mgt4NjoCIXt+2EI4Kj1PB81uk0i5v0b9WsTfsLuJTzcloptM13D1hKzDRGtLC3723ey4
         vfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nmC8rU/r/vCYcTCassjtbwxQQmvscPWPC8NwoK8nv6Y=;
        b=cHNt7/kLX4MjbnrBCkaJa8trg1GdyoJZ4dTw975rdD2KfQqd1QxrsLTt7K/F9fAJ6k
         FyapHCeRuBg2rmRD/TRC1cdbZObRDrZPnXl9bFXK3cs3HCzuZtYX7aZHLrwVMewbaFbG
         lHLT93WJugiURnXO9qifWVb7FZjZf3D80QXmwnjgw7eAXPu3G0xZKQpaP3BTYpqPWBmr
         0qxv90St0aPxwL4+Pyr4h6LAKweAU/+mKsCrR3ENJJ40OMXjW4Zo5WA9jIKp7d6aoIQp
         PJZFm0QLAD1pH+yLFnrKRTejgt3EnrWfKvFWm7I+R76MMny/9FALLcgtHCe8yI4+V85C
         ebkw==
X-Gm-Message-State: AO0yUKXzSvJ+S/NcKomvG/QomPcvm7/dwCRqRL4KbXHiNKsXetnPZZig
        H79eUShFI3YaeVPXY9AP1NZDYQ==
X-Google-Smtp-Source: AK7set8FqssPw31ewckoqg56O8trOVzvzax0KiJfiMOPwugY0umCwzbsSexEYjm9Rymh5WfeBMy3Rg==
X-Received: by 2002:aa7:d351:0:b0:4ac:bb85:c895 with SMTP id m17-20020aa7d351000000b004acbb85c895mr9724924edr.1.1677143285066;
        Thu, 23 Feb 2023 01:08:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m6-20020a509986000000b004aef147add6sm4252398edb.47.2023.02.23.01.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:08:02 -0800 (PST)
Message-ID: <bc514ba7-406e-bca8-4d3a-4f8997cd3241@linaro.org>
Date:   Thu, 23 Feb 2023 10:08:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] arch/arm: dts: introduce meson-a1 device tree
Content-Language: en-US
To:     Alexey Romanov <avromanov@sberdevices.ru>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
 <20230222115020.55867-4-avromanov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222115020.55867-4-avromanov@sberdevices.ru>
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

On 22/02/2023 12:50, Alexey Romanov wrote:
> Add basic support for the 32-bit Amlogic A1. This device tree

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

> describes following compontents: CPU, GIC, IRQ, Timer, UART,
> PIN controller. It's capable of booting up into
> the serial console.
> 
> This is based on arm64 version of meson-a1.dtsi.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>  arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++

There is such file and there is such DTS/hardware support. I don't see
any reason why entire DTSI should be duplicated. What's more, your
commit does not explain it - does not justify duplication.

Best regards,
Krzysztof

