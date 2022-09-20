Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773145BED3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiITS7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiITS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 14:59:13 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC874CEE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:59:12 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c11so2429325qtw.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=D8dJcpZD+yJJTRrjXKaOEFQ0b3WoLQpt8eE6p+5Y5WA=;
        b=NHt3gNnPRY070yyfzEtaxGPj3/Et1cnZr1JjOxd8wokmObZodFHvg07H8hBbx2spRg
         jJ8Nm9eyK14LafX//5FlM1iOhnV8/rdZTEUzmy+hE7/UHFUYf1Ll/WWmO7GYi6IlDN39
         2+UibzRQLTcmdZctFTj/LJUBcwfp/lIuCfFtzySsfFDAhMhb7Y7oTD9ukApmYU1Ayoi5
         fgiKZmmuN3Iur4kCMD3LfborPWmiWo5rsbb9gfQmJ8kSTm/axPf0RMpdNrjF/ynnPK/S
         umhqACAcN3oI8M6kKQs7nHeJ0C9nWaPRc/E7T0U1nAxNSJh7rYj5gvfE4PiLrb+dG/iR
         Idyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=D8dJcpZD+yJJTRrjXKaOEFQ0b3WoLQpt8eE6p+5Y5WA=;
        b=CLfyogNg5tR53SbHF7ZdEe2wHAISEXmLIflGSAmwNeEBJC3J4bK1yv69obQmEIe09p
         zSCF2koGyEtP8K65rNaJ/9ppcpLEEMgI9gVnedNsJa5WhxlY1LskKgOy27LZB/BDBFgk
         DzdxFJqiCGtuIx07x0eU4V6b5eyaGYZ1xs+RHzbuvuLMCx6QtYmkiV72Ro8xfzE8AaQP
         m7kmzRbgZiGb/eXyXkUGDAO03N39ANET1wod4cbojzLGHgecJ3ZEMZwFep5Gv1WGNzYj
         HSbd+0kgR0dAh0EJv54wB1XzBjyoU6NkATdv4MapyRY3tTBmWMaHV272wKlhB8UZkzDM
         ktMQ==
X-Gm-Message-State: ACrzQf1QZqeFRYSppNJDlBX5IPNi87WUADZei960bLl6xpOa5mdOmGSA
        nCpblsbq9qp6Ud2af4udHSI+3nfXQswjf4Y/aDA=
X-Google-Smtp-Source: AMsMyM57HLGXN3+cYuY8jv9gehCCyY0mZWh1rs1xM8VC3/4b4lbKOSUAZKQE/wkU3Mn5/vWWwmqydG7wMgyqx/ddzf0=
X-Received: by 2002:a05:622a:14d1:b0:344:b14a:b22a with SMTP id
 u17-20020a05622a14d100b00344b14ab22amr20408437qtx.203.1663700352038; Tue, 20
 Sep 2022 11:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662411799.git.andreyknvl@google.com> <CA+fCnZdok0KzOfYmXHQMNFmiuU1H26y8=PaRZ+F0YqTbgxH1Ww@mail.gmail.com>
 <CANpmjNM3RqQpvxvZ4+J9DYvMjcZwWjwEGakQb8U4DL+Eu=6K5A@mail.gmail.com>
 <20220912130643.b7ababbaa341bf07a0a43089@linux-foundation.org> <CAOUHufZg_FfKvNAsTmJvWA5MoMWQAjSpOHvWi=BAmsUPd3CZmg@mail.gmail.com>
In-Reply-To: <CAOUHufZg_FfKvNAsTmJvWA5MoMWQAjSpOHvWi=BAmsUPd3CZmg@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Sep 2022 20:59:01 +0200
Message-ID: <CA+fCnZcdfvHBhN3NjL+nybm8s1Tte+kMB_X59NMsBXJ_OpCa_A@mail.gmail.com>
Subject: Re: [PATCH mm v3 00/34] kasan: switch tag-based modes to stack ring
 from per-object metadata
To:     Yu Zhao <yuzhao@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 10:08 AM Yu Zhao <yuzhao@google.com> wrote:
>
> Hit the following with the latest mm-unstable. Please take a look. Thanks.
>
> BUG: rwlock bad magic on CPU#0, swapper/0, ffffffdc589d8218
> CPU: 0 PID: 0 Comm: swapper Not tainted 6.0.0-rc3-lockdep+ #36
> Call trace:
>  dump_backtrace+0xfc/0x14c
>  show_stack+0x24/0x58
>  dump_stack_lvl+0x7c/0xa0
>  dump_stack+0x18/0x44
>  rwlock_bug+0x88/0x8c
>  do_raw_read_unlock+0x7c/0x90
>  _raw_read_unlock_irqrestore+0x54/0xa0
>  save_stack_info+0x100/0x118
>  kasan_save_alloc_info+0x20/0x2c
>  __kasan_slab_alloc+0x90/0x94
>  early_kmem_cache_node_alloc+0x8c/0x1a8
>  __kmem_cache_create+0x1ac/0x338
>  create_boot_cache+0xac/0xec
>  kmem_cache_init+0x8c/0x174
>  mm_init+0x3c/0x78
>  start_kernel+0x188/0x49c

Hi Yu,

Just mailed a fix.

Thank you for the report!
