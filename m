Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A4673CDF6
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 04:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjFYCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 22:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjFYCNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 22:13:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F7B10A;
        Sat, 24 Jun 2023 19:13:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D3BF606DC;
        Sun, 25 Jun 2023 02:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A31C433C8;
        Sun, 25 Jun 2023 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687659216;
        bh=tO8ygIBNQgDG09IQJY8tRBeB8/twzooSyi/a2iRZmPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJSJvVSnJxdBSrlwsxs04gMyVeUDOC7H0y9BM7ozxTP8SmX5s6EYRpQjgtqA9EkPT
         x8B6f7hZPd8zd0PU7/P80D2Fjg7///2oJp7TKxhDR3997mz/Oy+p2OK7pbjEiWGCC1
         tcvBKjCWATgBYtwdSdpQe8q41uJhIU8n6WhCvFyhfInooMZH7Pq0Mxm1nf1816+HCR
         9Zf7DOgKIW5/KERl3dxloK87us+Lq7e2+IrjsF1sJnOcH28rHK8SbtGmk6sTKhoyv9
         XkGA3PpXqkKIiTP6H4vruwDzWuBaTT24lzf6u8Dek3AgyEiHjyC0oPvgH44WvjJ19Z
         1Zih4s+D970jA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-98de21518fbso130365466b.0;
        Sat, 24 Jun 2023 19:13:35 -0700 (PDT)
X-Gm-Message-State: AC+VfDwaA4dXUxRhCVoKNyUYuwfNbIaopSyiRRVPzr38s/QgRa+7nxyX
        b9vUtacu+gRt9J1RHMFXreRPQ+oh243hBDOSEN0=
X-Google-Smtp-Source: ACHHUZ7e7ZGxx17j1nJTkWVwVj2OgSY6k/JVOZOyZm7hb2/sSdTOvJSRHjCeW++9haXDHPqDDAMFjsqdjN7hU/an2lk=
X-Received: by 2002:a17:906:30c1:b0:98d:63c5:d132 with SMTP id
 b1-20020a17090630c100b0098d63c5d132mr4946746ejb.72.1687659214276; Sat, 24 Jun
 2023 19:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230624184055.3000636-1-kernel@xen0n.name> <20230624184055.3000636-8-kernel@xen0n.name>
In-Reply-To: <20230624184055.3000636-8-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 25 Jun 2023 10:13:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H54bZ5_OSXtcq3B3d4bZj4GBTOf7Z8aA6Jm7uGdKTj_ug@mail.gmail.com>
Message-ID: <CAAhV-H54bZ5_OSXtcq3B3d4bZj4GBTOf7Z8aA6Jm7uGdKTj_ug@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] LoongArch: Tweak CFLAGS for Clang compatibility
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Sun, Jun 25, 2023 at 2:42=E2=80=AFAM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> Now the arch code is mostly ready for LLVM/Clang consumption, it is time
> to re-organize the CFLAGS a little to actually enable the LLVM build.
>
> In particular, -mexplicit-relocs and -mdirect-extern-access are not
> necessary nor supported on Clang; feature detection via cc-option would
> not work, because that way the broken combo of "new GNU as + old GCC"
> would seem to get "fixed", but actually produce broken kernels.
> Explicitly depending on CONFIG_CC_IS_CLANG is thus necessary to not
> regress UX for those building their own kernels.
>
> A build with !RELOCATABLE && !MODULE is confirmed working within a QEMU
> environment; support for the two features are currently blocked on
> LLVM/Clang, and will come later.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 366771016b99..82c619791a63 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -51,7 +51,9 @@ LDFLAGS_vmlinux                       +=3D -static -n -=
nostdlib
>
>  # When the assembler supports explicit relocation hint, we must use it.
>  # GCC may have -mexplicit-relocs off by default if it was built with an =
old
> -# assembler, so we force it via an option.
> +# assembler, so we force it via an option. For LLVM/Clang the desired be=
havior
> +# is the default, and the flag is not supported, so don't pass it if Cla=
ng is
> +# being used.
>  #
>  # When the assembler does not supports explicit relocation hint, we can'=
t use
>  # it.  Disable it if the compiler supports it.
> @@ -61,8 +63,10 @@ LDFLAGS_vmlinux                      +=3D -static -n -=
nostdlib
>  # combination of a "new" assembler and "old" compiler is not supported. =
 Either
>  # upgrade the compiler or downgrade the assembler.
>  ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> +ifndef CONFIG_CC_IS_CLANG
>  cflags-y                       +=3D -mexplicit-relocs
>  KBUILD_CFLAGS_KERNEL           +=3D -mdirect-extern-access
> +endif
I prefer to drop CONFIG_CC_IS_CLANG and use
cflags-y                       +=3D $(call cc-option,-mexplicit-relocs)
KBUILD_CFLAGS_KERNEL           +=3D $(call cc-option,-mdirect-extern-access=
)

Then Patch-6 can be merged in this.

What's your opinion?

Huacai
>  else
>  cflags-y                       +=3D $(call cc-option,-mno-explicit-reloc=
s)
>  KBUILD_AFLAGS_KERNEL           +=3D -Wa,-mla-global-with-pcrel
> --
> 2.40.0
>
