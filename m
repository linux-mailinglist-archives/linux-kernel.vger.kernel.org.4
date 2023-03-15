Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7896BB8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjCOP6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbjCOP6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:58:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C484812;
        Wed, 15 Mar 2023 08:57:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r27so24879041lfe.10;
        Wed, 15 Mar 2023 08:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678895852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HfvOgH6XMk8F0fEjXMcYG1J1t/zw9awT0qO/UEb2Wa4=;
        b=hGTzg5TIgK5kuL2IOWtndLVU7X+sT8E3hG/yTuI2L7evZaDoszR+0OgM00E73PjbcR
         x29ONEL6gDvtUKJviDo4Zog+ydSmngJ2eF7GcXQ9gzyjbiLtH62QdRugIX64XhJHVSfy
         k5/uifP9QGX9BjSBCqXELMi2bVjnYxv0ncOdpfHwnulBrBIgDCpCx51atS5s58/CUyx+
         BuV2a12xMrHJAg4a4/4Nf+5UAsq1o6TcwrLlloU5+H1j9ohBUgcD04iotu4wCTLKMygC
         Mx9OFs6Sc5LzDeIbJI/Uf/lnIm57mrl0acLOcy34N2FWbm0qjfNQXA4gH7UUFjvj2vXn
         /yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678895852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HfvOgH6XMk8F0fEjXMcYG1J1t/zw9awT0qO/UEb2Wa4=;
        b=e5qIdoDzFGhQ8/wJ/GOCuJTpMTW3onwQyrCgFlXw1DIHMNJOOZSBca0p1lKvXHyvZU
         pHUYfcN44+8BALoFJSgZgZS31+ZLaxzekKxO7J63ZuMgaVaPN4wggch+JyCiucNhiwlI
         mXn3ycCMHTCR9FJMb1u0BMtetYEYvn2612ocQB3YLYumkTLD/5BP9Q9EKuxf2hIx4QB9
         SNg5Q5CB89rKLLV55gQM/9fAlmAW9/LIifdG5oBEwQM7cY9zKc2cKZVB09pLHHW6mrqe
         4EZULBYfeBqivlH6UK2YxqsYb7XM7quEjXOSWYjOBahDNcU61DDoMkztb9F3bqKtWF5M
         Hwyg==
X-Gm-Message-State: AO0yUKVn6kdYCaxbhnKtoqBTcjRtiHB+jtxhu6EXIKDgL1wer9ZXPlES
        2lWlDlKNOclSI1znrGk9HSNbG40jEXAD0eI64rA=
X-Google-Smtp-Source: AK7set+5krNCEg7awCbli3U7oD+UcxbYMwXFN8t3XINwP/+sCh/rsmN4HP5Nmdb8jhVoFOQz9HXOmiwdyqUGNVPJ0UI=
X-Received: by 2002:ac2:562b:0:b0:4e8:426d:123f with SMTP id
 b11-20020ac2562b000000b004e8426d123fmr2148772lff.11.1678895851603; Wed, 15
 Mar 2023 08:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230313171036.268407-1-bage@linutronix.de> <20230313171036.268407-2-bage@linutronix.de>
 <CAK7LNARd8rQdwauAvgSo-+wxv=rU-4tTCtrzRJ2uhgWRrt6Xxw@mail.gmail.com>
 <63232be8-59f6-8b93-96be-730f5126f60c@linutronix.de> <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
In-Reply-To: <CAK7LNAQ_EhN+6PhcStp8xEOuyLT77t4OJ=E33xTvqVZM-7+Z7A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Mar 2023 16:56:54 +0100
Message-ID: <CA+icZUV1ng9-TurSfKFuYueuHUbdkCxy3hsMOM9DrtTVL0SsHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] kbuild: deb-pkg: Allow parallel build
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bastian Germann <bage@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 3:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Tue, Mar 14, 2023 at 3:56=E2=80=AFAM Bastian Germann <bage@linutronix.=
de> wrote:
> >
> > Am 13.03.23 um 18:59 schrieb Masahiro Yamada:
> > > On Tue, Mar 14, 2023 at 2:10=E2=80=AFAM Bastian Germann <bage@linutro=
nix.de> wrote:
> > >>
> > >> Currently, the only way to build the deb-pkg generated package paral=
lely
> > >> is adding -jN to the MAKEFLAGS environment variable. The package ign=
ores
> > >> the usual parallel build option that is described in Debian Policy =
=C2=A74.9.1.
> > >
> > >
> > >
> > > "dpkg-buildpackage -b -j16" worked for me.
> >
> > This ends up in DEB_BUILD_OPTIONS=3Dparallel=3D16 being set and the cal=
l:
> > /usr/bin/make -f ./Makefile ARCH=3Dx86    KERNELRELEASE=3D6.3.0-rc2 KBU=
ILD_BUILD_VERSION=3D1  olddefconfig all
>
>
> "dpkb-buildpackage -j<N>" sets not only DEB_BUILD_OPTIONS
> but also MAKEFLAGS.
>
>
> This is clearly explained in "man dpkb-buildpackage".
>
>
>  -j, --jobs[=3Djobs|auto]
>    ...
>   Will add itself to the MAKEFLAGS environment variable, which should
>   cause all subsequent make invocations to inherit the option, thus
>   forcing the parallel setting on the packaging ...
>
>
>
>
> Your statement sounds like
>
>  'MAKEFLAGS=3D-j<N> dpkg-buildpackage'
>
> is the only way to build packages in parallel.
>
> Apparently, dpkg-buildpackage provides a much shorter way
> and invokes internal Make in parallel.
>
>
>
>
> >
> > So it is not used to run the actual build, just the top level `make -f =
debian/rules` invocation.
> > You can set --jobs-force=3D16, which ends up in MAKEFLAGS but the point=
 of the patch is that one can use
> > the usual way of parallelizing.
>
>
> What is the "usual" way in this context?
>
>
> Do you mean
> 'DEB_BUILD_OPTIONS=3Dparallel=3D16 dpkg-buildpackage -b'
> is the usual way for parallel building?
>
> If so, I agree. This patch caters to this case.
>
>
> But, I think your code should go to debian/rules
> instead of scripts/package/deb-build-option.
> Kbuild's "make clean" works much faster with the parallel option.
>
>
> Also, the commit description should explain the
> benefit of this patch.
>
>
> >
> > Side note: Without the patch, the build is run with -j1 regardless of b=
eing called from the Linux Makefile
> > or dpkg-buildpackage.
>
>
> Try:
>
>  $ make deb-pkg -j16
>
> and
>
>  $ dpkg-buildpackage -b -j16
>
>
> Both run the package building in parallel.
>
> You see a big difference in build speed w/wo the -j option.
> (and the build logs are interleaved, since they
> are emitted by multiple threads)
>
>

I have no strong opinion in having a DEB_BUILD_OPTIONS...

As you stated Masahiro I have seen it mostly in debian/rules.

See the example from [1]:

ifneq (,$(filter parallel=3D%,$(DEB_BUILD_OPTIONS)))
    NUMJOBS =3D $(patsubst parallel=3D%,%,$(filter parallel=3D%,$(DEB_BUILD=
_OPTIONS)))
    MAKEFLAGS +=3D -j$(NUMJOBS)
endif

Normally, I use in my kernel build-script:

$ make deb-pkg -j${NUMJOBS}

My =E2=82=AC0,02.

-Sedat-


[1] https://www.debian.org/doc/debian-policy/ch-source.html#s-debianrules-o=
ptions
