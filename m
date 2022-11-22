Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983ED633936
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKVJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiKVJ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:58:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6818E34
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:58:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k5so12816620pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Iswb2ultRT2N7P9BN9RKy+2BlKMbcXeEkzv8Y2QxO6g=;
        b=fFy0T2aFQS4NKdGRR3w9Kj1jqFSbkd+C5NiERcU4bhqH9G+l0zseqwiasB9Pwl6ON8
         wYeiWNEIMsKfHHINSB9Ud6nDE68z3DCRHk+nju+r9w7Qp0VjkzQ8Scn06NNnVpmPayTk
         cgYT7r970hhJQIO4BguxwGFtQGNcq6uPY89vgXAxt9EwyC/W5BuXGW9wrKWx3S0XJnSk
         NzWVi4rbrMglfusJWY1sCVGe9ex1g9/44lRtsRCPsB6oX+pWoh3W7S4sMCa7b9FmfsV4
         Kc2kF5BWVBq7PJZHodC+1EQuvpCTutqPJioH1mjgtqfYO6+HJaD6he/XE5rtuVbSPtoS
         eORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iswb2ultRT2N7P9BN9RKy+2BlKMbcXeEkzv8Y2QxO6g=;
        b=D+Rl7VS5wD35WZOFKZC3UgXTageBNmgixjCVobZYHoI0A7eYXlj2XgZy/5ozSKs87F
         Yp8tFdGnN1YJIo0yOtxBhNSwkl4vEkcqPK+fNasYq5fy15y90GuQ5wnjqUEIGP0iYzZz
         3AxMmqK8qCPYVJ3aLSoLMcT2klE1RJpwNXLP2V5aFd/9GbYwdbJ2SG2AUYG72VBhaY9D
         bLKF7EW71l9bQkcxbTwC8+1ddCDCrMjjDKJwHhtmivjPcbkSKkGoEpGLjSlznvqGjaPL
         t7MhWQ5iVsezKsgphxNj/N2doZx0zsny1rplCfJUAuqDLSqRpjRXmhEMO+17mN+dywSH
         OEYA==
X-Gm-Message-State: ANoB5plqWH/3uyFQAgT7e7gaQkwrXkrxJIX+iD2xvKa2jxoxRZlmtWad
        nGHSMeK3cMz6/oyPIN6/jhT67D5WD5jrGcOlwJU=
X-Google-Smtp-Source: AA0mqf6WcEk3GnbZurHe3unXBl7NHtFkiS1TosZ/XBuoZulgtWXKQtn9M30UMf668cjXXIIXNDHhm2c5CSh572AOyTM=
X-Received: by 2002:a17:902:8214:b0:188:e878:b5f6 with SMTP id
 x20-20020a170902821400b00188e878b5f6mr3038130pln.150.1669111087764; Tue, 22
 Nov 2022 01:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20221121135024.1655240-1-feng.tang@intel.com> <20221121135024.1655240-2-feng.tang@intel.com>
 <CA+fCnZenKqb9_a2e5b25-DQ3uAKPgm=+tTDOP+D9c6wbDSjMNA@mail.gmail.com> <Y3xx7JUaRfRXRriw@feng-clx>
In-Reply-To: <Y3xx7JUaRfRXRriw@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 22 Nov 2022 10:57:56 +0100
Message-ID: <CA+fCnZe0av3Ko8iRGAFjF1jpG77cE3mtQVK-HqZE9sP=eGwGtQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] mm/kasan: simplify is_kmalloc check
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
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 22, 2022 at 7:56 AM Feng Tang <feng.tang@intel.com> wrote:
>
> On Mon, Nov 21, 2022 at 04:15:32PM +0100, Andrey Konovalov wrote:
> > On Mon, Nov 21, 2022 at 2:53 PM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > Use new is_kmalloc_cache() to simplify the code of checking whether
> > > a kmem_cache is a kmalloc cache.
> > >
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> >
> > Hi Feng,
> >
> > Nice simplification!
> >
> > > ---
> > >  include/linux/kasan.h | 9 ---------
> > >  mm/kasan/common.c     | 9 ++-------
> > >  mm/slab_common.c      | 1 -
> > >  3 files changed, 2 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index dff604912687..fc46f5d6f404 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -102,7 +102,6 @@ struct kasan_cache {
> > >         int alloc_meta_offset;
> > >         int free_meta_offset;
> > >  #endif
> > > -       bool is_kmalloc;
> > >  };
> >
> > We can go even further here, and only define the kasan_cache struct
> > and add the kasan_info field to kmem_cache when CONFIG_KASAN_GENERIC
> > is enabled.
>
> Good idea. thanks!
>
> I mainly checked the kasan_cache related code, and make an add-on
> patch below, please let me know if my understanding is wrong or I
> missed anything.
>
> Thanks,
> Feng
>
> ---
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 0ac6505367ee..f2e41290094e 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -96,14 +96,6 @@ static inline bool kasan_has_integrated_init(void)
>  }
>
>  #ifdef CONFIG_KASAN
> -
> -struct kasan_cache {
> -#ifdef CONFIG_KASAN_GENERIC
> -       int alloc_meta_offset;
> -       int free_meta_offset;
> -#endif
> -};
> -
>  void __kasan_unpoison_range(const void *addr, size_t size);
>  static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
>  {
> @@ -293,6 +285,11 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
>
>  #ifdef CONFIG_KASAN_GENERIC
>
> +struct kasan_cache {
> +       int alloc_meta_offset;
> +       int free_meta_offset;
> +};
> +
>  size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
>  slab_flags_t kasan_never_merge(void);
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
> index f0ffad6a3365..39f7f1f95de2 100644
> --- a/include/linux/slab_def.h
> +++ b/include/linux/slab_def.h
> @@ -72,7 +72,7 @@ struct kmem_cache {
>         int obj_offset;
>  #endif /* CONFIG_DEBUG_SLAB */
>
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>         struct kasan_cache kasan_info;
>  #endif
>
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index f9c68a9dac04..4e7cdada4bbb 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -132,7 +132,7 @@ struct kmem_cache {
>         unsigned int *random_seq;
>  #endif
>
> -#ifdef CONFIG_KASAN
> +#ifdef CONFIG_KASAN_GENERIC
>         struct kasan_cache kasan_info;
>  #endif

Yes, this looks good.

Please resend as a v2 and I'll give a Reviewed-by.

Thanks!
