Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D828654681
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiLVTYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiLVTYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D911C05;
        Thu, 22 Dec 2022 11:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99C9161CE1;
        Thu, 22 Dec 2022 19:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2245C433D2;
        Thu, 22 Dec 2022 19:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671737040;
        bh=UTqBrX8CXcuLe1Opaa28kaUwSr5L0pWJFjuW7nIbBps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VtasgJkPU6ntIB9C8xyRlzibh/eySUioaZp9P3TigK9xUiunga/3zTZQiYtFG8IPu
         u4aFMWfyPveBOgidduKGfnL59rMwt0CQ1kc3ygJdO26H6Cr67FyvvJjEcClaSl60h6
         HY5NATp8aHmElr8P6JOfvtL6uueLhPstaB323k6Em2yipj1TT6M9UokipB3xIGCs6k
         IUpI5hKeDY8eNTfJLXncB45cNIKUITE1unWRA9KXhpPy/g+Mc+lxKzEDhv+0YEcFNn
         SV3I+Nd/Adsos1N68J5lTrd8HTs/S7hQ5qzvQUEz2ZE8QIf5MqVF0z1mDZHOWkX8IC
         l6fbhQcgv3+lw==
Date:   Thu, 22 Dec 2022 19:23:54 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        atishp@rivosinc.com, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        opensbi@lists.infradead.org
Subject: Re: [PATCH v1] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y6SuyiYC/oLB2VzL@spud>
References: <20221221141548.274408-1-conor@kernel.org>
 <20221222180627.GA1748427-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4wR4/gycHWfjw8/A"
Content-Disposition: inline
In-Reply-To: <20221222180627.GA1748427-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4wR4/gycHWfjw8/A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Rob,

On Thu, Dec 22, 2022 at 12:06:27PM -0600, Rob Herring wrote:
> On Wed, Dec 21, 2022 at 02:15:49PM +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > The SBI PMU extension requires a firmware to be aware of the event to
> > counter/mhpmevent mappings supported by the hardware. OpenSBI may use
> > DeviceTree to describe the PMU mappings. This binding is currently
> > described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by QEMU
> > since v7.2.0.
> >=20
> > Import the binding for use while validating dtb dumps from QEMU and
> > upcoming hardware (eg JH7110 SoC) that will make use of the event
> > mapping.
> >=20
> > Link: https://github.com/riscv-software-src/opensbi/blob/master/docs/pm=
u_support.md
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > I asked Rob on IRC about these bindings a few weeks ago & he said he
> > would be willing to take them. I have modified wording slightly in the
> > descriptions, but have mostly left things as close to the OpenSBI
> > documentation as possible.
>=20
> Please CC the perf maintainers. Might be crickets, but so they at least=
=20
> have a chance to see it.

Yah, I was kinda unsure who to CC. It does list them as being
specifically ARM so I probably made the wrong choice about inclusion.
I've added them now.

> > I'm not super sure about what I've done with the properties being
> > correct type wise, I went digging in bindings and am sorta using the
> > first thing that "fit".
> >=20
> > Since you wrote the md doc Atish, I put your co-developed-by. OpenSBI
> > is BSD-2-Clause licensed so I am also unsure as to what license I can
> > use for this binding since that's where I took it from.
> > ---
> >  .../devicetree/bindings/perf/riscv,pmu.yaml   | 158 ++++++++++++++++++
> >  1 file changed, 158 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.ya=
ml
> >=20
> > diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Do=
cumentation/devicetree/bindings/perf/riscv,pmu.yaml
> > new file mode 100644
> > index 000000000000..d65f937680af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> > @@ -0,0 +1,158 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/perf/riscv,pmu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: RISC-V SBI PMU events
> > +
> > +maintainers:
> > +  - Atish Patra <atishp@rivosinc.com>
> > +
> > +description: |
> > +  SBI PMU extension supports allow supervisor software to configure, s=
tart &
> > +  stop any performance counter at anytime. Thus, a user can leverage f=
ull
> > +  capability of performance analysis tools such as perf if the SBI PMU
> > +  extension is enabled. The OpenSBI implementation makes the following
> > +  assumptions about the hardware platform:
> > +    MCOUNTINHIBIT CSR must be implemented in the hardware. Otherwise, =
the SBI
> > +    PMU extension will not be enabled.
> > +
> > +    The platform must provide information about PMU event to counter m=
apping
> > +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> > +    extension will not be enabled.
> > +
> > +    The platforms should provide information about the PMU event selec=
tor
> > +    values that should be encoded in the expected value of MHPMEVENTx =
while
> > +    configuring MHPMCOUNTERx for that specific event. This can be done=
 via a
