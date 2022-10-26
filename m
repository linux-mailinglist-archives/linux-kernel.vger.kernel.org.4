Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E794A60DA59
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 06:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiJZEht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 00:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJZEhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 00:37:47 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F53E74E00;
        Tue, 25 Oct 2022 21:37:44 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_7eXuVhjp4gCAA--.8046S3;
        Wed, 26 Oct 2022 12:37:43 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqFeWuVhjWCYFAA--.1146S3;
        Wed, 26 Oct 2022 12:37:43 +0800 (CST)
Subject: Re: [PATCH v3 2/3] perf bench syscall: Add close syscall benchmark
To:     Ian Rogers <irogers@google.com>
References: <1665042130-15786-1-git-send-email-yangtiezhu@loongson.cn>
 <1665042130-15786-3-git-send-email-yangtiezhu@loongson.cn>
 <CAP-5=fX8_Q3EujmfBXF_66y=n+VUyeBZtzjZU9WGj4QBN2TZ5w@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <6a2d2031-0773-e1af-027f-8939ce596d52@loongson.cn>
Date:   Wed, 26 Oct 2022 12:37:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fX8_Q3EujmfBXF_66y=n+VUyeBZtzjZU9WGj4QBN2TZ5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxqFeWuVhjWCYFAA--.1146S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxZr1DJryDtF4xKw1xZF13Jwb_yoW5uFy7pF
        47Ca1Utw4rAF4jv3W3Jr4kXFyrJr12qF1YywnIkws8Zr13X3s0gayjgay5XFnruFW7K345
        ua1vvry8WF4xZaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8RuWPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2022 11:37 PM, Ian Rogers wrote:
> On Thu, Oct 6, 2022 at 12:42 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> This commit adds a simple close syscall benchmark, more syscall
>> benchmarks can be added in the future.
>>

...

>> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
>> index 746fd71..058394b 100644
>> --- a/tools/perf/bench/syscall.c
>> +++ b/tools/perf/bench/syscall.c
>> @@ -46,6 +46,9 @@ static int bench_syscall_common(int argc, const char **argv, int syscall)
>>                 case __NR_getppid:
>>                         getppid();
>>                         break;
>> +               case __NR_close:
>> +                       close(dup(0));
>
> Thanks for contributing! This benchmark will compute the cost of close
> and dup, naively dup could perform memory allocation and be slow.
> Perhaps a number of file descriptors could be made outside of the
> timed region?
>

Hi Ian,

Thanks for your review and suggestion.

I tried the following changes based on this patchset, it shows
"dup failed" due to the default number of "max open files"
(ulimit -n) is 1024 but the loops is 10000000, if reduce the
loops to 1000, the test time is too short and seems meaningless.

diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index c8f8bee..76571a4 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -57,10 +57,26 @@ static int bench_syscall_common(int argc, const char 
**argv, int syscall)
         struct timeval start, stop, diff;
         unsigned long long result_usec = 0;
         const char *name = NULL;
-       int i;
+       int i, *fd = NULL;

         argc = parse_options(argc, argv, options, bench_syscall_usage, 0);

+       if (syscall == __NR_close) {
+               fd = (int *) malloc(sizeof(int) * loops);
+               if (fd == NULL) {
+                       fprintf(stderr, "malloc failed\n");
+                       exit(1);
+               }
+
+               for (i = 0; i < loops; i++) {
+                       fd[i] = dup(i);
+                       if (fd[i] < 0) {
+                               fprintf(stderr, "dup failed\n");
+                               exit(1);
+                       }
+               }
+       }
+
         gettimeofday(&start, NULL);

         for (i = 0; i < loops; i++) {
@@ -69,7 +85,7 @@ static int bench_syscall_common(int argc, const char 
**argv, int syscall)
                         getppid();
                         break;
                 case __NR_close:
-                       close(dup(0));
+                       close(fd[i]);
                         break;
                 case __NR_execve:
                         test_execve();
@@ -85,6 +101,9 @@ static int bench_syscall_common(int argc, const char 
**argv, int syscall)
         gettimeofday(&stop, NULL);
         timersub(&stop, &start, &diff);

+       if (syscall == __NR_close)
+               free(fd);
+
         switch (syscall) {
         case __NR_getppid:
                 name = "getppid()";

What about the following changes? Use "open" instead of "dup" to
generate fd (it nees more test time), or just leave the code as
it is?

diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
index c8f8bee..3aab5fd 100644
--- a/tools/perf/bench/syscall.c
+++ b/tools/perf/bench/syscall.c
@@ -57,7 +57,7 @@ static int bench_syscall_common(int argc, const char 
**argv, int syscall)
         struct timeval start, stop, diff;
         unsigned long long result_usec = 0;
         const char *name = NULL;
-       int i;
+       int i, fd;

         argc = parse_options(argc, argv, options, bench_syscall_usage, 0);

@@ -69,7 +69,12 @@ static int bench_syscall_common(int argc, const char 
**argv, int syscall)
                         getppid();
                         break;
                 case __NR_close:
-                       close(dup(0));
+                       fd = open("/etc/passwd", O_RDONLY);
+                       if (fd < 0) {
+                               fprintf(stderr, "open failed\n");
+                               exit(1);
+                       }
+                       close(fd);
                         break;
                 case __NR_execve:
                         test_execve();


Thanks,
Tiezhu

