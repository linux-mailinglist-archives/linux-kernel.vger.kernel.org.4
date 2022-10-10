Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6105FA370
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJJShr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 14:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJJShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 14:37:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E41C20BC0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 11:37:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FEC4B8104A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 18:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6AC433C1;
        Mon, 10 Oct 2022 18:37:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EIX/T0z4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665427054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D1Nra9UGnOC3bDzVRFEpBnNHUeEKRv+pNgYnTsiPthE=;
        b=EIX/T0z4rMxk4elnMjC8Th2oDb8T7IBKhVqllK37S6JxmIafVfrQW60KzX72SB+VZ6sloz
        s8Y6WX1yGs+dW0SvVJT22rvciGAt7VoL57e6MMd91O+Xe4UipLgWVCWRPpEW/5/Dl6TTXE
        uJj3qADsO3Ugx9Vfxgz/wSgXq4aTRsM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4aaa09a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 10 Oct 2022 18:37:34 +0000 (UTC)
Date:   Mon, 10 Oct 2022 12:37:33 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] random number generator updates for 6.1-rc1
Message-ID: <Y0RmbbQNQ/ChrAjl@zx2c4.com>
References: <20221003174431.1189919-1-Jason@zx2c4.com>
 <CAHk-=whoPebQJqtSb+8by4o5pHKCPaUzMkbFp5_EjKuo3dxBUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whoPebQJqtSb+8by4o5pHKCPaUzMkbFp5_EjKuo3dxBUg@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Oct 10, 2022 at 10:56:16AM -0700, Linus Torvalds wrote:
> On Mon, Oct 3, 2022 at 10:45 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> >   Merge tag 'net-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2022-09-22 10:58:13 -0700)
> >
> > for you to fetch changes up to d687772e6d2cbffd91fdda64812f79192c1e7ca0:
> >
> >   random: fix typos in get_random_bytes() comment (2022-10-01 23:37:51 +0200)
> 
> Oh, and I notice that since you sent your pull request, you've updated
> that tag with a new commit for a fix.
> 
> That's fine, and hey, it took me a while to get to this pull request.
> 
> But I do wish you had notified me (a follow-up email just saying "hey,
> that tag got updated for a fix" is fine for a small change like this,
> a new pull request saying "this supercedes the previous one is
> preferred for anything bigger), if only because the difference in what
> I pull and what gets described makes me then go back and lok "what
> exactly happened here?".

Hah! Welp. I went back and forth in my mind all week over this, whether
to bother you, or just to see what happens. I was thinking that either
you'd notice, and not care, a script would pull until the "up to commit"
and leave that off, or the whole thing would explode. Anyway, I'll let
you know if that happens again. I've been reading tea leaves every day
trying to divine when you'd actually merge this. :)

This all reminds me: I've got some other changes staged, which I think I
might do for 6.1, which involve some treewide cleanups and some
coccinelle. My approximate plan was to rebase those patches on your
merge of this pull, add the additional conversions due to code not
currently in my tree, and then send you a pull based on that at the end
of the week. Does that seem like a reasonably strategy? Or should I wait
until after rc1? Or something else?

Jason
