Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C35EAE70
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiIZRpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIZRpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:45:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421F696DB;
        Mon, 26 Sep 2022 10:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F159261070;
        Mon, 26 Sep 2022 17:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5FA3C433C1;
        Mon, 26 Sep 2022 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664212488;
        bh=oU8fn0BSKQJ81q0PJD4003aYsQpw2jnsAd7aL0fi5nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsxD7Ezrth60I4eEJPxOWVxcAYT2+wvpZ0iLXxTkTwgbAKPsnHPVrnHZUJkn/mAtn
         M9DC0FakD7h5p5ZpwtaScOq0NkEKGdLXtf7N9QA8/r6tTs8Cjsjbo/5WKt9/5ROSbD
         Sc8lIErYHDImiS+EabT9oWGV62HB7RgUR03qP/IEsTsg1aTWGdIGhL9xkFm2A0VjU1
         bsc1YryL1H9Epxf3UOjmRM1vqcvE3WVM0iYFE0w6fUwVBDEb7zHrP9bqPE/xWEBgoY
         hKW9OKepxAq0AKO/57OTL7Aoe63pnrdTvFfJsrQJhrmmqiBoTNATuhAwR903oAbwIl
         goVPh7lyg0Puw==
Date:   Mon, 26 Sep 2022 18:14:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 16/16] crypto: arm64/sm4 - add ARMv9 SVE cryptography
 acceleration implementation
Message-ID: <YzHd/U9vvSwuhKsx@sirena.org.uk>
References: <20220926093620.99898-1-tianjia.zhang@linux.alibaba.com>
 <20220926093620.99898-17-tianjia.zhang@linux.alibaba.com>
 <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f7AumrwylgGDBblN"
Content-Disposition: inline
In-Reply-To: <CAMj1kXF8Fi9cG4p6udRYT4LbCAj0UBXQL12nmQBFEWvZsVX7Wg@mail.gmail.com>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f7AumrwylgGDBblN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 12:02:04PM +0200, Ard Biesheuvel wrote:

> Given that we currently do not support the use of SVE in kernel mode,
> this patch cannot be accepted at this time (but the rest of the series
> looks reasonable to me, although I have only skimmed over the patches)

> In view of the disappointing benchmark results below, I don't think
> this is worth the hassle at the moment. If we can find a case where
> using SVE in kernel mode truly makes a [favorable] difference, we can
> revisit this, but not without a thorough analysis of the impact it
> will have to support SVE in the kernel. Also, the fact that SVE may

The kernel code doesn't really distinguish between FPSIMD and SVE in
terms of state management, and with the sharing of the V and Z registers
the architecture is very similar too so it shouldn't be too much hassle,
the only thing we should need is some management for the VL when
starting kernel mode SVE (probably just setting the maximum VL as a
first pass).

The current code should *work* and on a system with only a single VL
supported it'd be equivalent since setting the VL is a noop, it'd just
mean that any kernel mode SVE would end up using whatever the last VL
set on the PE happened to be in which could result in inconsistent
performance.=20

> also cover cryptographic extensions does not necessarily imply that a
> micro-architecture will perform those crypto transformations in
> parallel and so the performance may be the same even if VL > 128.

Indeed, though so long as the performance is comparable I guess it
doesn't really hurt - if we run into situations where for some
implementations SVE performs worse then we'd need to do something more
complicated than just using SVE if it's available but...

> In summary, please drop this patch for now, and once there are more
> encouraging performance numbers, please resubmit it as part of a
> series that explicitly enables SVE in kernel mode on arm64, and
> documents the requirements and constraints.

=2E..in any case as you say until there are cases where SVE does better
for some in kernel use case we probably just shouldn't merge things.

Having said that I have been tempted to put together a branch which has
a kernel_sve_begin() implementation and collects proposed algorithm
implementations so they're there for people to experiment with as new
hardware becomes available.  There's clearly interest in trying to use
SVE in kernel and it makes sense to try to avoid common pitfalls and
reduce duplication of effort.

A couple of very minor comments on the patch:

> > +config CRYPTO_SM4_ARM64_SVE_CE_BLK
> > +       tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (ARMv9 cryptogra=
phy
> +acceleration with SVE2)"
> > +       depends on KERNEL_MODE_NEON
> > +       select CRYPTO_SKCIPHER
> > +       select CRYPTO_SM4
> > +       select CRYPTO_SM4_ARM64_CE_BLK
> > +       help

Our current baseline binutils version requirement predates SVE support
so we'd either need to manually encode all SVE instructions used or add
suitable dependency.  The dependency seems a lot more reasonable here,
and we could require a new enough version to avoid the manual encoding
that is done in the patch (though I've not checked how new a version
that'd end up requiring, it might be unreasonable so perhaps just
depending on binutils having basic SVE support and continuing with the
manual encoding might be more helpful).

> > +.macro sm4e, vd, vn
> > +       .inst 0xcec08400 | (.L\vn << 5) | .L\vd
> > +.endm

For any manual encodings that do get left it'd be good to note the
binutils and LLVM versions which support the instruction so we can
hopefully at some point switch to assembling them normally.

> > +static int __init sm4_sve_ce_init(void)
> > +{
> > +       if (sm4_sve_get_vl() <=3D 16)
> > +               return -ENODEV;

I'm not clear what this check is attempting to guard against - what's
the issue with larger VLs?

If it is needed then we already have a sve_get_vl() in the core kernel
which we should probably be making available to modules rather than
having them open code something (eg, making it a static inline rather
than putting it in asm).

--f7AumrwylgGDBblN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMx3fwACgkQJNaLcl1U
h9C8Pgf9GG6I05ACG8YLcqEf0Y5yObFlPelhwSsSzTXK+0+/qIciuuTFJnnq0/Bm
0+uR1I3XV5kCEsQRyeiXgOqzpkXdsy5ggrY29lme2tnBMA5DTV9/rhDdyoIdMcG4
JUVAdgFQ5UfZeLUkMTYreey6trdhQqJwi++7+oZBKnO59jmud3Mp6s0g4E++Kjv/
GvNSjKTOYl82Y433h5GvQ9J14zr/Vu2ZPj3H7XowF4HbFAu9VysfLtNmSSukK2Nu
fXAru8Tfoz3CxrvTUWcaYOU/5I+0uuVUiIdvpeyQHW+Z8KoKE0Bh+w9Y0GK8WoeL
AJGmPrT9aUIP7QgrTreHldsucUjVwA==
=wgDg
-----END PGP SIGNATURE-----

--f7AumrwylgGDBblN--
