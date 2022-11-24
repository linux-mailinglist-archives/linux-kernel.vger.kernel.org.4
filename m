Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C48637D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 16:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiKXPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 10:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXPiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 10:38:52 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CCB30562;
        Thu, 24 Nov 2022 07:38:51 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so3082087lfv.2;
        Thu, 24 Nov 2022 07:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+oPkZf+GhfgQrKgiZPW3MBbJ+ctJWRY4GDqWnQ3KJw=;
        b=pAd5o1mDKoJlLHYuEBrsAdp97sFCOalRl7ZCuIjJ5TJeysxEpSt0XnQTZQNpAWfRxD
         l+OwBw38RqoTdZqummg3ixL4VK2aGhoUF05LvfvJ6IH0w2vMk1mCMdBUKYq3JjVl5ZGX
         63X/lcyXIwwW7NS+XsC37pKsONBwJsH7JqCJlxe5nE2OCh/Tu5gzxvFMxZ2M0RiPRZZ+
         hxoXQEbOdd5FT/5+JZUX9qYhUS0n+1QLIyCo0vm0SCIyGwC2m0jb9PPuqSxybCJCL/8S
         7Hk6RiLMSznbCDMmqjusKWoFoMQTzBiyp8YbkNpxd+b0Ql7etJWE3YTB+XiKf+Fx1xY7
         G/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+oPkZf+GhfgQrKgiZPW3MBbJ+ctJWRY4GDqWnQ3KJw=;
        b=mCA6ntUbCxZlJ3Xj1tzFia5i2SnHzxPspbiD0OgKwylpSjZ+OdJY7N2LX/gBqNcka+
         GzuAubXujUEPpy+ecdIr+0O32rmUK7LT9cmpi0Hclafg3o+w6do/0C46iRKyzd4gTwfB
         Vn76EU/LdmLvrn6CRFni05rjmYr95hPEJuYZirhItoN3W0iP5/scwXdfYzuU0tNUfR0S
         Iz+ROH7aUvAJp3nXlhaX57d8t1jnoIc40Il9TPg+ggj99IyZWUfgmi6WLCTZ/6Izvl5z
         2wr9cjwsHVITjaDgl8GPhyCB3dqP84XwyIl2kLANt1XeZDammmaA5lIc76XbyTYgMvPD
         aJGQ==
X-Gm-Message-State: ANoB5pm+rNjeXhlawbYohKz5J4dV8MSGUyXpbJIrTGUn567IxziUOqjD
        OJwpExpFTLxTCkVDEcTTaViRlbd6VSryn4bNBnU=
X-Google-Smtp-Source: AA0mqf6HsXQhF0DuR+7Wf3ySK3+lEUJMnOoMStylksqgUclTIEYHWGoDP2vvobF8sQuaz0QLvF326DqzQon/i2S9fnw=
X-Received: by 2002:a05:6512:2116:b0:4b4:b904:a310 with SMTP id
 q22-20020a056512211600b004b4b904a310mr10492674lfr.576.1669304329613; Thu, 24
 Nov 2022 07:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20221122201232.107065-1-tmaimon77@gmail.com> <20221122201232.107065-2-tmaimon77@gmail.com>
 <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
In-Reply-To: <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Thu, 24 Nov 2022 17:38:38 +0200
Message-ID: <CAP6Zq1iGwqOVOnhmF0ijYw=KoTRJj5CUpFv6WDouZmjVxXhQ-g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-binding: soc: nuvoton: Add NPCM BPC LPC documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        arnd@arndb.de, hasegawa-hitomi@fujitsu.com, marcan@marcan.st,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        heiko@sntech.de, sven@svenpeter.dev, briannorris@chromium.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks a lot for your comments.

