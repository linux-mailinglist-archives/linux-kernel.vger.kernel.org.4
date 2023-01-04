Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCCB65D0B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjADKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbjADKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:32:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E9B1C93A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874E5616A0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C8C433D2;
        Wed,  4 Jan 2023 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672828353;
        bh=GkTdvslnrFVBa2cyBAB43WHO7wxBxOn/8ycIzVEF8Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WF1R2MPVg4cO38YS1OVSyYHzd705Ua+IW7gNEIeuwmpvMSRzWc+Md3ZjIRrjlxPGQ
         dhCXaOT21pgMz/Lmx9+LlB+T7XAI6QCPLImfFO/RgQU+CVnqRvyv8Svfc32cfCKm8l
         rIHPpibjJBtK9UtBhYNXd9X74L8r7csGZd1DXOYK9xFQILQO0dIKbpxrbl+by3m0xf
         X9y8bfFIyQDUY0purZazeuVj9UMNfQFKiU/ugk6jEubWF2O3q/TN6CllewABPh8hOi
         3rXS5nVFNNbVPl0TWrnXkGgE6YxOxiT1bFnLKhuS5TvETHMlTZllzuw2+YOgyjhNUx
         SD4byWRxwrNBw==
Date:   Wed, 4 Jan 2023 12:32:19 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memblock: Fix doc for memblock_phys_free
Message-ID: <Y7VVs//O0OE3Eebv@kernel.org>
References: <20221216100304.688209-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216100304.688209-1-linmq006@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 02:03:03PM +0400, Miaoqian Lin wrote:
> memblock_phys_free() is the counterpart to memblock_phys_alloc.
> Change memblock_alloc_xx() with memblock_phys_alloc_xx() to keep
> a consistency.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 511d4783dcf1..d036c7861310 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -836,7 +836,7 @@ void __init_memblock memblock_free(void *ptr, size_t size)
>   * @base: phys starting address of the  boot memory block
>   * @size: size of the boot memory block in bytes
>   *
> - * Free boot memory block previously allocated by memblock_alloc_xx() API.
> + * Free boot memory block previously allocated by memblock_phys_alloc_xx() API.
>   * The freeing memory will not be released to the buddy allocator.
>   */
>  int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
> -- 
> 2.25.1

Applied, thanks! 

-- 
Sincerely yours,
Mike.
