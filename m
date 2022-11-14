Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE86C628A39
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiKNUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiKNUMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:12:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC491B7A9;
        Mon, 14 Nov 2022 12:12:04 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n12so31023996eja.11;
        Mon, 14 Nov 2022 12:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ovN/KmE3k+WBFZFXF8j1G39y12WeXYLS+PvRskBsx0=;
        b=GuJ0+9mUHfci0E4m5LUtezP8A7urTPPz7Xe9SGVcUwua0Ng41nRyDaobl9GxxbigEb
         DLGt9yaDZzJFUN9+IZC0rS8UvY+H3AUFKSZTqzE0W0lshN3CKl8QaLj/xcii3z5FGGoX
         JnTESJZXxSBAnQmNzuJQENTcePLRqby1foUR6IAe4aVvzYNmUiDPv//e0a6rHGP7c+ru
         Op16OpgovM1WUmUDedkKCHGsHfXlIbV+Y1JjAdA6dj3b0XTsEj7EzSLwoSbwnJMRZWbY
         WFi+j+6wcgA6uSBApRUyZA4JWlnNEpHNs7StKbZ3iXvxRMFK+1eFU/AqYIVXXE13Fkr9
         pADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ovN/KmE3k+WBFZFXF8j1G39y12WeXYLS+PvRskBsx0=;
        b=Yeg5J1ZnqyGpLrd0EFwuEcQkmz9XhW0a6oi+QHfnm87CIRf7my6dL2x3uB67L616Sw
         1rKwhUnTUs6tCVN4ursZ9iNJul66NErpZLwfsJ8L0q+M4AMecFajJnUKQAXMUg2YdLH4
         F+S5FTCSLTJz7AtYeW0r129xsMF8FrgF1EA0I304oUY2wLH8+M7i3TVPJJKrgCODPZVg
         q0KC2JJtTUemKT5E55gtEuVHMl3sjHpWCuvDYi0R3BD1bmWM3syVhp+Ut+GOpI/6ydp0
         4Qq/QavQ86mtiPrDa4dYRjudRyhBq7HycR09hqwfxvKdpBdjVf4uq2pBPbzR1RbKg5mE
         Z95A==
X-Gm-Message-State: ANoB5pkRVthz+gq/tofISm/zHWN1BhdVaEBmYFM0Ob3EUUceKsHTP+1M
        rp1C05+loKxHCsbsIwYLVLknUM0scpmhMZ9xNJQ=
X-Google-Smtp-Source: AA0mqf7NJaKP0ZVifrUvt2QaQi3MyML22OuhUmA2BJI1cjIppjX46PWdBheofNojnXAi53QjrzRkL8kWrTQFKQDyoJE=
X-Received: by 2002:a17:906:68c4:b0:7ad:d662:f568 with SMTP id
 y4-20020a17090668c400b007add662f568mr10962621ejr.616.1668456723383; Mon, 14
 Nov 2022 12:12:03 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-4-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-4-ojeda@kernel.org>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Mon, 14 Nov 2022 10:04:14 -0500
