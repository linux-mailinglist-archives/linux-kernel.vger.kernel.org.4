Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4576F1826
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345945AbjD1MkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjD1MkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:40:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24075199
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:40:11 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f1950f5628so85025115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1682685609; x=1685277609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=so9KIu8LhIXSS+RBaLCGXQCS3RVkKbWGe3Dy1K6fiZY=;
        b=o3eKynrvckfOC+ssqQyzYTN2KeT3Zzl/oOjDyJyACeNd8w5nkc2hcADb4Eua5+ukMC
         YCm6nu+j2wVj93GqWWrOFHZuLveZZW7SlFHHzz/07WSeAVjgmF0qqs5Kn0MuUONHIHYA
         +tS8mqgKXxPgzqa0unn3Ru0JPz+aWGz00siCESWtOmajQN6cYlyKxMfKF2vybgKnnoO0
         R3mxJjWdr3R4GfdLfbIyyh1WtmC/88rU8i3QOykJPl0KZJtbNzeJ+piw0Q6ntIUwk7BT
         Aj84oNnGTs9M3DKiF2MTrlYGUJr/Pb3fC+LZHhM2XZQNMGFuK/gSDbDIDeEtEbT4AYOW
         cjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682685609; x=1685277609;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=so9KIu8LhIXSS+RBaLCGXQCS3RVkKbWGe3Dy1K6fiZY=;
        b=X5Ocd1Dc7yS93r2rl7IpAy/5ujft8ytNyaWbjR5WW+rHcKVLEVz/lTJwqUgXf1lMN9
         PhctuaJ0GQAiJRM9KBcr12NkwMkX536coj6ieqNsbgjNvZNhAVGZfSqqqLjiN/Zq8jCc
         jqlNFv0OPYePIjrZAFJPQ+Edu8oN5FDB0SWHjJT9kCnHdFlFn6f9UGcC5bkl93g+7Spw
         VPkQLFuSn52MyeVE8JIDLmfH71NQbrvoby+S26KtRvFExXBy4pzX5bmvVcS9Ypux3hDd
         ZbLHFe65sylEOixW+xO1KgPGiPvTs2km6IFK3N998FjbuT6ZsG4nopvvPfE61H6Zsi8i
         eE4Q==
X-Gm-Message-State: AC+VfDxh+vvJ20xV0dq00P32Eud5vRof39CsRDu07yfN5xSCEGiqTXc9
        oWyWyEa1ECndMFnKl4ZdcOXhFA==
X-Google-Smtp-Source: ACHHUZ4oyJ+//cf4rNgEGKdKn3OlOaCIZYzyzPVMMmjxajbwFk646G1FPmc6yNlWg2VxJFCB+I8dVQ==
X-Received: by 2002:a05:600c:ad9:b0:3f1:7bac:d411 with SMTP id c25-20020a05600c0ad900b003f17bacd411mr4233018wmr.39.1682685609550;
        Fri, 28 Apr 2023 05:40:09 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm24069000wmk.20.2023.04.28.05.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 05:40:09 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:40:08 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -fixes 1/2] riscv: Fix huge_ptep_set_wrprotect when PTE
 is a NAPOT
Message-ID: <baf74szfva57nyqhjmikd6ll4pmz4bj2i7p2wgs2hwwfu5bhap@ixcccn4xf4n3>
References: <20230428120120.21620-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428120120.21620-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:01:19PM +0200, Alexandre Ghiti wrote:
> We need to avoid inconsistencies across the PTEs that form a NAPOT
> region, so when we write protect such a region, we should clear and flush
> all the PTEs to make sure that any of those PTEs is not cached which would
> result in such inconsistencies (arm64 does the same).
> 
> Fixes: f2aeb0118ddd ("riscv: mm: support Svnapot in hugetlb page")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/mm/hugetlbpage.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
> index a163a3e0f0d4..238d00bdac14 100644
> --- a/arch/riscv/mm/hugetlbpage.c
> +++ b/arch/riscv/mm/hugetlbpage.c
> @@ -218,6 +218,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  {
>  	pte_t pte = ptep_get(ptep);
>  	unsigned long order;
> +	pte_t orig_pte;
>  	int i, pte_num;
>  
>  	if (!pte_napot(pte)) {
> @@ -228,9 +229,12 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  	order = napot_cont_order(pte);
>  	pte_num = napot_pte_num(order);
>  	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
> +	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
> +
> +	orig_pte = pte_wrprotect(orig_pte);
>  
>  	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
> -		ptep_set_wrprotect(mm, addr, ptep);
> +		set_pte_at(mm, addr, ptep, orig_pte);
>  }
>  
>  pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> -- 
> 2.37.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
