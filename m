Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEE68B589
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBFGRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFGQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:16:58 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3B1284F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:16:57 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id bs10so5605632vkb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 22:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JDJ7E+5D8G1vnAtYw8jg+ixJnHSubCbLRbjmt87s7Sw=;
        b=qIIw2mZMMmjo/0FQtz+0yBU5o4G0HgzUkUNKjNDISa/pJ3pED7IhKbQ5d+/wdzzist
         hY5j6JvXdsUKSZaBV5fNXJXysXOmbI95HOSekuOf6vA+KrRzHDk3bRrh/9SDNLcH9cAw
         rYp+/iV6lXL1iK75nVcW/164zKTuR1aKE2VKo3iz5QB4Gz3SoQtS5I8YaSfk6sFEB9R+
         Ln49Ytzqa8HPUortdoOKRew0e2fGnfHC0rMosNTWujpqP3BNV6abkpo+QI5sC90Ff7ua
         ESnEpaRSa5wAaAnIc99E5NxOVKcpUB6CEzP7QZdcm7U/bdepRoqtCfpHxtTeLyovH2/F
         DSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JDJ7E+5D8G1vnAtYw8jg+ixJnHSubCbLRbjmt87s7Sw=;
        b=uQ7/xK8L8a8E0STlNMntJ6rfZBwkpkI3EniLKtfdzdRocAIkPRHQnVmQdnKsueQiQJ
         U1tX9ujX5WMeeL/iRJ0pHc0QzHrWCN0+HLR1AHWfJhrMNjaC6J/8JozLEN9vzAzlMMtl
         D2ZhkscmFCNX50Rn2PBz0M+ae8faPDX6x7LQpC4sQ+uI4NTPAxKC/To8f9O/nlbuuil/
         GHlvUlm1Kj+LrFI76/+DeYQLyegpve9i1fpuW3D/GNI19finIR07LRV/qUG6PRf5CKBy
         lqxOChqCkA1vabc8ru73MRtZqGE2slLqzFp16xGqA78Nu/APr9VAG4SAwrg8KWKHqStA
         6btQ==
X-Gm-Message-State: AO0yUKU4AKdJW+4z+708KidZC74OIi7FvxZ2kJBO7mPlZzW1gmUuUPxv
        UJEFuuJXGJSnNt2j8HMqASwxwvMUXnu5ug9dzx50vg==
X-Google-Smtp-Source: AK7set/39asDmEDee/lAJrh20mhQCcOYI9j6u+CMzu5miOYPEEMIB+bkubutTVEsRHA9kwmgKX17qG/E/QngQK96HWA=
X-Received: by 2002:a05:6122:216b:b0:3ea:78fc:6dce with SMTP id
 j11-20020a056122216b00b003ea78fc6dcemr2643281vkr.0.1675664216181; Sun, 05 Feb
 2023 22:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20230203-get_kernel_pages-v2-0-f1dc4af273f1@intel.com> <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
In-Reply-To: <20230203-get_kernel_pages-v2-2-f1dc4af273f1@intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Feb 2023 11:46:45 +0530
Message-ID: <CAFA6WYMoVHWvzSBeR9xTayqqCXqRqsvMZS7WW0rCXX_VsOVWoA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] tee: Remove vmalloc page support
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
> Remove the vmalloc page support from shm_get_kernel_pages().  Replace
> with a warn on once.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/tee/tee_shm.c | 36 ++++++++++++------------------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 27295bda3e0b..527a6eabc03e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -24,37 +24,25 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> +       struct kvec *kiov;
>         size_t n;
>         int rc;
>
> -       if (is_vmalloc_addr((void *)start)) {
> -               struct page *page;
> -
> -               for (n = 0; n < page_count; n++) {
> -                       page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
> -                       if (!page)
> -                               return -ENOMEM;
> -
> -                       get_page(page);
> -                       pages[n] = page;
> -               }
> -               rc = page_count;
> -       } else {
> -               struct kvec *kiov;
> -
> -               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -               if (!kiov)
> -                       return -ENOMEM;
> +       if (WARN_ON_ONCE(is_vmalloc_addr((void *)start)))
> +               return -EINVAL;
>
> -               for (n = 0; n < page_count; n++) {
> -                       kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -                       kiov[n].iov_len = PAGE_SIZE;
> -               }
> +       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +       if (!kiov)
> +               return -ENOMEM;
>
> -               rc = get_kernel_pages(kiov, page_count, 0, pages);
> -               kfree(kiov);
> +       for (n = 0; n < page_count; n++) {
> +               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> +               kiov[n].iov_len = PAGE_SIZE;
>         }
>
> +       rc = get_kernel_pages(kiov, page_count, 0, pages);
> +       kfree(kiov);
> +
>         return rc;
>  }
>
>
> --
> 2.39.1
