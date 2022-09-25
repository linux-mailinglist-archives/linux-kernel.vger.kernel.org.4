Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DA15E9460
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 18:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiIYQbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 12:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIYQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 12:31:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD40229CBF
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:31:48 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id s13so3061929qvq.10
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=C77rGCAYqGdTYQ5Hat6z7HfUcuu3QTxI69RZhcgUIhM=;
        b=ARNgIAQgcmdEtZOEexNNmGTo6Z9hsC3jci8S3O3+hey4a9RZsz3JkKVf+xclu8qRBe
         SQFORAr9hfCEyo+ZnGbD0dcJnnb38ai3BTpsv98wqNG5QYC4J8/pM0tegoZkeCv9DQyO
         QjP768mKhlw/fy6EQ1iSVh/6t1thIPSr3E1H96PLQ96JaihyJu/r15rK0qjEpoYoID2h
         dAjEZhhoobRodaqreGvoP7UEhHRstXMbD1MhrqzDruOhMZ8Yh8cr357KG+0ud0irD9pp
         2n6TKfAhTMRe89Kf80nzRGVXZmc0ly85uTuVnCcCk4laF1isEnAfhj2/3R0jGPBkZb3T
         PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C77rGCAYqGdTYQ5Hat6z7HfUcuu3QTxI69RZhcgUIhM=;
        b=GCYyQE7z5BXTJ51VtkgSUnLeC0DCmMXCBYU/Gwe50pV13G5e0xGEsvNk/Yt7xGvnSG
         Jo9pgLaACbw6cy5xRy3sXsLUGa/2yhsZGKV0jVTivJ/aNOdzPq75z4ejMZf3pi92PNdN
         royej3yjNuqW8XYHvlx0hAknODoI817K8d6dO6E2rUQigGryPR0vMnO7/HVjlUmZnpRE
         1dtaYqgQMTAOPSE3t8ckAFprT0p+jq6RjIptMCWjbDGggWIGyhoedBEpWjRmHyAlBBLv
         XHB9QCypTHXAsVxZRVSOOLEFkd4CXIsZ91xx9jkcpnYMdtBLv5XpHaCfmpxjDJyaOEgZ
         hdtw==
X-Gm-Message-State: ACrzQf3spUDGEbxjzQVW7chBF2dG9zn+oQajp742gtBCoX/J9nEYHaeV
        411piAQ8bGv6Nf22wDc0OO5noc3BYz6ZJe1N1/E=
X-Google-Smtp-Source: AMsMyM4doZj44Hg5ElMbFU3KNWnssOmCSzbnnb/z3KiU48Pk6cWRggRQJQWV2OBGFJGgx6O67DOEFuPTFYCCrGQmbuE=
X-Received: by 2002:ad4:5be2:0:b0:4ad:791c:8724 with SMTP id
 k2-20020ad45be2000000b004ad791c8724mr14396644qvc.56.1664123507765; Sun, 25
 Sep 2022 09:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220913065423.520159-1-feng.tang@intel.com> <20220913065423.520159-4-feng.tang@intel.com>
 <CA+fCnZdFi471MxQG9RduQcBZWR10GCqxyNkuaDXzX6y4zCaYAQ@mail.gmail.com>
 <Yyr9ZZnVPgr4GHYQ@feng-clx> <CA+fCnZdUF3YiNpy10=xOJmPVbftaJr76wB5E58v0W_946Uketw@mail.gmail.com>
 <YzA68cSh5Uuh5pjZ@feng-clx>
In-Reply-To: <YzA68cSh5Uuh5pjZ@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 25 Sep 2022 18:31:37 +0200
Message-ID: <CA+fCnZd4SD4rSD5yWogwvYm0h7YZ73CXFNCSd8PVOSeNXdWR1Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
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
        "Sang, Oliver" <oliver.sang@intel.com>
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

On Sun, Sep 25, 2022 at 1:27 PM Feng Tang <feng.tang@intel.com> wrote:
>
> > [1] https://lore.kernel.org/linux-mm/c7b316d30d90e5947eb8280f4dc78856a49298cf.1662411799.git.andreyknvl@google.com/
>
> I noticed this has been merged to -mm tree's 'mm-everything' branch,
> so following is the patch againt that. Thanks!
>
> One thing I'm not very sure is, to check 'in-object' kasan's meta
> size, I didn't check 'alloc_meta_offset', as from the code reading
> the alloc_meta is never put inside slab object data area.

Yes, this is correct.

> Thanks,
> Feng
>
> ---8<---
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index d811b3d7d2a1..96c9d56e5510 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -302,7 +302,7 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>
>  #ifdef CONFIG_KASAN_GENERIC
>
> -size_t kasan_metadata_size(struct kmem_cache *cache);
> +size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
>  slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         slab_flags_t *flags);
> @@ -315,7 +315,8 @@ void kasan_record_aux_stack_noalloc(void *ptr);
>  #else /* CONFIG_KASAN_GENERIC */
>
>  /* Tag-based KASAN modes do not use per-object metadata. */
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache,
> +                                               bool in_object)
>  {
>         return 0;
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d8b5590f9484..5a806f9b9466 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -450,15 +450,22 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
>  }
>
> -size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
>  {
> +       struct kasan_cache *info = &cache->kasan_info ;
> +
>         if (!kasan_requires_meta())
>                 return 0;
> -       return (cache->kasan_info.alloc_meta_offset ?
> -               sizeof(struct kasan_alloc_meta) : 0) +
> -               ((cache->kasan_info.free_meta_offset &&
> -                 cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
> -                sizeof(struct kasan_free_meta) : 0);
> +
> +       if (in_object)
> +               return (info->free_meta_offset ?
> +                       0 : sizeof(struct kasan_free_meta));
> +       else
> +               return (info->alloc_meta_offset ?
> +                       sizeof(struct kasan_alloc_meta) : 0) +
> +                       ((info->free_meta_offset &&
> +                       info->free_meta_offset != KASAN_NO_FREE_META) ?
> +                       sizeof(struct kasan_free_meta) : 0);
>  }
>
>  static void __kasan_record_aux_stack(void *addr, bool can_alloc)
> diff --git a/mm/slub.c b/mm/slub.c
> index ce8310e131b3..a75c21a0da8b 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -887,7 +887,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
>         if (s->flags & SLAB_STORE_USER)
>                 off += 2 * sizeof(struct track);
>
> -       off += kasan_metadata_size(s);
> +       off += kasan_metadata_size(s, false);
>
>         if (off != size_from_object(s))
>                 /* Beginning of the filler is the free pointer */
> @@ -1042,7 +1042,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>                 /* We also have user information there */
>                 off += 2 * sizeof(struct track);
>
> -       off += kasan_metadata_size(s);
> +       off += kasan_metadata_size(s, false);
>
>         if (size_from_object(s) == off)
>                 return 1;

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
