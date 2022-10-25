Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1832760D0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJYPjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiJYPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:39:11 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C216910D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:39:09 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j4so22854466lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rc6vP6aw0tpiHFL5bJLFi2OMc2JAOBh2wNmcX8c+8ps=;
        b=NHQQEGq71Q+6Il33iUAFVexn9iQ9mWzEpO59NT/JRQmp1rXaGuradS+hrrsXAABJEc
         U7+PYBkWWTrZuVX++OEabLPKlbh2MwvYGa2ZDOgLYbLRvL/JCw+mvgf+2vRP+BMoDmES
         50uLNq2wVutVOjjXsr0E24szHMNb6UdlNj5ujOGxzWZWZ1XfwpNViglNC5TvcH8cIeeh
         VDNX60G8aZyrTU1leILKjgGDu4weUlcQbh0HsW5v+Q/NAeAgb62XhB0taMIpQ97SmIkv
         0JmGjlfvm1nsAxuYX5VMu2aQNtl4EL0MaqZEK9ux1Rryi8tJ/ftoDDmszB4DXeDMSNPw
         3Gtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc6vP6aw0tpiHFL5bJLFi2OMc2JAOBh2wNmcX8c+8ps=;
        b=lslGYHFEYegWoaoGd0tlpxguBydkGuHet+dvD/WD+8bLztrwjQt5SC0xHuQWHSvmmD
         HGkv2x47yQaOHOOuQkoPpocwwzvAZ4AQw8JWru32PslDOTlYPIhMqdwa4M6UesBftad0
         DFJVWZ1LKCYAMg9+IuIQY7/R9vVO78b1kMNZGVupp6QgPJG/13RiWe5QDB3FPOVsslK6
         9hl31GuHgmewHdnSKyOzwwSEheIboM+wY/ov1xVPzJ/+h91qNooHTgMT5LsHLphPQ/X+
         Gfe/m3mwxJXbF8dzKmjOhwHcrqiK/Cas/0HUDp1sFMWrQT5b16ETgSMdN9J0o4+Z+OCN
         vuCQ==
X-Gm-Message-State: ACrzQf0mWJKJPPKa4y+jaiZV7jVPegKASufrcBEo7wUFSiONGewgjSZ2
        dB2fooyRPhz/PauP13FOYD9MCPUnYxmx7Q==
X-Google-Smtp-Source: AMsMyM69dhdvfPKkhT7iauQ6D+ADqgjpD7E6mXZhD5FujxKc5923A11jM3+aHCM/KMbUhPo9KbpOTg==
X-Received: by 2002:a05:6512:261c:b0:49f:af36:d47 with SMTP id bt28-20020a056512261c00b0049faf360d47mr13775733lfb.284.1666712348133;
        Tue, 25 Oct 2022 08:39:08 -0700 (PDT)
Received: from ?IPV6:2a02:6b8:0:107:3e85:844d:5b1d:60a? ([2a02:6b8:0:107:3e85:844d:5b1d:60a])
        by smtp.gmail.com with ESMTPSA id p8-20020a2eba08000000b0026e00df2ed0sm547761lja.30.2022.10.25.08.39.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 08:39:07 -0700 (PDT)
Message-ID: <278cc353-6289-19e8-f7a9-0acd70bc8e11@gmail.com>
Date:   Tue, 25 Oct 2022 18:39:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [tip:x86/mm] [x86/mm] 1248fb6a82:
 Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Seth Jenkins <sethjenkins@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, "Yin, Fengwei" <fengwei.yin@intel.com>
References: <202210241508.2e203c3d-yujie.liu@intel.com>
 <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
