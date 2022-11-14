Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C764627D72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbiKNMOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiKNMOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:14:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309151AF2F;
        Mon, 14 Nov 2022 04:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668428081; x=1699964081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5x8kfOIpOogLr2BemNcIjIgxcyOCSCKqrEm0zBjiMTQ=;
  b=DXVZph+Yi5+GO915662RPN/Ze9q6HXEJ+fAN5ODiyOeF538wBYeEyloT
   9dxF1SCr0HLdQP1nbZp6gUWsD1O1aj6NCjDhYn1xkKOg9+UpY2RqbrUFk
   XfnZ6TY0revWTqt+la6NAjrUHnWf/1v8R2L262R6QDwQTLl9OuNk71B3u
   xXHr3dG6isU1qkiPfEp1/rB9F61HtrBZvpOT5WZrPdtipOmxeGC0tufR5
   E5rQgVWjHWgG2hdNtyc/6NgSQHoEilq0yCkPNkWCtUZ/2ROV6wUyNsgHi
   q17gcPlO24/jEdXrTUZsUlnnjdDuV+pAIW05pPdV/6k6MG96A/gA9loZR
   w==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="188868366"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2022 05:14:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 14 Nov 2022 05:14:38 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 14 Nov 2022 05:14:36 -0700
Date:   Mon, 14 Nov 2022 12:14:19 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <apatel@ventanamicro.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller
 bindings
Message-ID: <Y3IxG4d7ELlcmp0c@wendy>
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com>
 <9be58cb4-4ee8-a6e0-7a0a-f2f581e394d3@linaro.org>
 <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK9=C2X55CG6tjjiTPrecnnZZiwTOS1BSH3UTPa-fLBm38WdLA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
> 
> Refer, https://www.spinics.net/lists/devicetree/msg442720.html

AFAIU, <vendor> and <chip> are wildcards and do not have the same
meaning as vendor & chip. That's going off of the dt submitting patches
doc though and I don't know if the tooling supports this.

