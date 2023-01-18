Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87F671571
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjARHxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjARHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:17 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 956D066CDA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:20:45 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8DxTuvLncdj+EcCAA--.6944S3;
        Wed, 18 Jan 2023 15:20:43 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+TIncdjBDIbAA--.17039S3;
        Wed, 18 Jan 2023 15:20:41 +0800 (CST)
Subject: Re: [PATCH v12 4/5] LoongArch: Mark some assembler symbols as
 non-kprobe-able
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1674007261-9198-1-git-send-email-yangtiezhu@loongson.cn>
 <1674007261-9198-5-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H7Dt5MhaMU1=D9HxPFR+xjjoQG6RguaYMydy=v_jvrtiA@mail.gmail.com>
 <48f0508f-3908-c6ca-c8ba-7c12dd6b3f11@loongson.cn>
 <7f518dec-fd72-a73c-3f23-6372a83d65c2@loongson.cn>
 <6879b948-2d61-8e09-a9d4-bc2ede31c52b@loongson.cn>
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <14547aca-5649-c442-e062-a2e81052164b@loongson.cn>
Date:   Wed, 18 Jan 2023 15:20:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6879b948-2d61-8e09-a9d4-bc2ede31c52b@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxb+TIncdjBDIbAA--.17039S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFy7uF4UKF43Zw18AFy7Wrg_yoW7Aw15pr
        1kAF4DtrZ5Gr18Jry7tw1UXryUtr1xJ3WUXw1UAFy8JrsFqr1jqr18XrWq9FyxJw48GF10
        qF18Jr17ZF4UJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1D
        MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
        AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
        cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
        80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIF
        yTuYvjxUzZ2-UUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-01-18 14:24, Tiezhu Yang wrote:
>
>
> On 01/18/2023 02:05 PM, Jinyang He wrote:
>>
>> On 2023-01-18 12:23, Tiezhu Yang wrote:
>>>
>>>
>>> On 01/18/2023 12:14 PM, Huacai Chen wrote:
>>>> If memcpy should be blacklisted, then what about memset and memmove?
>>>
>>> According to the test results, there are no problems to probe
>>> memset and memmove, so no need to blacklist them for now,
>>> blacklist memcpy is because it may cause recursive exceptions,
>>> there is a detailed discussion in the following link:
>>>
>>> https://lore.kernel.org/lkml/20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org/ 
>>>
>>>
>>
>> Hi, Tiezhu,
>>
>> I cannot reproduce the results when kprobe memcpy. Could you please give
>> some details. Emm, I just replace "kernel_clone" with "memcpy" in
>> kprobe_example.c.
>
> Please remove the related "_ASM_NOKPROBE(memcpy)" code in
> arch/loongarch/lib/memcpy.S, and then compile and update kernel,
> execute the following cmd after reboot, I can reproduce the hang
> problem easily (it will take a few minutes).
>
> modprobe kprobe_example symbol="memcpy"

Okay, I can reproduce the hang, but sometimes quickly while
sometimes slowly. I do not know why it happend. Can you
explain how recursion happens? I means, can you explain why

no need mark {vprintk_store, vprintk, ... } as it may also cause recursion.


