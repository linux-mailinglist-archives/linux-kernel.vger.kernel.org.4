Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0C8714F89
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 21:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjE2THG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 15:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2THF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 15:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4118C4
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 12:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76E2B61B04
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA47C433EF;
        Mon, 29 May 2023 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685387222;
        bh=DC+0Nz9V+5G1BtqYeJRptzk3vDmLfC8GGcPOFmfLs7w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nSAVfaEyAVEWoJHatqnJ1OXPiUrRw3iGfdQttQqHXkrQil4SlK2xKjMoqKIO3SIeg
         WBZ6MZ04Elw/Oeha2r2R6O14rnSKUXt/kHy+Nm/UCnMUsWRopQBfF87gmLZ6J/SU2C
         QtKJFt/XNtMj45p5Bfa4YU3cxpjcpBfJrYsUao3mtB3sBPJk7JKot6zAWUijPO11+v
         U1SvmMqLqSAndAlKtdpciB7Rr/CvSAmba+U1Oj41vKrNYQNK1pP9xLeE9MA/8dKefw
         bnRQ2KcPhBeVXEIHxLS/xMUPK9H4bM1u6o5hEdQ0F1WukUoYeOKeg60jWzGygYWmWq
         0P5rX4ocLaw1w==
Date:   Mon, 29 May 2023 20:06:58 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes] riscv: Fix relocatable kernels with early
 alternatives using -fno-pie
Message-ID: <20230529-skillet-quarters-3fbc3b6edb3a@spud>
References: <20230526154630.289374-1-alexghiti@rivosinc.com>
 <20230526-clergyman-wriggly-accc659a3fad@spud>
 <20230526-rockfish-moody-f6d3e71f9d24@spud>
 <f6522c82-01bd-8a03-579d-a5b294784480@ghiti.fr>
 <20230527-hyperlink-doctrine-ef22cfcb508a@spud>
 <CAHVXubgx3uBEjMLHXTxr0192ZHbSb=qK4NggZyWQTDfgrJt2-g@mail.gmail.com>
 <20230528-darkness-grandly-6cb9e014391d@spud>
 <cf0d2d2a-c407-7b3d-a5ab-ea5c19e7b890@ghiti.fr>
 <20230528-uneatable-earpiece-3f8673548863@spud>
 <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9orEhVzZm/1dz2G/"
Content-Disposition: inline
In-Reply-To: <b71dc2f5-fdc0-2a8d-e1f9-696cd9a1529e@ghiti.fr>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9orEhVzZm/1dz2G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 08:51:57PM +0200, Alexandre Ghiti wrote:
>=20
> On 28/05/2023 15:56, Conor Dooley wrote:
> > On Sun, May 28, 2023 at 03:42:59PM +0200, Alexandre Ghiti wrote:
> > > Hmmm, it still works for me with both clang and gcc-9.
> > gcc-9 is a bit of a relic, do you have more recent compilers lying
> > around? If not, I can try some older compilers at some point.
> >=20
> > > You don't have to do that now but is there a way I could get your com=
piled
> > > image? With the sha1 used to build it? Sorry, I don't see what happen=
s, I
> > > need to get my hands dirty in some debug!
> > What do you mean by "sha1"? It falls with v6.4-rc1 which is a stable
> > hash, if that's what you're looking for.
> >=20
> > Otherwise,
> > https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinu=
x.bin
> > (ignore the release crap haha, too lazy to find a proper hosting
> > mechanism)
>=20
>=20
> Ok, I don't get much info without the symbols, can you also provide the
> vmlinux please? But at least your image does not boot, not during the ear=
ly
> boot though because the mmu is enabled.

Do you see anything print when you try it? Cos I do not. Iff I have time
tomorrow, I'll go poking with gdb. I'm sorry I have not really done any
investigating, I have been really busy this last week or so with
dt-binding stuff but I should be freer again from tomorrow.

https://github.com/ConchuOD/riscv-env/releases/download/v2022.03/vmlinux

> I tried with gcc-12 and it still works fine on my end, so frustrating!

Crap! Also, should you not be enjoying a public holiday rather than
debugging?! Or maybe debugging is enjoyable for you...

Cheers,
Conor.

--9orEhVzZm/1dz2G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHT30gAKCRB4tDGHoIJi
0oE4AQC8kQJqtdm4bfkg8EIJwiDdxoIlxlz5s8mF3AhgqoCiKAD+LAFXAi2wfTUg
PenZcj0zlOE6b84SgfE7oazBo3NcDws=
=OvI/
-----END PGP SIGNATURE-----

--9orEhVzZm/1dz2G/--
