Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EB370844F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjEROzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjEROzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D97ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B69C864FCD
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1900CC433EF;
        Thu, 18 May 2023 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421713;
        bh=uBmpW/dyzTfR1UsJFoB7UTpv7OXYuXYFBrE8Jnnzcio=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=r3lm9tb7cfoELHSfgM0q2ftAjCdofOTjY5AtF+ij9NYFBULndpEJAqgGrfyakwPa3
         jKZQvDtpxw1kug43RKtJ1c4WGooHYTpVKV3bITP6T5fJRyxowAMyHU7B/jSzLZpHni
         T+4499+RtJpG1eQI6O63QT+YztSwTy5YN9ZzDD6jjpaASYIxwggvfplTFvX6pcvIF5
         l+75WyvsKE2c4fAdcJDeXGivg0sBk2G75oI8OixqAFLW83irwpU+qPRFhsBYE4c68Q
         S+eCrUfM30kLBP85hwufgKY6xi9OZKq5HCUMnpqhn208895WjkXbF0KOTL7nxuRrSE
         71iGl8jDY0gxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2C97CE0CC3; Thu, 18 May 2023 07:55:12 -0700 (PDT)
Date:   Thu, 18 May 2023 07:55:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu
Subject: [PATCH nolibc 0/15] nolibc updates for v6.5]
Message-ID: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains nolibc updates for v6.5:

1.	tools/nolibc: tests: use volatile to force stack smashing,
	courtesy of Thomas Weiﬂschuh.

2.	tools/nolibc: tests: fix build on non-c99 compliant compilers,
	courtesy of Willy Tarreau.

3.	tools/nolibc: fix build of the test case using glibc, courtesy
	of Willy Tarreau.

4.	tools/nolibc: add libc-test binary, courtesy of
	Thomas Weiﬂschuh.

5.	tools/nolibc: add wrapper for memfd_create, courtesy of
	Thomas Weiﬂschuh.

6.	tools/nolibc: implement fd-based FILE streams, courtesy of
	Thomas Weiﬂschuh.

7.	tools/nolibc: add testcases for vfprintf, courtesy of
	Thomas Weiﬂschuh.

8.	tools/nolibc: Fix build of stdio.h due to header ordering,
	courtesy of Mark Brown.

9.	tools/nolibc: use standard __asm__ statements, courtesy of
	Thomas Weiﬂschuh.

10.	tools/nolibc: use __inline__ syntax, courtesy of
	Thomas Weiﬂschuh.

11.	tools/nolibc: use C89 comment syntax, courtesy of
	Thomas Weiﬂschuh.

12.	tools/nolibc: validate C89 compatibility, courtesy of
	Thomas Weiﬂschuh.

13.	tools/nolibc: s390: provide custom implementation for sys_fork,
	courtesy of Thomas Weiﬂschuh.

14.	tools/nolibc: add testcase for fork()/waitpid(), courtesy of
	Thomas Weiﬂschuh.

15.	tools/nolibc: remove LINUX_REBOOT_ constants, courtesy of
	Thomas Weiﬂschuh.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/include/nolibc/arch-aarch64.h          |   32 +++---
 b/tools/include/nolibc/arch-arm.h              |   44 ++++----
 b/tools/include/nolibc/arch-i386.h             |   40 ++++----
 b/tools/include/nolibc/arch-loongarch.h        |   38 +++----
 b/tools/include/nolibc/arch-mips.h             |   56 +++++------
 b/tools/include/nolibc/arch-riscv.h            |   40 ++++----
 b/tools/include/nolibc/arch-s390.h             |    2 
 b/tools/include/nolibc/arch-x86_64.h           |   34 +++---
 b/tools/include/nolibc/nolibc.h                |    2 
 b/tools/include/nolibc/stackprotector.h        |    4 
 b/tools/include/nolibc/stdio.h                 |   95 +++++++++++++------
 b/tools/include/nolibc/stdlib.h                |   18 +--
 b/tools/include/nolibc/string.h                |    4 
 b/tools/include/nolibc/sys.h                   |   23 ++++
 b/tools/include/nolibc/types.h                 |    8 -
 b/tools/testing/selftests/nolibc/.gitignore    |    1 
 b/tools/testing/selftests/nolibc/Makefile      |    6 +
 b/tools/testing/selftests/nolibc/nolibc-test.c |    8 -
 tools/include/nolibc/arch-s390.h               |    9 +
 tools/include/nolibc/sys.h                     |   11 +-
 tools/testing/selftests/nolibc/Makefile        |    2 
 tools/testing/selftests/nolibc/nolibc-test.c   |  125 +++++++++++++++++++++++--
 22 files changed, 391 insertions(+), 211 deletions(-)
