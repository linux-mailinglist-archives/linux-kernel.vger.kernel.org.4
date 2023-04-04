Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118A46D6F12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjDDVjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbjDDVjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:39:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8D40FF;
        Tue,  4 Apr 2023 14:39:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3BA411FDBE;
        Tue,  4 Apr 2023 21:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680644359;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6rnFBcBWfr2aiT8YSmtZUrPXOfzsUgPS2qkwzrhBQs=;
        b=Juq+gzubV1kWRI+fBWdnbjM58H1OERRfulwEMts4fHSuASfQ6Bv5GcNBosDDlj6v44k+FH
        YSaIOuVjmrWSPAWP8psqWWbYgFn8mcPY78ij01RsT+NQ3BSiOX6tMOxeQdoqy9rlhLQWBm
        1TVDUf0V/hGk4KQxFn4f9W/78Dx0wE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680644359;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c6rnFBcBWfr2aiT8YSmtZUrPXOfzsUgPS2qkwzrhBQs=;
        b=ujFyYHLB72/95xHjjUrl1gOKROPgRo1Zmn5OLJ7fk9tgPzotZGvKHOiVFGqPvThXoxtKY2
        ke/9GUrfIP3HAvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D42713920;
        Tue,  4 Apr 2023 21:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tiFWAgeZLGS+LQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 04 Apr 2023 21:39:19 +0000
Date:   Tue, 4 Apr 2023 23:39:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "Artem S. Tashkinov" <aros@gmx.com>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Introducing bugbot
Message-ID: <20230404213917.GG19619@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
 <022e2ef8-2a94-3109-ab90-9ee980915887@gmx.com>
 <20230404-uncrown-detonate-8bc1ac@meerkat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404-uncrown-detonate-8bc1ac@meerkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:35:34PM -0400, Konstantin Ryabitsev wrote:
> On Tue, Apr 04, 2023 at 04:16:08PM +0000, Artem S. Tashkinov wrote:
> > I love everything about what you've done except I've got a minor feature
> > request for the kernel bugzilla and this new workflow specifically.
> 
> Great to hear.
> 
> > Let's have a bot which polls open bug reports every 3-6 months with this
> > question:
> > 
> > "Is this still an issue in the current kernel? Please leave a comment or
> > this bug report will be closed due to inactivity".
> 
> I plan to do it slightly differently -- there will be a "housekeeping" command
> running daily that will auto-close bugs that haven't seen any activity for a
> defined period (90 days, for example), with a message like:
> 
> "This bug is now closed due to inactivity. Please reopen if this issue is
> still relevant with the latest kernel version."

Will there be a way to opt out of this? I'd rather see any bug closed
after an inspection from a human, I find the auto-close messages a bit
rude and I've read similar sentiment from others. The upstream bugzilla
is a best-effort level of support so it's true that bugs are left open
for months, sometimes years unfortunately, but I've seen many cases where
the report is valid or the "fix" is to improve documentation.

If we had enough people routinely going through the reports then some
sort of reminders would make sense but we don't. I take the bug
reports a task pool if there aren't more pressing things to do, which
may not be the same way how others use bugzilla.k.org so I'd be fine
with opting out of the auto-close or maybe out of any bugbot
interactions.
