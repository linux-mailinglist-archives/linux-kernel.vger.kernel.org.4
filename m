Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779F569B337
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBQTiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjBQTiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:38:21 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5FF5B2EB
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:38:20 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id i10-20020a17090a7e0a00b002341a2656e5so2249044pjl.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKKsXZajqAwe6W3hq4W4TjLXNRRTkhvXVuDWAa55fyY=;
        b=mUGUUwMmQdL7yiJ3A/3vV6P1wMLI6SAVScK7i+EWcuQRo+kxjv+fWFNz3IolqSBkyN
         1TJHCL6b1B4soEF0g++QCLyyqwBlCRxdR2mQaPTI5y8hDHATNGjB8RcGzcXu4FhSao/5
         ZOiQCMyCf4SgpUK4gSE26ZtSsFcC5pmMOIvus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKKsXZajqAwe6W3hq4W4TjLXNRRTkhvXVuDWAa55fyY=;
        b=ko0rOoeuUj+1Y0u/zJeYxBGIc6P3IJHC0GuDrFdAmFNhYhSaBf1zNErv4gFbAVLCT9
         aWGVJtyJAF78lKdZyweL8p62n0+RUk/p31lhsDo/U1NXedaKUgBUmypIq4nnSTX5G85g
         DkEK3Tl24td5JbSwhB/spgLAdTObtdI+lZ7nlYWxWM9LCoAjvjPIerDGSMjb2Z2YRJwT
         U9JZHL7U7mAUTTFsaibErM4T3t8s+rAAWebkTIJuN87ZNjr3d+qYsRKKjHwv2HzWuK4V
         5jJgfxSp5ZvLowAmzA+fuyOTmRIForFwm5j+LwwtUVYMixa6GjAtiNuH+5JEeWf4sM2o
         sp7g==
X-Gm-Message-State: AO0yUKXdnMZuKm3sfSAZq+gakB1o9FwDW+jzq8KPvEAAb9IjtPdY1jmQ
        P+dB5HZdMAVvfYL0d1wjPIs63g==
X-Google-Smtp-Source: AK7set+lYu6pNIj7bPGyNSwL2YoZiIEshkV7Lx/VqDnn/qlpC8zu4ILCO1HILl2dofPETM+U9dqiBw==
X-Received: by 2002:a17:90b:1bd2:b0:233:c3e7:bd3b with SMTP id oa18-20020a17090b1bd200b00233c3e7bd3bmr1501084pjb.10.1676662700260;
        Fri, 17 Feb 2023 11:38:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b00230e2b6f89esm3241765pjl.12.2023.02.17.11.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 11:38:19 -0800 (PST)
Message-ID: <63efd7ab.170a0220.3442b.6609@mx.google.com>
X-Google-Original-Message-ID: <202302171129.@keescook>
Date:   Fri, 17 Feb 2023 11:38:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>,
        Sam James <sam@gentoo.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-hardening@vger.kernel.org
Subject: [GIT PULL] hardening updates for v6.3-rc1
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

Please pull these hardening updates for v6.3-rc1. Beyond some specific
LoadPin, UBSAN, and fortify features, there are other fixes scattered
around in various subsystems where maintainers were okay with me carrying
them in my tree or were non-responsive but the patches were reviewed
by others.

Thanks!

-Kees

The following changes since commit be0d8f48ad97f5b775b0af3310343f676dbf318a:

  bcache: Silence memcpy() run-time false positive warnings (2023-01-25 12:24:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.3-rc1

for you to fetch changes up to 78f7a3fd6dc66cb788c21d7705977ed13c879351:

  randstruct: disable Clang 15 support (2023-02-08 15:26:58 -0800)

----------------------------------------------------------------
hardening updates for v6.3-rc1

- Replace 0-length and 1-element arrays with flexible arrays in various
  subsystems (Paulo Miguel Almeida, Stephen Rothwell, Kees Cook)

- randstruct: Disable Clang 15 support (Eric Biggers)

- GCC plugins: Drop -std=gnu++11 flag (Sam James)

- strpbrk(): Refactor to use strchr() (Andy Shevchenko)

- LoadPin LSM: Allow root filesystem switching when non-enforcing

- UBSAN: Improve arm64 trap code reporting

- fortify: Use dynamic object size hints when available

- ext4: Fix CFI function prototype mismatch

- Nouveau: Fix DP buffer size arguments

- hisilicon: Wipe entire crypto DMA pool on error

- coda: Fully allocate sig_inputArgs

- copy_struct_from_user(): Add minimum bounds check on kernel buffer size

----------------------------------------------------------------
Andy Shevchenko (1):
      lib/string: Use strchr() in strpbrk()

Eric Biggers (1):
      randstruct: disable Clang 15 support

Kees Cook (15):
      fortify: Use __builtin_dynamic_object_size() when available
      ARM: ixp4xx: Replace 0-length arrays with flexible arrays
      LoadPin: Refactor read-only check into a helper
      LoadPin: Refactor sysctl initialization
      LoadPin: Move pin reporting cleanly out of locking
      LoadPin: Allow filesystem switch when not enforcing
      drm/nouveau/disp: Fix nvif_outp_acquire_dp() argument size
      ext4: Fix function prototype mismatch for ext4_feat_ktype
      io_uring: Replace 0-length array with flexible array
      net/i40e: Replace 0-length array with flexible array
      crypto: hisilicon: Wipe entire pool on error
      Merge branch 'for-linus/hardening' into for-next/hardening
      coda: Avoid partial allocation of sig_inputArgs
      arm64: Support Clang UBSAN trap codes for better reporting
      uaccess: Add minimum bounds check on kernel buffer size

Paulo Miguel Almeida (1):
      i915/gvt: Replace one-element array with flexible-array member

Sam James (1):
      gcc-plugins: drop -std=gnu++11 to fix GCC 13 build

Stephen Rothwell (1):
      rxrpc: replace zero-lenth array with DECLARE_FLEX_ARRAY() helper

 arch/arm64/include/asm/brk-imm.h            |  3 +
 arch/arm64/kernel/traps.c                   | 21 +++++++
 drivers/crypto/hisilicon/sgl.c              |  3 +-
 drivers/gpu/drm/i915/gvt/firmware.c         |  4 +-
 drivers/gpu/drm/nouveau/include/nvif/outp.h |  3 +-
 drivers/gpu/drm/nouveau/nvif/outp.c         |  2 +-
 drivers/misc/lkdtm/heap.c                   |  1 +
 drivers/net/ethernet/intel/i40e/i40e.h      |  2 +-
 drivers/soc/ixp4xx/ixp4xx-npe.c             |  6 +-
 fs/coda/upcall.c                            |  2 +-
 fs/ext4/sysfs.c                             |  7 ++-
 include/linux/compiler_attributes.h         |  5 ++
 include/linux/fortify-string.h              |  7 +++
 include/linux/uaccess.h                     |  4 ++
 include/linux/ubsan.h                       |  9 +++
 include/uapi/linux/io_uring.h               |  2 +-
 lib/Makefile                                |  2 -
 lib/string.c                                | 10 ++--
 lib/ubsan.c                                 | 68 ++++++++++++++++++++++
 lib/ubsan.h                                 | 32 +++++++++++
 net/rxrpc/ar-internal.h                     |  2 +-
 scripts/gcc-plugins/Makefile                |  2 +-
 security/Kconfig.hardening                  |  3 +
 security/loadpin/loadpin.c                  | 89 +++++++++++++++++------------
 24 files changed, 229 insertions(+), 60 deletions(-)
 create mode 100644 include/linux/ubsan.h

-- 
Kees Cook
