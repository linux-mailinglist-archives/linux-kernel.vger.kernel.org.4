Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D620F635977
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236746AbiKWKQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiKWKPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:15:14 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CC81255DE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:03:31 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so27431643lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xrp9emg8rmzMjobwMpdEQCEo1OkOBMLjYQe8MINMVNo=;
        b=ql9cW+HxihOHo5ErhgqND81dCz26wUv7fAfv7rs02E6tP0ANDEs5aQlw5Mh/41C5ya
         6dkp601F5nRFztG81TMblWiaZK6kd5Hp3CuknKk8QDi58ATwJWkepZDFiury74gOQRxm
         5lIYMO+Ip7AFwCAoy5F/qXzJ5NO5PxAios/FTXxdcnvn/IZyyjr3ujLm/HQcSspL69Ts
         hRkymyq3MchxJJEPRLHk9mR8zng1koCY4+yXT88iT+wV5KbVh0aM4UMb+GA8joUNk+PD
         Au/XJE+Bz//c/Nwlq+FhM2bjiojaffPhBxuzYgIWrBMatesc0m4lgA2C7LxHvAWFMgrQ
         hkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xrp9emg8rmzMjobwMpdEQCEo1OkOBMLjYQe8MINMVNo=;
        b=o+6tyg4Om0shKIgt+a1C0Wy7/GUhuUQRsJUAELd2546Pn5kaUfb3B4oFHb/IvrFAZk
         6qJb6QgUe/OC1VbQiMEUDM7MbOxdLcbHqJpThK16VowxPcvdA2FzXsGcMpKkGercV9oS
         WwWAy+fsT0cnCa4xHPI4sCQzC0VYKdf0MV31uAL1GEXYSTRJKabCOWVGI+ibXAGIEZWS
         nL9DRmAt8PYSX0s2Jj4oAc1SgmYY6yacDk0Yl2r0mzZsqn7MERJwNG+pp6t1VENK5teZ
         witTb8AlILwVEI5wttBlGoiVQBGpXqo9WOn5GDgjz4a8LO0gb/6P8AVYcnewQm+zLJVY
         z4fw==
X-Gm-Message-State: ANoB5pkLD+2IUEPpCixiQiyd0/cIGNrOKiCUUORDTfKnD/UTLi8JDvlp
        IDxaznHkqu9mRjduAw263k3x2w==
X-Google-Smtp-Source: AA0mqf7R+ffMLqXf9Cp1KfZgINgnCgPuAR3jvHdHDFn13QxVur9RO6l7hku+b0va3p/aeMmg7jRq4A==
X-Received: by 2002:ac2:46f8:0:b0:4af:5088:8fa3 with SMTP id q24-20020ac246f8000000b004af50888fa3mr9691661lfo.538.1669197810196;
        Wed, 23 Nov 2022 02:03:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id br31-20020a056512401f00b004b1a5086485sm2834830lfb.2.2022.11.23.02.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 02:03:29 -0800 (PST)
Message-ID: <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
Date:   Wed, 23 Nov 2022 11:03:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1 1/2] dt-binding: soc: nuvoton: Add NPCM BPC LPC
 documentation
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, arnd@arndb.de,
        hasegawa-hitomi@fujitsu.com, marcan@marcan.st,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        heiko@sntech.de, sven@svenpeter.dev, briannorris@chromium.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221122201232.107065-1-tmaimon77@gmail.com>
 <20221122201232.107065-2-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122201232.107065-2-tmaimon77@gmail.com>
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

On 22/11/2022 21:12, Tomer Maimon wrote:

1. Subject: drop second, redundant "documentation" (dt-bindings are
documentation).

2. Use subject prefixes matching the subsystem (git log --oneline -- ...).

> Added device tree binding documentation for Nuvoton BMC NPCM BIOS Post
> Code (BPC).
> 
> The NPCM BPC monitoring two configurable I/O addresses written by the
> host on Low Pin Count (LPC) bus.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/soc/nuvoton/npcm-lpc-bpc.yaml    | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml b/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml
> new file mode 100644
> index 000000000000..2c8e66546891
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml

Filename should match compatibles, at least in the "vendor,device"
style, so for example: nuvoton,lpc.yaml

> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/nuvoton/npcm-lpc-bpc.yaml#

LPC is a generic bus, so this should not be in "soc" directory. Where?
Depends what is this... Generic bus bindings could be in "bus" directory
or dedicated "lpc", if we have more of these.

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton Low Pin Count (LPC) Bus Controller
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description:
> +  The Low Pin Count (LPC) is a low bandwidth bus that is used to connect
> +  peripherals around the CPU and to replace the Industry Standard Architecture
> +  (ISA) bus.

You need to decide whether you describe here bus, bus controller or
device on the bus.

> +
> +  The Nuvoton NPCM LPC bus is a bridge of host CPU to a several of peripheral
> +  devices.

LPC bus is a bridge? It's either incorrect or so generic that every bus
is a "bridge"?

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nuvoton,npcm750-lpc
> +          - nuvoton,npcm845-lpc
> +      - const: simple-mfd
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^lpc_bpc@[0-9a-f]+$":

No underscores in node names. Generic node names, so maybe "bpc"

This also does not match your example at all.


> +    type: object
> +    additionalProperties: false
> +
> +    description:
> +      Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable I/O
> +      addresses written by the host on the Low Pin Count (LPC) bus, the capure

typo: capture

> +      data stored in 128-word FIFO.
> +
> +      NPCM BPC supports capture double words, when using capture
> +      double word only I/O address 1 is monitored.

This sentence is not grammatically correct. BPC supports capturing
double words when using double word capturing? Aren't these two sentences?

> +
> +    properties:
> +      compatible:
> +        items:

No items here.

> +          - enum:
> +              - nuvoton,npcm750-lpc-bpc
> +              - nuvoton,npcm845-lpc-bpc
> +
> +      reg:
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      nuvoton,monitor-ports:
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        description: 
> +          Contain monitor I/O addresses, at least one monitor I/O address 

Contains

But you need to explain what are these... I/O addresses on the bus?

> +          required.
> +
> +      nuvoton,bpc-en-dwcapture:
> +        description: If present, Enable capture double words support.

Is it the same as reg-io-width?

> +        type: boolean
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - nuvoton,monitor-ports
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties:
> +  type: object

No, only bus schemas could have it. Here additionalProperties: false.

It seems there are already few LPC controllers and all are put in
different places:
Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml

Maybe Rob why this was made not really as two bindings - for bus
controller and devices?

Best regards,
Krzysztof

