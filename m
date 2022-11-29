Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6963BF59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiK2Lte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiK2Ltc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:49:32 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBD624090
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:49:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id y83so17086639yby.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KToa7R+tWe57h7Q6F1qr7Lg0Ngx6h/6bFBMqGMkri9A=;
        b=KWg1WWNqRJYvzYf/3YzwExxOx4ZsMdhCUFqoUpySN1QuMIIERwQ6HLgQ9kXuwvwSFA
         8WXWjIiCcWG5eBC1Le1kEqGnZOEDw8rUYpit45TFyB7ZVNmP2IvH+qNoAjMSvjZFQex5
         pNQh2kHhnu7VStMCG5XEfaWLSnWpX8RX1VANUlFrNJCYMJZUDyZO/VWktHOnKk12YGcX
         UQ0Wtkdzj+lo0YIOfm2b9glRQlAaUcN7HbwP3kTSPFesqZY4c2deBRUnOSlckaI+qyMx
         f+MFduF22j8WT3IcyPw+UDZHEPUSHmOZqQiPJNA5ZiGq+ejHIR89QSVLfPPGyaw7Yk9H
         wbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KToa7R+tWe57h7Q6F1qr7Lg0Ngx6h/6bFBMqGMkri9A=;
        b=PFG7F2qfP5djZgWATWVy5jzoCEQHnH7jj6FiHTIcjsXtaRjiSSDuPW/M+S84do7fH7
         qTJ4q6JLeJlb5PNmjhxEADQJY75VRLi8u+ixPbZkd3in2wQq2tMTMzfvQ54K5rGZxkzJ
         f58FHGQ0ZrBhHM+kWG0iDzosS/TY7OssR45G6uaahO/36tlN8S7njuGbxN9FOv1SDtcD
         lg6Rpkdyq2ViRzRi3F5j+ZWuQJOhee6TD1irBgf4wYqtk9ajGIuHDQurD/YQkUmrFNW+
         xPGoMmBOcxuZsBHTj0ZzUNdE68GFcQG0V5lnTXYE6acjOIBc0AV8+55w09XwbNw3LnD/
         AC2Q==
X-Gm-Message-State: ANoB5pl/aMUi1u5X9h6zO5DG/5oqdZJPmsR6S9atmTJBT9UBCRX8CLht
        elAeOagAXC3+sq/V0fs2PNxMlykGdLRDfyZsfq23lA==
X-Google-Smtp-Source: AA0mqf4xYINL19aZTRyDO6h3n08BWVgOeiNMBrRMJNyWu1Pugy+10+BnYK+927KL0NuECb64gZOwp0MlnbUuucUNuCg=
X-Received: by 2002:a25:e749:0:b0:6f1:9eb8:76d4 with SMTP id
 e70-20020a25e749000000b006f19eb876d4mr23938630ybh.143.1669722571129; Tue, 29
 Nov 2022 03:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20221129063358.3012362-1-feng.tang@intel.com> <20221129063358.3012362-2-feng.tang@intel.com>
 <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com> <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz>
In-Reply-To: <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Nov 2022 12:48:54 +0100
Message-ID: <CANpmjNNZhXX830jqPn9eaQZHwKhBb4b_PEuUdH6O69ELqW470w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, 29 Nov 2022 at 12:01, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/29/22 10:31, Marco Elver wrote:
> > On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:

> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index c71590f3a22b..b6cd98b16ba7 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -327,7 +327,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
> >>  /* Legal flag mask for kmem_cache_create(), for various configurations */
> >>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
> >>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> >> -                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
> >> +                        SLAB_KMALLOC | SLAB_SKIP_KFENCE | \
> >> +                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS)
> >
> > Shouldn't this hunk be in the previous patch, otherwise that patch
> > alone will fail?
>
> Good point.
>
> > This will also make SLAB_SKIP_KFENCE generally available to be used
> > for cache creation. This is a significant change, and before it wasn't
> > possible. Perhaps add a brief note to the commit message (or have a
> > separate patch). We were trying to avoid making this possible, as it
> > might be abused - however, given it's required for tests like these, I
> > suppose there's no way around it.
>
> For SLAB_SKIP_KFENCE, we could also add the flag after creation to avoid
> this trouble? After all there is a sysfs file to control it at runtime
> anyway (via skip_kfence_store()).
> In that case patch 1 would have to wrap kmem_cache_create() and the flag
> addition with a new function to avoid repeating. That function could also be
> adding SLAB_NO_USER_FLAGS to kmem_cache_create(), instead of the #define
> DEFAULT_FLAGS.

I wouldn't overcomplicate it, all we need is a way to say "this flag
should not be used directly" - and only have it available via an
indirect step. Availability via sysfs is one such step.

And for tests, there are 2 options:

1. we could provide a function "kmem_cache_set_test_flags(cache,
gfp_flags)" and define SLAB_TEST_FLAGS (which would include
SLAB_SKIP_KFENCE). This still allows to set it generally, but should
make abuse less likely due to the "test" in the name of that function.

2. just set it directly, s->flags |= SLAB_SKIP_KFENCE.

If you're fine with #2, that seems simplest and would be my preference.

> For SLAB_KMALLOC there's probably no such way unless we abuse the internal
> APIs even more and call e.g. create_boot_cache() instead of
> kmem_cache_create(). But that one is __init, so probably not. If we do
> instead allow the flag, I wouldn't add it to SLAB_CORE_FLAGS but rather
> SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTED.

I'd probably go with the simplest solution here.
