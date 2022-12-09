Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAB648589
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 16:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiLIP3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 10:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiLIP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 10:29:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80159D4A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 07:29:04 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2B9FSZaj020387;
        Fri, 9 Dec 2022 16:28:35 +0100
Date:   Fri, 9 Dec 2022 16:28:35 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] add s390 support to nolibc and rcutorture
Message-ID: <20221209152835.GC19965@1wt.eu>
References: <20221209141939.3634586-1-svens@linux.ibm.com>
 <20221209150325.GX4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209150325.GX4001@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 07:03:25AM -0800, Paul E. McKenney wrote:
> On Fri, Dec 09, 2022 at 03:19:34PM +0100, Sven Schnelle wrote:
> > Hi,
> > 
> > these patches add support for the s390 architecture both to nolibc
> > and rcutorture. Note that this only adds support for the 64 bit
> > version, no support for 31 bit (compat) is added. For nolibc it
> > includes one bugfix to make the fd_set datatype match the kernel
> > type.
> 
> Nice!!!

indeed :-)

> The rcutorture patches look plausible to me, but I must defer to Willy
> Tarreau on the nolibc changes.

I had a very quick glance over them and nothing shocked me. I just want
to double-check the u32->long conversion with a careful eye but I'm happy
to see that your rcutorture binary continues its diet on more and more
architectures ;-)

Cheers,
Willy
