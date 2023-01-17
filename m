Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3E66E5B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjAQSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjAQSJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:09:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70F233D4;
        Tue, 17 Jan 2023 09:51:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id n5so33402800ljc.9;
        Tue, 17 Jan 2023 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2ajQuXH91hVK7dVwZAzoM3s83y9WqIbvmabdkjYPxUI=;
        b=pJKYXu50oaB7Cw1PTPLx/ZJxt2Ssd2JnY4wmezCXB60WerABYxghOS/pA4fzDTWeS+
         GNYb0omA9/bSCtZqAhJgJEs3VrxMuUNdibvrFLMqZOFcDdhZHkpaIPFtzyfBfStKzMMz
         Q5AqDNeWSiGVv3/nG4lmy2aZUYbS+c2z6XZEhdh/I9EjpVZBBYtjOCZPAOOHXW8PqN7P
         X7+EZUlMo3QYt2p8DMIxCA+vUbNebEKi+bAYKSTd3i0CehaFvMQx+AewLp03d6bDyBkr
         CEfexuhjnWxOF8T36OdyvLx8l7sdtPbODQGAbZ7enQK+uDK6IEOnJKQVr1fsNUmNHMPz
         1jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ajQuXH91hVK7dVwZAzoM3s83y9WqIbvmabdkjYPxUI=;
        b=n0916e/9n9RRyZ8xBFCve0RkuVvdXhZhQgizVFbr6QU0SgUbAeAlzlNkLr39BSm27Z
         f8X/k1g6hbfUN0SGiF48fbhCGTHyYb8H0hgLbNK6L+74EYJsL73tQFVBrHHCqSJvy/MV
         1LOH17QK1bIDz2/xTY6QqwbfZT+/ARVwA4lHcv2TWMG8LDb0ksIj7wRwkU+Qe3N3CcXo
         PevAU3ScyduPC/kRvdxBSCnAnS5X5bTRAPVCObiOlMFuKKG6txQ95hoVGMYNUWpoUYQH
         oQgohgAKKNRjnZGWm/mBJs1mE8JhWd7ZjZLiXGAKMZ4PsuMDyJ84XJbXcnER+xVwUvfg
         lGxg==
X-Gm-Message-State: AFqh2koYCjXeshArMsjPEpfoOQB8s7eXqJTOjJ4n3al3+CHW3QAtco4V
        I+M7bQbu31gFMo6py2ZeXdohLFMffxPeH0E8gfc=
X-Google-Smtp-Source: AMrXdXsIA4q4R93FiNiktLtkM3MVU0yOCGbHwCKrGK6/JNPO8gN8dEJY0Y9YiOX0ajJNzyOFzwmw/HpOPomcM7jtB5k=
X-Received: by 2002:a2e:9e0d:0:b0:28b:88da:35b with SMTP id
 e13-20020a2e9e0d000000b0028b88da035bmr379573ljk.364.1673977884887; Tue, 17
 Jan 2023 09:51:24 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUUOckm1kwOEZhSw8zsaL5z7r8uczwiKeKGEVioZ=GeFNg@mail.gmail.com>
 <7964ec80-4d02-6c9c-ff9e-a6a8a0c427c3@intel.com> <004e01d92a93$79f21e50$6dd65af0$@telus.net>
In-Reply-To: <004e01d92a93$79f21e50$6dd65af0$@telus.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 17 Jan 2023 18:50:47 +0100
Message-ID: <CA+icZUW1_p75AgTfZU_1_Az8KGiRf+tdiF4tUoH0ckaVrqCcPA@mail.gmail.com>
Subject: Re: [6.2-rc4] tools: {amd,intel}_pstate_tracer: make -C tools/ clean
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Huang Rui <ray.huang@amd.com>, li.meng@amd.com,
        linux-kernel@vger.kernel.org, Jinzhou Su <Jinzhou.Su@amd.com>,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:48 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2023.01.17 07:40 Rafael wrote:
> > On 1/17/2023 3:03 PM, Sedat Dilek wrote:
> >> Hi,
> >> I regularly test:
> >> $ LANG=C LC_ALL=C make -C tools/ clean 2>&1 | tee ../make-log_tools-clean.txt
> >> This removes:
> >>
> >> $ git status -s
> >> D tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >> D tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> >>
> >> Checking the log:
> >>
> >> $ grep pstate_tracer.py ../make-log_tools-clean.txt
> >> 89:rm -f -r   /home/dileks/src/linux/git/tools/testing/selftests/amd-pstate/../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> >> /home/dileks/src/linux/git/tools/t
> >> esting/selftests/amd-pstate/../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> >>
> >> Is that intended or not?
> >
> > I don't think so.
> >
> > Doug?
>
> Nothing should ever remove the intel_pstate_tracer.py source file.
>
> Sedat, Thank you for your report.
> I get the same results when running your test.
>
> Note that I know nothing about Makefiles and such, but
> think the guilty commit is this one:
>
> commit ba2d788aa873da9c65ff067ca94665853eab95f0
> Author: Meng Li <li.meng@amd.com>
> Date:   Mon Oct 31 16:49:22 2022 +0800
>
>     selftests: amd-pstate: Trigger tbench benchmark and test cpus
>
>     Add tbench.sh trigger the tbench testing and monitor the cpu desire
>     performance, frequency, load, power consumption and throughput etc.
>
>     Signed-off-by: Meng Li <li.meng@amd.com>
>     Acked-by: Huang Rui <ray.huang@amd.com>
>     Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 6f4c7b01e3bb..cac8dedb7226 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -4,7 +4,15 @@
>  # No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
>  all:
>
> +uname_M := $(shell uname -m 2>/dev/null || echo not)
> +ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
> +
> +ifeq (x86,$(ARCH))
> +TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +endif
> +
>  TEST_PROGS := run.sh
> -TEST_FILES := basic.sh
> +TEST_FILES := basic.sh tbench.sh
>
>  include ../lib.mk
> diff --git a/tools/testing/selftests/amd-pstate/run.sh b/tools/testing/selftests/amd-pstate/run.sh
> ...
>
> And if I do this:
>
> doug@s19:~/kernel/linux$ git diff
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -

[ CC Shuah  due to ba2d788aa873da9c65ff067ca94665853eab95f0 ]

Hi Doug,

I guess some upper top-level Makefile in tools/ remove on PHONY
"clean" *TEST_GEN_FILES*.

Wild git grep-ing:

dileks@iniza:~/src/linux/git$ git grep TEST_GEN_FILES tools/ | sort | grep -i rm

As an example:

tools/testing/selftests/bpf/Makefile:   $(Q)$(RM) -r $(TEST_GEN_FILES)

You are right those files are NOT generated and are permanently stored in .git.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py

They should not be removed on `make -C tools/ clean`.

So your above changes make sense to me.

If responsible people agree, come with patch :-).

Best regards,
-Sedat-

[1] https://git.kernel.org/linus/ba2d788aa873da9c65ff067ca94665853eab95f0

>  TEST_PROGS := run.sh
>  TEST_FILES := basic.sh tbench.sh gitsource.sh
>
> The source files do not get deleted with Sedat's test.
>
> ... Doug
>
>
