Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C7E742FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjF2Vyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF2VyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:54:22 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E0F3A96
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:54:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1b093c318b0so1022700fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688075655; x=1690667655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo4SI0ZZdp5y5LdeUtkVjTp5Ukyn89v3LaAcM7QXj80=;
        b=lREZlaI/4e71j0PoDE3GODWpnHZvzzadtisH2kw3Bd4iIJhe+oxZVVjJX+TLKtT1AN
         SxtirDCYI8+pQQ4v0kIJub362zB/G7+o09HTuwSO6/p9Th3RLzjkfSHcyl5yDvC2Jvp3
         HEkmaMVPIDVVkm4OsJ2BHqH5Ga4IDuAIAOnb7VWp8B2IMtTvAzVNSk4n8FMHw/1AmyaJ
         VHM3o68HAdrmqxBL3eQDnIMFLDR+ZsLIDvFLS6mUhWJQvv5SaiZjjQoasz3roxvImBdw
         rlyRknBb2UJLeU+Co6FlYitLZEZhMSc6N2bw2uZ1QH9BobUpkjiYNSCo7/BHCruiU4fF
         XyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688075655; x=1690667655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo4SI0ZZdp5y5LdeUtkVjTp5Ukyn89v3LaAcM7QXj80=;
        b=gdEd+KNRzv6r9ypJR25tH//OzsAykLcRZE3vvriF+D09VEZ+m1embsA/UrfaKIxf00
         EnfhZH8/Eun0fW/8MHgCGNReelMewPap0oKYlixx3WynDPBNa6uFrEUBo6NLSgMxi7Gz
         TBQUlicUDyfhgNpGGNXsHoLceaRnrMTtqnqaBwH+mEGhK644HxeGhN4sh8NBIspXaJ5T
         JsZ36xCf8nN8fekqSu3XD9bv2GOgn+/VR9tOUr8BMnD6qXD1dcBwPWcEloc7SaxVcft7
         KNiN3sUTi59IZcpi3vRI4ciipdz9DFA1yLAU4LYx+jl8R9bQixX4kxC1okw8cZoVeQdB
         WlEw==
X-Gm-Message-State: ABy/qLYDDpS2g8+j71V5jh/jMm0nSYx6OsxO7WUUN3Z/knUM1AtN2dD9
        zwO+tltqt2R82qtdK4fIzNrof6NPTVYYV+4r8evjzw==
X-Google-Smtp-Source: APBJJlEmXAkKSxp8c0Oo1M+N6TBRleb8fMUPCyYvMXR6viYtpSwcdOSDlFFbOmgfHSde+oYuAjDrmj8ELni3nhkbr8o=
X-Received: by 2002:a05:6871:60cb:b0:1b0:4e46:7f12 with SMTP id
 qz11-20020a05687160cb00b001b04e467f12mr874389oab.43.1688075654993; Thu, 29
 Jun 2023 14:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.705870770@linuxfoundation.org>
In-Reply-To: <20230629184151.705870770@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 29 Jun 2023 15:54:03 -0600
Message-ID: <CAEUSe7__cNqH6d1D96m8XriVckS9MnL6CRfd+iTYXnNkqu9nvQ@mail.gmail.com>
Subject: Re: [PATCH 6.3 00/29] 6.3.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Early report of failures.

Arm64 fails with GCC-11 on the following configurations:
* lkftconfig
* lkftconfig-64k_page_size
* lkftconfig-debug
* lkftconfig-debug-kmemleak
* lkftconfig-kasan
* lkftconfig-kselftest
* lkftconfig-kunit
* lkftconfig-libgpiod
* lkftconfig-perf
* lkftconfig-rcutorture

lkftconfig is basically defconfig + a few fragments [1]. The suffixes
mean that we're enabling a few other kconfigs.

Failure:
-----8<-----
/builds/linux/arch/arm64/mm/fault.c: In function 'do_page_fault':
/builds/linux/arch/arm64/mm/fault.c:576:9: error: 'vma' undeclared
(first use in this function); did you mean 'vmap'?
  576 |         vma =3D lock_mm_and_find_vma(mm, addr, regs);
      |         ^~~
      |         vmap
