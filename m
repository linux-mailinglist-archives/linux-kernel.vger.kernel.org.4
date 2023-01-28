Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD77767F6E9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjA1KKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjA1KKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:10:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB24204
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:10:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso6676817wmb.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aR5Dg7w2l0iykP9VsPNgegnDIXzxG8qSZnQngFSkNqc=;
        b=PnDXWGTqyGPIlfP8pAto4OWRpswlITQardjDL7yCDiKvkEhB9iRxuk6CQHyJOsVGG4
         M3KKuSzu9HeJiGZPsva3s4kQm3V75zh8+qdUEOaGnafbuDsAN9b/heeACuEQkOgZUnlQ
         L+Ej/Jz+UvWncau8THu+o82o52erILE//0HLfrcZjYWea1/pEj+yh8WKtUVPl/8aqbWo
         uBbmNiAPWmxjC6ibVlkJrd9bPMZPnx1pdLBgjUI1DYkNRsKdpCjfGXXXLIoa4aZv1su3
         lvdJcMFPR2dKbwFi5nSMdPXBBw2506bS5/p7wOAkax0kJAajeT2CjdsceuaieWMfIciD
         VP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aR5Dg7w2l0iykP9VsPNgegnDIXzxG8qSZnQngFSkNqc=;
        b=Pg4bhSroBG2190BEd1q3MxAP5+GJdtrrHvSoOAXeoR21IrG0EnDjVILfNlDRsnQpJO
         kes4qLma9F2KTvw4Gj7y3b81lZJy0AdVd9U9G60CyE1D1vyY38u6QtedEszV/utnJws2
         esq/SJcRoFaCrO0DNRZrgvKJcnwV3KggFGoWd2j1+Dxnnw68U+lRlqOEevFePypfGJqu
         jBlXXlsdfurVUIWTEJJN782gIBH5qzygF8LmuaJpLiG5Gq84Idbb4hmQ+/7YZ3gHIhvT
         NSsNxr1SaLdui+/DmL+U2hFtNuPOkDPYHIM+Ja40dQPp+9iiiMZ4CrTxHM3fyEVlmCe/
         HvPQ==
X-Gm-Message-State: AFqh2kr2QsUDuA8yqd4bi9tC9XwNeTCUGWAh9B+qr5HVgjwE4rxWvuRm
        re1nXju6r+B3FBkbh2l31VnCYQ==
X-Google-Smtp-Source: AMrXdXvDvA3UXuMrtLwp4bkpwXroSUQMWjSXQhCsdVW5TUW0VJJoU5KgeShQnWh1YGRlvL4EzDRNZw==
X-Received: by 2002:a05:600c:35d5:b0:3db:fc4:d018 with SMTP id r21-20020a05600c35d500b003db0fc4d018mr41023283wmq.40.1674900629290;
        Sat, 28 Jan 2023 02:10:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ip7-20020a05600ca68700b003dc433bb5e1sm2716551wmb.9.2023.01.28.02.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:10:28 -0800 (PST)
Message-ID: <518c3b72-9e54-018a-3876-ea18a64531da@linaro.org>
Date:   Sat, 28 Jan 2023 11:10:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: display: bridge: sil,sii8620: convert to
 dtschema
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230127203525.198295-1-krzysztof.kozlowski@linaro.org>
 <Y9TdO9MeNxkesIQE@pendragon.ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y9TdO9MeNxkesIQE@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2023 09:30, Laurent Pinchart wrote:
> Hi Krzysztof,
> 
> Thank you for the patch.
> 
> On Fri, Jan 27, 2023 at 09:35:25PM +0100, Krzysztof Kozlowski wrote:
>> Convert the Silicon Image SiI8620 HDMI/MHL bridge bindings to DT schema.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/display/bridge/sil,sii8620.yaml  | 107 ++++++++++++++++++
>>  .../bindings/display/bridge/sil-sii8620.txt   |  33 ------
>>  2 files changed, 107 insertions(+), 33 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>> new file mode 100644
>> index 000000000000..90532bb99161
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
>> @@ -0,0 +1,107 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/bridge/sil,sii8620.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Silicon Image SiI8620 HDMI/MHL bridge
>> +
>> +maintainers:
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    const: sil,sii8620
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xtal
>> +
>> +  cvcc10-supply:
>> +    description: Digital Core Supply Voltage (1.0V)
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  iovcc18-supply:
>> +    description: I/O Supply Voltage (1.8V)
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  ports:
>> +    $ref: /schemas/graph.yaml#/properties/ports
>> +    unevaluatedProperties: false
>> +
>> +    properties:
>> +      port@0:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          Video port for HDMI (encoder) input
>> +
>> +      port@1:
>> +        $ref: /schemas/graph.yaml#/properties/port
>> +        description:
>> +          MHL to connector port
>> +
>> +    required:
>> +      - port@0
> 
> Why port@0 only ?

I am not the author of the original binding, but when it was introduced,
I think it came without MHL port support - only HDMI. This probably is
incomplete but I guess can work due to some default settings. Shall we
make both required? I don't know, sounds reasonable...

Best regards,
Krzysztof

