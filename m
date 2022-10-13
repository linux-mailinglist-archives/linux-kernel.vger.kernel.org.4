Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B888B5FD42D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 07:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiJMFTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 01:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJMFT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 01:19:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F37C10D6BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 22:19:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF9EFB81CFD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812F3C433D6;
        Thu, 13 Oct 2022 05:19:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=fail reason="signature verification failed" (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cNgEjXjx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665638359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcJRRVBiuZoG3cV61t2lzgRn8ZXdwknC9Fh8mKPwMvo=;
        b=cNgEjXjxnwPTcBYgqBJ6KwRRQcHuFgP2swPyuCTIcE3K2aODI/zwO7uKjzMc+Glc1egRQ9
        G9MFjt5SMq+mPDTYK8Rvtt9xqHt28Wq/dpzYYkAiITV57ncx1noYlthc78enwz0c6MJqS3
        eSPuPQPz8SSJKWCN/+6C9iltvLbllwA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af73e1cb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 05:19:18 +0000 (UTC)
Date:   Thu, 13 Oct 2022 07:19:17 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        cuigaosheng1@huawei.com, david@redhat.com, farosas@linux.ibm.com,
        geoff@infradead.org, gustavoars@kernel.org, haren@linux.ibm.com,
        hbathini@linux.ibm.com, joel@jms.id.au, lihuafei1@huawei.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, mikey@neuling.org, nathan@kernel.org,
        nathanl@linux.ibm.com, nicholas@linux.ibm.com, pali@kernel.org,
        paul@paul-moore.com, rmclure@linux.ibm.com, ruscur@russell.cc,
        windhl@126.com, wsa+renesas@sang-engineering.com,
        ye.xingchen@zte.com.cn, yuanjilin@cdjrlc.com,
        zhengyongjun3@huawei.com
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-1 tag
Message-ID: <Y0ef1SuIpFZxNCcJ@zx2c4.com>
References: <87edvhntv0.fsf@mpe.ellerman.id.au>
 <20221012141827.GA2405914@roeck-us.net>
 <Y0biBtCUtc2mowbQ@zx2c4.com>
 <20221012164452.GA2990467@roeck-us.net>
 <Y0b3ZsTRHWG6jGK8@zx2c4.com>
 <20221012221615.GA364143@roeck-us.net>
 <87bkqgmvxl.fsf@mpe.ellerman.id.au>
 <20221013002148.GA535574@roeck-us.net>
 <CNKJ6FE6U35I.3ERMDQR9MHRLX@bobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CNKJ6FE6U35I.3ERMDQR9MHRLX@bobo>
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:03:14PM +1000, Nicholas Piggin wrote:
> On Thu Oct 13, 2022 at 10:21 AM AEST, Guenter Roeck wrote:
> > On Thu, Oct 13, 2022 at 11:03:34AM +1100, Michael Ellerman wrote:
> > > Guenter Roeck <linux@roeck-us.net> writes:
> > > > On Wed, Oct 12, 2022 at 11:20:38AM -0600, Jason A. Donenfeld wrote:
> > > >> 
> > > >> I've also managed to not hit this bug a few times. When it triggers,
> > > >> after "kprobes: kprobe jump-optimization is enabled. All kprobes are
> > > >> optimized if possible.", there's a long hang - tens seconds before it
> > > >> continues. When it doesn't trigger, there's no hang at that point in the
> > > >> boot process.
> > > >> 
> > > >
> > > > I managed to bisect the problem. See below for results. Reverting the
> > > > offending patch fixes the problem for me.
> > > 
> > > Thanks.
> > > 
> > > This is probably down to me/us not testing with PREEMPT enabled enough.
> > > 
> > Not sure. My configuration has
> >
> > CONFIG_PREEMPT_NONE=y
> > # CONFIG_PREEMPT_VOLUNTARY is not set
> > # CONFIG_PREEMPT is not set
> 
> Thanks very much for helping with this. The config snippet you posted here
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2022-October/249758.html
> has CONFIG_PREEMPT=y. How do you turn that into a .config, olddefconfig?
> 
> I can't reproduce this so far using your config and qemu command line,
> but the patch you've bisected it to definitely could cause this. I'll
> keep trying...

Voila https://xn--4db.cc/dt00j0mt this repros it for me.

> 
> Thanks,
> Nick
> 
> [...]
> > > > # first bad commit: [e485f6c751e0a969327336c635ca602feea117f0] powerpc/64/interrupt: Fix return to masked context after hard-mask irq becomes pending
> 
