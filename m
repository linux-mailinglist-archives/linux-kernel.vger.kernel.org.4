Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580395B3415
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIIJgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIIJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:36:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365CA915F3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:36:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E53F41F8E4;
        Fri,  9 Sep 2022 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662716194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZMRMuHCYZenMkKNZlYosRlANTeyRL1A4qKReD8ccs0=;
        b=QYNv5X+lhWXPW6izhjmBJrqkGQtaaU6E1gtllfIJ5nwW8959Duzp0nPnHjAZKuc6UVUp6t
        Q1/SkoVel4dO4iMHZriXcVvX1o93VkIk2sOOx7Zf6ScFFKjQvvTm9jJG5J1rLyHci9UGUp
        xyhXbqyicLk/HzLZsVxpEETWeOoUeAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662716194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZMRMuHCYZenMkKNZlYosRlANTeyRL1A4qKReD8ccs0=;
        b=PuAAywOyDAlaL8Xi3AliGHK0ggukn6i/Mi2CFuhPTVy/ukdgeqKb9dAZYz19vtJF3tMjJa
        nBmhN2LgopQQYUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D027213A93;
        Fri,  9 Sep 2022 09:36:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zpPJMiIJG2MoZAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 09 Sep 2022 09:36:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E323A0684; Fri,  9 Sep 2022 11:36:34 +0200 (CEST)
Date:   Fri, 9 Sep 2022 11:36:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     axboe@kernel.dk, dhowells@redhat.com, vbabka@suse.cz,
        willy@infradead.org, akpm@linux-foundation.org,
        zhanglianjie@uniontech.com, neilb@suse.de, jack@suse.cz,
        bvanassche@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback: remove unused macro DIRTY_FULL_SCOPE
Message-ID: <20220909093634.od4aukp2oumgflcc@quack3>
References: <20220909025711.32012-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909025711.32012-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-09-22 10:57:11, Miaohe Lin wrote:
> It's introduced but never used. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 3f045f6d6c4f..06f9291b6fd5 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -17,20 +17,12 @@ struct bio;
>  DECLARE_PER_CPU(int, dirty_throttle_leaks);
>  
>  /*
> - * The 1/4 region under the global dirty thresh is for smooth dirty throttling:
> - *
> - *	(thresh - thresh/DIRTY_FULL_SCOPE, thresh)
> - *
> - * Further beyond, all dirtier tasks will enter a loop waiting (possibly long
> - * time) for the dirty pages to drop, unless written enough pages.
> - *
>   * The global dirty threshold is normally equal to the global dirty limit,
>   * except when the system suddenly allocates a lot of anonymous memory and
>   * knocks down the global dirty threshold quickly, in which case the global
>   * dirty limit will follow down slowly to prevent livelocking all dirtier tasks.
>   */
>  #define DIRTY_SCOPE		8
> -#define DIRTY_FULL_SCOPE	(DIRTY_SCOPE / 2)
>  
>  struct backing_dev_info;
>  
> -- 
> 2.23.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
