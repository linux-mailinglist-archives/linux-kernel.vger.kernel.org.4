Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4641A70AD3B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 11:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEUJYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEUJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 05:24:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157BDBA;
        Sun, 21 May 2023 02:24:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1E26163B;
        Sun, 21 May 2023 09:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD1CC433D2;
        Sun, 21 May 2023 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684661090;
        bh=VFUii29FV4EQioWM+zCcaPyRQxlTB11/ZC6sCA8N8UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9I4iu8tkFEXqV0QmJ6D5PsZZLo5qVH6r6Frzo9prgUXEGs6GzcA2Z9m/FqJLKxx/
         TgKeGBUxjf23Tpabbe939cTayUaPqJxOk4x3eNuuKcs2uGeOn+6/Q8DVfkpb3p1XAm
         SvPrndOr0/zwxjtK93EdXBwlt0JsWD8IbOwvWxYMq7cwkS2h8Z2epjSQNP++0iOKdl
         dNsdkOuMt5SBdjafmY3xTkR5+PhARKrXk/pqHvmlN1u1eDlHUwY4g4AKS6saKm2/XG
         eIF2oNbqVmWgJmHs7YE38kQSZm5oqMbFz67l87+rdiouLGln0Xwhk/q2KUyzrpmNH0
         Mw9Z4EnPj6Yhw==
Date:   Sun, 21 May 2023 17:13:38 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <ZGngwijxAKRpzmh7@xhacker>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-4-jszhang@kernel.org>
 <b5869cb0-1eab-4ab7-6dd7-16b06f91d93f@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5869cb0-1eab-4ab7-6dd7-16b06f91d93f@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:00:50PM -0500, Samuel Holland wrote:
> Hi Jisheng,

Hi Samuel,

> 
> On 5/18/23 10:22, Jisheng Zhang wrote:
> > Add bindings doc for Bouffalolab UART Driver
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> >  .../serial/bouffalolab,bl808-uart.yaml        | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> > new file mode 100644
> > index 000000000000..0ef858e50efb
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/serial/bouffalolab,bl808-uart.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/serial/bouffalolab,bl808-uart.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bouffalolab UART Controller
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +allOf:
> > +  - $ref: serial.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: bouffalolab,bl808-uart
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> 
> This is not complete. There are separate APB and module (baud) clocks,
> as well as a peripheral reset line. If we are going to keep the binding
> stable, these need to be described up front.

IIUC, the only requirement is to keep the driver compatible with both
new dts and old dts. clk tree and reset can be added latter. I have seen
sevral such examples from other SoCs' mainline progress.

> 
> (I still don't fully understand the clock tree, and so far that has been
> the main blocker for me sending a follow-up series with additional
> bindings for hardware that's otherwise already supported, like the
> Ethernet MAC.)
> 
> Regards,
> Samuel
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    uart0: serial@30002000 {
> > +        compatible = "bouffalolab,bl808-uart";
> > +        reg = <0x30002000 0x1000>;
> > +        interrupts = <53 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks = <&xtal>;
> > +    };
> > +...
> 
