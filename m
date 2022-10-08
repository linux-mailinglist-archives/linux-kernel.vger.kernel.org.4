Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116375F8322
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 07:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJHF0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 01:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiJHF0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:26:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C98489823
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 22:26:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r8-20020a1c4408000000b003c47d5fd475so396883wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 22:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PW6BygRIZdIPThWq8HGuaZv9/pJut4DcDnHQ9i39hOE=;
        b=Til3juUEVTsPMC3Y9k87Ip8krET6/ZDmxKC9sOIVA1gCimNg4uLZhc9kqh2OgcDnNR
         +2ln76EmHgOlAapvn/qA/VD4UeKcat0pt0UqqNPI/WVajt5jw/lVqCkFlZwp1uUmWs2P
         SIwWgSU1UDy6qwdWcaxhcFscmJV+VLCpHg7Xu+CW6QzmQsEAomE45h0XVug4oc2j1Z2l
         j3pulMosNtNxsFiPGGWhYdyUjLwvnoCrFr/6e4Y8Tw+VG0+wTDQ7BoF7xsZ2UQ66tAJa
         E4W5iEeHBtVxD49RzZrs078qSaTqPf5QUW4NR1A4QxJn1tyxn6TkMVcu9P+h5u3EOTB5
         LzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PW6BygRIZdIPThWq8HGuaZv9/pJut4DcDnHQ9i39hOE=;
        b=elsEgxglRomqFCD+A1nuBAEt2UaVa6V1wWHT5dd/bqq0ny5QFQifZNnP8aLqBGOPQ4
         eOtnczWidnRDY4MZbCTisNwjf6OLlImtz2ga2R8qXZdq6RYMBZg43ntF7X+1tUBWjEfb
         dylYy43rXpSMw4ICZjcDo91hwRdSn/Xlp1cCAT4/FyCABnIT9diZuxtdYoPqXzM0ryuc
         qJPv6QotMjJ9ALpzKBVw34isC+aUbkJZlpn50CwdUhZAfCrHGL4sw5R7+ZirQ79qRW8Q
         amDKTVuFmvJTkR9WS0Do9mt8Mz89xPgYUgtJoACqO0xz486lkft1/fuYTUSZGSUcCVxG
         bjdQ==
X-Gm-Message-State: ACrzQf2O2NOyL7BFBna/8ssKomdyQtesVXSDFX3FPoApWAFdlKi2e3yi
        icwX8OjBiJyb5JduN1lHeZAK5rFRbho=
X-Google-Smtp-Source: AMsMyM6ggLd+qaTpzqW5qlHpjm9XNolDRSbLdTK8ZdNBv5j7GwwEsWEAn90R33LA1bNEdAnyGQtgmA==
X-Received: by 2002:a7b:cc96:0:b0:3b4:ffb5:6366 with SMTP id p22-20020a7bcc96000000b003b4ffb56366mr5284736wma.48.1665206810201;
        Fri, 07 Oct 2022 22:26:50 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id j11-20020a5d448b000000b0022efc4322a9sm2343815wrq.10.2022.10.07.22.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 22:26:49 -0700 (PDT)
Date:   Sat, 8 Oct 2022 05:26:49 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     openrisc@lists.librecores.org, Jann Horn <jannh@google.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] openrisc: Fix pagewalk usage in arch_dma_{clear,
 set}_uncached
Message-ID: <Y0EKGV38rvbbXZF6@oscomms1>
References: <20221008052422.29695-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008052422.29695-1-shorne@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, meant to tag this as v2. But I missed the command line option as I am on
a new system and was working on getting aliases and other things setup to send
this mail.

-Stafford

On Sat, Oct 08, 2022 at 06:24:21AM +0100, Stafford Horne wrote:
> From: Jann Horn <jannh@google.com>
> 
> Since commit 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page
> walker"), walk_page_range() on kernel ranges won't work anymore,
> walk_page_range_novma() must be used instead.
> 
> Note: I don't have an openrisc development setup, so this is completely
> untested.
> 
> Fixes: 8782fb61cc848 ("mm: pagewalk: Fix race between unmap and page walker")
> Signed-off-by: Jann Horn <jannh@google.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
> Since v1:
>  - Repost to include LKML.
>  - Added my SOB
>  - I tested this by booking this on the qemu virt platform and it works fine.
> 
>  arch/openrisc/kernel/dma.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/dma.c b/arch/openrisc/kernel/dma.c
> index a82b2caaa560..b3edbb33b621 100644
> --- a/arch/openrisc/kernel/dma.c
> +++ b/arch/openrisc/kernel/dma.c
> @@ -74,10 +74,10 @@ void *arch_dma_set_uncached(void *cpu_addr, size_t size)
>  	 * We need to iterate through the pages, clearing the dcache for
>  	 * them and setting the cache-inhibit bit.
>  	 */
> -	mmap_read_lock(&init_mm);
> -	error = walk_page_range(&init_mm, va, va + size, &set_nocache_walk_ops,
> -			NULL);
> -	mmap_read_unlock(&init_mm);
> +	mmap_write_lock(&init_mm);
> +	error = walk_page_range_novma(&init_mm, va, va + size,
> +			&set_nocache_walk_ops, NULL, NULL);
> +	mmap_write_unlock(&init_mm);
>  
>  	if (error)
>  		return ERR_PTR(error);
> @@ -88,11 +88,11 @@ void arch_dma_clear_uncached(void *cpu_addr, size_t size)
>  {
>  	unsigned long va = (unsigned long)cpu_addr;
>  
> -	mmap_read_lock(&init_mm);
> +	mmap_write_lock(&init_mm);
>  	/* walk_page_range shouldn't be able to fail here */
> -	WARN_ON(walk_page_range(&init_mm, va, va + size,
> -			&clear_nocache_walk_ops, NULL));
> -	mmap_read_unlock(&init_mm);
> +	WARN_ON(walk_page_range_novma(&init_mm, va, va + size,
> +			&clear_nocache_walk_ops, NULL, NULL));
> +	mmap_write_unlock(&init_mm);
>  }
>  
>  void arch_sync_dma_for_device(phys_addr_t addr, size_t size,
> -- 
> 2.37.2
> 
