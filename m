Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFE072DA3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 08:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238340AbjFMGzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 02:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjFMGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 02:55:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C710D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:55:18 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5185f195f05so1799452a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686639317; x=1689231317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ya0JGjGnBFucsPDfp7+4IKVKKt1JIYfCsKyVruiNX70=;
        b=ciJ7aMVZ0GMKfRE1QHEWHJ/+hTTifJDeM3EguhxbExT8jSMBHgJBzCzbDyf2dV0YlV
         6Az9PZ1PjlmWE9kiCF4mSwx3ku/IhIVP9jpKpd7CU2hwdvKez9vJFZDoUgwFU1TTjhs5
         ysrzafMzuJgWPrr0J97gKj0VSHV1EQS1VzYxb0rp0FXCNo2j+Z6mjlxx/txj5BTeMF/L
         Sok6htd3FsAkXor9p22+afi0Cqvo0d/r6F55y1AVmgmjRImKqjMjxV7qN+sFsesKF0aP
         i/hAc/VFHqMJiJO2qu6CyPufIR+23CAViqgaWiwAeV5uMJy/Cu2eIt4xNUu2/8Rn8Pn2
         lzmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686639317; x=1689231317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya0JGjGnBFucsPDfp7+4IKVKKt1JIYfCsKyVruiNX70=;
        b=RqFNGJNUzWfqBDfvpXCeZRAfrVQm2rqK+pTlc9oP1/ls3RUu3XX0f2B2zqeNCLCWnM
         Gr/MN9oL0T6oMX6c+CDvLCgkPoVg6oh79lHNUm2OGtXOPmFba9a8YuwcrOAHLbW6J1Yr
         E5zW8oguQShpzvUM26k8pvTFsC4bpRXFzgeQ1xPv/4Kf4Up8zz+F3zFeqciXsXQ5VTVF
         Jip3mjlp6KF3BgaC7E9yDsFyrRkxAg5LRttMjbPBUS04Gf5oDAMKDZIbjH4CjSHL+1wE
         dz3B/a0Cz8jEc0C7OkKs5RHF+Y6Sh4bGZIUqNvm24zqLDqwWqNNFH7C3QRTIe+A2/gJx
         uC3Q==
X-Gm-Message-State: AC+VfDykZ+C3BTypcmFLz17FikraC6eIbcNmhEPIwX67KIoua6wqhPbf
        Rdwx2/eReP8TDDTv7gv0iXHHZA==
X-Google-Smtp-Source: ACHHUZ7TaDo55fN/TkO5Knr4heKEa4OgXNTHGx+AyyWww42lHuT5Covk8wTO1ijncHvSxtUPa8TbRQ==
X-Received: by 2002:a17:907:3fa4:b0:977:da9d:b842 with SMTP id hr36-20020a1709073fa400b00977da9db842mr12121149ejc.74.1686639316733;
        Mon, 12 Jun 2023 23:55:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709061c0e00b0096f6e2f4d9esm6115589ejg.83.2023.06.12.23.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 23:55:16 -0700 (PDT)
Message-ID: <399ac8fd-b5b1-50ae-c1bd-88951679cf83@linaro.org>
Date:   Tue, 13 Jun 2023 08:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/5] dt-bindings: ata: dwc-ahci: add Rockchip RK3588
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
 <20230608162238.50078-3-sebastian.reichel@collabora.com>
 <4c914503-c2e5-a5d8-97af-daaee0b4ec7c@linaro.org>
 <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
 <838ed0e6-985d-9a45-7ece-c607bda15871@linaro.org>
 <20230612085200.5okxcipiw5sofo62@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612085200.5okxcipiw5sofo62@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 10:52, Serge Semin wrote:
> On Mon, Jun 12, 2023 at 10:39:57AM +0200, Krzysztof Kozlowski wrote:
>> On 12/06/2023 10:35, Serge Semin wrote:
>>> On Mon, Jun 12, 2023 at 10:24:06AM +0200, Krzysztof Kozlowski wrote:
>>>> On 08/06/2023 18:22, Sebastian Reichel wrote:
>>>>> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
>>>>> allowed clocks without bloating the generic binding, the description
>>>>> of Rockchip's AHCI controllers has been moved to its own file.
>>>>>
>>>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>>>> ---
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    items:
>>>>> +      - enum:
>>>>> +          - rockchip,rk3568-dwc-ahci
>>>>> +          - rockchip,rk3588-dwc-ahci
>>>>> +      - const: snps,dwc-ahci
>>>>> +
>>>>> +  ports-implemented:
>>>>> +    const: 1
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^sata-port@[0-9a-e]$":
>>>>> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
>>>>> +
>>>>> +    unevaluatedProperties: false
>>>>
>>>
>>>> You should be able to skip this patternProperties entirely, because it
>>>> comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
>>>> without it?
>>>
> 
>>> Please see my message about this. The "sata-port@[0-9a-e]$" sub-node
>>> bindings could be updated with the "reg" property constraint which,
>>> based on the "ports-implemented" property value, most likely is
>>> supposed to be always set to const: 1.
>>
>> Then anyway the pattern is wrong as it should be @1 always.
> 
> * I miscalculated a bit, it should have been zero but in general
> the pattern-property is indeed redundant.
> 
> As a conclusion the change should look like this:
> 
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - rockchip,rk3568-dwc-ahci
> +          - rockchip,rk3588-dwc-ahci
> +      - const: snps,dwc-ahci
> +
> +  ports-implemented:
> +    const: 1
> +
> +  "sata-port@0":
> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
> +
> +    properties:
> +      reg:
> +        const: 0
> +
> +    unevaluatedProperties: false
> +
> + ...
> 
> Right?

Code is correct but as I said - probably meaningless. All other ports
are also accepted via referenced schema. You would need to disallow
other ports or switch to additionalProperties: false in top-level.

Best regards,
Krzysztof

