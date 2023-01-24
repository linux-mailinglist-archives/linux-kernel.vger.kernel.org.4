Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4322A678D25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjAXBNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjAXBNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:13:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA024728E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:13:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 921D2B80F96
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31971C433EF;
        Tue, 24 Jan 2023 01:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674522778;
        bh=RMY4of4Vz5+VejlZ5CDDcVfA7ToAWDCen5hbt7uQLbc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ENGqYuErMjXvkFZovo8yvw9ME0/aKxXogpd/yROmSrrI2zELkDTaC8MKzyVeEgbTN
         6XnK3FA/i7//1d/sulJFkYuboVApdBZokgY7V70Fyf95fk6aBHfQdL6Dm7uLiC8Uhg
         8E4k7iBhywpDPTImXAdxhc+//DeSO+66jFyFGwUJWDcvJLUv6Md0OKMkpIkjPJJbNN
         wmt34XPsbAeLxxguymlFoX+NhFQ3j5TZR7zC5lbsNCpeOAhiBso64i/EEMAAmMP8nv
         PbAqgc9sGd/Z8fpWfG0O5ZfwDj1aM8f0UneI+gEaZ/vhjL0muMwy0DWRYvOYUskkxA
         frYsGey4oLmmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id AD16A5C0865; Mon, 23 Jan 2023 17:12:57 -0800 (PST)
Date:   Mon, 23 Jan 2023 17:12:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH RFC] tools/nolibc: Add gitignore to avoid git complaints
 about sysroot
Message-ID: <20230124011257.GC2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
 <Y88u+KnrxjrC+NBe@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y88u+KnrxjrC+NBe@biznet-home.integral.gnuweeb.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:06:00AM +0700, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 04:47:07PM -0800, Paul E. McKenney wrote:
> > Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
> > is not known to git.  Because it is automatically generated, there is no
> > reason for it to be known to git.  Therefore, add a .gitignore to remove
> > it from git's field of view.
> 
> Yeah, I hit the same "git status" complaint and have a pending patch
> for that too:
> 
> https://github.com/ammarfaizi2/linux-block/commit/89bfe86a03c173863de12.patch
> 
> ^ I'll drop this one.

Actually, why don't we take yours?  Either way, I have to change something
per your feedback below.

No hurry, send it along when you normally would have.

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Willy Tarreau <w@1wt.eu>
> > Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > 
> > diff --git a/tools/include/nolibc/.gitignore b/tools/include/nolibc/.gitignore
> > new file mode 100644
> > index 0000000000000..dea22eaaed2ba
> > --- /dev/null
> > +++ b/tools/include/nolibc/.gitignore
> > @@ -0,0 +1 @@
> > +sysroot
> 
> Small nit about the naming, not so much important, but the common
> pattern for directory has a trailing slash. So, I would write
> "sysroot/".
> 
> ".gitignore" and "tools/testing/selftests/.gitignore" do that too :-)
> 
> Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> 
> Thanks!
> 
> -- 
> Ammar Faizi
> 
