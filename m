Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715496E1186
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDMP5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDMP53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:57:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C49EE3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:57:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87E0E1FD66;
        Thu, 13 Apr 2023 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681401426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBwi1yRHBm7pRIVPlzb249OVTEmSayyMyhLtJn+ArrA=;
        b=CUweODYTGOIMHVCOupHphoWQ0ETaktxHpBgU6Ibi1F/ZJCPq5OfGoNtIpJj9Q7rBpRAbeU
        NwHBtb/yukXJibosGLc5mME+EWYXWWOeLfo2YWOGbNn07xsKGtW9+hkhF0E3T2ZefOC6OP
        t8xGIEFx40wUBKn/GD7a8mmdMqO2Sts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681401426;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NBwi1yRHBm7pRIVPlzb249OVTEmSayyMyhLtJn+ArrA=;
        b=pTMkRK3qn3QZVqPupNg25NrlA0FdK6eSFbdgToYQYhc356j1NpFCldsVdWiUDp/vtcV3YW
        rZA7cg0tZoWGxpCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B99213421;
        Thu, 13 Apr 2023 15:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VetAGlImOGT1aQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 13 Apr 2023 15:57:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A54A7A0732; Thu, 13 Apr 2023 17:57:05 +0200 (CEST)
Date:   Thu, 13 Apr 2023 17:57:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: remove PRINT_QUOTA_WARNING support
Message-ID: <20230413155705.cgmkdveu6gw7f7ii@quack3>
References: <20230413144557.20700-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413144557.20700-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-04-23 22:45:57, Yangtao Li wrote:
> It's deprecated since commit 8e8934695dfd ("quota: send messages
> via netlink"), so let's remove it. User should use notification via
> netlink socket instead.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Yeah, but frankly I'm not sure whether there are not people still relying
on this. In particular distributions still seem to enable this config
option in their kernels. So rather than removing this config right away, we
could maybe make it depend on CONFIG_BROKEN and see who complains...

								Honza

> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index d5a85a8062d0..1b3bc0a99515 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -26,16 +26,6 @@ config QUOTA_NETLINK_INTERFACE
>  	  hardlimit, etc.) will be reported through netlink interface. If unsure,
>  	  say Y.
>  
> -config PRINT_QUOTA_WARNING
> -	bool "Print quota warnings to console (OBSOLETE)"
> -	depends on QUOTA
> -	default y
> -	help
> -	  If you say Y here, quota warnings (about exceeding softlimit, reaching
> -	  hardlimit, etc.) will be printed to the process' controlling terminal.
> -	  Note that this behavior is currently deprecated and may go away in
> -	  future. Please use notification via netlink socket instead.
> -
>  config QUOTA_DEBUG
>  	bool "Additional quota sanity checks"
>  	depends on QUOTA
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index a6357f728034..10b46c403bdb 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -154,7 +154,7 @@ void __quota_error(struct super_block *sb, const char *func,
>  }
>  EXPORT_SYMBOL(__quota_error);
>  
> -#if defined(CONFIG_QUOTA_DEBUG) || defined(CONFIG_PRINT_QUOTA_WARNING)
> +#if defined(CONFIG_QUOTA_DEBUG)
>  static char *quotatypes[] = INITQFNAMES;
>  #endif
>  static struct quota_format_type *quota_formats;	/* List of registered formats */
> @@ -1171,72 +1171,6 @@ static int warning_issued(struct dquot *dquot, const int warntype)
>  	return test_and_set_bit(flag, &dquot->dq_flags);
>  }
>  
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -static int flag_print_warnings = 1;
> -
> -static int need_print_warning(struct dquot_warn *warn)
> -{
> -	if (!flag_print_warnings)
> -		return 0;
> -
> -	switch (warn->w_dq_id.type) {
> -		case USRQUOTA:
> -			return uid_eq(current_fsuid(), warn->w_dq_id.uid);
> -		case GRPQUOTA:
> -			return in_group_p(warn->w_dq_id.gid);
> -		case PRJQUOTA:
> -			return 1;
> -	}
> -	return 0;
> -}
> -
> -/* Print warning to user which exceeded quota */
> -static void print_warning(struct dquot_warn *warn)
> -{
> -	char *msg = NULL;
> -	struct tty_struct *tty;
> -	int warntype = warn->w_type;
> -
> -	if (warntype == QUOTA_NL_IHARDBELOW ||
> -	    warntype == QUOTA_NL_ISOFTBELOW ||
> -	    warntype == QUOTA_NL_BHARDBELOW ||
> -	    warntype == QUOTA_NL_BSOFTBELOW || !need_print_warning(warn))
> -		return;
> -
> -	tty = get_current_tty();
> -	if (!tty)
> -		return;
> -	tty_write_message(tty, warn->w_sb->s_id);
> -	if (warntype == QUOTA_NL_ISOFTWARN || warntype == QUOTA_NL_BSOFTWARN)
> -		tty_write_message(tty, ": warning, ");
> -	else
> -		tty_write_message(tty, ": write failed, ");
> -	tty_write_message(tty, quotatypes[warn->w_dq_id.type]);
> -	switch (warntype) {
> -		case QUOTA_NL_IHARDWARN:
> -			msg = " file limit reached.\r\n";
> -			break;
> -		case QUOTA_NL_ISOFTLONGWARN:
> -			msg = " file quota exceeded too long.\r\n";
> -			break;
> -		case QUOTA_NL_ISOFTWARN:
> -			msg = " file quota exceeded.\r\n";
> -			break;
> -		case QUOTA_NL_BHARDWARN:
> -			msg = " block limit reached.\r\n";
> -			break;
> -		case QUOTA_NL_BSOFTLONGWARN:
> -			msg = " block quota exceeded too long.\r\n";
> -			break;
> -		case QUOTA_NL_BSOFTWARN:
> -			msg = " block quota exceeded.\r\n";
> -			break;
> -	}
> -	tty_write_message(tty, msg);
> -	tty_kref_put(tty);
> -}
> -#endif
> -
>  static void prepare_warning(struct dquot_warn *warn, struct dquot *dquot,
>  			    int warntype)
>  {
> @@ -1259,9 +1193,6 @@ static void flush_warnings(struct dquot_warn *warn)
>  	for (i = 0; i < MAXQUOTAS; i++) {
>  		if (warn[i].w_type == QUOTA_NL_NOWARN)
>  			continue;
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -		print_warning(&warn[i]);
> -#endif
>  		quota_send_warning(warn[i].w_dq_id,
>  				   warn[i].w_sb->s_dev, warn[i].w_type);
>  	}
> @@ -2936,15 +2867,6 @@ static struct ctl_table fs_dqstats_table[] = {
>  		.mode		= 0444,
>  		.proc_handler	= do_proc_dqstats,
>  	},
> -#ifdef CONFIG_PRINT_QUOTA_WARNING
> -	{
> -		.procname	= "warnings",
> -		.data		= &flag_print_warnings,
> -		.maxlen		= sizeof(int),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec,
> -	},
> -#endif
>  	{ },
>  };
>  
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
