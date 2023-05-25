Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10271139B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjEYSWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYSWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAEBB
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:22:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3C63CC4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83883C433D2;
        Thu, 25 May 2023 18:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685038940;
        bh=loWNWycyYK+0wW4ntNW0qoiBqz8/awi8rASYBr/SyRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CWzOvvXkz4eevP2GS6C4ohntbQIDR5A936MQqHNqnX0p5sKdrvdG/02dmD1blrUu+
         fmNE1iireJ1VVKxys3crHnjh2hk6dOQ7Y0PjHZXfHSlIIBau/8gCIIEKbHw1AS4wAm
         wJiWFONlvmiu2krivHTiB102vMzLsbm/Q03Nl8VvqYTTxMloEJRieGDf0PKtk+6M9W
         D4aSSdJmh0evgVpliXsbn5XWheg0/Gw+mqLzO7pJTKkXVJruJZhLS0QtFkV35hlaGW
         XwtKR3PgiNdZe1LVHVCcaGjys1ZKgT7Khk3+K3Fr1zDXcBb7pLL0Gn2/Yd1uQ+V4g/
         e06rG63rzGY9Q==
Date:   Thu, 25 May 2023 19:22:15 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-flaring-trading-f2bf0713ae26@spud>
References: <CAK9=C2X1BjZCHfYM33pZQtavu7yRqxwsypWL5OWj79bJrnDMQg@mail.gmail.com>
 <CAOnJCULpa-TJuG=TtCDOxOdUviZzWheLE-GMiU1r7GWaKn0nuQ@mail.gmail.com>
 <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy>
 <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy>
 <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7vr/djQpNP/RG/o+"
Content-Disposition: inline
In-Reply-To: <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7vr/djQpNP/RG/o+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Atish,

On Thu, May 25, 2023 at 10:39:44AM -0700, Atish Patra wrote:
> > How about the below?

> Instead of disabling hibernate support why not revert the patch
> 3335068 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> which doesn't add any "measured" value at this point.
> However, keeping the hibernation feature on and disabling linear
> mapping will get more testing on hibernation.
> While disabling hibernation and keeping the above patch which
> doesn't have any value at all.
>=20
> We don't have a regression at this point. So either approach will work th=
ough.

I favoured this approach so that we do not release a kernel in which
hibernate works for these versions of OpenSBI and then stops working in
the future when we shore up how communicating this is supposed to work.
It allows us to fix the problem "properly" in slow-time, instead of
racing against v6.4's release.

I happened to be talking to Palmer and he suggested making it depend on
NONPORTABLE:
|> config NONPORTABLE
|> 	bool "Allow configurations that result in non-portable kernels"
|> 	help
|> 	  RISC-V kernel binaries are compatible between all known systems
|> 	  whenever possible, but there are some use cases that can only be
|> 	  satisfied by configurations that result in kernel binaries that are
|> 	  not portable between systems.
|>=20
|> 	  Selecting N does not guarantee kernels will be portable to all known
|> 	  systems.  Selecting any of the options guarded by NONPORTABLE will
|> 	  result in kernel binaries that are unlikely to be portable between
|> 	  systems.
|>=20
|> 	  If unsure, say N.

I actually think that that makes more sense, as it may actually be fine
to use hibernation depending on what your SBI implementation does.

> If we choose to go this route, some thoughts about the commit message.
> > -- >8 --
> > From 1d4381290a1600eff9b29b8ace6be73955d9726c Mon Sep 17 00:00:00 2001
> > From: Conor Dooley <conor.dooley@microchip.com>
> > Date: Thu, 25 May 2023 15:09:08 +0100
> > Subject: [PATCH] RISC-V: mark hibernation as broken
> >
> > Hibernation support depends on firmware marking its reserved
> > regions as not mappable by Linux. As things stand, the de-facto SBI
>=20
> either not mappable or no save/restore capable (as We still have not
> concluded which way we want to go in)

s/mappable/accessible/? Sounds like a good catch all?

>=20
> > implementation (OpenSBI) does not do this, and other implementations may
> > not do so either, resulting in kernel panics during hibernation ([1],
> > [2]).
> >
>=20
> we should probably add more context in the commit message.
> How about adding something along these lines:
>=20
> As things stand, the latest version of de-facto SBI
> implementation(OpenSBI) doesn't
> do this any more to allow 1G huge page mappings by kernel. Other SBI
> implementations are probably
> doing the same. Until the commit 3335068 ("riscv: Use PUD/P4D/PGD
> pages for the linear mapping"),
> the first 2MB region of DRAM (where the typically firmware resides)
> was not mappable by kernel. However,
> enabling that mapping resulted in the kernel panics during hibernation
> ([1], [2]) as the hibernation process
> tries to save/restore any mapped region even though it is marked as reser=
ved.

SGTM, I could go with that.

> > Disable support for hibernation until such time that an SBI
> > implementation independent way to communicate what regions are reserved
> > has been agreed upon.
> >
>=20
> Anybody who wants to test the hibernation feature must revert the
> above mentioned patch along with turning on
> the config.

This goes away with the use of non-portable, although I would work
mention of the config option into the commit message.

Thanks,
Conor.

> > Reported-by: Song Shuai <suagrfillet@gmail.com>
> > Link: https://lore.kernel.org/all/CAAYs2=3DgQvkhTeioMmqRDVGjdtNF_vhB+vm=
_1dHJxPNi75YDQ_Q@mail.gmail.com/ [1]
> > Reported-by: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Link: https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ITXwaKfA6=
z8
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 13f058490608..b2495192f35a 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -801,7 +801,7 @@ menu "Power management options"
> >  source "kernel/power/Kconfig"
> >
> >  config ARCH_HIBERNATION_POSSIBLE
> > -       def_bool y
> > +       def_bool n
> >
> >  config ARCH_HIBERNATION_HEADER
> >         def_bool HIBERNATION


--7vr/djQpNP/RG/o+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+nVgAKCRB4tDGHoIJi
0vZ3AQCt83AEx+FXUff3m49musNTrQ4uxugH9QeO7i8ot2t0oAD9GOY4lL+OQZFV
flHzYz1g4OSLg6gvr6j2j8AB4kn6Uwg=
=8S63
-----END PGP SIGNATURE-----

--7vr/djQpNP/RG/o+--
