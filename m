Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE6D6620B7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjAII4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbjAII4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:56:05 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C514D10
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:48:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id g10so5716542wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ro2kDxZz7EAGoP5oHQ+mMCthtYR+NfGs0EcWvR992/U=;
        b=a1OUTyWsfSJOzJkq+NwDuyY/u+r1EWBFBTPp+MSvMayYRSPvsimiqnzJ3htgctQ5Tr
         H42l6ypH6FWYVco1PA4qDAcL+pQfwJA28WXGboOgrdKtJEJK0WGxFkSIikTWyXPi4UVC
         Sh2xXV44YDtv6mvhmgaFUWamT+S9ustTKX9e6oKFdo4obgzrYKlA3O/yHWXJfACtZAz0
         kPwO6GKzamgxGgvu0QSmbRkSMtfN7Fyqr5wE7ZSEUR306HqUN0YE2QfCuKTCl1Ky0P2G
         aIbI9LRDd9wptntPhaAN5+jP09rc3iU81rI6+V0VpwU0P7SQLbIj4qdZSpoAYE0TFp6R
         e0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ro2kDxZz7EAGoP5oHQ+mMCthtYR+NfGs0EcWvR992/U=;
        b=MbsCjoNiheHI1m49EU0h94RYKFk6zN8MIcjbearpWra8HzH5BxZrKqV6mtt3Fl/Y0V
         bpo47kdKOr82pSc4bz3x+P01Yve2UQBcGKf9YKtHDnwtcNJzVhDHpx2wwoadQpP7hH7Q
         VMxqCgZg5IlrJXm/EPDrjXkwrC1Dkrb7BMoCqEvPrf4qSgU5cXjssA5zisyACsX9ei1R
         vG1J0JbxDOY2nNTiHeuLg1feaub3VAxnSSCvol7KdZ3vcGsGv/4lPwzDfVV4DX2WlPup
         6Z0DFQ79cvC+3xskiKqvtDTH2G8iCkWNY+bn2v8qN2RM/nOcGmh7tfcrRm0ig3czk1bH
         gdfA==
X-Gm-Message-State: AFqh2koNXMjKmZVMjeUahvoSg0ZUolNr1pdXWRPT+SWCfIIfqB0F1SfY
        /EuoGmfwXMK6sMis04caMu6D8w==
X-Google-Smtp-Source: AMrXdXumc1fDCo2pgBLphIGetaLBrbPrgwuQjhJdu0PBJh702GIp0qwkyrG9R0zgq9jtyJFIj454/Q==
X-Received: by 2002:a05:600c:1ca3:b0:3d3:591a:bfda with SMTP id k35-20020a05600c1ca300b003d3591abfdamr48974353wms.27.1673254110851;
        Mon, 09 Jan 2023 00:48:30 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d990372dd5sm16516337wmq.20.2023.01.09.00.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 00:48:30 -0800 (PST)
Message-ID: <4e71bc38-27dc-4b81-49c9-c71c8e8f1cc4@linaro.org>
Date:   Mon, 9 Jan 2023 09:48:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/16] dt-bindings: spi: Convert bcm63xx-hsspi bindings to
 json-schema
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-2-william.zhang@broadcom.com>
 <0581eeed-f7d1-caf2-0dba-be14a01d7c05@linaro.org>
 <7828c353-e3f3-31d2-638d-3b11dc085a34@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7828c353-e3f3-31d2-638d-3b11dc085a34@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 08:52, William Zhang wrote:
> 
> 
> On 01/07/2023 07:32 AM, Krzysztof Kozlowski wrote:
>> On 06/01/2023 21:07, William Zhang wrote:
>>> This is the preparation for updates on the bcm63xx hsspi driver. Convert
>>> the text based bindings to json-schema per new dts requirement.
>>>
>>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>>> ---
>>>
>>>   .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 52 +++++++++++++++++++
>>>   .../bindings/spi/spi-bcm63xx-hsspi.txt        | 33 ------------
>>>   2 files changed, 52 insertions(+), 33 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>>   delete mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>> new file mode 100644
>>> index 000000000000..45f1417b1213
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
>>> @@ -0,0 +1,52 @@
>>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Broadcom BCM6328 High Speed SPI controller
>>> +
>>> +maintainers:
>>> +  - Jonas Gorski <jonas.gorski@gmail.com>
>>> +
>>
>> Missing reference to spi-controller.
>>
> This was word to word conversion from the text file. But I will update 
> with this required reference.
> 
>>> +properties:
>>> +  compatible:
>>> +    const: brcm,bcm6328-hsspi
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: spi master reference clock
>>> +      - description: spi master pll clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: hsspi
>>> +      - const: pll
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - clocks
>>> +  - clock-names
>>> +  - interrupts
>>> +
>>> +unevaluatedProperties: false
>>
>> This is for cases when you have reference to other schema.
>>
> Will drop here. But will add back in patch 1 which produces the final 
> version of this file and need this property.

When you add reference to spi-controller, keep it here. This was wrong
when the reference was missing.

Best regards,
Krzysztof

