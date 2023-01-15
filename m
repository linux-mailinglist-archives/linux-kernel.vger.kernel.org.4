Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35BC66B037
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 10:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjAOJuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 04:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbjAOJuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 04:50:15 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02049B75B;
        Sun, 15 Jan 2023 01:50:15 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z11so37035115ede.1;
        Sun, 15 Jan 2023 01:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJbXc+feWdrqTlshVGwB3Z4oTlL8/3Lfs4lGSV6qQxc=;
        b=SVOysDXI/KdXRRvrXHp0ya1LDMJuBWI61lpO+oK8r+0aY0CcpgvqzbUtdCl5zqYJLW
         isB7u9qMSzWpo6eY0TS6hauX8sJOWcviFR8RAwzFr2CVRXF+oTMAIriKigeZazZK1CoG
         HAj3ZyuY+W4j0jj7VINqFaK7aCX9jhqKoGUgeCxNZWPwaoV89H7JPZhUHTnSQ37a+ALA
         An3bX5fpT35o0TEQYAp4jWgWOenmUfSx+1MTB1cmFUnuvINZu6sXRMGqFil3Lm4ES5iF
         wc3mFjKJUT8wzf0E0mecWKemtuHyjH1qnsuIEFd0u81BWAam9kVqlmsm3FYamSyDkUMf
         tBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJbXc+feWdrqTlshVGwB3Z4oTlL8/3Lfs4lGSV6qQxc=;
        b=rWOaWCEphic3nONo1i4w2mDIYuVk5qqMZyKRE1+iXuvdU2bpEJNka8pnzaM1LBBBnb
         /jXjrohojxqMcVDBoel4yMW6C1UheXv4Mlm0K5d2pAuurDjYQHHrWhO8y8DcGm+k6Err
         oinFn2AGr+waqclfOGa2cU8kasXicnE7Omn/n1EOXk9lMponcYiTwbu+g6uBhuj8RaqF
         k+Sq7/46lTmg1yJPVfO0Z7o1ww/aSHEl8YT+rNDV5zUi7tkoRGiLmYNG6GuIBzej599o
         oYmgUeQfOeRWXkBgCn/KqmWzJkLExiNtH/+viU/YdKicBBc3tpkPdNsos577lGWZTXxY
         9WYw==
X-Gm-Message-State: AFqh2kqysYRdrM6pU544+5RW6ZJbz76n3M8O93LDA3TmRA5F3LBnMpWI
        +6A9foVogrEKEsJS+qZn+YJ5DYotBXJOfE211NQ=
X-Google-Smtp-Source: AMrXdXuUzOa2guBRIiKB1uwuexgzh4m3A+XUo+2InfVEBiNvpDerXJvdg/SBbJSjUz5jF+ZBXJGEE0fQbEC1OHVw1eI=
X-Received: by 2002:aa7:cc13:0:b0:49c:bc23:e5c0 with SMTP id
 q19-20020aa7cc13000000b0049cbc23e5c0mr964850edt.252.1673776213567; Sun, 15
 Jan 2023 01:50:13 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-4-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-4-davidgow@google.com>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Sun, 15 Jan 2023 10:49:37 +0100
Message-ID: <CAA76j91c1Uxo04Ymg8HszPOmiMjCzC08iDGL05m1ABa+u_Pw1A@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: arch/um: Add support for CONFIG_RUST under
 x86_64 UML
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
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

On Sat, 17 Dec 2022 at 05:48, David Gow <davidgow@google.com> wrote:
>
> CONFIG_RUST currently supports x86_64, but does not support it under
> UML. With the previous patches applied, adding support is trivial:
> add CONFIG_HAVE_RUST to UML if X86_64 is set.
>
> The scripts/generate_rust_target.rs file already checks for
> CONFIG_X86_64, not CONFIG_X86, so is prepared for UML support.
>
> The Rust support does not currently support X86_32.
>
> Also, update the Rust architecture support documentation to not that
> this is being maintained: I intend to look after this as best I can.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  Documentation/rust/arch-support.rst | 2 ++
>  arch/um/Kconfig                     | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arc=
h-support.rst
> index 6982b63775da..a526ca1c688b 100644
> --- a/Documentation/rust/arch-support.rst
> +++ b/Documentation/rust/arch-support.rst
> @@ -17,3 +17,5 @@ Architecture  Level of support  Constraints
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>  ``x86``       Maintained        ``x86_64`` only.
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +``um``        Maintained        ``x86_64`` only.
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index ad4ff3b0e91e..4db186f019ae 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -28,6 +28,7 @@ config UML
>         select TRACE_IRQFLAGS_SUPPORT
>         select TTY # Needed for line.c
>         select HAVE_ARCH_VMAP_STACK
> +       select HAVE_RUST                        if X86_64
>
>  config MMU
>         bool
> --
> 2.39.0.314.g84b9a713c41-goog
>

Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
