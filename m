Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429966E37C8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjDPLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDPLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:44:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561D41BD0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:44:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q2so27711746pll.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681645467; x=1684237467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IdPIXHdAAVocJh8z9AALcLC1nJeSwv0FGrEVmVSo0BQ=;
        b=Kqs3VCxJ9BN0RSTS7r4oFyy65PQjkkuzLPdTmkE5xgDLNSXgcH8SFWSjSWuy7Nra9Q
         /iF11G+4jKfIC8XNZ4pPD4rZKASD7O4LGjH+Uy+6DnkxAT0gZL7oxdXOmCpBdAXhfKlx
         RWIrjHE12IATbDsgDRmT6yifOBJBjlayVGSVzBsh2OWYT7X+TYaTfJpuBnnvbI1ayI/C
         l7lOWhR6R9jyBnEw7Az0q3c89DOMECGETGCw8BCkz5YWlsHrfzvy6gO+GVS8UeoNN1QB
         ifEi/GbCLy1jWdb7iX9WMoPQE5ko2FQQa5AQrc32BdTo2otW9GRGkqO9Cif3mR4S4dtn
         1wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681645467; x=1684237467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdPIXHdAAVocJh8z9AALcLC1nJeSwv0FGrEVmVSo0BQ=;
        b=jPfjRMhjtA+0KqUDJ8sNb8uyyzy1lCsalhZzeysiJEH7zBJR5L1RZxsSZIxkg7tsZ0
         p1+KF0rGnyTn4BfwwRl+IsiJ2+GvNk6HXFREGoyJS/Slm/C7OQL5RCCC16OI4GQTfobr
         YQvDAwzbiLFebewrQlhf+3x0Ka2in11M4CrCEGiz0nnVYtkW52qUEpGLOddzSLWzhg+r
         iTBjPljpj30YxajdZykC2oDRxCHYt33yJ3LglH3WpX8Rmi8fGo0klYlObAD3mTgRXi6k
         vm29pdVF6n+ClyZPK3PaXkAdQVjS/z1DMzRGHbrmQatq8/v+IxukiuK/rIv0lKfqLW07
         Jghg==
X-Gm-Message-State: AAQBX9fYNNl8gYHc0oFuDXppQZqr3LQHiCIRF9kDEduLSlgLLO++eS82
        kPc2pmsoOv24SnfoQ60BeE8=
X-Google-Smtp-Source: AKy350YNDZ/VSrvcDv9xsz8toTVxILT3xYH3kza7r1DYS+8JyvS1jEiwlGwyHiccbjN5j5rct4uijA==
X-Received: by 2002:a17:90b:3142:b0:247:1418:ad28 with SMTP id ip2-20020a17090b314200b002471418ad28mr12252878pjb.22.1681645466537;
        Sun, 16 Apr 2023 04:44:26 -0700 (PDT)
Received: from hyeyoo ([211.108.101.96])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090aba0200b00240015b837fsm11961245pjr.2.2023.04.16.04.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 04:44:25 -0700 (PDT)
Date:   Sun, 16 Apr 2023 20:44:14 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     david.keisarschm@mail.huji.ac.il
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, Jason@zx2c4.com,
        linux-mm@kvack.org, ilay.bahat1@gmail.com, aksecurity@gmail.com
Subject: Re: [PATCH v5 1/3] Replace invocation of weak PRNG
Message-ID: <ZDvfjkB5dKTFcC0L@hyeyoo>
References: <20230415173633.5422-1-david.keisarschm@mail.huji.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415173633.5422-1-david.keisarschm@mail.huji.ac.il>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 08:36:32PM +0300, david.keisarschm@mail.huji.ac.il wrote:
> From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> 
> The Slab allocator randomization uses the prandom_u32
> PRNG. That was added to prevent attackers to obtain information on the heap
> state, by randomizing the freelists state.
> 
> However, this PRNG turned out to be weak, as noted in commit c51f8f88d705
> To fix it, we have changed the invocation of prandom_u32_state to get_random_u32
> to ensure the PRNG is strong. Since a modulo operation is applied right after that,
> we used get_random_u32_below, to achieve uniformity.
>
> In addition, we changed the freelist_init_state union to struct,
> since the rnd_state inside which is used to store the state of prandom_u32,
> is not needed anymore, since get_random_u32 maintains its own state.

makes sense to me, but some nits:

I think the subject should start with "mm/slab:" for this patch
and "mm/slab_common:" for the next patch.

> 
> Signed-off-by: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>
> ---
> This fifth series changes only the arch/x86/mm/kaslr patch.
> 
> Changes since v3:
> 
> * edited commit message.
> 
> Changes since v2:
> 
> * replaced instances of get_random_u32 with get_random_u32_below
>     in mm/slab.c.
> 
>  mm/slab.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index edbe722fb..7c8bb4a8f 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2360,20 +2360,17 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct slab *slab)
>  
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Hold information during a freelist initialization */
> -union freelist_init_state {
> -	struct {
> -		unsigned int pos;
> -		unsigned int *list;
> -		unsigned int count;
> -	};
> -	struct rnd_state rnd_state;
> +struct freelist_init_state {
> +	unsigned int pos;
> +	unsigned int *list;
> +	unsigned int count;
>  };
>  
>  /*
>   * Initialize the state based on the randomization method available.
>   * return true if the pre-computed list is available, false otherwise.
>   */
> -static bool freelist_state_initialize(union freelist_init_state *state,
> +static bool freelist_state_initialize(struct freelist_init_state *state,
>  				struct kmem_cache *cachep,
>  				unsigned int count)
>  {
> @@ -2381,23 +2378,22 @@ static bool freelist_state_initialize(union freelist_init_state *state,
>  	unsigned int rand;
>  
>  	/* Use best entropy available to define a random shift */
> -	rand = get_random_u32();
> +	rand = get_random_u32_below(count);
>  

>  	/* Use a random state if the pre-computed list is not available */

This comment should be removed too.

>  	if (!cachep->random_seq) {
> -		prandom_seed_state(&state->rnd_state, rand);
>  		ret = false;
>  	} else {
>  		state->list = cachep->random_seq;
>  		state->count = count;
> -		state->pos = rand % count;
> +		state->pos = rand;

this could be:
		state->pos = get_random_u32_below(count);

without defining the variable rand.

>  		ret = true;
>  	}
>  	return ret;
>  }
>  
>  /* Get the next entry on the list and randomize it using a random shift */
> -static freelist_idx_t next_random_slot(union freelist_init_state *state)
> +static freelist_idx_t next_random_slot(struct freelist_init_state *state)
>  {
>  	if (state->pos >= state->count)
>  		state->pos = 0;
> @@ -2418,7 +2414,7 @@ static void swap_free_obj(struct slab *slab, unsigned int a, unsigned int b)
>  static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
>  {
>  	unsigned int objfreelist = 0, i, rand, count = cachep->num;
> -	union freelist_init_state state;
> +	struct freelist_init_state state;
>  	bool precomputed;
>  
>  	if (count < 2)
> @@ -2447,8 +2443,7 @@ static bool shuffle_freelist(struct kmem_cache *cachep, struct slab *slab)
>  
>  		/* Fisher-Yates shuffle */
>  		for (i = count - 1; i > 0; i--) {
> -			rand = prandom_u32_state(&state.rnd_state);
> -			rand %= (i + 1);
> +			rand = get_random_u32_below(i+1);
			
			per the coding standard this should be

			rand = get_random_u32_below(i +1);

>  			swap_free_obj(slab, i, rand);
>  		}
>  	} else {
> -- 
> 2.37.3
> 
