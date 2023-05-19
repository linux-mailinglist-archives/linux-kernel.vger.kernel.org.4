Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F32709484
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjESKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjESKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 06:11:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9800B114
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 03:11:04 -0700 (PDT)
Date:   Fri, 19 May 2023 12:11:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1684491062; bh=BnKI1wFlnT7b9jk8O+5vwIz927UI6o6heQwO+A058hM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hm2Q61hygij7TXQsb0WOKAyTvP/4g8aTkuHcvdRlVmlanj28CwhY2264Zi1sZtA5f
         2oVsfGRhuWLt7xdgA6TU0hAecM5iwndcUQEUgGEJZg+T/pkMWfgJi9VHIYIwGULR3k
         7KIJk5DbjaIsz7UGp8jHFcFL3BUWGOM3WsJFutJo=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Zhangjin Wu <falcon@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools/nolibc: riscv: Fix up compile error for rv32
Message-ID: <c5140f54-99f2-4d7f-8b53-bd3cd1093727@t-8ch.de>
References: <cover.1684425792.git.falcon@tinylab.org>
 <20230519094030.GA24947@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519094030.GA24947@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On 2023-05-19 11:40:30+0200, Willy Tarreau wrote:
> Hi Zhangjin,
> 
> On Fri, May 19, 2023 at 01:00:18AM +0800, Zhangjin Wu wrote:
> > Hi, Willy
> > 
> > nolibc for riscv is only tested for rv64 currently (see
> > tools/testing/selftests/nolibc/Makefile), this patchset tries to let it
> > compile for rv32, but still not pass the nolibc selftest:
> > 
> > * The first patch uses lw/sw instead of ld/sd for rv32 and verse-vice for rv64
> >     * This patch may conflict with the stackprotector patch [1], because
> >       both of them changed the _start assembly in arch-riscv.h
> 
> That's quite embarrassing, I'm having to trace of that series here. Now
> I can find it in my LKML archives, but I don't have the direct message and
> didn't spot the other ones. I'll have to investigate, thanks for notifying
> me! I'm CCing Thomas, I will check with him how to best merge the two.

I think the conflict should be trivial to fix.

I can also resend my series or just the single riscv patch.

<snip>

Thomas
