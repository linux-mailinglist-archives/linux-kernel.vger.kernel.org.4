Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786C962C8CF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiKPTOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPTOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:14:37 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54E4FF9E;
        Wed, 16 Nov 2022 11:14:35 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13bd19c3b68so21236662fac.7;
        Wed, 16 Nov 2022 11:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbNwY8VQfyVGQAfwpv9JwDuw9SzkucH6WBiJQC8HG/0=;
        b=thSBOreqavT3G5hbzKdeAv2t9AUEetIAen5peKjjwkUa66DRE4r2xhma6s5VCa99XX
         vV8TeSD5QHJTzaP2d0kmwabBuC63PZTgSsbSQ6Eq1H8Jwt1qZw0ziUsd7kmCWU9PVKv8
         qTgtCVJ0G+t2thWRfGBlE8lXM5FAIbLMGNayalT0w42eXH8SwbJbQ8N3z0GLAmqRZK50
         MmOZ/cXGR6SPfKXUZ0/+kLpvRKEzF0979LEc7MH3Zt+WsoY8XcUjTHuqBlWlRhsm8zHi
         EGoTuejDsB6zpmqHm78UQwDa4OujznynQppCCXGbGTt6gVt1e4s+mwu07scgnDXTyLnN
         fMHQ==
X-Gm-Message-State: ANoB5pnYNUAE22IBZcmDPWTl31dTSPHec1ZrWiikLOngKTB4AzLEvEYW
        rPePap/LWWXWjphqLuBmIUXXJe8OJw==
X-Google-Smtp-Source: AA0mqf6W/GBmEupGrcmRWBiGyu1SngWULZHScW7/4hei+ZTTdpIo3o2J+2Cu2gu2NAHj41OG+sJznA==
X-Received: by 2002:a05:6870:4b4c:b0:13c:c5bd:c311 with SMTP id ls12-20020a0568704b4c00b0013cc5bdc311mr2710756oab.108.1668626074869;
        Wed, 16 Nov 2022 11:14:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d5-20020a4aaa85000000b0049faebecee2sm338173oon.35.2022.11.16.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:14:34 -0800 (PST)
Received: (nullmailer pid 743580 invoked by uid 1000);
        Wed, 16 Nov 2022 19:14:36 -0000
Date:   Wed, 16 Nov 2022 13:14:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <20221116191436.GA576695-robh@kernel.org>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <9be58cb4-4ee8-a6e0-7a0a-f2f581e394d3@linaro.org>
 <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 05:36:06PM +0530, Anup Patel wrote:
> On Mon, Nov 14, 2022 at 3:19 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 11/11/2022 05:42, Anup Patel wrote:
> > > We add DT bindings document for RISC-V incoming MSI controller (IMSIC)
> > > defined by the RISC-V advanced interrupt architecture (AIA) specification.
> > >
> > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > ---
> > >  .../interrupt-controller/riscv,imsic.yaml     | 174 ++++++++++++++++++
> > >  1 file changed, 174 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> > > new file mode 100644
> > > index 000000000000..05106eb1955e
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,imsic.yaml
> > > @@ -0,0 +1,174 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interrupt-controller/riscv,imsic.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: RISC-V Incoming MSI Controller (IMSIC)
> > > +
> > > +maintainers:
> > > +  - Anup Patel <anup@brainfault.org>
> > > +
> > > +description:
> > > +  The RISC-V advanced interrupt architecture (AIA) defines a per-CPU incoming
> > > +  MSI controller (IMSIC) for handling MSIs in a RISC-V platform. The RISC-V
> > > +  AIA specification can be found at https://github.com/riscv/riscv-aia.
> > > +
> > > +  The IMSIC is a per-CPU (or per-HART) device with separate interrupt file
> > > +  for each privilege level (machine or supervisor). The configuration of
> > > +  a IMSIC interrupt file is done using AIA CSRs and it also has a 4KB MMIO
> > > +  space to receive MSIs from devices. Each IMSIC interrupt file supports a
> > > +  fixed number of interrupt identities (to distinguish MSIs from devices)
> > > +  which is same for given privilege level across CPUs (or HARTs).
> > > +
> > > +  The arrangement of IMSIC interrupt files in MMIO space of a RISC-V platform
> > > +  follows a particular scheme defined by the RISC-V AIA specification. A IMSIC
> > > +  group is a set of IMSIC interrupt files co-located in MMIO space and we can
> > > +  have multiple IMSIC groups (i.e. clusters, sockets, chiplets, etc) in a
> > > +  RISC-V platform. The MSI target address of a IMSIC interrupt file at given
> > > +  privilege level (machine or supervisor) encodes group index, HART index,
> > > +  and guest index (shown below).
> > > +
> > > +  XLEN-1           >=24                                 12    0
> > > +  |                  |                                  |     |
> > > +  -------------------------------------------------------------
> > > +  |xxxxxx|Group Index|xxxxxxxxxxx|HART Index|Guest Index|  0  |
> > > +  -------------------------------------------------------------
> > > +
> > > +  The device tree of a RISC-V platform will have one IMSIC device tree node
> > > +  for each privilege level (machine or supervisor) which collectively describe
> > > +  IMSIC interrupt files at that privilege level across CPUs (or HARTs).
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - vendor,chip-imsics
> >
> > There is no such vendor... As Conor pointed out, this does not look
> > correct. Compatibles must be real and specific.
> 
> Previously, Rob had suggest to:
> 1) Mandate two compatible strings: one for implementation and
>     and second for specification
> 2) Since this is new specification with QEMU being the only
>     implementation, we add "vendor,chip-imsics" as dummy
>     implementation specific string for DT schema checkers
>     to pass the examples. Once we have an actual implementation,
>    we will replace this dummy string.

What will QEMU's DT use? That's an implementation we can and do run 
validation on. Your choices are define a QEMU specific compatible string 
or allow the fallback alone. I'm fine either way. With the latter, 
someone has to review that the fallback is not used alone in .dts files 
while doing the former allows the tools to check for you. It also 
encourages making every new difference a property rather than implied by 
compatible, but those should be caught in review.

If you go with the fallback only, just make it clear that it's for QEMU 
or s/w models only.

Rob
