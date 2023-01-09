Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65361662309
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjAIKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbjAIKTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:19:33 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1A01B1CA;
        Mon,  9 Jan 2023 02:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673259487; x=1704795487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cnRJATz7yJsL7r1ewcN8ZjNqQ8XVBjEcH8iArzaQBEc=;
  b=fxUwXr6DXT0e66UHBoQaqGieOUDwt7qqAu0YjimQmnSf+sZLmqrR2qLQ
   /8oXf61xMseUpC/CJM510L1fudPEja8hx2f1LJmzS5IJVPLGnSNvPz6Zh
   Jh4yzlq/FnEL31Ni8wrO5jy/Gf1+MNf26NSQwO+ZCpjlHEz+LNaUe3kc/
   8P0A4Y/6nNIuprsdzpWpEquINfIXTYaKn9Ykj8BeyYtNVSNeCt5RViSs8
   hQ+OJ+7N8JZKldC/UmQZe7XstWNwNtL73vBHixo9k5w/Cjq1XVJGJUhy6
   N0Nzbjn4xTa9o+fz13JSD9foB6OIAmfTbEa3P5gwBxDlznm9R1n/cN5xc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="asc'?scan'208";a="131438788"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jan 2023 03:18:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 9 Jan 2023 03:18:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 9 Jan 2023 03:18:02 -0700
Date:   Mon, 9 Jan 2023 10:17:41 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     Conor Dooley <conor@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <atishp@rivosinc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <apatel@ventanamicro.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <opensbi@lists.infradead.org>,
        <samuel@sholland.org>
Subject: Re: [PATCH v4] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y7vpxW1AeEOhcxUf@wendy>
References: <20230108215047.3165032-1-conor@kernel.org>
 <20230109092715.bwomqoeosif43lr2@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vAoaG+B+xOqDz4RP"
Content-Disposition: inline
In-Reply-To: <20230109092715.bwomqoeosif43lr2@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vAoaG+B+xOqDz4RP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 10:27:15AM +0100, Andrew Jones wrote:
> On Sun, Jan 08, 2023 at 09:50:48PM +0000, Conor Dooley wrote:
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
> > Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-=
sbi.adoc # Performance Monitoring Unit Extension
> > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > Changes in v4:
> > - A bunch of minor description/comment changes suggested by Drew
> >=20
> > Changes in v3:
> > - align descriptions to SBI spec (and fix a misinterpretation of mine)
> > - switch to a nested items description, since the descriptions are for
> >   the elements of each entry, not the entries themselves
> >=20
> > Changes in v2:
> > - use the schema mechanism for dependancies between properties
> > - +CC perf maintainers...
> > - move the matrix element descriptions into regular item descriptions
> >   rather than doing so freeform in the property description
> > - drop some description text that no longer applies since changes were
> >   made to the SBI spec
> > - drop mention of the "generic platform" which is OpenSBI specific
> > - drop the min/max items from the matrices, they don't appear to be
> >   needed?
> >=20
> > Note:
> > OpenSBI is BSD-2-Clause licensed so I am unsure as to whether I can
> > submit it with a dual license.
> > ---
> >  .../devicetree/bindings/perf/riscv,pmu.yaml   | 160 ++++++++++++++++++
> >  1 file changed, 160 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.ya=
ml
> >=20
> > diff --git a/Documentation/devicetree/bindings/perf/riscv,pmu.yaml b/Do=
cumentation/devicetree/bindings/perf/riscv,pmu.yaml
> > new file mode 100644
> > index 000000000000..5e7a54e3d91b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/perf/riscv,pmu.yaml
> > @@ -0,0 +1,160 @@
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
> > +  The SBI PMU extension allows supervisor software to configure, start=
 and
> > +  stop any performance counter at anytime. Thus, a user can leverage a=
ll
> > +  capabilities of performance analysis tools, such as perf, if the SBI=
 PMU
