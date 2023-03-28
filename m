Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0BF6CCA12
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjC1Sfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC1Sfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:35:42 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EF71BE9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:35:41 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z83so16364359ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 11:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680028540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAYteq3mFV588TpLqRaA86uUyETx+bdriGoU/y4d71Q=;
        b=EtkvNeRanejerUBKb1YW3cH+uFNUeYLsqvaqGYBqdrzxnDPIhaTdpsAP5STbq4tqos
         VX3vS/hPsUvsRaov5cj5X+n8Dfw9cSF6EBigZbkMh08EAPI+bGNfsAItFKbgAWRnOahG
         3ura0nlamPbFBr1BxPGMsB3sQVsh3sB3eB/sP9+nKQdNYIAdsu+dxXbVuWHIwwl/Utl+
         V4qDqg+93Ku6ZNgowrnSX2vnpi8+X7GdsqEb6etgloYbB8ZnhRhS8AjL5jPncd02y8Lx
         DJ+2GSWatIo1RZXLx77f8fpT8JOLpChsogotPbGX6gzNf1pQzd/u9tfmn1buGCjQ95Av
         EbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAYteq3mFV588TpLqRaA86uUyETx+bdriGoU/y4d71Q=;
        b=x7IPkMYOD9f0qKk5lRRoWOy0QIXL6C3etUJP6PR0O9G/O8sPX5fkc4XBAAc0bwg+MC
         FpkRtj6WP+S1gQe1Nav1mwuR2VWTJmEnpdNaGT/LNoOwb0hSsblf5JL97B0/d0z9znNl
         rAYXyffFuFYfweXPvSO0ERnwNEAtd5ejqn86ZfL5L3P2+gvV6DHXDXbmA7x5OAmWxUcD
         vLplWsBDmZlZJ7955OWkPllQvhUZMjDEs+Ym7Gt1yTzVuEN7J+E36RvomtdnKPmc4UaC
         mlhMcsf8AKkKflCQq8JqFreNfTDN8DrsmvxPc1b1jDC/BS9G/L2SelOmK7qt3aWhzhWk
         dI5Q==
X-Gm-Message-State: AAQBX9efMjeCrUCrfP/HWPm2zQ1G56ASXjnFJmEwkZHfvf3UnJh5TJbg
        dr0L1/OJnAkKZZfiUXIv9h7MqP791Xu0HGG0rC+AWQ==
X-Google-Smtp-Source: AKy350YdWjxd5LK3M07fya8VNGhvEsapUC41YfV/gEay0jSdep7mSp60+MTMxUlrV/q2Vtcbppv04hHCkyRuXanpzEM=
X-Received: by 2002:a05:6902:1543:b0:b77:158d:b3a0 with SMTP id
 r3-20020a056902154300b00b77158db3a0mr14053685ybu.6.1680028540565; Tue, 28 Mar
 2023 11:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230328125807epcas1p1606c068a9043d6581a1fbdd30e7c53a2@epcas1p1.samsung.com>
 <20230328125818.5574-1-jaewon31.kim@samsung.com>
In-Reply-To: <20230328125818.5574-1-jaewon31.kim@samsung.com>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Tue, 28 Mar 2023 11:35:29 -0700
Message-ID: <CABdmKX1J6WzE9CMbRthROgHZLLhXZJBw4iOz-7q+RK5fGpggLA@mail.gmail.com>
Subject: Re: [PATCH] dma-buf/heaps: c9e8440eca61 staging: ion: Fix overflow
 and list bugs in system heap:
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     jstultz@google.com, sumit.semwal@linaro.org,
        daniel.vetter@ffwll.ch, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:58=E2=80=AFAM Jaewon Kim <jaewon31.kim@samsung.co=
m> wrote:
>
> Normal free:212600kB min:7664kB low:57100kB high:106536kB
>   reserved_highatomic:4096KB active_anon:276kB inactive_anon:180kB
>   active_file:1200kB inactive_file:0kB unevictable:2932kB
>   writepending:0kB present:4109312kB managed:3689488kB mlocked:2932kB
>   pagetables:13600kB bounce:0kB free_pcp:0kB local_pcp:0kB
>   free_cma:200844kB
> Out of memory and no killable processes...
> Kernel panic - not syncing: System is deadlocked on memory
>
> An OoM panic was reported, there were only native processes which are
> non-killable as OOM_SCORE_ADJ_MIN.
>
> After looking into the dump, I've found the dma-buf system heap was
> trying to allocate a huge size. It seems to be a signed negative value.
>
> dma_heap_ioctl_allocate(inline)
>     |  heap_allocation =3D 0xFFFFFFC02247BD38 -> (
>     |    len =3D 0xFFFFFFFFE7225100,
>
> Actually the old ion system heap had policy which does not allow that
> huge size with commit c9e8440eca61 ("staging: ion: Fix overflow and list
> bugs in system heap"). We need this change again. Single allocation
> should not be bigger than half of all memory.
>
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  drivers/dma-buf/heaps/system_heap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index e8bd10e60998..4c1ef2ecfb0f 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -351,6 +351,9 @@ static struct dma_buf *system_heap_allocate(struct dm=
a_heap *heap,
>         struct page *page, *tmp_page;
>         int i, ret =3D -ENOMEM;
>
> +       if (len / PAGE_SIZE > totalram_pages() / 2)
> +               return ERR_PTR(-ENOMEM);
> +

Instead of policy like that, would __GFP_RETRY_MAYFAIL on the system
heap's LOW_ORDER_GFP flags also avoid the panic, and eventually fail
the allocation request?
