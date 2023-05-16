Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA2704D47
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEPMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEPMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:04:22 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E910D7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:04:20 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-783ef1c0cfdso127366241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684238659; x=1686830659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClAd7kaJxhhiqMPyIHCwtBikQzkldIOZUtX2fRaU4lE=;
        b=QZo9npq+JCKzLkhoeg9ayogi3R2kQI9jOax1xXK2LQYuOAm+L/a7U4lTUZtboluA72
         zw65D5qmoQTPVhGBC1pg2YqlOxgLt0n44P9t5+cU0XJCeC4PDC1HNk00vtO81LluJRqg
         HsWLjLhlvDIsBUQu5ELGimSe6Nt+mIJscHmh2APyq+3YaN615xFfnVBHjfOQ9gD7TpSm
         HubM8U87Md8+wzhM8pyVzdbTiLiutaeFOdU7x7rQR//cx7zYqBxQTzXa4mr/kBuFhkf6
         uS5K9NNQGvQen4dqQlBf16yezfy7brVyXmQH5dwO/Gm9aYb5ZLXRtVC2Hpflvbbp4GeL
         ZVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684238659; x=1686830659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClAd7kaJxhhiqMPyIHCwtBikQzkldIOZUtX2fRaU4lE=;
        b=ZLTtQgE/OTMCDC0cC7PgM0w6IKJ3sX0RJ+Ll6lPWAFGq7uJ94mrrigM4sfrZ07geFU
         FcySk4xGVpsBSiaEfVAbxest6IAR7W9+Km5SW2svbPyR0eY5t/0GhhIohmpZUpSLEaer
         Mr58WwdhB0RMI9IVgMgF9Pq8rNLJ5zs5s1zrX75fmVcy3cMmt29zG/pvTvGxdockwXqo
         MIH1xldjxQuBwbL/pMO+Y/2Db37tgjqbeGeA5ngI62RM/INDJxeTwmE+OFTK/unVjj4G
         S6kX7e3rZdmCn0vy4n7xdf9UD/+1fuyNlmFdQ7J+GZboMZ4p/MVHrQqg2TMorkblN0fZ
         YPjQ==
X-Gm-Message-State: AC+VfDwrzy/q6T9rN+hfzmrSvjNVNTFrPdwTRBE73pYGbrgV0vZ1X2T6
        WUMPxaPxA+zsKcda3VuSwDlvmVXJf0/dkf0VH0BUdmoksRWeJbzpjtbn4A==
X-Google-Smtp-Source: ACHHUZ49uZYsYDaDRYtoIDZDcaWVG4RZfAPVRGC5Hy5OgI916EGbdwAu0anrxy5g4iK+N/xyPuYR0pqw/cAGNNf2HP0=
X-Received: by 2002:a05:6102:6d0:b0:436:50b6:efdb with SMTP id
 m16-20020a05610206d000b0043650b6efdbmr4247374vsg.3.1684238659339; Tue, 16 May
 2023 05:04:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161721.802179972@linuxfoundation.org>
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 16 May 2023 17:34:08 +0530
Message-ID: <CA+G9fYt6ZCmUykF3TLvgwCh7EdERDeN9ZgmGmjm54o1QgpOWZA@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 at 22:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.2.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm, x86_64, and i386.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

LTP commands test case mkfs01_ntfs_sh fails on following stable-rc
 - 6.2.16-rc1.
 - 6.1.29-rc1
 - 5.15.112-rc1
 - 5.10.180-rc1
 - 5.4.243-rc1
 - 4.19.283-rc1
 - 4.14.315-rc1

LTP commands,
  - mkfs01_ntfs_sh

Test log:
=3D=3D=3D=3D=3D=3D=3D
tst_device.c:93:[  147.226163] loop0: detected capacity change from 0 to 61=
4400
 TINFO: Found free device 0 '/dev/loop0'
mkfs01 1 TINFO: timeout per run is 0h 50m 0s
mkfs01 1 TPASS: 'mkfs -t ntfs  /dev/loop0 ' passed.
mkfs01 2 TINFO: Mounting device: mount -t ntfs /dev/loop0
/scratch/ltp-zKu0Zn6L6o/LTP_mkfs01.ULVi9nN6XF/mntpoint
modprobe: FATAL: Module fuse not found in directory /lib/modules/6.2.16-rc1
ntfs-3g-mount: fuse device is missing, try 'modprobe fuse' as root
mkfs01 2 TBROK: Failed to mount device ntfs type: mount exit =3D 21
[  166.420602] I/O error, dev loop0, sector 614272 op 0x0:(READ) flags
0x80700 phys_seg 1 prio class 2


Test log:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.=
2.15-243-g704eace42a14/testrun/17019981/suite/ltp-commands/test/mkfs01_ntfs=
_sh/log

Test history:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.=
1.28-240-gb82733c0ff99/testrun/17019910/suite/ltp-commands/test/mkfs01_ntfs=
_sh/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.=
2.15-243-g704eace42a14/testrun/17020198/suite/ltp-commands/test/mkfs01_ntfs=
_sh/history/


## Build
* kernel: 6.2.16-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.2.y
* git commit: 704eace42a1426c1ef49afee9db673752a7b7c73
* git describe: v6.2.15-243-g704eace42a14
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.2.y/build/v6.2.1=
5-243-g704eace42a14

## Test Regressions (compared to v6.2.15)

* x15, ltp-commands
  - mkfs01_ntfs_sh

* x86, ltp-commands
  - mkfs01_ntfs_sh


* x86-kasan, ltp-commands
  - mkfs01_ntfs_sh

* x86_64-clang, ltp-commands
  - mkfs01_ntfs_sh


## Metric Regressions (compared to v6.2.15)

## Test Fixes (compared to v6.2.15)

## Metric Fixes (compared to v6.2.15)

## Test result summary
total: 178929, pass: 153909, fail: 3053, skip: 21665, xfail: 302

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 142 passed, 3 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 38 passed, 3 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 16 passed, 0 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 46 total, 46 passed, 0 failed

## Test suites summary
* boot
* fwts
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-vm
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-cap_bo[
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-fsx
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* perf
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
