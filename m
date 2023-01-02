Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C965AF12
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjABJxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjABJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:52:42 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5301311
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:50:58 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3029oduU030521;
        Mon, 2 Jan 2023 10:50:39 +0100
Date:   Mon, 2 Jan 2023 10:50:39 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com
Subject: Re: [PATCH 2/5] nolibc: add support for s390
Message-ID: <20230102095039.GD29287@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209141939.3634586-3-svens@linux.ibm.com>
 <20221227213530.GA6390@1wt.eu>
 <yt9dilhpjqpr.fsf@linux.ibm.com>
 <20230102084122.GB29287@1wt.eu>
 <yt9dedsdjn6z.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dedsdjn6z.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 10:33:08AM +0100, Sven Schnelle wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > On Mon, Jan 02, 2023 at 09:17:04AM +0100, Sven Schnelle wrote:
> >> The kernel compiles with z10 as minimum architecture, so
> >> i'm leaning towards enforcing the same arch for nolibc. What do you think?
> >
> > Sure, as long as this works for most users, that's likely fine.
> > Alternately, are there equivalent sequences of instructions that achieve
> > the same on older architectures, and would that be relevant ?
> 
> Well, it's only one instruction that needs to be changed - we could also
> use aghi to do the same thing. Maybe that's better.
> 
> Also i will add -m64 to the testing Makefile, it shouldn't hurt.
> 
> > One future improvement I'll need will be to store the envp value into a
> > global "environ" variable, and run over it to catch the pointer that
> > follows the NULL and save it into the "_auxv" variable. I've done it for
> > all other archs here already:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/log/?h=20221227-nolibc-weak-4
> >
> > I'll give it a try once I'm able to build and test your code, and may
> > ask you for some help if I don't succeed in doing it. If you want to do
> > it yourself, please have a look at the last commits adding environ and
> > auxv to any arch of your choice, such as x86_64.
> 
> Ok, thanks for the Heads-Up. I'll take a look. I think i would send this
> as a separate Patch, so we get the initial support done first if that's ok.

Yes absolutely, that was also my intent. I have not yet submitted this
series.

Thanks!
Willy
