Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A895E628A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiIVMfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiIVMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:35:13 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7775DAE869
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:35:10 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWt4VixjZh4gAA--.58865S3;
        Thu, 22 Sep 2022 20:35:05 +0800 (CST)
Subject: Re: [PATCH 1/4] LoongArch: Add kprobe support
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
References: <1663645034-967-1-git-send-email-yangtiezhu@loongson.cn>
 <1663645034-967-2-git-send-email-yangtiezhu@loongson.cn>
 <8c54706f-4e5e-bab9-9382-f4195093996b@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <0196614f-27f0-1edd-ad23-a44eb3631c1d@loongson.cn>
Date:   Thu, 22 Sep 2022 20:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <8c54706f-4e5e-bab9-9382-f4195093996b@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxTWt4VixjZh4gAA--.58865S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fCw17JFyxtF43JF4ruFg_yoW5WrWkpF
        Z0yFsYkF4rJr93ury2vw4vgr18tw4rWr4fXF1aka43CFWqvr1Ik3y8GrWqyFyv9w4qkr1I
        9F1ft342kF1SyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
        IFyTuYvjfU1L0eDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jinyang,

On 09/22/2022 10:19 AM, Jinyang He wrote:
> On 09/20/2022 11:37 AM, Tiezhu Yang wrote:
>
>> Kprobes allows you to trap at almost any kernel address and
>> execute a callback function, this commit adds kprobe support
>> for LoongArch.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/loongarch/Kconfig               |   1 +
>>   arch/loongarch/include/asm/inst.h    |  31 ++++
>>   arch/loongarch/include/asm/kprobes.h |  44 +++++
>>   arch/loongarch/include/asm/ptrace.h  |   1 +
>>   arch/loongarch/kernel/Makefile       |   2 +
>>   arch/loongarch/kernel/inst.c         | 107 ++++++++++++
>>   arch/loongarch/kernel/kprobes.c      | 309

...

>> +void simu_pc(struct pt_regs *regs, union loongarch_instruction insn)
>> +{
>> +    unsigned long pc = regs->csr_era;
>> +    unsigned int rd = insn.reg1i20_format.rd;
>> +    unsigned int imm = insn.reg1i20_format.immediate;
>> +
>> +    switch (insn.reg1i20_format.opcode) {
>> +    case pcaddi_op:
>> +        regs->regs[rd] = pc + sign_extended(imm << 2, 21);
>> +        break;
>> +    case pcaddu12i_op:
>> +        regs->regs[rd] = pc + sign_extended(imm << 12, 31);
>> +        break;
>> +    case pcaddu18i_op:
>> +        regs->regs[rd] = pc + sign_extended(imm << 18, 37);
>> +        break;
>> +    case pcalau12i_op:
>> +        regs->regs[rd] = pc + sign_extended(imm << 12, 31);
>> +        regs->regs[rd] &= ~((1 << 12) - 1);
>> +        break;
>> +    }
>> +
>> +    regs->csr_era += LOONGARCH_INSN_SIZE;
>> +}
> Hi, Tiezhu,
>
> The simu_pc and the simu_branch should make sure the instruction op is
> excepted.
> I think returning with errno or adding notes to explain that is needed.
>

OK, will do it in v2.

> BTW, I honored these arch-specific simulation work I used to contribute
> in the old world, although the codes has been optimized. Could you add
> my sign-off?

OK, no problem, as we discussed offline, I will split it into a
single patch and add your credit, thanks for your work.

>> diff --git a/arch/loongarch/kernel/kprobes.c
>> b/arch/loongarch/kernel/kprobes.c

...

>> +int kprobe_exceptions_notify(struct notifier_block *self,
>> +                 unsigned long val, void *data)
>> +{
>> +    struct die_args *args = (struct die_args *)data;
>> +    int ret = NOTIFY_DONE;
>> +
>> +    switch (val) {
>> +    case DIE_BREAK:
>> +        if (kprobe_pre_handler(args->regs))
>> +            ret = NOTIFY_STOP;
>> +        break;
>> +    case DIE_SSTEPBP:
>> +        if (kprobe_post_handler(args->regs))
>> +            ret = NOTIFY_STOP;
>> +        break;
>> +    case DIE_PAGE_FAULT:
>> +        preempt_disable();
>> +        if (kprobe_running()
>> +            && kprobe_fault_handler(args->regs, args->trapnr))
>> +            ret = NOTIFY_STOP;
>> +        preempt_enable();
>> +        break;
> The DIE_PAGE_FAULT not be notified in do_page_fault() now, and the newly
> version to call kprobe_fault_handler is
> do_page_fault()->kprobe_page_fault()
> ->kprobe_fault_handler().

OK, will modify it in v2, thanks for your review.

Thanks,
Tiezhu