> > +    device tree or platform specific hooks. The exact value to be writ=
ten to
> > +    the MHPMEVENTx is completely dependent on the platform. The generic
> > +    platform writes the zero-extended event_idx as the expected value =
for
> > +    hardware cache/generic events as suggested by the SBI specificatio=
n.
> > +
> > +properties:
> > +  compatible:
> > +    const: riscv,pmu
> > +
> > +  riscv,event-to-mhpmevent:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents an ONE-to-ONE mapping between a PMU event and the eve=
nt
> > +      selector value that platform expects to be written to the MHPMEV=
ENTx CSR
> > +      for that event.
> > +      The mapping is encoded in an array format where each row represe=
nts an
>=20
> s/array/matrix/
>=20
> > +      event. The first element represents the event idx while the seco=
nd &
> > +      third elements represent the event selector value that should be=
 encoded
> > +      in the expected value to be written in MHPMEVENTx.
> > +      This property shouldn't encode any raw hardware event.
> > +    minItems: 1
> > +    maxItems: 255

I copied these 255s from dt-schema somewhere as a sane max.
Atish, is there a cap here or should we allow as many as someone likes?
The md binding doesn't mention any limits - is it in the SBI spec?
The strongest wording I saw there was "limited" & event idx is 20 bits
wide as per the spec [0]. Does that make 2^20 the hard limit here?

0 - https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.ad=
oc#11-performance-monitoring-unit-extension-eid-0x504d55-pmu

> > +    items:
> > +      $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> Huh? A property can only have 1 type. I wonder what the tools do with=20
> this...

I suppose I left this over (by accident) from when I had it arranged
slightly differently. I guess I never actually noticed as the tools
don't appear to complain. Now dropped :)

> > +      maxItems: 3
>=20
> Better to do:
>=20
>          items:
>            - description: what's in the 1st word
>            - description: what's in the 2nd word
>            - description: what's in the 3rd word
>=20
> And rework the overall description to not say the same thing.

Yah, good idea. I'll do that for the next version.

> > +  riscv,event-to-mhpmcounters:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents a MANY-to-MANY mapping between a range of events and =
all the
> > +      MHPMCOUNTERx in a bitmap format that can be used to monitor thes=
e range
> > +      of events. The information is encoded in an array format where e=
ach
> > +      row represents a certain range of events and corresponding count=
ers.
> > +      The first element represents starting of the pmu event id and 2n=
d column
> > +      represents the end of the pmu event id. The third element repres=
ent a
> > +      bitmap of all the MHPMCOUNTERx.
> > +      This property is mandatory if event-to-mhpmevent is present. Oth=
erwise,
> > +      it can be omitted.
>=20
> No need to state this in freeform text, use 'dependencies'.

Oh! I didn't know that that existed. I was going to go and do some sort
of required properties dance but perhaps that's not needed now (at least
to the same extent).

> > +      This property shouldn't encode any raw event.
> > +    minItems: 1
> > +    maxItems: 255
> > +    items:
> > +      $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      maxItems: 3
> > +
> > +  riscv,raw-event-to-mhpmcounters:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents an ONE-to-MANY or MANY-to-MANY mapping between the ra=
wevent(s)
> > +      and all the MHPMCOUNTERx in a bitmap format that can be used to =
monitor
> > +      that raw event.
> > +      The encoding of the raw events are platform specific. The inform=
ation is
> > +      encoded in an array format where each row represents the specifi=
c raw
> > +      event(s). The first element is a 64-bit match value where the in=
variant
> > +      bits of range of events are set. The second element is a 64-bit =
mask that
> > +      will have all the variant bits of the range of events cleared. A=
ll other
> > +      bits should be set in the mask. The third element is a 32-bit va=
lue to
> > +      represent bitmap of all MHPMCOUNTERx that can monitor these set =
of
> > +      event(s). If a platform directly encodes each raw PMU event as a=
 unique
> > +      ID, the value of select_mask must be 0xffffffff_ffffffff.
> > +    minItems: 1
> > +    maxItems: 255
> > +    items:
> > +      $ref: /schemas/types.yaml#/definitions/uint32-array
> > +      maxItems: 5
> > +
> > +required:
> > +  - compatible
>=20
> I assume at least one of the other properties must be present?

Atish: (and +CC the OpenSBI list)
Which properties are actually needed here? Or are any? The md binding
in the OpenSBI sources doesn't seem to require anything other than the
compatible?

Thanks Rob,
Conor.


--4wR4/gycHWfjw8/A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6SuygAKCRB4tDGHoIJi
0sBJAQCBb8LfSpRr50PGJ/MMYc80DhPX8SA6g08IeSWTCi5UWgD9G4UgEQffHyGP
OVaTnTLq8t88+8bsyX4LEh8Ov/0zlQ4=
=COOT
-----END PGP SIGNATURE-----

--4wR4/gycHWfjw8/A--
