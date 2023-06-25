Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B2773D505
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFYWPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5B1A5;
        Sun, 25 Jun 2023 15:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E425A60C36;
        Sun, 25 Jun 2023 22:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB72C433C8;
        Sun, 25 Jun 2023 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687731321;
        bh=zFVqf7YtgUM3F6YoG2jfwFRTpf8aCuPZPnbOJyql7oI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQWu/HyKwTHQmtgf357NogYhBahDyKX/1Jq6bAgM+m5Zo0iIokkBH1XRXky1qGyTg
         uhh/B3cij7HKHv6wOBpA1EIG7B7lJOwbtcF9DL+wB1dGlsyY0Y4KH2k3FMhDsD0Zdp
         Pn8HmbNqw7tdCXJwlcpp8V93ig8iSQeuR+sLgGmvggdJin3HEI7nGX87enlMtneFYB
         y/G6dMiGUgR+ur1R/E3W2GNtynrPGKnRxw2vgUCI3Wd2hQEH4nr9MThyP3fkw7MTL3
         JSDxPlPcZr0FbpqthgqTPF0Scgq6omh6MWCAAVAQHMXae1H0A3BM9QG37PlVjR9k8p
         KNqe3j4L3WizQ==
Date:   Sun, 25 Jun 2023 23:15:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org, frowand.list@gmail.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com,
        mpe@ellerman.id.au, arnd@arndb.de, rppt@kernel.org,
        samuel@sholland.org, panqinglin2020@iscas.ac.cn,
        conor.dooley@microchip.com, anup@brainfault.org,
        xianting.tian@linux.alibaba.com, anshuman.khandual@arm.com,
        heiko@sntech.de, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V1 1/3] Revert "RISC-V: mark hibernation as nonportable"
Message-ID: <20230625-obstinate-grimy-b765a1d3d741@spud>
References: <20230625140931.1266216-1-songshuaishuai@tinylab.org>
 <20230625140931.1266216-2-songshuaishuai@tinylab.org>
 <20230625-multiple-diaper-1db88a75314e@spud>
 <20281f01-2cc9-892e-beea-eb2bb91e3ca5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6ZfynoZLMeCQs+ZJ"
Content-Disposition: inline
In-Reply-To: <20281f01-2cc9-892e-beea-eb2bb91e3ca5@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6ZfynoZLMeCQs+ZJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Sun, Jun 25, 2023 at 11:09:21PM +0800, Song Shuai wrote:

> Sorry for the delayed reply,

It wasn't really delayed at all actually, you replied within an hour or
so, AFAICT.

> My tinylab email went something wrong, I'll use gmail in this thread.
>=20
> =E5=9C=A8 2023/6/25 22:18, Conor Dooley =E5=86=99=E9=81=93:
> > On Sun, Jun 25, 2023 at 10:09:29PM +0800, Song Shuai wrote:
> > > This reverts commit ed309ce522185583b163bd0c74f0d9f299fe1826.
> > >=20
> > > With the commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the
> > > linear mapping") reverted, the MIN_MEMBLOCK_ADDR points the kernel
> > > load address which was placed at a PMD boundary.
> >=20
> > > And firmware always
> > > correctly mark resident memory, or memory protected with PMP as
> > > per the devicetree specification and/or the UEFI specification.
> >=20
> > But this is not true? The versions of OpenSBI that you mention in your
> > cover letter do not do this.
> > Please explain.
> >=20
>=20
> At this time, OpenSbi [v0.8,v1.3) and edk2(RiscVVirt) indeed don't obey t=
he
> DT/UEFI spec. This statement is excerpted from "Reserved memory for resid=
ent
> firmware" part from the upcoming riscv/boot.rst. It isn't accurate for no=
w.
> How about deleting this one?

It is incorrect, so it will need to be removed, yes.
Unfortunately writing a doc does not fix the existing implementations :(

> Actually with 3335068f8721 reverted, the change of MIN_MEMBLOCK_ADDR can
> avoid the mapping of firmware memory, I will make it clear in the next
> version.

To be honest, I'd like to see this revert as the final commit in a
series that deals with the problem by actually reserving the regions,
rather than a set of reverts that go back to how we were.
I was hoping that someone who cares about hibernation support would be
interested in working on that - *cough* starfive *cough*, although maybe
they just fixed their OpenSBI and moved on.
If there were no volunteers, my intention was to add a firmware erratum
that would probe the SBI implementation & version IDs, and add a firmware
erratum that'd parse the DT for the offending regions and reserve them.

Cheers,
Conor.

> > > So those regions will not be mapped in the linear mapping and they
> > > can be safely saved/restored by hibernation.
> > >=20
> > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> > > ---
> > >   arch/riscv/Kconfig | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 5966ad97c30c..17b5fc7f54d4 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -800,11 +800,8 @@ menu "Power management options"
> > >   source "kernel/power/Kconfig"
> > > -# Hibernation is only possible on systems where the SBI implementati=
on has
> > > -# marked its reserved memory as not accessible from, or does not run
> > > -# from the same memory as, Linux
> > >   config ARCH_HIBERNATION_POSSIBLE
> > > -	def_bool NONPORTABLE
> > > +	def_bool y
> > >   config ARCH_HIBERNATION_HEADER
> > >   	def_bool HIBERNATION
> > > --=20
> > > 2.20.1
>

--6ZfynoZLMeCQs+ZJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJi8cgAKCRB4tDGHoIJi
0gQGAP4zFRf+mJ/qW1QVdbXhgxrDoXAjwnQiAGH8Qr85iJdixAEAoUq/DIivnRJ8
mJWf9t+LoW93pFfGCZD7UXny7Skemgg=
=Ztmn
-----END PGP SIGNATURE-----

--6ZfynoZLMeCQs+ZJ--
