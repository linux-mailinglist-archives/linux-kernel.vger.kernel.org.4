Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E133768F392
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjBHQlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjBHQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:40:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C073803E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:40:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42E3334280;
        Wed,  8 Feb 2023 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675874437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1KlVZ9F3aIxHpgD6Jwxy+qwJV6X/hM6MXtY37o4YVE=;
        b=vfT1tSdJK5Flqf27K9dNGf0xizCq/dyw/IQn8NX1aw2/Ju4kj/DKZj+lQHxtJ6BwoKrtsG
        uJrVlUMjvtKBRfkvfEn/yS5wiAoYWjYNBwFe/Qc52rFQEw7m/zPmxuv0JYTv13+KqElcy4
        0IsdGtkCKGmsMOdftLY8sOOqpRt8grg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675874437;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F1KlVZ9F3aIxHpgD6Jwxy+qwJV6X/hM6MXtY37o4YVE=;
        b=A3dlU/OcbcrnL4yzs0EZyrQIV18Shu7xP90WVUNWkJtBOyxhmkeghRv6TVMInq6fp8waNw
        ivF+kpXS3Iqpk3CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D6211358A;
        Wed,  8 Feb 2023 16:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Jc2CBoXQ42OvXwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 16:40:37 +0000
Message-ID: <e5a264d8-0e5a-176d-13d4-7d411a0d169f@suse.cz>
Date:   Wed, 8 Feb 2023 17:40:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/18] lib/stackdepot, mm: rename
 stack_depot_want_early_init
Content-Language: en-US
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
 <cb34925852c81be2ec6aac75766292e4e590523e.1675111415.git.andreyknvl@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <cb34925852c81be2ec6aac75766292e4e590523e.1675111415.git.andreyknvl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 21:49, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Rename stack_depot_want_early_init to stack_depot_request_early_init.
> 
> The old name is confusing, as it hints at returning some kind of intention
> of stack depot. The new name reflects that this function requests an action
> from stack depot instead.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/stackdepot.h | 14 +++++++-------
>  lib/stackdepot.c           | 10 +++++-----
>  mm/page_owner.c            |  2 +-
>  mm/slub.c                  |  4 ++--
>  4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
> index 1296a6eeaec0..c4e3abc16b16 100644
> --- a/include/linux/stackdepot.h
> +++ b/include/linux/stackdepot.h
> @@ -31,26 +31,26 @@ typedef u32 depot_stack_handle_t;
>   * enabled as part of mm_init(), for subsystems where it's known at compile time
>   * that stack depot will be used.
>   *
> - * Another alternative is to call stack_depot_want_early_init(), when the
> + * Another alternative is to call stack_depot_request_early_init(), when the
>   * decision to use stack depot is taken e.g. when evaluating kernel boot
>   * parameters, which precedes the enablement point in mm_init().
>   *
> - * stack_depot_init() and stack_depot_want_early_init() can be called regardless
> - * of CONFIG_STACKDEPOT and are no-op when disabled. The actual save/fetch/print
> - * functions should only be called from code that makes sure CONFIG_STACKDEPOT
> - * is enabled.
> + * stack_depot_init() and stack_depot_request_early_init() can be called
> + * regardless of CONFIG_STACKDEPOT and are no-op when disabled. The actual
> + * save/fetch/print functions should only be called from code that makes sure
> + * CONFIG_STACKDEPOT is enabled.
>   */
>  #ifdef CONFIG_STACKDEPOT
>  int stack_depot_init(void);
>  
> -void __init stack_depot_want_early_init(void);
> +void __init stack_depot_request_early_init(void);
>  
>  /* This is supposed to be called only from mm_init() */
>  int __init stack_depot_early_init(void);
>  #else
>  static inline int stack_depot_init(void) { return 0; }
>  
> -static inline void stack_depot_want_early_init(void) { }
> +static inline void stack_depot_request_early_init(void) { }
>  
>  static inline int stack_depot_early_init(void)	{ return 0; }
>  #endif
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 90c4dd48d75e..8743fad1485f 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -71,7 +71,7 @@ struct stack_record {
>  	unsigned long entries[];	/* Variable-sized array of entries. */
>  };
>  
> -static bool __stack_depot_want_early_init __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
> +static bool __stack_depot_early_init_requested __initdata = IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT);
>  static bool __stack_depot_early_init_passed __initdata;
>  
>  static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
> @@ -107,12 +107,12 @@ static int __init is_stack_depot_disabled(char *str)
>  }
>  early_param("stack_depot_disable", is_stack_depot_disabled);
>  
> -void __init stack_depot_want_early_init(void)
> +void __init stack_depot_request_early_init(void)
>  {
> -	/* Too late to request early init now */
> +	/* Too late to request early init now. */
>  	WARN_ON(__stack_depot_early_init_passed);
>  
> -	__stack_depot_want_early_init = true;
> +	__stack_depot_early_init_requested = true;
>  }
>  
>  int __init stack_depot_early_init(void)
> @@ -128,7 +128,7 @@ int __init stack_depot_early_init(void)
>  	if (kasan_enabled() && !stack_hash_order)
>  		stack_hash_order = STACK_HASH_ORDER_MAX;
>  
> -	if (!__stack_depot_want_early_init || stack_depot_disable)
> +	if (!__stack_depot_early_init_requested || stack_depot_disable)
>  		return 0;
>  
>  	if (stack_hash_order)
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 2d27f532df4c..90a4a087e6c7 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -48,7 +48,7 @@ static int __init early_page_owner_param(char *buf)
>  	int ret = kstrtobool(buf, &page_owner_enabled);
>  
>  	if (page_owner_enabled)
> -		stack_depot_want_early_init();
> +		stack_depot_request_early_init();
>  
>  	return ret;
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index 13459c69095a..f2c6c356bc36 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1592,7 +1592,7 @@ static int __init setup_slub_debug(char *str)
>  		} else {
>  			slab_list_specified = true;
>  			if (flags & SLAB_STORE_USER)
> -				stack_depot_want_early_init();
> +				stack_depot_request_early_init();
>  		}
>  	}
>  
> @@ -1611,7 +1611,7 @@ static int __init setup_slub_debug(char *str)
>  out:
>  	slub_debug = global_flags;
>  	if (slub_debug & SLAB_STORE_USER)
> -		stack_depot_want_early_init();
> +		stack_depot_request_early_init();
>  	if (slub_debug != 0 || slub_debug_string)
>  		static_branch_enable(&slub_debug_enabled);
>  	else

