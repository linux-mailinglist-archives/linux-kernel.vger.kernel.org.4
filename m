Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F925BC401
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiISIIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiISIIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:08:09 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B381FCCE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:08:07 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id g85so7986086vkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2SOaDgh3Xbp2cThKaHYYChzQVSEAWBeCFOscJLAXKq8=;
        b=nHCnfixG5nHOuGtmx95HZlP65DGnRnP1CQjYW7DVa8V9MnP0vzYYYpll38e3dolBVD
         LgCSmSi83HyDS3EZqMlDEeK5g+EXm8xuvyrayZi2cQzzpSrQvalzfBZ4Qsz/KUpNyssX
         zsFoPz7Kph+i7oq3lWE9NQKZJZ4McxevcCymVrgXqEuG34IIDzWt+NddALK4cZe6OHHJ
         79qWGjJI1/b3613bekRh8Oynh2KP8XTHRFaYWJ8MztJUhPDikbpAh95LDGMUZ39Zv3hK
         hQRIOlNxeAN9MbDxqT1XnDt3RkqDQO1pfHzRLz7WEMyIHaw7Df2wYMqQk6ZUamS+wKjB
         WKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2SOaDgh3Xbp2cThKaHYYChzQVSEAWBeCFOscJLAXKq8=;
        b=vrvkt7zIzl0gpTGQ/EuP7oHxGYGFg8kqI6WYqerGzC7TBCX1Ve4aAGKvum6xMQ2tnX
         IZodFXfEuNOJB5KX5yHg72WRpcvW3IwzAjW/hFxdOC9ozBZr3FZojZ4DAXYYHLDVS/Y9
         EcQ6FUNUG8LS/x6jasDX034pXEv4D9slsahBzhX7oFZAeTua5vhuW0BvUkX9Bi5Ze+6A
         bgJABQJxqxrItC+LE4JCGjDSf9Wa8uU52N4ZRYkVxYuBhRhYqCcU6ZgTAkUJ+O7qZeLL
         RJ4nQX5XHR3jOjJmH9OfbdjnYMEfbLvIw4mQJCRHOFfXXItlOikrmKKSqyWTTus299j8
         foNQ==
X-Gm-Message-State: ACrzQf3Lz8+arz842+f3yMTpTJSWQ83uKwfJgfDCK0riDlkE6K9B7lLe
        6N3NmC2OhTx0LIqTTq0VTSgzwn3x9eaBf9ru12fZqg==
X-Google-Smtp-Source: AMsMyM5OpGGORvjPdU0tcNC3Zx3GYKq0LbUwwMIOZOSE6B+3As6v4tDvuUjlbuLi/L6740/3JevWmF+XwaeL5c7IKaU=
X-Received: by 2002:a05:6122:10e4:b0:3a3:e3:d448 with SMTP id
 m4-20020a05612210e400b003a300e3d448mr5281172vko.29.1663574886403; Mon, 19 Sep
 2022 01:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662411799.git.andreyknvl@google.com> <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
 <CANpmjNM3RqQpvxvZ4+J9DYvMjcZwWjwEGakQb8U4DL+Eu=6K5A@mail.gmail.com> <20220912130643.b7ababbaa341bf07a0a43089@linux-foundation.org>
In-Reply-To: <20220912130643.b7ababbaa341bf07a0a43089@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 19 Sep 2022 02:07:30 -0600
Message-ID: <CAOUHufZg_FfKvNAsTmJvWA5MoMWQAjSpOHvWi=BAmsUPd3CZmg@mail.gmail.com>
Subject: Re: [PATCH mm v3 00/34] kasan: switch tag-based modes to stack ring
 from per-object metadata
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 12 Sep 2022 11:39:07 +0200 Marco Elver <elver@google.com> wrote:
>
> >
> > ...
> >
> > > Hi Andrew,
> > >
> > > Could you consider picking up this series into mm?
> > >
> > > Most of the patches have a Reviewed-by tag from Marco, and I've
> > > addressed the last few comments he had in v3.
> > >
> > > Thanks!
> >
> > I see them in -next, so they've been picked up?
>
> yup.
>
> > FWIW, my concerns have been addressed, so for patches that don't yet
> > have my Reviewed:
> >
> >
> > Acked-by: Marco Elver <elver@google.com>
>
> Updated, thanks.

Hit the following with the latest mm-unstable. Please take a look. Thanks.

BUG: rwlock bad magic on CPU#0, swapper/0, ffffffdc589d8218
CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-lockdep+ #36
Call trace:
 dump_backtrace+0xfc/0x14c
 show_stack+0x24/0x58
 dump_stack_lvl+0x7c/0xa0
 dump_stack+0x18/0x44
 rwlock_bug+0x88/0x8c
 do_raw_read_unlock+0x7c/0x90
 _raw_read_unlock_irqrestore+0x54/0xa0
 save_stack_info+0x100/0x118
 kasan_save_alloc_info+0x20/0x2c
 __kasan_slab_alloc+0x90/0x94
 early_kmem_cache_node_alloc+0x8c/0x1a8
 __kmem_cache_create+0x1ac/0x338
 create_boot_cache+0xac/0xec
 kmem_cache_init+0x8c/0x174
 mm_init+0x3c/0x78
 start_kernel+0x188/0x49c
