Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ECB656E93
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 21:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiL0USL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiL0USI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 15:18:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D8C32A;
        Tue, 27 Dec 2022 12:18:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA600B80E8C;
        Tue, 27 Dec 2022 20:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C94C433F0;
        Tue, 27 Dec 2022 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672172284;
        bh=pGyop+au4H0+njiVOEW2/kj4Vbw3nAC02Ud1MQ63UV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZRPi8qOmGpu4gfjpUCgnn62d/mEt/wHTIFJLfNh4JDwfDKZ0XuR4pHdLdHqVyO+K
         /oIs08WIGr8LR6twoSi+k+Da6NWKQqYH9lEaIhbyaQeyVFc6zwLpr8aYnEYvIMHfC5
         VHLhrsVA5R5TbL+eTD1xvhL1n0HdZOBDM5wFb+KJ6LluBRjskvCPpVKtaE8Vnj4buD
         oNEw8d9qCDIu0ontvs8w1Q6FKvrhOQCK18cBOSlnawTWwjT9ipkJlUD0aSfhLVuuWX
         +w//QvQSriaYt7t9/24FI9UFjjRUERS7BO12XLnM9f9ZS0kOXFGuxYkZgRWMUOyQpQ
         I72m0N7c8Jj1w==
Date:   Tue, 27 Dec 2022 20:17:59 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, atishp@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        will@kernel.org, mark.rutland@arm.com, opensbi@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y6tS959TaY2EBAdn@spud>
References: <20221227194056.3891216-1-conor@kernel.org>
 <8bbe4e7b-ae35-ab68-bb0b-72c201ea1256@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eIOXp9yigPnMrT0e"
Content-Disposition: inline
In-Reply-To: <8bbe4e7b-ae35-ab68-bb0b-72c201ea1256@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eIOXp9yigPnMrT0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 27, 2022 at 02:05:01PM -0600, Samuel Holland wrote:
> Hi Conor,
>=20
> On 12/27/22 13:40, Conor Dooley wrote:
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

> > +  riscv,event-to-mhpmevent:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents an ONE-to-ONE mapping between a PMU event and the eve=
nt
> > +      selector value that platform expects to be written to the MHPMEV=
ENTx CSR
> > +      for that event.
> > +      The mapping is encoded in an matrix format where each element re=
presents
> > +      an event.
> > +      This property shouldn't encode any raw hardware event.
> > +    items:
> > +      - description: event idx
>=20
> It might be good to clarify that this refers specifically to "event_idx"
> from the SBI specification.
>=20
> > +      - description: upper 32 bits of the event selector value for MHP=
MEVENTx
> > +      - description: lower 32 bits of the event selector value for MHP=
MEVENTx
>=20
> Since you are describing the the columns of the matrix here, I believe
> these entries need to go under two levels of "items:". The same applies
> for the other properties.
>=20
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
> > +      - description: upper 32 bits of the pmu event id
> > +      - description: lower 32 bits of the pmu event id
>=20
> These two cells represent the start and end of a range of 32-bit values
> (again the "event_idx" from the SBI specification), not 32-bit
> components of a 64-bit value.

I think this one is me struggling to understand the markdown description
of the binding. Thanks for explaining!

I'll sort the lot out for v3 in a few days.

Thanks,
Conor.


--eIOXp9yigPnMrT0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6tS9wAKCRB4tDGHoIJi
0sobAQDjWQob/opNqA920t7VrsXFJGE09T9GqC35jEjYCfZYsgD/aTGKWWYqH3b7
EBoFrwJVFhonxS+5Rg28In6ObBYTSww=
=/2gu
-----END PGP SIGNATURE-----

--eIOXp9yigPnMrT0e--
