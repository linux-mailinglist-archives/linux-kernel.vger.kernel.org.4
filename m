Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584FC715D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjE3L2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjE3L2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:28:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5C7D9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 04:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685446082; x=1716982082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9I56BwKJC+BbnxkzOeSVjINNxm7Kz+ydMtYSbEYEBo=;
  b=J9cVZikYXoVE5PENBGvd2nyHtpQ7vjiUVQ+kgqef5e35NC4CcUbEgL72
   EaxCK2zJWoKfnNhpvMA8Gr55WshUIbFPxpJ4y6bVfnQqG3ptZZVLhpfWN
   XeN1FK/4235v0IcaHDmpAFJ2db9w6KfcDlR1wMemdLkmiUzKlZ8ua4W6E
   SIwFAHa1Bky1SP5NVDpmacBSnwphkvYb6kjpM74LeqsWMD7Emei22lzNo
   Nudw2pPJ6nL5ip9mGDXFfC2N8a7XSqxz2GyGu90TwI3/PLiAmxunKDzVD
   x4eLXpd3JarvPmWDyf91DOw3yaRH/MO1mlXPjR3TGoH5g6Tay/GMz9aJt
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681196400"; 
   d="asc'?scan'208";a="227570029"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 May 2023 04:28:02 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 30 May 2023 04:28:01 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 30 May 2023 04:27:59 -0700
Date:   Tue, 30 May 2023 12:27:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230530-polka-trifle-7ccd7a093099@wendy>
References: <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
 <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ijmS6XfW1T6Cta2t"
Content-Disposition: inline
In-Reply-To: <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ijmS6XfW1T6Cta2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 09:37:28PM +0200, Alexandre Ghiti wrote:
> On 29/05/2023 21:06, Conor Dooley wrote:
> > On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
> > > On 28/05/2023 15:56, Conor Dooley wrote:
> > > > On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
> > > > > Hmmm, it still works for me with both clang and gcc-9.
> > > > gcc-9 is a bit of a relic, do you have more recent compilers lying
> > > > around? If not, I can try some older compilers at some point.
> > > >=20
> > > > > You don't have to do that now but is there a way I could get your=
 compiled
> > > > > image? With the sha1 used to build it? Sorry, I don't see what ha=
ppens, I
> > > > > need to get my hands dirty in some debug!
> > > > What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
> > > > hash, if that's what you're looking for.
> > > >=20
> > > > Otherwise,
> > > > https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vm=
linux.bin
> > > > (ignore the release crap haha, too lazy to find a proper hosting
> > > > mechanism)
> > >=20
> > > Ok, I don't get much info without the symbols, can you also provide t=
he
> > > vmlinux please? But at least your image does not boot, not during the=
 early
> > > boot though because the mmu is enabled.
> > Do you see anything print when you try it? Cos I do not. Iff I have time
> > tomorrow, I'll go poking with gdb. I'm sorry I have not really done any
> > investigating, I have been really busy this last week or so with
> > dt-binding stuff but I should be freer again from tomorrow.
> >=20
> > https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux
>=20
>=20
> Better, the trap happens in kasan_early_init() when it tries to access a
> global symbol using the GOT but ends up with a NULL pointer, which is wei=
rd.
> So to me, this is not related to kasan, it happens that kasan_early_init()
> is the first function called after enabling the mmu, I think you may have=
 an
> issue with the filling of the relocations.

Yeah, it reproduces without KASAN.

> Sorry to bother you again, but if
> at some point you can recompile with DEBUG_INFO enabled, that would be
> perfect! And also provide the vmlinux.relocs file. Sorry for all that, too
> bad I can't reproduce it.

New vmlinux & vmlinux.relocs here:
https://microchiptechnology-my.sharepoint.com/:u:/g/personal/conor_dooley_m=
icrochip_com/EZpFNxYYrnNAh5Z3c-rf0pUBBpdPGTLafqdtfcXRUUBkXw?e=3D7KKMHX
They're pretty massive unfortunately & hopefully that is not some
garbage internal-only link.
=2Econfig is a wee bit different, cos different build machine, but the
problem still manifests on a icicle. I've added it to the tarball just
in case.

> > > I tried with gcc-12 and it still works fine on my end, so frustrating!
> > Crap! Also, should you not be enjoying a public holiday rather than
> > debugging?! Or maybe debugging is enjoyable for you...
>=20
>=20
> Ahah, this is what I enjoy doing when the kids finally sleep :)
>=20
>=20
> Thank you again for your very quick feedback, really appreciated!

No worries.

--ijmS6XfW1T6Cta2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHXdqAAKCRB4tDGHoIJi
0lM7AP0U38KNP3c0yvn8PKfKxVr1SpAhJSK43MDqw7G9XFbtGgEAlCUv8lOmrwge
9usJ8IHOH3/p8eTuvB89kQgqwjxZGQg=
=mBwb
-----END PGP SIGNATURE-----

--ijmS6XfW1T6Cta2t--
