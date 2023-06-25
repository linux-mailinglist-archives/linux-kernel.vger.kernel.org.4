Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAF73CE83
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 07:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFYFHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 01:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjFYFHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 01:07:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551251B8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 22:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92DC860B4E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 05:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61396C433C0;
        Sun, 25 Jun 2023 05:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687669619;
        bh=jgfLh/zY7xN5RodVgYjPskEVQYhgmP71qY5MPGxsWh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bTFqTJ6G5bd2FpBRgo01PSa6FuP3N5SK0C86xiYCFXS8MugG6OOCX+G8TGsxIte7+
         f11IzCxCz/0rTwOI5bXaRG75OetjK10m4VO5W6deEj2y9edDNO7jR/P9MeGJvarTSL
         32RGJodvo2KIA2J6XJiwUgWSaBcpUYEZzJgjK5x7ZRj6Xk8Znlw86nFS7TIs7XkG+F
         AQfpw4DM9ujYlJawh0RvSqiBwqj3N38HlEuFvbY1SsDNxCBZsB2AYyCyuQ3OhhlcUx
         UEoe3mr53NsBIALBjK8ne8MWNq+gDku6V8PCqSyi7OjsJ3ZgpBr/XaSyKRW61OTWJv
         cbw0lBCYqVBYg==
Date:   Sun, 25 Jun 2023 08:06:12 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mm_init.c: Update obsolete comment in
 get_pfn_range_for_nid()
Message-ID: <20230625050612.GH52412@kernel.org>
References: <20230625033340.1054103-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625033340.1054103-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 11:33:40AM +0800, Miaohe Lin wrote:
> Since commit 633c0666b5a5 ("Memoryless nodes: drop one memoryless node boot
> warning"), the warning for a node with no available memory is removed.
> Update the corresponding comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/mm_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 999723dee8cc..f90db54e2b21 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1681,8 +1681,7 @@ static inline void alloc_node_mem_map(struct pglist_data *pgdat) { }
>   *
>   * It returns the start and end page frame of a node based on information
>   * provided by memblock_set_node(). If called for a node
> - * with no available memory, a warning is printed and the start and end
> - * PFNs will be 0.
> + * with no available memory, the start and end PFNs will be 0.
>   */
>  void __init get_pfn_range_for_nid(unsigned int nid,
>  			unsigned long *start_pfn, unsigned long *end_pfn)
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