> > +  extension is enabled. The following constraints apply:
> > +
> > +    The platform must provide information about PMU event to counter m=
appings
> > +    via device tree or platform specific hooks. Otherwise, the SBI PMU
> > +    extension will not be enabled.
> > +
> > +    Platforms should provide information about the PMU event selector =
values
> > +    that should be encoded in the expected value of MHPMEVENTx while c=
onfiguring
> > +    MHPMCOUNTERx for that specific event. This can be done via a devic=
e tree or
> > +    platform specific hooks. The exact value to be written to MHPMEVEN=
Tx is
> > +    completely dependent on the platform.
>=20
> The previous two paragraphs reference 'platform specific hooks'. I don't
> think this DT-specific description, as opposed to the more general OpenSBI
> description it's derived from, should reference the hooks, as "hooks"
> aren't defined in this context.

Do you have any suggestion about how it should be worded? It is
apparently valid to have only a compatible string in the dt-binding and
rely on using platform hooks to communicate the mapping. In that case,
the dt-binding only communicates the presence of SBI PMU support.
IMO, if we don't mention that that is a valid way, the fact that we only
require a compatible for a DT to be valid looks like a mistake in the
binding.

Thanks,
Conor.

> > +    For information on the SBI specification see the section "Performa=
nce
> > +    Monitoring Unit Extension" of:
> > +      https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv=
-sbi.adoc
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
> > +      selector value that the platform expects to be written to the MH=
PMEVENTx
> > +      CSR for that event.
> > +      The mapping is encoded in an matrix format where each element re=
presents
> > +      an event.
> > +      This property shouldn't encode any raw hardware event.
> > +    items:
> > +      items:
> > +        - description: event_idx, a 20-bit wide encoding of the event =
type and
> > +            code. Refer to the SBI specification for a complete descri=
ption of
> > +            the event types and codes.
> > +        - description: upper 32 bits of the event selector value for M=
HPMEVENTx
> > +        - description: lower 32 bits of the event selector value for M=
HPMEVENTx
> > +
> > +  riscv,event-to-mhpmcounters:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents a MANY-to-MANY mapping between a range of events and =
all the
> > +      MHPMCOUNTERx in a bitmap format that can be used to monitor thes=
e range
> > +      of events. The information is encoded in an matrix format where =
each
> > +      element represents a certain range of events and corresponding c=
ounters.
> > +      This property shouldn't encode any raw event.
> > +    items:
> > +      items:
> > +        - description: first event_idx of the range of events
> > +        - description: last event_idx of the range of events
> > +        - description: bitmap of MHPMCOUNTERx for this event
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
> > +      encoded in a matrix format where each element represents the spe=
cific raw
> > +      event(s).
> > +      If a platform directly encodes each raw PMU event as a unique ID=
, the
> > +      value of variant must be 0xffffffff_ffffffff.
> > +    items:
> > +      items:
> > +        - description:
> > +            upper 32 invariant bits for the range of events
> > +        - description:
> > +            lower 32 invariant bits for the range of events
> > +        - description:
> > +            upper 32 bits of the variant bit mask for the range of eve=
nts
> > +        - description:
> > +            lower 32 bits of the variant bit mask for the range of eve=
nts
> > +        - description:
> > +            bitmap of all MHPMCOUNTERx that can monitor the range of e=
vents
> > +
> > +dependencies:
> > +  "riscv,event-to-mhpmevent": [ "riscv,event-to-mhpmcounters" ]
> > +  "riscv,event-to-mhpmcounters": [ "riscv,event-to-mhpmevent" ]
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    pmu {
> > +        compatible =3D "riscv,pmu";
> > +        riscv,event-to-mhpmevent =3D <0x0000B 0x0000 0x0001>;
> > +        riscv,event-to-mhpmcounters =3D <0x00001 0x00001 0x00000001>,
> > +                                      <0x00002 0x00002 0x00000004>,
> > +                                      <0x00003 0x0000A 0x00000ff8>,
> > +                                      <0x10000 0x10033 0x000ff000>;
> > +        riscv,raw-event-to-mhpmcounters =3D
> > +            /* For event ID 0x0002 */
> > +            <0x0000 0x0002 0xffffffff 0xffffffff 0x00000f8>,
> > +            /* For event ID 0-4 */
> > +            <0x0 0x0 0xffffffff 0xfffffff0 0x00000ff0>,
> > +            /* For event ID 0xffffffff0000000f - 0xffffffff000000ff */
> > +            <0xffffffff 0x0 0xffffffff 0xffffff0f 0x00000ff0>;
> > +    };
> > +
> > +  - |
> > +    /*
> > +     * For HiFive Unmatched board the encodings can be found here
> > +     * https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86=
ed8b16acba_fu740-c000-manual-v1p6.pdf
> > +     *
> > +     * This example also binds standard SBI PMU hardware IDs to U74 PM=
U event
> > +     * codes, U74 uses a bitfield for events encoding, so several U74 =
events
> > +     * can be bound to a single perf ID.
> > +     * See SBI PMU hardware IDs in arch/riscv/include/asm/sbi.h
> > +     */
> > +    pmu {
> > +          compatible =3D "riscv,pmu";
> > +          riscv,event-to-mhpmevent =3D
> > +              /* SBI_PMU_HW_CACHE_REFERENCES -> Instruction or Data ca=
che/ITIM busy */
> > +              <0x00003 0x00000000 0x1801>,
> > +              /* SBI_PMU_HW_CACHE_MISSES -> Instruction or Data cache =
miss or MMIO access */
> > +              <0x00004 0x00000000 0x0302>,
> > +              /* SBI_PMU_HW_BRANCH_INSTRUCTIONS -> Conditional branch =
retired */
> > +              <0x00005 0x00000000 0x4000>,
> > +              /* SBI_PMU_HW_BRANCH_MISSES -> Branch or jump mispredict=
ion */
> > +              <0x00006 0x00000000 0x6001>,
> > +              /* L1D_READ_MISS -> Data cache miss or MMIO access */
> > +              <0x10001 0x00000000 0x0202>,
> > +              /* L1D_WRITE_ACCESS -> Data cache write-back */
> > +              <0x10002 0x00000000 0x0402>,
> > +              /* L1I_READ_ACCESS -> Instruction cache miss */
> > +              <0x10009 0x00000000 0x0102>,
> > +              /* LL_READ_MISS -> UTLB miss */
> > +              <0x10011 0x00000000 0x2002>,
> > +              /* DTLB_READ_MISS -> Data TLB miss */
> > +              <0x10019 0x00000000 0x1002>,
> > +              /* ITLB_READ_MISS-> Instruction TLB miss */
> > +              <0x10021 0x00000000 0x0802>;
> > +          riscv,event-to-mhpmcounters =3D <0x00003 0x00006 0x18>,
> > +                                        <0x10001 0x10002 0x18>,
> > +                                        <0x10009 0x10009 0x18>,
> > +                                        <0x10011 0x10011 0x18>,
> > +                                        <0x10019 0x10019 0x18>,
> > +                                        <0x10021 0x10021 0x18>;
> > +          riscv,raw-event-to-mhpmcounters =3D <0x0 0x0 0xffffffff 0xfc=
0000ff 0x18>,
> > +                                            <0x0 0x1 0xffffffff 0xfff8=
00ff 0x18>,
> > +                                            <0x0 0x2 0xffffffff 0xffff=
e0ff 0x18>;
> > +    };
> > --=20
> > 2.39.0
> >
>=20
> Besides the comment above,
>=20
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>=20
> Thanks,
> drew
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--vAoaG+B+xOqDz4RP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7vpvgAKCRB4tDGHoIJi
0mJQAQC0C3OE0oXcUqTqKzETetX0/hq8y9uPtDrjwh2pjLVHkQD/b7o+CjFxzeep
afN60naiwIkPxXxxAPCtY7PBfoUkQAU=
=iqPr
-----END PGP SIGNATURE-----

--vAoaG+B+xOqDz4RP--
