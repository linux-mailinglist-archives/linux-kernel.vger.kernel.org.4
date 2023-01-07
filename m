Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95369660CBF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 08:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjAGHXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 02:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAGHXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 02:23:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C01E13DBEF;
        Fri,  6 Jan 2023 23:23:29 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8CxvOrwHblj4TUAAA--.700S3;
        Sat, 07 Jan 2023 15:23:28 +0800 (CST)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxzr7vHbljN5oVAA--.46918S3;
        Sat, 07 Jan 2023 15:23:28 +0800 (CST)
Subject: Re: [PATCH v5 0/4] perf: Add more syscalls to benchmark
To:     Namhyung Kim <namhyung@kernel.org>
References: <1668052208-14047-1-git-send-email-yangtiezhu@loongson.cn>
 <c71e9666-c62a-83ae-0d7b-580dc717e9f1@loongson.cn>
 <dbf82707-df17-466b-f882-aa4e25d4f629@loongson.cn>
 <CAM9d7cgH0zK-DUmUV7yw1BJBvgyxWys9zPuB5Q7dQQwta=XcGA@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <06c8a265-0120-c4e1-6032-7bb3190df90a@loongson.cn>
Date:   Sat, 7 Jan 2023 15:23:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgH0zK-DUmUV7yw1BJBvgyxWys9zPuB5Q7dQQwta=XcGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bxzr7vHbljN5oVAA--.46918S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7KF13Cr4DJFW3KFyUur18AFb_yoW8Wr1DpF
        9xCF45Gr4rXryavasIqr10qF9xt3WfA34Fqry7trWUuw1qqry3tr1xJay5GFyDWryxKFyF
        9r4vqFy3u3WrAaDanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
        AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j
        6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIY
        CTnIWIevJa73UjIFyTuYvjxUc0eHDUUUU
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2023 05:04 AM, Namhyung Kim wrote:
> Hello,
>
> On Thu, Jan 5, 2023 at 5:23 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>
>>
>> On 12/03/2022 05:19 PM, Tiezhu Yang wrote:
>>>
>>>
>>> On 11/10/2022 11:50 AM, Tiezhu Yang wrote:
>>>> Tested on x86_64, arm64, mips64 and loongarch64.
>>>>
>>>> Tiezhu Yang (4):
>>>>   tools x86: Keep list sorted by number in unistd_{32,64}.h
>>>>   perf bench syscall: Introduce bench_syscall_common()
>>>>   perf bench syscall: Add getpgid syscall benchmark
>>>>   perf bench syscall: Add execve syscall benchmark
>>>>
>>>>  tools/arch/x86/include/uapi/asm/unistd_32.h | 23 ++++++---
>>>>  tools/arch/x86/include/uapi/asm/unistd_64.h | 23 ++++++---
>>>>  tools/perf/bench/bench.h                    |  2 +
>>>>  tools/perf/bench/syscall.c                  | 76
>>>> +++++++++++++++++++++++++++--
>>>>  tools/perf/builtin-bench.c                  |  2 +
>>>>  5 files changed, 108 insertions(+), 18 deletions(-)
>>>>
>>>
>>> Ping, any more comments?
>>>
>>> Thanks,
>>> Tiezhu
>>
>> Hi all,
>>
>> If this patch series has no value and is not acceptable,
>> or what should I do to update, please let me know.
>
> I'm so sorry about being late a lot.
> I don't have any objection to this series.
>
> For the execve bench, I think it's actually fork + execve
> then maybe it makes sense to have a fork only bench
> to compare the execve part precisely.
>
> But it can be added later, so
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>

Hi Namhyung,

Thank you very much. I will submit another single patch
to benchmark fork after this series is applied.

Thanks,
Tiezhu

