Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1E6C3AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCUTtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjCUTs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:48:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD111EA7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D1D61DD1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 19:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2879C433D2;
        Tue, 21 Mar 2023 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679428113;
        bh=yFiw3LGrAcSOiNFsN+4nDh4SSqrTdcuCWGPhMmcIHWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIw1ewHVzqPo9SCNICzE6BvXU0KMuQn6Qt4Hh8ZepoVQ+sQWtkFYjBlaAkkf/bZ0A
         UcvqRyX/WBinNj8bGCPpVQ9P96juzZgMLUKzifzTaqUBygMu/eGxVpD0hYr1X30zDN
         AluxXQAdXxLWS+BeLtLhIOxGnSveVbOb502uBdmpNsl+GHhdNkxZ/J1omFp6YWjrVR
         ZD/qCsEsH0lu0nr40Re3OGscBsQCrZOTllZrQdoFlkEBgu7XuASVG4egS3r954XM82
         R99kLq4lncV/mhp0iauNWh6qo/sMzk319dIXzl0hlazhHfMnvZTKpBNLylJNvtHO0u
         PxKwAvcFYRLDQ==
Date:   Tue, 21 Mar 2023 19:48:29 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
Message-ID: <4d9770c7-3cb6-42d6-891f-1247a02742e9@spud>
References: <20230318080059.1109286-1-leobras@redhat.com>
 <8f698f49-135a-4263-8471-96f406919cb1@spud>
 <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
 <18e07d0a-7e21-46d0-9166-6ee07817352a@spud>
 <CAJ6HWG5zHMB1-vVsuQ+nG3EC12JAi2MP5o8GbSQ9QJfgLEQNnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sHTtzWQ0f0z8DfTw"
Content-Disposition: inline
In-Reply-To: <CAJ6HWG5zHMB1-vVsuQ+nG3EC12JAi2MP5o8GbSQ9QJfgLEQNnw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sHTtzWQ0f0z8DfTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 02:01:59PM -0300, Leonardo Bras Soares Passos wrote:
> On Tue, Mar 21, 2023 at 4:49=E2=80=AFAM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> > On Tue, Mar 21, 2023 at 03:30:35AM -0300, Leonardo Br=C3=A1s wrote:
> > > On Sun, 2023-03-19 at 20:35 +0000, Conor Dooley wrote:
> > > > On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> > > > > While studying riscv's cmpxchg.h file, I got really interested in
> > > > > understanding how RISCV asm implemented the different versions of
> > > > > {cmp,}xchg.
> > > > >
> > > > > When I understood the pattern, it made sense for me to remove the
> > > > > duplications and create macros to make it easier to understand wh=
at exactly
> > > > > changes between the versions: Instruction sufixes & barriers.
> > > > >
> > > > > I split those changes in 3 levels for each cmpxchg and xchg, resu=
lting a
> > > > > total of 6 patches. I did this so it becomes easier to review and=
 remove
> > > > > the last levels if desired, but I have no issue squashing them if=
 it's
> > > > > better.
> > > > >
> > > > > Please provide comments.
> > > > >
> > > > > Thanks!
> > > > > Leo
> > > > >
> > > > > Leonardo Bras (6):
> > > > >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> > > > >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> > > > >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
> > > >
> > > > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> > > >
> > > > FWIW, this patch seems to break the build pretty badly:
> > > > https://patchwork.kernel.org/project/linux-riscv/patch/202303180800=
59.1109286-5-leobras@redhat.com/
> > >
> > > Thanks for pointing out!
> > >
> > > It was an intermediary error:
> > > Sufix for amoswap on acquire version was "d.aqrl" instead of the
> > > correct".d.aqrl", and that caused the fail.
> > >
> > > I did not notice anything because the next commit made it more genera=
l, and thus
> > > removed this line of code. I will send a v2-RFC shortly.
> > >
> > > I see that patch 4/6 has 5 fails, but on each one of them I can see:
> > > "I: build output in /ci/workspace/[...]", or
> > > ""I: build output in /tmp/[...]".
> >
> > I don't push the built artifacts anywhere, just the brief logs -
> > although the "failed to build" log isn't very helpful other than telling
> > you the build broke.
> > That seems like a bug w.r.t. where tuxmake prints its output. I'll try
> > to fix that.
>=20
> Thanks for that :)

