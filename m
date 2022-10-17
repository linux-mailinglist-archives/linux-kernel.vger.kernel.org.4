Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A5E60071C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJQG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiJQG4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:56:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E38A57896
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 23:55:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H5L8pj001597;
        Mon, 17 Oct 2022 06:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=W307ZMgjpJWrwvfrbiwXMexvBy+E75TxBf5gCogIVsw=;
 b=d11bKYWw2fo/YrPKyVA8FmZFrpAFiPTkHN+RgNyNHdsEXXiWtQZ11u0PwOd7vINaOXs+
 nLKHT3dQHMEQ0ek2HY1B9QZZToEGDwKXuraNOC4gaA5JT7LY+9Q4d0a1ktY390hYmEWp
 eTYuTWlTcLMT59K+7EqubCtiUP30n1Ns2LaWmz/8bFo9SwV/2j4MUrb1n4m8iPN+48xh
 LIzqAUspbgqvd96xdIs2n5x4qrP4C0+a0ysGx3aFoH3ChfEmq5G7JyvWV/Uu0trHwqj8
 l38qqZl2S8V5TnwUVK9NzjJ+ALIuws+ZPuMIswtZ+xuF+cfTPNuoKWv6hC8L1gadiWNn uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5pcfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:54:50 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29H6NXP6032001;
        Mon, 17 Oct 2022 06:54:49 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3k86g5pcer-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:54:49 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29H6oq0S024265;
        Mon, 17 Oct 2022 06:54:47 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3k7mg8sve8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Oct 2022 06:54:47 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29H6sjOx64487830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 06:54:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FBAFA4055;
        Mon, 17 Oct 2022 06:54:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D302A4040;
        Mon, 17 Oct 2022 06:54:40 +0000 (GMT)
Received: from [9.43.94.119] (unknown [9.43.94.119])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Oct 2022 06:54:40 +0000 (GMT)
Message-ID: <b3608266-f9f7-367a-1aed-3e5ace74d011@linux.ibm.com>
Date:   Mon, 17 Oct 2022 12:24:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <78100f92-afd7-52b6-d5e5-17eb2de72a9a@linux.ibm.com>
 <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <46e0908c-a753-bec1-68bf-a58a89798056@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: beBD2Q5DQhVRKh1jbWJO78MQeCWld_76
