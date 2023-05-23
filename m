Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA670D852
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjEWJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjEWJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:02:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72E12109;
        Tue, 23 May 2023 02:02:39 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxR_EtgWxkygIAAA--.32S3;
        Tue, 23 May 2023 17:02:37 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxD78pgWxkcRRwAA--.56326S3;
        Tue, 23 May 2023 17:02:34 +0800 (CST)
Subject: Re: [PATCH] perf symbol: Add LoongArch case in get_plt_sizes()
To:     Leo Yan <leo.yan@linaro.org>, Huacai Chen <chenhuacai@kernel.org>
References: <CAAhV-H7waE0gmSU09YKJMHDAnj7BV7ukiLqWs+JzzLrHDG5z8w@mail.gmail.com>
 <20230518030618.GB1068119@leoy-yangtze.lan>
 <CAAhV-H6L9kNyGU2UrX7jyN_6O_pafSVSamP7DYHkzfMgmCxVXA@mail.gmail.com>
 <20230518032129.GC1068119@leoy-yangtze.lan>
 <CAAhV-H6_=qwheWvNozop2+9MexnOZQcva28xaeikCc49_DqABA@mail.gmail.com>
 <20230518040553.GE1068119@leoy-yangtze.lan> <ZGYXKnRZQh18D2Fd@kernel.org>
 <CAAhV-H40kQf5WD-8ozFwS6copfQaGtUJqm=nvQ6btXZnpDmZFA@mail.gmail.com>
 <387463f9-adb0-8e98-1de6-cae7a79a7d03@loongson.cn>
 <CAAhV-H4mLCZ7qN3y6siTzpaybMr64f4FrKhfUhA_Qjm-O+sKnQ@mail.gmail.com>
 <20230523073007.GB1969788@leoy-yangtze.lan>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <7c5ca655-dd68-b67a-0674-de624bf10752@loongson.cn>
Date:   Tue, 23 May 2023 17:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20230523073007.GB1969788@leoy-yangtze.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxD78pgWxkcRRwAA--.56326S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7ArWxXFy7tFWDtw18ZF4Dtwb_yoW8Gr17pr
        1DCa15ta1Dtr1fGasFyw43Xas7Krs2yrW0gw15trWDCr9rtFy2gr4Iva1a9F13Xr18W34j
        y34j9FZYkrnYq3DanT9S1TB71UUUUbDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
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
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIx
        AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jTq2NUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/23/2023 03:30 PM, Leo Yan wrote:
> On Tue, May 23, 2023 at 09:47:19AM +0800, Huacai Chen wrote:
>
> [...]
>
>>>> I'm very sorry that this patch breaks cross-build. We need some
>>>> additional modification.
>>>>
>>>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>>>> index 5d409c26a22e..b3dbf6ca99a7 100644
>>>> --- a/tools/perf/util/symbol-elf.c
>>>> +++ b/tools/perf/util/symbol-elf.c
>>>> @@ -35,6 +35,10 @@
>>>>  #define EM_AARCH64     183  /* ARM 64 bit */
>>>>  #endif
>>>>
>>>> +#ifndef EM_LOONGARCH
>>>> +#define EM_LOONGARCH   258
>>>> +#endif
>>>> +
>
> I confirmed that we must apply this change, otherwise, it will
> introduce perf building failure on Ubuntu 22.04 (jammy) with my Arm64
> machine.
>
> Sorry I didn't detect the building failure when reviewed this patch!
>

Sorry for that, EM_LOONGARCH was added in binutils in 2020 [1],
and then it was added in glibc in 2022 [2], so it may be not
exist on some systems.

For now, I do not find the related commit of this patch in any
branch of acme/linux.git, so it is better to send v2 to avoid
the build error, I will do it as soon as possible.

[1] 
https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=4cf2ad720078
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=2d83247d90c9

Thanks,
Tiezhu

