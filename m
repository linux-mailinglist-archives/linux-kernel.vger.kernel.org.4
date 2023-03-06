Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF236ACDFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCFT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjCFT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:27:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883506F497;
        Mon,  6 Mar 2023 11:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39284B810CB;
        Mon,  6 Mar 2023 19:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DB7C433D2;
        Mon,  6 Mar 2023 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678130815;
        bh=qJZNuK31WcsEJiNza1huRTw6AstehkIf7XEiHaxQpRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evMW9Jw7+rFCbiPUyIffpCsSKySfnXOeDFIjsBW5Fk3mDSZcpzqM7Gd5VTD1JjEYO
         jX3bQa67lPhzW4mY/KQ3NLqtrwGc07oXNikGq0s9KqHrzy22vwP4FoFnCcbQpOn42/
         oaShy5iJLKwBE8386ZPLowLJoxWAv0fvOrnxTOGJp9l8yFBCyPBdgKP35bXa5YX3Qp
         bnHqPOIxhEzkWZCD+BYQUqNywK5c/+Vu/LNuJKH5J/GgkajAA0dXlV+Z5ZW6sw1ZwY
         cK0wY0ExeNC2REvxMki/R6Eou/7VghZxpht18BkclAHc+4/gapoSDZ+6KuC+z4b3vn
         vzLb7zRlegB8A==
Date:   Mon, 6 Mar 2023 19:26:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     miguel.ojeda.sandonis@gmail.com,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [RFC 0/2] RISC-V: enable rust
Message-ID: <719ed82b-ffe5-4f2f-a21c-f32b9b4f867b@spud>
References: <CANiq72ndkF0JM1kV=ewnO4uGirDowHDGLkhvjQgtLnuPEk_hTQ@mail.gmail.com>
 <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bv6pgk4XOEP22YAx"
Content-Disposition: inline
In-Reply-To: <mhng-a7ada57e-543c-434b-a4f3-4fbda9238eb0@palmer-ri-x1c9a>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bv6pgk4XOEP22YAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2023 at 11:18:06AM -0800, Palmer Dabbelt wrote:
> On Sat, 25 Feb 2023 00:37:29 PST (-0800), miguel.ojeda.sandonis@gmail.com=
 wrote:
> > On Sat, Feb 25, 2023 at 12:18 AM Palmer Dabbelt <palmer@dabbelt.com> wr=
ote:
> > >=20
> > > Works for me.
> > >=20
> > > I've got a few other things in the pipeline for this merge window so
> > > this probably won't make it, but I'll dig in after that.  We've got a
> > > bunch of Rust-types floating around Rivos as well, so with any luck
> > > someone else will have some time to poke around.  Having a full cycle=
 in
> > > linux-next is probably the right way to go for this sort of thing
> > > anyway, as it's likely to shake out some long-tail issues.
> >=20
> > Thanks a lot! That would be great.
> >=20
> > At least from our side, no rush. In fact, we are letting users (or
> > arch maintainers) to request/submit the architectures themselves as
> > they need/want them.
>=20
> It's time for the next release.  IIUC there were some authorship issues
> here, did you guys want to re-spin this with those sorted out?  I can give
> it a shot if you want, but I'm probably as likely to screw it up as anyone
> else...

It's in my queue to respin, I wasn't bothered doing one until after -rc1.
I'll try to get to it tomorrow since it's simpler than anything else I
currently owe one for.
Should be able to do something that satisfies everyone, or, at least,
gives everyone the opportunity to be satisfied!

Cheers,
Conor.


--bv6pgk4XOEP22YAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAY+QAAKCRB4tDGHoIJi
0obrAP9X3eFi/wo3T5hY5jI6VcYOgDX5U9nhlmdJj6G1KUkFGgD9FSf22UcJPohT
atZEWK7qWW8liEdc0PizSJE8mWeNrwY=
=IHr0
-----END PGP SIGNATURE-----

--bv6pgk4XOEP22YAx--
