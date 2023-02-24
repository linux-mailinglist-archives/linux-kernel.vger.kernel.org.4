Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954CD6A2354
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXVAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:00:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC227D5F;
        Fri, 24 Feb 2023 13:00:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A09B36198A;
        Fri, 24 Feb 2023 21:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5688BC433D2;
        Fri, 24 Feb 2023 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677272445;
        bh=2hjpyvDNC/wSGd+1eQn8U57a8M+iEjURLEBCMQC9WCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLJpIT7pDDaWlDn2FWpGiTm0l0Hf9NkJskpSVsWOVJierGI3/z/FGex58pkoLVVCv
         crERApewISnJR5PC5YcqPC49xNp2xSRvbVuTmo2pe6kGWjWNlgJeYsRTiJAGLL7tvm
         SZUU4dWGVeNXXodlhfHzBVSNW+4yEdR7ZHGvek4wEemqOYTLuREcikoaV0yrmBP9Bx
         LVEJlNGEUae0AvH8zjtmcy6fu7DtpBV4/DsMo3G6f9mRPxpUCC352meb0i4uAOQjbh
         qOIfH+BK6ruwCTCaylDCiwKm16UxCsYebsidWL00xsFT0hdoo4DgSDqKBtEJaTRXns
         TJMxhiffUXCVA==
Date:   Fri, 24 Feb 2023 21:00:38 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [RFC 0/2] RISC-V: enable rust
Message-ID: <Y/kldmYcl7+2FBRB@spud>
References: <20230224133609.2877396-1-conor.dooley@microchip.com>
 <CANiq72=4ZhV=u2ZUr=x-iAS_iMnV8GSiq0tEn7Tj0NanO=D+xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EzgSW8I33ytRe36y"
Content-Disposition: inline
In-Reply-To: <CANiq72=4ZhV=u2ZUr=x-iAS_iMnV8GSiq0tEn7Tj0NanO=D+xQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EzgSW8I33ytRe36y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2023 at 09:42:08PM +0100, Miguel Ojeda wrote:
> Hi Conor,
>=20
> On Fri, Feb 24, 2023 at 2:37 PM Conor Dooley <conor.dooley@microchip.com>=
 wrote:
> >
> > This is a somewhat blind (and maybe foolish) attempt at enabling Rust
> > for RISC-V. I've tested this on Icicle, and the modules seem to work.
> > I'd like to play around with Rust on RISC-V, but I'm not interested in
> > using downstream kernels, so figured I should try and see what's
> > missing...
> > I've tagged this as RFC in case I've missed some "WAaaaa you can't do
> > this" somewhere :)
>=20
> Thanks for sending this and taking the lead on RISC-V

Meh, far from it. I'm just trying to get the ball rolling if it really
is as trivial as this seems.

> I appreciate
> you put me as the author, but in this case, it was actually Gary that
> started the RISC-V port [1], and then I sent three PRs on top later
> on.

The stuff that I have lifted here all had you as the sole author in the
"rust" branch downstream, which is why I gave you authorship. Namely:
afba78eacb9b ("rust: generate target specification files on the fly")
732b3c386328 ("rust: target: remove `cpu`")

I don't see anything from [1] in these commits, so I don't think that I
made a mistake here.

> When submitting something on behalf of somebody else, I suggest being
> very careful and ideally contacting the authors beforehand. In
> particular, if there has been any modification (including to the
> commit message), then a note should be added explaining so.

It's RFC for a reason, I've had a poor track record with off-list emails
to people that do not know me so would rather do it this way :)
Probably should have noted that I wrote the ~placeholder commit messages
though, apologies. I'll sort that out for a potential v1.

> Therefore, please double-check everybody that contributed to the lines
> you are sending (e.g. via `git-blame`) and add them as

That's what I did! Unless I missed something that was non-obvious, the
only name on the commits I lifted was you. Is there somewhere else I
should have looked for that information?

> `Co-developed-by`. Also, please add a note of what you changed/wrote
> e.g. square brackets, and `Link` tags to the original PRs/discussions.

If this goes to v1, I will note that I wrote the commit messages.

Apologies,
Conor.

--EzgSW8I33ytRe36y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/kldgAKCRB4tDGHoIJi
0kRlAQCUtbv6hyB+QaKgek4dllhjR2OYkuSr5B2c1hLoO5iADAEAs0GElI0VA2QL
tfv3Ync/lLJwVaPRbeh6/nBJInV17wU=
=lKKs
-----END PGP SIGNATURE-----

--EzgSW8I33ytRe36y--
