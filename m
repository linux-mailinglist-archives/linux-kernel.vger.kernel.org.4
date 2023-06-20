Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ABD73695D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 12:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjFTKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjFTKdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 06:33:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DFCE;
        Tue, 20 Jun 2023 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687257216; x=1718793216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7jLFGIDURQwJ/rts8JKrdNtasOylt7Y9FBs4mmLhI54=;
  b=lYThuM8M1l6AuQW+d8uRtrxzFTzGjREwHPZ3dI0jPFZMsfhvxS1yQHC7
   oDpc2qmzGnZmBYEArArx7psVs7qadqnpHQpuCZX+Ywof7m9/q3urjnvZr
   IOwuPCI4GmapIGyncE9jLBIfYHrJA3JJqg9WObH4tHt/ZygML+agMU+Hf
   iBdlhpdUuae9gw+qQ3nAGRWYCGibdBwHkFfReNVfVif01FVEI3wSpEioP
   QTgzUGifS8VOLpNFIzufZYLOhKJ2LuB/Rzy709N/DwdoeJStn7dg1+F1d
   IkXuz3a9HR7EiqnlpvOaoHe/z+RPwEv6/PXCx9i/07enafqGbKwb8DUwJ
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="asc'?scan'208";a="216809712"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2023 03:33:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 20 Jun 2023 03:33:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 20 Jun 2023 03:33:30 -0700
Date:   Tue, 20 Jun 2023 11:33:03 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Conor Dooley <conor@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: riscv: Add early boot document
Message-ID: <20230620-limes-glaring-4831955f7250@wendy>
References: <20230619094705.51337-1-alexghiti@rivosinc.com>
 <20230619-kerchief-unmixed-cfdbeb1cf242@wendy>
 <CAHVXubjV=0HNyc0-UMAQRQfi4ZUnwH8dmghV-BGogZsJiumtZA@mail.gmail.com>
 <20230619-sponge-armful-6beeaf4a8624@spud>
 <CAHVXubjHpdRpgrywwm1UTxwV99uCYOp9qhKBui9Ghff65yGmsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9jIUO9bbeSs1cKLm"
Content-Disposition: inline
In-Reply-To: <CAHVXubjHpdRpgrywwm1UTxwV99uCYOp9qhKBui9Ghff65yGmsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9jIUO9bbeSs1cKLm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 11:09:47AM +0200, Alexandre Ghiti wrote:
> On Mon, Jun 19, 2023 at 6:00=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Mon, Jun 19, 2023 at 04:04:52PM +0200, Alexandre Ghiti wrote:
> > > On Mon, Jun 19, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor.dooley@mi=
crochip.com> wrote:
> > > > On Mon, Jun 19, 2023 at 11:47:04AM +0200, Alexandre Ghiti wrote:

> > > > > +Bootflow
> > > >
> > > > "Boot Flow", no?
> > > > I am not sure that this is the "correct" heading for the content it
> > > > describes, but I have nothing better to offer :/
> > >
> > > Yes you're right, what about simply "Kernel Entrance"? Not sure this
> > > is easily understandable though.
> >
> > "Non-boot Hart Initialisation"?
>=20
> Hmmm not that great either (sorry for being direct here)

lol, no need to apologise.

> > > > > +There exist 2 methods to enter the kernel:
> > > > > +
> > > > > +- `RISCV_BOOT_SPINWAIT`: the firmware releases all harts in the =
kernel, one hart
> > > > > +  wins a lottery and executes the early boot code while the othe=
r harts are
> > > > > +  parked waiting for the initialization to finish. This method i=
s now
> > > >
> > > > nit: s/now//
> > >
> > > Ok
> > >
> > > >
> > > > What do you mean by deprecated? There's no requirement to implement=
 the
> > > > HSM extension, right?
> > >
> > > I would say yes, you have to use a recent version of openSBI that
> > > supports the HSM extension. @Atish Kumar Patra WDYT?
> >
> > Uh, you don't need to use OpenSBI in the first place, let alone use a
> > recent version of it, right? What am I missing?
>=20
> You need a M-Mode firmware which follows the SBI specification and
> that implements the HSM extension.

Firstly, and maybe I am showing my ignorance here, but we do support
m-mode in Linux, and SMP is not disabled for m-mode kernels where it is
required to use the spinwait method.
Secondly, I don't think that we've actually noted that non-HSM booting
is deprecated before now - at least not somewhere obviously. Things like
the platform spec on github might require it & it may be deprecated in
SBI implementations etc, but in the Kconfig option it is not described
as deprecated. The Kconfig option only says that it "should be only
enabled for M-mode Linux or platforms relying on older firmware without
SBI HSM extension".
I think marking it as deprecated here is not accurate, and instead we
would be better off pointing out what the limitations of the method are
and noting the limited situations when it should be used.

> > Also, what about !SMP systems? Although my suggested new section title
> > kinda addresses that!
>=20
> I'll add "On SMP systems, there exist 2 methods to enter the

nit: s/exist/are/

> kernel:....", I don't think we need to detail the !SMP case as it is
> obvious.

That's fine. Maybe I am just a pedant, but I think it is good to be a
bit over precise.

> > > > > +  **deprecated**.
> > > > > +- Ordered booting: the firmware releases only one hart that will=
 execute the
> > > > > +  initialization phase and then will start all other harts using=
 the SBI HSM
> > > > > +  extension.

> > > > > +---------------------
> > > > > +
> > > > > +The installation of the virtual mapping is done in 2 steps in th=
e RISC-V kernel:
> > > > > +
> > > > > +1. :c:func:`setup_vm` installs a temporary kernel mapping in
> > > > > +   :c:var:`early_pg_dir` which allows to discover the system mem=
ory: only the
> > > >
> > > > s/to discover/discovery of/
> > >
> > > You mean "the discovery of" right?
> >
> > No? The "the" there would not be required.
>=20
> That was a genuine question, thanks

Sorry if the "No?" came across as aggressive, I meant it inquisitively.
Adding the "the" changes the meaning slightly, but not in a way that
that is relevant here.

> > > > > +Pre-MMU execution
> > > > > +-----------------
> > > > > +
> > > > > +Any code that executes before even the first virtual mapping is =
established
> > > > > +must be very carefully compiled as:
> > > >
> > > > Could you point out what the non-obvious examples of this code are?
> > >
> > > I can do a list, yes
> >
> > Not even a list, just something like "...established, for example early
> > alternatives and foo, must be very..."
>=20
> Done as follows:
>=20
> "A few pieces of code need to run before even the first virtual mapping is
> established, that comprises the installation of the first virtual mapping=
, the
> early alternatives and the early parsing of the kernel command line. That=
 code
> must be very carefully compiled as:..."

Changed slightly:
"A few pieces of code need to run before even the first virtual mapping is
established. These are the installation of the first virtual mapping itself,
patching of early alternatives and the early parsing of the kernel command =
line.
That code must be very carefully compiled as:..."

Two minor suggestions there, one to make the it more obvious what the first
section inside commas refers to & one to note what it is that we do with
the alternatives.

Cheers,
Conor.

--9jIUO9bbeSs1cKLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJGAXwAKCRB4tDGHoIJi
0mSSAP40wGujSAsLtbH+8uDlzjX7pMMlc0BtQW1hrnclERbeTgD9FVOvFIC+DtWj
+F7XDOO2YszhsEsEE+fk2iv312rGugo=
=8men
-----END PGP SIGNATURE-----

--9jIUO9bbeSs1cKLm--
