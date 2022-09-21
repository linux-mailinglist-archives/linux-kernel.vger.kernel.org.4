Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334D5BFC23
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIUKRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiIUKRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:17:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E0793234
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a3so8361784lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yzjx6E9igsuTXnzRNP3+K/9v8BB+rrIrI9XXW0kAwts=;
        b=N3jo3aH8q00MNnQwdAGWJul1Hg8tzQq8aTnbigvxcRhGj7gFPgLKkbgDiLdQRfPd58
         iF3CKoXL0ngKYxKjZFQIRaxxQzLFI+FSihQtBzKsxDkinM96LdTl6A3TOQTOOFk4nT/y
         RfsalRLJPWoZOUORCbMo4+TShCiXW7Jk6dSKwe10RrV9eJM8tr3ZDzr9DAu1R7eUuvk9
         YkWj0AvdIFK2rwI+zO1xDGMJE7v4WoHuJUTBYYksWNulOW14rcKFrSPXt/zY/92zjImr
         x7FU5Ny2wAxyZT7p7XqdkjOL27WxQt0qcgcQ7xFiiSLF6EoOOsJcOWnPrG1rlJqKzVG6
         Mbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yzjx6E9igsuTXnzRNP3+K/9v8BB+rrIrI9XXW0kAwts=;
        b=A/r9W+QbGgwVaIoin1s826CuB8dLL6ZmculqtnBAimZmeZMxXHhAUk4AQZkY+jKe9C
         GdGm3k0lpXW0uN4cEQx1lsrMp9cv3M7x8qMpyWpLSLzufB/2JcTHkwbdT6+spQ2RKwkA
         NV0rImLoy2wOJKkzAS3td77N0SGdgvbaOstOVzHzDLxkBjeNiDQXTU5dlfhH8LyhkjB4
         nO/lJ61Zqb3LeogmADHhqoHIBHZfKoBPgejUWHUQybHEsMFDHDaD2yscZDG6phEoTYHk
         xvd+7vfWjkhMwAhrQZHlUYHo3pXArlmgswbkw05UVMqh8J3/waZPNk0qF/3By7QZJF22
         GRtg==
X-Gm-Message-State: ACrzQf2TONVpJK3yOBhMCSOyKMuvinAXu8ca36pgRtx4NdS6FxRpOEfo
        nmVNP6+RoYbinUQOTB3bjOHO+A==
X-Google-Smtp-Source: AMsMyM7cHVHULWLnULj9mK8sInlgIqpR3q7VVoVLlsSAKejKuWD0ZCRo9zwghPn7eLFT6gBaZ17SKg==
X-Received: by 2002:a05:6512:110c:b0:49f:99f0:5a3a with SMTP id l12-20020a056512110c00b0049f99f05a3amr5913755lfg.384.1663755455262;
        Wed, 21 Sep 2022 03:17:35 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a05651202fa00b0048b3a92a2dbsm362277lfq.215.2022.09.21.03.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 03:17:34 -0700 (PDT)
Message-ID: <b49de03c-2d88-ad81-7bdb-a33e6841481e@linaro.org>
Date:   Wed, 21 Sep 2022 12:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Similar SoCs with different CPUs and interrupt bindings
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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
 <567e9e6c-e34c-4ded-9622-9ad8387dd24b@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <567e9e6c-e34c-4ded-9622-9ad8387dd24b@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 12:14, Robin Murphy wrote:
>> +#define SOC_PERIPHERAL_IRQ_NUMBER(na)  (na + 32)
>> +#define SOC_PERIPHERAL_IRQ(nr, na) GIC_SPI nr SOC_PERIPHERAL_IRQ_NUMBER(na)
>>   / {
>>          compatible = "renesas,r9a07g043";
>>          #address-cells = <2>;
>> @@ -128,7 +130,7 @@ ssi1: ssi@1004a000 {
>>                          compatible = "renesas,r9a07g043-ssi",
>>                                       "renesas,rz-ssi";
>>                          reg = <0 0x1004a000 0 0x400>;
>> -                       interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
>> +                       interrupts = <SOC_PERIPHERAL_IRQ(330, IRQ_TYPE_LEVEL_HIGH)>,
>>
>>
>>
>> Or any other method like that....
> 
> Which will generate the text:
> 
> 	"interrupts = <GIC_SPI 330 (IRQ_TYPE_LEVEL_HIGH + 32)>,"
> 
> (give or take some whitespace)
> 
> CPP supports constant expressions in #if and #elif directives, but 
> macros are purely literal text replacement. It might technically be 
> achievable with some insane CPP metaprogramming, but for all practical 
> purposes this is a non-starter unless dtc itself grows the ability to 
> process arithmetic expressions.

Except I put it into flags, not to IRQ number, it works, so I am not
sure why do you call it non-starter?

Best regards,
Krzysztof

