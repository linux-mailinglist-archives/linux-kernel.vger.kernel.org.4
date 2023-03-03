Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2615E6A94F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCCKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCCKMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:12:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430E85D8BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:12:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so8060693edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677838361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wIXpkJrhXTPwGpv7CslgbXTP5NsG/65llnuvwiJ94Xo=;
        b=F+wT+WYF1s8KiGpaCpHuq6j21Oy+hkULUoUT1oL/0G67XEYLxp+nuJvTYtIySgnnE7
         BLg9JlCla+mhai9qMEvjnpojEWFK+pk3E2ojrqYhMFLBiNuLBN5SwlFsMIIbCBeZDFpK
         9AChHRuU4rKc/fq6mGithDketvTbQ0K1VRBO9Msw/zgsXOPBdPkQg0IdaneD7ShSU4od
         t3nhFiZRTAz8O6B3hWHBNzxUFNUc4GR6BgTBOP3Ny5PNYj0dR8Aoo4kYP2e6gnFF5rTJ
         TENBctVZF6N4e3Rx4vcK4qbZRxGe56Ld0OHuKWisHGK04TEuwOUGTvitswVfvqg0dLPJ
         SdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677838361;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wIXpkJrhXTPwGpv7CslgbXTP5NsG/65llnuvwiJ94Xo=;
        b=5BgPJDpdCwY4Js+JRxRGfnEzhgR80LXAjEJljP6uItNQXwNybvzJrf+GQ28QSGoaTY
         hJtBoexO0EwXeZ3EWitlPzlsQNdWUkoO6KIS0NZs6sMdCa4JI6ClSVgv046mke5ZCree
         fSJyVneL5gSs1orLHA+0NtjWAcn1XtguK/3piKUJahnXvq04KhBRcRGDcpUrVl5pjkMx
         t1Kk7HTiU0TNtfSz6n7eW8v2NZWHrMWtdQJMvH6MsMcTSIT/c5KKr/pXxjdALG1R3JH9
         M/uA7p+UFD3g6OP+Cw+uMcCoIi94FIijyBHBAxePgw/fXmslSnfwQxQ/fpFS9wfxZn0M
         fOqg==
X-Gm-Message-State: AO0yUKU9WcJwP7Z6467SYgKwXt3cbHxL2gXwC+0PqppOpdBQgwKwZOiF
        biArbZQZ8hfwT+dWkGY/HM5/3g==
X-Google-Smtp-Source: AK7set9InJ7ZobX7OkawZpjXpE9ZuWZ2mzMhO1nV58gYpmXHx6LmAwUTVwzlW/aazm++QwUmDo3hrQ==
X-Received: by 2002:a17:906:3106:b0:8b1:7eb4:6bea with SMTP id 6-20020a170906310600b008b17eb46beamr1000101ejx.38.1677838360754;
        Fri, 03 Mar 2023 02:12:40 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h3-20020a170906590300b008ddf3476c75sm789818ejq.92.2023.03.03.02.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:12:40 -0800 (PST)
Message-ID: <690dec31-6de6-efe4-c1b1-f434ff1a771f@linaro.org>
Date:   Fri, 3 Mar 2023 11:12:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
 Samsung PCIe
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        jingoohan1@gmail.com, Sergey.Semin@baikalelectronics.ru,
        lukas.bulwahn@gmail.com, hongxing.zhu@nxp.com, tglx@linutronix.de,
        m.szyprowski@samsung.com, jh80.chung@samsung.co,
        pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214121333.1837-1-shradha.t@samsung.com>
 <CGME20230214121404epcas5p3bfa6af0151b7f319d418f7c0dbed7c5a@epcas5p3.samsung.com>
 <20230214121333.1837-2-shradha.t@samsung.com>
 <b40cafa1-396f-e6cd-3240-bc879d5f2c8b@linaro.org>
 <139501d94d06$2e159850$8a40c8f0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <139501d94d06$2e159850$8a40c8f0$@samsung.com>
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

On 02/03/2023 13:54, Shradha Todi wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: 16 February 2023 16:24
>> To: Shradha Todi <shradha.t@samsung.com>; lpieralisi@kernel.org;
>> kw@linux.com; robh@kernel.org; bhelgaas@google.com;
>> krzysztof.kozlowski+dt@linaro.org; alim.akhtar@samsung.com;
>> jingoohan1@gmail.com; Sergey.Semin@baikalelectronics.ru;
>> lukas.bulwahn@gmail.com; hongxing.zhu@nxp.com; tglx@linutronix.de;
>> m.szyprowski@samsung.com; jh80.chung@samsung.co;
>> pankaj.dubey@samsung.com
>> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH 01/16] dt-bindings: PCI: Rename Exynos PCIe binding to
>> Samsung PCIe
>>
>> On 14/02/2023 13:13, Shradha Todi wrote:
>>> The current DT bindings is being used for Exynos5433 SoC only.
>>> In order to extend this binding for all SoCs manufactured by Samsung
>>> using DWC PCIe controller, renaming this file to a more generic name.
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>>
>>> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
>>> ---
>>>  .../pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml}     | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)  rename
>>> Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml =>
>>> samsung,pcie.yaml} (93%)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>> b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>>> similarity index 93%
>>> rename from
>>> Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>> rename to Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>>> index f20ed7e709f7..6cd36d9ccba0 100644
>>> --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/samsung,pcie.yaml
>>
>> We keep the name rather tied to compatible, not generic. There are no other
>> compatibles here, so I don't think we should rename it.
>>
> 
> Our intention to rename was to have a common name for Samsung manufactured SoCs having PCIe controller.
> Though this change may not be a blocker for us but we feel it will be good to have a common name as this file will
> not have bindings only for Exynos series of SoC (Samsung Sys. LSI designed) but also custom ASICs such as FSD / ARTPEC SoC (Samsung Foundry designed). 
> We hope we are not breaking any ABI as such in this patch.

There is no FSD/Artpec added here, so renaming just for "rename" is a
no. If you add new hardware here, this could have sense, depending on
the hardware. But since we pretty often expect the first compatible to
be the name of the file, why renaming at all?

Best regards,
Krzysztof

