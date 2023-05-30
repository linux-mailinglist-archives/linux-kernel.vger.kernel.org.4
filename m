Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48B5716B84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbjE3Rr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjE3Rr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:47:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2780EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F5AD62EA0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF09C433D2;
        Tue, 30 May 2023 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685468842;
        bh=ZbKD8T6XaIwB4p2rBGYXibCFVbjC5VHZ8efSGsRpmf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5RyBCiNjWNomJEEMvP38q3EOc/bloifBXLw76Zo2gV7mUs8f4F1/RFXyZ8vlvMyh
         PRGJ+HkY49bqp4CW8Bn3jc2Ip1ya2vOhm4lT4pZYsBBni+Lu4PmvN/hYEY5jhgZNVJ
         SOWuvGQ5mVXBHmwiue8FlqTbYsdgFjZMLf/EE8uVdipOjvBzwtJ6fgyfZ4R/r72TTa
         0v2taCtgBw7q7ZEMwXGqV7r4Sh6e0McsVf1WAOEQqQh56sdby20Fq9bo62fpZQRTMh
         TyFIZ/5mzaWaTjb9EhH4z8MMziZGz8zYgcjbE5bC5IMCXuB8tWOHMSgGcd8/n64GyZ
         qzRhpd4A8miuQ==
Date:   Tue, 30 May 2023 18:47:18 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230530-hatchery-unifier-64d7a2ffe0d0@spud>
References: <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
 <20230529-skillet-quarters-3fbc3b6edb3a@spud>
 <41e57bb9-ce0c-7772-abeb-5c01d5ec19bb@ghiti.fr>
 <20230530-polka-trifle-7ccd7a093099@wendy>
 <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yFAqj5gbekTcSN8V"
Content-Disposition: inline
In-Reply-To: <92d4aaa8-a1ed-74e1-3a22-df9be1ca1e4a@ghiti.fr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yFAqj5gbekTcSN8V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2023 at 04:33:45PM +0200, Alexandre Ghiti wrote:
>=20
> On 30/05/2023 13:27, Conor Dooley wrote:
> > On Mon, May 29, 2023 at 09:37:28PM +0200, Alexandre Ghiti wrote:
> > > On 29/05/2023 21:06, Conor Dooley wrote:
> > > > On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
> > > > > On 28/05/2023 15:56, Conor Dooley wrote:
> > > > > > On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
> > > > > > > Hmmm, it still works for me with both clang and gcc-9.
> > > > > > gcc-9 is a bit of a relic, do you have more recent compilers ly=
ing
> > > > > > around? If not, I can try some older compilers at some point.
> > > > > >=20
> > > > > > > You don't have to do that now but is there a way I could get =
your compiled
> > > > > > > image? With the sha1 used to build it? Sorry, I don't see wha=
t happens, I
> > > > > > > need to get my hands dirty in some debug!
> > > > > > What do you mean by "sha1"? It falls with v6.4-rc1 which is a s=
table
> > > > > > hash, if that's what you're looking for.
> > > > > >=20
> > > > > > Otherwise,
> > > > > > https://github.com/ConchuOD/riscv-env/releases/download/v2022.0=
3/vmlinux.bin
> > > > > > (ignore the release crap haha, too lazy to find a proper hosting
> > > > > > mechanism)
> > > > > Ok, I don't get much info without the symbols, can you also provi=
de the
> > > > > vmlinux please? But at least your image does not boot, not during=
 the early
> > > > > boot though because the mmu is enabled.
> > > > Do you see anything print when you try it? Cos I do not. Iff I have=
 time
> > > > tomorrow, I'll go poking with gdb. I'm sorry I have not really done=
 any
> > > > investigating, I have been really busy this last week or so with
> > > > dt-binding stuff but I should be freer again from tomorrow.
> > > >=20
> > > > https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vm=
linux
> > >=20
> > > Better, the trap happens in kasan_early_init() when it tries to acces=
s a
> > > global symbol using the GOT but ends up with a NULL pointer, which is=
 weird.
> > > So to me, this is not related to kasan, it happens that kasan_early_i=
nit()
> > > is the first function called after enabling the mmu, I think you may =
have an
> > > issue with the filling of the relocations.
> > Yeah, it reproduces without KASAN.
> >=20
> > > Sorry to bother you again, but if
> > > at some point you can recompile with DEBUG_INFO enabled, that would be
> > > perfect! And also provide the vmlinux.relocs file. Sorry for all that=
, too
> > > bad I can't reproduce it.
> > New vmlinux & vmlinux.relocs here:
> > https://microchiptechnology-my.sharepoint.com/:u:/g/personal/conor_dool=
ey_microchip_com/EZpFNxYYrnNAh5Z3c-rf0pUBBpdPGTLafqdtfcXRUUBkXw?e=3D7KKMHX
> > They're pretty massive unfortunately & hopefully that is not some
> > garbage internal-only link.
> > .config is a wee bit different, cos different build machine, but the
> > problem still manifests on a icicle. I've added it to the tarball just
> > in case.
>=20
>=20
> Ok so I had to recreate the Image from the files you gave me and it boots
> fine using qemu: is that expected? Because you only mention the icicle
> above.

Unfortunately you sent this one right as I left work..
I ssh'ed in though and ran the vmlinux.bin & had the same issues.
Silly question perhaps - is it just not possible to boot something that
has been hit with `objcopy -O binary vmlinux vmlinux.bin` with
CONFIG_RELOCATABLE? At this point that's the main thing that sticks out
to me as being different. You couldn't boot the vmlinux.bin that I sent
you either.

Cheers,
Conor.

--yFAqj5gbekTcSN8V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHY2pgAKCRB4tDGHoIJi
0hAqAP9YasgLw/aZyFNtndJoOr+ciIy8BdmXFiR3djiyi79E1wEAqr4fh/FlvjgV
896quzlFUVMJxGPMq51gcAZSP9yvdAI=
=a/8W
-----END PGP SIGNATURE-----

--yFAqj5gbekTcSN8V--
