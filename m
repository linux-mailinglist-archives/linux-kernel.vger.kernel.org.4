Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA6603888
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJSDRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSDR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:17:27 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E046E1941;
        Tue, 18 Oct 2022 20:17:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0VSYahCs_1666149436;
Received: from 30.221.97.167(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VSYahCs_1666149436)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 11:17:18 +0800
Message-ID: <811bdf09-be38-ce2a-a1d3-ada9f7c85b97@linux.alibaba.com>
Date:   Wed, 19 Oct 2022 11:17:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH V3 1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
To:     =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= 
        <k-hagio-ab@nec.com>, Baoquan He <bhe@redhat.com>,
        lijiang <lijiang@redhat.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "alexandre.ghiti@canonical.com" <alexandre.ghiti@canonical.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Conor.Dooley@microchip.com" <Conor.Dooley@microchip.com>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "crash-utility@redhat.com" <crash-utility@redhat.com>,
        "heinrich.schuchardt@canonical.com" 
        <heinrich.schuchardt@canonical.com>,
        "hschauhan@nulltrace.org" <hschauhan@nulltrace.org>,
        "yixun.lan@gmail.com" <yixun.lan@gmail.com>
References: <20221018081755.6214-1-xianting.tian@linux.alibaba.com>
 <20221018081755.6214-2-xianting.tian@linux.alibaba.com>
 <Y05tfxRenMs5d+bt@MiWiFi-R3L-srv>
 <049ec19e-60c3-2854-5f5e-9850231108b4@linux.alibaba.com>
 <Y05540td7lLz+0BY@MiWiFi-R3L-srv>
 <a66a5b16-5f1f-3d80-3cdc-4b82d38d604f@linux.alibaba.com>
 <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
