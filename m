Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F53663CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjAJJ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbjAJJZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:25:27 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97BF8551EE
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:25:25 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A9PHD1004644;
        Tue, 10 Jan 2023 10:25:17 +0100
Date:   Tue, 10 Jan 2023 10:25:17 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230110092517.GA4626@1wt.eu>
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110073242.GB3229@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110073242.GB3229@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:32:42AM +0100, Willy Tarreau wrote:
> On Mon, Jan 09, 2023 at 11:15:34AM -0800, Paul E. McKenney wrote:
> > On Mon, Jan 09, 2023 at 09:09:06AM +0100, Willy Tarreau wrote:
> > > Hello Paul,
> > > 
> > > this series adds support for the s390x platform to nolibc and rcutorture,
> > > reducing the init size from ~600kB to ~1kB. The work was contributed by
> > > Sven Schnelle. It depends on the fixes series I sent previously:
> > > 
> > >   https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/
> > > 
> > > It passes the self-tests correctly and the patches are clean, please
> > > consider queuing it.
> > 
> > "80 test(s) passed" and successful exit code.  I will assume that the
> > decrease in tests from 81 to 80 is intended.  I have these queued,
> > but it may be some hours before they are externally visible.
> 
> Interesting, I didn't notice and I'm not observing this when running
> qemu-s390x (the userland version), I'm currently rebuilding the kernel
> to compare and will let you know. Thanks for checking!

So after a re-check, I'm constantly seeing 82 tests passed and a success
here. I don't understand what's differing, and would be interested in a
copy of your "run.out" in the "tools/testing/selftests/nolibc" subdir to
compare with mine, as it's possible we have a bug somewhere in the way
tests are run (or maybe we're still facing a mangled qemu output).

You can just send this to me privately, no need to spam the list, the
file is moderately large and uninteresting.

Thanks!
Willy
