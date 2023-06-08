Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E60172888A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjFHTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFHTau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:30:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D82D55;
        Thu,  8 Jun 2023 12:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3F3650BB;
        Thu,  8 Jun 2023 19:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC148C4339B;
        Thu,  8 Jun 2023 19:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686252634;
        bh=Sn9hAi2Kyf0okzCneZ3amJPSCNVbUHG48YWRl4CGl/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lfdr8/t7jAH4glSpjV2KYZiJ23pFC02NUTTTkCYlLGOvVOrmDCcRICN1I7ckFGeAQ
         TPGCO5Yx6pvnH5XLP1XTniYRePwwraYyUDpYJqCXzS6uNl5YuDSEtEqzaa6vast+yd
         AMjS+CzLVMzQGuWTQNRSM0Ufd/re+R18iMYOl+Biy/Afeke4T74nR7ID5P7Lx82b2L
         1/KMCBpD/NbyjEYVOdgT3myEqZ9cUkkHXTTjYCo/FHA0ZWQmct3tB4tNdElz8hzlKD
         dMXMAC24mzOI1YV/emxTct+WnhjV22drqsWa8YBbOCsThta5By4dLh6opE8JHBZsev
         ojK/xAa+VBS6A==
Date:   Thu, 8 Jun 2023 20:30:28 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230608-cobbler-giving-e0fac2185e11@spud>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud>
 <20230530-duller-reset-a34ae111f207@wendy>
 <20230608191537.GA3233857-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J8Z0GTvlCQGm2lQj"
Content-Disposition: inline
In-Reply-To: <20230608191537.GA3233857-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J8Z0GTvlCQGm2lQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 01:15:37PM -0600, Rob Herring wrote:
> On Tue, May 30, 2023 at 03:12:12PM +0100, Conor Dooley wrote:
> > On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> > > On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:
> >=20
> > > >=20
> > > > Why not just have something like
> > > >=20
> > > > mycpu {
> > > > 	...
> > > > 	riscv,isa {
> > > > 		i;
> > > > 		m;
> > > > 		a;
> > > > 		zicsr;
> > > > 		...
>=20
> I prefer property names be globally unique. The tools are geared towards=
=20
> that too. That's largely a symptom of having 0 type information in the=20
> DT.
>=20
> For example if you had an extension called 'reg', it would be a problem.

Per the current ISA rules, that'd not be valid. But then again, I do
have trust issues & it's not like "reg" is the only property name in DT
land.

> > > Naming of the node aside (perhaps that could be riscv,isa-extensions)
> > > there's not something hitting me immediately as to why that is a no-n=
o.
> > > If the size is a concern, this would certainly be more efficient & not
> > > like the probing would be anything other than trivial more difficult
> > > what I have in my proposal.
> >=20
> > Having started messing around with this, one of the main advantages, to
> > me, of this approach is proper validation.
> > cpus.yaml has additionalProperties: true in it, which would have had to
> > be sorted out, or worked around, but creating a child-node with the
> > properties in it allows setting additionalProperties: false.
>=20
> That's an issue on my radar to fix. I started that for the Arm cpus.yaml=
=20
> a while back. Sadly it involves adding all the misc properties vendors=20
> added. It's not a lot, but still better to get in front of that for=20
> Risc-V.

Yeah, guess I can append that to my todo list.

> > > Rob's AFK at the moment, and I was hoping that he would take a look at
> > > the idea, so I won't respin til he is back, but I'll give this a go in
> > > the interim.
> >=20
> > Mechanically, the conversion of the patch isn't difficult, but I'll sti=
ll
> > wait for Rob to come back before sending a v2. But that v2 will more
> > than likely implement your suggestion.
>=20
> I haven't read the whole thread, but the initial proposal looks okay to=
=20
> me.
>=20
> Another way you could do this is a list of strings:
>=20
> riscv,isa-ext =3D "i", "m", "zicsr";
>=20
> I think we have a helper to test is a string in the list.

Perhaps I should've waited a bit longer than a month for a v2 - I sent
one this afternoon doing what Sean suggested:
https://lore.kernel.org/all/20230608-sitting-bath-31eddc03c5a5@spud/

I'll do some poking at the strings and see what I think of it.

Cheers,
Conor.

--J8Z0GTvlCQGm2lQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIIsVAAKCRB4tDGHoIJi
0g5YAQC9F/U/qWJxcOhejKFcF7fDmwOe+gCq0sgnacuq/Vu+ZAEAwAZ9EAwNs4oF
aCnC2JOfp//gPzZTwmsYjjFeeLhAkwA=
=KmSP
-----END PGP SIGNATURE-----

--J8Z0GTvlCQGm2lQj--
