Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB7872D0E7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFLUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbjFLUqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4082106
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:46:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3400E621BA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:45:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9472FC433EF;
        Mon, 12 Jun 2023 20:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686602699;
        bh=Pfr4o4XyYda6fpbeSNhoAPyvOTSxcoZkj4Gf7jTdY60=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Pmc4gSAkZyIlrubOX+PHcsRikxctyIk1I0X4BQg+0U8XDldiELd3J7VppZvn+w2/M
         /TArNvu1B/0eNZjq3qOkHb8rhqh8n0YC2iONonk+TMjpYYpq44u+aVXQDJ6idC4bCW
         yErl2MG2EMx80jI0aWHzv0bXxUSriE26OqCLyBVZo5j5DwcROO6HWWEr3yE6lfOIXH
         Umi2n0drcCS8248GE4V0BNvMBqjKKofbuzgqqODRcd9xr1gRFj74+ngVtQaYTzfcYy
         cDp26KDZhbIv/wT8M+73No50iVa99Xk+tNk+Hs8geLKDj2wcgJziXWDaik/8J8iEIt
         wiiS8EPSA/2CQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 26268CE09E7; Mon, 12 Jun 2023 13:44:59 -0700 (PDT)
Date:   Mon, 12 Jun 2023 13:44:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu
Subject: [PATCH v2 nolibc 0/15] nolibc updates for v6.5]
Message-ID: <8b757cc0-3719-4e63-a755-9710384137bc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains a second version of the nolibc updates for v6.5:

1.	tools/nolibc: tests: use volatile to force stack smashing,
	courtesy of Thomas Weiﬂschuh.

2.	tools/nolibc: tests: fix build on non-c99 compliant compilers,
	courtesy of Willy Tarreau.

3.	tools/nolibc: fix build of the test case using glibc, courtesy
	of Willy Tarreau.

4.	tools/nolibc: add libc-test binary, courtesy of Thomas Weiﬂschuh.

5.	tools/nolibc: add wrapper for memfd_create, courtesy of Thomas
	Weiﬂschuh.

6.	tools/nolibc: implement fd-based FILE streams, courtesy of
	Thomas Weiﬂschuh.

7.	tools/nolibc: add testcases for vfprintf, courtesy of Thomas
	Weiﬂschuh.

8.	tools/nolibc: Fix build of stdio.h due to header ordering,
	courtesy of Mark Brown.

9.	tools/nolibc: use standard __asm__ statements, courtesy of
	Thomas Weiﬂschuh.

10.	tools/nolibc: use __inline__ syntax, courtesy of Thomas
	Weiﬂschuh.

11.	tools/nolibc: use C89 comment syntax, courtesy of Thomas
	Weiﬂschuh.

12.	tools/nolibc: validate C89 compatibility, courtesy of Thomas
	Weiﬂschuh.

13.	tools/nolibc: s390: provide custom implementation for sys_fork,
	courtesy of Thomas Weiﬂschuh.

14.	tools/nolibc: add testcase for fork()/waitpid(), courtesy of
	Thomas Weiﬂschuh.

15.	tools/nolibc: remove LINUX_REBOOT_ constants, courtesy of Thomas
	Weiﬂschuh.

16.	tools/nolibc: riscv: Fix up load/store instructions for rv32,
	courtesy of Zhangjin Wu.

17.	tools/nolibc/unistd: add syscall(), courtesy of Thomas Weiﬂschuh.

18.	selftests/nolibc: syscall_args: use generic __NR_statx, courtesy
	of Zhangjin Wu.

19.	selftests/nolibc: reduce syscalls during space padding, courtesy
	of Thomas Weiﬂschuh.

20.	tools/nolibc: aarch64: add stackprotector support, courtesy of
	Thomas Weiﬂschuh.

21.	tools/nolibc: arm: add stackprotector support, courtesy of
	Thomas Weiﬂschuh.

22.	tools/nolibc: loongarch: add stackprotector support, courtesy
	of Thomas Weiﬂschuh.

23.	tools/nolibc: mips: add stackprotector support, courtesy of
	Thomas Weiﬂschuh.

24.	tools/nolibc: riscv: add stackprotector support, courtesy of
	Thomas Weiﬂschuh.

25.	tools/nolibc: fix typo pint -> point, courtesy of Thomas
	Weiﬂschuh.

26.	tools/nolibc: x86_64: disable stack protector for _start,
	courtesy of Thomas Weiﬂschuh.

27.	tools/nolibc: ensure stack protector guard is never zero,
	courtesy of Thomas Weiﬂschuh.

28.	tools/nolibc: add test for __stack_chk_guard initialization,
	courtesy of Thomas Weiﬂschuh.

29.	tools/nolibc: reformat list of headers to be installed, courtesy
	of Thomas Weiﬂschuh.

30.	tools/nolibc: add autodetection for stackprotector support,
	courtesy of Thomas Weiﬂschuh.

31.	tools/nolibc: simplify stackprotector compiler flags, courtesy
	of Thomas Weiﬂschuh.

32.	tools/nolibc: fix segfaults on compilers without attribute
	no_stack_protector, courtesy of Thomas Weiﬂschuh.

