Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370286E9C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjDTTCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDTTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:02:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DB1995
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 12:02:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A215219DF;
        Thu, 20 Apr 2023 19:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1682017370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyOpH1UnQrvVJw6kWYdzta6t/ke0kX3oYrzbrP5nCuQ=;
        b=v1d+3DaMAllHzLN5tsGSUp+ae/unfKhbqg+TQFsgWHC+t4iTyrrUgFOp5USdxySWmOnw88
        xrkk/1PF4C/qgKHJH2Q4s1IlBbXov5PXa3Mg8iea3F2Vl6oK7WhiygJvLuaVAbGnsc51xs
        1b2KHd6La1ccwopUyNu3ZglA21e9Sss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1682017370;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyOpH1UnQrvVJw6kWYdzta6t/ke0kX3oYrzbrP5nCuQ=;
        b=NNsgpZgAKDpS40EAM3z4xvLFkP2uLB+Pl1kG6ul1+v08CNRiszf8icDRDKzWCnWrD34DSU
        J/BuQwFuLRia8NCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDD0F1333C;
        Thu, 20 Apr 2023 19:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7lVxMVmMQWTKQgAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Apr 2023 19:02:49 +0000
Date:   Thu, 20 Apr 2023 21:02:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2023-04-16]
Message-ID: <20230420190239.GX19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
 <20230418182036.GS19619@suse.cz>
 <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjL7GG9s9Y2+u2725M+Ru=bUXnzOnXRwoSktY0fVdhhzw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 12:11:51PM -0700, Linus Torvalds wrote:
> On Tue, Apr 18, 2023 at 11:20 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > There's also in-memory cache of already trimmed ranges since last mount
> > so even running discard repeatedly (either fstrim or as mount option)
> > will not do extra IO. We try hard not to provoke the firmware bugs.

[...]

> Again, that's libata - odd crazy hardware. But it's exactly the odd
> crazy hardware that worries me. When the failure mode isn't "it's
> slow", but "it ATE MY WHOLE DISK", that's a scary scary problem.
> 
> Hmm?
> 
> I dunno. Maybe you have reason to believe that all of these cases have
> been fixed, or that some of these were caused by kernel bugs because
> we did things wrong, and those have been fixed.
> 
> But the failure modes just makes me worry. From your email, it *seems*
> like you think that the failures were primarily performance-related.

No, the main concern is if discard works without destroying data,
performance is more like an optimization. I too worry about buggy
hardware, we have a page just about that
https://btrfs.readthedocs.io/en/latest/Hardware.html .

I've taken notes from your reply and will enhance the page, or page
about discard in particular. The info about device quirks/horkage could
be linked too or I thought about generating a static page from the
per-bus tables so it's on one page.

I'll send pull request with fixes for the regression.
