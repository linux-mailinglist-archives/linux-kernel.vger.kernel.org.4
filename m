Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68636D4EBF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjDCRPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDCRPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B61BF0;
        Mon,  3 Apr 2023 10:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9FF762276;
        Mon,  3 Apr 2023 17:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E2DC433D2;
        Mon,  3 Apr 2023 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680542103;
        bh=goHoB2jLaOy/EZiBpWOJOkuOxo+2a8uUDASlH5Rjdeo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZwzCFdR2HlV/3xEQ2th+BoUWRZxclFUkHHSDMfWoUpFshEVDp4PwvXfwPfwER46zu
         utJLROIS9/Qc/2ko2aE1xfHFyTEz59HpTsq4MoWb4c8DmwUTg+qDyjk3du2n2sBJvX
         dQUKlZ5L1keWxOxmBB8S08JMiituLrqzxnnE06tbsYuy+/FLZTfjyTp/0PDW7Kairo
         c84lBAg53Eb2j6lj7QaRqTK0B9n6oGkXHkX5TPH+344DGvaXCqX7DY4VXPMy8FoKmA
         nFSYMz35eiNfDuL4I3hMZwKn8jWjD0oZGCwIJEYgZes3oq7ZktScL+GuTEm6fj2N7i
         43CXpTlrr0RJg==
Date:   Mon, 3 Apr 2023 18:14:57 +0100
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
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
Message-ID: <20230403-repose-cartwheel-c3e10c231cae@spud>
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com>
 <a6220e52-9934-422b-9b05-95705b8fd684@spud>
 <b5fba6b3-177c-4325-905a-8f9f633a592a@spud>
 <CANiq72mip7Xs5vnS4KccxCmBmRbKGki7AYTTHxwaeyr3amvSWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XTCdhfO5W5YlGhZZ"
Content-Disposition: inline
In-Reply-To: <CANiq72mip7Xs5vnS4KccxCmBmRbKGki7AYTTHxwaeyr3amvSWw@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XTCdhfO5W5YlGhZZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 06:35:45PM +0200, Miguel Ojeda wrote:
> On Thu, Mar 30, 2023 at 11:12=E2=80=AFAM Conor Dooley
> <conor.dooley@microchip.com> wrote:
> >
> > I'd rather do this in the RISC-V Makefile so that it does not get
> > forgotten.
>=20
> Sounds good to me! We want to have the least amount of things possible
> in the common pieces (e.g. for the target spec file we moved some
> flags); so the more we move out to `arch/`, the better.
>=20
> > If my understanding of bindgen is correct, we don't actually need to be
> > honest to it about what extensions the rest of the kernel is compiled
> > with, only make sure that it is not called with arguments it does not
> > understand?
>=20
> As long as bindgen generates things with the right ABI etc., yeah.
> But, in principle, enabling one extension one side but not the other
> could be wrong if it ends up in something that Rust uses, e.g. if the
> C side does:
>=20
>     #ifdef __ARM_ARCH_7R__
>         int x;
>     #else
>         char x;
>     #endif
>=20
> and Rust attempts to use it, then particular `-march` builds could be bro=
ken.

To be on the safe side then, we should really disable the extensions
across the whole kernel. I don't *think* we have any madness at the
moment like in the above, but it is better to be on the safe side.
As I note below, it's just one extension for now anyway.

> > What version of GCC do I need to replicate this? I can build tip-of-tree
> > gcc if needs be.
>=20
> Sorry, what do you want to replicate? If you mean what we had in the
> old GitHub CI, I see:
>=20
>     CONFIG_CC_VERSION_TEXT=3D"riscv64-linux-gnu-gcc (Ubuntu
> 11.3.0-1ubuntu1~22.04) 11.3.0"
>=20
> which successfully boots in QEMU for the kernel config we tested.

No, I misunderstood your question. I thought you meant something else
entirely.

> But if you are asking what should be supported, I guess it depends on
> the RISC-V maintainers. Ideally, everything that the kernel supports
> (GCC >=3D 5.1),

Heh, as if that number is true across the board!

> but since the GCC+Rust builds are so experimental, I
> think as long as something is tested from time to time, it would be
> great (to at least know not everything is completely broken).
>=20
> But if you think that would be too much effort to maintain, or even
> GCC builds in general, then please feel free to ignore it for the time
> being, i.e. it is better to have LLVM builds rather than nothing! :)

Yeah, it may be worth getting just the LLVM bits in. I abhor the -march
handling and it may end up looking like shite with the zicsr &
zifencei handling.
Worst comes to worst, can permit gcc builds by just removing all the
extensions that get passed in -march for RUST && CC_IS_GCC type
scenarios. The only one of those at the moment is zihintpause & I don't
suppose too many tears will be shed over that.
For now it's safe to assume that LLVM doesn't require zicsr or zifencei
[1], we don't need to do a version dance right away.

=C2=AF\_(=E3=83=84)_/=C2=AF,
Conor.

1 - https://reviews.llvm.org/D147183#4233360

--XTCdhfO5W5YlGhZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCsJkAAKCRB4tDGHoIJi
0sYFAQDDRMpXIXaf93gLvJjaLEOPJ8XmdZ81CElLrdC/W/n/QgD/TsQf3QYbIo/K
DV49NcCFvY9TYFvAJ4G3pq6JXWWEEgw=
=tW4o
-----END PGP SIGNATURE-----

--XTCdhfO5W5YlGhZZ--
