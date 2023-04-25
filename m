Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3256EDDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 10:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjDYIT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 04:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjDYITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 04:19:25 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157173C3A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:19:21 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-94a34a14a54so1009786666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 01:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682410759; x=1685002759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=znRV0nWYnqPOSY77B900qlMay8TPNkGb3s+FapEpgN0=;
        b=LrmBxu2EGogQSTBkcCYzasNpZW/pKKd+LqTsGa/ifcmlV7SrWEsRCLujLGcNA137kR
         lgwXt02NGHCJSzACgRty3LrKWmIf7PuMckGMm8d0LuQHfa3kRMdEE7xcneEgoDnt30pU
         ICbLRprS81Q5+UWB1qUS+Xz8ejauuXRB00g3emna+Fc5Uq0YzQKXiO1HCgOSVUYsofLg
         HAyRSdTObW2jp7yFUero1cT0zWgI5o8AgwOUvzA7wvYF/P5Igdaa8PA9CIAotIyyWhPE
         HQyi2HqeCP3YbfrWZ9wHHbqpVkFD2C3LQt4yqEcG14S1CGYcQHSyqFmpM6tPjofJhhJ9
         MN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682410759; x=1685002759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=znRV0nWYnqPOSY77B900qlMay8TPNkGb3s+FapEpgN0=;
        b=HHEl7BWKfS1mHdbKRDrSj8l8uBdlBqErbaxbLa2nSiKKKurxyQ79jSAeSopTDHbjjQ
         xa/ZEFyhmRIbUyvLZGyyWZJrrE6h4VL35KFRxbd12PXNFCf2cLIJ3q78jCTVfggI+Jy3
         EMe8Rqu6qOAhRPILcc9F33ZZ35AU8QC6772Sb1wNoyWe58zEvZJcxZN1qy+RfXGbMV47
         TpD/mkXLs2SUZfQvoSGEcrPYPFe/NsUl3O8V1jEGYzQZXFxXoDLm0HJiHNvfc1sVMvGa
         kKovOmSlAupv96iWs1D+qt3fS1UIP3szjjX/bkiplUDGpdaEtiTYXSHKkmM7xqxrg1Gp
         KhKg==
X-Gm-Message-State: AAQBX9d6Sl/rSgzzVNDUAUGBY7lq+UOdd3Y/yCbeMHuLRixokFLbZ1kJ
        CpeDc1SgkeUi/AKZ6//022PbUw==
X-Google-Smtp-Source: AKy350baIrrRrmfaPcUDOSj2l2OdIXPrZ1RbEUf1vTKFBK8BjYDz6c/Q0be38k6esdo6bxwhgxnskg==
X-Received: by 2002:a17:907:76ea:b0:94f:7486:85a7 with SMTP id kg10-20020a17090776ea00b0094f748685a7mr12083094ejc.31.1682410759554;
        Tue, 25 Apr 2023 01:19:19 -0700 (PDT)
Received: from [192.168.9.102] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b0094e877ec197sm6587131ejb.148.2023.04.25.01.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 01:19:18 -0700 (PDT)
Message-ID: <68cb565d-bf39-10b0-9e3e-35ba7f54b90b@linaro.org>
Date:   Tue, 25 Apr 2023 10:19:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Content-Language: en-US
To:     Changhuang Liang <changhuang.liang@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-2-changhuang.liang@starfivetech.com>
 <20230419-labored-camper-644d51a7ca96@spud>
 <1a5b15fa-4f20-51c2-2ba1-a04a2911a694@starfivetech.com>
 <20230424-baffle-punch-ec73098f2b6a@spud>
 <d685a1d4-c07d-7dfa-f1fb-b35ceb2aa0eb@starfivetech.com>
 <20230425-unquote-eligible-09f743d81981@wendy>
 <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a7cdfabf-2312-eaf3-f462-5bda7f0a120d@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 09:57, Changhuang Liang wrote:
>>>>>>>  
>>>>>>>  description: |
>>>>>>>    StarFive JH7110 SoC includes support for multiple power domains which can be
>>>>>>> @@ -17,6 +18,7 @@ properties:
>>>>>>>    compatible:
>>>>>>>      enum:
>>>>>>>        - starfive,jh7110-pmu
>>>>>>> +      - starfive,jh7110-aon-pmu
>>>>
>>>> I was speaking to Rob about this over the weekend, he asked:
>>>> 'Why isn't "starfive,jh7110-aon-syscon" just the power-domain provider
>>>> itself?'
>>>
>>> Maybe not, this syscon only offset "0x00" configure power switch.
>>> other offset configure other functions, maybe not power, so this
>>> "starfive,jh7110-aon-syscon" not the power-domain itself.
>>>
>>>> Do we actually need to add a new binding for this at all?
>>>>
>>>> Cheers,
>>>> Conor.
>>>>
>>>
>>> Maybe this patch do that.
>>> https://lore.kernel.org/all/20230414024157.53203-6-xingyu.wu@starfivetech.com/
>>
>> This makes it a child-node right? I think Rob already said no to that in
>> and earlier revision of this series. What he meant the other day was
>> making the syscon itself a power domain controller, since the child node
>> has no meaningful properties (reg, interrupts etc).
>>
>> Cheers,
>> Conor.
> 
> Yes, "starfive,jh7110-aon-pmu" is a child-node of "starfive,jh7110-aon-syscon".
> In my opinion, "0x17010000" is "aon-syscon" on JH7110 SoC, and this "aon-pmu" is just 
> a part of "aon-syscon" function, so I think it is inappropriate to make "aon-syscon"
> to a power domain controller. I think using the child-node description is closer to
> JH7110 SoC. 

Unfortunately, I do not see the correlation between these, any
connection. Why being a child of syscon block would mean that this
should no be power domain controller? Really, why? These are two
unrelated things.

Best regards,
Krzysztof

