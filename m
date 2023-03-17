Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BB26BEB77
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCQOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjCQOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:35:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289D244B8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:34:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x13so21236973edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679063686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4FKk1Fwhr1fzG6SpZjspB0mX89kWkmddwIe7IQAMes=;
        b=UENArZTj3eYJid1mlv2le+ufGlum1Zp0eLeeq/UMk2jR1tIsCq8g4fnTOWOjeXS05X
         9wmwkepGz2SvRU8GWyOwtI5NvaWBNAOo5mZ5ZibAWbNg1lVNyW8Eb2lkBpbbc5bvOMCn
         S3hUKHL4JUvzWowv2pFzSFUz/38OYNVQyUTsSWfNO1uRQ/Fib22/BpfqF27k9zhFqol1
         pP2RWAq50SxYGZliECPrKyQccTxB3qRGLAnpzqizhY8lhvfMb2UCdEA7/lM3qwonljmz
         atsj1ZlbsCwcif2lrkfKAedNAr3o4vZKAGGbRDVSpB1amb1pNrz3LhvcUJxeQEs1AHw1
         FZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679063686;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4FKk1Fwhr1fzG6SpZjspB0mX89kWkmddwIe7IQAMes=;
        b=LO93wVN/Yfx0WrDLUHT/i4RFuO5qqvObELRREEdyYOIyIFkd9gWj9rp2mcpMsjGEAY
         F5p+j1vUaUPVGkbo4Zt8Tguaezfk8vqBkJBQkSv0d6E+rrbrrvG+EUHnynUu2f+YynfB
         ZBUDxwRRwHq6Y+oykV3bLTvlMXByyktN5vyi34ZOtKPDVDh1Z5Eigu7T72pZbFU9acqP
         gAhdIbdAO9vsjyvdg0JZyT3JAGVyEIerEOguhdmjIISlYyktA+TNEi7MQk1EXHBSenfV
         sc77AGiAcQqXp1/txh5bpHxaoxBd//QQQUIJptISTqLYodZveYWYw2ICH0552yOseEjq
         +JlA==
X-Gm-Message-State: AO0yUKXbDqnUs++UUT4Fj4mOGaVn6seZhlS0/mrOOo28Q6LMcK+HImOi
        IQ+nQodI/rI9+3Wd/tDpooTCdQ==
X-Google-Smtp-Source: AK7set/5VawiO0rvgEB3jmpUoHQievfUgoXM5XEaTxW/KdVKozL8AZkY8bPCPx6Dl2eH5jQEGkKctQ==
X-Received: by 2002:a17:906:9413:b0:930:9197:24d1 with SMTP id q19-20020a170906941300b00930919724d1mr3059411ejx.6.1679063686618;
        Fri, 17 Mar 2023 07:34:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906c00800b008e1509dde19sm1029098ejz.205.2023.03.17.07.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 07:34:46 -0700 (PDT)
Message-ID: <3a6a756c-3393-abf7-3ddf-7dd44c8ea160@linaro.org>
Date:   Fri, 17 Mar 2023 15:34:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Probing devices by their less-specific "compatible" bindings
 (here: brcmnand)
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
References: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 11:02, Rafał Miłecki wrote:
> Hi, I just spent few hours debugging hidden hw lockup and I need to
> consult driver core code behaviour.
> 
> I have a BCM4908 SoC based board with a NAND controller on it.
> 
> 
> ### Hardware binding
> 
> Hardware details:
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> 
> Relevant part:
> nand-controller@1800 {
> 	compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";

(...)

> ### Problem
> 
> As first Linux probes my hardware using the "brcm,nand-bcm63138"
> compatibility string driver bcm63138_nand.c. That's good.
> 
> It that fails however (.probe() returns an error) then Linux core starts
> probing using drivers for less specific bindings.
> 
> In my case probing with the "brcm,brcmnand" string driver brcmstb_nand.c
> results in ignoring SoC specific bits and causes a hardware lockup. Hw
> isn't initialized properly and writel_relaxed(0x00000009, base + 0x04)
> just make it hang.
> 
> That obviously isn't an acceptable behavior for me. So I'm wondering
> what's going on wrong here.
> 
> Should Linux avoid probing with less-specific compatible strings?

Why? If less-specific compatible is there, it means device is compatible
with it and it should work.

> Or should I not claim hw to be "brcm,brcmnand" compatible if it REQUIRES
> SoC-specific handling?

As you pointed this compatible does not work for your device, so they
are not compatible.


Best regards,
Krzysztof

