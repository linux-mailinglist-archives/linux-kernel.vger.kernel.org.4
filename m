Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE96E21D6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDNLOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNLOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:14:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E076A7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:14:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 34225219C4;
        Fri, 14 Apr 2023 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681470845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09HEENaNVyDpRX7bYgQvh45dwM5kHY2AkiPLq6widu4=;
        b=JlXqRUePG2y58Q2VQVW3hI8wKyrPXMdzehWAO7A3uMbh3cZ8lVbUAiSV1ZtGrNLCVMJuIY
        zNPFHRoJPRMA7+K7Nhzg37csSgKGfMFzYlerNoYP4Z001D26Ueu92ysZHxdFOg2RvAl7WF
        C9VSWiOThPs6NdBV5YREtOaJZuHFOsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681470845;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09HEENaNVyDpRX7bYgQvh45dwM5kHY2AkiPLq6widu4=;
        b=zEw7XDCiRux/TNCU4gCE3451ngH3a/Ynr7D7+ia1IpbXM1382QRaC/7xHpoYB5MAo9mc3o
        n6Sh7ZQ3rdn9iVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 224B213498;
        Fri, 14 Apr 2023 11:14:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OudQCH01OWTNQAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 14 Apr 2023 11:14:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A24EAA0732; Fri, 14 Apr 2023 13:14:04 +0200 (CEST)
Date:   Fri, 14 Apr 2023 13:14:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: mark PRINT_QUOTA_WARNING as BROKEN
Message-ID: <20230414111404.cohbcdy6nmgigaga@quack3>
References: <20230413163833.43913-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413163833.43913-1-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-04-23 00:38:32, Yangtao Li wrote:
> User should use notification via netlink socket. PRINT_QUOTA_WARNING is
> deprecated since commit 8e8934695dfd ("quota: send messages
> via netlink"), so mark it as BROKEN.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Thanks. I've merged the patch (with somewhat updated changelog) to my tree.

								Honza

> ---
>  fs/quota/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/quota/Kconfig b/fs/quota/Kconfig
> index d5a85a8062d0..10e9a0efc6c2 100644
> --- a/fs/quota/Kconfig
> +++ b/fs/quota/Kconfig
> @@ -28,7 +28,7 @@ config QUOTA_NETLINK_INTERFACE
>  
>  config PRINT_QUOTA_WARNING
>  	bool "Print quota warnings to console (OBSOLETE)"
> -	depends on QUOTA
> +	depends on QUOTA && BROKEN
>  	default y
>  	help
>  	  If you say Y here, quota warnings (about exceeding softlimit, reaching
> -- 
> 2.35.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
