Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C43363F0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiLAMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiLAMmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:42:22 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3558C681;
        Thu,  1 Dec 2022 04:42:20 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id v206so1856304ybv.7;
        Thu, 01 Dec 2022 04:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZLFHPHmu42F5vgCZp4ijmCKeW/Bp2vfBJ56tLv98tY=;
        b=kg0NfjNL+OZtMi114IVofJvt6YDQkbGAEpaviVRhPdIjwYYviGV2s3k43+qZF1bYj+
         PZvcJoRTQZb7jt0VFVy6VxVIU+mKeStj/sw82fnqzlsBsaTM6SiZlmUblJqG7vGgY63n
         fnP/0Sbn57tfS23JPWy9myf87Ev7eGvIhH62f/rcucBwbnzRZEb1zAmKIWaodf4XrZkr
         0yzHIEUQE7/nu520vdvk4z2EUr+3EjiM/bKfq5fN0wkXiuD07lWCn9TYf2w5JDmvEbvW
         rKqbLRg7zA5ZIqTxC+EgOOjN14v74AAvaffr8BGGBZ9K/GU2D2sfIyC4VFIGM4SLtUxh
         1aSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZLFHPHmu42F5vgCZp4ijmCKeW/Bp2vfBJ56tLv98tY=;
        b=MHXzGojgphhFusO0IdIK58XexMagUwG9g2D3s5tfybuUUeybQp4cFMb5gfrPN6SYi7
         E1m5hgdMe9ozI11QSa3NON4atrU9VwS7XT5MRCafyIQt7HvhxgpplN1aVzZid5gLL1jt
         MGifPNxyg6z7Zaa6RlHbwEa2668DlEC5shhhUwHDVI14l2IKKD9f2BimCFStOzos4gn1
         kKXlexOMSnepo8n/uEwxbxyZHTm9TW+LCMQ3+4izbwUhjV4M0TJCDkT1nN+ZZ2bw0KGt
         gWdhuoIfnUDOGLk9pNAgJ81nckNUlazSVwzgID2Mm+4xTRBTemgt/2MEhQYoUzzcJnYK
         hW5Q==
X-Gm-Message-State: ANoB5plPv8ZEfMFFST+WPPyG5ezTp0aZNDaV2VbpXnv2Ke7JakpzHWep
        9RZPdxR46oNDMXduySfa4QGhVFtV2gH5hjWEAKE=
X-Google-Smtp-Source: AA0mqf4+TyrNUMCpYufVvJDLCwKVdwSU4HrNiYDvpS5hHJZK1APaT4dregkaqc2dwCh0X9KeU6wJeozM1gV0AmRrHy8=
X-Received: by 2002:a25:c589:0:b0:6f5:8253:b125 with SMTP id
 v131-20020a25c589000000b006f58253b125mr22169566ybe.75.1669898539703; Thu, 01
 Dec 2022 04:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
In-Reply-To: <20221130220825.1545758-1-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 1 Dec 2022 13:42:08 +0100
Message-ID: <CANiq72nMY5f85tJJFg7AFsh4YRrKObhurhT8TVawYqoZU+J-Fg@mail.gmail.com>
Subject: Re: [PATCH] docs: Integrate rustdoc into Rust documentation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:08 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> Include HTML output generated with rustdoc into the Linux kernel
> documentation on Rust. Change target `make htmldocs` to combine RST Sphinx
> and the generation of Rust documentation, when support is available.

Looks better, thanks for this v2! A few comments below...

> +ifdef CONFIG_RUST
> +       @make LLVM=1 rustdoc
> +endif

The Rust docs should probably be built with the build
system/config/... as given, whether it is GCC, LLVM, etc. This should
probably use `$(MAKE)` too; and if you intended to remove the command
line definitions, `MAKEOVERRIDES` too.

Ideally `htmldocs` would depend on `rustdoc`, though that would
require shuffling quite a few things since to build the Rust docs we
need a subset of the Rust dependencies built. Given we may be changing
things soon anyway on the Rust `Makefile`, we can leave that for the
future.

By the way, while checking this, I noticed we use some `CONFIG_`s in
this `Makefile`, but we do not perform a config sync for the `*docs`
targets, so one needs to do so manually, i.e. it can be a pitfall for
e.g. `CONFIG_WARN_MISSING_DOCUMENTS` and ` as well as a potential
`CONFIG_RUST`. Should this be fixed orthogonally, or is it intended?
(some targets do not need the sync, and the ones that need are
probably less used, so I guess that could be the reason?).

> +Rustdoc output
> +==============
> +
> +If this documentation includes rustdoc-generated HTML, the entry point
> +can be found `here. <rustdoc/kernel/index.html>`_

Perhaps this sentence could be moved to the top of the index file, so
that users do not need two clicks when visiting "Rust"? That way we
avoid one more file too.

> +RUSTDOC_OUTPUT=$(objtree)/Documentation/output/rust/rustdoc

Please add a space around the equal sign to be consistent with (most)
of the rest of the file.

Cheers,
Miguel
