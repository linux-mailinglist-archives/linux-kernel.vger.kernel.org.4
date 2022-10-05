Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7615F561C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJEOGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJEOGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:06:00 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3734177EB0;
        Wed,  5 Oct 2022 07:05:57 -0700 (PDT)
Received: from [192.168.68.105] (unknown [111.18.94.45])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+Awjz1jdIAmAA--.12059S3;
        Wed, 05 Oct 2022 22:05:38 +0800 (CST)
Message-ID: <81cf37d4-b964-cf32-31dd-afd35e7f511a@loongson.cn>
Date:   Wed, 5 Oct 2022 22:05:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [perf bench syscall] c5ba0666d8: perf-sanity-tests.perf.make_fail
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
References: <202210051644.a83a7ca4-yujie.liu@intel.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <202210051644.a83a7ca4-yujie.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxT+Awjz1jdIAmAA--.12059S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur1UGw43XrWUGFW8XF4Dtwb_yoWruw15pa
        9rCw40krZ5GFyFkw1IvF409r9xtrsxAw13XFyqg3Z8Za4jq3s3JrsF9FZ0grnF9a1IgFWF
        gFs7Xwn8XFyUZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkI
        wI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/5/22 16:35, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-11):
> 
> commit: c5ba0666d8f6dd34cb07ad45804e6a90159d377f ("[PATCH v2 1/3] perf bench syscall: Introduce bench_syscall_common()")
> url: https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/perf-Add-more-syscalls-to-benchmark/20220929-165832
> base: https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git perf/core
> patch link: https://lore.kernel.org/lkml/1664441571-31349-2-git-send-email-yangtiezhu@loongson.cn
> 
> in testcase: perf-sanity-tests
> version: perf-x86_64-b357fd1c2afc-1_20221001
> with following parameters:
> 
> 	perf_compiler: gcc
> 
> 
> on test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
>    CC      bench/syscall.o
> bench/syscall.c: In function ‘bench_syscall_common’:
> bench/syscall.c:47:8: error: ‘__NR_getppid’ undeclared (first use in this function); did you mean ‘__getpgid’?
>     47 |   case __NR_getppid:
>        |        ^~~~~~~~~~~~
>        |        __getpgid
> bench/syscall.c:47:8: note: each undeclared identifier is reported only once for each function it appears in
> bench/syscall.c: In function ‘bench_syscall_basic’:
> bench/syscall.c:102:42: error: ‘__NR_getppid’ undeclared (first use in this function); did you mean ‘__getpgid’?
>    102 |  return bench_syscall_common(argc, argv, __NR_getppid);
>        |                                          ^~~~~~~~~~~~
>        |                                          __getpgid
> bench/syscall.c:103:1: error: control reaches end of non-void function [-Werror=return-type]
>    103 | }
>        | ^
> cc1: all warnings being treated as errors
> 
> 
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202210051644.a83a7ca4-yujie.liu@intel.com
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          sudo bin/lkp install job.yaml           # job file is attached in this email
>          bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>          sudo bin/lkp run generated-yaml-file
> 
>          # if come across any failure that blocks the test,
>          # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> 

I am sorry for the build issues.

In my opinion, include asm/unistd.h can fix the build error about
undeclared __NR_getppid reported by kernel test robot, and this is
what I did in the v2 patch, but it seems no effect.

Here are the definition on my x86_64 system:

[yangtiezhu@linux ~]$ grep -rn __NR_getppid /usr/include/
/usr/include/asm/unistd_x32.h:102:#define __NR_getppid 
(__X32_SYSCALL_BIT + 110)
/usr/include/asm/unistd_32.h:68:#define __NR_getppid 64
/usr/include/asm/unistd_64.h:114:#define __NR_getppid 110
/usr/include/asm-generic/unistd.h:492:#define __NR_getppid 173
/usr/include/asm-generic/unistd.h:493:__SYSCALL(__NR_getppid, sys_getppid)
/usr/include/bits/syscall.h:610:#ifdef __NR_getppid
/usr/include/bits/syscall.h:611:# define SYS_getppid __NR_getppid
[yangtiezhu@linux ~]$ cat /usr/include/asm/unistd.h
/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
#ifndef _ASM_X86_UNISTD_H
#define _ASM_X86_UNISTD_H

/* x32 syscall flag bit */
#define __X32_SYSCALL_BIT	0x40000000

# ifdef __i386__
#  include <asm/unistd_32.h>
# elif defined(__ILP32__)
#  include <asm/unistd_x32.h>
# else
#  include <asm/unistd_64.h>
# endif

#endif /* _ASM_X86_UNISTD_H */
[yangtiezhu@linux ~]$ rpm -qf /usr/include/asm/unistd.h
kernel-headers-4.18.0-348.7.1.el8_5.x86_64

In order to fix the build error,

(1) Maybe I need to add the following code like
tools/build/feature/test-bpf.c:

#ifndef __NR_getppid
# if defined(__i386__)
#  define __NR_getppid 64
# elif defined(__x86_64__)
#  define __NR_getppid 110
# elif defined(__aarch64__)
...
# elif defined(__sparc__)
...
# elif defined(__s390__)
...
# elif defined(__mips__)
...
# else
#  error __NR_getppid not defined.
# endif
#endif

(2) Maybe I need to modify the following header files:
tools/arch/x86/include/uapi/asm/unistd_32.h
tools/arch/x86/include/uapi/asm/unistd_64.h

I prefer the second method, but I am a bit confused,
why not include /usr/include/asm/unistd*.h?
I think it is to avoid cross build issues?
Am I missing something?

Let me rethink it and then send v3, thank you.

Thanks,
Tiezhu

