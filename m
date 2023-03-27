Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609556C9EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjC0JAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjC0I7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:59:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7C96185;
        Mon, 27 Mar 2023 01:57:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A8111F390;
        Mon, 27 Mar 2023 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679907470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsjdwQC1SQNlX4Ss19all/21eWMCxSr72u89IWVV3N8=;
        b=3NB+KVfA63hYNzd6cCOT0J91ZMysy4InCEVvnVWRQEVecqVkoF/PZK4nAw4K4GR2gCDtiN
        7Q5Rc95I4tErGOm+y7rXNbmD8J4HUjKGusyhe16EI5pcHsf/3xxzQSf9YcW1CX22M1ZqfT
        NiqcarGBdO3kOvdKbJ1Xbp5zx4PIyDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679907470;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VsjdwQC1SQNlX4Ss19all/21eWMCxSr72u89IWVV3N8=;
        b=O/zS+lKt9iROId/HQmgAGxFMCy5PCQ62LGW6KPGAuidre1hh0+hViOJBt2Bk0rCYQDWdTH
        yUw4i7s+0KlhnCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 480B913329;
        Mon, 27 Mar 2023 08:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +uSMEY5aIWRHVQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 08:57:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CC219A071C; Mon, 27 Mar 2023 10:57:49 +0200 (CEST)
Date:   Mon, 27 Mar 2023 10:57:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tom Rix <trix@redhat.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com, willy@infradead.org,
        akpm@linux-foundation.org, jack@suse.cz, jlayton@kernel.org,
        song@kernel.org, yi.zhang@huawei.com, bvanassche@acm.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] reiserfs: remove unused sched_count variable
Message-ID: <20230327085749.feyfegzdjxqhymdu@quack3>
References: <20230326204459.1358553-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326204459.1358553-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 26-03-23 16:44:59, Tom Rix wrote:
> clang with W=1 reports
> fs/reiserfs/journal.c:3034:6: error: variable
>   'sched_count' set but not used [-Werror,-Wunused-but-set-variable]
>         int sched_count = 0;
>             ^
> This variable is not used so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Thanks. I've added the fix to my tree.

								Honza

> ---
>  fs/reiserfs/journal.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 9ce4ec296b74..4d11d60f493c 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -3031,7 +3031,6 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
>  	unsigned int old_trans_id;
>  	struct reiserfs_journal *journal = SB_JOURNAL(sb);
>  	struct reiserfs_transaction_handle myth;
> -	int sched_count = 0;
>  	int retval;
>  	int depth;
>  
> @@ -3088,7 +3087,6 @@ static int do_journal_begin_r(struct reiserfs_transaction_handle *th,
>  		    ((journal->j_len + nblocks + 2) * 100) <
>  		    (journal->j_len_alloc * 75)) {
>  			if (atomic_read(&journal->j_wcount) > 10) {
> -				sched_count++;
>  				queue_log_writer(sb);
>  				goto relock;
>  			}
> -- 
> 2.27.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
