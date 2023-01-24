Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC5678EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjAXDMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjAXDL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:11:59 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABA1D25297
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 19:11:57 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30O3Blfn017895;
        Tue, 24 Jan 2023 04:11:47 +0100
Date:   Tue, 24 Jan 2023 04:11:47 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH RFC] tools/nolibc: Add gitignore to avoid git complaints
 about sysroot
Message-ID: <20230124031147.GA17865@1wt.eu>
References: <20230124004707.GA318943@paulmck-ThinkPad-P17-Gen-1>
 <Y88u+KnrxjrC+NBe@biznet-home.integral.gnuweeb.org>
 <20230124011257.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y88xjSd2ZIpVIeHd@biznet-home.integral.gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y88xjSd2ZIpVIeHd@biznet-home.integral.gnuweeb.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 08:17:01AM +0700, Ammar Faizi wrote:
> On Mon, Jan 23, 2023 at 05:12:57PM -0800, Paul E. McKenney wrote:
> > On Tue, Jan 24, 2023 at 08:06:00AM +0700, Ammar Faizi wrote:
> > > On Mon, Jan 23, 2023 at 04:47:07PM -0800, Paul E. McKenney wrote:
> > > > Testing of nolibc can produce a tools/include/nolibc/sysroot file, which
> > > > is not known to git.  Because it is automatically generated, there is no
> > > > reason for it to be known to git.  Therefore, add a .gitignore to remove
> > > > it from git's field of view.
> > > 
> > > Yeah, I hit the same "git status" complaint and have a pending patch
> > > for that too:
> > > 
> > > https://github.com/ammarfaizi2/linux-block/commit/89bfe86a03c173863de12.patch
> > > 
> > > ^ I'll drop this one.
> > 
> > Actually, why don't we take yours?  Either way, I have to change something
> > per your feedback below.
> > 
> > No hurry, send it along when you normally would have.
> 
> OK, I'll keep it then. Will send it together with my other patches later :-)

Sorry, I didn't notice it previously. Ack from me for either of your
patches of course. Ammar, please note that Paul's subject is a bit more
descriptive, so please consider updating when you resend.

Thanks!
Willy
