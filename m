Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196975FA192
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiJJQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJJQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:06:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AEF17057
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:05:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id m15so16502757edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ83mKY8kfQjaYHQHYd5lU6Kccpvr+jVPRWONIMgoJ4=;
        b=V99ybNau30DvukEacRLqhvPg2FXlUt9H9UPz2ZTGqYPUhz9yQar5Pic0/dzyK+5UKW
         ea1hA2Emzs2xf8WcJmTMmx/+D9ybJJb195H8kFoPjAIGjr4apvRGepFUluIAWyWO3kPX
         7rHEwr9xMvFgr/SyRQA8VFuCxqbdoLau/lpW7elG60rYvCH6u0bO/ctVwz18ikiNVjEh
         eUkIq0bY3qgvZlXaDXulwlQ77Vq6xFNUNykDvM5bBUEEGYVK6+K/EugCRdKmEHORAi4q
         //U+JMVFu6k0ZR5wFcnes8ZecG0W04GdrdyRsT9JuUpILFtomOOfAmbjUR/8bwIQR8ui
         /Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJ83mKY8kfQjaYHQHYd5lU6Kccpvr+jVPRWONIMgoJ4=;
        b=Cx4FgVMXcPG4smV3j2H+uNhaIA5s+/21zyL3Ya8/1gUeQaavgAhQ5lhGjrFvKLNFJm
         2BTI5iHCIFcEpObTglB5KjFyMYi7u+PLZAkC0M8E1A5YWd76bjcLZmgL3K+syYftejeb
         /7ovGzTcC/nfKVl7P6b8uHQvTv/TP+QnLVa4T07tGFNMM0f6k8VdrdKKkmncCkfl5izB
         ru9wwhL3t1hOVs8nbMccjOv4cHCjn/ZnTTVkg6XkgQd0sjahUSvR5mzatxf3S4VWwr/g
         WNu8s8Rrylp8M0CVqsGcFsjgqq9Ymz6HkbNB3p9DJTT7NpAAP/pZiMDculB3rNeEsJqH
         3a9g==
X-Gm-Message-State: ACrzQf3uBUB4cHcpzNrRwmefarllivRzSc42IPG9o336BZter04FHJ1q
        aYuLfXtE1wrQmDF13x/An3C7rokw5KS+EGbQ6xTHWw==
X-Google-Smtp-Source: AMsMyM5Let9YT1mW/xjKiRz91lCNum9gBb59k2Qwh2Z1mdLStFhZvhd6cZrvJR1PorUgXPu0bunAFV2UqPwEqfj0T00=
X-Received: by 2002:a05:6402:280f:b0:458:ea37:7f00 with SMTP id
 h15-20020a056402280f00b00458ea377f00mr18372978ede.1.1665417954234; Mon, 10
 Oct 2022 09:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221010070331.211113813@linuxfoundation.org>
In-Reply-To: <20221010070331.211113813@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 10 Oct 2022 21:35:42 +0530
Message-ID: <CA+G9fYt8w7YZQU0TrpYxMJ8fysGBkeL6==EE11p62iViiqaZ0w@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/37] 5.15.73-rc1 review
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 12:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.73 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Oct 2022 07:03:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.73-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro's test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.73-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.15.y
* git commit: ebe70cd7f54131bf594f842a69d363a9e2812d67
* git describe: v5.15.72-38-gebe70cd7f541
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.72-38-gebe70cd7f541

## No Test Regressions (compared to v5.15.71-71-gc68173b2012b)

## No Metric Regressions (compared to v5.15.71-71-gc68173b2012b)

## No Test Fixes (compared to v5.15.71-71-gc68173b2012b)

## No Metric Fixes (compared to v5.15.71-71-gc68173b2012b)

## Test result summary
total: 101182, pass: 89631, fail: 630, skip: 10732, xfail: 189

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 339 total, 336 passed, 3 failed
* arm64: 72 total, 70 passed, 2 failed
* i386: 61 total, 55 passed, 6 failed
* mips: 62 total, 59 passed, 3 failed
* parisc: 14 total, 14 passed, 0 failed
* powerpc: 69 total, 66 passed, 3 failed
* riscv: 27 total, 27 passed, 0 failed
* s390: 30 total, 27 passed, 3 failed
* sh: 26 total, 24 passed, 2 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 65 total, 63 passed, 2 failed

## Test suites summary
* fwts
* igt-gpu-tools
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-[
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
* rcutorture
* v4l2-compliance
* vdso

--
Linaro LKFT
https://lkft.linaro.org
