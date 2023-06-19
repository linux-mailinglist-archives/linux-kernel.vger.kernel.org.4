Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81492735DA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFSS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFSS6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:58:42 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667918C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:58:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so4933599e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google; t=1687201119; x=1689793119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIUqA0rcSlk22wNkCwu8p2OK1XKL+AlvaBKhRl9Deog=;
        b=Df4GXWhRRUFLnOveDK8hfvwd48RBrvQO8w2FAxtEuEwDdipeUoSfZ50kZXGW0h9VSb
         gbEczQ+4zmK62ezKKxFoMO7CM9ActHZjxlk5clXTK7MCLdZJEQbp8Iaj7dO5/H+FZCV7
         haf8zABDvR53HP3z3HjL9X7d20Vjmr6PAMifc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687201119; x=1689793119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIUqA0rcSlk22wNkCwu8p2OK1XKL+AlvaBKhRl9Deog=;
        b=cxotB3H7wH2wBisXCAPoBnxzjHqa6MyzBxCiT0VQWPaK3P+O/lmAPjbDX51gTgg9w9
         rHsaayhBAJZoktu8CqZlvnYWEnk0zzq+d530yQ4t9IKGuH6kEm0z+zvk40wThcgVFYzz
         c3xUCuzr5HtglwfCCxEkGeKC+LJ6dyNLHmiptKZYZbU44vKFEAYkR+zx8YoQ8UUjFOPf
         Z6qSQSzklFVVoy6XNECMt8H7XdgFf+uGO2BmX5OfuuOhc9nFfACwLcKf2/YRLFJVq6AN
         mJe3WUHGtsjHo3TG9yl6oAxIXM7Q1uTr2dW2H5/0H+3bRt/bcEmrRzVvdX5qegQDkVXm
         DhCw==
X-Gm-Message-State: AC+VfDwvfKY2Hmf15qlSxEL0+yhKD8f9RtHWFdE/lwJd816E6EI4OGal
        +j93yiRoyW6DGLOwc+05Fw4zQHtAY53RqLRI5Kuk
X-Google-Smtp-Source: ACHHUZ6la5UyKR8hrXvI002lIEv1MDyAtdLvfOV6K2EKG0u9ts0sSq+5LA8R8Q0q7PRSIdMI7FtvKjtqtc3ZTgaiRuE=
X-Received: by 2002:a2e:9548:0:b0:2ad:99dd:de07 with SMTP id
 t8-20020a2e9548000000b002ad99ddde07mr5430627ljh.16.1687201119335; Mon, 19 Jun
 2023 11:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230619094705.51337-1-alexghiti@rivosinc.com> <20230619094705.51337-2-alexghiti@rivosinc.com>
In-Reply-To: <20230619094705.51337-2-alexghiti@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 19 Jun 2023 11:58:28 -0700
Message-ID: <CAOnJCUJ5BgApWz3=F7f_CwATF0CV8dnZNw6hPYL0=b7-p63TiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Documentation: riscv: Update boot image header since
 EFI stub is supported
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 2:48=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The EFI stub is supported on RISC-V so update the documentation that
> explains how the boot image header was reused to support it.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  Documentation/riscv/boot-image-header.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/riscv/boot-image-header.rst b/Documentation/ri=
scv/boot-image-header.rst
> index a4a45310c4c4..df2ffc173e80 100644
> --- a/Documentation/riscv/boot-image-header.rst
> +++ b/Documentation/riscv/boot-image-header.rst
> @@ -28,11 +28,11 @@ header in future.
>  Notes
>  =3D=3D=3D=3D=3D
>
> -- This header can also be reused to support EFI stub for RISC-V in futur=
e. EFI
> -  specification needs PE/COFF image header in the beginning of the kerne=
l image
> -  in order to load it as an EFI application. In order to support EFI stu=
b,
> -  code0 should be replaced with "MZ" magic string and res3(at offset 0x3=
c) should
> -  point to the rest of the PE/COFF header.
> +- This header is also reused to support EFI stub for RISC-V. EFI specifi=
cation
> +  needs PE/COFF image header in the beginning of the kernel image in ord=
er to
> +  load it as an EFI application. In order to support EFI stub, code0 is =
replaced
> +  with "MZ" magic string and res3(at offset 0x3c) points to the rest of =
the
> +  PE/COFF header.
>
>  - version field indicate header version number
>
> --
> 2.39.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

--=20
Regards,
Atish
