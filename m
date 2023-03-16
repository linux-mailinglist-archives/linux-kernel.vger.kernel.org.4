Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C26BC4AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjCPD1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCPD0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:26:33 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822929BA52;
        Wed, 15 Mar 2023 20:24:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id u5so354433plq.7;
        Wed, 15 Mar 2023 20:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678937098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNHlIO69ec3eioGUhSag8tmnyuktf3gIfuSWwZXOVbs=;
        b=bCsX6pixTgzGXBT0Ep8l2BFiyOB4DzHtkZNsVJcf+RF3EpV6bNPK4qZliJy+0/V9Kg
         QCrVpLEEzwHL4Qi2/kCk6aOGPOwa7oHQYho/QVFWT2YhIkbhjPLLoa2CJg/3eChM4qRc
         e4eBlKVns3npPcNNTNSRyoqbmUAU2ADQGShOO27Z8oDfVowz5QNC7p7rOthGwXysN7JH
         rK47fX763E3ALdVXV8oLfp273Aum3Po1FnPtC1p7YM0ZIh6DvyZ2RfDSjMU+038mBYZD
         rvKdThjHz1pL5acI+L+JBWgagiUBRG0/b5TVoh7KhKypFbeIG4nkfzTcqz0J7lbXAMHa
         dMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678937098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNHlIO69ec3eioGUhSag8tmnyuktf3gIfuSWwZXOVbs=;
        b=sQn5ndZrEpVwl3sxYcyxwSL08RETi/CtNMtuWsVNlLjTwjFcjgD/lonpnkv1Z6kfNV
         FvAlpBpJkqDIZrY03Lwn0lDBh0nzoiNjILfTa09N9X6Cn928zJhirs0qG1OR8j2Ezeo8
         QfGhWIBNu0zroL0Lc1G4g/jb6LUdXagIzrDRrijDyK3AMortvTDp482oyJEtves1ttgV
         PEy6QXjJJJDwfzepOuIS5DEK8n4eLHpGx6LVsSh6FRyGwmn18S8mzdhiznVBqt1JNI8d
         qT/T0z2Y8BhPv6I36PYhWmfF/4swsS149txwKhXxqtfwUmrMvfJ9OOcxi0TdzBHlePKX
         1nsQ==
X-Gm-Message-State: AO0yUKUPUNwt+A87RBQzR/k73iWz+beCZOw7QF2xoqt4I9UwiNBW7jeR
        7OdQrNWr9Eb37XV1qH5kLbA=
X-Google-Smtp-Source: AK7set8+8Gttpm122NqDqvc3nC2lNl7BJB8qep7vWcThcDpY3xAa94UzgxD6C2weZGJKGFYJaL+MVA==
X-Received: by 2002:a17:902:f9ce:b0:199:1160:956c with SMTP id kz14-20020a170902f9ce00b001991160956cmr1513924plb.31.1678937097840;
        Wed, 15 Mar 2023 20:24:57 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090274cb00b001a0450da45csm4308670plt.185.2023.03.15.20.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 20:24:57 -0700 (PDT)
Message-ID: <13780a99-33bb-6387-d4e3-66bc8456c2f2@gmail.com>
Date:   Thu, 16 Mar 2023 11:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <d181a7bffc22be4b690f95f594ecbf5c.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <d181a7bffc22be4b690f95f594ecbf5c.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Stephen,


Thanks for your review.


On 2023/3/16 上午 05:59, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-15 00:28:55)
>> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> new file mode 100644
>> index 000000000000..5c2dea071b38
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/nuvoton,ma35d1-clk.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/nuvoton,ma35d1-clk.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Clock Controller Module Binding
> Binding is redundant.

I will remove this word.

>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description: |
>> +  The MA35D1 clock controller generates clocks for the whole chip,
>> +  including system clocks and all peripheral clocks.
>> +
>> +  See also:
>> +    include/dt-bindings/clock/ma35d1-clk.h
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: nuvoton,ma35d1-clk
>> +      - const: syscon
> Does it really need to be a syscon?

Some registers of the clock controller are locked against writing.
Before writing, the lock must be unlocked through the system controller.
So syscon is needed.

>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: clk_hxt
>> +
>> +  assigned-clocks:
>> +    maxItems: 5
>> +
>> +  assigned-clock-rates:
>> +    maxItems: 5
> I hope the assigned clocks properties can be left out of this doc.

Sure, we will remove it.

>> +
>> +  nuvoton,pll-mode:
>> +    description:
>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>> +      spectrum mode.
>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>> +    maxItems: 5
>> +    items:
>> +      minimum: 0
>> +      maximum: 2
> Why not use a string?

OK, we'll use strings instead.

>> +
>> +  nuvoton,sys:
>> +    description:
>> +      Phandle to the system management controller.
>> +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +  - clocks
>> +  - clock-names
>> +  - nuvoton,sys
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
> No need to include this header right?

Yes, I will remove this header in the next version.

>
>> +
>> +    clk: clock-controller@40460200 {
> Drop the label?

OK, I will drop this label in the next version.

>
>> +        compatible = "nuvoton,ma35d1-clk", "syscon";
>> +        reg = <0x40460200 0x100>;
>> +        #clock-cells = <1>;
>> +        clocks = <&clk_hxt>;
>> +        clock-names = "clk_hxt";
>> +        nuvoton,sys = <&sys>;
>> +    };


Best Regards,

Jacky Huang

