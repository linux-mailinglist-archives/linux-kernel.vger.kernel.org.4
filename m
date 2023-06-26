Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FC973D7B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFZGTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjFZGTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:19:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB89102
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:19:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9741caaf9d4so218952366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687760370; x=1690352370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4pmC8wZXtYNTW6/LxLrgQoLPpYTxup5SGOO3PUWoNQs=;
        b=rlW+Zt77COA20cJdXuNuF7ggNubDMstIwA5vm5NECHqd3WDi7xRuzeHwzUmy4YLa2S
         TxPFb7pd2Nl/KKPBzP68mwqCxu9wMUmN8jnGdc2sCy+1Pak9GqU0ClHlZ7DBJ6/gPd0w
         OacU+K+OM7ksc0tUIu7YpXQwNqD+SfZETIYoQ5JGBmMC8S2pFbQQ0PiMpTuTRRDbyJQj
         3wzmgokWicYOrTNQ7wzQY2RXCbL/ed20OsC5Lw8moQRlQN0M2+wXaDMBKMF81RZi09PG
         5Ja6YA+ClqLl2DWFQncTY3Z9tz7pJYsCKFr2fos2SEpvQqt5pipxXFlD3xNJbTcBdIV0
         Evjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687760370; x=1690352370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4pmC8wZXtYNTW6/LxLrgQoLPpYTxup5SGOO3PUWoNQs=;
        b=Wkn6IX70V89F9vX/w0sC4Foz8vhneJ2EZc/cCXV4t6dsQQeOD5VrlBfYfflj3Go1Wd
         OlJSg3C4awviKfq9VkpfCmlmDqr2/EIrZ+BKifpYwomNGsqErn41Vcwr2AnxLsCzcGDr
         McdiffXdE3F9Wdd5Itq7DW9DvFGRpu72vtu68W4Zc35IW7pzjvr7nT5j5S7ez8G8PEmN
         L7E/ZrgmgY0plU05c0dziOlkAdI9mbuZ/FWlkfruPUy0eP8gI/IbIqomgtA6rkbzS/0a
         P2gsyQq7t3ZxPoKboTx8U7SgJf0KPDvs+iKmLh1+1GqMHJjAH9C+dT57/Von/NPBBmgu
         Jl1A==
X-Gm-Message-State: AC+VfDxknE+iA+nNSGMzjUXGOgkFKlpjSaT/WXWk+SEPtfjicMtrSvon
        U32gm6NhfEJCVg4PnB1+gVfhYScWxSEsbobE1fs=
X-Google-Smtp-Source: ACHHUZ5jHs+wHRLwWTuvwMW7A1RL8o9mhMMeuhCDIHHhXY4HsUgGPXw2ay6r63vnJ66x2hVyymzlyg==
X-Received: by 2002:a17:907:9305:b0:96f:8666:5fc4 with SMTP id bu5-20020a170907930500b0096f86665fc4mr25221452ejc.50.1687760370474;
        Sun, 25 Jun 2023 23:19:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i4-20020a170906a28400b00991e849dbd1sm104735ejz.63.2023.06.25.23.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 23:19:29 -0700 (PDT)
Message-ID: <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
Date:   Mon, 26 Jun 2023 08:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>
Cc:     conor@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu, maz@kernel.org,
        chenhuacai@kernel.org, baolu.lu@linux.intel.com, will@kernel.org,
        kan.liang@linux.intel.com, nnac123@linux.ibm.com,
        pierre.gondois@arm.com, jgross@suse.com, chao.gao@intel.com,
        maobibo@loongson.cn, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dslin1010@gmail.com, Zong Li <zong.li@sifive.com>,
        Nick Hu <nick.hu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
 <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 05:26, Eric Lin wrote:
> Hi Krzysztof,
> 
> On Fri, Jun 16, 2023 at 6:45 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 16/06/2023 08:32, Eric Lin wrote:
>>> This add YAML DT binding documentation for SiFive Private L2
>>> cache controller
>>>
>>> Signed-off-by: Eric Lin <eric.lin@sifive.com>
>>> Reviewed-by: Zong Li <zong.li@sifive.com>
>>> Reviewed-by: Nick Hu <nick.hu@sifive.com>
>>> ---
>>>  .../bindings/riscv/sifive,pL2Cache0.yaml      | 81 +++++++++++++++++++
>>>  1 file changed, 81 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>>> new file mode 100644
>>> index 000000000000..b5d8d4a39dde
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/riscv/sifive,pL2Cache0.yaml
>>> @@ -0,0 +1,81 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +# Copyright (C) 2023 SiFive, Inc.
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/riscv/sifive,pL2Cache0.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: SiFive Private L2 Cache Controller
>>> +
>>> +maintainers:
>>> +  - Greentime Hu  <greentime.hu@sifive.com>
>>> +  - Eric Lin      <eric.lin@sifive.com>
>>> +
>>> +description:
>>> +  The SiFive Private L2 Cache Controller is per hart and communicates with both the upstream
>>> +  L1 caches and downstream L3 cache or memory, enabling a high-performance cache subsystem.
>>> +  All the properties in ePAPR/DeviceTree specification applies for this platform.
>>
>> Drop the last sentence. Why specification would not apply?
>>
> OK, I'll drop it in v2.
> 
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/cache-controller.yaml#
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - sifive,pL2Cache0
>>> +          - sifive,pL2Cache
>>> +
>>> +  required:
>>> +    - compatible
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>
>>
>> You have only one item, so no need for items... unless you just missed
>> proper fallback.
> 
> OK, I'll fix it in v2.
> 
>>
>>> +      - enum:
>>> +          - sifive,pL2Cache0
>>> +          - sifive,pL2Cache1
>>
>> What is "0" and "1" here? What do these compatibles represent? Why they
>> do not have any SoC related part?
> 
> The pL2Cache1 has minor changes in hardware, but it can use the same
> pl2 cache driver.

Then why aren't they compatible?

> May I ask, what do you mean about the SoC-related part? Thanks.

This is part of a SoC, right? We expect SoC blocks to have compatible
based on the SoC.



Best regards,
Krzysztof

