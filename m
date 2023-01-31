Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8766835F4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjAaTBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbjAaTBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:01:44 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF34589A7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:40 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e10so10749855pgc.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JEPpab3psC6bj9jl5RKXgLUqYW14UThmzVF6DuOiw/8=;
        b=c7mxTGGa9A1LwUkWB4akK2UlSlprQ/F4wZkQfISs+OsLhsm0YaC/hBtxD3IxCIIDr2
         jmhevDnuLoyCl9vqRo2x7NswXwz/mwwg6MMYxNYfF6xwwnA+1D3c4zXK35chb3UQp5ZN
         BHGi1RSypx30sJFir4RnlAmwP1qES2TGLyxdBrYbqshr4W0yn67WMrXf8Z/ZDKI2C0pI
         g1BSvGjsH69RyROe86IfM0cffETBNHgqVQdyR30TIxM3NEF7iqdzciV4zYHr/1Ct3rmB
         MV5PPMLlYGUKSUCD8iSerY19ufBwtIG/K0Sd97VspYvKrT4OBuEhua1lVD14V9qmi8Q4
         T+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JEPpab3psC6bj9jl5RKXgLUqYW14UThmzVF6DuOiw/8=;
        b=cozBMu8y4yqleEn4SEI8qh/Ao+VrlkNGoDEejvS6Ep+ftiE+AfySK1+q0h2HFoAcPv
         orvsqQFus7zLEeEDTC31EIdPYA2BrcAh1iL7J1jf/8CgiRG8vQ97LaZYMas/3LqjUg+L
         H4JTxwCtyJ3nyG0OUZYy6ihhowwq/3yuefBd48zekNuEJg6rgQUzqsqDokCGjZK+4mhi
         GMEGVPty35HJAdFoPStAc9yYDOcAe+4CI0DQ5rKD0mu2yZUfg+pDmod8SAb++W+i37WM
         bCw7qsHiuvciefckdsRq18AyoU7B3MVs/T4XemJEYjR8p7cII9Zyac6j5kFDwBWbvm1I
         HqDQ==
X-Gm-Message-State: AO0yUKUHNvqR07b4gdhcdfLozZAkD7c4ojxJFSmavij5GDqWp9btp1tz
        oOhUVO959HwnwVg6+sgQKA2Tv7BxDf6Z1sC2hPM=
X-Google-Smtp-Source: AK7set9nFO7AbCFSBUnBwbXDh0Sd63kphwuYMRjlW/W05MiWN/UbYOMWhlAruqIK5rkPIWrq/r0++vnYzYzaSs7iy50=
X-Received: by 2002:a62:1dcd:0:b0:592:d71:74ec with SMTP id
 d196-20020a621dcd000000b005920d7174ecmr3537457pfd.43.1675191700062; Tue, 31
 Jan 2023 11:01:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <4ed1d0828e837e15566a7cfa7688a47006e3f4b3.1675111415.git.andreyknvl@google.com>
 <CAG_fn=V=91XNUyaWuwrgDqNKhHcEQFmD7Q4opc_v4vos+GR3qQ@mail.gmail.com>
In-Reply-To: <CAG_fn=V=91XNUyaWuwrgDqNKhHcEQFmD7Q4opc_v4vos+GR3qQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 31 Jan 2023 20:01:29 +0100
Message-ID: <CA+fCnZeWQ7xSTLxLhGmDeyQx6UVDN9J9J0_jUjv3B--dPWaXAw@mail.gmail.com>
Subject: Re: [PATCH 08/18] lib/stackdepot: reorder and annotate global variables
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 31, 2023 at 11:43 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Group stack depot global variables by their purpose:
> >
> > 1. Hash table-related variables,
> > 2. Slab-related variables,
> >
> > and add comments.
> >
> > Also clean up comments for hash table-related constants.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> ...
> > +/* Lock that protects the variables above. */
> > +static DEFINE_RAW_SPINLOCK(depot_lock);
> > +/* Whether the next slab is initialized. */
> > +static int next_slab_inited;
> Might be worth clarifying what happens if there's no next slab (see my
> comment to patch 01).

Will do in v2. Thanks!