33.	tools/nolibc: s390: disable stackprotector in _start, courtesy
	of Thomas Weiﬂschuh.

34.	tools/nolibc: add support for prctl(), courtesy of Thomas
	Weiﬂschuh.

35.	selftests/nolibc: prevent coredumps during test execution,
	courtesy of Thomas Weiﬂschuh.

36.	tools/nolibc: support nanoseconds in stat(), courtesy of
	Thomas Weiﬂschuh.

37.	selftests/nolibc: print name instead of number for EOVERFLOW,
	courtesy of Zhangjin Wu.

38.	selftests/nolibc: remove the duplicated gettimeofday_bad2,
	courtesy of Zhangjin Wu.

39.	tools/nolibc: ppoll/ppoll_time64: add a missing argument,
	courtesy of Zhangjin Wu.

40.	selftests/nolibc: test_fork: fix up duplicated print, courtesy
	of Zhangjin Wu.

41.	tools/nolibc: ensure fast64 integer types have 64 bits, courtesy
	of Thomas Weiﬂschuh.

42.	selftests/nolibc: remove test gettimeofday_null, courtesy of
	Thomas Weiﬂschuh.

43.	selftests/nolibc: allow specify extra arguments for qemu,
	courtesy of Zhangjin Wu.

44.	selftests/nolibc: fix up compile warning with glibc on x86_64,
	courtesy of Zhangjin Wu.

45.	selftests/nolibc: not include limits.h for nolibc, courtesy of
	Zhangjin Wu.

46.	selftests/nolibc: use INT_MAX instead of __INT_MAX__, courtesy
	of Zhangjin Wu.

47.	tools/nolibc: arm: add missing my_syscall6, courtesy of
	Zhangjin Wu.

48.	tools/nolibc: open: fix up compile warning for arm, courtesy of
	Zhangjin Wu.

49.	selftests/nolibc: support two errnos with EXPECT_SYSER2(),
	courtesy of Zhangjin Wu.

50.	selftests/nolibc: remove gettimeofday_bad1/2 completely, courtesy
	of Zhangjin Wu.

51.	selftests/nolibc: add new gettimeofday test cases, courtesy of
	Zhangjin Wu.

52.	selftests/nolibc: also count skipped and failed tests in output,
	courtesy of Willy Tarreau.

53.	selftests/nolibc: make sure gcc always use little endian on MIPS,
	courtesy of Willy Tarreau.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/include/nolibc/Makefile                |   18 +
 b/tools/include/nolibc/arch-aarch64.h          |   32 +--
 b/tools/include/nolibc/arch-arm.h              |   44 ++--
 b/tools/include/nolibc/arch-i386.h             |   40 ++--
 b/tools/include/nolibc/arch-loongarch.h        |   38 ++--
 b/tools/include/nolibc/arch-mips.h             |   56 +++---
 b/tools/include/nolibc/arch-riscv.h            |   40 ++--
 b/tools/include/nolibc/arch-s390.h             |    2 
 b/tools/include/nolibc/arch-x86_64.h           |   34 +--
 b/tools/include/nolibc/arch.h                  |    2 
 b/tools/include/nolibc/compiler.h              |   15 +
 b/tools/include/nolibc/nolibc.h                |    2 
 b/tools/include/nolibc/stackprotector.h        |    4 
 b/tools/include/nolibc/stdint.h                |   10 -
 b/tools/include/nolibc/stdio.h                 |   95 +++++++---
 b/tools/include/nolibc/stdlib.h                |   18 -
 b/tools/include/nolibc/string.h                |    4 
 b/tools/include/nolibc/sys.h                   |   23 ++
 b/tools/include/nolibc/types.h                 |    8 
 b/tools/include/nolibc/unistd.h                |   15 +
 b/tools/testing/selftests/nolibc/.gitignore    |    1 
 b/tools/testing/selftests/nolibc/Makefile      |    6 
 b/tools/testing/selftests/nolibc/nolibc-test.c |    8 
 tools/include/nolibc/Makefile                  |    1 
 tools/include/nolibc/arch-aarch64.h            |   15 +
 tools/include/nolibc/arch-arm.h                |   38 +++-
 tools/include/nolibc/arch-i386.h               |    8 
 tools/include/nolibc/arch-loongarch.h          |   15 +
 tools/include/nolibc/arch-mips.h               |   16 +
 tools/include/nolibc/arch-riscv.h              |   29 ++-
 tools/include/nolibc/arch-s390.h               |   13 +
 tools/include/nolibc/arch-x86_64.h             |   10 -
 tools/include/nolibc/compiler.h                |   10 +
 tools/include/nolibc/stackprotector.h          |   17 -
 tools/include/nolibc/stdint.h                  |   14 +
 tools/include/nolibc/sys.h                     |  108 +++++++----
 tools/include/nolibc/types.h                   |    6 
 tools/testing/selftests/nolibc/Makefile        |   39 ++--
 tools/testing/selftests/nolibc/nolibc-test.c   |  231 +++++++++++++++++++++----
 39 files changed, 738 insertions(+), 347 deletions(-)
