Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5361D740AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjF1IOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjF1IMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:12:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53D3588
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:08:58 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6686ef86110so2963899b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687939738; x=1690531738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSn4tuQbZU5tpej8ySDKdoCTz3C/VKUeJEIDXrI8ApI=;
        b=GddAD7EzMPI2JNeGDVRRJkWhqY29b78VrQ5j8B255IdXwk8ae8xC2D27h0y898xTva
         O9OPMA2ipm7Luk7VApbxEupJeuc8iIxbN3oOhGKxOyO25mvEC5nSCG8cWfbY5ElvqYcA
         1yWlpCEhd+KS3bJD765iHJkFL69wN57NW4o3Pam2AQ3ALQ3LyGN0wiWQYbVtLxzlDNe2
         VCxww4x0Z3ReT8ELuFMEWHaDamW4BXIF/ekFPvVkgN03rcyuyqxgl82095r89OQfZuWa
         PJwalZ2ozZtrcqkPOQQZhyboTEDdgajsryDCvTMcq4l+YV4rxOc4XCE1J6J7v6FV695M
         WQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939738; x=1690531738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSn4tuQbZU5tpej8ySDKdoCTz3C/VKUeJEIDXrI8ApI=;
        b=DtN5e9Ch1Wm5KcoujlYQjR1O2skXZFKQT3hyBwyTk4Y7G7kJ/m4aodGNCwR6qumn0+
         dNQ4b4+kdV19WzpzQWPaoQMifZkKsGJiqf30dAKdVgauFdkebzNiBi8emgCyGXqcI1Zn
         jWNf0b5JgiU8/KrB2vmM+Kj+/k7vVmvlArmL1aj48IsMiluy7ovzGaCifzbIIgAwdHt4
         ElBZP4l+qoQpN00yUGC5jfRmsf0edBpQlOnfq5XT2ocdYPbLL6rLd+Ft3pkrHcgHPHbe
         HaZUJhKaqLtuFB18LnouH//ab1M4w3uzGV9Sishhd25abXTRKPjORu5N6jniSf0DroMA
         ntXA==
X-Gm-Message-State: AC+VfDzo1Hbt85PE4SzOdNCpsWIxWJWx+FcWgveQGfD7S0fkwganXGBV
        9CfAC4rN5hXrcr0ISdpWOAP3fhj82icN+6krsCzDrUn1C6BIQT9K/ADW9A==
X-Google-Smtp-Source: ACHHUZ7t44iUD/uayELXJZDpQD9e5qu/zLWUfEGQ4HOTGsdJOeGEWwlqjUuEh6jUUU001f88X4GQWC028YZtissqo8E=
X-Received: by 2002:a67:f309:0:b0:443:6052:43a7 with SMTP id
 p9-20020a67f309000000b00443605243a7mr3835859vsf.32.1687935587369; Tue, 27 Jun
 2023 23:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180736.243379844@linuxfoundation.org>
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 28 Jun 2023 12:29:23 +0530
Message-ID: <CA+G9fYvdQOWt6uq4CHViVfiOzP9dOcvES_0vRCgsSg-p1qkpCQ@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/41] 4.19.288-rc1 review
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 23:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.288 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.288-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.288-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: d46c55c4b242c7dc4d40b4b2a0fb5dbac24ae5cd
* git describe: v4.19.287-42-gd46c55c4b242
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.287-42-gd46c55c4b242

## Test Regressions (compared to v4.19.287)

## Metric Regressions (compared to v4.19.287)

## Test Fixes (compared to v4.19.287)

## Metric Fixes (compared to v4.19.287)

## Test result summary
total: 65773, pass: 51942, fail: 1892, skip: 11895, xfail: 44

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 111 total, 106 passed, 5 failed
* arm64: 37 total, 32 passed, 5 failed
* i386: 21 total, 18 passed, 3 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 12 total, 12 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 26 passed, 5 failed

## Test suites summary
* boot
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
* kselftest-x86
* kselftest-zram
* kunit
* libhugetlbfs
* log-parser-boot
* log-parser-test
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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
