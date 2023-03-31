Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CAB6D2016
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjCaMXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjCaMW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:22:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED17220624;
        Fri, 31 Mar 2023 05:22:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B170621996;
        Fri, 31 Mar 2023 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680265306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GnhdEVRiXpY8fy5LwSvQ63l1Tv95/C9yEYwE8xQJFI=;
        b=N3AdQR8s1TpV+AIiNrFfqeZy5037pMRRncNNTN3rVp2pe18xJ4gOo8krnHaamj4CAwfSMJ
        6hfvdnwbCEtFbldvm4Nqb3UJMDAGVD568HeGtT7fdK2KLDwJQU0ftYJeRDM5MbNOk8QE7h
        6YwYLuH5fmPWULZzs+jKsWpVy+JJpGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680265306;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3GnhdEVRiXpY8fy5LwSvQ63l1Tv95/C9yEYwE8xQJFI=;
        b=J1L5ruveSfJbRzEnimD3K36YgonuEJferAtuRSPRvGN2nTxLuFeATWN5VftGwUvqgMco/b
        QpQuM8adArlSXoCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EE97134F7;
        Fri, 31 Mar 2023 12:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jue6JlrQJmSsIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 31 Mar 2023 12:21:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2637DA071E; Fri, 31 Mar 2023 14:21:46 +0200 (CEST)
Date:   Fri, 31 Mar 2023 14:21:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com, axboe@kernel.dk,
        akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        yi.zhang@huawei.com, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] reiserfs: remove unused iter variable
Message-ID: <20230331122146.3rmw3dqv6y573pg2@quack3>
References: <20230331120325.1855111-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331120325.1855111-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-03-23 08:03:25, Tom Rix wrote:
> clang with W=1 reports
> fs/reiserfs/stree.c:1265:6: error: variable
>   'iter' set but not used [-Werror,-Wunused-but-set-variable]
>         int iter = 0;
>             ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks. I've merged the patch to my tree.

								Honza

> ---
>  fs/reiserfs/stree.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
> index 84c12a1947b2..ce5003986789 100644
> --- a/fs/reiserfs/stree.c
> +++ b/fs/reiserfs/stree.c
> @@ -1262,7 +1262,6 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
>  
>  #ifdef CONFIG_REISERFS_CHECK
>  	char mode;
> -	int iter = 0;
>  #endif
>  
>  	BUG_ON(!th->t_trans_id);
> @@ -1274,7 +1273,6 @@ int reiserfs_delete_item(struct reiserfs_transaction_handle *th,
>  		removed = 0;
>  
>  #ifdef CONFIG_REISERFS_CHECK
> -		iter++;
>  		mode =
>  #endif
>  		    prepare_for_delete_or_cut(th, inode, path,
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
