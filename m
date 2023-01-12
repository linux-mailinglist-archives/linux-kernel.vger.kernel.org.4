Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09D36670AF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbjALLOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbjALLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:13:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831111C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:04:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83A2F3EB52;
        Thu, 12 Jan 2023 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673521493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7U4mlN6IF/k21gP9LsSqfR9yyrjT6JH4Uv/UCYlR+E=;
        b=NcYnuvitptmAuez2XBj6nEOXLq9D+CPypAeb3HxFZtXul03DiOfpAFiCpFSw3OWFMAWoqJ
        Bpgfk1bqPYQb1eBfK9cT+s3HNe8eZ8Rlm1hJEybRDUJxp9lExiv9lIMcUBKJpc6TwnpaQJ
        3Y1zt2DxwjbfByhG5hCN3ziZBZFZg6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673521493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e7U4mlN6IF/k21gP9LsSqfR9yyrjT6JH4Uv/UCYlR+E=;
        b=iJw2x/cgJd7Laxrc+uU9MXmqgSZavie4T/1g9g3jzcRn+GPwW0oL79NJUzGJGyrLZ4i2JX
        rDF5+smmKecxrdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E73313776;
        Thu, 12 Jan 2023 11:04:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwNtElXpv2N/MAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 12 Jan 2023 11:04:53 +0000
Message-ID: <ef422b84-cd33-69c7-9fef-cc8d1d45651c@suse.cz>
Date:   Thu, 12 Jan 2023 12:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/5] Documentation/mm: Update references to
 __m[un]lock_page() to *_folio()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1672043615.git.lstoakes@gmail.com>
 <cf3c5615d98f4e690dad46b074933024b8469d37.1672043615.git.lstoakes@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cf3c5615d98f4e690dad46b074933024b8469d37.1672043615.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/22 09:44, Lorenzo Stoakes wrote:
> We now pass folios to these functions, so update the documentation
> accordingly.
> 
> Additionally, correct the outdated reference to __pagevec_lru_add_fn(), the
> referenced action occurs in __munlock_folio() directly now.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

With:

> ---
>  Documentation/mm/unevictable-lru.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/mm/unevictable-lru.rst b/Documentation/mm/unevictable-lru.rst
> index 4a0e158aa9ce..153629e0c100 100644
> --- a/Documentation/mm/unevictable-lru.rst
> +++ b/Documentation/mm/unevictable-lru.rst
> @@ -308,22 +308,22 @@ do end up getting faulted into this VM_LOCKED VMA, they will be handled in the
>  fault path - which is also how mlock2()'s MLOCK_ONFAULT areas are handled.
>  
>  For each PTE (or PMD) being faulted into a VMA, the page add rmap function
> -calls mlock_vma_page(), which calls mlock_page() when the VMA is VM_LOCKED
> +calls mlock_vma_page(), which calls mlock_folio() when the VMA is VM_LOCKED
>  (unless it is a PTE mapping of a part of a transparent huge page).  Or when
>  it is a newly allocated anonymous page, lru_cache_add_inactive_or_unevictable()

Think it would be more appropriate now:    ^ folio_add_lru_vma()

> -calls mlock_new_page() instead: similar to mlock_page(), but can make better
> +calls mlock_new_folio() instead: similar to mlock_folio(), but can make better
>  judgments, since this page is held exclusively and known not to be on LRU yet.
>  
> -mlock_page() sets PageMlocked immediately, then places the page on the CPU's

		     PG_mlocked?

> -mlock pagevec, to batch up the rest of the work to be done under lru_lock by
> -__mlock_page().  __mlock_page() sets PageUnevictable, initializes mlock_count

					PG_unevictable

ditto below

> +mlock_folio() sets PageMlocked immediately, then places the page on the CPU's
> +mlock folio batch, to batch up the rest of the work to be done under lru_lock by
> +__mlock_folio().  __mlock_folio() sets PageUnevictable, initializes mlock_count
>  and moves the page to unevictable state ("the unevictable LRU", but with
>  mlock_count in place of LRU threading).  Or if the page was already PageLRU
>  and PageUnevictable and PageMlocked, it simply increments the mlock_count.
>  
>  But in practice that may not work ideally: the page may not yet be on an LRU, or
>  it may have been temporarily isolated from LRU.  In such cases the mlock_count
> -field cannot be touched, but will be set to 0 later when __pagevec_lru_add_fn()
> +field cannot be touched, but will be set to 0 later when __munlock_folio()
>  returns the page to "LRU".  Races prohibit mlock_count from being set to 1 then:
>  rather than risk stranding a page indefinitely as unevictable, always err with
>  mlock_count on the low side, so that when munlocked the page will be rescued to

