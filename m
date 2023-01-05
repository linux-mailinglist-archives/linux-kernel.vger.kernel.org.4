Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0265E9ED
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjAELad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjAELaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:30:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235613F6F;
        Thu,  5 Jan 2023 03:30:20 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C8E486C21D;
        Thu,  5 Jan 2023 11:30:15 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B187513338;
        Thu,  5 Jan 2023 11:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fdx3K8e0tmNJMQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 05 Jan 2023 11:30:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3CD3AA0742; Thu,  5 Jan 2023 12:30:15 +0100 (CET)
Date:   Thu, 5 Jan 2023 12:30:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, Jan Kara <jack@suse.com>
Subject: Re: [PATCH rcu 21/27] fs/quota: Remove "select SRCU"
Message-ID: <20230105113015.6f3ikdgmnhweoish@quack3>
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-21-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105003813.1770367-21-paulmck@kernel.org>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.40
X-Spamd-Result: default: False [0.40 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-01-23 16:38:07, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Jan Kara <jack@suse.com>
> ---
>  fs/quota/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Sure. You can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index b59cd172b5f97..d5a85a8062d05 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -6,7 +6,6 @@
>  config QUOTA
>  	bool "Quota support"
>  	select QUOTACTL
> -	select SRCU
>  	help
>  	  If you say Y here, you will be able to set per user limits for disk
>  	  usage (also called disk quotas). Currently, it works for the
> -- 
> 2.31.1.189.g2e36527f23
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
