Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4A64C2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 05:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237400AbiLNEE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 23:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiLNEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 23:04:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3B1AA24
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:04:47 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id r18so1184859pgr.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQt5vmWNOYImcx88xRRm26FyZREKL6BjzFiX1hvI6Vg=;
        b=VjmDhHepmfUEnQccFYiwt7Dlq6KQP7BINTCd7o2YXW6vaaQR3dSwPKux5kqY2OlGyY
         NZPqSRPzrAJLAehjaxEjwszjuIEjhSN5jjKswrrBoIag4XsoCdW+MRYKi8sUYunWVVtd
         5BWz50E9diQghXUIf60DxCQdAXZTRHWPe4zhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQt5vmWNOYImcx88xRRm26FyZREKL6BjzFiX1hvI6Vg=;
        b=S2zBphw0huUNMOn6VNwL9iOHTJawuEFKn+WAKSAD2+h3gMvKPlTUrO1i1kITGWXZ/E
         I4aFIYlXid06RDJQRLAeLRp7FPk9GllAqaFRWfGLa+PNW2JX9eEVVrEbKQEezJPnq2RS
         38UqV0VLnlcMMQWk2ZvpBulbDjaVa8CQJ8Vx7wyKmWzECBMUbhwhIw/ARmr173P2Xj+R
         3l+xQie77hJlh/CgGRtLO0I+LF9g09sBbVc3EdWL43Xle5jTR4cmPvexdMuftgF/2qAJ
         PiDgvboJSljN6mIFaqZdiNC9Bdstnn/v522cP2ZQZIYHyKU1jSMwVZK7HSMoSmsV3eML
         87rw==
X-Gm-Message-State: ANoB5ply/2eK15pqimbeBXmJX+GK5K3JVU+UO4DVnAZc359PND9dUE9H
        P7TuhVTEFQmz3hUSVWhzs4/GnQ==
X-Google-Smtp-Source: AA0mqf5RjmddANWQHs4HCwxfe9mmCGS3+IpZPehGLaE6VCHmIZnfsaOnk1CL1tLvvtYmVc9gCps7Fg==
X-Received: by 2002:aa7:8252:0:b0:574:c62c:2f55 with SMTP id e18-20020aa78252000000b00574c62c2f55mr21575418pfn.3.1670990686523;
        Tue, 13 Dec 2022 20:04:46 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b0056bc742d21esm8654559pfd.176.2022.12.13.20.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 20:04:46 -0800 (PST)
Date:   Tue, 13 Dec 2022 20:04:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        David Gow <davidgow@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "haifeng.xu" <haifeng.xu@shopee.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Xin Li <xin3.li@intel.com>
Subject: [GIT PULL] kernel hardening updates for v6.2-rc1
Message-ID: <202212131955.22F9FD9AB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardening updates for v6.2-rc1. This tree's various
collected improvements, noted below, have been in -next for a while
now. The only merge note I have is that this tree's ksize() work depends
on behavioral changes in the slab and netdev trees, but those trees have
now been merged into your tree, so there should be no surprises.

Thanks!

-Kees

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.2-rc1

for you to fetch changes up to d272e01fa0a2f15c5c331a37cd99c6875c7b7186:

  ksmbd: replace one-element arrays with flexible-array members (2022-12-02 13:14:29 -0800)

----------------------------------------------------------------
hardening updates for v6.2-rc1

- Convert flexible array members, fix -Wstringop-overflow warnings,
  and fix KCFI function type mismatches that went ignored by
  maintainers (Gustavo A. R. Silva, Nathan Chancellor, Kees Cook).

- Remove the remaining side-effect users of ksize() by converting
  dma-buf, btrfs, and coredump to using kmalloc_size_roundup(),
  add more __alloc_size attributes, and introduce full testing
  of all allocator functions. Finally remove the ksize() side-effect
  so that each allocation-aware checker can finally behave without
  exceptions.

- Introduce oops_limit (default 10,000) and warn_limit (default off)
  to provide greater granularity of control for panic_on_oops and
  panic_on_warn (Jann Horn, Kees Cook).

- Introduce overflows_type() and castable_to_type() helpers for
  cleaner overflow checking.

- Disable structleak plugin in FORTIFY KUnit test (Anders Roxell).

- Adjust orphan linker section checking to respect CONFIG_WERROR
  (Xin Li).

- Make sure siginfo is cleared for forced SIGKILL (haifeng.xu).

- Improve code generation for strscpy() and update str*() kern-doc.

- Convert strscpy and sigphash tests to KUnit, and expand memcpy
  tests.

- Always use a non-NULL argument for prepare_kernel_cred().

- Fix um vs FORTIFY warnings for always-NULL arguments.

----------------------------------------------------------------
Anders Roxell (1):
      lib: fortify_kunit: build without structleak plugin

Gustavo A. R. Silva (2):
      mm/pgtable: Fix multiple -Wstringop-overflow warnings
      ksmbd: replace one-element arrays with flexible-array members

Jann Horn (1):
      exit: Put an upper limit on how often we can oops

