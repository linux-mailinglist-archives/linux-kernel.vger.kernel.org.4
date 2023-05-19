Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CBE7094A4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjESKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjESKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:19:30 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 698ECE43
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:19:28 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 34JAJAlK005895;
        Fri, 19 May 2023 12:19:10 +0200
Date:   Fri, 19 May 2023 12:19:10 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Message-ID: <ZGdNHv/QmAGBIYsM@1wt.eu>
References: <cover.1684425792.git.falcon@tinylab.org>
 <20230519094030.GA24947@1wt.eu>
 <c5140f54-99f2-4d7f-8b53-bd3cd1093727@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5140f54-99f2-4d7f-8b53-bd3cd1093727@t-8ch.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023 at 12:11:00PM +0200, Thomas Weißschuh wrote:
> Hi Willy,
> 
> On 2023-05-19 11:40:30+0200, Willy Tarreau wrote:
> > Hi Zhangjin,
> > 
> > On Fri, May 19, 2023 at 01:00:18AM +0800, Zhangjin Wu wrote:
> > > Hi, Willy
> > > 
> > > nolibc for riscv is only tested for rv64 currently (see
> > > tools/testing/selftests/nolibc/Makefile), this patchset tries to let it
> > > compile for rv32, but still not pass the nolibc selftest:
> > > 
> > > * The first patch uses lw/sw instead of ld/sd for rv32 and verse-vice for rv64
> > >     * This patch may conflict with the stackprotector patch [1], because
> > >       both of them changed the _start assembly in arch-riscv.h
> > 
> > That's quite embarrassing, I'm having to trace of that series here. Now
> > I can find it in my LKML archives, but I don't have the direct message and
> > didn't spot the other ones. I'll have to investigate, thanks for notifying
> > me! I'm CCing Thomas, I will check with him how to best merge the two.
> 
> I think the conflict should be trivial to fix.
> 
> I can also resend my series or just the single riscv patch.

OK then I'll pick Zhangjin's series and will apply yours on top of it.
Do not bother resending the whole series, only the riscv patch will be
sufficient, I have the rest of your series in my lkml mbox.

Thanks!
Willy
