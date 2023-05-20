Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F470A61A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjETHSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 03:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjETHS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 03:18:29 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B0E1A8
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 00:18:27 -0700 (PDT)
Date:   Sat, 20 May 2023 09:18:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684567106; bh=fD+QpWRMeNFpRCJAE2QutFXhc74ml8IcDlJIdx112eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uj+pDEHqqNV40b2qwspNNCqdm/q/yaCq93D06gl4xwM/y1QgFOHkvfkBKDLbF3b/8
         8WvG0c74Q8zNqe4oclx74UEc/7QAn1JImdiWfLm7JWYGUP30m/AbUsd32xPS5pDo84
         37y8Sunt1vg0v4qtRrLtQLi90o+Oj5ihEu08paG0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Message-ID: <3ce199ce-d9ca-4aa1-b19d-8e6b9b574300@t-8ch.de>
References: <cover.1684425792.git.falcon@tinylab.org>
 <20230519094030.GA24947@1wt.eu>
 <c5140f54-99f2-4d7f-8b53-bd3cd1093727@t-8ch.de>
 <ZGdNHv/QmAGBIYsM@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGdNHv/QmAGBIYsM@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-05-19 12:19:10+0200, Willy Tarreau wrote:
> On Fri, May 19, 2023 at 12:11:00PM +0200, Thomas Weißschuh wrote:
> > Hi Willy,
> > 
> > On 2023-05-19 11:40:30+0200, Willy Tarreau wrote:
> > > Hi Zhangjin,
> > > 
> > > On Fri, May 19, 2023 at 01:00:18AM +0800, Zhangjin Wu wrote:
> > > > Hi, Willy
> > > > 
> > > > nolibc for riscv is only tested for rv64 currently (see
> > > > tools/testing/selftests/nolibc/Makefile), this patchset tries to let it
> > > > compile for rv32, but still not pass the nolibc selftest:
> > > > 
> > > > * The first patch uses lw/sw instead of ld/sd for rv32 and verse-vice for rv64
> > > >     * This patch may conflict with the stackprotector patch [1], because
> > > >       both of them changed the _start assembly in arch-riscv.h
> > > 
> > > That's quite embarrassing, I'm having to trace of that series here. Now
> > > I can find it in my LKML archives, but I don't have the direct message and
> > > didn't spot the other ones. I'll have to investigate, thanks for notifying
> > > me! I'm CCing Thomas, I will check with him how to best merge the two.
> > 
> > I think the conflict should be trivial to fix.
> > 
> > I can also resend my series or just the single riscv patch.
> 
> OK then I'll pick Zhangjin's series and will apply yours on top of it.
> Do not bother resending the whole series, only the riscv patch will be
> sufficient, I have the rest of your series in my lkml mbox.

Could you let me know if or when your are publishing your integration
branch?

Thomas
