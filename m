Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5E6C72B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCWWBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCWWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:01:16 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87818ABC;
        Thu, 23 Mar 2023 15:01:14 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t15so22045716wrz.7;
        Thu, 23 Mar 2023 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679608873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqzUJsrIXiTLpizNGikfWg7eLgCDOytK955gGY1JKdU=;
        b=MtsS9dXCPwpbHTXScU03nwi2uCeBqtuV861ZsHWLUi4P287ZgJ2eRK2qph+XuQ7ZGw
         cJ4qcqstjMsCOrwnWXtyjUrhF8iPqFpGlFsuq400KA+l2+ZbBgV0a/bSXZ8bJoNHFtgB
         KkQ3RSf0KrmEQYCCp12Hwn3ipVEUDdrz8/MucGy9mYRm49mVNvsz4YAF7u0gja+tSWQ4
         E+95GBBuWOmJzeIg1mJ871RJbBez7rm9muvz0VDuis4Ywc5tO0O0xiLd0pz/JsEI/lbj
         BYm9K3FVHzFoO7ZTNEmRzTJHCoD/EfsBqKfdq21obDhaduZC9VjvtniI5YXCImXo8Bzy
         RA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679608873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqzUJsrIXiTLpizNGikfWg7eLgCDOytK955gGY1JKdU=;
        b=Gw/nmspGd1cW1dGwwC4Jgxr3oXZAtKF7lBFPhQaSKsMbeXDaVppPKeRr70Y5X+HbQk
         Cvu2gRC/KQY1b/1BzVIqe6pRCUrDkc/E47pDpjU/QypXN0rn/rBShxuCASL4g9snqekY
         EwyJyTASqQY6J3c+5LLVeuAq161Ru6R1rsuI7OvdvyLBJr3XskWfzEttUSZY3K2EUx4N
         2xOZEfmV1ejfK5ntrfseKM4kfeyArTs8vj+PYb8QgO7UdZBW0lZ8gYOmN7vUFgH/EWmh
         cPkA/NC4sXAv2yHBuBV/PGQWud2DGqWpMH22SypZi+F1g45A9hvrAte0pmCHqjz6MIMD
         f3bQ==
X-Gm-Message-State: AAQBX9cLLQmQJ0UxKve6bMTs34R/RbrtGNTEMOUasLS2pXDxz/KEHSnN
        PUH7kT5d/yJ7FwUq/d8yIPByh/UkJFg=
X-Google-Smtp-Source: AKy350ZjZeexV9C1kqEBi0ePu5nbBoMphGTFCJnNosf96qBrdHhnR0OBtQaTAx0UnX8fsDcF2coymw==
X-Received: by 2002:adf:dbc5:0:b0:2d7:998c:5ad9 with SMTP id e5-20020adfdbc5000000b002d7998c5ad9mr450159wrj.8.1679608872474;
        Thu, 23 Mar 2023 15:01:12 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002cfe685bfd6sm17045576wrw.108.2023.03.23.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 15:01:11 -0700 (PDT)
Date:   Thu, 23 Mar 2023 22:01:11 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, akpm@linux-foundation.org,
        sfr@canb.auug.org.au
Subject: Re: + mm-vmalloc-convert-vread-to-vread_iter-v8.patch added to
 mm-unstable branch
