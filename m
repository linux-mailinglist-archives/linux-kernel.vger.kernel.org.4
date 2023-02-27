Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFACF6A3C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjB0IPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjB0IPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:15:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00A81C7C4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:15:07 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso6025397wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ykQL+wemGByro2MkMCepozrEmOoZvr3Fpiqikx6KNvU=;
        b=XTuhesiLkfEkA+SGb398z9A6gEpdRaVwniIjjcWh/5zzOW2M8KIcI39ELkW0U7D98s
         KW8TofHUTUc76kbKnH7EJK0+qnMQmAF39k2TNmxXnwHYKCowEMvUjcuP8WNuf7mvpQyp
         /FOvD3kEsBNG7uj95+QCLm0ma5Lb5b/4V/O9/QPZWOsyhHOTF32DsCTCTMj7OOysy1l/
         t47MJWtPfOpNCZD5B7eA4kkMF76HlQHuKd30bue+N3stNmEPKkMlxGkg1DCboa/Jb7UE
         n0k1bEjiHz4+QhJEaWArE/pEZzI+PghfZf/wxlkUWimZgHSOM0cTpydArzEA7FyF7sK1
         puWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ykQL+wemGByro2MkMCepozrEmOoZvr3Fpiqikx6KNvU=;
        b=IffkCYYOS1rlM57Lr1QK8By8J1FLIIR/8APqwhSYAbwSNU45IjJTdvNl4fIbvb+CuR
         G7jkxEJbHS/CAsvV9qQEKXahFydrHi6gm9xsHK/RMhW3Micmv9UPhJ3+vr5/L+xHZn9o
         KT9ntUtg3g3aNCtjpVY3W/tTfhetmmhszz42shqb+a8LY4dA1xVc2kT4e46cxto/dlMH
         Go8KaahgI3vFpwaGJqEH87V776rmEQBDt7P+xOnX/ileUqynvMXqLFFruOSLLn4YXI/O
         qMNk3xvvitGu0h6IhAwvHayz9wzjPSY06d2GQo8GL+RVHnpv8tnEzGtuoFAbBiLekECi
         +oiA==
X-Gm-Message-State: AO0yUKURJvFl3815uBivXGNp+0SGPIit9Zq2a7lfA9eZ8PX5KLcuxgbX
        O320FAa/oZ9+/W5NbZKCcnDBSg==
X-Google-Smtp-Source: AK7set8ZGX2NnlEpE1CBg+Kmv2R0/WA3VAJQafJbNbYhmP4TslhboAqFxsukDkCv3SNGGwsiGWcIAw==
X-Received: by 2002:a05:600c:4d21:b0:3ea:e4bb:340c with SMTP id u33-20020a05600c4d2100b003eae4bb340cmr11811958wmp.18.1677485706224;
        Mon, 27 Feb 2023 00:15:06 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d4b10000000b002c56013c07fsm6310120wrq.109.2023.02.27.00.15.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:15:05 -0800 (PST)
Message-ID: <8e5f9bfa-d612-cd43-d722-d04c40938c62@linaro.org>
Date:   Mon, 27 Feb 2023 09:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/3] Meson A1 32-bit support
To:     Alexey Romanov <avromanov@sberdevices.ru>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230222115020.55867-1-avromanov@sberdevices.ru>
Content-Language: en-US
Organization: Linaro Developer Services
In-Reply-To: <20230222115020.55867-1-avromanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 12:50, Alexey Romanov wrote:
> Hello!
> 
> This patchset adds support for 32-bit Meson A1 board.

Hi Alexev,

I'm aware Amlogic also runs their kernel as 32bit to gain a few kbytes
of memory, but those processors are ARMv8 and the arm64 arch code
has been designed for those CPUs.

So far I didn't find a single good reason to add 32bit support for
ARMv8 Amlogic based SoCs, if you have a solid reason please share.

And as Krzysztof stated, the support is incomplete and cannot work
without a dts file.

Neil

> We describe device tree with following components:
> CPU, GIC, IRQ, Timer, UART, PIN controller.
> It's capable of booting up into the serial console.
> 
> We have tested this DTS and used drivers at our
> 32-bit Meson A1 board and it works correctly.
> 
> Alexey Romanov (3):
>    meson: pinctrl: use CONFIG_PINCTRL_A1 with CONFIG_ARM
>    firmware: meson: use CONFIG_MESON_SM with CONFIG_ARM
>    arch/arm: dts: introduce meson-a1 device tree
> 
>   arch/arm/boot/dts/meson-a1.dtsi | 151 ++++++++++++++++++++++++++++++++
>   drivers/firmware/meson/Kconfig  |   2 +-
>   drivers/pinctrl/meson/Kconfig   |   2 +-
>   3 files changed, 153 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/boot/dts/meson-a1.dtsi
> 

