Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6A6EF545
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241095AbjDZNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240992AbjDZNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:15:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3C524E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:15:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-506bdf29712so53323274a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 06:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682514932; x=1685106932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5X6XbY4GDs1zBv4u666H8NBc+gIaLqZ5jMZDYOgtIiE=;
        b=csEP7fZdTmBKFMSHuwcvXsv4i9NMYXACDayZgOM4X9kux+rwqi6nmitioNzmZg/a28
         OUKwei1asmNDrQK9gRNOeSeB4Ey5TY8SihiXJHDiq4+9WeeGm46XbVILUiAuPmTuhtav
         uqIh3573N7omTVGYjYiKMIbAOkFTe03G7vtsd2i88+IuS+zsVbLhfzZJnipA/D6tstNF
         zwjFSL50ti7B7jzvO3m4DaXFc8M4apafaGJ0w0zwz9Ur0Y1x/WVzy3ImHD7RgQvY2LF2
         Gogo+Ckj8cg69f9DfBtLUN8USsA7xsHHLo16l+ca9aikh8Jefe0K3ik5ajQYQfc5XVDr
         4fTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682514932; x=1685106932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5X6XbY4GDs1zBv4u666H8NBc+gIaLqZ5jMZDYOgtIiE=;
        b=D16caaOTtoIX6hWoEVX8IuMiMDAB09ZesLrvt82q6/oW32CInNzuLFXalXj+gWvbe2
         76l36gAdcHCLcU6tTnb6SzeN68UjhqoiIzarrR39nN3pdxY/64thxxTUJLCFLeHW6NBK
         n8AOW6SidSeGSGaYDyBUZqBVGtTc0E4INlu3FgQrsmJcB5/Y2PZ+iGZ/6S7rbO/Bw5z3
         uK1dCs0ne5u4YUmGMWPJl8EwmJUSKDNOjCE0IdI5GMREBUr18zcQ1aWmnoY8dmfUL4Vu
         WOnXShbCnd5KutvH2SxrKzIvzsrq4KRcg3MHNo6io7JQov/BpnJWCEE33sK2372gl0zn
         h6+w==
X-Gm-Message-State: AC+VfDykgiH3wkgoIsJ/dNl8ScsS7YpzVStdIf307rNUQJ81+92P9/IE
        wlFTCz3ns8l9YmKnMFGn5iMOHw==
X-Google-Smtp-Source: ACHHUZ7nSlGKXPcRIffgSkm2iBxwOkyGHDmgNxJTloG4BcBShfBKk6j6RPxDVvXpOivjiadIjs89+g==
X-Received: by 2002:a17:906:4898:b0:94f:2020:b5dd with SMTP id v24-20020a170906489800b0094f2020b5ddmr2399230ejq.24.1682514931969;
        Wed, 26 Apr 2023 06:15:31 -0700 (PDT)
Received: from [172.23.2.142] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id l20-20020a170906645400b0095342bfb701sm8407935ejn.16.2023.04.26.06.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 06:15:31 -0700 (PDT)
Message-ID: <d30cb539-d5de-94c3-237a-fb27c97e7c5e@linaro.org>
Date:   Wed, 26 Apr 2023 15:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/9] dt-bindings: ASoC: Add chv3-i2s
Content-Language: en-US
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
        upstream@semihalf.com
References: <20230414140203.707729-1-pan@semihalf.com>
 <20230414140203.707729-3-pan@semihalf.com>
 <5544de12-396c-29d4-859c-a6e17b2e2de4@linaro.org>
 <CAF9_jYRXsdQX22bOVG5Dp20GnC7JniqGC6popTS5dSxmiqjizQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAF9_jYRXsdQX22bOVG5Dp20GnC7JniqGC6popTS5dSxmiqjizQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2023 18:01, Paweł Anikiel wrote:
> On Fri, Apr 14, 2023 at 7:00 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/04/2023 16:01, Paweł Anikiel wrote:
>>> Add binding for chv3-i2s device.
>>
>> Your subject needs improvements:
>> 1. ASoC goes before bindings
>> 2. You miss some meaningful title of device. "chv3-i2s" can be anything,
>> so add Google or Google Chameleon. Or use entire compatible.
> 
> Would "ASoC: dt-bindings: Add Google Chameleon v3 I2S device" be better?

Yes, thanks.

> 
>>
>>
>>>
>>> Signed-off-by: Paweł Anikiel <pan@semihalf.com>
>>> ---
>>>  .../bindings/sound/google,chv3-i2s.yaml       | 42 +++++++++++++++++++
>>>  1 file changed, 42 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
>>> new file mode 100644
>>> index 000000000000..6f49cf059ac5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/google,chv3-i2s.yaml
>>> @@ -0,0 +1,42 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/google,chv3-i2s.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Google Chameleon v3 I2S device
>>> +
>>> +maintainers:
>>> +  - Paweł Anikiel <pan@semihalf.com>
>>> +
>>> +description: |
>>> +  I2S device for the Google Chameleon v3. The device handles both RX
>>> +  and TX using a producer/consumer ring buffer design.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: google,chv3-i2s
>>
>> Missing blank line.
>>
>> Is chv3 the name of your SoC? Where are the SoC bindings? What's exactly
>> the versioning scheme for it (compatibles must be specific, not generic).
> 
> The Chameleon v3 is based around an Intel Arria 10 SoC FPGA. The i2s
> device is implemented inside the FPGA. Does this case require SoC
> bindings?

No, I was mistaken. I somehow get impression that's for Pixel... Sorry
for the noise.

> 
>>
>>> +  reg:
>>> +    items:
>>> +      - description: core registers
>>> +      - description: irq registers
>>
>> As well...
>>
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    i2s0: i2s@c0060300 {
>>> +        compatible = "google,chv3-i2s";
>>> +        reg = <0xc0060300 0x100>,
>>> +              <0xc0060f00 0x10>;
>>> +        interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
>>
>> Isn't 0 also a known define?
> 
> Do you mean this?
> interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;


Yes, please.

Best regards,
Krzysztof

