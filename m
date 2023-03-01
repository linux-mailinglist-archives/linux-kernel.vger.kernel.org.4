Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075CB6A6891
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCAIHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 03:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjCAIHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:07:06 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8035D37569
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:07:05 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 556E36382EFA;
        Wed,  1 Mar 2023 09:07:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aGzhhw1eme9t; Wed,  1 Mar 2023 09:07:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 023D46382F05;
        Wed,  1 Mar 2023 09:07:04 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mgiQXURzRfJZ; Wed,  1 Mar 2023 09:07:03 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id E04936382EFB;
        Wed,  1 Mar 2023 09:07:03 +0100 (CET)
Date:   Wed, 1 Mar 2023 09:07:03 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <52785855.187162.1677658023892.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.3-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 8SzAAtPX+qxfvaL6KPjwV/oCiPeEjg==
Thread-Topic: UML changes for v6.3-rc1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:

  Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linus-6.3-rc1

for you to fetch changes up to 04df97e150c83d4640540008e95d0229cb188135:

  Documentation: rust: Fix arch support table (2023-02-13 10:14:32 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Add support for rust (yay!)
- Add support for LTO
- Add platform bus support to virtio-pci
- Various virtio fixes
- Coding style, spelling cleanups

----------------------------------------------------------------
Ammar Faizi (1):
      x86: um: vdso: Add '%rcx' and '%r11' to the syscall clobber list

Bagas Sanjaya (1):
      Documentation: rust: Fix arch support table

Benjamin Berg (6):
      um: Switch printk calls to adhere to correct coding style
      um: Declare fix_range_common as a static function
      um: virtio_uml: free command if adding to virtqueue failed
      um: virtio_uml: mark device as unregistered when breaking it
      um: virtio_uml: move device breaking into workqueue
      um: virt-pci: properly remove PCI device from bus

Carlos Bilbao (1):
      uml: vector: Remove unused definitions VECTOR_{WRITE,HEADERS}

David Gow (3):
      rust: arch/um: Use 'pie' relocation mode under UML
      rust: arch/um: Disable FP/SIMD instruction to match x86
      rust: arch/um: Add support for CONFIG_RUST under x86_64 UML

Fabio M. De Francesco (1):
      hostfs: Replace kmap() with kmap_local_page()

Johannes Berg (1):
      um: protect VMA iteration

Masahiro Yamada (1):
      UML: define RUNTIME_DISCARD_EXIT

Peter Foley (6):
      um: Make the definition of cpu_data more compatible
      um: Avoid pcap multiple definition errors
      um: Prevent building modules incompatible with MODVERSIONS
      um: Use CFLAGS_vmlinux
      um: put power options in a menu
      um: Support LTO

Vincent Whitchurch (3):
      um: virt-pci: implement pcibios_get_phb_of_node()
      um-virt-pci: Make max delay configurable
      virt-pci: add platform bus support

Xiang Yang (1):
      um: vector: Fix memory leak in vector_config

Yang Li (1):
      um: remove unneeded semicolon

ye xingchen (1):
      um: Remove the unneeded result variable

 Documentation/rust/arch-support.rst     |   2 +
 arch/um/Kconfig                         |   7 ++
 arch/um/Makefile                        |   7 +-
 arch/um/drivers/Kconfig                 |   2 +
 arch/um/drivers/pcap_kern.c             |   4 +-
 arch/um/drivers/vector_kern.c           |   1 +
 arch/um/drivers/vector_user.h           |   2 -
 arch/um/drivers/virt-pci.c              | 139 ++++++++++++++++++++++++++++++--
 arch/um/drivers/virtio_uml.c            |  20 ++++-
 arch/um/include/asm/processor-generic.h |   2 +-
 arch/um/kernel/exec.c                   |   4 +-
 arch/um/kernel/tlb.c                    |   6 +-
 arch/um/kernel/um_arch.c                |   2 +-
 arch/um/kernel/vmlinux.lds.S            |   2 +-
 arch/um/os-Linux/irq.c                  |   4 +-
 arch/um/os-Linux/skas/mem.c             |  19 ++---
 arch/um/os-Linux/skas/process.c         | 121 ++++++++++++++-------------
 arch/x86/Makefile.um                    |   6 ++
 arch/x86/um/vdso/Makefile               |   2 +-
 arch/x86/um/vdso/um_vdso.c              |  12 ++-
 fs/hostfs/hostfs_kern.c                 |  15 ++--
 21 files changed, 268 insertions(+), 111 deletions(-)
