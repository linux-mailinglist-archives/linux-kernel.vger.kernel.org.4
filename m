Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5042F682C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAaMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjAaMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:23:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B013A90;
        Tue, 31 Jan 2023 04:23:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78B3F2038F;
        Tue, 31 Jan 2023 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675167797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OehRyuo+VcKrzg4xlXQWaR0lEXjv3Oh1VfztNYQkhMo=;
        b=IRKVWjGBdsb+jzaWicK9ketoVps1vde8vuBbuvuwDayabs7lOeRhNFV54+YK32/ULLHavo
        ndYbzst38dcFexvE0xoaqTFCtI5iWYyeX4whFaBiffzuM9Vdimb0RrX7qszmLJM3jBYPKh
        vgSkjJhEQzZlsN5nUFreCeccBuejSUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675167797;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OehRyuo+VcKrzg4xlXQWaR0lEXjv3Oh1VfztNYQkhMo=;
        b=dNBkZIbtrTjZaczJqdL9yIXGp2kwX4OiNZ2TYYHBRdrMtM4gs+wpuu2brD7hxwnHz1K2dn
        2M0xJW1yctZAf5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E00F13585;
        Tue, 31 Jan 2023 12:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9j84DjUI2WN3CQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Jan 2023 12:23:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B8D08A06D5; Tue, 31 Jan 2023 13:23:14 +0100 (CET)
Date:   Tue, 31 Jan 2023 13:23:14 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the mm tree
Message-ID: <20230131122314.umasrmx2hwe2epdx@quack3>
References: <20230131145654.768c6149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131145654.768c6149@canb.auug.org.au>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue 31-01-23 14:56:54, Stephen Rothwell wrote:
> The following commit is also in the ext3 tree as a different commit
> (but the same patch):
> 
>   05a4851d2729 ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")
> 
> This is commit
> 
>   7010839ccfd4 ("fs: gracefully handle ->get_block not mapping bh in __mpage_writepage")
> 
> in the ext3 tree.

Yes, as we already discussed with Andrew, I've merged the patch to my tree
because otherwise UDF fixes result in triggering this problem and crashing
machine left-and-right (which results in a flood of emails from testing
infrastructure). So carrying the patch in my tree seems like by far
the simplest option (otherwise I'd have to either rebase on top of MM tree
or pull MM tree into my tree, neither of which looks particularly
attractive).
								Honza

[1] https://lore.kernel.org/all/20230127133213.su4cl6zuiuuv2p35@quack3

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