Message-ID: <e19a8c9e-d282-4ea7-a797-44eef7f62524@lucifer.local>
References: <20230323215510.C74D5C433D2@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323215510.C74D5C433D2@smtp.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 02:55:10PM -0700, Andrew Morton wrote:
>
> The patch titled
>      Subject: mm-vmalloc-convert-vread-to-vread_iter-v8
> has been added to the -mm mm-unstable branch.  Its filename is
>      mm-vmalloc-convert-vread-to-vread_iter-v8.patch
>
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-vmalloc-convert-vread-to-vread_iter-v8.patch
>
> This patch will later appear in the mm-unstable branch at
>     git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
>
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
>
> *** Remember to use Documentation/process/submit-checklist.rst when testing your code ***
>
> The -mm tree is included into linux-next via the mm-everything
> branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> and is updated there every 2-3 working days
>
> ------------------------------------------------------
> From: Lorenzo Stoakes <lstoakes@gmail.com>
> Subject: mm-vmalloc-convert-vread-to-vread_iter-v8
> Date: Thu, 23 Mar 2023 10:15:19 +0000
>
> make zero_iter() static, move uio.h inclusion to vmalloc.h
>
> Link: https://lkml.kernel.org/r/8506cbc667c39205e65a323f750ff9c11a463798.1679566220.git.lstoakes@gmail.com
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/vmalloc.h |    2 +-
>  mm/vmalloc.c            |    3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> --- a/include/linux/vmalloc.h~mm-vmalloc-convert-vread-to-vread_iter-v8
> +++ a/include/linux/vmalloc.h
> @@ -9,12 +9,12 @@
>  #include <asm/page.h>		/* pgprot_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
> +#include <linux/uio.h>
>
>  #include <asm/vmalloc.h>
>
>  struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
>  struct notifier_block;		/* in notifier.h */
> -struct iov_iter;		/* in uio.h */
>
>  /* bits in flags of vmalloc's vm_struct below */
>  #define VM_IOREMAP		0x00000001	/* ioremap() and friends */
> --- a/mm/vmalloc.c~mm-vmalloc-convert-vread-to-vread_iter-v8
> +++ a/mm/vmalloc.c
> @@ -33,7 +33,6 @@
>  #include <linux/compiler.h>
>  #include <linux/memcontrol.h>
>  #include <linux/llist.h>
> -#include <linux/uio.h>

The above changes accidentally undoes the fix for sparc64 that Stephen
Rothwell provided (I have incorporated that in my local repo so if there
are any future respins they will include it going forward).

Could we revert the above but keep the static declaration change below?
Thanks!

>  #include <linux/bitops.h>
>  #include <linux/rbtree_augmented.h>
>  #include <linux/overflow.h>
> @@ -3446,7 +3445,7 @@ EXPORT_SYMBOL(vmalloc_32_user);
>   *
>   * Returns the number of zeroed bytes.
>   */
> -size_t zero_iter(struct iov_iter *iter, size_t count)
> +static size_t zero_iter(struct iov_iter *iter, size_t count)
>  {
>  	size_t remains = count;
>
> _
>
> Patches currently in -mm which might be from lstoakes@gmail.com are
>
> mm-prefer-xxx_page-alloc-free-functions-for-order-0-pages.patch
> mm-refactor-do_fault_around.patch
> mm-pefer-fault_around_pages-to-fault_around_bytes.patch
> maintainers-add-myself-as-vmalloc-reviewer.patch
> mm-remove-unused-vmf_insert_mixed_prot.patch
> mm-remove-vmf_insert_pfn_xxx_prot-for-huge-page-table-entries.patch
> drm-ttm-remove-comment-referencing-now-removed-vmf_insert_mixed_prot.patch
> fs-proc-kcore-avoid-bounce-buffer-for-ktext-data.patch
> fs-proc-kcore-convert-read_kcore-to-read_kcore_iter.patch
> iov_iter-add-copy_page_to_iter_nofault.patch
> mm-vmalloc-convert-vread-to-vread_iter.patch
> mm-vmalloc-convert-vread-to-vread_iter-v8.patch
> mm-mmap-vma_merge-further-improve-prev-next-vma-naming.patch
> mm-mmap-vma_merge-fold-curr-next-assignment-logic.patch
> mm-mmap-vma_merge-explicitly-assign-res-vma-extend-invariants.patch
> mm-mmap-vma_merge-init-cleanup-be-explicit-about-the-non-mergeable-case.patch
>
