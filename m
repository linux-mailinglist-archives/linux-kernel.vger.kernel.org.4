Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E118272BAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjFLIk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbjFLIkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:40:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACECBBE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:40:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9786c67ec32so672414266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686559200; x=1689151200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02uq97znLW4jmjI8z3bfmKNKoaY1pURh+uCJ5ILlpl4=;
        b=r3TsQrkeAGuvV2odOjldtDHX2T+L/m8a6yRAR6lIrc1jRs/1Pi7KK6zsjHLQaR8cFi
         SxaiTckU4XCvA2DPqjaaReqb+/Ae0hBbsLNK5bvqVBAI2no9Okt7LkqEigfQIl88nkDa
         w7wumWQefYsGZSbmJ1MQso5m0yw6SrQjAHkcXfTMBztqlxs+oQbcCNSNhRQ49gBbDecK
         3ULlREI4GhYIh6OYo/CtkDRCa61kLyeP5IohYjEoxQaXLHbRuB93Jam2vFM/NLuA9yk9
         eOoNeqarG51IqFkVglJ+aCHvRNBS7EBfpFXnulWi3Erhu2A6GnEgPgDwE7YVB48i9yIX
         SLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686559200; x=1689151200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02uq97znLW4jmjI8z3bfmKNKoaY1pURh+uCJ5ILlpl4=;
        b=ieuBk0OCNhlFFQpl7qTpAjhNNY5qXgjE7DNgWXZxBogNF8xEib83U6zIbm5UIPMAx0
         leLOcVPzTvecXTgCBWet3dzTp//6T/WZ3ap8x0YFdHqioby4YyKY5AVstZwOsGYT5bZr
         YRJW5ChGgR2U4+pQs5rzU1j0neA3TJhJSNIxJnVEl1exzSf6Hb9WS2fqSpMvetaYFrIE
         IK3Fw9I42yO/Oh+jTAQb8bPXF4HwJd59W9nwY1NVqIaskL1Go9gEPUUHZiRs6nz9gWFp
         co9ckXP0OPRg0qoW8xZ+sZra2NYDUYsfvTHXEqM0XjYblvnBBzqK4lHZVSBWciwDFg6O
         ZNbg==
X-Gm-Message-State: AC+VfDxRAY32HTdz5bWTdKUNBrYLQdWCLN4VU/JJSfTnwF2LfkHRmR0i
        Me3ZboM1dvbqsPAFvsKKXL+KDQ==
X-Google-Smtp-Source: ACHHUZ4xrQwuUVb3h5HfV5TapbFL6CRyh+HdmkFi6c1IQyUy5wmGPCLKe5LhyIoZ9pNqf/4ghHn8Qg==
X-Received: by 2002:a17:907:9617:b0:974:1ef7:1e88 with SMTP id gb23-20020a170907961700b009741ef71e88mr9928825ejc.13.1686559200150;
        Mon, 12 Jun 2023 01:40:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906258300b00977d194bf42sm4851790ejb.161.2023.06.12.01.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 01:39:59 -0700 (PDT)
Message-ID: <838ed0e6-985d-9a45-7ece-c607bda15871@linaro.org>
Date:   Mon, 12 Jun 2023 10:39:57 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612083536.q3sq7w6cyiuxaqtv@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 10:35, Serge Semin wrote:
> On Mon, Jun 12, 2023 at 10:24:06AM +0200, Krzysztof Kozlowski wrote:
>> On 08/06/2023 18:22, Sebastian Reichel wrote:
>>> This adds Rockchip RK3588 AHCI binding. In order to narrow down the
>>> allowed clocks without bloating the generic binding, the description
>>> of Rockchip's AHCI controllers has been moved to its own file.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>> ---
>>
>> ...
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - rockchip,rk3568-dwc-ahci
>>> +          - rockchip,rk3588-dwc-ahci
>>> +      - const: snps,dwc-ahci
>>> +
>>> +  ports-implemented:
>>> +    const: 1
>>> +
>>> +patternProperties:
>>> +  "^sata-port@[0-9a-e]$":
>>> +    $ref: /schemas/ata/snps,dwc-ahci-common.yaml#/$defs/dwc-ahci-port
>>> +
>>> +    unevaluatedProperties: false
>>
> 
>> You should be able to skip this patternProperties entirely, because it
>> comes from dwc-ahci-common -> ahci-common schema. Did you try the patch
>> without it?
> 
> Please see my message about this. The "sata-port@[0-9a-e]$" sub-node
> bindings could be updated with the "reg" property constraint which,
> based on the "ports-implemented" property value, most likely is
> supposed to be always set to const: 1.

Then anyway the pattern is wrong as it should be @1 always.

Best regards,
Krzysztof