Message-ID: <CAA76j93h4i+xSPU0BEVaJr60aK9+GLqaqADrOkDtLGpj54nLGw@mail.gmail.com>
Subject: Re: [PATCH v1 03/28] rust: print: add `pr_cont!` macro
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 at 11:43, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> This level is a bit different from the rest since it does not
> pass the module name to the `_printk()` call.
>
> Thus add a new parameter to the general `print_macro!` to
> handle it differently.
>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/print.rs | 72 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
> index 694f51c6da5c..29bf9c2e8aee 100644
> --- a/rust/kernel/print.rs
> +++ b/rust/kernel/print.rs
> @@ -81,6 +81,7 @@ pub mod format_strings {
>      pub static NOTICE: [u8; LENGTH] =3D generate(false, bindings::KERN_N=
OTICE);
>      pub static INFO: [u8; LENGTH] =3D generate(false, bindings::KERN_INF=
O);
>      pub static DEBUG: [u8; LENGTH] =3D generate(false, bindings::KERN_DE=
BUG);
> +    pub static CONT: [u8; LENGTH] =3D generate(true, bindings::KERN_CONT=
);
>  }
>
>  /// Prints a message via the kernel's [`_printk`].
> @@ -111,6 +112,26 @@ pub unsafe fn call_printk(
>      }
>  }
>
> +/// Prints a message via the kernel's [`_printk`] for the `CONT` level.
> +///
> +/// Public but hidden since it should only be used from public macros.
> +///
> +/// [`_printk`]: ../../../../include/linux/printk.h
> +#[doc(hidden)]
> +#[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
> +pub fn call_printk_cont(args: fmt::Arguments<'_>) {
> +    // `_printk` does not seem to fail in any path.
> +    //
> +    // SAFETY: The format string is fixed.
> +    #[cfg(CONFIG_PRINTK)]
> +    unsafe {
> +        bindings::_printk(
> +            format_strings::CONT.as_ptr() as _,
> +            &args as *const _ as *const c_void,
> +        );
> +    }
> +}
> +
>  /// Performs formatting and forwards the string to [`call_printk`].
>  ///
>  /// Public but hidden since it should only be used from public macros.
> @@ -120,7 +141,7 @@ pub unsafe fn call_printk(
>  #[allow(clippy::crate_in_macro_def)]
>  macro_rules! print_macro (
>      // The non-continuation cases (most of them, e.g. `INFO`).
> -    ($format_string:path, $($arg:tt)+) =3D> (
> +    ($format_string:path, false, $($arg:tt)+) =3D> (
>          // SAFETY: This hidden macro should only be called by the docume=
nted
>          // printing macros which ensure the format string is one of the =
fixed
>          // ones. All `__LOG_PREFIX`s are null-terminated as they are gen=
erated
> @@ -134,6 +155,13 @@ macro_rules! print_macro (
>              );
>          }
>      );
> +
> +    // The `CONT` case.
> +    ($format_string:path, true, $($arg:tt)+) =3D> (
> +        $crate::print::call_printk_cont(
> +            format_args!($($arg)+),
> +        );
> +    );
>  );
>
>  /// Stub for doctests
> @@ -174,7 +202,7 @@ macro_rules! print_macro (
>  #[macro_export]
>  macro_rules! pr_emerg (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::EMERG, $($ar=
g)*)
> +        $crate::print_macro!($crate::print::format_strings::EMERG, false=
, $($arg)*)
>      )
>  );
>
> @@ -198,7 +226,7 @@ macro_rules! pr_emerg (
>  #[macro_export]
>  macro_rules! pr_alert (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::ALERT, $($ar=
g)*)
> +        $crate::print_macro!($crate::print::format_strings::ALERT, false=
, $($arg)*)
>      )
>  );
>
> @@ -222,7 +250,7 @@ macro_rules! pr_alert (
>  #[macro_export]
>  macro_rules! pr_crit (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::CRIT, $($arg=
)*)
> +        $crate::print_macro!($crate::print::format_strings::CRIT, false,=
 $($arg)*)
>      )
>  );
>
> @@ -246,7 +274,7 @@ macro_rules! pr_crit (
>  #[macro_export]
>  macro_rules! pr_err (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::ERR, $($arg)=
*)
> +        $crate::print_macro!($crate::print::format_strings::ERR, false, =
$($arg)*)
>      )
>  );
>
> @@ -270,7 +298,7 @@ macro_rules! pr_err (
>  #[macro_export]
>  macro_rules! pr_warn (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::WARNING, $($=
arg)*)
> +        $crate::print_macro!($crate::print::format_strings::WARNING, fal=
se, $($arg)*)
>      )
>  );
>
> @@ -294,7 +322,7 @@ macro_rules! pr_warn (
>  #[macro_export]
>  macro_rules! pr_notice (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::NOTICE, $($a=
rg)*)
> +        $crate::print_macro!($crate::print::format_strings::NOTICE, fals=
e, $($arg)*)
>      )
>  );
>
> @@ -319,7 +347,7 @@ macro_rules! pr_notice (
>  #[doc(alias =3D "print")]
>  macro_rules! pr_info (
>      ($($arg:tt)*) =3D> (
> -        $crate::print_macro!($crate::print::format_strings::INFO, $($arg=
)*)
> +        $crate::print_macro!($crate::print::format_strings::INFO, false,=
 $($arg)*)
>      )
>  );
>
> @@ -346,7 +374,33 @@ macro_rules! pr_info (
>  macro_rules! pr_debug (
>      ($($arg:tt)*) =3D> (
>          if cfg!(debug_assertions) {
> -            $crate::print_macro!($crate::print::format_strings::DEBUG, $=
($arg)*)
> +            $crate::print_macro!($crate::print::format_strings::DEBUG, f=
alse, $($arg)*)
>          }
>      )
>  );
> +
> +/// Continues a previous log message in the same line.
> +///
> +/// Use only when continuing a previous `pr_*!` macro (e.g. [`pr_info!`]=
).
> +///
> +/// Equivalent to the kernel's [`pr_cont`] macro.
> +///
> +/// Mimics the interface of [`std::print!`]. See [`core::fmt`] and
> +/// `alloc::format!` for information about the formatting syntax.
> +///
> +/// [`pr_cont`]: https://www.kernel.org/doc/html/latest/core-api/printk-=
basics.html#c.pr_cont
> +/// [`std::print!`]: https://doc.rust-lang.org/std/macro.print.html
> +///
> +/// # Examples
> +///
> +/// ```
> +/// # use kernel::pr_cont;
> +/// pr_info!("hello");
> +/// pr_cont!(" {}\n", "there");
> +/// ```
> +#[macro_export]
> +macro_rules! pr_cont (
> +    ($($arg:tt)*) =3D> (
> +        $crate::print_macro!($crate::print::format_strings::CONT, true, =
$($arg)*)
> +    )
> +);
> --
> 2.38.1
>
Reviewed-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
