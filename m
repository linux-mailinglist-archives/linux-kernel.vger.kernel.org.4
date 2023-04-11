Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC676DE7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 01:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDKXUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 19:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKXUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 19:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B1A30C7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 16:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5280862CA1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 23:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC223C433D2;
        Tue, 11 Apr 2023 23:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681255219;
        bh=+YzaIRLUWzkFWzM4AaTJ91w/6s7cuW/xzuFrwR0u9fk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QA2SIEySBnNUmSqZthotkjyQ7pfTFBedYhKdqWU7J1Yrwz+40YjTQ2AOvXQmuTQWE
         cM4JKoMTNayzR+M0YDcSGX56Rk0cmxxJt4QgNkSMq/kgVHkTUIjpsmjnd9KeO38O8d
         K+sXVR7os/DJJDFHGjsn8nl0hdZN89Hjogngz95V+m/D6ZwSG9bLbJmrwuHOqC1XEZ
         y1jCtv/9qHgWMwAmDoGQHTPKdrlYmTOpeXbqD7x0KsWac9rhJ1fSmE2MaPFJT0+0nM
         EszFPZUEBDJ7U7DH6xVIRS4Urx1BXXBlMjHYurd11Yft1sALVTpL+9q+CB5q+gqdhh
         Bg+ALAf8H7GGA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 327BB1540478; Tue, 11 Apr 2023 16:20:19 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:20:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com, w@1wt.eu,
        linux@weissschuh.net, v@vda.io, chenfeiyang@loongson.cn
Subject: [GIT PULL] nolibc changes for v6.4
Message-ID: <455d6aeb-f2cc-4967-835e-92a10edc616b@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the v6.4 merge window opens, please pull these nolibc changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2023.04.04a
  # HEAD: 0d8c461adbc4a43736927f93db69ae376efbc2f1: tools/nolibc: x86_64: add stackprotector support (2023-03-27 16:26:10 -0700)

----------------------------------------------------------------
nolibc updates for v6.4

o     Add support for loongarch.

o     Fix stack-protector issues.

o     Support additional integral types and signal-related macros.

o     Add support for stdin, stdout, and stderr.

o     Add getuid() and geteuid().

o     Allow S_I* macros to be overridden by program.

o     Defer to linux/fcntl.h and linux/stat.h to avoid duplicate
	definitions.

o     Many improvements to the self tests.

----------------------------------------------------------------
Feiyang Chen (5):
      tools/nolibc: Include linux/fcntl.h and remove duplicate code
      tools/nolibc: Add statx() and make stat() rely on statx() if necessary
      tools/nolibc: Add support for LoongArch
      selftests/nolibc: Add support for LoongArch
      selftests/nolibc: Adjust indentation for Makefile

Paul E. McKenney (1):
      tools/nolibc: Add gitignore to avoid git complaints about sysroot

Thomas Weiﬂschuh (9):
      tools/nolibc: always disable stack protector for tests
      tools/nolibc: add definitions for standard fds
      tools/nolibc: add helpers for wait() signal exits
      tools/nolibc: tests: constify test_names
      tools/nolibc: add support for stack protector
      tools/nolibc: tests: fold in no-stack-protector cflags
      tools/nolibc: tests: add test for -fstack-protector
      tools/nolibc: i386: add stackprotector support
      tools/nolibc: x86_64: add stackprotector support

Vincent Dagonneau (4):
      tools/nolibc: add stdint.h
      tools/nolibc: add integer types and integer limit macros
      tools/nolibc: enlarge column width of tests
      tools/nolibc: add tests for the integer limits in stdint.h

Willy Tarreau (3):
      tools/nolibc: add getuid() and geteuid()
      selftests/nolibc: skip the chroot_root and link_dir tests when not privileged
      tools/nolibc: check for S_I* macros before defining them

 tools/include/nolibc/.gitignore              |   1 +
 tools/include/nolibc/Makefile                |   4 +-
 tools/include/nolibc/arch-i386.h             |   7 +-
 tools/include/nolibc/arch-loongarch.h        | 200 ++++++++++++++++++++++++
 tools/include/nolibc/arch-x86_64.h           |   5 +
 tools/include/nolibc/arch.h                  |   2 +
 tools/include/nolibc/nolibc.h                |   1 +
 tools/include/nolibc/stackprotector.h        |  53 +++++++
 tools/include/nolibc/std.h                   |  15 +-
 tools/include/nolibc/stdint.h                |  99 ++++++++++++
 tools/include/nolibc/sys.h                   | 100 +++++++++++-
 tools/include/nolibc/types.h                 |  30 +++-
 tools/include/nolibc/unistd.h                |   5 +
 tools/testing/selftests/nolibc/Makefile      |  90 ++++++-----
 tools/testing/selftests/nolibc/nolibc-test.c | 221 ++++++++++++++++++++-------
 15 files changed, 718 insertions(+), 115 deletions(-)
 create mode 100644 tools/include/nolibc/.gitignore
 create mode 100644 tools/include/nolibc/arch-loongarch.h
 create mode 100644 tools/include/nolibc/stackprotector.h
 create mode 100644 tools/include/nolibc/stdint.h
