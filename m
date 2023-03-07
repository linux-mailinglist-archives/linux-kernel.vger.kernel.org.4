Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC146AF2F6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 19:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjCGS55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 13:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbjCGS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 13:57:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DCBB6D36;
        Tue,  7 Mar 2023 10:45:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F68AB819CB;
        Tue,  7 Mar 2023 18:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2A7C433D2;
        Tue,  7 Mar 2023 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678214681;
        bh=98GSn9Nd5lbsZB8GQDRpBCln3pvxy2GNE1Kh/iUgG4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ci9N7xCRe3wAWKGx/fHN59ZdShHG3aGjM0ECdLco4W7QTTaolajEJDHRwxvUfIbl2
         JEdttpeYOYKITpWFhrQ8yqGYNxjMeIspbBV7yKxPZAQK3I5HeeJEKokX3QBFsITDmW
         9V8fMq3OnQktdbltjtKV1bfjg11yg2ZQvNHVgB9RuKE1fSY7Orgz/DmJeDCIadnSAi
         Rrp5S+qhFFAb7qkLDwhwzqdlBSZHO5aIyprEzfJ3x0t2e4euG1/C/Vp9wBJ17qEr/w
         iHo/7rodCX7H5a6n6XPg12/FabuzP9TBNbJ4Nww8tewlRAbmb1il3mvTUy2TpzQyHC
         3DzJX5Sv83O4w==
Date:   Tue, 7 Mar 2023 18:44:35 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH V3 00/20] Add basic ACPI support for RISC-V
Message-ID: <a9823561-2e32-49e8-b6c9-73e4b8f8cf8d@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <16007014-c5f2-4b07-baec-e19952236aa5@spud>
 <ZAbGSA6F0kfv9YYw@sunil-laptop>
 <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Syeh4y7IR+Jnz+iK"
Content-Disposition: inline
In-Reply-To: <E7FB4927-1FE6-435A-914E-9615C2AD9D34@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Syeh4y7IR+Jnz+iK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 07, 2023 at 06:13:22AM +0000, Conor Dooley wrote:
>=20
>=20
> On 7 March 2023 05:06:16 GMT, Sunil V L <sunilvl@ventanamicro.com> wrote:
> >On Mon, Mar 06, 2023 at 09:51:09PM +0000, Conor Dooley wrote:
> >> Hey Sunil,
> >>=20
> >> On Fri, Mar 03, 2023 at 07:06:27PM +0530, Sunil V L wrote:
> >> > This patch series enables the basic ACPI infrastructure for RISC-V.
> >> > Supporting external interrupt controllers is in progress and hence i=
t is
> >> > tested using poll based HVC SBI console and RAM disk.
> >> >=20
> >> > The first patch in this series is one of the patch from Jisheng's
> >> > series [1] which is not merged yet. This patch is required to support
> >> > ACPI since efi_init() which gets called before sbi_init() can enable
> >> > static branches and hits a panic.
> >> >=20
> >> > Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
> >> > but a PR is raised already.
> >> >=20
> >> > Below are two ECRs approved by ASWG.
> >> > RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xS=
EqK2l/view
> >> > RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR=
-tia/view
> >> >=20
> >> > The series depends on Anup's IPI improvement series [2].
> >> >=20
> >> > [1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel=
=2Eorg/
> >> > [2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@vent=
anamicro.com/T/
> >>=20
> >> Building a clang-15 allmodconfig (I didn't try gcc) with this series, =
and
> >> Anup's IPI bits, results in a broken build, due to failings in cmpxchg:
> >>=20
> >> /stuff/linux/drivers/platform/surface/aggregator/controller.c:61:25: e=
rror: call to __compiletime_assert_335 declared with 'error' attribute: BUI=
LD_BUG failed
> >>         while (unlikely((ret =3D cmpxchg(&c->value, old, new)) !=3D ol=
d)) {
> >>                                ^

> > I am able to build without any of these issues using clang-15. I am
> > wondering whether the base is proper. I had rebased on top of the master
> > and couple of patches from IPI series were already merged in the master.
> >=20
> > Do you mind verifying with my branch
> > https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3?
>=20
> I can check that later I suppose.

That's broken too.

> > Or if you could provide me your branch details, I can look further.
>=20
> 6.3-rc1, with both series applied, sans Anups applied patches.

I've pushed my stuff here, but unlikely that it makes any odds since
your branch experiences the same build issue.
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ borked-acp=
i-surface

My build commands are wrapped in a script, but it's an LLVM=3D1
allmodconfig run w/ clang-15(.0.7) etc.

Chees,
Conor.

--Syeh4y7IR+Jnz+iK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAeGEwAKCRB4tDGHoIJi
0pBJAQC6eUPL8agYJlDStZNq2bNTc9yH0rw+9QH9WnR5mdEIxwD+Ikx1pSDTQT/o
2vHNHYLroiHM+zN28aBpih7YsooWjQI=
=4gdL
-----END PGP SIGNATURE-----

--Syeh4y7IR+Jnz+iK--
