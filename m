Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C11865B35B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbjABOd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjABOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:33:25 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CBAF627E;
        Mon,  2 Jan 2023 06:33:22 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 302EX2pP032291;
        Mon, 2 Jan 2023 15:33:02 +0100
Date:   Mon, 2 Jan 2023 15:33:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] add s390 support to nolibc and rcutorture
Message-ID: <20230102143302.GF29287@1wt.eu>
References: <20230102105112.1661651-1-svens@linux.ibm.com>
 <20230102110252.GE29287@1wt.eu>
 <yt9d358trpcx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d358trpcx.fsf@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 03:19:10PM +0100, Sven Schnelle wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > On Mon, Jan 02, 2023 at 11:51:07AM +0100, Sven Schnelle wrote:
> >> Hi,
> >> 
> >> these patches add support for the s390 architecture both to nolibc
> >> and rcutorture. Note that this only adds support for the 64 bit
> >> version, no support for 31 bit (compat) is added. For nolibc it
> >> includes one bugfix to make the fd_set datatype match the kernel
> >> type.
> >> 
> >> Changes in v2:
> >> 
> >> - use __attribute__((unused)) instead of __maybe_unused
> >> - prefer aghi over lay, as lay is not present in all architecure levels
> >> - add -m64 CFLAG to force 64 bit mode for compiler that can do 31bit and 64bit mode
> >
> > Excellent, now works out of the box for me, thank you Sven!.
> >
> > Paul, would you mind taking these ones for your dev branch instead
> > of the previous ones ?
> 
> Hrm, while looking at the code to make the adjustments for the auxv
> stuff, i noted that the envp handling in the startup code is wrong. So i
> have to fix that and send a v3 of the patchset.

OK thank you for letting us know!

Willy

