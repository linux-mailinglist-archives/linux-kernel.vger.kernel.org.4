Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663DA6E4D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 17:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjDQPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDQPrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 11:47:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F415AB0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 08:47:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AD26A1F6E6;
        Mon, 17 Apr 2023 15:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681746465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWaGp6h7eG3pYrSv/bO1HCdBjKN4Xw+BSEvICpcpi/4=;
        b=mvLhMZoWbebI8r+gQzEh+wSPI224Hxq7CWXkL7UiY/2/4m1jRLfToM2I+gR0NPHlCJ6yM6
        mc0h/mdJGLUX+3JelZWTphsq01tQ28KugME+WPN2Va8dbm5iBj7UK/avtPPkjAcpV9G4rm
        RHizf00Skiwqjr+CdRzc34OYMtMiofc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681746465;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gWaGp6h7eG3pYrSv/bO1HCdBjKN4Xw+BSEvICpcpi/4=;
        b=PSseswosx2QxDS48lOus2B6NdL8l+v1ajQBpJCOwg2w54gDmKeakceEmmP4FF2EMFq5jYF
        T9MdNipSW4OndPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 84E0D13319;
        Mon, 17 Apr 2023 15:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uxDYHyFqPWSrPwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 17 Apr 2023 15:47:45 +0000
Message-ID: <24a0219d-b0a1-8b81-ff98-2fff107650c3@suse.cz>
Date:   Mon, 17 Apr 2023 17:47:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] mm: Fixed incorrect comment for _kmem_cache_create
 function
Content-Language: en-US
To:     zhaoxinchao <ChrisXinchao@outlook.com>, bagasdotme@gmail.com
Cc:     akpm@linux-foundation.org, cl@linux.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com
References: <ZDQXl2wMk271w3xy@debian.me>
 <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <DM6PR22MB183653311FF3549B7D473020C59A9@DM6PR22MB1836.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 11:13, zhaoxinchao wrote:
> From: zhaoxinchao <chrisxinchao@outlook.com>
> 
> Actually __kmem_cache_create() returns a status :
> 0 is success
> nonezero are failed.
> 
> This function has three return positions. In addition to successfully
> return 0, the first failed position will return - E2BIG, and the second
> position will return nonzero value for setup_cpu_cache function failure.
> 
> Signed-off-by: zhaoxinchao <chrisxinchao@outlook.com>
> ---
>  mm/slab.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index edbe722fb..399daa4d0 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1893,7 +1893,12 @@ static bool set_on_slab_cache(struct kmem_cache *cachep,
>   * @cachep: cache management descriptor
>   * @flags: SLAB flags
>   *
> - * Returns a ptr to the cache on success, NULL on failure.
> + * Returns zero on success, nonzero on failure.

OK.

> + * This function has three return positions.
> + * In addition to successfully return 0, the
> + * first failed position will return - E2BIG,
> + * and the second position will return nonzero
> + * value for setup_cpu_cache function failure.

I don't think we need to be so specific here, so we can drop this block.

>   * Cannot be called within an int, but can be interrupted.
>   * The @ctor is run when new pages are allocated by the cache.
>   *

You missed that there's also:

 * Return: a pointer to the created cache or %NULL in case of error
 */
int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)

I guess we can drop the first mention of returns and fix up this one.
Also I'd make this a non-kerneldoc comment (/* instead of /**) as
it's for a SLAB-specific internal implementation only. Only
kmem_cache_create() is meant as an API.
