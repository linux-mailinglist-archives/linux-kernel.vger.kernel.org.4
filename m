Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317D85FC888
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJLPik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 11:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiJLPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:38:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4432EDB746
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:38:35 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y10so3561248qvo.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+NMoPOZq1erzKnfhYuGIlvnqtWcZGNnxl2pMMZiBdo=;
        b=Lz+j6HeJDCFOKr1Gyj43KK/P7fM0J4lk/iKn6dVTn+y8wEIYuHfAh5SyfCA8cJWXhY
         obM6zp6Ht3x/RTCY18QHtftkGoImtad9ussJ+nBB6PIRujcV9ZF0ToMVFfYrz+uHJyE7
         O//8XUzkLvspmUOeE2JoBqBQBcO2ByxXbSDnawaDVa9lyljOqF8Nz/iHhC9J119RmLXI
         c+5t48cJNJRzvuxh441WXhpgdKnpqzzUmU4EioMXHDK5qgeeO8/JrWImvlCVnDVAFvk2
         vlAcmZCnHC+XdxOJ6l+Va0KmA13NT4iQFf8tNrTrDNbrGO2uouR5BVVtGumAzxTYgWb8
         ZBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+NMoPOZq1erzKnfhYuGIlvnqtWcZGNnxl2pMMZiBdo=;
        b=p/AULbxPt4/CDWg/ULCu5xV73RPLzOXuJlblZdgejnt1/ojWPWEM5/CSW6nrT0YWra
         meqlEGGMqS0eg+PZoGy7NemC2VoRk2u0txFlrtQJcdSXobfAuPNMftIq0fH1MN6UlrZ1
         dX02RYqazZVvSO28hwmQHPDFV8nVHvxyFBiO51P5pQi3TXpzQVdfGnm2d27R3xr2VeFe
         CBxlM00B8PO7z+S22dk66VgIGbFq/JzxvIeaIdWDYVCRJKkl7c60a4mFM26stf2tetx9
         cRf3aE3lDxHAz74HRAThTRFAFQ05cCYtFd9XwPISU/qu9zWYhL2GBFRMhjlYja9PIbk3
         WulQ==
X-Gm-Message-State: ACrzQf2cys04W+wZPtovn4f+LcrTHsOmTZ68Zc5N6Qpvp20ozmJwXmz/
        FVD6o2cYdnn7LevrsznkUXYRoQ==
X-Google-Smtp-Source: AMsMyM6FgPeEeq6o1hXq7OPXCciAymFLlQ+QAF+otIX2xa/uUftSe2ABcXLoRVZM1hDWaM/wexNsPQ==
X-Received: by 2002:a05:6214:1d01:b0:4b0:b782:15a6 with SMTP id e1-20020a0562141d0100b004b0b78215a6mr24569885qvd.43.1665589114407;
        Wed, 12 Oct 2022 08:38:34 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b006cfc1d827cbsm15705502qki.9.2022.10.12.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 08:38:33 -0700 (PDT)
Message-ID: <57e454f4-6767-bf42-8337-ce1f486137ca@linaro.org>
Date:   Wed, 12 Oct 2022 11:38:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH 0/2] RZ/G2UL separate out SoC specific parts
Content-Language: en-US
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220929172356.301342-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8vD1+kbby8rbZqYv2Ux1GaT=7n7V9qHJS3Djv-fKdWrAQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+V-a8vD1+kbby8rbZqYv2Ux1GaT=7n7V9qHJS3Djv-fKdWrAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 05:41, Lad, Prabhakar wrote:
> Hi Rob, Krzysztof,
> 
> On Thu, Sep 29, 2022 at 6:24 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>
>> Hi All,
>>
>> This patch series aims to split up the RZ/G2UL SoC DTSI into common parts
>> so that this can be shared with the RZ/Five SoC.
>>
>> Implementation is based on the discussion [0] where I have used option#2.
>>
>> The Renesas RZ/G2UL (ARM64) and RZ/Five (RISC-V) have almost the same
>> identical blocks to avoid duplication a base SoC dtsi (r9a07g043.dtsi) is
>> created which will be used by the RZ/G2UL (r9a07g043u.dtsi) and RZ/Five
>> (r9a07g043F.dtsi)
>>
>> Sending this as an RFC to get some feedback.
>>
>> r9a07g043f.dtsi will look something like below:
>>
>> #include <dt-bindings/interrupt-controller/irq.h>
>>
>> #define SOC_PERIPHERAL_IRQ_NUMBER(nr)   (nr + 32)
>> #define SOC_PERIPHERAL_IRQ(nr, na)      SOC_PERIPHERAL_IRQ_NUMBER(nr) na
>>
>> #include <arm64/renesas/r9a07g043.dtsi>
>>
>> / {
>>    ...
>>    ...
>> };
>>
>> Although patch#2 can be merged into patch#1 just wanted to keep them separated
>> for easier review.
>>
>> [0] https://lore.kernel.org/linux-arm-kernel/Yyt8s5+pyoysVNeC@spud/T/
>>
>> Cheers,
>> Prabhakar
>>
>> Lad Prabhakar (2):
>>   arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
>>     to specify interrupt property
> 
> Can either of you please review patch #1.
> 

Why? This is a DTS patch, isn't it? You should CC rather platform
maintainers, architecture maintainers and SoC folks (the latter you
missed for sure). You missed them, so please resend.

Best regards,
Krzysztof

