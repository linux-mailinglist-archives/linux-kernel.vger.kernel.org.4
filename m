Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4A661A10
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236163AbjAHVe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjAHVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:34:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB01BE2C;
        Sun,  8 Jan 2023 13:34:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26FE460DBD;
        Sun,  8 Jan 2023 21:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71A9C433EF;
        Sun,  8 Jan 2023 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673213693;
        bh=0wHJQPN/hpr3Vl9aQTSQEIJxwRCq7DQjAoDMixc2BhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkDJ3Y7GJAmzlskWWhUBfZLdMQnBuJNnw6zC52Zwp5N5lUWJWY/Z892uu6JgFYxFP
         iWCfoQcUsmf8gXDGEZh+/ddmTDHNMmgUlr63Ba9LiQ/8Ve6W93i3+r4TeXWFAacDiF
         4jT7xCHOl6W+mfcN/Lt9fSJ8pMULo/WIFNnRR3hp4cUYGEb1Iau9z/oHPwCh41prBE
         ORaJeDwKl/5QWw7DsZlh0YGKivaW+LtLjPbadmLBGgOxp4J2oifCt2THRmbF0ItlRg
         Nw2moygITtrPd8jHR8hm3/jl8s/gD4ihclW21bpqZ0WYZYy0GDIwIMuT/RQ2R/XBQf
         27zVh5jwSpGMg==
Date:   Sun, 8 Jan 2023 21:34:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, atishp@rivosinc.com,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, apatel@ventanamicro.com,
        will@kernel.org, mark.rutland@arm.com, opensbi@lists.infradead.org,
        samuel@sholland.org
Subject: Re: [PATCH v3] dt-bindings: riscv: add SBI PMU event mappings
Message-ID: <Y7s2+McYXLeEMNck@spud>
References: <20230102165551.1564960-1-conor@kernel.org>
 <20230103092816.w6hknvd4caeahdo4@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XO6L+Ie2KiC/ogDG"
Content-Disposition: inline
In-Reply-To: <20230103092816.w6hknvd4caeahdo4@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XO6L+Ie2KiC/ogDG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Drew, Atish,

Mainly just a question about the OpenSBI doc at the end. Gonna fix up
the rest of the wording and resend in a few.

On Tue, Jan 03, 2023 at 10:28:16AM +0100, Andrew Jones wrote:
> On Mon, Jan 02, 2023 at 04:55:51PM +0000, Conor Dooley wrote:
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

> > +  riscv,event-to-mhpmevent:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    description:
> > +      Represents an ONE-to-ONE mapping between a PMU event and the eve=
nt
> > +      selector value that platform expects to be written to the MHPMEV=
ENTx CSR
>                             ^ the

I think this one is arguable, it makes sense both ways IMO. I don't care
since it's not my prose though ;)

> > +      for that event.
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
>=20
> > +     * codes, U74 uses a bitfield for events encoding, so several U74 =
events
> > +     * can be bound to single perf id.
>                                 ^ a   ID
>=20
> > +     * See SBI PMU hardware id's in OpenSBI's include/sbi/sbi_ecall_in=
terface.h
>=20
> IDs

Most of this stuff comes directly from the doc in OpenSBI that I
copy-pasted. Atish, what do you wanna do once the binding is upstream
about the original doc?

Thanks,
Conor.


--XO6L+Ie2KiC/ogDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY7s2+AAKCRB4tDGHoIJi
0pu6AP9wCOtE0JPf/jDtqIJnKHi2n73OeKq0MkwLM5SU5/sZ5gD/W9s+CxpmmBc+
5BcwhD+MSLvsGf9pbk7f7Mrs6k3iYwQ=
=eD0/
-----END PGP SIGNATURE-----

--XO6L+Ie2KiC/ogDG--
