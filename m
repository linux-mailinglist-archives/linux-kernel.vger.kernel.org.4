Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AF5C0488
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIUQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiIUQps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:45:48 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDAA2627
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:36:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 850FE6323052;
        Wed, 21 Sep 2022 18:36:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EfoFMhj7NX5z; Wed, 21 Sep 2022 18:36:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 32509632304C;
        Wed, 21 Sep 2022 18:36:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4bZ9pIIqBl_J; Wed, 21 Sep 2022 18:36:37 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 10B6C6323041;
        Wed, 21 Sep 2022 18:36:37 +0200 (CEST)
Date:   Wed, 21 Sep 2022 18:36:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1498364411.248529.1663778196892.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 6.0-rc7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: KKZLADGJCwG+9bYdh5iNj8aWLI86/Q==
Thread-Topic: UML fixes for 6.0-rc7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.0-rc7

for you to fetch changes up to bd71558d585ac61cfd799db7f25e78dca404dd7a:

  arch: um: Mark the stack non-executable to fix a binutils warning (2022-09-21 09:11:42 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Various fixes for build warnings
- Fix default kernel command line

----------------------------------------------------------------
Christian Lamparter (1):
      um: fix default console kernel parameter

David Gow (1):
      arch: um: Mark the stack non-executable to fix a binutils warning

Lukas Straub (2):
      um: Cleanup syscall_handler_t cast in syscalls_32.h
      um: Cleanup compiler warning in arch/x86/um/tls_32.c

Vincent Whitchurch (1):
      um: Prevent KASAN splats in dump_stack()

 arch/um/Makefile                        | 8 ++++++++
 arch/um/kernel/sysrq.c                  | 3 ++-
 arch/um/kernel/um_arch.c                | 2 +-
 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 arch/x86/um/tls_32.c                    | 6 ------
 arch/x86/um/vdso/Makefile               | 2 +-
 6 files changed, 14 insertions(+), 12 deletions(-)
