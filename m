Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554F8737814
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFUAGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUAGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:06:03 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E06198
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:06:02 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bf3934ee767so4002405276.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687305961; x=1689897961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3G/JH8xUdw8gSx/YEs/5ci0zS1wvZQqJqScEFLkqKI=;
        b=K0nt7buSuZeY8253GtOBvNOwCaBAwpvBeFzHgStIvYAyDQbUyw5Ggzr3/eBnacM1Ri
         EyCHLc8gYodL0dMMwHX7T0m20wsKcnPbiJY+SLgA3xT8LvJ2BKd1/3sABKCMbk+ArHOC
         7WUEcml7ty8dHzodyCukKj4Zrr67KdcdOrQ9QjJ/hRU1Ya9mWnTymABHxmOdJUgLTSid
         cFvXyzety5eJ/ayI6nt9rIQyqQ0VB6sgVr8gIXyO9i4AeIn/msXhQd2n8DIL0S3Juon9
         rH+mv4+hbQ+Vi0RnAqOu0jXtrWb7KDJ1SGPAFllVAJTNSUHdGzACTBX2PG4AFQwJGQvU
         FDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305961; x=1689897961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3G/JH8xUdw8gSx/YEs/5ci0zS1wvZQqJqScEFLkqKI=;
        b=X7FC5KJZuHxcZYMZwpkKFCwWFa0raMqwKSX3+IPmhuQxTSgd8Go2R6InGpc+LfELlT
         Wi819nYuTN3NZbS0RnM6PtGeTFhpxKnhYKPCHBGjRp7GtRUQtlelBfJl4zoe/z65KLCg
         Nv72YDG/UdjC2vvw7rN1BYX3QVwGUeel2hsItW2JlQ3YBd52JFLmakvscD11uSzUtYna
         UBPG9hXhhjZJ+73vVVwVBgSSQUNUd8mcg3l+kTTCs/Qf636V0GN+cZ37x9S7Kq/ATUu8
         hd1hKJ07VbKm1lWKYTWjFfOyVJ89HtA6RhYaBd2VPRw1I8gF00Vij8iZ1fvmH9P2JDgm
         m7Bw==
X-Gm-Message-State: AC+VfDy9mQUxYDDFWXhE++rU3QVR0DXJ5v9GXGLIv8tBQAvxZ5CJBuFi
        3ZJ6kWR4xOnulbINu8bgoJ+lFi18kPlF7bKORMNAZg==
X-Google-Smtp-Source: ACHHUZ6HliN/tqzrkE+hwWXJ3eDEJh9Paxo8Q+e7QGdLi4QHGQOV5HKfF09Xm1pULkdijbsbh3oBaFeCImPM3G3EFro=
X-Received: by 2002:a25:32d6:0:b0:bca:f238:5ff2 with SMTP id
 y205-20020a2532d6000000b00bcaf2385ff2mr14405390yby.8.1687305961083; Tue, 20
 Jun 2023 17:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230620235726.3873043-1-surenb@google.com> <20230620235726.3873043-3-surenb@google.com>
In-Reply-To: <20230620235726.3873043-3-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 20 Jun 2023 17:05:50 -0700
Message-ID: <CAJuCfpH+oMZeYYfKOavDBN85j2+tfxvGz56gMmbpJAepHghUjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: check for VMA being detached before destroying it
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, torvalds@linuxfoundation.org,
        vegard.nossum@oracle.com, mpe@ellerman.id.au,
        Liam.Howlett@oracle.com, lrh2000@pku.edu.cn, mgorman@suse.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 4:57=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> By the time VMA is freed it has to be detached with the exception of
> exit_mmap which is destroying the whole VMA tree. Enforce this
> requirement before freeing the VMA. exit_mmap in the only user calling
> __vm_area_free directly, therefore it won't trigger the new check.
> Change VMA initialization to mark new VMAs as detached and change that
> flag once the VMA is added into a tree.
>
> Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

My tests did not generate the warning but the test coverage is far
from perfect, so if someone can run extensive testing on this one that
would be greatly appreciated.
Thanks,
Suren.

> ---
>  include/linux/mm.h | 4 ++--
>  kernel/fork.c      | 2 ++
>  mm/internal.h      | 1 +
>  3 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 74e3033c9fc2..9a10fcdb134e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -247,7 +247,7 @@ void setup_initial_init_mm(void *start_code, void *en=
d_code,
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *);
>  struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
>  void vm_area_free(struct vm_area_struct *);
> -/* Use only if VMA has no other users */
> +/* Use only if VMA has no other users and might still be attached to a t=
ree */
>  void __vm_area_free(struct vm_area_struct *vma);
>
>  #ifndef CONFIG_MMU
> @@ -751,7 +751,7 @@ static inline void vma_init(struct vm_area_struct *vm=
a, struct mm_struct *mm)
>         vma->vm_mm =3D mm;
>         vma->vm_ops =3D &dummy_vm_ops;
>         INIT_LIST_HEAD(&vma->anon_vma_chain);
> -       vma_mark_detached(vma, false);
> +       vma->detached =3D true;
>         vma_numab_state_init(vma);
>  }
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 41c964104b58..000fc429345c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -540,6 +540,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head=
)
>
>         /* The vma should not be locked while being destroyed. */
>         VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> +       WARN_ON_ONCE(!vma->detached);
>         __vm_area_free(vma);
>  }
>  #endif
> @@ -549,6 +550,7 @@ void vm_area_free(struct vm_area_struct *vma)
>  #ifdef CONFIG_PER_VMA_LOCK
>         call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
>  #else
> +       WARN_ON_ONCE(!vma->detached);
>         __vm_area_free(vma);
>  #endif
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 68410c6d97ac..728189e6c703 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1068,6 +1068,7 @@ static inline void vma_iter_store(struct vma_iterat=
or *vmi,
>         vmi->mas.index =3D vma->vm_start;
>         vmi->mas.last =3D vma->vm_end - 1;
>         mas_store_prealloc(&vmi->mas, vma);
> +       vma_mark_detached(vma, false);
>  }
>
>  static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
> --
> 2.41.0.162.gfafddb0af9-goog
>