X-Proofpoint-ORIG-GUID: G9I1OKB4NUKQ64wZ5lYa-jDhC1EFTbqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210170038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 08/10/22 01:03, Eric DeVolder wrote:
>
>
> On 9/19/22 02:06, Sourabh Jain wrote:
>>
>> On 10/09/22 02:35, Eric DeVolder wrote:
>>> For x86_64, when CPU or memory is hot un/plugged, the crash
>>> elfcorehdr, which describes the CPUs and memory in the system,
>>> must also be updated.
>>>
>>> When loading the crash kernel via kexec_load or kexec_file_load,
>>> the elfcorehdr is identified at run time in
>>> crash_core:handle_hotplug_event().
>>>
>>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>>> generated from the available CPUs and memory. The new elfcorehdr
>>> is prepared into a buffer, and then installed over the top of
>>> the existing elfcorehdr.
>>>
>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>> the need to update purgatory due to the change in elfcorehdr was
>>> eliminated.  As a result, no changes to purgatory or boot_params
>>> (as the elfcorehdr= kernel command line parameter pointer
>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>
>>> To accommodate a growing number of resources via hotplug, the
>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>>
>>> With this change, crash hotplug for kexec_file_load syscall
>>> is supported. The kexec_load is also supported, but also
>>> requires a corresponding change to userspace kexec-tools.
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   arch/x86/Kconfig             |  11 ++++
>>>   arch/x86/include/asm/kexec.h |  20 +++++++
>>>   arch/x86/kernel/crash.c      | 102 
>>> +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 133 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index f9920f1341c8..cdfc9b2fdf98 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>>>         (CONFIG_RELOCATABLE=y).
>>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>>> +config CRASH_MAX_MEMORY_RANGES
>>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || 
>>> MEMORY_HOTPLUG)
>>> +    int
>>> +    default 32768
>>> +    help
>>> +      For the kexec_file_load path, specify the maximum number of
>>> +      memory regions, eg. as represented by the 'System RAM' entries
>>> +      in /proc/iomem, that the elfcorehdr buffer/segment can 
>>> accommodate.
>>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>> +      size to determine the final buffer size.
>>> +
>>>   config KEXEC_JUMP
>>>       bool "kexec jump"
>>>       depends on KEXEC && HIBERNATION
>>> diff --git a/arch/x86/include/asm/kexec.h 
>>> b/arch/x86/include/asm/kexec.h
>>> index a3760ca796aa..432073385b2d 100644
>>> --- a/arch/x86/include/asm/kexec.h
>>> +++ b/arch/x86/include/asm/kexec.h
>>> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>>>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>>>   extern void kdump_nmi_shootdown_cpus(void);
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>>> +#define arch_map_crash_pages arch_map_crash_pages
>>> +
>>> +void arch_unmap_crash_pages(void **ptr);
>>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>>> +
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +        unsigned int hp_action);
>>> +#define arch_crash_handle_hotplug_event 
>>> arch_crash_handle_hotplug_event
>>> +
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>>> +#endif
>>> +
>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>>> +#endif
>>> +
>>>   #endif /* __ASSEMBLY__ */
>>>   #endif /* _ASM_X86_KEXEC_H */
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index 9ceb93c176a6..8fc7d678ac72 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/memblock.h>
>>> +#include <linux/highmem.h>
>>>   #include <asm/processor.h>
>>>   #include <asm/hardirq.h>
>>> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>>>       image->elf_headers = kbuf.buffer;
>>>       image->elf_headers_sz = kbuf.bufsz;
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>>> +    kbuf.memsz =
>>> +        (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>>> +            sizeof(Elf64_Phdr);
>>> +    /* Mark as usable to crash kernel, else crash kernel fails on 
>>> boot */
>>> +    image->elf_headers_sz = kbuf.memsz;
>>> +    image->elfcorehdr_index = image->nr_segments;
>>> +    image->elfcorehdr_index_valid = true;
>>> +#else
>>>       kbuf.memsz = kbuf.bufsz;
>>> +#endif
>>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>       ret = kexec_add_buffer(&kbuf);
>>> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>>>       return ret;
>>>   }
>>>   #endif /* CONFIG_KEXEC_FILE */
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +/*
>>> + * NOTE: The addresses and sizes passed to this routine have
>>> + * already been fully aligned on page boundaries. There is no
>>> + * need for massaging the address or size.
>>> + */
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>>> +{
>>> +    void *ptr = NULL;
>>> +
>>> +    if (size > 0) {
>>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>>> +
>>> +        ptr = kmap_local_page(page);
>>> +    }
>>> +
>>> +    return ptr;
>>> +}
>>> +
>>> +void arch_unmap_crash_pages(void **ptr)
>>> +{
>>> +    if (ptr) {
>>> +        if (*ptr)
>>> +            kunmap_local(*ptr);
>>> +        *ptr = NULL;
>>> +    }
>>> +}
>>> +
>>> +/**
>>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr 
>>> changes
>>> + * @image: the active struct kimage
>>> + * @hp_action: the hot un/plug action being handled
>>> + *
>>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>>> + * is prepared in a kernel buffer, and then it is written on top
>>> + * of the existing/old elfcorehdr.
>>> + */
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +    unsigned int hp_action)
>>> +{
>>> +    struct kexec_segment *ksegment;
>>> +    unsigned char *ptr = NULL;
>>> +    unsigned long elfsz = 0;
>>> +    void *elfbuf = NULL;
>>> +    unsigned long mem, memsz;
>>> +
>>> +    /*
>>> +     * Elfcorehdr_index_valid checked in 
>>> crash_core:handle_hotplug_event()
>>> +     */
>>> +    ksegment = &image->segment[image->elfcorehdr_index];
>>> +    mem = ksegment->mem;
>>> +    memsz = ksegment->memsz;
>>> +
>>> +    /*
>>> +     * Create the new elfcorehdr reflecting the changes to CPU and/or
>>> +     * memory resources.
>>> +     */
>>> +    if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>>> +        pr_err("crash hp: unable to prepare elfcore headers");
>>> +        goto out;
>>
>> On PowerPC, while preparing the elf core header the memblock 
>> structure is used to prepare program header for memory regions of 
>> elfcorehdr. Since the above arch specific hotplug handler gets 
>> invoked when memory is marked offline (MEM_OFFLINE) which is before 
>> memblock structure gets updated so on PowerPC the above handler may 
>> not work for memory hotplug case.
>>
>> Just wondering which data structure is used to get the list of memory 
>> regions while preparing program header for memory regions of 
>> elfcorehdr on other architectures?
>>
>> Thanks,
>> Sourabh Jain
>
> I think your request to report the memory block address in comments of 
> patch 3/7 "crash: add generic infrastructure" cover this scenario now.
Yes, the asked changes will make easy for PowerPC to recreate elfcorehdr.

Thanks,
Sourabh Jain
