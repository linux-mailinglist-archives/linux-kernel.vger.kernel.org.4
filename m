Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63F6016B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJQSzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiJQSzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:55:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD5857BE4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:55:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E5361208
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 18:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA2EC433D6;
        Mon, 17 Oct 2022 18:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666032905;
        bh=fqz0/dSKPxCpuYxX3KOjnFE48a7QeBm2US5pXceX9rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prGbyX8/cKdPxZmM+nurlnBVT/4oQFIZYASjVuul+4WEjq8tlz1KzTlIeS+CqXoTL
         xa+Q0PdmSUbW5KP4qY4FwOGnNHBKLoAHKSBlAPh9W2UwgRnBtTCijaYworYW0bZJNz
         s/vClosptpr8c+Wf14KnLxQ1wb+jKiHqcwzUz6ddAbMeyVMWWmx9HEXDrv+adQxki5
         9ELB8/PPVTQmCTLc/64EDN5mF90TsWblIP+EJvVy9VS6rLWn5n0p/3QJBx5QMn14ho
         Z+4OsjrVlmwZLaYBgix+mdWTflJt6RSGjCdCGCKK5nUhsTirsLEk4Q5L+a23lW5YTp
         QgD74JndE6y7w==
Date:   Mon, 17 Oct 2022 19:54:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Jakub Kicinski <kuba@kernel.org>, palmer@dabbelt.com
Subject: Re: Linux 6.1-rc1
Message-ID: <Y02lAy2ZL0AeQ2Pn@spud>
References: <CAHk-=wj6y5fipM2A5kEuOO9qm5PBzUY=-m9viEahhtxT09KR_g@mail.gmail.com>
 <20221017123434.GA1062543@roeck-us.net>
 <CAHk-=wh9o1x43Me0kRZAwN-DmZzUgJzUhA2_v+Uo0Aq04hB_=A@mail.gmail.com>
 <7e5e4c7d-07f4-6ccd-6796-cd6f021f222e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5e4c7d-07f4-6ccd-6796-cd6f021f222e@roeck-us.net>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 11:28:53AM -0700, Guenter Roeck wrote:
> On 10/17/22 10:39, Linus Torvalds wrote:
> > On Mon, Oct 17, 2022 at 5:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > Build results:
> > >          total: 152 pass: 152 fail: 0
> > > Qemu test results:
> > >          total: 490 pass: 420 fail: 70
> > 
> > Strange. You claim zero build failures, but then:
> > 
> > > Build failures
> > > 
> > > Building riscv:defconfig ... failed
> > 
> > so I think your stats may be wrong somehow ;)
> > 
> 
> Puzzled ... the logs show that the builds for riscv[32/64] succeeded
> with no error, but a manual build test still shows the failure.
> 
> Ah .... the build fails with gcc 11.3.0 / binutils 2.38, but passes
> with gcc 11.3.0 / binutils 2.39. I had switched my builders to the
> latter last night to fix a problem with powerpc builds. At the same time,
> the manual test I just ran still used binutils 2.38.
> 
> That is interesting; I didn't expect that the binutils version would
> make a difference, but apparently it does. Comparing defconfig:
> 
> 10c10
> < CONFIG_AS_VERSION=23900
> ---
> > CONFIG_AS_VERSION=23800
> 12c12
> < CONFIG_LD_VERSION=23900
> ---
> > CONFIG_LD_VERSION=23800
> 260d259
> < CONFIG_RISCV_DMA_NONCOHERENT=y
> 297,298d295
> < CONFIG_CC_HAS_ZICBOM=y
> < CONFIG_RISCV_ISA_ZICBOM=y
> 4134,4137d4130
> < CONFIG_ARCH_HAS_SETUP_DMA_OPS=y
> < CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE=y
> < CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
> < CONFIG_ARCH_HAS_DMA_PREP_COHERENT=y
> 4140,4142d4132
> < CONFIG_DMA_NONCOHERENT_MMAP=y
> < CONFIG_DMA_COHERENT_POOL=y
> < CONFIG_DMA_DIRECT_REMAP=y
> 
> The build failure is only seen with CONFIG_RISCV_ISA_ZICBOM=n,
> or in other words with binutils 2.38 or earlier.

+CC Palmer since he's the maintainer of the code being changed by the
fix.

The Zicbom extension only got support in binutils 2.39, so it's
automatically disabled for your older binutils, along with non-coherent
DMA support. As pointed out, we've already got a reviewed fix for it, so
hopefully that lands soon.

Kinda surprised this didn't trigger complaints from more than just you
and an LKP report, but it may be that having some other options selected
hides the problem.

Palmer, the fix is here if you get a chance to look at it:
https://lore.kernel.org/all/20221013134217.1850349-1-ajones@ventanamicro.com/

Thanks,
Conor.

