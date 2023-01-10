Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D8A663A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjAJHeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjAJHdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:33:43 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B1EAB1B1C9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:32:47 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30A7Wggg003996;
        Tue, 10 Jan 2023 08:32:42 +0100
Date:   Tue, 10 Jan 2023 08:32:42 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 0/4] nolibc: add support for the s390 platform
Message-ID: <20230110073242.GB3229@1wt.eu>
References: <20230109080910.26594-1-w@1wt.eu>
 <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109191534.GU4028633@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:15:34AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 09, 2023 at 09:09:06AM +0100, Willy Tarreau wrote:
> > Hello Paul,
> > 
> > this series adds support for the s390x platform to nolibc and rcutorture,
> > reducing the init size from ~600kB to ~1kB. The work was contributed by
> > Sven Schnelle. It depends on the fixes series I sent previously:
> > 
> >   https://lore.kernel.org/lkml/20230109075442.25963-1-w@1wt.eu/
> > 
> > It passes the self-tests correctly and the patches are clean, please
> > consider queuing it.
> 
> "80 test(s) passed" and successful exit code.  I will assume that the
> decrease in tests from 81 to 80 is intended.  I have these queued,
> but it may be some hours before they are externally visible.

Interesting, I didn't notice and I'm not observing this when running
qemu-s390x (the userland version), I'm currently rebuilding the kernel
to compare and will let you know. Thanks for checking!

Willy
