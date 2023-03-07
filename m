Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4307D6ADEE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjCGMi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCGMiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:38:23 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBB15C95;
        Tue,  7 Mar 2023 04:38:22 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id e82so11189483ybh.9;
        Tue, 07 Mar 2023 04:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678192701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSEz68o1z40ANsWKStxDZUpJi38UlOaVVt3jRhWQlTQ=;
        b=ZgdedfeR9XfwFISvOChCkRiLiJgbEJy4cje9O6hYrmaW0SGUWGTmK1lVGYNlo4Khnd
         t7DJ34nDMfS3q1qe/RgtSE5PiI1BAoSvctwVyM7wBV0uG4Tm24eDfK5JvD99O9voqqZj
         NQYSXagTcTZoBotIl2SbYSpG9FUuDYjoa+LFm9VVSGgFH+tEgATKDDwRkWkKsGq1tQ9x
         AVHbnVpejGCLMUYhW9ba6KyuI55tD7k7JXGxilHmr1h6p7p0GcPN0JXJPsJ6AOmlfzj5
         O7JyGdMPN0arFY+BbeJraOhaAfNZCgoYODN3wvTTtneWhplBxSfkkOv8NjEgyFD9/waU
         CWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678192701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSEz68o1z40ANsWKStxDZUpJi38UlOaVVt3jRhWQlTQ=;
        b=V2/sYb1fgZG2armTQSsFuz7XLR+Gj32szJwaC27/7i3UbyFnlcwWU5YvMN9RGygLOi
         c563aRAca+RRIBDlIS+H9msZiB4sviTn/Bz8mWsMjsds9t7fAanZ7QIzKM/jDpUk8a1M
         yCzo6fQ/AYzrXRgYYFdyXjWXbV7/0DaS1s9mUYXRoSrdyDbJK/ys1xLgIS96nrnR2Z23
         9KcIRyb5MroKrhaMxIgZtgaL24W6bLYJTlx+O45qiXvluBg0BAb/vEA9aGk2IFv+erT5
         N/rWmSurAEIxKQdDw0H0wd2J+dzGhy8CnM3tTGaR5+wldlLDPwP7Z9WWbAeXMc/tkO9g
         wDlA==
X-Gm-Message-State: AO0yUKULqoEChMklO+7cIEtW2hKbBWGJ3dKFg+cC9zv3YgN5nMB6gD2z
        AS+3f8Hri071P7AwlSsB0QPtQxVtyVJkOvzG+ME=
X-Google-Smtp-Source: AK7set/bjVOF/tcpsafQHUq1w74UFeRGrrHxn7lfm3hF282Xi2cyHm24ApJe9havtvrj4+UV8yGabi5SE3jarS9Tezc=
X-Received: by 2002:a5b:5d0:0:b0:a48:6236:1be4 with SMTP id
 w16-20020a5b05d0000000b00a4862361be4mr8605519ybp.2.1678192701704; Tue, 07 Mar
 2023 04:38:21 -0800 (PST)
MIME-Version: 1.0
References: <20230307120736.75492-1-nmi@metaspace.dk>
In-Reply-To: <20230307120736.75492-1-nmi@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 13:38:10 +0100
Message-ID: <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust-analyzer: Skip crate module directories
To:     Asahi Lina <lina@asahilina.net>,
        Andreas Hindborg <nmi@metaspace.dk>
Cc:     rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 1:08=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk> =
wrote:
>
> When generating rust-analyzer configuration, skip module directories.

This is https://github.com/Rust-for-Linux/linux/pull/883, also handled
by Vinay's patch
https://lore.kernel.org/rust-for-linux/20230118160220.776302-1-varmavinaym@=
gmail.com/.

Lina's approach is arguably a bit more idiomatic in Python in that it
is usually encouraged to follow the "Easier to ask for forgiveness
than permission" approach.

Lina, would you like to submit yours? Or do you prefer a `Link: ` /
`Reported-by: ` / `Co-developed-by: ` here?

> If `driver_mod` is a module of the crate `driver`, the directory `driver_=
mod`
> may not contain `Makefile`, and `generate_rust_analyzer.py` will fail.

By the way, note that in the kernel crate we are avoiding `mod.rs`
files, instead using `name.rs` in the parent folder, in other to make
it easier to find the files. I will add a note about it in the docs.

Cheers,
Miguel
