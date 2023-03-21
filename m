Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7516C2BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjCUHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCUHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:48:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0A135
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679384915; x=1710920915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6MyBY7psL5F53ecAKmJGuXc/BjEv9wV4jEJml3TJFIk=;
  b=xS2fizMc3QnHcnnNsvEouQXu9R3N/A1H7kJ69ZQ2bNINeq7Z5tIzMXcl
   b40RZez0w3D6rBWyusFT69kA1GesNBgKkOlGxofe2WHgdSvVW8AR5cBSl
   AdKmSEWCZOWqltircgW1Ie/6wr1k4PWSBQ/zvpwNNyBq6o/+ylxlKgWb2
   Wnx1rstZntdx9E+4e35QWaDELUBWmBUEoGyvHKEGOHRCS8yGanHIRka4p
   /+p9UUSxkK/sJ/BfA8DprqWMfy6ko/qBj+x50ndoD7vZd/euG8loIkTGB
   ltTW5walX7rl5gXiRFB7EFymwHiQU7k04mUpORVyPOVL8cnynm+lVyXVW
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,278,1673938800"; 
   d="asc'?scan'208";a="143073635"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Mar 2023 00:48:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 00:48:33 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 21 Mar 2023 00:48:31 -0700
Date:   Tue, 21 Mar 2023 07:48:01 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
CC:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
Message-ID: <18e07d0a-7e21-46d0-9166-6ee07817352a@spud>
References: <20230318080059.1109286-1-leobras@redhat.com>
 <8f698f49-135a-4263-8471-96f406919cb1@spud>
 <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="92Q1AYY2bRdVQ9dX"
Content-Disposition: inline
In-Reply-To: <4f35f41c143b02b6b815e7eb527ca3acd8b4aabe.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--92Q1AYY2bRdVQ9dX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 21, 2023 at 03:30:35AM -0300, Leonardo Br=E1s wrote:
> Hello Conor, thanks for the feedback!
>=20
>=20
> On Sun, 2023-03-19 at 20:35 +0000, Conor Dooley wrote:
> > On Sat, Mar 18, 2023 at 05:00:54AM -0300, Leonardo Bras wrote:
> > > While studying riscv's cmpxchg.h file, I got really interested in=20
> > > understanding how RISCV asm implemented the different versions of=20
> > > {cmp,}xchg.
> > >=20
> > > When I understood the pattern, it made sense for me to remove the=20
> > > duplications and create macros to make it easier to understand what e=
xactly=20
> > > changes between the versions: Instruction sufixes & barriers.
> > >=20
> > > I split those changes in 3 levels for each cmpxchg and xchg, resultin=
g a=20
> > > total of 6 patches. I did this so it becomes easier to review and rem=
ove=20
> > > the last levels if desired, but I have no issue squashing them if it'=
s=20
> > > better.
> > >=20
> > > Please provide comments.
> > >=20
> > > Thanks!
> > > Leo
> > >=20
> > > Leonardo Bras (6):
> > >   riscv/cmpxchg: Deduplicate cmpxchg() asm functions
> > >   riscv/cmpxchg: Deduplicate cmpxchg() macros
> > >   riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
> >=20
> > >   riscv/cmpxchg: Deduplicate xchg() asm functions
> >=20
> > FWIW, this patch seems to break the build pretty badly:
> > https://patchwork.kernel.org/project/linux-riscv/patch/20230318080059.1=
109286-5-leobras@redhat.com/
>=20
> Thanks for pointing out!
>=20
> It was an intermediary error:
> Sufix for amoswap on acquire version was "d.aqrl" instead of the
> correct".d.aqrl", and that caused the fail.
>=20
> I did not notice anything because the next commit made it more general, a=
nd thus
> removed this line of code. I will send a v2-RFC shortly.
>=20
> I see that patch 4/6 has 5 fails, but on each one of them I can see:
> "I: build output in /ci/workspace/[...]", or
> ""I: build output in /tmp/[...]".

I don't push the built artifacts anywhere, just the brief logs -
although the "failed to build" log isn't very helpful other than telling
you the build broke.
That seems like a bug w.r.t. where tuxmake prints its output. I'll try
to fix that.

> I could not find any reference to where this is saved, though.
> Could you point where can I find the error output, just for the sake of f=
urther
> debugging?
>=20
> >=20
> > Patches 1 & 5 also add quite a lot of sparse issues (like 1000), but I
> > think that may be more of an artifact of the testing process as opposed
> > to something caused by this patchset.
>=20
> For those I can see the build output diffs. Both added error lines to
> conchuod/build_rv64_gcc_allmodconfig.
> I tried to mimic this with [make allmodconfig + gcc build with
> CROSS_COMPILE=3Driscv64-linux-gnu- ] but I could not get any error in any=
 patch.

If you can't replicate them, it's probably because they come from
sparse. I only really mentioned it here in case you went looking at the
other patches in the series and were wondering why things were so amiss.

> For patch 1/6 it removes as much error lines (-) as it adds (+), and the =
error
> messages are mostly the same, apart for an line number.

I don't see a line number difference, but rather an increase in the
number of times the same error lines have appeared in the output.
I don't find the single-line output from sparse to really be very
helpful, I should probably have a bit of a think how to present that
information better.

> For patch 5/6 it actually adds many more lines, but tracking (some of) the
> errors gave me no idea why.

Probably just sparse being unhappy with some way the macros were
changed - but some of it ("Should it be static?" bits) look very much
like the patch causing things to be rebuilt only for the "after the
patch" build, but somehow not for the "before" build.

--92Q1AYY2bRdVQ9dX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBlhLQAKCRB4tDGHoIJi
0hZlAP4n0duDt3EuH405TYYD+EISOJ36GeTGI8Kt1+7QKXReaAEAql7EYVrXRAF3
YdlzsFA20w5PSOvdJ5cWWZsdY2NFjgA=
=lOX4
-----END PGP SIGNATURE-----

--92Q1AYY2bRdVQ9dX--
