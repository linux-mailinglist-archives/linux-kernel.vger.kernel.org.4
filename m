Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2786C59A3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjCVWy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjCVWyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 18:54:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465F2B9DF;
        Wed, 22 Mar 2023 15:54:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PhkLl5lvLz4x4r;
        Thu, 23 Mar 2023 09:54:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679525680;
        bh=Dw9KKHFRKsyBtU+fKJlSyEZzpIz6Kgnh88k47o4lQ3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VNyHo+YwULsiYliqm+LCt6aT/ZSZV8lwc5+WCq9lmwEsq5jZlmXkyozvOFzr7JxX7
         DbwWT+8tAGIMsCW4E3KGwcWTBli2yQCsn/ai7P9Ri+OD36QpvfkaBV57XAgvPNUpmz
         vaZfJvGkHpQpqWoy3NZ2xeugxmbnIulNAVNu1NqOaNXktJmAK2O8vkC/GABxq3nrOi
         x7HIfmLykDHx6gT/MqaC4H5iE7JMTB4kgtIa0pSzARJYik9c+COTdyxRNSb8jlAKXj
         lrlCJD8budbcmyXbCxBkgjoHtQQsttQk32+jKxpTjYHW6ncOS79kYCWBtvBRMfv7hg
         0cxoyci7Ig9Jg==
Date:   Thu, 23 Mar 2023 09:54:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        namhyung@kernel.org
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20230323095437.1ecccec1@canb.auug.org.au>
In-Reply-To: <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
References: <20230317095025.49aa34f9@canb.auug.org.au>
        <20230322083956.5c051777@canb.auug.org.au>
        <CAP-5=fUHqrQWPjk7QJB=r2Gzj7z5X3nL4bRuBAKzy2HvdSAr-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rQxJ09ZAjJuMdiri0xFiojP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rQxJ09ZAjJuMdiri0xFiojP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, 22 Mar 2023 11:37:31 -0700 Ian Rogers <irogers@google.com> wrote:
>
> On Tue, Mar 21, 2023 at 2:40=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > Hi all,
> >
> > On Fri, 17 Mar 2023 09:50:25 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > After merging the perf tree, today's linux-next build (native perf)
> > > failed like this:
> > >
> > > Auto-detecting system features:
> > > ...                         clang-bpf-co-re: [  [32mon [m  ]
> > > ...                                    llvm: [  [31mOFF [m ]
> > > ...                                  libcap: [  [32mon [m  ]
> > > ...                                  libbfd: [  [32mon [m  ]
> > >
> > > make[1]: *** Deleting file '/home/sfr/next/perf/util/bpf_skel/vmlinux=
.h'
> > > libbpf: failed to find '.BTF' ELF section in /boot/vmlinux-6.0.0-5-po=
werpc64le
> > > Error: failed to load BTF from /boot/vmlinux-6.0.0-5-powerpc64le: No =
data available
> > > make[1]: *** [Makefile.perf:1075: /home/sfr/next/perf/util/bpf_skel/v=
mlinux.h] Error 195
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile.perf:236: sub-make] Error 2
> > > Command exited with non-zero status 2
> > >
> > > To be clear this is a native build of perf on a PPC64le host using th=
is
> > > command line:
> > >
> > > make -C tools/perf -f Makefile.perf -s -O -j60 O=3D../perf EXTRA_CFLA=
GS=3D-Wno-psabi
> > >
> > > (I could probably remove the EXTRA_CLFAGS now that I am building with
> > > gcc 12.2)
> > >
> > > I don't know which commit caused this.
> > >
> > > I have used the perf tree from next-20230316 for today. =20
> >
> > I am still getting this build failure. =20
>=20
> The build failure is intentional as not having BPF skeleton support in
> the perf tool will remove features. I've just sent:
> https://lore.kernel.org/lkml/20230322183108.1380882-1-irogers@google.com/
> Which will recommend adding NO_BPF_SKEL=3D1 to your build options when
> this failure occurs. I didn't think a features test was appropriate
> for this as the feature test would basically replicate the vmlinux.h
> generation and I didn't want to move that support through the build
> system.

I was trying to understand why this step fails, but from the error
messages, it seems to require something to be present in the distro
supplied kernel image?  Is there something missing from the ppc
build process?  Or toolchain?  Why is it looking at the installed
kernel and not the built kernel?  Does the perf build now depend on the
kernel being built first?

I will add NO_BPF_SKEL=3D1 to my build from tomorrow, but surely that
means that we miss some perf build testing :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/rQxJ09ZAjJuMdiri0xFiojP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQbhy4ACgkQAVBC80lX
0GzwWAf/UuEFMTTa5jcaleQQeBi0lX8Ewaa8JCUjQXXPj3+i8zzXQCwJPNR1ALTI
R5w/eWZAa26XrGG+BYEnq0kB/CCLxOj4LNLXwGUDZMvOuELcHuDoUelOoK5M9d9/
xi+4PuKSGxieXZ5Yu5pEe6zvu3c5I8JlX1njDjirNyNX/xd5qP9VD7Qn7Cfk4j1E
n3p6Wjm3jp4SaIQLizsME0KbR7DdT3mIEr/E19mcuSFx+J5kIYrmWCtPidUuR21f
1UbkvXPKtqo9VO84ZWeEp0lICxPaJkSoWOM+EGWW81C8HGXYkuKRC2wDSkDjN26u
H3kgSW+IRV7xzgQxsyW4SqOGnlowZw==
=a4HK
-----END PGP SIGNATURE-----

--Sig_/rQxJ09ZAjJuMdiri0xFiojP--
