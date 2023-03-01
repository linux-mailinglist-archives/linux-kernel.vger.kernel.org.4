Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A86A6558
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCACNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCACNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:13:05 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4353768F;
        Tue, 28 Feb 2023 18:13:01 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id o32so17718437vsv.12;
        Tue, 28 Feb 2023 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677636780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVqhmTk5l6ti9SvNkNnXSprP913yBJDavUcvFDqr63U=;
        b=luMdgw16IXUVS3Wtk8sxZll7Vgq6OZfg/WwEv3Ub/PZEtlQ2ikwgTLXdGVtNsukuM8
         zLwidQTHuvyxaOFYoARwfjOwkUu2Zku3kxAv6h5K22NH0zBkRYPV5ebiKLaORRqOtK1O
         oguHnh+hZToRzW7f4tZZDGbNcfGgabuQRw7l62ytfmnDBa5elQA6cliaT7st8BiHa48W
         n8qQ6ASftITquk0bmg0xFP2Do1gqhk6IAf/6p5TRkf1B26ncMFZE5WiKsInB5OT+BobD
         QYebbmbRgf1B1O380Zs32sme64+8SFh+6aY7zONsi6zFgMJ9gJb2KHXMphAXTUqvhWut
         jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677636780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVqhmTk5l6ti9SvNkNnXSprP913yBJDavUcvFDqr63U=;
        b=O9H1xrYsGdouU+Mhhd9hD/vw9popNfeg8zJz4ETCM+KnK8QJrlx2w0+1HDIuG3SDG/
         c6RxiyWuoZQdUZSqpn9u5aPvRVgRcYjJ7HZ5dp10l/KZiqHhngAf/FD05JeY9YDL0ZZ1
         Qupt1LQcTTX6BvtkOLQe4fDrMyZlkIHdvQsnJBxO6ChLFztBGpMuxSx0PsOjVAS+Xwu6
         w7wsJxcv5e9cN3ztbPFuZ1UljCmjrrmXQ7xAo5iDe7kERSM3in662PieSUSxNkBXThfq
         I0Q5APfZjgX04Jix52rvzO9zcJVLR/etOFZ78fKzayv97Ligar+YLVbcQWX7/+O0aL/R
         FKFw==
X-Gm-Message-State: AO0yUKVERgoIFIV8dK2k6844dzpuC7e07AX3FT1xtLtT/gTkbqS1hq7Z
        Ks0IQzZ9bpNIoih4jSjCmpOLvt1QGB6XCsm/15H1wfLTuf8=
X-Google-Smtp-Source: AK7set805bRYjrmPrAp34SqgSxGraeFIz/okS7NOBfzN+CH4vL4cnbnwFtk7OBl4NFqJSH2Xu83mcM8h6wGT6eFE/l8=
X-Received: by 2002:a67:d30a:0:b0:415:74b4:6067 with SMTP id
 a10-20020a67d30a000000b0041574b46067mr3533620vsj.6.1677636780564; Tue, 28 Feb
 2023 18:13:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677612539.git.jbaron@akamai.com> <855201dc0204a1428a79d415c97df2b6e11c95c3.1677612539.git.jbaron@akamai.com>
 <Y/5mVe3NErpZj45n@bombadil.infradead.org>
In-Reply-To: <Y/5mVe3NErpZj45n@bombadil.infradead.org>
From:   jim.cromie@gmail.com
Date:   Tue, 28 Feb 2023 19:12:34 -0700
Message-ID: <CAJfuBxwqO8xgenBHXiKS6MRfZ9t=TZx+TFPUgGA7hwYEoCSr0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dyndbg: remove unused 'base' arg from __ddebug_add_module()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jason Baron <jbaron@akamai.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
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

On Tue, Feb 28, 2023 at 1:38=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> On Tue, Feb 28, 2023 at 02:34:21PM -0500, Jason Baron wrote:
> > __ddebug_add_module() doesn't use the 'base' arg. Remove it.
>
> It would be good if the commit log explains why the base became unused.
> What commit removed its use? As of what kernel?
>
>   Luis

the base arg became obsolete with this.
I had the same patch on-deck, but Jason did it 1st.


commit b7b4eebdba7b6aea6b34dc29691b71c39d1dbd6a
Author: Jim Cromie <jim.cromie@gmail.com>
Date:   Sun Sep 4 15:40:48 2022 -0600

    dyndbg: gather __dyndbg[] state into struct _ddebug_info

    This new struct composes the linker provided (vector,len) section,
    and provides a place to add other __dyndbg[] state-data later:

      descs - the vector of descriptors in __dyndbg section.
      num_descs - length of the data/section.

    Use it, in several different ways, as follows:

    In lib/dynamic_debug.c:

    ddebug_add_module(): Alter params-list, replacing 2 args (array,index)
    with a struct _ddebug_info * containing them both, with room for
    expansion.  This helps future-proof the function prototype against the
    looming addition of class-map info into the dyndbg-state, by providing
    a place to add more member fields later.

    NB: later add static struct _ddebug_info builtins_state declaration,
    not needed yet.

    ddebug_add_module() is called in 2 contexts:

    In dynamic_debug_init(), declare, init a struct _ddebug_info di
    auto-var to use as a cursor.  Then iterate over the prdbg blocks of
    the builtin modules, and update the di cursor before calling
    _add_module for each.

    Its called from kernel/module/main.c:load_info() for each loaded
    module:

    In internal.h, alter struct load_info, replacing the dyndbg array,len
    fields with an embedded _ddebug_info containing them both; and
    populate its members in find_module_sections().

    The 2 calling contexts differ in that _init deals with contiguous
    subranges of __dyndbgs[] section, packed together, while loadable
    modules are added one at a time.

    So rename ddebug_add_module() into outer/__inner fns, call __inner
    from _init, and provide the offset into the builtin __dyndbgs[] where
    the module's prdbgs reside.  The cursor provides start, len of the
    subrange for each.  The offset will be used later to pack the results
    of builtin __dyndbg_sites[] de-duplication, and is 0 and unneeded for
    loadable modules,
