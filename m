Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C646676BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 15:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALOfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 09:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238021AbjALOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 09:33:53 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7E25585E;
        Thu, 12 Jan 2023 06:25:42 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id fy8so45046462ejc.13;
        Thu, 12 Jan 2023 06:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYpqbjdLUiH8F5H1EJG0ptUSVdez6XT9MKBwFyuoI2o=;
        b=WdTaqzvFjo3/K9YUHrDGwic5e44c1ojtJE2M9bn/xjrQUOCGPy5uMKteHS5CesqTOx
         A8XSjVIvtzUUR1pymfl4C3JLi3ERHX3mq52bHs4UliQa2bjDgpykQcc+5PBwjHuDHatZ
         XkcnjKg/gSmihb+ZRknkc13ouU0z4s1Tcqqlq0JwJWtQMHlr2jVlmzYw0mx59/jTUyuN
         sgIjAoh9pUzgbxigArv2QhA14Y3wFc+xe3tJEekRLTtKzcB6tfx2hjVZjr9VXG87nCgi
         LMMGCEr7JhgPtzwbYc17UNYQybrhrb8ECSQKtZfMg15NRnP3g2sA1EUfovxxPJ0GSqJj
         /qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYpqbjdLUiH8F5H1EJG0ptUSVdez6XT9MKBwFyuoI2o=;
        b=unt5UGkA3iBwqubiKcsTlsVibi3ctzSLtbVV2wSuhh2e9NndAlgREei3ktHIEcU9U1
         18vANlfUVrqetxQVRyl4VBCRu0ivA8gvo5pHsPHCljBM1Q/Gx0G968GJ4V2CPggFzjsx
         FSqaAl1jLRN83M04l41BncTlg65fL/IBJvGguPBi1KkpaaY6kU/9dHFa2nMI/uV3yjlX
         y0ASbPjlCjaY9kN/lo8IvMVbTEDoNSprxW4gQnNqftw5ONMBjOh0GIhqNZgRvDK0+Ni5
         7RZAhD//RnafuiPU565KmKsgUMrDmPkrn0EVEv11M06OuMeSqus1ZFDs6lasdCSqrOSq
         mcwg==
X-Gm-Message-State: AFqh2kqZ1FgwXM2J6Xmnm49QK1ijjYo/Pmqw6Yk2tDAhVrHLbgaF53og
        FkUtmmqGt9VsIjNKnq1g8GQ=
X-Google-Smtp-Source: AMrXdXtfDk1CKgSiYb0Pxnr+Jv456eavOCuqTkBLuld1MUlN3/b/LR7FCyoooB1eYE6Ta1ukM1kFYA==
X-Received: by 2002:a17:907:6e05:b0:7c1:235d:2a2b with SMTP id sd5-20020a1709076e0500b007c1235d2a2bmr85006546ejc.24.1673533540433;
        Thu, 12 Jan 2023 06:25:40 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:3285:c486:87d3:b4eb])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007a4e02e32ffsm7532398ejc.60.2023.01.12.06.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 06:25:39 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 12 Jan 2023 15:25:38 +0100
Message-Id: <CPQA4LWQZOX1.31XJYNUR2O449@vincent>
To:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@lists.linux.dev>,
        "Domen Puncer Kugler" <domen.puncerkugler@nccgroup.com>
Subject: Re: [PATCH] rust: print: avoid evaluating arguments in `pr_*`
 macros in `unsafe` blocks
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.8.2
References: <20230109204912.539790-1-ojeda@kernel.org>
In-Reply-To: <20230109204912.539790-1-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 9, 2023 at 9:49 PM CET, Miguel Ojeda wrote:
> At the moment it is possible to perform unsafe operations in
> the arguments of `pr_*` macros since they are evaluated inside
> an `unsafe` block:
>
>     let x =3D &10u32 as *const u32;
>     pr_info!("{}", *x);
>
> In other words, this is a soundness issue.
>
> Fix it so that it requires an explicit `unsafe` block.
>
> Reported-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Reported-by: Domen Puncer Kugler <domen.puncerkugler@nccgroup.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/479
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
> ---
>  rust/kernel/print.rs | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 29bf9c2e8aee..30103325696d 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -142,17 +142,24 @@ pub fn call_printk_cont(args: fmt::Arguments<'_>) {
>  macro_rules! print_macro (
>      // The non-continuation cases (most of them, e.g. `INFO`).
>      ($format_string:path, false, $($arg:tt)+) =3D> (
> -        // SAFETY: This hidden macro should only be called by the docume=
nted
> -        // printing macros which ensure the format string is one of the =
fixed
> -        // ones. All `__LOG_PREFIX`s are null-terminated as they are gen=
erated
> -        // by the `module!` proc macro or fixed values defined in a kern=
el
> -        // crate.
> -        unsafe {
> -            $crate::print::call_printk(
> -                &$format_string,
> -                crate::__LOG_PREFIX,
> -                format_args!($($arg)+),
> -            );
> +        // To remain sound, `arg`s must be expanded outside the `unsafe`=
 block.
> +        // Typically one would use a `let` binding for that; however, `f=
ormat_args!`
> +        // takes borrows on the arguments, but does not extend the scope=
 of temporaries.
> +        // Therefore, a `match` expression is used to keep them around, =
since
> +        // the scrutinee is kept until the end of the `match`.
> +        match format_args!($($arg)+) {
> +            // SAFETY: This hidden macro should only be called by the do=
cumented
> +            // printing macros which ensure the format string is one of =
the fixed
> +            // ones. All `__LOG_PREFIX`s are null-terminated as they are=
 generated
> +            // by the `module!` proc macro or fixed values defined in a =
kernel
> +            // crate.
> +            args =3D> unsafe {
> +                $crate::print::call_printk(
> +                    &$format_string,
> +                    crate::__LOG_PREFIX,
> +                    args,
> +                );
> +            }
>          }
>      );
> =20
>
> base-commit: b7bfaa761d760e72a969d116517eaa12e404c262
> --=20
> 2.39.0

