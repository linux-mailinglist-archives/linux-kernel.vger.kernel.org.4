Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDCC65AE45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjABIje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjABIjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:39:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8DC19;
        Mon,  2 Jan 2023 00:39:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 59CE433F82;
        Mon,  2 Jan 2023 08:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672648769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBpzvYwTG7MktQJZQ60oM5iN55WPRaqqwC7DCEgXNrM=;
        b=ScZXyyDkp3FSC9rCEqv8glXmh316nDRRBqEdxFm2B85ZC1QzyP+kDYROvtjeMq9rmc7dQu
        JiI/Qd+BL5YyaEoCYal2v4UJmMagl85ET8KTmTQl+bbiAkRhtiQyPzxhNSoApVbd1lGUIb
        3JHg2/iCEhRzxRjoMsMKaRXz+sLIWec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672648769;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zBpzvYwTG7MktQJZQ60oM5iN55WPRaqqwC7DCEgXNrM=;
        b=EM7SMaIlHYkfB6f2LuUlB3uwF90WNRoTFdKaIiuqR8aOAQqieK++OflGumRL3c/FJ0KVW8
        KFxABA13vb0Dg+AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B17B13427;
        Mon,  2 Jan 2023 08:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lnXHCUGYsmODKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 02 Jan 2023 08:39:29 +0000
Message-ID: <0f330796-480e-0b78-c2f4-006eac38d7df@suse.cz>
Date:   Mon, 2 Jan 2023 09:39:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V2] mm/slab: remove unused slab_early_init
Content-Language: en-US
To:     gouhao@uniontech.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, keescook@chromium.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, mingo@elte.hu
References: <20221218123127.23810-1-gouhao@uniontech.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221218123127.23810-1-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/22 13:31, gouhao@uniontech.com wrote:
> From: Gou Hao <gouhao@uniontech.com>
> 
> 'slab_early_init' was introduced by 'commit e0a42726794f
> ("[PATCH] mm/slab.c: fix early init assumption")', this
> flag was used to prevent off-slab caches being created
> so early during bootup.
> 
> The only user of 'slab_early_init' was removed in 'commit
>  3217fd9bdf00 ("mm/slab: make criteria for off slab
> determination robust and simple")'.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks, added to slab/for-6.3/cleanups

> ---
>  mm/slab.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 7a269db050ee..ede1f29fd81c 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -220,7 +220,6 @@ static inline void fixup_objfreelist_debug(struct kmem_cache *cachep,
>  static inline void fixup_slab_list(struct kmem_cache *cachep,
>  				struct kmem_cache_node *n, struct slab *slab,
>  				void **list);
> -static int slab_early_init = 1;
>  
>  #define INDEX_NODE kmalloc_index(sizeof(struct kmem_cache_node))
>  
> @@ -1249,8 +1248,6 @@ void __init kmem_cache_init(void)
>  	slab_state = PARTIAL_NODE;
>  	setup_kmalloc_cache_index_table();
>  
> -	slab_early_init = 0;
> -
>  	/* 5) Replace the bootstrap kmem_cache_node */
>  	{
>  		int nid;

