Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5701770B741
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjEVIDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjEVIDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:03:31 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDE69B;
        Mon, 22 May 2023 01:03:30 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-783eef15004so1831098241.3;
        Mon, 22 May 2023 01:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684742610; x=1687334610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/deT6NIs/fCmfBK6TadeTF6djYRsWDmBLQzhkm7Whg=;
        b=QK9rPLNa5YQIm4BrTN9G+Gp8sOyYcF3EKdXnKr8/9/PSYQ1vi0/0Uj4L/BmJbTc2we
         qJs3SIOqu758OmnrJ2FEhJ4p1EVRlm2S9uxj/13VWFOw7RzBrlGoMWDWap2oBM20esBP
         hZZywbt/uGTOo36/73mWU5yQCHlThzL7ebf0DmvA3dlBHdoqp9q1tO0k5T9U4/GH14R1
         i5xQkpFtI0s54mLkHCRIpQnKsT8DxWJyP2Krgo6lhJtdRNcxYH1LgFDgr79CVKxVx1eH
         jGYeIUAxIqXGi33JfzyBKulQ3Neom1TyrxEnKs0zyUdhp/vLUDXpNIrRPmBEicdh2VP7
         syrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684742610; x=1687334610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5/deT6NIs/fCmfBK6TadeTF6djYRsWDmBLQzhkm7Whg=;
        b=Dxewe7N0mGTlE7SKzJBkHZBTgZ/sNcrWI75hZ8OYqWcA0b6ExxA28B96UrMF5qFmNa
         mFOcr9UMYxBiZpCVsvWUAGr0EqERCM2z9WULHkyg5NRctRZrwGGYCNTD8GLTKM1Q6M/l
         ZVG1c6qx3cMhFidcHlLmVVcu6VHNBAzVkRcHz43LJeHOBjR0Z+VCqb0IRdAjcPXS2vjD
         ccKM2qYWBtY4+Nk3S7Kpkeq8deOSWc4skuewqF/QuAcs07YJPAmvJ66BLzKtbAGjx4ky
         042tmJPkhL/cJ8SezCfUVWunl4EDmm1SwDTYszIprI/Y690mKZNkKI46jbay0LgWSgRk
         t4pA==
X-Gm-Message-State: AC+VfDygLlUa5PQ6zmNvmQq/v1SUx7WhKDz/7eOrphLCkm7cpOiPPwW2
        Ryb7xyKXl5nt1RfhDn1vI1UyNhSJOIXSJ9S6jJg=
X-Google-Smtp-Source: ACHHUZ5RIyVZS4Zu5Pamc3MV66jkvYcnWuWIb5VA1JscKU7+8/Afy7hzNiltpdL4e7QJgffQP8PpI2kr86z8ouEF1ps=
X-Received: by 2002:a67:fe17:0:b0:439:e3f:9d6 with SMTP id l23-20020a67fe17000000b004390e3f09d6mr2336475vsr.17.1684742609589;
 Mon, 22 May 2023 01:03:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
 <5f5a858a-7017-5424-0fa0-db3b79e5d95e@huawei.com> <CAB=+i9R0GZiau7PKDSGdCOijPH1TVqA3rJ5tQLejJpoR55h6dg@mail.gmail.com>
 <19707cc6-fa5e-9835-f709-bc8568e4c9cd@huawei.com>
In-Reply-To: <19707cc6-fa5e-9835-f709-bc8568e4c9cd@huawei.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Mon, 22 May 2023 17:03:37 +0900
Message-ID: <CAB=+i9T-iqtMZw8y7SxkaFBtiXA93YwFFEtQyGynBsorud1+_Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
To:     Gong Ruiqi <gongruiqi1@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 4:35=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.com> =
wrote:
> On 2023/05/17 6:35, Hyeonggon Yoo wrote:
[...]
> >>>> +#ifdef CONFIG_RANDOM_KMALLOC_CACHES
> >>>> +# define SLAB_RANDOMSLAB       ((slab_flags_t __force)0x01000000U)
> >>>> +#else
> >>>> +# define SLAB_RANDOMSLAB       0
> >>>> +#endif
> >
> > There is already the SLAB_KMALLOC flag that indicates if a cache is a
> > kmalloc cache. I think that would be enough for preventing merging
> > kmalloc caches?
>
> After digging into the code of slab merging (e.g. slab_unmergeable(),
> find_mergeable(), SLAB_NEVER_MERGE, SLAB_MERGE_SAME etc), I haven't
> found an existing mechanism that prevents normal kmalloc caches with
> SLAB_KMALLOC from being merged with other slab caches. Maybe I missed
> something?
>
> While SLAB_RANDOMSLAB, unlike SLAB_KMALLOC, is added into
> SLAB_NEVER_MERGE, which explicitly indicates the no-merge policy.

I mean, why not make slab_unmergable()/find_mergeable() not to merge kmallo=
c
caches when CONFIG_RANDOM_KMALLOC_CACHES is enabled, instead of a new flag?

Something like this:

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 607249785c07..13ac08e3e6a0 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -140,6 +140,9 @@ int slab_unmergeable(struct kmem_cache *s)
  if (slab_nomerge || (s->flags & SLAB_NEVER_MERGE))
  return 1;

+ if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
+ return 1;
+
  if (s->ctor)
  return 1;

@@ -176,6 +179,9 @@ struct kmem_cache *find_mergeable(unsigned int
size, unsigned int align,
  if (flags & SLAB_NEVER_MERGE)
  return NULL;

+ if (IS_ENALBED(CONFIG_RANDOM_KMALLOC_CACHES) && (flags & SLAB_KMALLOC))
+ return NULL;
+
  list_for_each_entry_reverse(s, &slab_caches, list) {
  if (slab_unmergeable(s))
  continue;
