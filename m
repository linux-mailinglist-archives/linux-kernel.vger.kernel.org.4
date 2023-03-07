Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443A6ADF63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCGM7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCGM7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:59:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138417B4A1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 04:58:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id p16so7683638wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 04:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1678193918;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/Cy/OujEvrfcgtxPDuxMYp8s8ng0EOqDDkVszWumlc=;
        b=TGPUjYNpDx/QPw20JCz5TtjaNYMDyJieQmDNClQ4JrH94qOsexFMclQooJxhwpRc5N
         B7a49mLYHpVbv9EdfaGhjrYpaSKn+/idY4P5F9dXczgSYrOW1cTZw0v0nfXANfmdOQVT
         vTa+H5v4C4gvExvz7ZnvYjKvaIvsv8XdBD0Y9FAYZBPBd0sZ7lcu4SdKllVIz4bza2CQ
         KqM5X/ZCbjpypB7l38jrnSRefjWT6zxDSaimQr5zkW9sK7WHfcsGAlru0RqOREmzv5Ho
         rIXfsXSJgWk75UrWiJx2u74l2hF4MzKzkv5uQDYW+audTAImBpcily54sNPvCLFtKpwB
         ly4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678193918;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n/Cy/OujEvrfcgtxPDuxMYp8s8ng0EOqDDkVszWumlc=;
        b=p80++qbmj1KgF3rX8kqOmp7P5xMpRlx2ho9G6SB8GIGPuExGVy5DENUmXa5vyNNk/a
         tSqIrmcgA9rLieO2kP15jbP7UI4k41ruEFDvdyk9gE74QUhT2D6isJ9XzuC+g+IgHe38
         3OKbGh4mpPKJqRD8ypC04FZFqL9vcsck2sczI2ZEUxUQKfM85UfU+ZqFr0vSDTy60Hcd
         kyWFjrMGcrkFTRKXV6wTkVuZZIMcfbWrmRv6II2UZR4Hj9HEhW9ycSFe75pNu600A9Bc
         tBcNNdglYYSSU0vu1uUXtckg9+IJ5K9UGv2eEjdtdr0SDZcSIN1eiVUSQ6ddTqtPYG+1
         bhyw==
X-Gm-Message-State: AO0yUKXndE02SkNWXJ3SE+xpzyAK7eL9WomDUOvDclh+LQbHFXih0Yab
        0pw5Bk7kpUAvqDh/Cm9UiP7oGg==
X-Google-Smtp-Source: AK7set/D4A4p19IRPCyUevUEJCTN9mTsfWxBu+p9Nnr+gZbVJ/onBxvG4vdlW0zE1acL1wtSjU4lYg==
X-Received: by 2002:a7b:cc10:0:b0:3eb:3104:efef with SMTP id f16-20020a7bcc10000000b003eb3104efefmr12335752wmh.31.1678193918141;
        Tue, 07 Mar 2023 04:58:38 -0800 (PST)
Received: from localhost ([165.225.194.197])
        by smtp.gmail.com with ESMTPSA id n8-20020a05600c304800b003e21f01c426sm12787712wmh.9.2023.03.07.04.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 04:58:37 -0800 (PST)
References: <20230307120736.75492-1-nmi@metaspace.dk>
 <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: rust-analyzer: Skip crate module directories
Date:   Tue, 07 Mar 2023 13:53:53 +0100
In-reply-to: <CANiq72mvL3f-MZiZiZp-uZDQGCnYJ9yFh_QTWrTMUkUdiXdm=Q@mail.gmail.com>
Message-ID: <87edq0iupw.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Tue, Mar 7, 2023 at 1:08=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
>>
>> When generating rust-analyzer configuration, skip module directories.
>
> This is https://github.com/Rust-for-Linux/linux/pull/883, also handled
> by Vinay's patch
> https://lore.kernel.org/rust-for-linux/20230118160220.776302-1-varmavinay=
m@gmail.com/.

Awesome, three solutions to the same problem =F0=9F=98=85

>
> Lina's approach is arguably a bit more idiomatic in Python in that it
> is usually encouraged to follow the "Easier to ask for forgiveness
> than permission" approach.
>
> Lina, would you like to submit yours? Or do you prefer a `Link: ` /
> `Reported-by: ` / `Co-developed-by: ` here?
>
>> If `driver_mod` is a module of the crate `driver`, the directory `driver=
_mod`
>> may not contain `Makefile`, and `generate_rust_analyzer.py` will fail.
>
> By the way, note that in the kernel crate we are avoiding `mod.rs`
> files, instead using `name.rs` in the parent folder, in other to make
> it easier to find the files. I will add a note about it in the docs.

Thanks for pointing that out :)

BR Andreas
