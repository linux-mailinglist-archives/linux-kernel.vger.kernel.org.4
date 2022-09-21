Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2AB5BFC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiIUKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiIUKKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:10:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2B5A835
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:10:12 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id w8so8307265lft.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yxhsCHqbjeaUvDSrWwmS/tUjVYbJlbwwcVnNivmxf/A=;
        b=Mx7+v7mLDXYL9fZJN81ZLtHPaaRSjT+E201/j9MMBacZSRokSKMoitW9Kj6QZeFCfc
         5KgqLjmvBVDHm1PQr2blWlEPWQY8I2wreEH0ThGty+Nm1LpGMQbSVt0jjd0+8V+fxWbc
         aZHdCVM+JrKPXIITHE2oz24+bHztTA+QVFxyZcAIgUNZYqopCE77QX1aPYlqWv3hiYpv
         s6hx4P8rHUxBqsam0PFddMEK0cEizIyZuv2ztE/pD8vHs7UDYAWJ714lt8GIgLdXoSpy
         lhxbCCMCjWQAe+yapph8KF6kewtaIxLyW4qJ63h3LZp1MUOmFT3n1RquYE03323Qkbsc
         THQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yxhsCHqbjeaUvDSrWwmS/tUjVYbJlbwwcVnNivmxf/A=;
        b=I6qlipOntYeEOg9oZXrH/NmUkbB1M2XmEM847KXzQT+hAVK0GqiKifgbbCeIi9wq+T
         jDy3QDfOeAVnSueWywsa6frDARLoHZ1/FRd+76maAyOrVAux7Qg7kKtZJ1dAvbKmdTae
         HL6fG0hMxRr/XS+oSlvPGFmt54+dNLq/TITKZHkOJxbXrkdiGod7xgAOPSzrgcHDtG9c
         ldTVWRYwHwQKIIJRrkQ0jU657I8I60bhtQ6okpnCeMu/unnzV4SW1BXBq6yPnUIKte3h
         xVC1TsBpqt5e11Ywejf7v1F5t6UeNWOY+CXx4Fwm11VNPPajo21qGwG4h2PaSv9nmOd0
         Jgbg==
X-Gm-Message-State: ACrzQf2TqggMnUQONKdIXp9MzwMtdEQKxabKV2s2Z6eRJhIHIZzv4Bc8
        oAaZ9PsNeYauxFWPy+W0I9u5AA==
X-Google-Smtp-Source: AMsMyM7miLYxhwhmdAm6xqnhxaOOx6BmPBe4KQD2NDEVZSgjClHYYwttY/drvejnXcRy+vqeDU5rVg==
X-Received: by 2002:a05:6512:68a:b0:49f:4c31:e9f with SMTP id t10-20020a056512068a00b0049f4c310e9fmr10129696lfe.136.1663755010574;
        Wed, 21 Sep 2022 03:10:10 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o12-20020a056512052c00b00497a41b3a42sm370469lfc.88.2022.09.21.03.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:10:09 -0700 (PDT)
Message-ID: <131d9058-a9de-7012-49e0-95e8477edf85@linaro.org>
Date:   Wed, 21 Sep 2022 12:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
References: <CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com>
 <b0f2e13a-ff5d-5bfc-6dda-ca39bb57803e@linaro.org>
 <CA+V-a8t3ukpa1PNz=5fP+BTjWkFJmwDo_EJJYjO9YctF2=K1Vg@mail.gmail.com>
 <df9ff0bd-ad0e-4b5b-859d-dd913628edc8@linaro.org>
 <CAMuHMdXaWz4zP-Zrc4drxwVmbMjmGZHABVbUtO91fZXKawathw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMuHMdXaWz4zP-Zrc4drxwVmbMjmGZHABVbUtO91fZXKawathw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 12:08, Geert Uytterhoeven wrote:
>> diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> index ff6aab388eb7..0ecca775fa3f 100644
>> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
>> @@ -8,6 +8,8 @@
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/clock/r9a07g043-cpg.h>
>>
>> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
>> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
> 
> #define SOC_PERIPHERAL_IRQ(nr, flags) GIC_SPI
> SOC_PERIPHERAL_IRQ_NUMBER(nr) flags

Right. Let's consider my code just proof-of-concept :)

Best regards,
Krzysztof

