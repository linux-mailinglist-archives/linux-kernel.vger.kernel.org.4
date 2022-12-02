Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0A6402E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiLBJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiLBJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:03:56 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0EE90C0557
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:03:26 -0800 (PST)
Received: from loongson.cn (unknown [10.20.42.170])
        by gateway (Coremail) with SMTP id _____8CxI_Bdv4ljAcECAA--.6648S3;
        Fri, 02 Dec 2022 17:03:25 +0800 (CST)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxoOJcv4ljhUckAA--.24197S3;
        Fri, 02 Dec 2022 17:03:25 +0800 (CST)
Message-ID: <c5e1b113-f457-2cc7-808b-b13f83adbb2b@loongson.cn>
Date:   Fri, 2 Dec 2022 17:03:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] LoongArch: export symbol with function
 smp_send_reschedule
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221202075854.2253116-1-maobibo@loongson.cn>
 <07e0d775-6bb7-051b-9ec9-71153efbdf21@xen0n.name>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <07e0d775-6bb7-051b-9ec9-71153efbdf21@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxoOJcv4ljhUckAA--.24197S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWFWkGrW8AF4fGrW3Gw1kAFb_yoW5Zr1rpF
        97Zr1kCr4UWr97Ar90v3yruryrGrs5Gr1aqF43tay8Arnxt3WkZryvqwn0gFyUZ3yIkF1F
        gFWrWwna9FyUA37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
        AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
        Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
        xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
        JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
        C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24SoDUUUU
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/2 16:25, WANG Xuerui 写道:
> On 2022/12/2 15:58, Bibo Mao wrote:
>> Function smp_send_reschedule is standard kernel ABI, which is
>> defined header file include/linux/smp.h, however on LoongArch
>> it is defined as inline function, so that kernel module can
>> not use this function.
>>
>> Now define smp_send_reschedule as general function, and add
>> EXPORT_SYMBOL_GPL on this function, so that kernel modules can
>> use it.
>>
>> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   arch/loongarch/include/asm/smp.h | 10 ----------
>>   arch/loongarch/kernel/smp.c      | 11 +++++++++++
>>   2 files changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/smp.h b/arch/loongarch/include/asm/smp.h
>> index 3dd172d9ffea..d82687390b4a 100644
>> --- a/arch/loongarch/include/asm/smp.h
>> +++ b/arch/loongarch/include/asm/smp.h
>> @@ -78,16 +78,6 @@ extern void calculate_cpu_foreign_map(void);
>>    */
>>   extern void show_ipi_list(struct seq_file *p, int prec);
>>   -/*
>> - * This function sends a 'reschedule' IPI to another CPU.
>> - * it goes straight through and wastes no time serializing
>> - * anything. Worst case is that we lose a reschedule ...
>> - */
>> -static inline void smp_send_reschedule(int cpu)
>> -{
>> -    loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
>> -}
>> -
>>   static inline void arch_send_call_function_single_ipi(int cpu)
>>   {
>>       loongson_send_ipi_single(cpu, SMP_CALL_FUNCTION);
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index 6ed72f7ff278..51dd3c3f06cb 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -141,6 +141,17 @@ void loongson_send_ipi_single(int cpu, unsigned int action)
>>       ipi_write_action(cpu_logical_map(cpu), (u32)action);
>>   }
>>   +/*
>> + * This function sends a 'reschedule' IPI to another CPU.
>> + * it goes straight through and wastes no time serializing
>> + * anything. Worst case is that we lose a reschedule ...
>> + */
>> +void smp_send_reschedule(int cpu)
>> +{
>> +    loongson_send_ipi_single(cpu, SMP_RESCHEDULE);
>> +}
>> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
>> +
> 
> While the change is in itself okay (one less case of mips legacy, getting in line with ia64, powerpc and riscv that all EXPORT_SYMBOL_GPL this), I'd suggest you batch this patch with the subsequent changes you plan to enable with this one, so reviewers would have more context and hopefully avoid churn. (I, by my familiarity with Loongson and LoongArch development, know you're probably aiming to use this with KVM, but others probably don't know, and again it's always better to have more context.)
> 

yes, kvm module depends on function smp_send_reschedule, only that it is not mature now. And this function is standard API, not arch specified API, it is normal for modules to use it :)

regards
bibo,mao
>>   void loongson_send_ipi_mask(const struct cpumask *mask, unsigned int action)
>>   {
>>       unsigned int i;
> 

