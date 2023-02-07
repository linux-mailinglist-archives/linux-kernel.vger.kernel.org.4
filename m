Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2168E391
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjBGWtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBGWs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:48:58 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676B1F498
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:48:57 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5254e8994e8so168912127b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFjw02IGyYSdDqsEhGgv/e8XgYEcv3UpXCjNfFEdXS0=;
        b=GI/ToeaWmvHz6ucktkDFQkkqRo3i5y+Gl6saKyeYIQ/pC5tRn0XVLeambEGioJVxWN
         74/vWrgZbak2g8mxqJ3b39fwMzpg8AXkOqsq0WBQ40wMx9RryCeR+M/ypiDwVAAt1Dov
         Pj3zDXQaWYwOzDzCALo7WSz5sRGFCq5NLOUyJh0BlIp558muUp/xxKIAHtnsoSNY2PcO
         ZzwCK0NoOP0+hbDNcUgCUFykO8tmPMGM6bEfhbkiWhw0x+AgJVSljuKKbbq0IR0XFfcy
         zSa1QCyz44N0mu3+I2H6VeRYq27qmbA44vPNwAsAp/el994/bY0UeNt40FwWQ200DCHA
         qKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFjw02IGyYSdDqsEhGgv/e8XgYEcv3UpXCjNfFEdXS0=;
        b=nDgO6pBWx4nLewl0o1DDAjW8/0+9MbCcJoEKUvM4gyhlPx+Tff+sr+Aao/VbqxSbZ9
         DnrTC8RexkNyz5UTUdhuvV0PDPkkze8Q8CbWPJMsv8IUs69XwTPXktLX83ZeXT9wj/mA
         FQgMsBgaswcXyj83JnisaIjAGdkXuxHg6a83chLqOK0aY9McKeowkUqqW1ja1+HioQX3
         XKZ4Ky6e26dOj6OmYAaJ4DNWn4ocBCFlLdUEg/lDM3LDD5xMWtgjxYZwvUV/MYRg8WoM
         /oBWqmxupY9Hl+qVqwZVLVYNZQo58vJ6DhJYm09jue7sqHoRvApUVgbvrfID4sPT1k3r
         ROaQ==
X-Gm-Message-State: AO0yUKWRPc2jujLEL+DltcLcE2nOE5yIJmzTpNPK418WEocoet5ou+wG
        WVLLxriXGAHDRokwYo1hpQOiBXJj1rfRbqp4MQtKyw==
X-Google-Smtp-Source: AK7set/3u4YHNlC+/83bA4p+sLvvz8D/RgSPVT+/yvkr6U5mkJh85s9pupfui0U5sJPjLsQU9F32UlhNbSMsZOMimyQ=
X-Received: by 2002:a0d:d7cf:0:b0:50f:a78f:8c2 with SMTP id
 z198-20020a0dd7cf000000b0050fa78f08c2mr511373ywd.438.1675810136127; Tue, 07
 Feb 2023 14:48:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675690847.git.quic_charante@quicinc.com> <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
In-Reply-To: <08e04b5d2fc7a2300a52fb7fff1bc6316a53927c.1675690847.git.quic_charante@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 7 Feb 2023 14:48:44 -0800
Message-ID: <CAJuCfpH7Jag9qEcKjGTx9Qv_oekM6qRVkGwzTrXShgYbLdLKtg@mail.gmail.com>
Subject: Re: [PATCH V6 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, shakeelb@google.com,
        mhocko@suse.com, vbabka@suse.cz, quic_pkondeti@quicinc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

Hi Charan,

On Mon, Feb 6, 2023 at 6:22 AM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
>
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the clients who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt](). One usecase is implemented on the
> Snapdragon SoC's running Android where the graphics client is allocating
> lot of shmem pages per process and pinning them. When this process is
> put to background, the instantaneous reclaim is performed on those shmem
> pages using the logic implemented downstream[3][4]. With this patch, the

Thanks for upstreaming this feature!

