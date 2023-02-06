Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AF268B58B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjBFGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:17:19 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED31014EB7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:17:18 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id a24so11612113vsl.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 22:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+xiDdTXHz9kIw5NyDNxaV9yiFmJDYKUg0WvCnptXTRs=;
        b=nLyqU/ylxVYAnUf1Vo8aIMOpW9ExvPm8ofwBiIWCzOvtnKdtDAPg4P7rggeEiTFkoX
         hSyeeM04zvkrX2x0fGp3hFnVVjeU2YE0nYv6yaSMtHAKyObnjqoR7IINadZ6zvMGLn2B
         mxPkB918/T7FKCm6ZPV7GI2CJM1TPnCKP/v16iWw73B+tq/+kvNj/3wi1wCnUh+oIVD/
         61FrPqItSs/IWJJLKWNcERkGvR5hNTD6Vj0Yd2pHLa/7tQYd8gBmiYhDctEddZqBUTzz
         MGw5H9tz90jLwltcLdc0HNcNIZIMtP7SDTsdE7oNZzETGW851TLUuRQ478V2JR4ksSoE
         Iqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xiDdTXHz9kIw5NyDNxaV9yiFmJDYKUg0WvCnptXTRs=;
        b=ftRrW73ypWBs18XtfPizQXNmo8z2eYSQa4zp/EOHSPUygcME6VnnOdCuaagrtEgkib
         qB881jhqG1Epgyr7hmnWolPwPn1oRRdvNgFjGxhWmqq8GFar2aEdvxlzgKva4D+MALM7
         RoO0RWuEjcwXAUq58B5Vb/z7gducPQ/wqBH9YU40eVHMNwkhi/pEd4sgdEDbjMQFXb5l
         MknnmoIMo1T14fsurAQV8zFrMGXeXV4kXlEPgPwvcCJlCF48F+66zVrFeWP3Zl+Hg1OA
         fWn8kE0aWND4+fq9c75Ky1LMHH4ygwP7IK9QY9ufRAPUkaLwh7bi+fncalkKlK8Amtp3
         MVhg==
X-Gm-Message-State: AO0yUKU974BeI/zTZbjQEp8kbu54qt34NxZyTlrv/p+GLSITSeDZGyqE
        UNvj4gpH1xIC11aE7ZW+rXNgC8DR0cbcM//MfibUtg==
X-Google-Smtp-Source: AK7set8XMWe0KVmVR29XsCEVIh/R7FQFNTjo1vzmArB0lCeKTRvncByylG3QSkXNpTQc8KyXg0qXmPpbFmn5IjdNNF8=
X-Received: by 2002:a67:ebc1:0:b0:3d0:d172:3a02 with SMTP id
 y1-20020a67ebc1000000b003d0d1723a02mr2755109vso.41.1675664238071; Sun, 05 Feb
 2023 22:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com> <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-3-f1dc4af273f1@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 11:47:07 +0530
Message-ID: <CAFA6WYPKpk=YmHdt1RKUKroji0ky457snsfndCjbqm=_kQw+7A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] tee: Remove call to get_kernel_pages()
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-mm@kvack.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
> The kernel pages used by shm_get_kernel_pages() are allocated using
> GFP_KERNEL through the following call stack:
>
> trusted_instantiate()
>         trusted_payload_alloc() -> GFP_KERNEL
>         <trusted key op>
>                 tee_shm_register_kernel_buf()
>                         register_shm_helper()
>                                 shm_get_kernel_pages()
>
> Where <trusted key op> is one of:
>
>         trusted_key_unseal()
>         trusted_key_get_random()
>         trusted_key_seal()
>
> Because the pages can't be from highmem get_kernel_pages() boils down to
> a get_page() call.
>
> Remove the get_kernel_pages() call and open code the get_page().
>
> In case a highmem page does slip through warn on once for a kmap'ed
> address.
>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes from v1:
>         Al/Christoph: Remove kiov altogether
> ---
>  drivers/tee/tee_shm.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 527a6eabc03e..b1c6231defad 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -11,6 +11,7 @@
>  #include <linux/tee_drv.h>
>  #include <linux/uaccess.h>
>  #include <linux/uio.h>
> +#include <linux/highmem.h>
>  #include "tee_private.h"
>
>  static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> @@ -24,26 +25,20 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;
> +       struct page *page;
>         size_t n;
> -       int rc;
>
> -       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start) ||
> +                        is_kmap_addr((void *)start)))
>                 return -EINVAL;
>
> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -       if (!kiov)
> -               return -ENOMEM;
> -
> +       page = virt_to_page(start);
>         for (n = 0; n < page_count; n++) {
> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -               kiov[n].iov_len = PAGE_SIZE;
> +               pages[n] = page + n;
> +               get_page(pages[n]);
>         }
>
> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
> -
> -       return rc;
> +       return page_count;
>  }
>
>  static void release_registered_pages(struct tee_shm *shm)
>
> --
> 2.39.1
