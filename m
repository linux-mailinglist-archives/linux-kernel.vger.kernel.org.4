Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7572A2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjFITAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFITAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:00:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74223592;
        Fri,  9 Jun 2023 12:00:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B42165B16;
        Fri,  9 Jun 2023 19:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF35C433D2;
        Fri,  9 Jun 2023 19:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686337236;
        bh=/2FmvcnecbdW46CuoR4VJGXTU+PMKkkyJidGNM/RvI8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WJsIF9BcaTGesz1AAnkFByy8zXGEdzXlruhqmQKIMIKCxeq5iH5wS+bF7OFSURSBu
         ewA0SM963tPldN757IROihwQKCjK1jXMwPwxNli3ul7UeVgPKB2P00zcljaZLijSqI
         b9JP93GOC7rymO174LGODmmsOl1kl+OLOSddjzHKtDwv4yv3+0VBlT4NggEI3TlA6E
         Hb7ldy2AKR7HklZweu6KCJdgDc14b5XqAldX2e6TIU8YhBzMR71E6bTbJbsr6e4L1z
         TbJRyOzuT5A28UVJ0M5BgFKl1lSByIOi0gMOlTshYpXbXyfRsdvXKpSfsepX6MJNhZ
         ImxkLRploOJwA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4436BCE14DD; Fri,  9 Jun 2023 12:00:36 -0700 (PDT)
Date:   Fri, 9 Jun 2023 12:00:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Willy Tarreau <w@1wt.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the rcu tree
Message-ID: <5db31cea-470f-453b-ae1f-28c67a2128e5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230609083102.0a063bc0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609083102.0a063bc0@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 08:31:02AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
>   bc6edad600e6 ("selftests/nolibc: make sure gcc always use little endian on MIPS")
>   15f57edf4753 ("selftests/nolibc: also count skipped and failed tests in output")
>   87c76b30c631 ("selftests/nolibc: add new gettimeofday test cases")
>   168bacf2b889 ("selftests/nolibc: remove gettimeofday_bad1/2 completely")
>   b58a501ed987 ("selftests/nolibc: support two errnos with EXPECT_SYSER2()")
>   5b654b2c0284 ("tools/nolibc: open: fix up compile warning for arm")
>   a50316875429 ("tools/nolibc: arm: add missing my_syscall6")
>   1993d9c770c2 ("selftests/nolibc: use INT_MAX instead of __INT_MAX__")
>   fc41c241d79c ("selftests/nolibc: not include limits.h for nolibc")
>   a8b20e76e877 ("selftests/nolibc: fix up compile warning with glibc on x86_64")
>   d785d831bde5 ("selftests/nolibc: allow specify extra arguments for qemu")
>   df772c12508a ("selftests/nolibc: syscall_args: use generic __NR_statx")
>   3f83dcdf4fc6 ("selftests/nolibc: remove test gettimeofday_null")
>   a54457590ece ("tools/nolibc: ensure fast64 integer types have 64 bits")
>   a232f7f31314 ("selftests/nolibc: test_fork: fix up duplicated print")
>   c79ff8143435 ("tools/nolibc: ppoll/ppoll_time64: add a missing argument")
>   b1f9a5df6b53 ("selftests/nolibc: remove the duplicated gettimeofday_bad2")
>   b38d446d8364 ("selftests/nolibc: print name instead of number for EOVERFLOW")
>   37363156afc3 ("tools/nolibc: support nanoseconds in stat()")
>   6a1935f83840 ("selftests/nolibc: prevent coredumps during test execution")
>   6066aced432c ("tools/nolibc: add support for prctl()")
>   997c1685b7ec ("tools/nolibc: s390: disable stackprotector in _start")
>   4eb9ada569ee ("tools/nolibc: fix segfaults on compilers without attribute no_stack_protector")
>   be5547775590 ("tools/nolibc: simplify stackprotector compiler flags")
>   ea22ffdf3acf ("tools/nolibc: add autodetection for stackprotector support")
>   92b85d2cc2e4 ("tools/nolibc: reformat list of headers to be installed")
>   af29d2e6df83 ("tools/nolibc: add test for __stack_chk_guard initialization")
>   b0e9a86caded ("tools/nolibc: ensure stack protector guard is never zero")
>   f14f35a85ee6 ("tools/nolibc: x86_64: disable stack protector for _start")
>   9d15cbe52c62 ("tools/nolibc: fix typo pint -> point")
>   340529052f74 ("tools/nolibc: riscv: add stackprotector support")
>   9b80e2f60acb ("tools/nolibc: mips: add stackprotector support")
>   58ac7b1823c7 ("tools/nolibc: loongarch: add stackprotector support")
>   3259f396c0e6 ("tools/nolibc: arm: add stackprotector support")
>   8411f6ee8393 ("tools/nolibc: aarch64: add stackprotector support")
>   8c9ea6b3d1b7 ("selftests/nolibc: reduce syscalls during space padding")
>   6bff2a1e97e3 ("tools/nolibc/unistd: add syscall()")
>   5f97e9feb11e ("tools/nolibc: riscv: Fix up load/store instructions for rv32")
> 
> are missing a Signed-off-by from their committer.
> 
> It looks like you should have merged someone else's branch, but ended
> up rebasing it instead.

We will be moving to me pulling directly from Willy's tree, but that will
be next cycle.  Me, I stupidly forgot the "-s" argument.  Apologies for
the hassle, and fixed.

							Thanx, Paul