> client can now issue the fadvise calls on the shmem files that does the
> instantaneous reclaim which can aid the use cases like mentioned above.
>
> This usecase lead to ~2% reduction in average launch latencies of the
> apps and 10% in total number of kills by the low memory killer running
> on Android.
>
> Some questions asked while reviewing this patch:
> Q) Can the same thing be achieved with FD mapped to user and use
> madvise?
> A) All drivers are not mapping all the shmem fd's to user space and want
> to manage them with in the kernel. Ex: shmem memory can be mapped to the
> other subsystems and they fill in the data and then give it to other
> subsystem for further processing, where, the user mapping is not at all
> required.  A simple example, memory that is given for gpu subsystem
> which can be filled directly and give to display subsystem. And the
> respective drivers know well about when to keep that memory in ram or
> swap based on may be a user activity.
>
> Q) Should we add the documentation section in Manual pages?
> A) The man[1] pages for the fadvise() whatever says is also applicable
> for shmem files. so couldn't feel it correct to add specific to shmem
> files separately.
>
> Q) The proposed semantics of POSIX_FADV_DONTNEED is actually similar to
> MADV_PAGEOUT and different from MADV_DONTNEED. This is a user facing API
> and this difference will cause confusion?
> A) man pages [2] says that "POSIX_FADV_DONTNEED attempts to free cached
> pages associated with the specified region." This means on issuing this
> FADV, it is expected to free the file cache pages. And it is
> implementation defined If the dirty pages may be attempted to writeback.
> And the unwritten dirty pages will not be freed. So, FADV_DONTNEED also
> covers the semantics of MADV_PAGEOUT for file pages and there is no
> purpose of PAGEOUT for file pages.
>
> [1] https://linux.die.net/man/2/fadvise
> [2] https://man7.org/linux/man-pages/man2/posix_fadvise.2.html
> [3] https://git.codelinaro.org/clo/la/platform/vendor/qcom/opensource/graphics-kernel/-/blob/gfx-kernel.lnx.1.0.r3-rel/kgsl_reclaim.c#L289
> [4] https://android.googlesource.com/kernel/common/+/refs/heads/android12-5.10/mm/shmem.c#4310
>
> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> ---
>  mm/shmem.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0005ab2..58aa3d7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -39,6 +39,9 @@
>  #include <linux/fs_parser.h>
>  #include <linux/swapfile.h>
>  #include <linux/iversion.h>
> +#include <linux/mm_inline.h>
> +#include <linux/fadvise.h>
> +#include <linux/page_idle.h>
>  #include "swap.h"
>
>  static struct vfsmount *shm_mnt;
> @@ -2327,6 +2330,117 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
>  #define shmem_initxattrs NULL
>  #endif
>
> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
> +                               loff_t end, struct list_head *list)
> +{
> +       XA_STATE(xas, &mapping->i_pages, start);
> +       struct folio *folio;
> +
> +       rcu_read_lock();
> +       xas_for_each(&xas, folio, end) {
> +               if (xas_retry(&xas, folio))
> +                       continue;
> +               if (xa_is_value(folio))
> +                       continue;
> +
> +               if (!folio_try_get(folio))
> +                       continue;
> +               if (folio_test_unevictable(folio) || folio_mapped(folio) ||
> +                               folio_isolate_lru(folio)) {
> +                       folio_put(folio);
> +                       continue;
> +               }
> +               folio_put(folio);
> +
> +               /*
> +                * Prepare the page to be passed to the reclaim_pages().
> +                * VM couldn't reclaim the page unless we clear PG_young.

nit: Since you operate on folios now, should you update this comment as well?

> +                */
> +               folio_clear_referenced(folio);
> +               folio_test_clear_young(folio);
> +               list_add(&folio->lru, list);
> +               if (need_resched()) {
> +                       xas_pause(&xas);
> +                       cond_resched_rcu();
> +               }
> +       }
> +       rcu_read_unlock();
> +}
> +
> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> +                               loff_t end)
> +{
> +       LIST_HEAD(folio_list);
> +
> +       if (!total_swap_pages)
> +               return 0;
> +
> +       lru_add_drain();
> +       shmem_isolate_pages_range(mapping, start, end, &folio_list);
> +       reclaim_pages(&folio_list);
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +                                pgoff_t start, pgoff_t long end)
> +{
> +       struct page *page;
> +       pgoff_t index;
> +
> +       xa_for_each_range(&mapping->i_pages, index, page, start, end) {
> +               if (!xa_is_value(page))
> +                       continue;
> +               page = shmem_read_mapping_page(mapping, index);
> +               if (!IS_ERR(page))
> +                       put_page(page);
> +       }
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +       loff_t endbyte;
> +       pgoff_t start_index;
> +       pgoff_t end_index;
> +       struct address_space *mapping;
> +       struct inode *inode = file_inode(file);
> +       int ret = 0;
> +
> +       if (S_ISFIFO(inode->i_mode))
> +               return -ESPIPE;
> +
> +       mapping = file->f_mapping;
> +       if (!mapping || len < 0 || !shmem_mapping(mapping))
> +               return -EINVAL;
> +
> +       endbyte = fadvise_calc_endbyte(offset, len);
> +
> +       start_index = offset >> PAGE_SHIFT;
> +       end_index   = endbyte >> PAGE_SHIFT;
> +       switch (advice) {
> +       case POSIX_FADV_DONTNEED:

Should (SHMEM_I(inode)->flags & VM_LOCKED) be checked here too?

> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_WILLNEED:
> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_NORMAL:
> +       case POSIX_FADV_RANDOM:
> +       case POSIX_FADV_SEQUENTIAL:
> +       case POSIX_FADV_NOREUSE:
> +               /*
> +                * No bad return value, but ignore advice.
> +                */
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
>                                      umode_t mode, dev_t dev, unsigned long flags)
>  {
> @@ -3933,6 +4047,7 @@ static const struct file_operations shmem_file_operations = {
>         .splice_write   = iter_file_splice_write,
>         .fallocate      = shmem_fallocate,
>  #endif
> +       .fadvise        = shmem_fadvise,
>  };
>
>  static const struct inode_operations shmem_inode_operations = {
> --
> 2.7.4
>
