Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09125FE9A2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJNHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiJNHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:35:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827326AA1E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 00:35:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3B4BB1F74A;
        Fri, 14 Oct 2022 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665732917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjAKlOIc9+kUV/2uFXOWSjipZ0QlJBcD+i3sVbc0+lY=;
        b=gmQwQOa+gwNxtkeplHUOMU3gKgX7mP0mtx4iu+znQ2QvrIlNFei5ASTKBl/mtTMlo//O/w
        SNxmnvMPUdinLaNeSs3H2kVnavMnWG46bTazFARv9CyT17JEGcjZ3TWe4ckMjUKyqUjZfG
        032F7Udc+ls7zH5Kf7dmCUje5n0skko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665732917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjAKlOIc9+kUV/2uFXOWSjipZ0QlJBcD+i3sVbc0+lY=;
        b=YL77d77d5dBqe8q7MpQmiDcaPuTwxUAK4y6Ge1KacsVLcMLPggf+MfZFLn8onwSczLZtyZ
        Vb/UZ7DK184TkAAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13A1A13A4A;
        Fri, 14 Oct 2022 07:35:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3jMPBDURSWPXXQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Oct 2022 07:35:17 +0000
Message-ID: <931c87d8-5856-e393-7108-66275ee4099a@suse.cz>
Date:   Fri, 14 Oct 2022 09:35:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCHv2] mm: slab: comment __GFP_ZERO case for kmem_cache_alloc
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com
References: <20221011145413.8025-1-aahringo@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221011145413.8025-1-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/22 16:54, Alexander Aring wrote:
> This patch will add a comment for the __GFP_ZERO flag case for
> kmem_cache_alloc(). As the current comment mentioned that the flags only
> matters if the cache has no available objects it's different for the
> __GFP_ZERO flag which will ensure that the returned object is always
> zeroed in any case.
> 
> I have the feeling I run into this question already two times if the
> user need to zero the object or not, but the user does not need to zero
> the object afterwards. However another use of __GFP_ZERO and only zero
> the object if the cache has no available objects would also make no
> sense.

Hmm, but even with the update, the comment is still rather misleading, no?
- can the caller know if the cache has available objects and thus the flags
are irrelevant, in order to pass flags that are potentially wrong (if there
were no objects)? Not really.
- even if cache has available objects, we'll always end up in
slab_pre_alloc_hook doing might_alloc(flags) which will trigger warnings
(given CONFIG_DEBUG_ATOMIC_SLEEP etc.) if the flags are inappropriate for
given context. So they are still "relevant"

So maybe just delete the whole comment? slub.c doesn't have it, and if any
such comment should exist for kmem_cache_alloc() and contain anything useful
and not misleading, it should be probably in include/linux/slab.h anyway?

> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
> changes since v2:
>  - don't make a separate sentence for except
> 
>  mm/slab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 10e96137b44f..a86879f42f2e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3482,7 +3482,8 @@ void *__kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
>   * @flags: See kmalloc().
>   *
>   * Allocate an object from this cache.  The flags are only relevant
> - * if the cache has no available objects.
> + * if the cache has no available objects, except flag __GFP_ZERO which
> + * will zero the returned object.
>   *
>   * Return: pointer to the new object or %NULL in case of error
>   */

