Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB02C6510BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbiLSQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiLSQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:51:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D487DBC
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF730B80EF3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 16:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C93C433D2;
        Mon, 19 Dec 2022 16:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671468685;
        bh=5d6QIC714srN2pLMGTnuPRYkaTpSx52qfB26H8/1sm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFbHs4K0upepZN5GiyebdPtXvmuohaYd+BVq+yV3nR6vmmmoZDrIXtc0E5WK+ZMjb
         wxHYDaiM1ZWZrGYN2xeLYiM3+GxCYnBEwU+X4j+LvNnPNN+Q7FmdARy9rknhvARG6s
         NGxNxH6os2bLx5oTAKJtYgc5RHjpXsHPREXvOJc2eZusvbybnqPD82ZnLHiNMh+jby
         HEiZBe5ItE7A/BXdPk7rZ5mwb2+/iZMkPb8VMULz9AyZPunwg2Qqerlb8xL+tviWRg
         sGA368Ds5MTMr5GTZZs27eHgEBqIGrQHgtLdWuW6YpYuYgOIqTtq8t8J5VgWHk5xny
         AqmyGNNCpVW7Q==
Date:   Mon, 19 Dec 2022 16:51:20 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Saleem Abdulrasool <abdulras@google.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, ben.dooks@codethink.co.uk,
        ndesaulniers@google.com, nathan@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: avoid enabling vectorized code generation
Message-ID: <Y6CWiMJRqYRd/S4G@spud>
References: <39636675da60fc6c54cc8bbab64ddbac@codethink.co.uk>
 <mhng-d601613f-1c73-48e0-bb06-7f87acd60cfa@palmer-ri-x1c9a>
 <CAO8XFHth5tJWi8EYag1FnOgD38i2pDe87G3u2dkkP+-gkYBZkg@mail.gmail.com>
 <E9917D44-4C61-4806-8A79-7F24AF504DA3@kernel.org>
 <CAO8XFHvf9UE8abprkjiKx0RvMCDkyGdpc_MSoFk2pQCyA2qmxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RBZVM2aroxjCYBKy"
Content-Disposition: inline
In-Reply-To: <CAO8XFHvf9UE8abprkjiKx0RvMCDkyGdpc_MSoFk2pQCyA2qmxA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RBZVM2aroxjCYBKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2022 at 07:21:32AM -0800, Saleem Abdulrasool wrote:
> On Fri, Dec 16, 2022 at 6:02 PM Conor Dooley <conor@kernel.org> wrote:
> >
> >
> >
> > On 16 December 2022 12:56:23 GMT-08:00, Saleem Abdulrasool <abdulras@go=
ogle.com> wrote:
> > >On Fri, Dec 16, 2022 at 11:54 AM Palmer Dabbelt <palmer@dabbelt.com> w=
rote:
> > >>
> > >> On Fri, 16 Dec 2022 11:45:21 PST (-0800), ben.dooks@codethink.co.uk =
wrote:
> > >> >
> > >> >
> > >> > On 2022-12-16 18:50, Saleem Abdulrasool wrote:
> > >> >> The compiler is free to generate vectorized operations for zero'i=
ng
> > >> >> memory.  The kernel does not use the vector unit on RISCV, simila=
r to
> > >> >> architectures such as x86 where we use `-mno-mmx` et al to preven=
t the
> > >> >> implicit vectorization.  Perform a similar check for
> > >> >> `-mno-implicit-float` to avoid this on RISC-V targets.
> > >> >
> > >> > I'm not sure if we should be emitting either of the vector or floa=
ting
> > >> > point instrucitons in the kernel without explicitly marking the se=
ction
> > >> > of code which is using them such as specific accelerator blocks.
> > >>
> > >> Yep, we can't let the compiler just blindly enable V or F/D.  V would
> > >> very much break things as we have no support, but even when that's in
> > >> we'll we at roughly the same spot as F/D are now where we need to ha=
ndle
> > >> the lazy save/restore bits.
> > >>
> > >> This looks like an LLVM-only option, I see at least some handling he=
re
> > >>
> > >> https://github.com/llvm/llvm-project/blob/a72883b7612f5c00b592da85ed=
2f1fd81258cc08/clang/lib/Driver/ToolChains/Clang.cpp#L2098
> > >>
> > >> but I don't really know LLVM enough to understand if there's some
> > >> default for `-mimplicit-float` and I can't find anything in the docs.
> > >> If it can be turned on by default and that results in F/D/V instruct=
ions
> > >> then we'll need to explicitly turn it off, and that would need to be
> > >> backported.
> > >
> > >Yes, this is an LLVM option, but I think that the `cc-option` wrapping
> > >should help ensure that we do not break the gcc build.  This only
> > >recently was added to clang, so an older clang would also miss this
> > >flag.  The `-mimplicit-float` is the default AFAIK, which is why we
> > >needed to add this flag in the first place.  Enabling V exposed this,
> > >which is why the commit message mentions vector.
> >
> > You've said "enabling V" in the comment and here.
> > By that, do you mean when V support is enabled in clang or when it is e=
nabled in Linux?
>=20
> Excellent distinction.  I meant enabled in the compiler, enabling it
> in the kernel is not yet possible without the pending patchset.  This
> makes us robust to when that patchset is merged, but in the meantime,
> this protects against the V extension being enabled in the toolchain.

Ah cool. I figured that it was not possible without the vector patchset
but I was not 100% as it was a wee bit vague ;)
Since V will not be enabled without that patchset, I guess this does not
*have* to go as a fix or to stable?

Per the option's name &
https://github.com/llvm/llvm-project/commit/549231d38e10de7371adb85f5452d42=
ad42f4201
it may however be better to backport it anyway, in case implicit use of
fp registers does arrive.

You mentioned the gcc build & gcc-12 is fine:
https://patchwork.kernel.org/project/linux-riscv/patch/20221216185012.23426=
75-1-abdulras@google.com/

Anyway, seems like a sensible addition to me, so:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
I think it may also be good to do:
Link: https://github.com/llvm/llvm-project/commit/549231d38e10de7371adb85f5=
452d42ad42f4201

Thanks,
Conor.


--RBZVM2aroxjCYBKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6CWiAAKCRB4tDGHoIJi
0i1nAQCCw/jEfWBsMbalcMqc5madBFGwCM+LtSQDhmjpgrHLJwD/cf9M0DIkFBjO
9btAqPOuizXGmlQkhi3pGMQ6vt6WNw0=
=ZrTv
-----END PGP SIGNATURE-----

--RBZVM2aroxjCYBKy--
