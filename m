Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6AD65EFD7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbjAEPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 10:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjAEPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 10:18:49 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AF25C930
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 07:18:28 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id t2so8433955vkk.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 07:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UcGhj1fWzMBjio5nPbCBvm4l5bqnUYX6YD0JwGx4dxg=;
        b=meWLS9NU+Y3YtvvQJS71Z9odvgeKiXGhWUT9NYGY5/bnOvz++UYSDsM7nF02c0SzMn
         3NDg/KwpuoEftJdQvhwR8rPAJQ2JxZ6cEs/NG7U7dEgRLiBlN1Q4CR2ekOkrglCbHbG8
         NlD0hIO+bsDRXAkJznh3cPGRCglwvdht2w8GK1wnXxJdMG0GfoZPZio/SIuaCaz3+Yf5
         gfCmtUHu8qx9s179gEy4DG27g2uKMpTygors/xviFJN23m3LoprMcWvtjUILy8FRq4Uu
         6rua9yrFmIaAdHqQ1tPhr8lWaKDnJq3nnoHVfG7/SjzUWCnEJd1DoxZwO9F3GEPCPYBg
         nKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UcGhj1fWzMBjio5nPbCBvm4l5bqnUYX6YD0JwGx4dxg=;
        b=ohtlpWd5BGSszyUjF3Ygu0D5KzMqifW/sa3rJgiIVqnnLLPBMUJHRN/uUD/uDF4E8K
         6o2gswXWixTft5wi1VP5rt2pvrXcsW9dNzmP/vCIwFckMnRq7THCzu44XHJFYq6FAvnu
         5dqauxTM+SvC9NDmQ4UHAoKXNhTnW7jzab43vz8/MmSsHgzeoSm6bUyNRYR1uNCEv6DD
         iLZv/CsWY2Rf9OaFeYcaAXWgNz+Bopr9CEz4MdfzRbvlTEauSY7X+YxuBwnbCjL344CN
         fKoRb3+AVg6QT4jA2iag33zLIjPWYqZxwzZe62957+b9228trHMXmCCmo0Axj8SQ7ZSL
         iK6A==
X-Gm-Message-State: AFqh2kr54GXzDqNfYKhFJzhd5U1c66cZdKTKGH9TxZnZ/zr1JK4yjEEL
        H3UqZoO/n2Ddi79ycp+SNQ+hOsUzDH52ZYcOsohrDw==
X-Google-Smtp-Source: AMrXdXv+/VSMgynXqQpmsyBzO7isr1WOZJtTaF/1AnM7s//bGzTRjfKyoZFdmXyQ2hX1KPv8cG92bBRBhajW8vCeWKA=
X-Received: by 2002:a1f:6282:0:b0:3d5:555e:49c5 with SMTP id
 w124-20020a1f6282000000b003d5555e49c5mr3967985vkb.39.1672931907075; Thu, 05
 Jan 2023 07:18:27 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Jan 2023 20:48:15 +0530
Message-ID: <CA+G9fYvj4kuaup=kXtFPDRu7YouayJyU_3wNykO7bX=Scsnn+g@mail.gmail.com>
Subject: next: arm64: ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko]
 undefined!
To:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        brendan.higgins@linux.dev, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following arm64 kunit enabled build failed with gcc-12.

ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko] undefined!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------------
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc' olddefconfig
.config:10084:warning: override: TRANSPARENT_HUGEPAGE_MADVISE changes
choice state
make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- ARCH=arm64
CROSS_COMPILE=aarch64-linux-gnu- 'CC=sccache aarch64-linux-gnu-gcc'
'HOSTCC=sccache gcc'
In file included from /builds/linux/include/asm-generic/rwonce.h:26,
                 from /builds/linux/arch/arm64/include/asm/rwonce.h:71,
                 from /builds/linux/include/linux/compiler.h:247,
                 from /builds/linux/include/linux/export.h:33,
                 from /builds/linux/include/linux/linkage.h:7,
                 from /builds/linux/include/linux/kernel.h:17,
                 from /builds/linux/fs/btrfs/ioctl.c:6:
/builds/linux/include/linux/kasan-checks.h: In function 'btrfs_ioctl_wait_sync':
/builds/linux/include/linux/kasan-checks.h:38:27: warning: 'transid'
may be used uninitialized [-Wmaybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
      |                           ^~~~~~~~~~~~~~~~~~~
/builds/linux/include/linux/kasan-checks.h:20:6: note: by argument 1
of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/builds/linux/fs/btrfs/ioctl.c:3134:13: note: 'transid' declared here
 3134 |         u64 transid;
      |             ^~~~~~~
/builds/linux/include/linux/kasan-checks.h: In function 'btrfs_ioctl':
/builds/linux/include/linux/kasan-checks.h:38:27: warning:
'space_args' may be used uninitialized [-Wmaybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
      |                           ^~~~~~~~~~~~~~~~~~~
/builds/linux/include/linux/kasan-checks.h:20:6: note: by argument 1
of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/builds/linux/fs/btrfs/ioctl.c:2973:39: note: 'space_args' declared here
 2973 |         struct btrfs_ioctl_space_args space_args;
      |                                       ^~~~~~~~~~
/builds/linux/include/linux/kasan-checks.h:38:27: warning: 'args32'
may be used uninitialized [-Wmaybe-uninitialized]
   38 | #define kasan_check_write __kasan_check_write
      |                           ^~~~~~~~~~~~~~~~~~~
/builds/linux/include/linux/kasan-checks.h:20:6: note: by argument 1
of type 'const volatile void *' to '__kasan_check_write' declared here
   20 | bool __kasan_check_write(const volatile void *p, unsigned int size);
      |      ^~~~~~~~~~~~~~~~~~~
/builds/linux/fs/btrfs/ioctl.c:4320:49: note: 'args32' declared here
 4320 |                 struct btrfs_ioctl_send_args_32 args32;
      |                                                 ^~~~~~
ERROR: modpost: "kunit_running" [drivers/gpu/drm/vc4/vc4.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:137:
Module.symvers] Error 1
make[2]: Target '__modpost' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1967: modpost] Error 2

build log:
-----------
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230105/testrun/13988421/suite/build/test/gcc-12-lkftconfig-kunit/log

Easy steps to reproduce with tuxmake:
-------------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig defconfig --kconfig-add
https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/lkft-crypto.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/distro-overrides.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/systemd.config
--kconfig-add https://raw.githubusercontent.com/Linaro/meta-lkft/kirkstone/meta/recipes-kernel/linux/files/virtio.config
--kconfig-add CONFIG_ARM64_MODULE_PLTS=y --kconfig-add
CONFIG_SYN_COOKIES=y --kconfig-add CONFIG_SCHEDSTATS=y --kconfig-add
CONFIG_KASAN=y --kconfig-add CONFIG_KUNIT=y --kconfig-add
CONFIG_KUNIT_ALL_TESTS=y CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-

tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2JtJj8Fpj9wmxgtyz3nkpqOFHdf/config
CROSS_COMPILE_COMPAT=arm-linux-gnueabihf-


--
Linaro LKFT
https://lkft.linaro.org