From:   Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <Y1e7kgKweck6S954@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/22 13:33, Peter Zijlstra wrote:
> On Tue, Oct 25, 2022 at 12:54:40PM +0800, kernel test robot wrote:
>> Hi Peter,
>>
>> We noticed that below commit changed the value of
>> CPU_ENTRY_AREA_MAP_SIZE. Seems KASAN uses this value to allocate memory,
>> and failed during initialization after this change, so we send this
>> mail and Cc KASAN folks. Please kindly check below report for more
>> details. Thanks.
>>
>>
>> Greeting,
>>
>> FYI, we noticed Kernel_panic-not_syncing:kasan_populate_pmd:Failed_to_allocate_page due to commit (built with gcc-11):
>>
>> commit: 1248fb6a8201ddac1c86a202f05a0a1765efbfce ("x86/mm: Randomize per-cpu entry area")
>> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
>>
>> in testcase: boot
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> [    7.114808][    T0] Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000
>> [    7.119742][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1-00001-g1248fb6a8201 #1
>> [    7.122122][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
>> [    7.124976][    T0] Call Trace:
>> [    7.125849][    T0]  <TASK>
>> [    7.126642][    T0]  ? dump_stack_lvl+0x45/0x5d
>> [    7.127908][    T0]  ? panic+0x21e/0x46a
>> [    7.129009][    T0]  ? panic_print_sys_info+0x77/0x77
>> [    7.130618][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
>> [    7.132224][    T0]  ? memblock_alloc_try_nid+0xd9/0x118
>> [    7.133717][    T0]  ? memblock_alloc_try_nid_raw+0x106/0x106
>> [    7.135252][    T0]  ? kasan_populate_pmd+0x142/0x1d2
>> [    7.136655][    T0]  ? early_alloc+0x95/0x9d
>> [    7.137738][    T0]  ? kasan_populate_pmd+0x142/0x1d2
>> [    7.138936][    T0]  ? kasan_populate_pud+0x182/0x19f
>> [    7.140335][    T0]  ? kasan_populate_shadow+0x1e0/0x233
>> [    7.141759][    T0]  ? kasan_init+0x3be/0x57f
>> [    7.142942][    T0]  ? setup_arch+0x101d/0x11f0
>> [    7.144229][    T0]  ? start_kernel+0x6f/0x3d0
>> [    7.145449][    T0]  ? secondary_startup_64_no_verify+0xe0/0xeb
>> [    7.147051][    T0]  </TASK>
>> [    7.147868][    T0] ---[ end Kernel panic - not syncing: kasan_populate_pmd+0x142/0x1d2: Failed to allocate page, nid=0 from=1000000 ]---
> 
> Ufff, no idea about what KASAN wants here; Andrey, you have clue?
> 
> Are you trying to allocate backing space for .5T of vspace and failing
> that because the kvm thing doesn't have enough memory?
> 

KASAN tries to allocate shadow memory for the whole cpu entry area.
The size is CPU_ENTRY_AREA_MAP_SIZE/8 and this is obviously fails after your patch.
The fix this might be something like this:


---
 arch/x86/include/asm/kasan.h |  2 ++
 arch/x86/mm/cpu_entry_area.c |  3 +++
 arch/x86/mm/kasan_init_64.c  | 16 +++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 13e70da38bed..77dd8b57f1e2 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -28,9 +28,11 @@
 #ifdef CONFIG_KASAN
 void __init kasan_early_init(void);
 void __init kasan_init(void);
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size);
 #else
 static inline void kasan_early_init(void) { }
 static inline void kasan_init(void) { }
+static inline void kasan_populate_shadow_for_vaddr(void *va, size_t size) { }
 #endif
 
 #endif
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index ad1f750517a1..602daa550543 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -9,6 +9,7 @@
 #include <asm/cpu_entry_area.h>
 #include <asm/fixmap.h>
 #include <asm/desc.h>
+#include <asm/kasan.h>
 
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage);
 
@@ -91,6 +92,8 @@ void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 static void __init
 cea_map_percpu_pages(void *cea_vaddr, void *ptr, int pages, pgprot_t prot)
 {
+	kasan_populate_shadow_for_vaddr(cea_vaddr, pages*PAGE_SIZE);
+
 	for ( ; pages; pages--, cea_vaddr+= PAGE_SIZE, ptr += PAGE_SIZE)
 		cea_set_pte(cea_vaddr, per_cpu_ptr_to_phys(ptr), prot);
 }
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index e7b9b464a82f..dbee52f14700 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -316,6 +316,19 @@ void __init kasan_early_init(void)
 	kasan_map_early_shadow(init_top_pgt);
 }
 
+void __init kasan_populate_shadow_for_vaddr(void *va, size_t size)
+{
+	unsigned long shadow_start, shadow_end;
+
+	shadow_start = (unsigned long)kasan_mem_to_shadow(va);
+	shadow_start = round_down(shadow_start, PAGE_SIZE);
+	shadow_end = (unsigned long)kasan_mem_to_shadow(va + size);
+	shadow_end = round_up(shadow_end, PAGE_SIZE);
+
+	kasan_populate_shadow(shadow_start, shadow_end,
+			      early_pfn_to_nid(__pa(va)));
+}
+
 void __init kasan_init(void)
 {
 	int i;
@@ -393,9 +406,6 @@ void __init kasan_init(void)
 		kasan_mem_to_shadow((void *)VMALLOC_END + 1),
 		shadow_cpu_entry_begin);
 
-	kasan_populate_shadow((unsigned long)shadow_cpu_entry_begin,
-			      (unsigned long)shadow_cpu_entry_end, 0);
-
 	kasan_populate_early_shadow(shadow_cpu_entry_end,
 			kasan_mem_to_shadow((void *)__START_KERNEL_map));
 
-- 
2.37.4

