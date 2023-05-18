Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834EF708391
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjEROG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjEROGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:06:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A0D10E2;
        Thu, 18 May 2023 07:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684418803; x=1715954803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Ql81PbdPYsst1Egf8I5nhPuh1Xe/UW0zjJnF/GxGws=;
  b=THmSrP25rA3Og1E0a2YgXH94O9uf3/cNleB1dSlSL5zt1DKyvm1Sg6UD
   vwufVkjt9k6x9LwycVMYJTve7ig+M6K79R5p8xzM/kw4jddYsQndzbOzL
   UQKi3pwU4x9BobbnKUQdoKrN+xaQh0nqnNW5rOhXoAXJlIGXx0jCvuRSD
   euImVSNN3tbcIeVpoKTIibdIg2LZt9eRH4FLTnlFnt30bupVEGVnRsfAA
   qscx6lkAWzbwJ8fnoo6HDaTKPtKJeKo3QibZEO8ummKvJoaxAVx4TdCLf
   NC3NCpHInc7pPOXjO6uHXuU4wG+ezhLQ7B4oIn2HvWfkBV+GdfWla5cEl
   A==;
X-IronPort-AV: E=Sophos;i="5.99,285,1677567600"; 
   d="asc'?scan'208";a="216119339"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2023 07:06:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 18 May 2023 07:06:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 18 May 2023 07:06:38 -0700
Date:   Thu, 18 May 2023 15:06:17 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Anup Patel <anup@brainfault.org>
CC:     Andrew Jones <ajones@ventanamicro.com>, <palmer@dabbelt.com>,
        <conor@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        <linux-riscv@lists.infradead.org>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230518-hammock-doornail-478e8ea8e6a7@wendy>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="inIwqqp4mBpjB1FE"
Content-Disposition: inline
In-Reply-To: <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--inIwqqp4mBpjB1FE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 07:13:15PM +0530, Anup Patel wrote:
> On Thu, May 18, 2023 at 4:02=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
=2Ecom> wrote:
> > On Thu, May 18, 2023 at 09:58:30AM +0100, Conor Dooley wrote:

> > > -  riscv,isa:
> > > -    description:
> > > -      Identifies the specific RISC-V instruction set architecture
> > > -      supported by the hart.  These are documented in the RISC-V
> > > -      User-Level ISA document, available from
> > > -      https://riscv.org/specifications/
> > > -
> > > -      Due to revisions of the ISA specification, some deviations
> > > -      have arisen over time.
> > > -      Notably, riscv,isa was defined prior to the creation of the
> > > -      Zicsr and Zifencei extensions and thus "i" implies
> > > -      "zicsr_zifencei".
> > > -
> > > -      While the isa strings in ISA specification are case
> > > -      insensitive, letters in the riscv,isa string must be all
> > > -      lowercase to simplify parsing.
> > > -    $ref: "/schemas/types.yaml#/definitions/string"
> > > -    pattern: ^rv(?:64|32)imaf?d?q?c?b?k?j?p?v?h?(?:[hsxz](?:[a-z])+)=
?(?:_[hsxz](?:[a-z])+)*$
> > > -
> > >    # RISC-V requires 'timebase-frequency' in /cpus, so disallow it he=
re
> > >    timebase-frequency: false
> > >
> > > @@ -133,8 +117,13 @@ properties:
> > >        DMIPS/MHz, relative to highest capacity-dmips-mhz
> > >        in the system.
> > >
> > > +oneOf:
> > > +  - required:
> > > +      - riscv,isa
> >
> > This is the part Anup keeps reminding me about. We can create better wa=
ys
> > to handle extensions in DT and ACPI, but we'll still need to parse ISA
> > strings to handle legacy DTs and holdouts that keep creating ISA string=
s,
> > at least during the deprecation period, since ISA strings are still "the
> > way to do it" according to the spec.
>=20
> Coming up with an alternate way in DT is fine but we can't deprecate
> ISA strings since ISA strings are widely used:
> 1) Various bootloaders

Aye, for the reason, as I mentioned earlier and in the RFC thread,
removing existing parsers isn't a good idea.

> 2) It is part of /proc/cpuinfo

That is irrelevant.

> 3) Hypervisors use it to communicate HW features to Guest/VM.
> Hypervisors can't get away from generating ISA strings because
> Hypervisors don't know what is running inside Guest/VM.

Generate both :) As things stand, your guests could interpret what you
communicate to them via riscv,isa differently!

> In the case of ACPI, it is a very different situation. Like Sunil mention=
ed,
> ACPI will always follow mechanisms defined by RVI (such as ISA string).
> Other ACPI approaches such as GUID for ISA extension are simply not
> scalable and will take a lot more memory for ACPI tables compared to
> ISA strings.

My proposal should actually suit ACPI, at least for Linux, as it would
be a chance to align currently misaligned definitions. I won't speak to
GUIDs or whatever as that's someone else's problem :)

> > Also, if we assume the wording in the spec does get shored up, then,
> > unless I'm missing something, the list of advantages for this boolean
> > proposal from your commit message would be
>=20
> IMO, we should try our best to have the wordings changed in RVI spec.

Yes, doing so is beneficial for all of us regardless of what happens
here. I do think that it is partially orthogonal - it allows us to not
design an interface that needs to be capable of communicating a wide
variety of versions, but I don't think it solves some of the issues
that riscv,isa has. If I thought it did, I would not have gone to the
trouble of respinning this patch out of the other approach.

> > * More character choices for name -- probably not a huge gain for ratif=
ied
> >   extensions, since the boolean properties will likely still use the sa=
me
> >   name as the ISA string (riscv,isa-extension-<name>). But, for vendor
> >   extensions, this is indeed a major improvement, since vendor extension
> >   boolean property names may need to be extended in unambiguous ways to
> >   handle changes in the extension.
> >
> > * Simpler, more complete DT validation (but we still need a best effort
> >   for legacy ISA strings)
> >
> > * Simpler DT parsing (but we still need the current parser for legacy I=
SA
> >   strings)
> >
> > > +  - required:
> > > +      - riscv,isa-base
> > > +
> > >  required:
> > > -  - riscv,isa
> > >    - interrupt-controller
> > >
> > >  additionalProperties: true
> > > @@ -177,7 +166,13 @@ examples:
> > >                  i-tlb-size =3D <32>;
> > >                  mmu-type =3D "riscv,sv39";
> > >                  reg =3D <1>;
> > > -                riscv,isa =3D "rv64imafdc";
> > > +                riscv,isa-base =3D "rv64i";
> > > +                riscv,isa-extension-i;
> > > +                riscv,isa-extension-m;
> > > +                riscv,isa-extension-a;
> > > +                riscv,isa-extension-f;
> > > +                riscv,isa-extension-d;
> > > +                riscv,isa-extension-c;
>=20
> One downside of this new approach is it will increase the size of DTB.
> Imaging 50 such DT properties in 46 CPU DT nodes.

I should do a comparison between 50 extensions in riscv,isa and doing
this 50 times and see what the sizes are.

--inIwqqp4mBpjB1FE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGYw2QAKCRB4tDGHoIJi
0hSeAP9jzSAva+PzLu6ehqVimB0Aoyoav0gV6v8bchdyV0ETdgEA0jVTNEscUYpu
ogN+UZoE7KVethG+zRAi1/oDPc87rgo=
=HFE9
-----END PGP SIGNATURE-----

--inIwqqp4mBpjB1FE--
