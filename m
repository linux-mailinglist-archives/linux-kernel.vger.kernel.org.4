Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845DC6F1828
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346013AbjD1Mkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1Mkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:40:33 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24C319AD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:40:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f09b4a156eso66835085e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682685630; x=1685277630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iaouctOWZBOsKFA2vqArt/NLD4fDZB6ir2IWOV4YLBs=;
        b=Q3NHV1/dhHD6vIVZyRd0jJ00SQFLKwAQxGc5846tQx4++tcsE79l1LxDprLXH8zIlV
         m62Ewpm9KbLPFkG+pNSNLDfpsSuier0Sct68hBu03tMQajcaM/rXlirc9NM+QlcdsN6J
         kz6UAFUZWCMMLTVVZmXdwzAieLMuUWErRkT2uRYRTpJfAU+YZYr4KMTEV6l9341sB10q
         pLcDDtrCFit8PDjv4vSAc+0hWBQ/xeZD5j/xSOp/ML/PIe6wpvumqesSs7EaxazGNPaZ
         qdb9okUxzwHlZrkE5rQyN92GLP1MdzFTiKzjo5GG3TtqN2Fsy4qNaySdnQcvDTIQC3wK
         yFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682685630; x=1685277630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaouctOWZBOsKFA2vqArt/NLD4fDZB6ir2IWOV4YLBs=;
        b=Kda/e/UY9rO7cA/hzUylnxlaLAOHBJ1+Jwt/reMYhPgC32WagORGfci7KsW7n7b+6r
         mQdyYM9C+3XCs7ibUr5e1IV89KRxRwzO2Lsw+OXlvyz7pv2iB/v2NE85zCONYEwqxnMw
         cVhYwQztBnvvvgG+Ms5IXdVl6PTKsOceK96mdpjB8zVLXskEfQ+UL+a6FZj1Gap3aGKF
         OxATElKfHkfblc0hmW0MQ34QkiQVIUin/CdOdEl3zWGQqrdt7Lm4MlcVxN2i13LJEZuh
         l4ij1PEhsDPVP+Ye+rQ47rQz2b4ujYE8wFslrsJmSVjYkUmzxVfpdgrh/XPK2FtOWOvz
         91Ag==
X-Gm-Message-State: AC+VfDzqkiW/4lg2CwituIwYKXJa7kWYVSTHtcKOd4LWP9EJIBTQziAr
        4qXWL7RjjgxLg+EK0mPuNF6/+Q==
X-Google-Smtp-Source: ACHHUZ5FmuCTkr22XOwD5Tj0SaZURbIqao0sH/3Yu6cxhKOiGkjH32HPfuGFfPr1N5luTAUHxR0eYg==
X-Received: by 2002:a05:600c:acf:b0:3ed:4b0f:5378 with SMTP id c15-20020a05600c0acf00b003ed4b0f5378mr4320880wmr.27.1682685630183;
        Fri, 28 Apr 2023 05:40:30 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id q17-20020a1cf311000000b003eeb1d6a470sm24200166wmq.13.2023.04.28.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:40:29 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:40:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 2/2] riscv: Implement missing huge_ptep_get
Message-ID: <t7beh3jeodkkltiurnhvk4jkjhmhkbfvfxlzi7x5p6m3mkgreq@oblek3mii7zf>
References: <20230428120120.21620-1-alexghiti@rivosinc.com>
 <20230428120120.21620-2-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428120120.21620-2-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:01:20PM +0200, Alexandre Ghiti wrote:
> huge_ptep_get must be reimplemented in order to go through all the PTEs
> of a NAPOT region: this is needed because the HW can update the A/D bits
> of any of the PTE that constitutes the NAPOT region.
> 
> Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/hugetlb.h |  3 +++
>  arch/riscv/mm/hugetlbpage.c      | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
> index fe6f23006641..ce1ebda1a49a 100644
> --- a/arch/riscv/include/asm/hugetlb.h
> +++ b/arch/riscv/include/asm/hugetlb.h
> @@ -36,6 +36,9 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
>  			       unsigned long addr, pte_t *ptep,
>  			       pte_t pte, int dirty);
>  
> +#define __HAVE_ARCH_HUGE_PTEP_GET
> +pte_t huge_ptep_get(pte_t *ptep);
> +
>  pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
>  #define arch_make_huge_pte arch_make_huge_pte
>  
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index 238d00bdac14..e0ef56dc57b9 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -3,6 +3,30 @@
>  #include <linux/err.h>
>  
>  #ifdef CONFIG_RISCV_ISA_SVNAPOT
> +pte_t huge_ptep_get(pte_t *ptep)
> +{
> +	unsigned long pte_num;
> +	int i;
> +	pte_t orig_pte = ptep_get(ptep);
> +
> +	if (!pte_present(orig_pte) || !pte_napot(orig_pte))
> +		return orig_pte;
> +
> +	pte_num = napot_pte_num(napot_cont_order(orig_pte));
> +
> +	for (i = 0; i < pte_num; i++, ptep++) {
> +		pte_t pte = ptep_get(ptep);
> +
> +		if (pte_dirty(pte))
> +			orig_pte = pte_mkdirty(orig_pte);
> +
> +		if (pte_young(pte))
> +			orig_pte = pte_mkyoung(orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +
>  pte_t *huge_pte_alloc(struct mm_struct *mm,
>  		      struct vm_area_struct *vma,
>  		      unsigned long addr,
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
