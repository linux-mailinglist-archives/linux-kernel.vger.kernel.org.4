Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367F6695C4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241402AbjAMLiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjAMLhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:37:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D414019;
        Fri, 13 Jan 2023 03:26:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D5ED6ACFE;
        Fri, 13 Jan 2023 11:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673609189;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOg9jIs+YlxfzRJ2HLM5rvcF9/BHEDyYH4eLa34v64Y=;
        b=HodNWU1PyXH8GzPfltlGook/HBsuXMPJTR6KzrbL/EUQmeu1Ywkb2HE7vbK4bfeef94O0z
        D0Vv2NIGSbXbQKpPQUdKZi7Unc2RgwX4T6bWQqM3bgXXueFPM7bpDlHLAjfPughjnagl36
        K6pzMWGX2SbZLEvrCeucf0MWJyF9GHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673609189;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xOg9jIs+YlxfzRJ2HLM5rvcF9/BHEDyYH4eLa34v64Y=;
        b=bRbef9FrfsP6d2qJrTA+NHv6ir/2DVzyNgrxTvkESIhcO572zAoulafLjG7CGhAYTC+om7
        B+GZ9u4eG2mgqVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B3D11358A;
        Fri, 13 Jan 2023 11:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +upSFeU/wWNvMwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 13 Jan 2023 11:26:29 +0000
Date:   Fri, 13 Jan 2023 12:20:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the btrfs tree
Message-ID: <20230113112053.GT11562@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230113102707.649f0938@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113102707.649f0938@canb.auug.org.au>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:27:07AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are duplicated in the btrfs tre and also in the
> btrfs-fixes tree as different commits (but the same patches):
> 
>   6d3d970b2735 ("btrfs: fix missing error handling when logging directory items")
>   8bb6898da627 ("btrfs: fix directory logging due to race with concurrent index key deletion")
>   94cd63ae6799 ("btrfs: add missing setup of log for full commit at add_conflicting_inode()")
>   16199ad9eb6d ("btrfs: do not abort transaction on failure to write log tree when syncing log")
>   09e44868f1e0 ("btrfs: do not abort transaction on failure to update log root")
> 
> and
> 
>   18c166730923 ("btrfs: fix missing error handling when logging directory items")
>   5c7eafa405c4 ("btrfs: fix directory logging due to race with concurrent index key deletion")
>   db260d6a0abb ("btrfs: add missing setup of log for full commit at add_conflicting_inode()")
>   ab6e0ba0377d ("btrfs: do not abort transaction on failure to write log tree when syncing log")
>   40c7d0525fcd ("btrfs: do not abort transaction on failure to update log root")
> 
> in the btrfs tree and
> 
>   8ba46a395c7f ("btrfs: fix missing error handling when logging directory items")
>   46fc636870f4 ("btrfs: fix directory logging due to race with concurrent index key deletion")
>   52bd17801bcb ("btrfs: add missing setup of log for full commit at add_conflicting_inode()")
>   3d223cb5a2f7 ("btrfs: do not abort transaction on failure to write log tree when syncing log")
>   b8a4b882f62c ("btrfs: do not abort transaction on failure to update log root")
> 
> in the btrfs-fixes tree.

Will be fixed in next for-next snapshot, some of the merged branches
weren't properly refreshed.
