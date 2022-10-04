Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54575F3E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiJDImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJDImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:42:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8B92253D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:42:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id au23so6554809ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dBCTTwJe156Jlf7g+nR9xvVLNBl2FAdvHJE9BXeY7Gk=;
        b=PhhvhXlZRh+Js5RkngTmfAsb+H1hvkFuCsc27xi/K0SQo92xIzzXSoY9lUBdskIRdi
         GxYRp6RwxTR3fNlFgBfqlpmNn8hDK3JemPUNW1cpUV7l0f4GWiReMrj5sgtipsoxwnFm
         Tq9M7xI6dmOCNShAl1uAz0LkslbpsxSUjWGSp1XD7sQjXoGRLcQLnvX/Tsz4m8+5jm2s
         Mo1L96yGXKmpOcolLnKIJNMVm6LSdEH6d/CUPfAY9eYt3/7eNdFWMHwV9a8f6rgnlgoc
         mwQxPXtfw67Odek8i7n3l3b2DVato5aK6fM1sdkcrJIlC3i5BJGyVzVR6EiV5l/6jpou
         jVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dBCTTwJe156Jlf7g+nR9xvVLNBl2FAdvHJE9BXeY7Gk=;
        b=pEbDCeJFfcu/Tx20t1elAL8sa6sO3+upRDDyWAlyQ3dHKsKSpU4q2NPx3j5C9foMRN
         4zCcc3fVYVKATjC+SAnnIMBKjiQ3luDL4zX4XlL5n/QdyPsPGqsyTXCE9JkjTNHr8t5W
         ewEbhAwhaG1hZc3w1BcZrpwGvh/38sZsfYFkGqrV+ylTayS5/gPE+6osz4n50BCJLSQn
         80zR81BFlZBy1HDqiUDCr/3QhFxMlKlHoxaFUghBwJjaK5joVTa9pEkIa26eIOIJK10k
         sLYTiWzdZ6qT5vM4t5UGnnDyDnvSGO67SIxO3s0GrKagLmPUdlLtmD6JkZn+zMbzdZxZ
         BJhA==
X-Gm-Message-State: ACrzQf1kw6XG9mjNunG/Txh85ehtPmfhwiOYfuprtYgGBzNkwUwrNEcr
        NMPp6my5iKLHtf3cgwP2exYY4xVS+5hT98ugDgzjhw==
X-Google-Smtp-Source: AMsMyM4Z7FRVxJljAviaMej5OXimNEU3mPTREf95/149sdKrwox4u+vHWZKRgzxyeN8HF/dkWEGK7qn8FIsP1MJT448=
X-Received: by 2002:a17:906:da86:b0:740:7120:c6e6 with SMTP id
 xh6-20020a170906da8600b007407120c6e6mr18091453ejb.44.1664872922535; Tue, 04
 Oct 2022 01:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221003070718.687440096@linuxfoundation.org>
In-Reply-To: <20221003070718.687440096@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 4 Oct 2022 14:11:51 +0530
Message-ID: <CA+G9fYsKtvGxf01b-34aXNNhDCLTp-AaWeTJmrjyyw9gcHbSbg@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/52] 5.10.147-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Oct 2022 at 12:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.147 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 05 Oct 2022 07:07:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.147-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.147-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: ['9d377edf70b6af4c3d7f6ebe67b0216146c0d752']
* git describe: v5.10.146-53-g9d377edf70b6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.146-53-g9d377edf70b6

## No Test Regressions (compared to v5.10.146)

## No Metric Regressions (compared to v5.10.146)

## No Test Fixes (compared to v5.10.146)

## No Metric Fixes (compared to v5.10.146)

## Test result summary
total: 102659, pass: 90224, fail: 752, skip: 11372, xfail: 311

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 330 total, 328 passed, 1 failed, 1 skipped
* arm64: 62 total, 59 passed, 2 failed, 1 skipped
* i386: 53 total, 51 passed, 2 failed
* mips: 56 total, 53 passed, 3 failed
* parisc: 12 total, 12 passed, 0 failed
* powerpc: 59 total, 50 passed, 9 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 23 total, 23 passed, 0 failed
* sh: 24 total, 24 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 58 total, 56 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
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
* ltp-open-posix-tests
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-syscalls
* ltp-tracing
* network-basic-tests
* packetdrill
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
