Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16DF740AA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjF1IIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjF1IBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C912D72;
        Wed, 28 Jun 2023 00:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6569A6123C;
        Wed, 28 Jun 2023 04:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90DCC433CC;
        Wed, 28 Jun 2023 04:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687926172;
        bh=X3rvLe7iT1fsUty/3X7jBr4yKHG5Fo+ow7WiOnlm/OY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZhvOamz2SSgjdgsYUzyx8dChx82/qE+ipvNsapcBvuyS3D98jiQj65p1O97Hl9NLX
         f/2uF8eNTAUyoVnQQ99zxuLbtPGvw+mOPC17Zk80Jr0Byxi/LSDO+8qTN/Uqwynd17
         j6DyMeQfkayDPKkKpmSEw24/egB12eL+i/rU52nkqFtaDlXiIiZc6kYvoNcx3oS/75
         8tY/Zx9BJEFDkUrKRtSYdn9o+x9zSELLzvPGBMq3LyVUv3H5TknUDKNJlM6aselwOr
         lVFgTdQ5u7mVjYOTtA3D7xPSx6qMk94IQLNDWlCL5dkRIgHF7LduUpmtvStei/4vQ+
         w8Fm6geHZRQ4A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-51d95aed33aso3356036a12.3;
        Tue, 27 Jun 2023 21:22:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDz1uZ6ZcjigbadIT+zl/rxxZ9CCa65P9S+x+DN1OLaCF9WHQrl9
        pGTg+Y0bI0tTUjnyWgqTxUAapo4W24tHwotErjE=
X-Google-Smtp-Source: ACHHUZ5lQ/OUgzU/r2jKXXgQTJJNNX1ps35U07SrvvAOjGzO8AVNbAs0Emji5F2TczIfBYlqW3wazYu2gYxNb9AUKt0=
X-Received: by 2002:aa7:c7cf:0:b0:514:8eb7:d587 with SMTP id
 o15-20020aa7c7cf000000b005148eb7d587mr17503964eds.17.1687926171043; Tue, 27
 Jun 2023 21:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230627130122.1491765-1-kernel@xen0n.name> <20230627130122.1491765-3-kernel@xen0n.name>
 <20230627162512.GB223742@dev-arch.thelio-3990X>
In-Reply-To: <20230627162512.GB223742@dev-arch.thelio-3990X>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 28 Jun 2023 12:22:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5jU9xWe3Us2R5hqnny5tf+wEZ3LFH5AqZBfaoE+J888w@mail.gmail.com>
Message-ID: <CAAhV-H5jU9xWe3Us2R5hqnny5tf+wEZ3LFH5AqZBfaoE+J888w@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Include KBUILD_CPPFLAGS in CHECKFLAGS invocation
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, WANG Rui <wangrui@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>, loongarch@lists.linux.dev,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.

Huacai

On Wed, Jun 28, 2023 at 12:25=E2=80=AFAM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> On Tue, Jun 27, 2023 at 09:01:22PM +0800, WANG Xuerui wrote:
> > From: WANG Xuerui <git@xen0n.name>
> >
> > This is a port of commit 08f6554ff90e ("mips: Include KBUILD_CPPFLAGS
> > in CHECKFLAGS invocation") to arch/loongarch, for fixing
> > cross-compilation of Linux/LoongArch with Clang, where previously the
> > `--target` flag would no longer be present for the CHECKFLAGS cc
> > invocation leading to build failure.
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
> >  arch/loongarch/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index a63683da3bcf..09ba338a64de 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -112,7 +112,7 @@ KBUILD_CFLAGS +=3D -isystem $(shell $(CC) -print-fi=
le-name=3Dinclude)
> >  KBUILD_LDFLAGS       +=3D -m $(ld-emul)
> >
> >  ifdef CONFIG_LOONGARCH
> > -CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CFLAGS) -dM -E -x c /dev/null |=
 \
> > +CHECKFLAGS +=3D $(shell $(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -dM =
-E -x c /dev/null | \
> >       grep -E -vw '__GNUC_(MINOR_|PATCHLEVEL_)?_' | \
> >       sed -e "s/^\#define /-D'/" -e "s/ /'=3D'/" -e "s/$$/'/" -e 's/\$$=
/&&/g')
> >  endif
> > --
> > 2.40.0
> >
