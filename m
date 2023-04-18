Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5956E6BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjDRSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjDRSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 14:20:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27252B46A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 11:20:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B16FA1FD66;
        Tue, 18 Apr 2023 18:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681842046;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi1TBo+SLJXa7yGshskQpukN+VXKieY/b9qu71iGCwY=;
        b=hyGS5hu5U1VVKKe6GQtxxHu+7a1xnQiPFeWKNPa0h9hVDI02F3uDp1mHuepnsXVKmPdkW0
        5I6hfXTrfYxCZb0nvfAGXLq3VfcuG11EjqUHWouvOf6FKF51CT4gxYTRCKzg2lzG7WDu99
        RY+9zcLU2wn4uMyTn/vX4G0FDUUCEpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681842046;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qi1TBo+SLJXa7yGshskQpukN+VXKieY/b9qu71iGCwY=;
        b=bL/xfliUBNa9Do8isD978jjg6+9tt+sz8vvpbsD4SXV7bP2lhqyc52s+svkQdIlwX8Zz0e
        vSitjE+RkigATNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F53213581;
        Tue, 18 Apr 2023 18:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T50PGn7fPmSFXQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 18 Apr 2023 18:20:46 +0000
Date:   Tue, 18 Apr 2023 20:20:37 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Regzbot (on behalf of Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, Rafael Wysocki <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Linux regressions report for mainline [2023-04-16]
Message-ID: <20230418182036.GS19619@suse.cz>
Reply-To: dsterba@suse.cz
References: <168166781352.1843526.278570500979918184@leemhuis.info>
 <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjQaxmXTR68VnEJvLgB=H2agMTrrF4EXkXT4Hbdf2ZuMQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 01:48:52PM -0700, Linus Torvalds wrote:
> On Sun, Apr 16, 2023 at 10:59 AM Regzbot (on behalf of Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> > Another issue from the 6.2 days still not fixed are a huge number of
> > DISCARD request on NVME devices with Btrfs caused by 63a7cb13071
> > ("btrfs: auto enable discard=async when possible") [1, 2].
> 
> Yeah, automatic discard is a broken idea, and that should just be reverted.
> 
> The number of devices that have *horrible* problems with discard is
> too high for any kind of "do discard by default" logic.
> 
> David, please don't do that. Just because discard happens to work well
> on some disk, *you* care about, does not in any way mean that "do
> discard by default" is sane.
> 
> Discard needs to be opt-in. Not out-opt.

What we've enabled is the async mode that waits and batches the ranges
to trim so it's in big chunks and it does not hammer the device with
short discard requests among other IO. The problems reported is due to
the throttling logic that was too slow to keep up after large freed
data. We have fixes for that.

There's also in-memory cache of already trimmed ranges since last mount
so even running discard repeatedly (either fstrim or as mount option)
will not do extra IO. We try hard not to provoke the firmware bugs.

The request to make it default came from Fedora guys, we're not pushing
defaults just because it works on somebody's newest hardware. Feature
introduced in 5.6, enabled in 6.2 provides time to let people test it
and report bugs. Of course we can't cover all different types of
hardware so changing defaults for everyone comes with a risk. I've
scanned IRC logs for feedback related to the discard=async, the
community there tends to be from the more technical users that do try
new things and report back. This is usually a good sample.

- https://pagure.io/fedora-btrfs/project/issue/6
- https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/t/#u

Opt-in yes ideally with information available at least to end users
about which devices are safe and which to avoid. This is sadly
nonexistent, we get only broad claims that "don't do that on old
device", vaguely mentioning some vendors and not on record for legal
reasons. There are posts on some forums about bad vendor/model or if
it's really bad then it hits the news sites as well.

- https://www.truenas.com/community/threads/ssd-install-failures-possible-trim-issue.56162/

> The number of devices that have horrible problems with discard is too
> high for any kind of “do discard by default” logic.

As you state it, I would be concerned about enabling discard on any
device and not even the widely configured weekly fstrim jobs. If the
number of the affected devices is too high, please show me where is the
evidence for that. I've been searching web for that now and back then,
the mailing list archives, the in-tree quirk tables. The MMC has a
specific quirk MMC_QUIRK_TRIM_BROKEN, some SATA devices used to require
ncq=1 set which in turn made it to the quirk tables, NVMe has an
impressive list of quirks but not related to discard.

I'm genuinely interested, this can only improve the shared knowledge. I
hope we won't end up reverting it just "because Linus said so".
