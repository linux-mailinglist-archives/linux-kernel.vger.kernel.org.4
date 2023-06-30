Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3842774416E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjF3RkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjF3RkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD4199B;
        Fri, 30 Jun 2023 10:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E627617C5;
        Fri, 30 Jun 2023 17:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0773DC433C8;
        Fri, 30 Jun 2023 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688146808;
        bh=fgMw4Lp/89gtsazSrFpFs6t2HizOmMl025qH0SfI+3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oDtJjJBwaYpzniZn58CZW7gfEA4yVbEcCAXoEczsJPipXrnCHZ/iEoIIhJRJYioYv
         Mv2s6ZaJrq2alFzZ9QMF7xRvC2J/KZ4N5vqOuJuTcUOk96GLXw22Iv6zGcgKDCgYqX
         V80VgNhFGWPJ6vwAAjUTdGLfDAjH7hNJznbG34XtJ1kOg4ICngoslMBuKtd5J/YFfa
         BGP3LcMb+IgmCJWvwjW0Ieaxqb8do132PC9BUM+P7c7WQsiztb4omluj4SOinSJowB
         KHP4TbIZDXj2u4cLH7wIBI2dZF1Bgvb0SrMmIfgBOiWd966YnXzHvnrjhk2MJRnMqd
         O2wfBYO8bgLLQ==
Date:   Fri, 30 Jun 2023 18:40:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Stefan O'Rear <sorear@fastmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        Oleksii <oleksii.kurochko@gmail.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v3] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230630-scheming-hurry-947c54f131a5@spud>
References: <20230626-unmarked-atom-70b4d624a386@wendy>
 <a6449161-d800-4094-bf15-cde890ed17b5@app.fastmail.com>
 <CAOnJCULs47ZCai5EOQJPFrgV1-2xPjWAOB2CfUDStcigsR5Wew@mail.gmail.com>
 <20230627-harmonize-monastery-c6b40d2e5556@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AjUvKUIkfgdr2+xV"
Content-Disposition: inline
In-Reply-To: <20230627-harmonize-monastery-c6b40d2e5556@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AjUvKUIkfgdr2+xV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Been implementing feedback, so going back through this

On Tue, Jun 27, 2023 at 12:30:25PM +0100, Conor Dooley wrote:
> On Mon, Jun 26, 2023 at 11:35:10PM -0700, Atish Patra wrote:
> > On Mon, Jun 26, 2023 at 5:40=E2=80=AFPM Stefan O'Rear <sorear@fastmail.=
com> wrote:
> > > On Mon, Jun 26, 2023, at 6:10 AM, Conor Dooley wrote:
>=20
> > > > Off-list, some of the RVI folks have committed to shoring up the wo=
rding
> > > > in either the ISA specifications, the riscv-isa-manual or
> > > > so that in the future, modifications to and additions or removals of
> > > > features will require a new extension. Codifying that assertion
> > > > somewhere would make it quite unlikely that compatibility would be
> > > > broken, but we have the tools required to deal with it, if & when it
> > > > crops up.
> > > > It is in our collective interest, as consumers of extension meaning=
s, to
> > > > define a scheme that enforces compatibility.
> > > >
> > > > The use of individual properties, rather than elements in a single
> > >
> > > no longer individual properties
> > >
> > > > string, will also permit validation that the properties have a mean=
ing,
> > > > as well as potentially reject mutually exclusive combinations, or
> > > > enforce dependencies between extensions. That would not have be pos=
sible
> > >
> > > Under what circumstances is a device tree which declares support for a
> > > superset extension (e.g. m) required to also declare support for its =
subsets
> > > (e.g. zmmul)?  There are compatibility issues in both directions.
> > >
> > > Proposal: If an extension X is a superset of an extension Y and X is =
present
> > > in riscv,isa-extensions, Y must also be present if Y was ratified or =
added
> > > to the schema before X, but need not also be present if Y was ratifie=
d after
> > > or at the same time as X.  If X "depends on" Y, then Y must be presen=
t in
> > > riscv,isa-extensions even if X and Y were ratified at the same time.
>=20
> Yes, I think that this all makes sense from a compatibility point of
> view. Splitting it up:
>=20
> > > If an extension X is a superset of an extension Y and X is present
> > > in riscv,isa-extensions, Y must also be present if Y was ratified or =
added
> > > to the schema before X
>=20
> This makes total sense from a "being nice to" software point of view.
>=20
> > > but need not also be present if Y was ratified after
> > > or at the same time as X.
>=20
> It may make sense to reduce this to only after, or not permit the
> supersets at all where they are ratified alongside their subsets.
> Cross that bridge when we come to it perhaps.

I ending up doing some proof of concept implementation of this for linux
the other day, I think "at or at the same time" is the way to go. Up to
me to enforce while reviewing binding patches I guess!

> > > If X "depends on" Y, then Y must be present in
> > > riscv,isa-extensions even if X and Y were ratified at the same tim
>=20
> For Linux, this is already the case for F & D. I think that's a good
> policy to follow.

> > > > +        - const: i
> > > > +          description: |
> > > > +            The base integer instruction set, as ratified in the
> > > > 20191213
> > > > +            version of the unprivileged ISA specification, with the
> > > > exception of
> > > > +            counter access.
> > > > +            Counter access was removed after the ratification of t=
he
> > > > 20191213
> > > > +            version of the unprivileged specification and shunted =
into
> > > > the
> > > > +            Zicntr and Zihpm extensions.
> > >
> > > I think this may belong in the description of zicsr?  rdcycle in 2019=
1213
> > > is a special case of csrrs, which is in zicsr not the base.
>=20
> Sorry, this is a bit unclear. Do you mean that the sentence you have
> provided here should be in the Zicsr entry?

I went and checked this, rdcycle appears in chapter 10 "Counters", not
chapter 9 "Zicsr". I'll slightly reword it & put it in both sections
since the specs are (IMO) unclear in this regard.

Cheers,
Conor.

--AjUvKUIkfgdr2+xV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ8TcgAKCRB4tDGHoIJi
0kfhAP9LUTyxG2UPb9njPjY61mUQw7bCuGAoavL5xUWQbnhDFQEAsxfEEvEMtCk4
UEUiLHTChRa5oy2pr1vS8chP0tO/Sw0=
=VCpO
-----END PGP SIGNATURE-----

--AjUvKUIkfgdr2+xV--
