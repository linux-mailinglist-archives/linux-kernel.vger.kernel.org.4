Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC35F84AC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJHJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJHJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:51:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B05B74D17B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 02:51:37 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOInSEFjNGYoAA--.16373S3;
        Sat, 08 Oct 2022 17:51:36 +0800 (CST)
Subject: Re: [PATCH] LoongArch: Do not create sysfs control file for io master
 CPUs
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
References: <1665219579-2501-1-git-send-email-yangtiezhu@loongson.cn>
 <922e6d73-78e5-8852-788b-017d0dbe4df5@xen0n.name>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <75f1aa18-2e84-107a-f0b6-3e4b753ab8b1@loongson.cn>
Date:   Sat, 8 Oct 2022 17:51:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <922e6d73-78e5-8852-788b-017d0dbe4df5@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxBOInSEFjNGYoAA--.16373S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGr17Zry3WFW3XryfGw1kuFg_yoW5Kr1kpF
        yIkF4UKr48WF1kGay0gw1jvryYv3sxG34SvFW2ka48Ca4DArn09F1ktrn5XF17AFWFkFWF
        vr9Y9rWS9Fy5J3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5iiSJUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/08/2022 05:27 PM, WANG Xuerui wrote:
> On 2022/10/8 16:59, Tiezhu Yang wrote:
>> Now io master CPUs are not hotpluggable on LoongArch, in the current
>> code,
>> only /sys/devices/system/cpu/cpu0/online is not created, let us set the
>> hotpluggable field of all the io master CPUs as 0, then prevent to create
>> sysfs control file for the other io master CPUs which confuses some user
>> space tools. This is similar with commit 9cce844abf07 ("MIPS: CPU#0 is
>> not
>> hotpluggable").
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   arch/loongarch/kernel/smp.c      |  8 --------
>>   arch/loongarch/kernel/topology.c | 12 +++++++++++-
>>   2 files changed, 11 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
>> index b5fab30..ef89292 100644
>> --- a/arch/loongarch/kernel/smp.c
>> +++ b/arch/loongarch/kernel/smp.c
>> @@ -240,19 +240,11 @@ void loongson3_smp_finish(void)
>>     #ifdef CONFIG_HOTPLUG_CPU
>>   -static bool io_master(int cpu)
>> -{
>> -    return test_bit(cpu, &loongson_sysconf.cores_io_master);
>> -}
>> -
>>   int loongson3_cpu_disable(void)
>>   {
>>       unsigned long flags;
>>       unsigned int cpu = smp_processor_id();
>>   -    if (io_master(cpu))
>> -        return -EBUSY;
>> -
>
> Could this get invoked from somewhere other than the sysfs entries that
> "confuse user-space tools", e.g. from somewhere else in kernel land? If
> so (or if we can't rule out the possibility) keeping the guard here
> might prove more prudent.
>

If c->hotpluggable is 0, it will not generate a control file in sysfs
for this CPU, for example:

[root@linux loongson]# cat /sys/devices/system/cpu/cpu0/online
cat: /sys/devices/system/cpu/cpu0/online: No such file or directory
[root@linux loongson]# echo 0 > /sys/devices/system/cpu/cpu0/online
bash: /sys/devices/system/cpu/cpu0/online: Permission denied

So no need to check it here, just remove the code.

This was done in commit cbab54d9c2b2 ("MIPS: No need to check CPU 0 in
{loongson3,bmips,octeon}_cpu_disable()").

>>   #ifdef CONFIG_NUMA
>>       numa_remove_cpu(cpu);
>>   #endif
>> diff --git a/arch/loongarch/kernel/topology.c
>> b/arch/loongarch/kernel/topology.c
>> index ab1a75c..7e7a77f 100644
>> --- a/arch/loongarch/kernel/topology.c
>> +++ b/arch/loongarch/kernel/topology.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/node.h>
>>   #include <linux/nodemask.h>
>>   #include <linux/percpu.h>
>> +#include <asm/bootinfo.h>
>>     static DEFINE_PER_CPU(struct cpu, cpu_devices);
>>   @@ -33,6 +34,11 @@ void arch_unregister_cpu(int cpu)
>>   EXPORT_SYMBOL(arch_unregister_cpu);
>>   #endif
>>   +static bool io_master(int cpu)
>> +{
>> +    return test_bit(cpu, &loongson_sysconf.cores_io_master);
>> +}
>> +
>>   static int __init topology_init(void)
>>   {
>>       int i, ret;
>> @@ -40,7 +46,11 @@ static int __init topology_init(void)
>>       for_each_present_cpu(i) {
>>           struct cpu *c = &per_cpu(cpu_devices, i);
>>   -        c->hotpluggable = !!i;
>> +        if (io_master(i))
>> +            c->hotpluggable = 0;
>> +        else
>> +            c->hotpluggable = 1;
>> +
>
> This is just "c->hotpluggable = !io_master(i);".
>

Yes, I am OK either way, if it is necessary to send v2,
please let me know.

>>           ret = register_cpu(c, i);
>>           if (ret < 0)
>>               pr_warn("topology_init: register_cpu %d failed (%d)\n",
>> i, ret);
> Other changes should be okay as they are in line with the previous MIPS
> change you referenced, but let's see what Huacai thinks.
>

Thanks,
Tiezhu

