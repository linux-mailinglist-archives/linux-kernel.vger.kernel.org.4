Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D3601E10
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 02:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiJRADk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJRADh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 20:03:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFE237F6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 17:03:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5296EB81AD7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:03:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C456C433D6;
        Tue, 18 Oct 2022 00:03:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GakdiyuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666051410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2lAybai8gKhX1DN+fgNma6jgJEWUPQPSN+/pCq2V3uE=;
        b=GakdiyuAlCGhaXaRbJGQUHBJktZsxtTlL5cdRm/jh5cigMewYPfxpszVlKDCsHkD65UDZ/
        0Z9qQzUf6Ae5DBzAZQfttJZoH5Yj9QeCCLQp40BpZpcaDiEXU5qGLsibvkj76I4Y65hMgM
        wQaU7EgEpB8jzb+Ci72sLhc77vd5HFo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 448a33b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 18 Oct 2022 00:03:29 +0000 (UTC)
Date:   Tue, 18 Oct 2022 02:03:27 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guo Ren <guoren@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Linux 6.1-rc1
Message-ID: <Y03tTxLdH7HezRI+@zx2c4.com>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <20221017123434.GA1062543@roeck-us.net>
 <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:39:08AM -0700, Linus Torvalds wrote:
> On Mon, Oct 17, 2022 at 5:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Build results:
> >         total: 152 pass: 152 fail: 0
> > Qemu test results:
> >         total: 490 pass: 420 fail: 70
> 
> Strange. You claim zero build failures, but then:
> 
> > Build failures
> >
> > Building riscv:defconfig ... failed
> 
> so I think your stats may be wrong somehow ;)
> 
> > mips, sparc64
> > -------------
> >
> > All big endian mips tests fail to reset after boot. The problem is
> > caused by commit 72a95859728a ("mfd: syscon: Remove repetition of the
> > regmap_get_val_endian()").
> 
> Bah. I had already archived that whole thread as "sorted out", but
> yeah, the revert clearly never made it to me for rc1.
> 
> But it should be in the regmap queue (Lee/Andy?), so it is hopefully
> just a temporary thing.
> 
> In fact, it looks like all the failures have known fixes. So here's
> hoping that your list will be a whole lot cleaner by rc2.
> 
> Knock wood.

I emailed Lee about it 3 days ago, hoping it'd make rc1 too, but never
heard back. Maybe vacation? Dunno.

Jason

> 
> Thanks,
>            Linus
