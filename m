Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFD3632FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKUWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 17:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKUWwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 17:52:09 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684C786E8;
        Mon, 21 Nov 2022 14:52:07 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so31769978ejb.13;
        Mon, 21 Nov 2022 14:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGPJoGgEf7UilkDf7rSI+x9NQwnpZsCCeFTrbXEasDc=;
        b=OwNcrxDRAmcQHMo9wTgynMmwAIRBuCsrD3KspfMDRMphTsKqByctGClHVT+KoyeXGA
         y78uoy9R3NCzMwSDIgQIP6He3AFAaGEH76DCk1EuGIMmyth5vV7QglQl/LCRm0jqas5P
         w3a/xkkRcbQqsEhyI3fTvKMx0p65zHOJfC72Nc2a1X7Lz+5rpWlwzCLqiHOhV933mB/h
         kAyGYEeK2IfJnQqOtOrs+EX95fQ5o7+OZQby75E17scPZ68/Owxeei5k64EE5IcT7o5S
         sulDKG4Eh5/SNFJs4BgyQZn37fc/knirDuMEa0BhfNsfHUJDx8djGTvk9qRRhkvkeNc+
         WY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGPJoGgEf7UilkDf7rSI+x9NQwnpZsCCeFTrbXEasDc=;
        b=nvkrrowz0apfCz2K4N7jXCtWSJ6DmBAY9c1diBFyy1VrHhM5okjn35z7a0dmvzAr56
         +dvbETKHZrwXL5TKyqxfObuMncaBwTKTco2tyU3aFXYBUrotRta3TxNRILgIEp7c3WWh
         j3eXcJOf/ae2GpjXT/+sK92EcwNyM5Ep1nGjSnG/74wYCgITmBqbZ6qdxxFilHSZPl4X
         G0vGpFbLogEWOMm/MMN55UUTbE1z0VBWLLRe0uD/KI+/nWgnCvAuFrEVIes5wxK+wVKE
         HoVgJ2qyoixn/7IM/qXY8s+u7mOH+le8Ne5qH0eLIKl3A1zXsYuNwhZ0KyHTv68971Gu
         HIDA==
X-Gm-Message-State: ANoB5pl0yM4JBg9K8vBmIKTtrrtbfOt0tFkyfdc0Cbttw83EOBqb25dX
        YZCSUng1zjRY/G6L9KB8D8ZPG3e74/NOf7uuf3oggakwYXAdsg==
X-Google-Smtp-Source: AA0mqf6n9ijZrSMSuLDDEU2b+4Sc2H56X4iXT7tpuHy2HAO64Z8INcpLQs6KxHhnRFvg9RE0e2nOlbkOHWhmfRGD+Y4=
X-Received: by 2002:a17:907:208d:b0:7ad:d662:f568 with SMTP id
 pv13-20020a170907208d00b007add662f568mr16734609ejb.616.1669071126105; Mon, 21
 Nov 2022 14:52:06 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-5-ojeda@kernel.org>
In-Reply-To: <20221110164152.26136-5-ojeda@kernel.org>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Mon, 21 Nov 2022 23:51:29 +0100
Message-ID: <CAA76j93O=a32EOT0vkxf6SGb9qypNpOjDC-dUMOuUPuujPkzOQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/28] rust: samples: add `rust_print` example
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Thu, 10 Nov 2022 at 17:43, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Add example to exercise the printing macros (`pr_*!`) introduced
> in the previous patches.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  samples/rust/Kconfig       | 10 +++++++
>  samples/rust/Makefile      |  1 +
>  samples/rust/rust_print.rs | 54 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+)
>  create mode 100644 samples/rust/rust_print.rs
>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 841e0906e943..b0f74a81c8f9 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -20,6 +20,16 @@ config SAMPLE_RUST_MINIMAL
>
>           If unsure, say N.
>
> +config SAMPLE_RUST_PRINT
> +       tristate "Printing macros"
> +       help
> +         This option builds the Rust printing macros sample.
> +
> +         To compile this as a module, choose M here:
> +         the module will be called rust_print.
> +
> +         If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>         bool "Host programs"
>         help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 1daba5f8658a..03086dabbea4 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)              +=3D rust_minimal.o
> +obj-$(CONFIG_SAMPLE_RUST_PRINT)                        +=3D rust_print.o
>
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)         +=3D hostprogs
> diff --git a/samples/rust/rust_print.rs b/samples/rust/rust_print.rs
> new file mode 100644
> index 000000000000..09f737790f3f
> --- /dev/null
> +++ b/samples/rust/rust_print.rs
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust printing macros sample.
> +
> +use kernel::pr_cont;
> +use kernel::prelude::*;
> +
> +module! {
> +    type: RustPrint,
> +    name: b"rust_print",
> +    author: b"Rust for Linux Contributors",
> +    description: b"Rust printing macros sample",
> +    license: b"GPL",
> +}
> +
> +struct RustPrint;
> +
> +impl kernel::Module for RustPrint {
> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> +        pr_info!("Rust printing macros sample (init)\n");
> +
> +        pr_emerg!("Emergency message (level 0) without args\n");
> +        pr_alert!("Alert message (level 1) without args\n");
> +        pr_crit!("Critical message (level 2) without args\n");
> +        pr_err!("Error message (level 3) without args\n");
> +        pr_warn!("Warning message (level 4) without args\n");
> +        pr_notice!("Notice message (level 5) without args\n");
> +        pr_info!("Info message (level 6) without args\n");
> +
> +        pr_info!("A line that");
> +        pr_cont!(" is continued");
> +        pr_cont!(" without args\n");
> +
> +        pr_emerg!("{} message (level {}) with args\n", "Emergency", 0);
> +        pr_alert!("{} message (level {}) with args\n", "Alert", 1);
> +        pr_crit!("{} message (level {}) with args\n", "Critical", 2);
> +        pr_err!("{} message (level {}) with args\n", "Error", 3);
> +        pr_warn!("{} message (level {}) with args\n", "Warning", 4);
> +        pr_notice!("{} message (level {}) with args\n", "Notice", 5);
> +        pr_info!("{} message (level {}) with args\n", "Info", 6);
> +
> +        pr_info!("A {} that", "line");
> +        pr_cont!(" is {}", "continued");
> +        pr_cont!(" with {}\n", "args");
> +
> +        Ok(RustPrint)
> +    }
> +}
> +
> +impl Drop for RustPrint {
> +    fn drop(&mut self) {
> +        pr_info!("Rust printing macros sample (exit)\n");
> +    }
> +}
> --
> 2.38.1
>

Tested-by: Sergio Gonz=C3=A1lez Collado <sergio.collado@gmail.com>
