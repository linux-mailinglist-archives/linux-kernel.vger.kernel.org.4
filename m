Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FD26DC2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 04:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjDJCyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 22:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjDJCyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 22:54:15 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7EE2D5F;
        Sun,  9 Apr 2023 19:54:14 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q5so6248407ybk.7;
        Sun, 09 Apr 2023 19:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681095253; x=1683687253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68hFqK4w8HaSDUtj3lg9PKOMpgnSuCAOnFcquas933k=;
        b=IjZnrt9C8yXtdC/ohkFj9vbfN0I5CrHdGt6RXZhkRTqVcM4PMjWP/8xUL9vbh8GGdo
         v454lLMWWjhwjJ+VwzO4RTWzcsPINmuMQDfY6mX3OxL3T2JUR5wc/5FIZLCPAdV2aAV1
         2nqWJ6HPIB8NtV7TS3pFPZtZQnmgfufw/AHgIz6Yzu5VN/QU1pp1FvkXrmUm+DXClkya
         jatyStfza2n5Pf+HX832FAHLOmaxuJz5KC6QlcmgrizkjCKQByCyTfEjLGbUN1xSnDmZ
         lhd2umXNlbGwYnA/By0TG4KlvBR25fY1c8TeMp/RFKkT3DtALIkJ9fKFGpKgBbmgsV/c
         Yy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681095253; x=1683687253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68hFqK4w8HaSDUtj3lg9PKOMpgnSuCAOnFcquas933k=;
        b=R7OXyxqO6ZcYkIf+tB0Gyg2rQcL8GqdLzhfPX24PMaqRs2hj3H/qteQezXc5JkWWT3
         kquHWDQVG3Ly0sWEzJ4PAqxQEFvpYG39Npdo5zJz/Ky8mDzkMIBJ1o+y+wz7SbmB3r1Y
         Ncj5UA6xSFsevd/TjjuHqcXzad8u7PGIgzBHwag6/TsIcoLnDDGyV67SanMgWlXjUQFs
         7Up8eo1sZRdThjrcUbPSlBE9oQFrR1h3kVsRKPu08BVsc8vjfZPMDRz7B4zZ2QqTNSoA
         PwVsltxsc3DYrkIVcYaObXyayB0ZqzjGDKE1fsoyYQNAeSKOjGerYXbjPL1gXnsPVOKY
         iVjw==
X-Gm-Message-State: AAQBX9da0WJEh9j6YI8xxg159Zpy82xxkv8fbVm4xrpbXsQt7xSqLrbK
        BdzeleiPQvMGpM0VAeMnpVfnkBnUxBCB8Yr1R1k=
X-Google-Smtp-Source: AKy350Zt7Ncm7oRHxX7FoJD7gllamV44wOZFNwP7hZX6GC9TeqVGMSrkLhxzsHnsz947jvbOVKIpBCQsnTS1VTe26eY=
X-Received: by 2002:a25:7781:0:b0:b8e:cad0:6e57 with SMTP id
 s123-20020a257781000000b00b8ecad06e57mr3253999ybc.11.1681095253548; Sun, 09
 Apr 2023 19:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
In-Reply-To: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Apr 2023 04:54:02 +0200
Message-ID: <CANiq72ma7p9q8Usos6=Opv+YwzOXKgLXj6EEBUsfY2OY7KniGg@mail.gmail.com>
Subject: Re: [PATCH] rust: Enable the new_uninit feature for kernel and driver crates
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 9:10=E2=80=AFAM Asahi Lina <lina@asahilina.net> wro=
te:
>
> The unstable new_uninit feature enables various library APIs to create
> uninitialized containers, such as `Box::assume_init()`. This is
> necessary to build abstractions that directly initialize memory at the
> target location, instead of doing copies through the stack.
>
> Will be used by the DRM scheduler abstraction in the kernel crate, and
> by field-wise initialization (e.g. using `place!()` or a future
> replacement macro which may itself live in `kernel`) in driver crates.
>
> See [1] [2] [3] for background information.
>
> [1] https://github.com/Rust-for-Linux/linux/issues/879
> [2] https://github.com/Rust-for-Linux/linux/issues/2
> [3] https://github.com/rust-lang/rust/issues/63291

Applied to `rust-next` (reworded to use `Link` tags). Thanks!

Cheers,
Miguel
