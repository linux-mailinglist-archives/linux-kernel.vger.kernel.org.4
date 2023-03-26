Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217FD6C92BB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCZGUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 02:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCZGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 02:20:50 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDFCE40FD
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 23:20:47 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 32Q6Kf62008489;
        Sun, 26 Mar 2023 08:20:41 +0200
Date:   Sun, 26 Mar 2023 08:20:41 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] tools/nolibc: add support for stack protector
Message-ID: <ZB/kOb8bl390wBwS@1wt.eu>
References: <20230325154516.7995-1-w@1wt.eu>
 <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d9bbc94-7ea2-4bc5-8523-29b100c0f1a1@paulmck-laptop>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 09:36:28PM -0700, Paul E. McKenney wrote:
> On Sat, Mar 25, 2023 at 04:45:08PM +0100, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > This is essentially Thomas' work so instead of paraphrasing his work,
> > I'm pasting his description below. I've tested his changes on all
> > supported archs, applied a tiny modification with his permission
> > to continue to support passing CFLAGS, and for me this is all fine.
> > In a short summary this adds support for stack protector to i386 and
> > x86_64 in nolibc, and the accompanying test to the selftest program.
> > 
> > A new test category was added, "protection", which currently has a
> > single test. Archs that support it will report "OK" there and those
> > that do not will report "SKIPPED", as is already the case for tests
> > that cannot be run.
> > 
> > This was applied on top of your dev.2023.03.20a branch. I'm reasonably
> > confident with the nature of the changes, so if your queue for 6.4 is
> > not closed yet, it can be a good target, otherwise 6.5 will be fine as
> > well.
> 
> I have applied and pushed it out, thank you both!
> 
> We are a little late in the process, but if testing goes well, I can't
> see why this cannot make the v6.4 merge window.

That's what I suspected, reason why I mentioned both options ;-)
Perfect then, many thanks Paul!

Willy