/builds/linux/arch/arm64/mm/fault.c:576:9: note: each undeclared
identifier is reported only once for each function it appears in
/builds/linux/arch/arm64/mm/fault.c:579:17: error: label 'done' used
but not defined
  579 |                 goto done;
      |                 ^~~~
make[4]: *** [/builds/linux/scripts/Makefile.build:252:
arch/arm64/mm/fault.o] Error 1
make[4]: Target 'arch/arm64/mm/' not remade because of errors.
----->8-----

We're expecting to see more failures on other architectures, and so
will follow-up with that.

[1] https://github.com/Linaro/meta-lkft/tree/kirkstone/meta/recipes-kernel/=
linux/files

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

On Thu, 29 Jun 2023 at 12:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.3.11 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 01 Jul 2023 18:41:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.3.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.3.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.3.11-rc1
>
> Ricardo Ca=C3=B1uelo <ricardo.canuelo@collabora.com>
>     Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource=
 leak in mtk_thermal_probe"
>
> Mike Hommey <mh@glandium.org>
>     HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.
>
> Jason Gerecke <jason.gerecke@wacom.com>
>     HID: wacom: Use ktime_t rather than int when dealing with timestamps
>
> Ludvig Michaelsson <ludvig.michaelsson@yubico.com>
>     HID: hidraw: fix data race on device refcount
>
> Zhang Shurong <zhang_shurong@foxmail.com>
>     fbdev: fix potential OOB read in fast_imageblit()
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     gup: add warning if some caller would seem to want stack expansion
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     mm: always expand the stack with the mmap write lock held
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     execve: expand new process stack manually ahead of time
>
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     mm: make find_extend_vma() fail if write lock not held
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     powerpc/mm: convert coprocessor fault to lock_mm_and_find_vma()
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     mm/fault: convert remaining simple cases to lock_mm_and_find_vma()
>
> Ben Hutchings <ben@decadent.org.uk>
>     arm/mm: Convert to using lock_mm_and_find_vma()
>
> Ben Hutchings <ben@decadent.org.uk>
>     riscv/mm: Convert to using lock_mm_and_find_vma()
>
> Ben Hutchings <ben@decadent.org.uk>
>     mips/mm: Convert to using lock_mm_and_find_vma()
>
> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/mm: Convert to using lock_mm_and_find_vma()
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     arm64/mm: Convert to using lock_mm_and_find_vma()
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     mm: make the page fault mmap locking killable
>
> Linus Torvalds <torvalds@linux-foundation.org>
>     mm: introduce new 'lock_mm_and_find_vma()' page fault helper
>
> Peng Zhang <zhangpeng.00@bytedance.com>
>     maple_tree: fix potential out-of-bounds access in mas_wr_end_piv()
>
> Oliver Hartkopp <socketcan@hartkopp.net>
>     can: isotp: isotp_sendmsg(): fix return error fix on TX path
>
> Wyes Karny <wyes.karny@amd.com>
>     cpufreq: amd-pstate: Make amd-pstate EPP driver name hyphenated
>
> Thomas Gleixner <tglx@linutronix.de>
>     x86/smp: Cure kexec() vs. mwait_play_dead() breakage
>
> Thomas Gleixner <tglx@linutronix.de>
>     x86/smp: Use dedicated cache-line for mwait_play_dead()
>
> Thomas Gleixner <tglx@linutronix.de>
>     x86/smp: Remove pointless wmb()s from native_stop_other_cpus()
>
> Tony Battersby <tonyb@cybernetics.com>
>     x86/smp: Dont access non-existing CPUID leaf
>
> Thomas Gleixner <tglx@linutronix.de>
>     x86/smp: Make stop_other_cpus() more robust
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     x86/microcode/AMD: Load late on both threads too
>
> David Woodhouse <dwmw@amazon.co.uk>
>     mm/mmap: Fix error return in do_vmi_align_munmap()
>
> Liam R. Howlett <Liam.Howlett@oracle.com>
>     mm/mmap: Fix error path in do_vmi_align_munmap()
>
>
> -------------
>
> Diffstat:
>
>  Makefile                                  |   4 +-
>  arch/alpha/Kconfig                        |   1 +
>  arch/alpha/mm/fault.c                     |  13 +--
>  arch/arc/Kconfig                          |   1 +
>  arch/arc/mm/fault.c                       |  11 +--
>  arch/arm/Kconfig                          |   1 +
>  arch/arm/mm/fault.c                       |  63 +++---------
>  arch/arm64/Kconfig                        |   1 +
>  arch/arm64/mm/fault.c                     |  44 ++-------
>  arch/csky/Kconfig                         |   1 +
>  arch/csky/mm/fault.c                      |  22 +----
>  arch/hexagon/Kconfig                      |   1 +
>  arch/hexagon/mm/vm_fault.c                |  18 +---
>  arch/ia64/mm/fault.c                      |  36 ++-----
>  arch/loongarch/Kconfig                    |   1 +
>  arch/loongarch/mm/fault.c                 |  16 ++--
>  arch/m68k/mm/fault.c                      |   9 +-
>  arch/microblaze/mm/fault.c                |   5 +-
>  arch/mips/Kconfig                         |   1 +
>  arch/mips/mm/fault.c                      |  12 +--
>  arch/nios2/Kconfig                        |   1 +
>  arch/nios2/mm/fault.c                     |  17 +---
>  arch/openrisc/mm/fault.c                  |   5 +-
>  arch/parisc/mm/fault.c                    |  23 +++--
>  arch/powerpc/Kconfig                      |   1 +
>  arch/powerpc/mm/copro_fault.c             |  14 +--
>  arch/powerpc/mm/fault.c                   |  39 +-------
>  arch/riscv/Kconfig                        |   1 +
>  arch/riscv/mm/fault.c                     |  31 +++---
>  arch/s390/mm/fault.c                      |   5 +-
>  arch/sh/Kconfig                           |   1 +
>  arch/sh/mm/fault.c                        |  17 +---
>  arch/sparc/Kconfig                        |   1 +
>  arch/sparc/mm/fault_32.c                  |  32 ++-----
>  arch/sparc/mm/fault_64.c                  |   8 +-
>  arch/um/kernel/trap.c                     |  11 ++-
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/include/asm/cpu.h                |   2 +
>  arch/x86/include/asm/smp.h                |   2 +
>  arch/x86/kernel/cpu/microcode/amd.c       |   2 +-
>  arch/x86/kernel/process.c                 |  28 +++++-
>  arch/x86/kernel/smp.c                     |  73 ++++++++------
>  arch/x86/kernel/smpboot.c                 |  81 ++++++++++++++--
>  arch/x86/mm/fault.c                       |  52 +---------
>  arch/xtensa/Kconfig                       |   1 +
>  arch/xtensa/mm/fault.c                    |  14 +--
>  drivers/cpufreq/amd-pstate.c              |   2 +-
>  drivers/hid/hid-logitech-hidpp.c          |   2 +-
>  drivers/hid/hidraw.c                      |   9 +-
>  drivers/hid/wacom_wac.c                   |   6 +-
>  drivers/hid/wacom_wac.h                   |   2 +-
>  drivers/iommu/amd/iommu_v2.c              |   4 +-
>  drivers/iommu/iommu-sva.c                 |   2 +-
>  drivers/thermal/mediatek/auxadc_thermal.c |  14 +--
>  drivers/video/fbdev/core/sysimgblt.c      |   2 +-
>  fs/binfmt_elf.c                           |   6 +-
>  fs/exec.c                                 |  38 ++++----
>  include/linux/mm.h                        |  16 ++--
>  lib/maple_tree.c                          |  11 ++-
>  mm/Kconfig                                |   4 +
>  mm/gup.c                                  |  14 ++-
>  mm/memory.c                               | 127 ++++++++++++++++++++++++=
+
>  mm/mmap.c                                 | 153 +++++++++++++++++++++++-=
------
>  mm/nommu.c                                |  17 ++--
>  net/can/isotp.c                           |   5 +-
>  65 files changed, 614 insertions(+), 544 deletions(-)
>
>
