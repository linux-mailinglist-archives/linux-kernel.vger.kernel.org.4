Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29BC726A5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjFGUEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjFGUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:04:17 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7752E19AC;
        Wed,  7 Jun 2023 13:04:08 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-77a62a84855so85602539f.1;
        Wed, 07 Jun 2023 13:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686168247; x=1688760247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raWNAi0peUWVI3Y9OrLkCkchq3HuytUBPEeFbP0ENuk=;
        b=RT/4Ansqnewawi4SZqN3dWQjT4XFkbrds9oSySi+YlzIbjd3NhBGhCubFhRokcLzBZ
         50FN5hB0LC0VN9nVTtp18s+R+k5rDL7aGGP4Q+3bjylbEq209aHiujMFFT0mbP3ze/nC
         H9XBWjEEhb7MkrZ5ViQSMIi66xgnXPC8Jx4rSRpshJ1q3YY0mv/P4avt7q+b2guKbOQf
         5KY6kErl8Q/j1IosGYH6vsclY4givoxYL9TU5r9+Y4rSBWN+1OkPMUEAl7HQzoMIuP7q
         0F/Y1215t9y6keFIb/JPp+Gi3EDD/F1Uct0DT5ny8My4SkRHBX8nHZwr9ZxdmYVJhOhR
         vvJQ==
X-Gm-Message-State: AC+VfDzxYHsebiOpfm6ad6csyxWuqnJgqpAyMhXNNGcA6DThD1zj37YM
        mm4O1Fw5edYDmbgcpRuxCrb3Nl+TYg==
X-Google-Smtp-Source: ACHHUZ45IDkIGT2Q9JMkxSSYM+aG/391kCQL1L54WXzc5BgP8ucqjIEn8nrFNK3DEjXExINnGSY8NQ==
X-Received: by 2002:a5d:8703:0:b0:776:fc02:184e with SMTP id u3-20020a5d8703000000b00776fc02184emr6236322iom.14.1686168247383;
        Wed, 07 Jun 2023 13:04:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n7-20020a02cc07000000b0041cce10544dsm3696709jap.123.2023.06.07.13.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 13:04:06 -0700 (PDT)
Received: (nullmailer pid 3931893 invoked by uid 1000);
        Wed, 07 Jun 2023 20:04:03 -0000
Date:   Wed, 7 Jun 2023 14:04:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 06/10] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <20230607200403.GA3909108-robh@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-7-jszhang@kernel.org>
 <c6e44e14-35b2-da09-5e8c-4d47e7a7a055@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e44e14-35b2-da09-5e8c-4d47e7a7a055@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 10:31:35PM -0500, Samuel Holland wrote:
> Hi Jisheng, DT maintainers,
> 
> On 5/18/23 10:22, Jisheng Zhang wrote:
> > Several SoMs and boards are available that feature the Bouffalolab
> > bl808 SoC. Document the compatible strings.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/riscv/bouffalolab.yaml           | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > new file mode 100644
> > index 000000000000..3b25d1a5d04a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bouffalo Lab Technology SoC-based boards
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description:
> > +  Bouffalo Lab Technology SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: Carrier boards for the Sipeed M1s SoM
> > +        items:
> > +          - enum:
> > +              - sipeed,m1s-dock
> > +          - const: sipeed,m1s
> > +          - const: bouffalolab,bl808
> 
> As mentioned in the message for patch 5, "The Bouffalolab bl808 SoC
> contains three riscv CPUs, namely M0, D0 and LP. The D0 is 64bit RISC-V
> GC compatible, so can run linux."
> 
> I have also been running U-Boot and NOMMU Linux on the less powerful,
> but still quite fast, "M0" core. However, this core needs a different
> DTB because:
>  1) The CPU is different (T-HEAD E907 instead of C906).
>  2) The interrupt routing is completely different.
>     a. The M0 core contains a CLIC instead of a PLIC.
>     b. The peripherals in the SoC are split between two buses. Those
>        on one bus have their IRQs directly connected to M0, and share
>        a multiplexed IRQ connection to D0; and vice versa for the
>        other bus. So each bus's interrupt-parent needs to be swapped.

Can't you include the dts file and then just override 
'interrupt-parent'? 

> Using some preprocessor magic like we did for Allwinner and Renesas, I
> was able to share most of the SoC and board DTs between the cores[1].
> However, this still ends up with two DTs for each board. So here are my
> questions:
>  - Is this acceptable?
>  - Is there precedent for how we should name the two board DTs?
>  - How does this affect the board and SoC compatible strings?
>    - Should there be a separate "bouffalolab,bl808-d0" in addition to
>      "bouffalolab,bl808"?

Probably. A DT is ultimately the view of the hardware from a CPU's 
perspective. Different views, different compatibles.

>    - Is it acceptable to use the same board compatible string for both,
>      since the _board_ part of the DT does not change, only things
>      inside the SoC?

Yes.

> 
> It would be possible to avoid having two DTs per board by guarding all
> of the differences behind "#ifdef CONFIG_64BIT", but that seems wrong
> because you would end up with two totally incompatible DTBs named the
> same thing, depending on how the DTB was built.

You can't have CONFIG_ options in .dts files.

Rob
