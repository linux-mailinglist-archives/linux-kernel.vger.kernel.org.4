Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770516E957B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjDTNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDTNM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:12:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE9710D2;
        Thu, 20 Apr 2023 06:12:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so4754211fa.2;
        Thu, 20 Apr 2023 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681996374; x=1684588374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2zHLuZQqv995ZnaTJ8GLCbIdGNJLSCJHtTeZLLgszs=;
        b=rcxPnJyw2eJcMgMizZ9JkG80D9A7zgP84qNx43gP76d52MreGttItft3Exv84l+om1
         XrLk8CGQgZoOlnESaD9zaL87N/BDb+vepvaeX8VY2bh/EPAfx8pxOW9tOtqCjg0f4jRt
         fzacQUaiE7zMRYpjSY1RqYuuwTo4FPooWwNCn+gGNaonBe6dVuNAotpMroAohlt3dfgK
         2UlXM+BFTPAH2vJZHOMcnudQzATLkwwujqBF1yXHXKdJncq/nJT2C+/AZbBFhF7WzVMD
         TZTWiuN+8tM6gR3MN17vXl6TwIaMdnBlhGK9rHjIoVS/xhQqF1nymbBDD18NhnF/WBhk
         jfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996374; x=1684588374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2zHLuZQqv995ZnaTJ8GLCbIdGNJLSCJHtTeZLLgszs=;
        b=L0o7UQ7i0LoXD0FlOKbNmdePcNIciZVllDxKBuMc+buOFUFhTqgRZMSQLBhu/xT71Z
         bU/L6JmakiCGCv7PU7Pqsn2MrFPjR4yhtdcfw0eZISDTgV/6g7ngpsyPe9pDHT2Dj78S
         ikaWB4vOnzwUqrwVH8QI3Rtl/GGXoBCeFJoXHmaOVaefDGt718X0rAMtUXPtAwUr5qS9
         SugxKh81MvrboRI3bY32xsYdzQnXKtOnZqkqsQg1Fl/ipaJQR8jAGqeXnOMOr9mD2a28
         aZ72h3lCjBt0tUanqYMd7vvzc5R4h8yX+6Aob9P3udxHxLDBYfXoYggmMHYNWtXIcHiE
         K0ug==
X-Gm-Message-State: AAQBX9f0GjjEbFQdDCxbGxFzBz78YybrqI51diYF4BUlg57sG6jxQ3P8
        m1lkM8dWeEHvTX4FFL5NSkM9AlQ1qoQwyFhcSI8=
X-Google-Smtp-Source: AKy350ZutqwJZvzTeNbJ2LJiZaQbkLDXCebqvFCuOgRt0LR5RBao08S9wHcKpEySpbV/IEqglu7EifuEI24NJ+6eWns=
X-Received: by 2002:ac2:43a9:0:b0:4db:5133:59a6 with SMTP id
 t9-20020ac243a9000000b004db513359a6mr368815lfl.13.1681996373645; Thu, 20 Apr
 2023 06:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org>
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
From:   Ariel Miculas <ariel.miculas@gmail.com>
Date:   Thu, 20 Apr 2023 16:12:42 +0300
Message-ID: <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've applied the patch series, upgraded rustc and built the kernel:

$ rustup override set $(scripts/min-tool-version.sh rustc)
$ rustup component add rust-src # Rust standard library source
$ cargo install --locked --version $(scripts/min-tool-version.sh
bindgen) bindgen
$ make LLVM=3D1 rustavailable
$ grep  RUSTC_VERSION .config
CONFIG_RUSTC_VERSION_TEXT=3D"rustc 1.68.2 (9eb3afe9e 2023-03-27)"
$ make LLVM=3D1 -j$(nproc)

Then I ran the kernel in qemu-system-x86_64, inserted the
rust_minimal.ko kernel module and checked that it behaves as expected.

Tested-by: Ariel Miculas <amiculas@cisco.com>

Cheers,
Ariel

On Wed, Apr 19, 2023 at 12:48=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
>
> Please see the last patch message for a long explanation of the upgrade,
> the policy for future upgrades and some indications on how to easily
> review this.
>
> The series is based on `rust-next`.
>
> Miguel Ojeda (3):
>   rust: alloc: clarify what is the upstream version
>   rust: arc: fix intra-doc link in `Arc<T>::init`
>   rust: upgrade to Rust 1.68.2
>
>  Documentation/process/changes.rst |   2 +-
>  rust/alloc/README.md              |   3 +
>  rust/alloc/alloc.rs               |  55 ++--
>  rust/alloc/boxed.rs               | 446 ++++++++++++++++++++++++++--
>  rust/alloc/collections/mod.rs     |   5 +-
>  rust/alloc/lib.rs                 |  71 +++--
>  rust/alloc/raw_vec.rs             |  16 +-
>  rust/alloc/slice.rs               | 447 ++++------------------------
>  rust/alloc/vec/drain.rs           |  81 +++++-
>  rust/alloc/vec/drain_filter.rs    |  60 +++-
>  rust/alloc/vec/into_iter.rs       | 125 ++++++--
>  rust/alloc/vec/is_zero.rs         |  96 ++++++-
>  rust/alloc/vec/mod.rs             | 464 +++++++++++++++++++++++-------
>  rust/alloc/vec/set_len_on_drop.rs |   5 +
>  rust/alloc/vec/spec_extend.rs     |  63 +---
>  rust/bindings/lib.rs              |   1 -
>  rust/kernel/build_assert.rs       |   2 +
>  rust/kernel/init.rs               |   5 +
>  rust/kernel/lib.rs                |   4 -
>  rust/kernel/std_vendor.rs         |   2 +
>  rust/kernel/sync/arc.rs           |   2 +-
>  scripts/Makefile.build            |   2 +-
>  scripts/min-tool-version.sh       |   2 +-
>  23 files changed, 1278 insertions(+), 681 deletions(-)
>
> --
> 2.40.0
>
