Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AABB6E21EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjDNLTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDNLTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:19:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770377EC3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:19:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2FAF9219D6;
        Fri, 14 Apr 2023 11:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681471156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZUPV6pvekn40maEI+d6rlcYC8PK3Q9/JIUXWlP6fAA=;
        b=w9LeYM/Q58ccqbrL9dE7O08byimshZocrbvRnOHJ+AYITEdf9YzDa4vvq/fd1FqYMVUp0l
        lHCLT+HkeAE0AXka1m+LYlKEw5KH544rKNd0dY3nhAtsQaLr3RswnsNMlzk/5ZvOT5l0Lc
        vSETGlGHFru3yJUQX6QVQjHOJCpaOA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681471156;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CZUPV6pvekn40maEI+d6rlcYC8PK3Q9/JIUXWlP6fAA=;
        b=l2W7I7U1WfPo+HxoNATaOUkbgXialypbm9FH3wNuCBHkEidLnaA3oQuhtMLrOx5BIgaLPz
        3ug9QVipKx8ZCIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C0F513498;
        Fri, 14 Apr 2023 11:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BQbUBrQ2OWRlQwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 11:19:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A234DA0732; Fri, 14 Apr 2023 13:19:15 +0200 (CEST)
Date:   Fri, 14 Apr 2023 13:19:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: add ALLQUOTA macro
Message-ID: <20230414111915.7tovgyisqrru3amn@quack3>
References: <20230413154151.72935-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413154151.72935-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 23:41:51, Yangtao Li wrote:
> Convert to use macro instead of raw number.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Um, I agree the iteration over quota types would use some cleanup (like
clearly distinguishing which functions can handle multiple types, which can
handle only one) but your change does not really help much towards that
cleanup. -1 is clearly special value and shorter to type than ALLQUOTA.

If you are interested in doing larger cleanup of quota type handling, tell
me and we can discuss how it should look like.

								Honza

> ---
>  fs/quota/dquot.c           | 20 ++++++++++----------
>  include/uapi/linux/quota.h |  1 +
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 10b46c403bdb..62ee6cb32e57 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -640,7 +640,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  	WARN_ON_ONCE(!rwsem_is_locked(&sb->s_umount));
>  
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		if (!sb_has_quota_active(sb, cnt))
>  			continue;
> @@ -675,7 +675,7 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  	}
>  
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
> -		if ((cnt == type || type == -1) && sb_has_quota_active(sb, cnt)
> +		if ((cnt == type || type == ALLQUOTA) && sb_has_quota_active(sb, cnt)
>  		    && info_dirty(&dqopt->info[cnt]))
>  			sb->dq_op->write_info(sb, cnt);
>  	dqstats_inc(DQST_SYNCS);
> @@ -714,7 +714,7 @@ int dquot_quota_sync(struct super_block *sb, int type)
>  	 * that userspace sees the changes.
>  	 */
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		if (!sb_has_quota_active(sb, cnt))
>  			continue;
> @@ -948,7 +948,7 @@ static int dqinit_needed(struct inode *inode, int type)
>  		return 0;
>  
>  	dquots = i_dquot(inode);
> -	if (type != -1)
> +	if (type != ALLQUOTA)
>  		return !dquots[type];
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
>  		if (!dquots[cnt])
> @@ -1391,7 +1391,7 @@ static int __dquot_initialize(struct inode *inode, int type)
>  		int rc;
>  		struct dquot *dquot;
>  
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		/*
>  		 * The i_dquot should have been initialized in most cases,
> @@ -1440,7 +1440,7 @@ static int __dquot_initialize(struct inode *inode, int type)
>  	if (IS_NOQUOTA(inode))
>  		goto out_lock;
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		/* Avoid races with quotaoff() */
>  		if (!sb_has_quota_active(sb, cnt))
> @@ -1478,7 +1478,7 @@ static int __dquot_initialize(struct inode *inode, int type)
>  
>  int dquot_initialize(struct inode *inode)
>  {
> -	return __dquot_initialize(inode, -1);
> +	return __dquot_initialize(inode, ALLQUOTA);
>  }
>  EXPORT_SYMBOL(dquot_initialize);
>  
> @@ -2131,7 +2131,7 @@ static void vfs_cleanup_quota_inode(struct super_block *sb, int type)
>  }
>  
>  /*
> - * Turn quota off on a device. type == -1 ==> quotaoff for all types (umount)
> + * Turn quota off on a device. type == ALLQUOTA ==> quotaoff for all types (umount)
>   */
>  int dquot_disable(struct super_block *sb, int type, unsigned int flags)
>  {
> @@ -2158,7 +2158,7 @@ int dquot_disable(struct super_block *sb, int type, unsigned int flags)
>  		return 0;
>  
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		if (!sb_has_quota_loaded(sb, cnt))
>  			continue;
> @@ -2392,7 +2392,7 @@ int dquot_resume(struct super_block *sb, int type)
>  		up_read(&sb->s_umount);
>  
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
> -		if (type != -1 && cnt != type)
> +		if (type != ALLQUOTA && cnt != type)
>  			continue;
>  		if (!sb_has_quota_suspended(sb, cnt))
>  			continue;
> diff --git a/include/uapi/linux/quota.h b/include/uapi/linux/quota.h
> index f17c9636a859..1707ed43365a 100644
> --- a/include/uapi/linux/quota.h
> +++ b/include/uapi/linux/quota.h
> @@ -38,6 +38,7 @@
>  #define __DQUOT_VERSION__	"dquot_6.6.0"
>  
>  #define MAXQUOTAS 3
> +#define ALLQUOTA -1
>  #define USRQUOTA  0		/* element used for user quotas */
>  #define GRPQUOTA  1		/* element used for group quotas */
>  #define PRJQUOTA  2		/* element used for project quotas */
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
