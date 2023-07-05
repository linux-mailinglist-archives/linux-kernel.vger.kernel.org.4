Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9935474895F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjGEQjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjGEQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:39:50 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36CF1735
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:39:49 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-38e04d1b2b4so4930929b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688575189; x=1691167189;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI9CLsm2oW8kfbs1hBH+e/0ERX071RcI8E72ekQXPDA=;
        b=gmFBtYFhwJ+7phVUY43QG+hVEi6c/vJc/q4QqqB04Fz/eh2KF7q49kSkFQq/ZYWvEb
         XLzUf/gY61oKMM35EUkP1NjDlAuTD55LKptgOxTECNm+9hoLWOB2GpbWvR4AJU7/emwm
         z1NWJQoY53o/DLZf0gQUXvTtAyo/dLEwJcuSA3Tos1SOtXRWm97IpA4pCgtkcYFoYO/g
         lgjn3OtVq8CWqcjX3KbeLNqj96Dl2uMALNZPFkmU3zuWEwjjOLn7DU73gfLH5LNRGqjM
         orS+u388qp9m712ulamDgCJZJyEqLvITp7nM7dPLUy/Ic0SZSphAQQalmZCFUBE0imqf
         ApSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688575189; x=1691167189;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EI9CLsm2oW8kfbs1hBH+e/0ERX071RcI8E72ekQXPDA=;
        b=fscB3FyQ0DRmThwlVVsu7SmXBH+PQ22P++XmuIDYh3BqCfS0E5xVeITSlSl2FaZRyp
         k5MzP9tmAbfzI9VewQgYaPyymccBZXS/NgeEXD2fmS3nv+CDQdGJU6rVyHOeWdWrUnET
         P6XrGmFiTctQz1EzAEjpSPq/UIqklCnO5YQwmqbiDXk5DWcI9YMezDBTrJzj0TaOOaNq
         Rbtb2ELvcRxG1rZIxBZBGUzzhRglcj4t00Wa1PCfahF810gXr9Y4hgdL4JcfKkzfdH9x
         zaDfqfp8x/AAEWf82LYSkTKebut5fj3Kseyl6MN+LIFYUjZjwh0+xaJP+txiFh+WZnzA
         WAcw==
X-Gm-Message-State: AC+VfDxfVxfe6DVt4zIm2UMw/QROr6nTx0RLQ9OXZEzBGGCBJ3yxfeYs
        SL0uPlx0GrB0827pPK4/aBQ83kCRPzuvN5PdP+JTaw==
X-Google-Smtp-Source: ACHHUZ502PDYk+ukxq96sLxd2mbe+JQAKHgFVAKWl7eiRTAGponNHfG3cMQKfip2QB/8PrjRtZ9sHA==
X-Received: by 2002:a05:6808:158a:b0:3a1:dc0d:f32b with SMTP id t10-20020a056808158a00b003a1dc0df32bmr17523946oiw.40.1688575189011;
        Wed, 05 Jul 2023 09:39:49 -0700 (PDT)
Received: from [192.168.17.16] ([149.19.169.25])
        by smtp.gmail.com with ESMTPSA id n7-20020a0568080a0700b003a3d273aef8sm636728oij.6.2023.07.05.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 09:39:48 -0700 (PDT)
Message-ID: <073df643-2985-0b46-7ffb-381cbabb969e@linaro.org>
Date:   Wed, 5 Jul 2023 10:39:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
Subject: Re: [PATCH 6.3 00/14] 6.3.12-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, 04 Jul 2023 09:48:39 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 6.3.12 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

## Build
* kernel: 6.3.12-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.3.y
* git commit: c5daff36a0ce3df91adefd505cd78605a51ad1ed
* git describe: v6.3.11-15-gc5daff36a0ce
* test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.3.y/build/v6.3.11-15-gc5daff36a0ce

## Test Regressions (compared to v6.3.11)
No test regressions found.

## Metric Regressions (compared to v6.3.11)
No metric regressions found.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Test Fixes (compared to v6.3.11)
No test fixes found.

## Metric Fixes (compared to v6.3.11)
No metric fixes found.

## Test result summary
total: 170331, pass: 140734, fail: 1887, skip: 27550, xfail: 160

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 145 total, 144 passed, 1 failed
* arm64: 54 total, 53 passed, 1 failed
* i386: 41 total, 40 passed, 1 failed
* mips: 30 total, 28 passed, 2 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 38 total, 36 passed, 2 failed
* riscv: 26 total, 25 passed, 1 failed
* s390: 16 total, 14 passed, 2 failed
* sh: 14 total, 12 passed, 2 failed
* sparc: 8 total, 8 passed, 0 failed
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
* kselftest-mincore
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
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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
* perf
* rcutorture
* v4l2-compliance
* vdso


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

-- 
Linaro LKFT
https://lkft.linaro.org
