Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F969654705
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiLVUQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLVUQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:16:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97548FD3D;
        Thu, 22 Dec 2022 12:16:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2259261D05;
        Thu, 22 Dec 2022 20:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17392C433D2;
        Thu, 22 Dec 2022 20:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671740181;
        bh=DMHA3b3oHIoMzIjLooyiE/VarbkUBMVQxKioBAYS5mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nySFoWQrub2dY++C8/ToiEIR1HqSq6F5Geiaa4u5Scj+P+jEi10a21cF7Mb1wZpXZ
         RtVCZKgWak25BFC0ZGHtNzeNh32pb0pIxE9msHl1ufADSSej13HYGO8K8jLHrsZQyI
         fyssER6r1dHTpyuQFCUfQRCJ8dcgU7pYwx+aG05OkJLNPHy/m57xMW597IdXx4nNAQ
         ptIPs18Uqifua37kpXIuwUWBTAE259+AerS/kkQ6qZbd3otaD0JHwkGed2UJ8dXLXh
         NQLozAQRbxr3lfA2fSBXTjhmZA2Evb8arl5+VIZdzmQ13s5AUlD27t0y0U2VbLMRBA
         nZ2fJ5ZtAT4+g==
Date:   Thu, 22 Dec 2022 20:16:16 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     Rob Herring <robh@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        opensbi@lists.infradead.org
Subject: Re: [PATCH v1] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y6S7ENNXQe42ymTz@spud>
References: <20221221141548.274408-1-conor@kernel.org>
 <20221222180627.GA1748427-robh@kernel.org>
 <Y6SuyiYC/oLB2VzL@spud>
 <CAHBxVyEZJeH6H00Jdcm2_=z-D2kYxVTgagYhmLoyJ2CPqcFbgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z4/XEoq9i0wqaR4N"
Content-Disposition: inline
In-Reply-To: <CAHBxVyEZJeH6H00Jdcm2_=z-D2kYxVTgagYhmLoyJ2CPqcFbgg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z4/XEoq9i0wqaR4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 22, 2022 at 11:55:29AM -0800, Atish Kumar Patra wrote:
> On Thu, Dec 22, 2022 at 11:24 AM Conor Dooley <conor@kernel.org> wrote:
> > On Thu, Dec 22, 2022 at 12:06:27PM -0600, Rob Herring wrote:
> > > On Wed, Dec 21, 2022 at 02:15:49PM +0000, Conor Dooley wrote:
> > > > From: Conor Dooley <conor.dooley@microchip.com>
> > > >
> > > > The SBI PMU extension requires a firmware to be aware of the event =
to
> > > > counter/mhpmevent mappings supported by the hardware. OpenSBI may u=
se
> > > > DeviceTree to describe the PMU mappings. This binding is currently
> > > > described in markdown in OpenSBI (since v1.0 in Dec 2021) & used by=
 QEMU
> > > > since v7.2.0.
> > > >
> > > > Import the binding for use while validating dtb dumps from QEMU and
> > > > upcoming hardware (eg JH7110 SoC) that will make use of the event
> > > > mapping.
> > > >
> > > > Link: https://github.com/riscv-software-src/opensbi/blob/master/doc=
s/pmu_support.md
> > > > Co-developed-by: Atish Patra <atishp@rivosinc.com>
> > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > > > +description: |
> > > > +  SBI PMU extension supports allow supervisor software to configur=
e, start &
> > > > +  stop any performance counter at anytime. Thus, a user can levera=
ge full
> > > > +  capability of performance analysis tools such as perf if the SBI=
 PMU
> > > > +  extension is enabled. The OpenSBI implementation makes the follo=
wing
> > > > +  assumptions about the hardware platform:
> > > > +    MCOUNTINHIBIT CSR must be implemented in the hardware. Otherwi=
se, the SBI
> > > > +    PMU extension will not be enabled.
> > > > +
>=20
> This is no longer true since OpenSBI commit b28f070. We should remove
> this from OpenSBI docs as well.

Since you know the detail of it, I volunteer you for that one ;)

> > > > +    The platform must provide information about PMU event to count=
er mapping
> > > > +    via device tree or platform specific hooks. Otherwise, the SBI=
 PMU
