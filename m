Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4867427E4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjF2ODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF2ODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:03:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E40A1FE4;
        Thu, 29 Jun 2023 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688047430; x=1719583430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0LCje66TrgfndvZbz38XLfCZaJE3/THeERjOD2/AstY=;
  b=pD6y9J85HsERg0DbTeB+Smy7meSqEtSGZ4p/P1hKZyMynCPzJcABaf4o
   Y9d44jBCBqbcEM3Pk3mtOLQ5xDoL2KXJ6HGJ+1Se0r7L1SBfYKNa8DAQ/
   kga3hBZsaiT3ltp1E+IuaqG/B+CZt6Didq8VEpjXCFL8MoCeZveNPgttV
   d1LBNN2+pqFQzWfL7oAmh59xaMxhTHJXMaGuAMoaX0UwOB+ZXYqjX2+Q/
   O1OoywQpq7UYo/3Xx2kV6QozNmHVAxHaEJ63D9qr+cx51L6zkDzBfB7bE
   pjJF+tcunFfGoJ5ISQBFn6sQ7Nw+eL2RUpc6JbzMkNrhu6J25TZ9rjSNh
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="asc'?scan'208";a="232893173"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2023 07:03:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 29 Jun 2023 07:03:40 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 29 Jun 2023 07:03:37 -0700
Date:   Thu, 29 Jun 2023 15:03:08 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Andy Chiu <andy.chiu@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Yangyu Chen <cyy@cyyself.name>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/2] RISC-V: Probe for unaligned access speed
Message-ID: <20230629-untaxed-tripping-6000bc8c1873@wendy>
References: <20230623222016.3742145-1-evan@rivosinc.com>
 <20230623222016.3742145-2-evan@rivosinc.com>
 <20230626-veneering-superglue-751719bd967c@wendy>
 <CALs-HsskE1-OkZxFzH9bM6bR9NBW5R4mh5AJScVtnvHbv+Pi6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H5dFwnc5H1LxQund"
Content-Disposition: inline
In-Reply-To: <CALs-HsskE1-OkZxFzH9bM6bR9NBW5R4mh5AJScVtnvHbv+Pi6A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--H5dFwnc5H1LxQund
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 12:11:25PM -0700, Evan Green wrote:
> On Mon, Jun 26, 2023 at 7:15=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> > > +void check_misaligned_access(int cpu)
> > > +{
> > > +     unsigned long j0, j1;
> > > +     struct page *page;
> > > +     void *dst;
> > > +     void *src;
> > > +     long word_copies =3D 0;
> > > +     long byte_copies =3D 0;
> > > +     long speed =3D RISCV_HWPROBE_MISALIGNED_SLOW;
> >
> > Is this not a change from current behaviour, that may actually lead to
> > incorrect reporting. Presently, only T-Head stuff sets a speed, so
> > hwprobe falls back to UNKNOWN for everything else. With this, we will
> > get slow set, for anything failing the test.
> > Slow is defined as "Misaligned accesses are supported in hardware, but
> > are slower than the cooresponding aligned accesses sequences (sic)", but
> > you have no way of knowing, based on the test you are performing, wheth=
er
> > the hardware supports it or if it is emulated by firmware.
> > Perhaps that is not relevant to userspace, but wanted to know your
> > thoughts.
> >
>=20
> Hm, that's true. EMULATED was an easy one when we were planning to get
> this info from the DT. It also might be an easy one in the future, if
> we get an SBI call that allows the kernel to take over misaligned trap
> handling. We'd then be able to do a misaligned access and see if our
> trap handler got called.
>=20
> One option is to leave the value alone if we fail the FAST test
> (rather than changing it from UNKNOWN to SLOW). This isn't great
> though, as it effectively makes UNKNOWN synonymous with SLOW, but in a
> way where usermode can't tell the difference between "I truly don't
> know" and "I tried the fast test and it failed".
>=20
> The alternative, as it is now, may mislabel some emulated systems as
> slow until the new SBI call shows up.

Make that "mislabel some emulated systems forever", existing systems
don't magically grow support for new extensions unfortunately.

Realistically though, does it matter to userspace if it is slow because
the hardware is slow, or if the emulation is slow, since there's not
really a way for userspace to tell from the syscall by how much it is
slower.
It can probably guess that emulation is worse, given how crap the
speed I see on mpfs is.

I'd rather we did say slow, rather than people start to interpret
UNKNOWN as slow.

> I'm not sure how bad this is in
> practice. We could add a subsequent performance bar below which we
> guess "emulated".

Nah, I don't really think that that is required.

> This probably matches what usermode will use that
> value for anyway (a synonym for "very slow"), but it's basically the
> same problem with reversed polarity (we mislabel some slow systems as
> emulated). I'm open to suggestions!

I think I just agreed with you, give or take. If it is fast, say fast.
If it is slow, we say it is slow. If we know it is emulated, then we can
report it being emulated. Is it too late to remove the "hardware" from
the syscall documentation, IOW s/supported in hardware/supported/?

Please actually describe the assumptions/subtleties in the commit
message though, so that the rationale for stuff is in the history :)

Cheers,
Conor.

--H5dFwnc5H1LxQund
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ2PHAAKCRB4tDGHoIJi
0u12AP9Y4hnYqRbH89CmxyncXU2SpQInIjF2gv52xpsfjjHjSgD+Kupcyjx9JdXL
IXyCwSeqVgJgGgNYQaIGXrmI/E/Biwo=
=2Coz
-----END PGP SIGNATURE-----

--H5dFwnc5H1LxQund--
