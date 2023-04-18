Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442B86E5A20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDRHKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 03:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDRHKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 03:10:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EB31BD0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 00:10:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EEF81F8D6;
        Tue, 18 Apr 2023 07:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681801808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRH3eWeEGHDvPlwB5o7ZP/I1WDLHJ6RIIKKJIQqdE1A=;
        b=so4zQ8EwJgUkGF0MgCPwmVLb9bk0I+asMlVdVPpISErxSfb+i83YtveAq+Qi0DGZ2iMlAk
        9vyBCNCEW79KiKHD3UTvHqW3hUx7n8mJCgmVTplSW2euEhf3zB1ABtT6lW/GnKILOvu0Gh
        KXaKBZlDDHmFIOjj4IMYvG+fUi1SXw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681801808;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dRH3eWeEGHDvPlwB5o7ZP/I1WDLHJ6RIIKKJIQqdE1A=;
        b=+8hBlk8yQAjosdSue4bgIic8LNRi4fkdwOZEOBroGaWoymfQN+3Q+JKjQ1AEnzilwO5ee9
        tfWOHNTJw7ncFwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06A0B13581;
        Tue, 18 Apr 2023 07:10:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HTvXAFBCPmSZWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 18 Apr 2023 07:10:08 +0000
Message-ID: <031c79dd-1927-0d81-bfef-6dc64adcad12@suse.cz>
Date:   Tue, 18 Apr 2023 09:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] mm: Fixed incorrect comment for _kmem_cache_create
 function
To:     zhaoxinchao <ChrisXinchao@outlook.com>
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com, cl@linux.com,
        iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, penberg@kernel.org, rientjes@google.com
References: <24a0219d-b0a1-8b81-ff98-2fff107650c3@suse.cz>
 <DM6PR22MB1836E82FB689EE68B8065C47C59D9@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <DM6PR22MB1836E82FB689EE68B8065C47C59D9@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/23 04:05, zhaoxinchao wrote:
> From: zhaoxinchao <chrisxinchao@outlook.com>
> 
> Actually __kmem_cache_create() returns a status :
> 0 is success
> nonezero are failed.
> 
> This function has three return positions. In addition to successfully
> return 0, the first failed position will return - E2BIG, and the second
> position will return nonzero value for setup_cpu_cache function failure.

Adjusted a bit.

> Signed-off-by: zhaoxinchao <chrisxinchao@outlook.com>
> ---
>  mm/slab.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index edbe722fb..ebd326f07 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1888,14 +1888,17 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
>  	return true;
>  }
>  
> -/**
> +/*
>   * __kmem_cache_create - Create a cache.
>   * @cachep: cache management descriptor
>   * @flags: SLAB flags
>   *
> - * Returns a ptr to the cache on success, NULL on failure.
> - * Cannot be called within an int, but can be interrupted.
> - * The @ctor is run when new pages are allocated by the cache.
> + * Returns zero on success, nonzero on failure.
> + * This function has three return positions.
> + * In addition to successfully return 0, the
> + * first failed position will return - E2BIG,
> + * and the second position will return nonzero
> + * value for setup_cpu_cache function failure.

In v2 I recommended dropping the detailed description. Removed it when
merging. The result is merged for 6.5 here:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git/log/?h=slab/for-6.5/trivial

Thanks!

>   *
>   * The flags are
>   *
> @@ -1908,8 +1911,6 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
>   * %SLAB_HWCACHE_ALIGN - Align the objects in this cache to a hardware
>   * cacheline.  This can be beneficial if you're counting cycles as closely
>   * as davem.
> - *
> - * Return: a pointer to the created cache or %NULL in case of error
>   */
>  int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>  {

