Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1A5FF522
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJNVRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJNVRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:17:18 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A658CEE8B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:17:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7CDF7642172E;
        Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EueKNQ03VQhz; Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 395E3642172F;
        Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sKScj7yUuC4f; Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 243B7642172E;
        Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
Date:   Fri, 14 Oct 2022 23:17:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1664125781.30715.1665782235123.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for 6.1-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: eu8Lr/WFHSi3zrjtn8iP5stRMfVGvQ==
Thread-Topic: UML updates for 6.1-rc1
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

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.1-rc1

for you to fetch changes up to 193cb8372424184dde28088a4230a5fed0afb0ad:

  uml: Remove the initialization of statics to 0 (2022-09-19 23:10:07 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Move to strscpy()
- Improve panic notifiers
- Fix NR_CPUS usage
- Fixes for various comments
- Fixes for virtio driver

----------------------------------------------------------------
Benjamin Beichler (1):
      um: read multiple msg from virtio slave request fd

Christian Lamparter (1):
      um: increase default virtual physical memory to 64 MiB

Gaosheng Cui (1):
      um: remove unused reactivate_chan() declaration

Guilherme G. Piccoli (1):
      um: Improve panic notifiers consistency and ordering

Huacai Chen (1):
      UM: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Jason Wang (1):
      um: Fix comment typo

Shaomin Deng (1):
      uml: Remove the initialization of statics to 0

Wolfram Sang (2):
      um: move from strlcpy with unused retval to strscpy
      hostfs: move from strlcpy with unused retval to strscpy

Xin Gao (1):
      um: Do not initialise statics to 0.

Xiu Jianfeng (2):
      um: virt-pci: add __init/__exit annotations to module init/exit funcs
      um: mmaper: add __exit annotations to module exit funcs

 arch/um/drivers/chan.h          |  1 -
 arch/um/drivers/mconsole_kern.c |  9 +++---
 arch/um/drivers/mmapper_kern.c  |  2 +-
 arch/um/drivers/net_kern.c      |  2 +-
 arch/um/drivers/ssl.c           |  2 +-
 arch/um/drivers/stdio_console.c |  2 +-
 arch/um/drivers/ubd_kern.c      |  2 +-
 arch/um/drivers/vector_kern.c   |  2 +-
 arch/um/drivers/virt-pci.c      |  4 +--
 arch/um/drivers/virtio_uml.c    | 71 +++++++++++++++++++++--------------------
 arch/um/kernel/physmem.c        |  2 +-
 arch/um/kernel/um_arch.c        | 14 ++++----
 arch/um/kernel/umid.c           |  2 +-
 fs/hostfs/hostfs_kern.c         |  2 +-
 14 files changed, 59 insertions(+), 58 deletions(-)