On Wed, 23 Nov 2022 at 12:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/11/2022 21:12, Tomer Maimon wrote:
>
> 1. Subject: drop second, redundant "documentation" (dt-bindings are
> documentation).
O.K.
>
> 2. Use subject prefixes matching the subsystem (git log --oneline -- ...).
this is what I did dt-binding: soc: nuvoton... do you mean dt-binding: nuvoton.
>
> > Added device tree binding documentation for Nuvoton BMC NPCM BIOS Post
> > Code (BPC).
> >
> > The NPCM BPC monitoring two configurable I/O addresses written by the
> > host on Low Pin Count (LPC) bus.
> >
> > Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> > ---
> >  .../bindings/soc/nuvoton/npcm-lpc-bpc.yaml    | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml b/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml
> > new file mode 100644
> > index 000000000000..2c8e66546891
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/nuvoton/npcm-lpc-bpc.yaml
>
> Filename should match compatibles, at least in the "vendor,device"
> style, so for example: nuvoton,lpc.yaml
>
> > @@ -0,0 +1,112 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/nuvoton/npcm-lpc-bpc.yaml#
>
> LPC is a generic bus, so this should not be in "soc" directory. Where?
> Depends what is this... Generic bus bindings could be in "bus" directory
> or dedicated "lpc", if we have more of these.
The BPC can run also on the eSPI bus therefore I think it better to
remove the LPC and describe only the BPC module it self.
>
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Nuvoton Low Pin Count (LPC) Bus Controller
> > +
> > +maintainers:
> > +  - Tomer Maimon <tmaimon77@gmail.com>
> > +
> > +description:
> > +  The Low Pin Count (LPC) is a low bandwidth bus that is used to connect
> > +  peripherals around the CPU and to replace the Industry Standard Architecture
> > +  (ISA) bus.
>
> You need to decide whether you describe here bus, bus controller or
> device on the bus.
>
> > +
> > +  The Nuvoton NPCM LPC bus is a bridge of host CPU to a several of peripheral
> > +  devices.
>
> LPC bus is a bridge? It's either incorrect or so generic that every bus
> is a "bridge"?
>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - nuvoton,npcm750-lpc
> > +          - nuvoton,npcm845-lpc
> > +      - const: simple-mfd
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 1
> > +
> > +  ranges: true
> > +
> > +patternProperties:
> > +  "^lpc_bpc@[0-9a-f]+$":
>
> No underscores in node names. Generic node names, so maybe "bpc"
>
> This also does not match your example at all.
>
>
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    description:
> > +      Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable I/O
> > +      addresses written by the host on the Low Pin Count (LPC) bus, the capure
>
> typo: capture
>
> > +      data stored in 128-word FIFO.
> > +
> > +      NPCM BPC supports capture double words, when using capture
> > +      double word only I/O address 1 is monitored.
>
> This sentence is not grammatically correct. BPC supports capturing
> double words when using double word capturing? Aren't these two sentences?
>
> > +
> > +    properties:
> > +      compatible:
> > +        items:
>
> No items here.
>
> > +          - enum:
> > +              - nuvoton,npcm750-lpc-bpc
> > +              - nuvoton,npcm845-lpc-bpc
> > +
> > +      reg:
> > +        maxItems: 1
> > +
> > +      interrupts:
> > +        maxItems: 1
> > +
> > +      nuvoton,monitor-ports:
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        description:
> > +          Contain monitor I/O addresses, at least one monitor I/O address
>
> Contains
>
> But you need to explain what are these... I/O addresses on the bus?
>
> > +          required.
> > +
> > +      nuvoton,bpc-en-dwcapture:
> > +        description: If present, Enable capture double words support.
>
> Is it the same as reg-io-width?
>
> > +        type: boolean
> > +
> > +    required:
> > +      - compatible
> > +      - reg
> > +      - interrupts
> > +      - nuvoton,monitor-ports
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +  - ranges
> > +
> > +additionalProperties:
> > +  type: object
>
> No, only bus schemas could have it. Here additionalProperties: false.
>
> It seems there are already few LPC controllers and all are put in
> different places:
> Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> Documentation/devicetree/bindings/arm/hisilicon/low-pin-count.yaml
>
> Maybe Rob why this was made not really as two bindings - for bus
> controller and devices?
As mention above, next patch I will describe only the BPC device.
>
> Best regards,
> Krzysztof
>

In general, I waiting for Arnd approval for adding the NPCM BPC driver to SoC.
After Arnd approval, I will send a new patch revision.

Best regards,

Tomer
