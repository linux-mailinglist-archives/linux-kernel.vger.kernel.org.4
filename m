Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C863C07B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiK2M5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiK2M4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:56:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AA960EBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:56:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id o127so1821098yba.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eQ2q70MxmrOTbyY/3idcvpot4MIQOw6xbYQRAtAnHRk=;
        b=k2CNqn4mmj4GxHren8t1/WpNcwnKbVDjdcpLv/RrGu2RoN9vE8ISGcNpmGrZUgp4x6
         Pl3bgYcY5wHW3oNo/keuSbf9CYoAyPCy5gvbAATXwgkvlFVnte370kxzSxozhMrV70N9
         54bb4mbKdDeALTNypg9O7h5clw2O+BOLf9O5Bh/evHwxwHwdgtrIpXLZejf3XCie9DLp
         z46XKJL3U2KAdzHAAI0ki2IjRsKDKTdEiA0ffrm/Q17I3YEwBtn4mI8K28phKEHjt9vc
         Tzwu2o0PyOR3EmYssrhwKDEyU/w/wO9BcrMeHUIajjRrW9JtAUx7pxuQDdqEP8gay66H
         gBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQ2q70MxmrOTbyY/3idcvpot4MIQOw6xbYQRAtAnHRk=;
        b=gxqAwFNgDWOgvs49n+IXjkzQ323stXlL3NuWRMH7GCgPvxU8hcJAnKmrU0WNtu+hKt
         ROmxj44KFXaB4GgF6q2ZZfuBt/9Yweydou+GeI2PM9z4XdM9od+2UuCJclacDSXKPoM2
         F7NK0n7iXDpQSEZn39XQlYoGZKVqiyWc+1T5cKB8FYo+4L+55mBNJhcaIL3un1eewmXi
         qrJcSMXtm/B9s4s07bei7MEvM9fjvke435tSmjVlnqWJHEqgmwD8udift4sPY80s+z8a
         rrRer7h7A8SmNQIrwKZYHm8c2WaD8qY0XTUJzeVd0Xvxhf8rEv7+3fEtzc00JJ3diGel
         9y2g==
X-Gm-Message-State: ANoB5pn9S1SKdnVvKr0FMBORJhPEZn9Qr6sqIi3z0sfK4C0GFSN20GZw
        8C7hKoJVO4EKztzid/n7goCnGPg4zN3CvLvoCbSFpA==
X-Google-Smtp-Source: AA0mqf4PQ4Y68c2XrynpIIxjyPxdSRYah17bCPQEUU08Zqa1ulpRxof1sNCWke5miQDd6dOMZUbUAmVyyD43g37IsPM=
X-Received: by 2002:a25:e749:0:b0:6f1:9eb8:76d4 with SMTP id
 e70-20020a25e749000000b006f19eb876d4mr24173229ybh.143.1669726611154; Tue, 29
 Nov 2022 04:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20221129063358.3012362-1-feng.tang@intel.com> <20221129063358.3012362-2-feng.tang@intel.com>
 <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
 <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz> <CANpmjNNZhXX830jqPn9eaQZHwKhBb4b_PEuUdH6O69ELqW470w@mail.gmail.com>
 <d6c614fe-cc80-7a19-1fa6-2ed6cc75b705@suse.cz> <Y4YAC9UTxQLg4Y5q@feng-clx>
In-Reply-To: <Y4YAC9UTxQLg4Y5q@feng-clx>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Nov 2022 13:56:15 +0100
Message-ID: <CANpmjNPm1JUB6O-xBOT_Ab0ztKnjX1kgnr=81AzTg=Tkt6yCBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, 29 Nov 2022 at 13:53, Feng Tang <feng.tang@intel.com> wrote:
>
> On Tue, Nov 29, 2022 at 08:02:51PM +0800, Vlastimil Babka wrote:
> > On 11/29/22 12:48, Marco Elver wrote:
> > > On Tue, 29 Nov 2022 at 12:01, Vlastimil Babka <vbabka@suse.cz> wrote:
> > >>
> > >> On 11/29/22 10:31, Marco Elver wrote:
> > >> > On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:
> > >
> > >> For SLAB_SKIP_KFENCE, we could also add the flag after creation to avoid
> > >> this trouble? After all there is a sysfs file to control it at runtime
> > >> anyway (via skip_kfence_store()).
> > >> In that case patch 1 would have to wrap kmem_cache_create() and the flag
> > >> addition with a new function to avoid repeating. That function could also be
> > >> adding SLAB_NO_USER_FLAGS to kmem_cache_create(), instead of the #define
> > >> DEFAULT_FLAGS.
> > >
> > > I wouldn't overcomplicate it, all we need is a way to say "this flag
> > > should not be used directly" - and only have it available via an
> > > indirect step. Availability via sysfs is one such step.
> > >
> > > And for tests, there are 2 options:
> > >
> > > 1. we could provide a function "kmem_cache_set_test_flags(cache,
> > > gfp_flags)" and define SLAB_TEST_FLAGS (which would include
> > > SLAB_SKIP_KFENCE). This still allows to set it generally, but should
> > > make abuse less likely due to the "test" in the name of that function.
> > >
> > > 2. just set it directly, s->flags |= SLAB_SKIP_KFENCE.
> > >
> > > If you're fine with #2, that seems simplest and would be my preference.
> >
> > Yeah, that's what I meant. But slub_kunit.c could still have own internal
> > cache creation function so the "|SLAB_NO_USER_FLAGS" and "s->flags |=
> > SLAB_SKIP_KFENCE" is not repeated X times.
>
> I just quickly tried adding a new wrapper, like
>
>   struct kmem_cache *debug_kmem_cache_create(const char *name, unsigned int size,
>                         unsigned int align, slab_flags_t flags,
>                         void (*ctor)(void *), slab_flags_t debug_flags);
>
> and found that, IIUC, both SLAB_KMALLOC and SLAB_NO_USER are creation
> time flag, while SLAB_SKIP_KFENCE is an allocation runtime flag which
> could be set after creation.
>
> So how about use the initial suggestion from Vlastimil to set the
> SKIP_KFENCE flag through an internal wrapper in slub_kunit.c?
>
>         /* Only for debug and test use, to skip kfence allocation */
>         static inline void kmem_cache_skip_kfence(struct kmem_cache *s)
>         {
>                 s->flags |= SLAB_SKIP_KFENCE;
>         }

Yes, that's fine - as long as it's local to slub_kunit.c, this seems
very reasonable.

Thanks,
-- Marco
