Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3270EF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjEXHSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 03:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbjEXHSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 03:18:48 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2660591;
        Wed, 24 May 2023 00:18:32 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx2fFHum1kqFYAAA--.961S3;
        Wed, 24 May 2023 15:18:31 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqrZEum1keVRzAA--.61319S3;
        Wed, 24 May 2023 15:18:29 +0800 (CST)
Subject: Re: [PATCH 1/2] perf arm64: Handle __NR3264_ prefixed syscall number
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
References: <1684837327-18203-1-git-send-email-yangtiezhu@loongson.cn>
 <1684837327-18203-2-git-send-email-yangtiezhu@loongson.cn>
 <CAJ1xhMUZoO66b=LNVnjBN1GbHvXdo2b2y+YeONC36Ok=Xn5XFg@mail.gmail.com>
 <49e98308-ab8d-5811-66a8-9e17f22bb8c4@loongson.cn>
 <CAJ1xhMV=WaYbdGpiRedLUGnYp8JLzcP81Ksw1k1610xeHCiGBA@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hans-Peter Nilsson <hp@axis.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <2932e212-ba17-090b-761b-b18e8f9c33e8@loongson.cn>
Date:   Wed, 24 May 2023 15:18:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAJ1xhMV=WaYbdGpiRedLUGnYp8JLzcP81Ksw1k1610xeHCiGBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxqrZEum1keVRzAA--.61319S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF1rCr4fXF4kXw18XF17GFg_yoW5urWfpr
        n5Aay5tay0gF12kwn29rsIqrySy34ktr1DWryqyws3u3WDt3Z3Kr10vF4YkFWxXw4xKrW5
        Zr10qFy7X3W5Z3DanT9S1TB71UUUUbJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bqkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jTq2NUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/24/2023 02:43 PM, Alexander Kapshuk wrote:
> On Wed, May 24, 2023 at 6:19 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>
>>
>> On 05/23/2023 08:31 PM, Alexander Kapshuk wrote:
>>> On Tue, May 23, 2023 at 1:22 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>>
>>>> After commit 9854e7ad35fe ("perf arm64: Simplify mksyscalltbl"),
>>>> in the generated syscall table file syscalls.c, there exist some
>>>> __NR3264_ prefixed syscall numbers such as [__NR3264_ftruncate],
>>>> it looks like not so good, just do some small filter operations
>>>> to handle __NR3264_ prefixed syscall number as a digital number.
>>>>
>>>> Without this patch:
>>>>
>>>>   [__NR3264_ftruncate] = "ftruncate",
>>>>
>>>> With this patch:
>>>>
>>>>   [46] = "ftruncate",
>>>>
>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> ---
>>>>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 7 ++++---
>>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
>>>> index 22cdf91..59ab7939 100755
>>>> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
>>>> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
>>>> @@ -39,7 +39,8 @@ create_table()
>>>>         echo "};"
>>>>  }
>>>>
>>>> -$gcc -E -dM -x c -I $incpath/include/uapi $input \
>>>> -       |sed -ne 's/^#define __NR_//p' \
>>>> -       |sort -t' ' -k2 -n             \
>>>> +$gcc -E -dM -x c -I $incpath/include/uapi $input               \
>>>> +       |awk '{if ($2~"__NR" && $3 !~"__NR3264_") {print}}'     \
>>>> +       |sed -ne 's/^#define __NR_//p;s/^#define __NR3264_//p'  \
>>>> +       |sort -t' ' -k2 -n                                      \
>>>>         |create_table
>>>> --
>>>> 2.1.0
>>>>
>>>
>>> As an aside, the awk + sed + sort parts of the command line may be
>>> reduced to the following awk script, if desired:
>>> awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
>>>         sub("^#define __NR_", "")
>>>         sub("^#define __NR3264_", "")
>>>         print | "sort -k2 -n"
>>> }'
>>>
>>
>> Hi Alexander,
>>
>> Thanks, it seems more simple and works well as expected.
>> Let us wait for more review comments before respin.
>>
>> If no any objections, I will send v2 with the following
>> changes based on the current patch in the next week.
>>
>> -$gcc -E -dM -x c -I $incpath/include/uapi $input               \
>> -       |awk '{if ($2~"__NR" && $3 !~"__NR3264_") {print}}'     \
>> -       |sed -ne 's/^#define __NR_//p;s/^#define __NR3264_//p'  \
>> -       |sort -t' ' -k2 -n                                      \
>> +$gcc -E -dM -x c -I $incpath/include/uapi $input \
>> +       |awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
>> +               sub("^#define __NR_", "")
>> +               sub("^#define __NR3264_", "")
>> +               print | "sort -k2 -n"}' \
>>          |create_table
>>
>> Thanks,
>> Tiezhu
>>
>
> Hi Tiezhu,
>
> Thanks for your prompt feedback.
> It was merely a suggestion entirely subject to your discretion.
>
> If no other patterns are anticipated to be processed by the sub

Yes, there are only 2 patterns such as "__NR_" and "__NR3264_",
I confirmed that in include/uapi/asm-generic/unistd.h.

> routines, they may be combined into a single sub routine like so:
> awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
>         sub("^#define __NR(3264)?_", "")
>         print | "sort -k2 -n"
> }'

Thanks again, I tested the above code, it also works well and
looks better, I will modify the code as you suggested in v2.

Thanks,
Tiezhu

