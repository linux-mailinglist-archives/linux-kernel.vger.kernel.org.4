Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2076C9751
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCZSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZSAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:00:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63B5B88
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 11:00:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D2570CE0EA6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 18:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B35C433EF;
        Sun, 26 Mar 2023 18:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679853626;
        bh=HpEZtykGeKWR3lSUeO8IDIKb3LKCVG4yWYLo3kms3j4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=lyCB9ZYxXzBqL/CaUuGla2wgAcKXD7C14w7+3TvW37TG//z7kmiKajv/KCsSLek3o
         gY1oj4gnaLMkFhXeAhpJTrzS7uYsQb498rm44vCOKeasKTIJkoQVuCkQkbmNj21kUn
         HbgUvhfeV1/oSQ1+hQQluoDiO4DhltHNogcMaNp551MSu3FixlGeG1RpaEkzm16DAa
         BWjh0v4Lxutyni5xpwSwlGH6YtTHYoHc1MTRjMLCfZvyWL9ugdJHAqPQhvRvZmCjId
         Hi0OCqrL3GKUcPG8yYHsjtW6LimYYiq30Ny+oRiNKKTbthzLOe5EveJM9YfoLcFG0v
         YHkS5Ki9UJViA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 799A31540474; Sun, 26 Mar 2023 11:00:26 -0700 (PDT)
Date:   Sun, 26 Mar 2023 11:00:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <8927157b-bf2c-46b7-a385-f4e230a4777d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
 <a65340bb-2d11-445b-8595-9bf25a9f7a47@paulmck-laptop>
 <ZCBiDZfQW+YuiVNs@1wt.eu>
 <35a26245-0171-44b0-8072-325576768f91@paulmck-laptop>
 <ZCBkrOqWR7EVMeP/@1wt.eu>
 <d2c780bb-00ec-4966-87a2-d233f19032ab@paulmck-laptop>
 <ZCBsLQARaZBHeE4k@1wt.eu>
 <ZCBtOxqRJ9+P+G0z@1wt.eu>
 <ZCB5HZVbrjTM37Bd@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCB5HZVbrjTM37Bd@1wt.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 06:55:57PM +0200, Willy Tarreau wrote:
> On Sun, Mar 26, 2023 at 06:05:15PM +0200, Willy Tarreau wrote:
> > On Sun, Mar 26, 2023 at 06:00:45PM +0200, Willy Tarreau wrote:
> > > On Sun, Mar 26, 2023 at 08:45:55AM -0700, Paul E. McKenney wrote:
> > > > Glad I could "help"!  Timers.  Huh.  ;-)
> > > > 
> > > > Checking v6.2, though the rebase is a bit messy, so I won't be all
> > > > that confident in the results.
> > > 
> > > I got the same as you now. I don't know what I missed before not to
> > > face it, maybe it's the consequence of the rebase. I've re-applied
> > > the patches on top of 6.2.8 and am retesting now.
> > > 
> > > I think you don't need to waste more of your time on this for now
> > > since we have a reproducer. Thomas and I should take over.
> > 
> > And it's a 6.3 regression, as 6.2.8 works fine:
> > 
> >   $ make run
> >   (...)
> >   Kernel: arch/x86/boot/bzImage is ready  (#2)
> >   make[1]: Leaving directory '/g/public/linux/master'
> >   126 test(s) passed.
> >   $ tail  run.out 
> >   Errors during this test: 0
> >   
> >   Running test 'protection'
> >   0 -fstackprotector                                               [OK]
> >   Errors during this test: 0
> >   
> >   Total number of errors: 0
> >   Leaving init with final status: 0
> >   [    3.388706] ACPI: PM: Preparing to enter system sleep state S5
> >   [    3.389424] reboot: Power down
> > 
> > Now let's have fun bisecting it!
> 
> So I have a good news, 6.3-rc1 which dev.2023.03.20a is based on, fails,
> while 6.3-rc3 works. I haven't got further yet and am not sure it's useful
> to dig further given that it's an already fixed problem that is not related
> to the patches in your branch. I don't know if you usually rebase on more
> recent tags though.

Thank you for chasing this down!

In this case, I will at the very least merge with v6.3 before testing.
I have Joel Fernandes and Boqun Feng trying their hands at running
the RCU pull request for v6.4, so I will probably resist the urge to
inject confusion by rebasing onto v6.3-rc1.  ;-)

							Thanx, Paul
