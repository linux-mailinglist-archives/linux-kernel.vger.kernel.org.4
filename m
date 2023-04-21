Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C096EA7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjDUJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDUJ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:59:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E658DAF0B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:59:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9136821A01;
        Fri, 21 Apr 2023 09:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682071180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkJAfV1NB5q3HpwhV7gnZ+rdb2IyYfHSUMa0JX1MvDw=;
        b=kqLJX7mmuTIdbIELDsdxpOrnAFIKwbx+kIDUrLz2m8OgvPmT+hKCqNs4N2BH/OQX7iXMaw
        ewBUsF0QzudVm3fV7Hbn65yT6yTQjQcWFWK64jlScM/dYvFo6aYl0KHrH4NWKlLzEtdQPZ
        UlYBeVVgN6Y4Er0kwPrkYOYkd6/mjuk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682071180;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WkJAfV1NB5q3HpwhV7gnZ+rdb2IyYfHSUMa0JX1MvDw=;
        b=p3F97fUteP+W0gcVLYstYpjAyVraBCVWB/ARMdC7pb1r+X0i58omRmC9FesskbHrAxnn3R
        iPEqdb3u8l0xyaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72D5B13456;
        Fri, 21 Apr 2023 09:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id peRMG4xeQmQXXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 21 Apr 2023 09:59:40 +0000
Message-ID: <0ddb50f0-2e2d-e750-3867-3842a3ea12cc@suse.cz>
Date:   Fri, 21 Apr 2023 11:59:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH linux-next v2] mm: workingset: update description of the
 source file
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iamjoonsoo.kim@lge.com, Mike Rapoport <rppt@kernel.org>
References: <202304131634494948454@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <202304131634494948454@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 10:34, yang.yang29@zte.com.cn wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> The calculation of workingset size is the core logic of handling refault,
> it had been updated several times[1][2] after workingset.c was created[3].
> But the description hadn't been updated accordingly, this mismatch may
> confuse the readers.
> So we update the description to make it consistent to the code. 
> 
> [1] commit 34e58cac6d8f ("mm: workingset: let cache workingset challenge anon")
> [2] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
> [3] commit a528910e12ec ("mm: thrash detection-based file cache sizing")
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

I'm late but FWIW, not supper happy that while the updated calculations are
now accurate wrt the actual code, the explanation (which was written at the
time of page cache-only workinset) was more easier to follow in the simpler
form. Now it's still mostly talking about page cache and explaining the
balance between its active and inactive list only, and then suddenly the
anon lists appear out of nowhere in the final equations.

In other words, I think it would have been better to leave that explanation
as it was, and then add a new part describing the extension to anon pages.

But nevermind, not a reason to yank/revert the change from mm-stable, but I
should be eventually getting back to this and maybe move this to mm docs
while doing what I described above (CCing Mike so he can remind me later of
this yet another promise :)

Vlastimil

> ---
> change for v2 - Update commit of workingset_refault() suggested Johannes Weiner.
> See https://lore.kernel.org/all/20230316143007.GC116016@cmpxchg.org/
> ---
>  mm/workingset.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/workingset.c b/mm/workingset.c
> index a304e8571d54..b864eec49ddd 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -111,9 +111,20 @@
>   *
>   *   NR_inactive + (R - E) <= NR_inactive + NR_active
>   *
> - * which can be further simplified to
> + * If we have swap we should consider about NR_inactive_anon and
> + * NR_active_anon, so for page cache and anonymous respectively:
>   *
> - *   (R - E) <= NR_active
> + *   NR_inactive_file + (R - E) <= NR_inactive_file + NR_active_file
> + *   + NR_inactive_anon + NR_active_anon
> + *
> + *   NR_inactive_anon + (R - E) <= NR_inactive_anon + NR_active_anon
> + *   + NR_inactive_file + NR_active_file
> + *
> + * Which can be further simplified to:
> + *
> + *   (R - E) <= NR_active_file + NR_inactive_anon + NR_active_anon
> + *
> + *   (R - E) <= NR_active_anon + NR_inactive_file + NR_active_file
>   *
>   * Put into words, the refault distance (out-of-cache) can be seen as
>   * a deficit in inactive list space (in-cache).  If the inactive list
> @@ -130,14 +141,14 @@
>   * are no longer in active use.
>   *
>   * So when a refault distance of (R - E) is observed and there are at
> - * least (R - E) active pages, the refaulting page is activated
> - * optimistically in the hope that (R - E) active pages are actually
> + * least (R - E) pages in the userspace workingset, the refaulting page
> + * is activated optimistically in the hope that (R - E) pages are actually
>   * used less frequently than the refaulting page - or even not used at
>   * all anymore.
>   *
>   * That means if inactive cache is refaulting with a suitable refault
>   * distance, we assume the cache workingset is transitioning and put
> - * pressure on the current active list.
> + * pressure on the current workingset.
>   *
>   * If this is wrong and demotion kicks in, the pages which are truly
>   * used more frequently will be reactivated while the less frequently
> @@ -468,7 +479,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	 * don't activate pages that couldn't stay resident even if
>  	 * all the memory was available to the workingset. For page
>  	 * cache whether workingset competition needs to consider
> -	 * anon or not depends on having swap.
> +	 * anon or not depends on having free swap sapce.
>  	 */
>  	workingset_size = lruvec_page_state(eviction_lruvec, NR_ACTIVE_FILE);
>  	/* For anonymous page */

