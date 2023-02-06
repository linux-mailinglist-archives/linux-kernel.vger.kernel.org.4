Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1767668B58C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFGRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:17:46 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DE91554E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:17:44 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k6so11599435vsk.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 22:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCbIkGsR/i9GGED+PeoqWkhVcXF5/sJXuBW46dRtiTs=;
        b=YXvWfgXKCu0uIwCXxm4jAs6wezXdu3WB35GxfZGQseVFFmjxXbqqWBRwVyTzgMvdDA
         zXXpU8oXGVXRRMVfcrCWFPzo9vsv/0QMPnSiTgTq2ArJMLq4WKeWLnrYbC4Ob8nVcNVM
         K7DYXQxxBwBqmaehbWrU2w8gISgvZGT/I67Fs/E2ok9YlPJqOSrjxdTJt7t7JNpORTuY
         z4uMQbZcFWqPwjqKpxPheb4zqqvwf3oBz1JVQSThPHPK5mH/8gu+5jUg6KSpCPoZxtWl
         9D05ZpVpG2yjgqZHW3Vbw6JFJFgVP8ejwQNiYvhelm3aVMD7VvOjIlfu7/Zq6aGCiZbV
         VIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCbIkGsR/i9GGED+PeoqWkhVcXF5/sJXuBW46dRtiTs=;
        b=7BmXAMSm11aPhjad61y3HqouWMlmA12lPgKuWwfomP0nUF1DVYHA9vuQe6dHJwkSUM
         T3wIEHBLKU4LS9h+cton5qgzGABrWI5jk71po6sVrc9ouTascfuW5ot2oJVIwJyBdmZM
         bYNzjgsAxDI+aK7gt0DEQ2thcbs0iCsdGZOxMM6Z2Rrs0TlrpbTLPB05VwFSCnaWSMjz
         JMn0nNLDs8joytG3cQIu85juX9OPz9leKoYzNbpx9sa57weFalgMu6A/i1MrlIC9CZHo
         m6QydQKTdKtDbCZYUjjsnoUBPO7JI4Fd5Gv+mTzjViLYAXdktwgwZV9AvtW/f6NEzvGo
         RPSA==
X-Gm-Message-State: AO0yUKW7bXT57o/imDL1pKALa6+3GGO1ttU3pIuLj4cie+8CvU4V41M3
        DVi3NhtwDYvTrMZFNUk3BshfJA/+uFujotaPKb2WEA==
X-Google-Smtp-Source: AK7set+QaKxOl5Eq1HyGyCzA9bpv05T31dNrk8Crvv6Cedn4iwLfdcd87Sby8mB58ngkwFbg0Pr/sraGEIL+mIdClek=
X-Received: by 2002:a67:c599:0:b0:3f9:6368:48b8 with SMTP id
 h25-20020a67c599000000b003f9636848b8mr2582845vsk.41.1675664263811; Sun, 05
 Feb 2023 22:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com> <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-4-f1dc4af273f1@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 11:47:32 +0530
Message-ID: <CAFA6WYMSF+GPdhx6oTDPmdBgam+GvCKJ5pcb3GFTDXe7W0yMEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] mm: Remove get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2023 at 09:36, Ira Weiny <ira.weiny@intel.com> wrote:
>
> The only caller to get_kernel_pages() [shm_get_kernel_pages()] has been
> updated to not need it.
>
> Remove get_kernel_pages().
>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/swap.c          | 30 ------------------------------
>  2 files changed, 32 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8f857163ac89..2041e6d4fa27 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2095,8 +2095,6 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
>                         struct task_struct *task, bool bypass_rlim);
>
>  struct kvec;
> -int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
> -                       struct page **pages);
>  struct page *get_dump_page(unsigned long addr);
>
>  bool folio_mark_dirty(struct folio *folio);
> diff --git a/mm/swap.c b/mm/swap.c
> index 70e2063ef43a..4c03ecab698e 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -158,36 +158,6 @@ void put_pages_list(struct list_head *pages)
>  }
>  EXPORT_SYMBOL(put_pages_list);
>
> -/*
> - * get_kernel_pages() - pin kernel pages in memory
> - * @kiov:      An array of struct kvec structures
> - * @nr_segs:   number of segments to pin
> - * @write:     pinning for read/write, currently ignored
> - * @pages:     array that receives pointers to the pages pinned.
> - *             Should be at least nr_segs long.
> - *
> - * Returns number of pages pinned. This may be fewer than the number requested.
> - * If nr_segs is 0 or negative, returns 0.  If no pages were pinned, returns 0.
> - * Each page returned must be released with a put_page() call when it is
> - * finished with.
> - */
> -int get_kernel_pages(const struct kvec *kiov, int nr_segs, int write,
> -               struct page **pages)
> -{
> -       int seg;
> -
> -       for (seg = 0; seg < nr_segs; seg++) {
> -               if (WARN_ON(kiov[seg].iov_len != PAGE_SIZE))
> -                       return seg;
> -
> -               pages[seg] = kmap_to_page(kiov[seg].iov_base);
> -               get_page(pages[seg]);
> -       }
> -
> -       return seg;
> -}
> -EXPORT_SYMBOL_GPL(get_kernel_pages);
> -
>  typedef void (*move_fn_t)(struct lruvec *lruvec, struct folio *folio);
>
>  static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)
>
> --
> 2.39.1
