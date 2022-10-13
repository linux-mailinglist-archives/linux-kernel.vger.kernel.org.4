Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00BD5FDBE3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 16:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiJMODK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 10:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJMODG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 10:03:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41B1E09EE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:02:36 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id w3so1125884qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/q9HFSGdoaZv7OXKTbYpwwK8nkInj5DxOSaXWkZAU+U=;
        b=Kcak6tm0SuGgWwsrDMBLqrQ7qRQe4J5N/ixufaeWu9b7IROIEG9bpyA+ivJFEVwpxG
         T0gNt1R0XXbdDGaG68MG4F8hw6552zAxTWwLSJBBHuoXjnSz3QgZ2+C8QRlsyQh+ABh1
         kH+H+ZP3GETqrOkXvrlj8ex2hrx2CuGIvnl/jtK3VJhEJE7PQ7oIOdb8f04BA7kP+Xbm
         A6Q56vX3vrMO3qIYJ5OMCh53vbypeXwa4jGVX4S6zJciJUIg+vgZYn9k36oENl1O6oD5
         vP1i/ZxKWYAYIemsNBySzufQ6bUFSjb9r5Lph0iDp+fkReHzBUonwShArPPNQURBgy0i
         g6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q9HFSGdoaZv7OXKTbYpwwK8nkInj5DxOSaXWkZAU+U=;
        b=6UiXGJJxcucTMwhH4T1JH22fyume/Fd8nneeBMpiGUbn5C1Bp+pqMoHTC7eJXo1J3L
         7Bts14C/NIaff/y9iJ9oPNi7Lc2e+quO8qXM8WUM1hXTQbF9HCi+oRZ4aGvfbNd1r5DR
         L01ukV0n8P5eJ06CUQfQLpvM4+o4C2gJtiTTjUaGzleH0+CRRml1omSEDIbqf7B8vPc8
         4t3DS0+eDKT5fEffLfTJnOxyoIQLSBQoKx+VGBY8+3CuqxGdGGuF/OMHIxdxhbfcuSQg
         +UPyMQpOsyGiUJNDwxJAnhhis2o8EHLtKc4urGaXl4ICizK7lTO0lv28FhGWtt6RQqF8
         h81Q==
X-Gm-Message-State: ACrzQf0iro6o4GPLE7gJszHWHfaV+q5ChBt5DrVEM/yNoMmilHUUCNYK
        fTZcD9Wr02rs9az/rfqCj3PKAURvSa1KGDW4oeE=
X-Google-Smtp-Source: AMsMyM64yFZ8mtXWRw8gK7FV/429jX/QlN/bnSB3WDi3V83jXcuf1B3cPY45R4wDJLmpzgZuDYW+KxzjfLg+JYj00P8=
X-Received: by 2002:a05:620a:d94:b0:6bc:5a8c:3168 with SMTP id
 q20-20020a05620a0d9400b006bc5a8c3168mr38151qkl.56.1665669668750; Thu, 13 Oct
 2022 07:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220913065423.520159-1-feng.tang@intel.com> <20220913065423.520159-3-feng.tang@intel.com>
 <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com> <YzJi/NmT3jW1jw4C@feng-clx>
In-Reply-To: <YzJi/NmT3jW1jw4C@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 13 Oct 2022 16:00:57 +0200
Message-ID: <CA+fCnZdvqZzCU_LO178ZsPDvs-Unkh2iZ4Rq5Amb=zS31aWFpA@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
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

On Tue, Sep 27, 2022 at 4:42 AM Feng Tang <feng.tang@intel.com> wrote:
>
> > > @@ -746,7 +747,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
> > >         for (i = 0; i < size; i++) {
> > >                 p[i] = kasan_slab_alloc(s, p[i], flags, init);
> > >                 if (p[i] && init && !kasan_has_integrated_init())
> > > -                       memset(p[i], 0, s->object_size);
> > > +                       memset(p[i], 0, orig_size);
> >
> > Note that when KASAN is enabled and has integrated init, it will
> > initialize the whole object, which leads to an inconsistency with this
> > change.
>
> Do you mean for kzalloc() only? or there is some kasan check newly added?

Hi Feng,

I mean that when init is true and kasan_has_integrated_init() is true
(with HW_TAGS mode), kasan_slab_alloc() initializes the whole object.
Which is inconsistent with the memset() of only orig_size when
!kasan_has_integrated_init(). But I think this is fine assuming SLAB
poisoning happens later. But please add a comment.

Thanks!
