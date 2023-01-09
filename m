Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7166221A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbjAIJw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbjAIJvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:51:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090FD12D2E;
        Mon,  9 Jan 2023 01:51:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9A2C377503;
        Mon,  9 Jan 2023 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673257865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3dpWY39isfQP0sdAp5OZ+ksSedF6ts93bX5mDxLgRNU=;
        b=xo2Dc7X0igItsb8uMulagOWyFVE9QbzvnOlAga3jVFhn4gTJRTGkp7RA0LpmV/E4Ej2DhT
        6Mx9FqrQRJ/05VoavCW6+GY0SKHg2f4Dqt/ZsAwJXOifG39JhQKTZzt8HO+KKVCIYwh1pQ
        5RuK/ZaInk/jzhEDqmnq5Eij+Zw+yAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673257865;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3dpWY39isfQP0sdAp5OZ+ksSedF6ts93bX5mDxLgRNU=;
        b=hK9+rN5/OIQTVQ+e/nlFnbbfuUpeP7w58Z+jDhh18VIuMj1eNbB0DnL8ec4+VN8KYbxpor
        0hqKKA/G0WdAauBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E1B613583;
        Mon,  9 Jan 2023 09:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XLemIonju2NYBAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Jan 2023 09:51:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19AD3A074D; Mon,  9 Jan 2023 10:51:05 +0100 (CET)
Date:   Mon, 9 Jan 2023 10:51:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the ext3 tree
Message-ID: <20230109095105.afvw25ntcvopgvub@quack3>
References: <20230108125156.30578c00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108125156.30578c00@canb.auug.org.au>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun 08-01-23 12:51:56, Stephen Rothwell wrote:
> The following commits are also in Linus Torvalds' tree as different commits
> (but the same patches):
> 
>   ae9e9c7ff062 ("udf: Fix extension of the last extent in the file")
>   6d5ab7c2f7cf ("udf: initialize newblock to 0")

Yes, I'm sorry for the trouble. Linus considered the whole original pull
request too intrusive for rc3 so I've just cherrypicked the easy standalone
fixes and sent a pull request for those. I've now rebased my for_next
branch on top of Linus' tree to get rid of the duplicates (nobody depends
on my tree and there's enough time before the merge window opens so it
should be fine). If there's a better process how to handle such situations,
please tell me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