In-Reply-To: <0f0a77a9-c824-8aa4-77de-a75c2139d791@nec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/10/19 上午10:50, HAGIO KAZUHITO(萩尾 一仁) 写道:
> On 2022/10/19 10:50, Xianting Tian wrote:
>> 在 2022/10/18 下午6:03, Baoquan He 写道:
>>> On 10/18/22 at 05:25pm, Xianting Tian wrote:
>>>> 在 2022/10/18 下午5:10, Baoquan He 写道:
>>>>> On 10/18/22 at 04:17pm, Xianting Tian wrote:
>>>>>> Add arch_crash_save_vmcoreinfo(), which exports VM layout(MODULES, VMALLOC,
>>>>>> VMEMMAP and KERNEL_LINK_ADDR ranges), va bits and ram base for vmcore.
>>>>>>
>>>>>> Default pagetable levels and PAGE_OFFSET aren't same for different kernel
>>>>>> version as below. For pagetable levels, it sets sv57 by default and falls
>>>>>> back to setting sv48 at boot time if sv57 is not supported by the hardware.
>>>>>>
>>>>>> For ram base, the default value is 0x80200000 for qemu riscv64 env and,
>>>>>> for example, is 0x200000 on the XuanTie 910 CPU.
>>>>>>
>>>>>>     * Linux Kernel 5.18 ~
>>>>>>     *      PGTABLE_LEVELS = 5
>>>>>>     *      PAGE_OFFSET = 0xff60000000000000
>>>>>>     * Linux Kernel 5.17 ~
>>>>>>     *      PGTABLE_LEVELS = 4
>>>>>>     *      PAGE_OFFSET = 0xffffaf8000000000
>>>>>>     * Linux Kernel 4.19 ~
>>>>>>     *      PGTABLE_LEVELS = 3
>>>>>>     *      PAGE_OFFSET = 0xffffffe000000000
>>>>>>
>>>>>> Since these configurations change from time to time and version to version,
>>>>>> it is preferable to export them via vmcoreinfo than to change the crash's
>>>>>> code frequently, it can simplify the development of crash tool.
>>>>>>
>>>>>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>>>>>> ---
>>>>>>     arch/riscv/kernel/Makefile     |  1 +
>>>>>>     arch/riscv/kernel/crash_core.c | 29 +++++++++++++++++++++++++++++
>>>>>>     2 files changed, 30 insertions(+)
>>>>>>     create mode 100644 arch/riscv/kernel/crash_core.c
>>>>>>
>>>>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>>>>>> index db6e4b1294ba..4cf303a779ab 100644
>>>>>> --- a/arch/riscv/kernel/Makefile
>>>>>> +++ b/arch/riscv/kernel/Makefile
>>>>>> @@ -81,6 +81,7 @@ obj-$(CONFIG_KGDB)        += kgdb.o
>>>>>>     obj-$(CONFIG_KEXEC_CORE)    += kexec_relocate.o crash_save_regs.o machine_kexec.o
>>>>>>     obj-$(CONFIG_KEXEC_FILE)    += elf_kexec.o machine_kexec_file.o
>>>>>>     obj-$(CONFIG_CRASH_DUMP)    += crash_dump.o
>>>>>> +obj-$(CONFIG_CRASH_CORE)    += crash_core.o
>>>>>>     obj-$(CONFIG_JUMP_LABEL)    += jump_label.o
>>>>>> diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
>>>>>> new file mode 100644
>>>>>> index 000000000000..8d7f5ff108da
>>>>>> --- /dev/null
>>>>>> +++ b/arch/riscv/kernel/crash_core.c
>>>>>> @@ -0,0 +1,29 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>> +
>>>>>> +#include <linux/crash_core.h>
>>>>>> +#include <linux/pagemap.h>
>>>>>> +
>>>>>> +void arch_crash_save_vmcoreinfo(void)
>>>>>> +{
>>>>>> +    VMCOREINFO_NUMBER(VA_BITS);
>>>>>> +    VMCOREINFO_NUMBER(phys_ram_base);
>>>>>> +
>>>>>> +    vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
>>>>>> +    vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
>>>>>> +    vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
>>>>>> +    vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>>>>>> +    vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>>>>>> +#ifdef CONFIG_64BIT
>>>>>> +    vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>>>>>> +    vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>>>>>> +#endif
>>>>>> +
>>>>>> +    if (IS_ENABLED(CONFIG_64BIT)) {
>>>>>> +#ifdef CONFIG_KASAN
>>>>>> +        vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_START)=0x%lx\n", KASAN_SHADOW_START);
>>>>>> +        vmcoreinfo_append_str("NUMBER(KASAN_SHADOW_END)=0x%lx\n", KASAN_SHADOW_END);
>>>>>> +#endif
>>>>>> +        vmcoreinfo_append_str("NUMBER(KERNEL_LINK_ADDR)=0x%lx\n", KERNEL_LINK_ADDR);
>>>>>> +        vmcoreinfo_append_str("NUMBER(ADDRESS_SPACE_END)=0x%lx\n", ADDRESS_SPACE_END);
>>>>> Seems this is the firsr ARCH where kasan and kernel link/bpf space are
>>>>> added to dump and analyze. Just curious, have you got code change to
>>>>> make use of them to do dumping and analyze?
>>>> KASAN_SHADOW_START is not used, KERNEL_LINK_ADDR is used in the crash patch set:
>>>> https://patchwork.kernel.org/project/linux-riscv/cover/20220813031753.3097720-1-xianting.tian@linux.alibaba.com/
>>> Oh, I would say please no. Sometime we got tons of objection when adding an
>>> necessary one, we definitely should not add one for possible future
>>> use.
>>>
>>> For this kind of newly added one, we need get ack from
>>> makedumpfile/crash utility maintainer so that we know they are necessary
>>> to have. At least they don't oppose.
>> Hi Kazu, Li Jiang
>>
>> Could you help comment whether we need KASAN_SHADOW_START and KERNEL_LINK_ADDR area export for vmcore from crash point of view？
>>
>> In my crash patch set, I don't use KASAN_SHADOW_START,
>> And only get the value of KERNEL_LINK_ADDR, not realy use it.
>> https://patchwork.kernel.org/project/linux-riscv/cover/20220813031753.3097720-1-xianting.tian@linux.alibaba.com/
> In your crash patch set, KERNEL_LINK_ADDR is used in VTOP() and looks
> necessary to me.
>
> The others (KASAN_SHADOW_START, KASAN_SHADOW_END and ADDRESS_SPACE_END)
> are not currently used.  It may be better to add them when they are
> really used.

I am very sorry, I missed it , KERNEL_LINK_ADDR is used indeed.

KASAN_SHADOW_START is not used, so I don't need to send crash patch set 
again. only need to remove KASAN_SHADOW_END in kernel patch set.

>
> Thanks,
> Kazu
>
>> If we need to remove the two areas, I will resend the crash patch set and kernel patch set.
>> thanks
>>
>>>> I add it in case of using in furture.
>>>>
>>>>> Thanks
>>>>> Baoquan
