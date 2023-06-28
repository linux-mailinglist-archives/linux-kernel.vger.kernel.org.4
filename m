Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2631B740A51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjF1ICD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:02:03 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:44620 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbjF1H7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:59:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD2761227;
        Wed, 28 Jun 2023 04:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4181EC433CA;
        Wed, 28 Jun 2023 04:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687926150;
        bh=E3cMC1OQGi1J1pe3NYVGtGoJHPH7rhJK8+ImhoRtZnM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=blRrkp5fGfDYZjME7oxp79y1t4UBgdiSTArjFD9e0VObw8M2NnRSWAVZ07eqnO6Zb
         BWNDzpydl1KBnMBI7oxdWEb3kIx6Uajkrdhe7n7YYiYrmpFrcXwDaAVEJfUYZFhkza
         GAhshZngBARHXJvRCCNUvbAeVr27B8dfQwdWCzIhBIkhMoXXRKotWhfDBq1ZXvkv1R
         R8656hY7K9DcrLOglckLAhRS+8tmxUv1xoNKnVAm4xngmm30VSfH7IFHfp0XDK3AV1
         QzgSFflZno0YbV7f4aEJ7mia9DtOUsdXRpUq0lz4NFh9zHICVq7ifRdhSJJh8O6hW8
         BcnOEaGDX8IQg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d80d81d6eso4671150a12.1;
        Tue, 27 Jun 2023 21:22:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDxJTXbNwH52VIjkQ936dHN5CcSHen01jGMtfciqbfsomdeTCg92
        noq4ks6kWICcvcxSdU9j8+cUSAQsvKA275pwzTg=
X-Google-Smtp-Source: ACHHUZ4uzjpla0PpOSz7jN5NaYu5agLcovOE+HYx95odgKreDQRpg1KAvz2GEMXy5EMzysJilLMiKt2x2E5aG/OwbKs=
X-Received: by 2002:a05:6402:12d3:b0:51d:988d:5ed8 with SMTP id
 k19-20020a05640212d300b0051d988d5ed8mr5576748edx.29.1687926148447; Tue, 27
 Jun 2023 21:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230627130122.1491765-1-kernel@xen0n.name> <20230627130122.1491765-2-kernel@xen0n.name>
 <20230627162456.GA223742@dev-arch.thelio-3990X>
In-Reply-To: <20230627162456.GA223742@dev-arch.thelio-3990X>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 28 Jun 2023 12:22:15 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5P1+hToeNFO2Np5v2EorPK4B9Fmh5U4n+aHRDsaOnYcw@mail.gmail.com>
Message-ID: <CAAhV-H5P1+hToeNFO2Np5v2EorPK4B9Fmh5U4n+aHRDsaOnYcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] LoongArch: vDSO: Use CLANG_FLAGS instead of filtering
 out '--target='
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Wed, Jun 28, 2023 at 12:24=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Tue, Jun 27, 2023 at 09:01:21PM +0800, WANG Xuerui wrote:
> > From: WANG Xuerui <git@xen0n.name>
> >
> > This is a port of commit 76d7fff22be3e ("MIPS: VDSO: Use CLANG_FLAGS
> > instead of filtering out '--target=3D'") to arch/loongarch, for fixing
> > cross-compilation with Clang.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1787#issuecomment=
-1608306002
> > Signed-off-by: WANG Xuerui <git@xen0n.name>
>
> Thanks for the patch!
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  arch/loongarch/vdso/Makefile | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefil=
e
> > index 3f9df4d9930f..a50308b6fc25 100644
> > --- a/arch/loongarch/vdso/Makefile
> > +++ b/arch/loongarch/vdso/Makefile
> > @@ -12,12 +12,9 @@ ccflags-vdso :=3D \
> >       $(filter -E%,$(KBUILD_CFLAGS)) \
> >       $(filter -march=3D%,$(KBUILD_CFLAGS)) \
> >       $(filter -m%-float,$(KBUILD_CFLAGS)) \
> > +     $(CLANG_FLAGS) \
> >       -D__VDSO__
> >
> > -ifeq ($(cc-name),clang)
> > -ccflags-vdso +=3D $(filter --target=3D%,$(KBUILD_CFLAGS))
> > -endif
> > -
> >  cflags-vdso :=3D $(ccflags-vdso) \
> >       -isystem $(shell $(CC) -print-file-name=3Dinclude) \
> >       $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
> > --
> > 2.40.0
> >
