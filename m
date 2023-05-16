Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084CA704613
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjEPHPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjEPHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:15:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F315595
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:14:54 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso24249070a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684221293; x=1686813293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyQq6Ma+IalniJ60xUX0fi/X5hB5M8pYnXUsp4Z7gY=;
        b=xXrGev8c7n+hEhvi9ED2WV5N4+H6krmlBs/RISfv6BVeznDNlnPx+fUtj04r8BJpOU
         9/O0pRE0RZAUfN83i5SVmxCwn4j19/IV6DW9xV3JFIF4MI1m3DGu57QrUZ5dDvcUCDf0
         RDZuilvUB85ahh5VxqluKV6SD79zCa2lxPNCpV4dEdmEKn/NtLHukEim+Yv7xbHnHm5k
         3pqiajegnkvEsXmT1hdUPibxWrEFArF2XrLgA4avtWeuMg+vHdvVijoZo0V+a/pOKbWM
         28Elk3kQSpvCZxJwW99w8vGQ+O6ytFiwIc6u1kkOTTpKK98X24X+RzJna203wTuxqhIL
         ntOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221293; x=1686813293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwyQq6Ma+IalniJ60xUX0fi/X5hB5M8pYnXUsp4Z7gY=;
        b=EE3Z5M14KPO+OSjaovU+I9Z/FJT26EG01ncEvFDOQ5CQa6M6I88xmEABGrwslzXR0Q
         7t6Wi/Sm0trKFrgdQtsJ5p39Oy40uQi047frQKidj6GDwzSG3IPxjNeLMQvBIc0H6/6F
         2DtugNtPjbMoTzM/3qC3l38nt20vdxZ0FLgOZ4cU/H2t2bSErH1h2rBm1dFDxUiQCO0z
         BF+USGnCT8QFHHv4/xKAdc8D6ucck/Iyw2B8ZSdESQVP3hjjP9Z1ae0YbtpJCUmdvA8C
         I2zfbBT8WMIszgIeO4NkHg9oO737WSX8BoCnW3uM/EwacOsYIVtt2+u909s6VjaaG4/B
         FdnA==
X-Gm-Message-State: AC+VfDzqef+KJo0tfNYXMxAcR6y1Ub/SA6BNxKGrowoTMh5AoruehRvZ
        i7X4cMfUyB2Q55tQtiepEdYYYQ==
X-Google-Smtp-Source: ACHHUZ6YHyV1ku6mmH3P0IsC9v4GxmhMCFVjSTIigwYYsmI8YOpiBLJUxecGFyGtxb5NIAoLKTnO4A==
X-Received: by 2002:a17:907:26c6:b0:91f:b13f:a028 with SMTP id bp6-20020a17090726c600b0091fb13fa028mr28954750ejc.34.1684221293282;
        Tue, 16 May 2023 00:14:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id d1-20020a1709067a0100b0096b0e93193asm3444377ejo.90.2023.05.16.00.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 00:14:52 -0700 (PDT)
Message-ID: <463b4f44-dbcc-1c3a-5b9d-93f68a5db0bd@linaro.org>
Date:   Tue, 16 May 2023 09:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 0/8] Support AMD Pensando Elba SoC
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
References: <20230515181606.65953-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230515181606.65953-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 20:15, Brad Larson wrote:
> This series enables support for AMD Pensando Elba SoC based platforms.
> 
> The Elba SoC has the following features:
> - Sixteen ARM64 A72 cores
> - Dual DDR 4/5 memory controllers
> - 32 lanes of PCIe Gen3/4 to the Host
> - Network interfaces: Dual 200GE, Quad 100GE, 50GE, 25GE, 10GE and
>   also a single 1GE management port.
> - Storage/crypto offloads and 144 programmable P4 cores.
> - QSPI and EMMC for SoC storage
> - Two SPI interfaces for peripheral management
> - I2C bus for platform management
> 
> == V14 changes ==
> Updated email list using get_maintainer.pl

If you split the patches per subsystem (e.g. SPI), you would get more of
them merged already.

Best regards,
Krzysztof