>
>>
>> And for your call trace,
>>
>>  handler_pre()
>>    pr_info()
>>      printk()
>>       _printk()
>>         vprintk()
>>           vprintk_store()
>>             memcpy()
>>
>> I think when we should skip this time kprobe which triggered in
>> handler_{pre, post}. That means this time kprobe will not call
>> handler_{pre, post} agian, and not cause recursion. I remember
>> your codes had done this skip action. So, that's so strange if
>> recursion in handler_{pre, post}.
>>
>>
>> Thanks,
>>
>> Jinyang
>>
>>
>>>
>>> Thanks,
>>> Tiezhu
>>>
>>>>
>>>> Huacai
>>>>
>>>> On Wed, Jan 18, 2023 at 10:01 AM Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> wrote:
>>>>>
>>>>> Some assembler symbols are not kprobe safe, such as handle_syscall
>>>>> (used as syscall exception handler), *memcpy* (may cause recursive
>>>>> exceptions), they can not be instrumented, just blacklist them for
>>>>> kprobing.
>>>>>
>>>>> Here is a related problem and discussion:
>>>>> Link:
>>>>> https://lore.kernel.org/lkml/20230114143859.7ccc45c1c5d9ce302113ab0a@kernel.org/ 
>>>>>
>>>>>
>>>>>
>>>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>>>> ---
>>>>>  arch/loongarch/include/asm/asm.h | 10 ++++++++++
>>>>>  arch/loongarch/kernel/entry.S    |  1 +
>>>>>  arch/loongarch/lib/memcpy.S      |  3 +++
>>>>>  3 files changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/arch/loongarch/include/asm/asm.h
>>>>> b/arch/loongarch/include/asm/asm.h
>>>>> index 40eea6a..f591b32 100644
>>>>> --- a/arch/loongarch/include/asm/asm.h
>>>>> +++ b/arch/loongarch/include/asm/asm.h
>>>>> @@ -188,4 +188,14 @@
>>>>>  #define PTRLOG         3
>>>>>  #endif
>>>>>
>>>>> +/* Annotate a function as being unsuitable for kprobes. */
>>>>> +#ifdef CONFIG_KPROBES
>>>>> +#define _ASM_NOKPROBE(name)                            \
>>>>> +       .pushsection "_kprobe_blacklist", "aw";         \
>>>>> +       .quad   name;                                   \
>>>>> +       .popsection
>>>>> +#else
>>>>> +#define _ASM_NOKPROBE(name)
>>>>> +#endif
>>>>> +
>>>>>  #endif /* __ASM_ASM_H */
>>>>> diff --git a/arch/loongarch/kernel/entry.S
>>>>> b/arch/loongarch/kernel/entry.S
>>>>> index d53b631..55e23b1 100644
>>>>> --- a/arch/loongarch/kernel/entry.S
>>>>> +++ b/arch/loongarch/kernel/entry.S
>>>>> @@ -67,6 +67,7 @@ SYM_FUNC_START(handle_syscall)
>>>>>
>>>>>         RESTORE_ALL_AND_RET
>>>>>  SYM_FUNC_END(handle_syscall)
>>>>> +_ASM_NOKPROBE(handle_syscall)
>>>>>
>>>>>  SYM_CODE_START(ret_from_fork)
>>>>>         bl      schedule_tail           # a0 = struct task_struct 
>>>>> *prev
>>>>> diff --git a/arch/loongarch/lib/memcpy.S 
>>>>> b/arch/loongarch/lib/memcpy.S
>>>>> index 7c07d59..3b7e1de 100644
>>>>> --- a/arch/loongarch/lib/memcpy.S
>>>>> +++ b/arch/loongarch/lib/memcpy.S
>>>>> @@ -17,6 +17,7 @@ SYM_FUNC_START(memcpy)
>>>>>         ALTERNATIVE     "b __memcpy_generic", \
>>>>>                         "b __memcpy_fast", CPU_FEATURE_UAL
>>>>>  SYM_FUNC_END(memcpy)
>>>>> +_ASM_NOKPROBE(memcpy)
>>>>>
>>>>>  EXPORT_SYMBOL(memcpy)
>>>>>
>>>>> @@ -41,6 +42,7 @@ SYM_FUNC_START(__memcpy_generic)
>>>>>  2:     move    a0, a3
>>>>>         jr      ra
>>>>>  SYM_FUNC_END(__memcpy_generic)
>>>>> +_ASM_NOKPROBE(__memcpy_generic)
>>>>>
>>>>>  /*
>>>>>   * void *__memcpy_fast(void *dst, const void *src, size_t n)
>>>>> @@ -93,3 +95,4 @@ SYM_FUNC_START(__memcpy_fast)
>>>>>  3:     move    a0, a3
>>>>>         jr      ra
>>>>>  SYM_FUNC_END(__memcpy_fast)
>>>>> +_ASM_NOKPROBE(__memcpy_fast)
>>>>> -- 
>>>>> 2.1.0
>>>>>
>>>

