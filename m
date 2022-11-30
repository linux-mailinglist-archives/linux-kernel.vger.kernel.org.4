Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEDD63E0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiK3TaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3TaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:30:18 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207808C44C;
        Wed, 30 Nov 2022 11:30:17 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-14263779059so22267697fac.1;
        Wed, 30 Nov 2022 11:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vey2xyZWw852h6h6+sA2dVPI7ZTC37aAaOAnPv7n9Cs=;
        b=I6pnVW1Zml+1uikWb+2tCdDpqX9aKyudylPaMRNuXlxeXA2paVyAk48AVmTzAov1jh
         0Cj+SWwle57WeIwteNjD385Px+DXdhQS20uiajWTaLjwkqUu6abjJ7ulpSD8JjSElN/d
         MpW/JsZnIms0ewTBaE9L6ytSTVWN63Rwaf7471COyNhvAWlGG0P9XLjmAY1Y7RioT/LN
         K1i1dlSBW2XF1iX57GXGMi1mHzNCBxtU7filqzTe/GlXfZ7ivrR5w0lp8XS9XoJcN740
         KV5Mnk2yUF9YfXlgosI9cJj1buVfyvtR708OlyLv2fHOfTy4FFgnkPPo1WfOSWyMRbmT
         ffhg==
X-Gm-Message-State: ANoB5plaCgW8S/j0kU3DYF7WaRUbvMMhDfn0EBQ8KHt+DFvU7pfGtNlc
        AQoW1H71x534ZZEw9bD9bw==
X-Google-Smtp-Source: AA0mqf6euqww3Wd1rIgPAv+lutmMx14inHv1/54xYfDjWH7CJCTALg8wNYpo9bIiKFtWbL0Uj8+vnA==
X-Received: by 2002:a05:6870:a11d:b0:132:3c19:8cbc with SMTP id m29-20020a056870a11d00b001323c198cbcmr34597528oae.185.1669836616291;
        Wed, 30 Nov 2022 11:30:16 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s10-20020acadb0a000000b0035b439a4b81sm970779oig.31.2022.11.30.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 11:30:15 -0800 (PST)
Received: (nullmailer pid 2655052 invoked by uid 1000);
        Wed, 30 Nov 2022 19:30:14 -0000
Date:   Wed, 30 Nov 2022 13:30:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, arnd@arndb.de,
        hasegawa-hitomi@fujitsu.com, marcan@marcan.st,
        nicolas.ferre@microchip.com, conor.dooley@microchip.com,
        heiko@sntech.de, sven@svenpeter.dev, briannorris@chromium.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: soc: nuvoton: Add NPCM BPC LPC
 documentation
Message-ID: <20221130193014.GA2645083-robh@kernel.org>
References: <20221122201232.107065-1-tmaimon77@gmail.com>
 <20221122201232.107065-2-tmaimon77@gmail.com>
 <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cedc0013-f0c0-3180-6995-477b77b919f8@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 11:03:28AM +0100, Krzysztof Kozlowski wrote:
> On 22/11/2022 21:12, Tomer Maimon wrote:
> 
> 1. Subject: drop second, redundant "documentation" (dt-bindings are
> documentation).
> 
> 2. Use subject prefixes matching the subsystem (git log --oneline -- ...).
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

ISA type bus is 2 cells.

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

What does 'reg' contain then?

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

Always the 3rd instance that gets to restructure things...

> Maybe Rob why this was made not really as two bindings - for bus
> controller and devices?

This schema should certainly be split between LPC and BPC. As LPC is 
logically ISA bus, there is an ISA bus schema in dtschema already which 
should be referenced.

Rob
