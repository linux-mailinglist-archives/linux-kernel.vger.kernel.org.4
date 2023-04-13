Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1964D6E10DC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjDMPTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjDMPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:19:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA3A5E1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:19:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E1EE2189B;
        Thu, 13 Apr 2023 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681399169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mG40i2zm3vZGS3htibJ+KR1FgLBJvqBG7htHHhKQLY8=;
        b=s1KVB38jF6oRg4QaT0tJDVD3/XKuNCAzUd582kt3/K1wys75RiAfTUUdV1cY8zKW1e/Num
        hfYD79Ey5epH0pnTdgmSoxaseLFUbLHII03AriR1mmS8YTFUYPDEBwvI4TPlTnYhzop9Gf
        rFtCh7tKZ3olU7fS7l8mDfDShr4kwuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681399169;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mG40i2zm3vZGS3htibJ+KR1FgLBJvqBG7htHHhKQLY8=;
        b=rKVmid54ByMlEe6NqPHEPYW1JlkHS7t7E3Np8JK15gcxQ0ar3cUZhiCOb3jg6xpGj/PE7h
        xhQHGPZyoU2NRAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67BDC1390E;
        Thu, 13 Apr 2023 15:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 69s9GYEdOGQaVgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 13 Apr 2023 15:19:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ADEBFA0732; Thu, 13 Apr 2023 17:19:28 +0200 (CEST)
Date:   Thu, 13 Apr 2023 17:19:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: update Kconfig comment
Message-ID: <20230413151928.cugxsv56eikx6fgb@quack3>
References: <20230413151412.30059-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413151412.30059-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 23:14:12, Yangtao Li wrote:
> f2fs support quota since commit 0abd675e97e6 ("f2fs: support plain
> user/group quota"), let's document it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/quota/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, I've added the patch to my tree.

								Honza

> 
> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index 1b3bc0a99515..9286037e1dbd 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -9,7 +9,7 @@ config QUOTA
>  	help
>  	  If you say Y here, you will be able to set per user limits for disk
>  	  usage (also called disk quotas). Currently, it works for the
> -	  ext2, ext3, ext4, jfs, ocfs2 and reiserfs file systems.
> +	  ext2, ext3, ext4, f2fs, jfs, ocfs2 and reiserfs file systems.
>  	  Note that gfs2 and xfs use their own quota system.
>  	  Ext3, ext4 and reiserfs also support journaled quotas for which
>  	  you don't need to run quotacheck(8) after an unclean shutdown.
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
