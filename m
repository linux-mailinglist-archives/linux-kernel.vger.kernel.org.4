Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F426294FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiKOJzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiKOJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:55:41 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C31323BC7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id c1so23600378lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHVGZGFvlfOuto+Xt8nKu6o58i2L4GJKNS5eugoVkdE=;
        b=zujkZBsa5qfQFD0h/od/X1kboXjmeDHm2yfi4szFjwzyYt7mnF4wBKv5WQn9NLO9+B
         lYpysXg9wd7vHoEJ9HvIUhdmb0bgAobw+IBZeQ59YOjDKb3OaQJ6zQrne2IfNtOJD35S
         MKe/vfadEg5hdu2TwEf/qNWON4ABNcvs5m4Uv5Hlo3p1cHN9WLARq+1G/RNgJ7PkZ9bJ
         8yk2+SIMzZ7rMQJXzKE8fhQdWznUW5zFy6rIXxZLF4yfl/91aDu+tVKn7ht2kQyDsEM0
         mIVChOdiOzNrA/GwOryL3DtSCiuqy8QeYvVDrziGqUI/jtWLXwZWOD0UCscg2XCOmnfr
         QsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHVGZGFvlfOuto+Xt8nKu6o58i2L4GJKNS5eugoVkdE=;
        b=pj+fwARj+vkVIsdl8pONoG2+3EKxCll2pv3uyR21f9x/q/NZ7QabEx+TlQbbEh+VsX
         qwB+iNcJVsrRRwY3uOmsDAZSAXauYDJwwGTv5YgkLN9Cu13Ondj1IZ9Hb7rc5UTBRaOp
         Ot9EOKmKtRff1IWSRX5YFxKvTLifbEgHodJ6TSNhbA14ZvqTOmCrE4jA2LgA/MPZR7nC
         qIeWPqFSO2/GC9KXc1ZYV9en8vI4KiV9KelOpIO1kjqb5Zjus7xIX8Q2SAy3A2c42vPf
         DkpJL9KkTizHkVavvzd5cYtcxwQMaIiC9b6DC1qnC6b6qUBWivqIvTb8U+JkW+7BR/Gq
         Sofg==
X-Gm-Message-State: ANoB5pnqU1ThguMWi3Ekw6YUd9BNr+wwiS3kiAM/Ti7J8XXHQ/1sNrMX
        7sMzcTq+DkBucQXUACA4rLk4Tg==
X-Google-Smtp-Source: AA0mqf5B6D63SwaArDeQof7jXTKety9c9QdXaQDZlQbDtJv27tmP/fm6Z/YAplBjW8krHbClAmPb3w==
X-Received: by 2002:a05:6512:3ac:b0:498:f36a:76fa with SMTP id v12-20020a05651203ac00b00498f36a76famr5519055lfp.532.1668506135411;
        Tue, 15 Nov 2022 01:55:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h28-20020a2eb0fc000000b0027741daec09sm2343827ljl.107.2022.11.15.01.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:55:35 -0800 (PST)
Message-ID: <5b7f035c-807b-a6d4-30ec-e5467ff4ea47@linaro.org>
Date:   Tue, 15 Nov 2022 10:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20221108092840.14945-1-JJLIU0@nuvoton.com>
 <20221108092840.14945-4-JJLIU0@nuvoton.com>
 <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
 <CAKUZ0+GCf_Zv=VhnY5Z=yYAfR1=_ha98BVVxRGVy8ui6so_Yrg@mail.gmail.com>
 <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com>
 <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 09:38, Jim Liu wrote:
> Hi Linus
> 
> Thanks for your reply.
> 
> let me explain the gpio pin as below:
> 
> Our sgpio module has 64 pins output and 64 pins input.
> Soc have 8 reg to control 64 output pins
> and  8 reg to control 64 input pins.
> so the pin is only for gpi or gpo.
> 
> The common property ngpio can be out or in.
> so i need to create d_out and d_in to control it.
> customers can set the number of output or input pins to use.

Aren't customers interested in specific pins, not the number? IOW, why
do you assume pins should be set to output in ascending order (e.g. 1, 2
and 3) and not in a flexible way?

> the driver will open the ports to use.
> ex: if  i set d_out=9   and d_in=20

Why 20 means three input ports? 9 opening two outputs could have sense
if it was a mask but you did not say it is a mask.



Best regards,
Krzysztof

