Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A296B6F54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 06:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjCMF6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCMF6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 01:58:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3323133442
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 22:58:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z5so11402815ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678687117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r42O6Y5cB+VDeHMbarldOxJ8LK3WTSPXYQqJukkf3Co=;
        b=HULX4dIJAgeRdwtS5mfYykOMh13+Xqj/QT2rPJ1a+3ODMjiCUDWTKdK06fSvfPJ4HF
         4/F8JZBua8UMySt2uLzxP4tPjKwDsogQ9+4TVtXfAAqGg3xwNKVYq1aS65bTyZoWlTs2
         xevewOLFKBAQPf3mNOOvgSNr9LsqYI/ovCZGRTlJvqkHGD8RQDOlV/AVUT0pKVwrnt9g
         uC3Lx5G5wj+Ouv2NtmVmew0mymJar+LWESghOlxK7N4sjc0xRDufn+DbPpBvViDUCMAR
         uA+1IiQLPbIMxeXeFCE8jXiyC3e39cxSkDYsM3fLuTkHowWUwuml1F0DwpfnJnBa/Zr0
         AAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678687117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r42O6Y5cB+VDeHMbarldOxJ8LK3WTSPXYQqJukkf3Co=;
        b=Fchz8aAWXNA9d8GkDvJ/aDPvoX9KBhNVfbSCu/8GNjV1WgACHB5mPBtSCVYoTqsIM8
         urzz9TUcqldYzIO9bRg3G+zBXqrRkvGqfG2UuQiHFTaPI1U0l0/6vBSNrPQJAXkekjNA
         4sklxooSt7/yhzpWfe3iidAo+f4Jc6CBk1dVV9OvIhnhPID6GPrGV1JgLt7+S69sX+t9
         w8X8wxLU40i9COghZsO0v5nQ+zUV+Qn13kNCxZfkmZ0oNAna6hcTIvoUrzcxzeKpsGVs
         gzZes947P54cH3ZxCYOrLhikkz9Lzrq8+f2aa3xzfXGCRVftU6CZfQ4Kt94kfpWSZePO
         JSAg==
X-Gm-Message-State: AO0yUKX+XowMXNc9myBZIFE3voNL1uNFQwEHNVRvgWz+mRvIGJuFVgtp
        vRGbh7T1drPvqBDlE/7lekf3XcgY+ybb0Q==
X-Google-Smtp-Source: AK7set/VsUuMbBC5VMNZ+AreBezxbJCALlZZ3PkWVlsYj7vuYmyIll1BbItD6I0MhHQ5BEbf1diYTw==
X-Received: by 2002:a2e:8012:0:b0:294:899:afc3 with SMTP id j18-20020a2e8012000000b002940899afc3mr11764874ljg.35.1678687116950;
        Sun, 12 Mar 2023 22:58:36 -0700 (PDT)
Received: from curiosity ([5.188.167.245])
        by smtp.gmail.com with ESMTPSA id e17-20020a05651c039100b00293526a0c87sm888637ljp.41.2023.03.12.22.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 22:58:35 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:58:34 +0300
From:   Sergey Matyukevich <geomatsi@gmail.com>
To:     Dylan Jhong <dylan@andestech.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@kernel.org, sergey.matyukevich@syntacore.com,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, x5710999x@gmail.com,
        tim609@andestech.com, peterlin@andestech.com, ycliang@andestech.com
Subject: Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing
 TLB
Message-ID: <ZA67iqLoX9DUjGm/@curiosity>
References: <20230313034906.2401730-1-dylan@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313034906.2401730-1-dylan@andestech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> function. We should only take the ASID field to prevent from touching
> the reserved bit field.
> 
> Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> Signed-off-by: Dylan Jhong <dylan@andestech.com>
> ---
> Changes from v2:
> - Remove unsued EXPORT_SYMBOL()
> ---
>  arch/riscv/include/asm/tlbflush.h | 2 ++
>  arch/riscv/mm/context.c           | 2 +-
>  arch/riscv/mm/tlbflush.c          | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 907b9efd39a8..597d6d8aec28 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -12,6 +12,8 @@
>  #include <asm/errata_list.h>
>  
>  #ifdef CONFIG_MMU
> +extern unsigned long asid_mask;
> +
>  static inline void local_flush_tlb_all(void)
>  {
>  	__asm__ __volatile__ ("sfence.vma" : : : "memory");
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 80ce9caba8d2..6d1aeb063e81 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
>  
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
> -static unsigned long asid_mask;
> +unsigned long asid_mask;
>  
>  static atomic_long_t current_version;
>  
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index ce7dfc81bb3f..ba4c27187c95 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>  	/* check if the tlbflush needs to be sent to other CPUs */
>  	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>  	if (static_branch_unlikely(&use_asid_allocator)) {
> -		unsigned long asid = atomic_long_read(&mm->context.id);
> +		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
>  
>  		/*
>  		 * TLB will be immediately flushed on harts concurrently

Reviewed-by: Sergey Matyukevich <sergey.matyukevich@syntacore.com>

Thanks !