Kees Cook (27):
      overflow: Fix kern-doc markup for functions
      overflow: Refactor test skips for Clang-specific issues
      fortify: Capture __bos() results in const temp vars
      string: Rewrite and add more kern-doc for the str*() functions
      kunit/memcpy: Add dynamic size and window tests
      string: Add __realloc_size hint to kmemdup()
      string: Convert strscpy() self-test to KUnit
      fortify: Short-circuit known-safe calls to strscpy()
      siphash: Convert selftest to KUnit
      fortify: Do not cast to "unsigned char"
      cred: Do not default to init_cred in prepare_kernel_cred()
      dma-buf: Proactively round up to kmalloc bucket size
      btrfs: send: Proactively round up to kmalloc bucket size
      coredump: Proactively round up to kmalloc bucket size
      overflow: Introduce overflows_type() and castable_to_type()
      Merge branch 'for-linus/hardening' into for-next/hardening
      driver core: Add __alloc_size hint to devm allocators
      kunit/fortify: Validate __alloc_size attribute results
      mm: Make ksize() a reporting-only function
      panic: Separate sysctl logic from CONFIG_SMP
      exit: Expose "oops_count" to sysfs
      exit: Allow oops_limit to be disabled
      panic: Consolidate open-coded panic_on_warn checks
      panic: Introduce warn_limit
      panic: Expose "warn_count" to sysfs
      um: virt-pci: Avoid GCC non-NULL warning
      hpet: Replace one-element array with flexible-array member

Nathan Chancellor (3):
      vmlinux.lds.h: Fix placement of '.data..decrypted' section
      drm/fsl-dcu: Fix return type of fsl_dcu_drm_connector_mode_valid()
      drm/sti: Fix return type of sti_{dvo,hda,hdmi}_connector_mode_valid()

Nick Desaulniers (1):
      overflow: disable failing tests for older clang versions

Xin Li (1):
      kbuild: upgrade the orphan section warning to an error if CONFIG_WERROR is set

haifeng.xu (1):
      signal: Initialize the info in ksignal

 Documentation/ABI/testing/sysfs-kernel-oops_count |   6 +
 Documentation/ABI/testing/sysfs-kernel-warn_count |   6 +
 Documentation/admin-guide/sysctl/kernel.rst       |  19 +
 Documentation/core-api/kernel-api.rst             |   9 +
 Documentation/driver-api/basics.rst               |   3 -
 MAINTAINERS                                       |   6 +-
 Makefile                                          |   2 +-
 arch/arm/boot/compressed/Makefile                 |   2 +-
 arch/arm64/kernel/vdso/Makefile                   |   2 +-
 arch/arm64/kernel/vdso32/Makefile                 |   2 +-
 arch/um/drivers/virt-pci.c                        |   9 +-
 arch/x86/boot/compressed/Makefile                 |   2 +-
 arch/x86/mm/pgtable.c                             |  22 +-
 drivers/base/firmware_loader/main.c               |   2 +-
 drivers/dma-buf/dma-resv.c                        |   9 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c         |   5 +-
 drivers/gpu/drm/i915/i915_user_extensions.c       |   2 +-
 drivers/gpu/drm/i915/i915_utils.h                 |   4 -
 drivers/gpu/drm/sti/sti_dvo.c                     |   5 +-
 drivers/gpu/drm/sti/sti_hda.c                     |   5 +-
 drivers/gpu/drm/sti/sti_hdmi.c                    |   5 +-
 fs/btrfs/send.c                                   |  11 +-
 fs/cifs/cifs_spnego.c                             |   2 +-
 fs/cifs/cifsacl.c                                 |   2 +-
 fs/coredump.c                                     |   7 +-
 fs/ksmbd/smb2pdu.c                                |   4 +-
 fs/ksmbd/smb2pdu.h                                |   2 +-
 fs/ksmbd/smb_common.c                             |   2 +-
 fs/ksmbd/smb_common.h                             |  12 +-
 fs/nfs/flexfilelayout/flexfilelayout.c            |   4 +-
 fs/nfs/nfs4idmap.c                                |   2 +-
 fs/nfsd/nfs4callback.c                            |   2 +-
 include/asm-generic/vmlinux.lds.h                 |   2 +-
 include/linux/compiler.h                          |   1 +
 include/linux/device.h                            |   7 +-
 include/linux/fortify-string.h                    | 161 +++++++-
 include/linux/hpet.h                              |   2 +-
 include/linux/overflow.h                          |  85 +++--
 include/linux/panic.h                             |   1 +
 include/linux/string.h                            |   2 +-
 init/Kconfig                                      |  15 +-
 kernel/cred.c                                     |  15 +-
 kernel/exit.c                                     |  60 +++
 kernel/kcsan/report.c                             |   3 +-
 kernel/panic.c                                    |  45 ++-
 kernel/sched/core.c                               |   3 +-
 kernel/signal.c                                   |   1 +
 lib/Kconfig.debug                                 |  28 +-
 lib/Makefile                                      |   7 +-
 lib/fortify_kunit.c                               | 255 +++++++++++++
 lib/memcpy_kunit.c                                | 205 +++++++++++
 lib/overflow_kunit.c                              | 428 +++++++++++++++++++++-
 lib/{test_siphash.c => siphash_kunit.c}           | 165 ++++-----
 lib/string.c                                      |  82 -----
 lib/strscpy_kunit.c                               | 142 +++++++
 lib/test_strscpy.c                                | 150 --------
 lib/ubsan.c                                       |   3 +-
 mm/kasan/kasan_test.c                             |  19 +-
 mm/kasan/report.c                                 |   4 +-
 mm/kfence/report.c                                |   3 +-
 mm/slab_common.c                                  |  26 +-
 net/dns_resolver/dns_key.c                        |   2 +-
 scripts/kernel-doc                                |   6 +-
 63 files changed, 1601 insertions(+), 504 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-oops_count
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-warn_count
 rename lib/{test_siphash.c => siphash_kunit.c} (60%)
 create mode 100644 lib/strscpy_kunit.c
 delete mode 100644 lib/test_strscpy.c

-- 
Kees Cook