> > > > +    extension will not be enabled.
> > > > +
> > > > +    The platforms should provide information about the PMU event s=
elector
> > > > +    values that should be encoded in the expected value of MHPMEVE=
NTx while
> > > > +    configuring MHPMCOUNTERx for that specific event. This can be =
done via a
> > > > +    device tree or platform specific hooks. The exact value to be =
written to
> > > > +    the MHPMEVENTx is completely dependent on the platform. The ge=
neric
> > > > +    platform writes the zero-extended event_idx as the expected va=
lue for
> > > > +    hardware cache/generic events as suggested by the SBI specific=
ation.
> > > > +
>=20
> But the larger question is these are OpenSBI implementation specific
> assumptions. Should it be included in
> the DT binding?

Probably not. I'll drop it for v2.

> > > > +properties:
> > > > +  compatible:
> > > > +    const: riscv,pmu
> > > > +
> > > > +  riscv,event-to-mhpmevent:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > +    description:
> > > > +      Represents an ONE-to-ONE mapping between a PMU event and the=
 event
> > > > +      selector value that platform expects to be written to the MH=
PMEVENTx CSR
> > > > +      for that event.
> > > > +      The mapping is encoded in an array format where each row rep=
resents an
> > >
> > > s/array/matrix/
> > >
> > > > +      event. The first element represents the event idx while the =
second &
> > > > +      third elements represent the event selector value that shoul=
d be encoded
> > > > +      in the expected value to be written in MHPMEVENTx.
> > > > +      This property shouldn't encode any raw hardware event.
> > > > +    minItems: 1
> > > > +    maxItems: 255
> >
> > I copied these 255s from dt-schema somewhere as a sane max.
> > Atish, is there a cap here or should we allow as many as someone likes?
> > The md binding doesn't mention any limits - is it in the SBI spec?
> > The strongest wording I saw there was "limited" & event idx is 20 bits
> > wide as per the spec [0]. Does that make 2^20 the hard limit here?
> >
>=20
> This is for hardware & cache events. The total number of events
> defined there are 52 (10 HW + 42 Cache) events.
> So 255 is a sane max that provides enough room for expansion in future
> if required.

WFM.

> > > > +  riscv,raw-event-to-mhpmcounters:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > > > +    description:
> > > > +      Represents an ONE-to-MANY or MANY-to-MANY mapping between th=
e rawevent(s)
> > > > +      and all the MHPMCOUNTERx in a bitmap format that can be used=
 to monitor
> > > > +      that raw event.
> > > > +      The encoding of the raw events are platform specific. The in=
formation is
> > > > +      encoded in an array format where each row represents the spe=
cific raw
> > > > +      event(s). The first element is a 64-bit match value where th=
e invariant
> > > > +      bits of range of events are set. The second element is a 64-=
bit mask that
> > > > +      will have all the variant bits of the range of events cleare=
d. All other
> > > > +      bits should be set in the mask. The third element is a 32-bi=
t value to
> > > > +      represent bitmap of all MHPMCOUNTERx that can monitor these =
set of
> > > > +      event(s). If a platform directly encodes each raw PMU event =
as a unique
> > > > +      ID, the value of select_mask must be 0xffffffff_ffffffff.
> > > > +    minItems: 1
> > > > +    maxItems: 255
> > > > +    items:
> > > > +      $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +      maxItems: 5
> > > > +
> > > > +required:
> > > > +  - compatible
> > >
> > > I assume at least one of the other properties must be present?
> >
> > Atish: (and +CC the OpenSBI list)
> > Which properties are actually needed here? Or are any? The md binding
> > in the OpenSBI sources doesn't seem to require anything other than the
> > compatible?
> >
>=20
> That's true. Opensbi allows the platform to define functions
> to provide the mapping. Now that's an OpenSBI implementation thing.
> Other implementations may choose to use it differently.

In the case where the platform can define functions, the "bare" node
with just the compatible is still required though in that case, right?

Thanks,
Conor.


--Z4/XEoq9i0wqaR4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6S7EAAKCRB4tDGHoIJi
0g2vAP9nEuTCVUKqyW74owqbj8+OZMHQcIeLAXuvNmpN4MR1cQD/Tq/Bn3SqRxBH
OkW3HsXxbS3jEy6nw0LmAuq+6i5lKg4=
=4o47
-----END PGP SIGNATURE-----

--Z4/XEoq9i0wqaR4N--
