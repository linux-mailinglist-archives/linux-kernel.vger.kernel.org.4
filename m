Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BE26A0EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjBWRaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBWRaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:30:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D4570A3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:30:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE6F65D9BF;
        Thu, 23 Feb 2023 17:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677173400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GfD7bVI37Hoten2JJxqaA5DYKUJRjUgORtyVUH4ACFU=;
        b=MpwUzLjQnKBehag874uU2dxJQZU3M1AtVM0EGiXceD+WpkQfCzXPvbppMLlEFth+Mh0Sp6
        T2hDOF9Ndkt3RzaoxW0UW+/4YPlf59SBkSDhX4onjeF+Fqwq995tMd+yGVon/pi9V7lOxu
        erkb4J1WqxZSV0EW+WFn9VUfH7mzhZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677173400;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GfD7bVI37Hoten2JJxqaA5DYKUJRjUgORtyVUH4ACFU=;
        b=+/ToPFoO4p+tOcuI7IwO8Yxghyeo7tXa6VgiZVxISpZPCFPMbaDPY2+Y226QsXIvsaCB+k
        tRKbsqvTPvsopBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9801D139B5;
        Thu, 23 Feb 2023 17:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nkPgI5ii92NsBgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 23 Feb 2023 17:30:00 +0000
Date:   Thu, 23 Feb 2023 18:24:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/2] tty: ipwireless: move Kconfig entry to tty
Message-ID: <20230223172403.GW10580@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230222085013.32331-1-jirislaby@kernel.org>
 <86e99adb-eccd-4c78-8128-b3690aa559c9@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e99adb-eccd-4c78-8128-b3690aa559c9@app.fastmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 09:20:53AM +0100, Arnd Bergmann wrote:
> On Wed, Feb 22, 2023, at 09:50, Jiri Slaby (SUSE) wrote:
> > The ipwireless' Kconfig entry is currently sitting in char/pcmcia. But
> > the driver is in tty/. So move the entry to tty/ too.
> >
> > First, it makes sense to have the entry along the driver. Second, whole
> > char/pcmcia is about to pass away.
> >
> > Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: David Sterba <dsterba@suse.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This is clearly correct
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> In Dominik's list from
> https://lore.kernel.org/all/Y07d7rMvd5++85BJ@owl.dominikbrodowski.net/
> 
> he had listed this driver as 'some activity in 2021', but all I can
> find are treewide cleanups (mostly from you) after some work by David
> in 2008 and Dominik's own PCMCIA rework in 2010. My guess is that
> most likely this driver can be removed entirely, but you and David
> are the ones who know if there are still users.

The driver works and did not need any development, so the treewide or
minor bugfixes are understandable. I had some discussions with a user in
2011 regarding card detection but otherwise nothing. I can't tell how
many users are there, there are some IPWireless cards in second hand
market and cards for pcmcia can be bought in local shops.
I'd vote for keeping the driver as long as the pcmcia subsystem exists
(option a).