I've pushed what I think is a fix, the wrong log file was being grepped
for errors in the case of a failed build.

> > > I could not find any reference to where this is saved, though.
> > > Could you point where can I find the error output, just for the sake =
of further
> > > debugging?
> > >
> > > >
> > > > Patches 1 & 5 also add quite a lot of sparse issues (like 1000), bu=
t I
> > > > think that may be more of an artifact of the testing process as opp=
osed
> > > > to something caused by this patchset.
> > >
> > > For those I can see the build output diffs. Both added error lines to
> > > conchuod/build_rv64_gcc_allmodconfig.
> > > I tried to mimic this with [make allmodconfig + gcc build with
> > > CROSS_COMPILE=3Driscv64-linux-gnu- ] but I could not get any error in=
 any patch.
> >
> > If you can't replicate them, it's probably because they come from
> > sparse. I only really mentioned it here in case you went looking at the
> > other patches in the series and were wondering why things were so amiss.
>=20
> Oh, it makes sense.
>=20
> >
> > > For patch 1/6 it removes as much error lines (-) as it adds (+), and =
the error
> > > messages are mostly the same, apart for an line number.
> >
> > I don't see a line number difference, but rather an increase in the
> > number of times the same error lines have appeared in the output.
> > I don't find the single-line output from sparse to really be very
> > helpful, I should probably have a bit of a think how to present that
> > information better.
>=20
> Oh, I see.
> The number at the beginning relates to the number of times the error happ=
ens.
> Ok it makes sense to me now :)
>=20
> >
> > > For patch 5/6 it actually adds many more lines, but tracking (some of=
) the
> > > errors gave me no idea why.
> >
> > Probably just sparse being unhappy with some way the macros were
> > changed - but some of it ("Should it be static?" bits) look very much
> > like the patch causing things to be rebuilt only for the "after the
> > patch" build, but somehow not for the "before" build.
>=20
> Humm, not sure I could understand that last part:
> What I get is that the patch 5/6 is causing things to be rebuilt, and
> it was not like that on 1-4/6.
> Is that what you said?
> If so, and you are doing it as an incremental build, changing the
> macros in 5/6 should be triggering rebuilds, but it does not make
> sense to not be rebuilt in 1-4/6 as they change the same macros.

Right, it is an incremental build.
First it builds the tree with a patch applied, then it checks out HEAD~1
and builds that tree. Then it goes back to the tree with the patch
applied and builds it again. The output from builds 2 & 3 are compared
to see if any errors snuck in.
In theory, that should ensure that, as builds 2 & 3 have had the same
diff to the previous one just in opposite directions, the same files get
rebuilt - but I am a little worried that ccache gets involved sometimes
and leads to the before/after builds not being exactly the same.

They may very well be real issues as your refactor has caused the
casting in the macros to change or w/e. Not my area of expertise by any
stretch of the imagination, but the lkp sparse is out of date & doesn't
run any more so I figure it's better to be running the stuff, even if it
does sometimes result in a splurge of errors like this than forget about
poor aul sparse.

Cheers,
Conor.

--sHTtzWQ0f0z8DfTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBoJ8wAKCRB4tDGHoIJi
0ofLAP4uMEUjJ/dmB7hfcng2HG8v1/7rX5pK+hQ/6SwXzXp+SAEAiAZz/x8GU5hl
4sdoY8W6pj4+SP+6W/37N4xxpqmqGAI=
=lWRM
-----END PGP SIGNATURE-----

--sHTtzWQ0f0z8DfTw--
