Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509D05E58FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 05:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiIVDJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 23:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIVDJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 23:09:22 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B653A2637;
        Wed, 21 Sep 2022 20:09:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d11so125533pll.8;
        Wed, 21 Sep 2022 20:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=rl1V8i/19g2BpHGNfkomTENIQJl6suPkyvuKZnztk5k=;
        b=qO+DRizWuRbQnin5VWP0y6OJN9zoVAngR5k9QVMxq6sx+RqHZn8lgviLJEHBJqCXeT
         rc0c8d9Fl1oCTJ9NHuxX2qgwqtFwWJdoezPzCWCZokbIHY3NllBx6k8Dqg0b9RbI25At
         ttzc89UA2XoMk+/cVoGoxrv7b3qMT5irvi7bj8PWFUKDw2WbyGzw3+NXWEhY6nhQuHz/
         fxDVmhktGCrHRjkZ+7AzznwCYTpm4z7OZke9Kwwj3urCe66wDmLCIyEVjQe1pWNwy45m
         OW7Md0ebvb3ZKi1OoUI9GOVM+fYEi1ezHTiysDCO2OHhhF3bJCwa9Ri/DF1mkq49ZqHB
         aqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=rl1V8i/19g2BpHGNfkomTENIQJl6suPkyvuKZnztk5k=;
        b=WmrC0vydJnDISIBmUX/sd2pW0yno9yA0MIS5PdRbvyER41tNimJcMb9bWLzHNxOnbK
         NJ3iILkUyE0tAo5POTCTIR4p02JJkKKHv0S7SF4wiAz4tzEHei40zObOGEnDHCTO4a5T
         Xs2dXuAw8NtHZvLG/uG6bXcLi6YCxv7VT4o8e9OxvmwnqBzTa6RQQuLuPW5yTNwI6Tx5
         y9ESKrpmYoQg7/SXxXhDtyAoHSbHMGGRgKfUwB2O+3uS81rkb+cRdZmD+CRrl9Ou/JFG
         QPoGIUcwKN82Flyq+Wa3EVtkBAguem7yCID8VmjDyi0wNSORH6kmYxZc6Wa1UDKa6M7P
         zZnQ==
X-Gm-Message-State: ACrzQf0/aBmM4AeOjk4B+xzQ7xyDVNuyv/I+718JY7p8NkXjrThgV8uA
        6HvXEJcxtK9/S5wtdDQ92H4=
X-Google-Smtp-Source: AMsMyM56g2ZnC2aDwqRnlD/XfGawOLUhDiBnRUnfBddoG1Wlo/8msyO4+BVJCQy0a2zrVjEz3GLtYg==
X-Received: by 2002:a17:902:f782:b0:173:1206:cee0 with SMTP id q2-20020a170902f78200b001731206cee0mr1276576pln.130.1663816156601;
        Wed, 21 Sep 2022 20:09:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 192-20020a6217c9000000b0053788e9f865sm2969883pfx.21.2022.09.21.20.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 20:09:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d8cd7c7e-24c1-7f70-24a9-91c77aa634af@roeck-us.net>
Date:   Wed, 21 Sep 2022 20:09:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] x86/mm: Refuse W^X violations
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, keescook@chromium.org,
        Sean Christopherson <seanjc@google.com>
References: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
 <20220921200726.GA3094503@roeck-us.net>
 <4dd594ad-490a-68ee-9e32-fbd9f135bd54@intel.com>
 <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
In-Reply-To: <1a6e7165-cdae-6c8c-f57d-159fdb68897b@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 15:59, Guenter Roeck wrote:
> On 9/21/22 13:59, Dave Hansen wrote:
>> On 9/21/22 13:07, Guenter Roeck wrote:
>>> [    2.042861] CPA refuse W^X violation: 8000000000000063 -> 0000000000000063 range: 0x00000000c00a0000 - 0x00000000c00a0fff PFN a0
>>> ILLOPC: cbc65efa: 0f 0b
>>> [    2.043267] WARNING: CPU: 0 PID: 1 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0xdca/0xdd0
>> ...
>>> [    2.050307] ---[ end trace 0000000000000000 ]---
>>> [    2.050762] PCI: PCI BIOS area is rw and x. Use pci=nobios if you want it NX.
>>> [    2.051115] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
>>> [    2.051115] BUG: unable to handle page fault for address: c00fd2bf
>>
>> This _looks_ like it is working as intended.  The PCI BIOS code tried to
>> make a RWX page.  The CPA code refused to do it and presumably returned
>> an error, leaving a RW page, non-executable page.  The PCI code didn't
>> check the set_memory_x() return code and tried to go execute anyway.
>> That resulted in the oops.
>>
>> I was able to reproduce this pretty easily.  The workaround from dmesg
>> is pci=nobios.  That seems to do the trick for me, although that advise
>> was sandwiched between a warning and an oops, so not the easiest to find.
>>
>> I'm a bit torn what to do on this one.  Breaking the boot is bad, but so
>> is leaving RWX memory around.
>>
>> Thoughts?
> 
> For my part I'll do what the above suggests, ie run tests with PAE enabled
> with pci=nobios command line option. AFAICS that hides the problem in my tests.
> I am just not sure if that is really appropriate.
> 

Oh well, that "helped" to hide one of the crashes. Here is another one.
This is with PAE enabled and booting through efi32.

Guenter

---
[    1.080779] ------------[ cut here ]------------
[    1.080959] CPA refuse W^X violation: 8000000000000063 -> 0000000000000063 range: 0x00000000d0770000 - 0x00000000d0770fff PFN edcd
ILLOPC: c7465efa: 0f 0b
[    1.081467] WARNING: CPU: 0 PID: 0 at arch/x86/mm/pat/set_memory.c:600 __change_page_attr_set_clr+0xdca/0xdd0
[    1.082120] Modules linked in:
[    1.082476] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc6-next-20220921 #1
[    1.082706] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[    1.082988] EIP: __change_page_attr_set_clr+0xdca/0xdd0
[    1.083187] Code: 10 8b 45 ac 89 7c 24 04 89 74 24 14 89 4c 24 1c 8d 8e ff 0f 00 00 89 4c 24 18 89 44 24 08 c7 04 24 38 67 88 c8 e8 56 38 fb 00 <0f> 0b eb 83 66 90 55 89 e5 57 56 89 d6 53 89 c3 83 ec 58 31 d2 8b
[    1.083672] EAX: 00000076 EBX: 0edcd063 ECX: 00000000 EDX: 00000003
[    1.083830] ESI: d0770000 EDI: 00000063 EBP: c8a3dea8 ESP: c8a3dd90
[    1.083984] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200296
[    1.084286] CR0: 80050033 CR2: ffbff000 CR3: 08d7c000 CR4: 000006b0
[    1.084501] Call Trace:
[    1.084849]  ? __this_cpu_preempt_check+0xf/0x11
[    1.085053]  ? __purge_vmap_area_lazy+0x6c/0x640
[    1.085269]  ? _vm_unmap_aliases.part.0+0x1d8/0x1f0
[    1.085415]  ? __mutex_unlock_slowpath+0x2b/0x2b0
[    1.085536]  ? purge_fragmented_blocks_allcpus+0x64/0x2c0
[    1.085696]  ? _vm_unmap_aliases.part.0+0x1d8/0x1f0
[    1.085820]  ? _vm_unmap_aliases.part.0+0x54/0x1f0
[    1.086004]  change_page_attr_set_clr+0x11d/0x2d0
[    1.086313]  ? __efi_memmap_init+0x70/0xd3
[    1.086475]  set_memory_x+0x56/0x60
[    1.086592]  efi_runtime_update_mappings+0x36/0x42
[    1.086717]  efi_enter_virtual_mode+0x351/0x36e
[    1.086860]  start_kernel+0x57d/0x60f
[    1.086956]  ? set_intr_gate+0x42/0x55
[    1.087079]  i386_start_kernel+0x43/0x45
[    1.087272]  startup_32_smp+0x161/0x164
[    1.087491] irq event stamp: 6582
[    1.087593] hardirqs last  enabled at (6590): [<c74e7119>] __up_console_sem+0x69/0x80
[    1.087824] hardirqs last disabled at (6597): [<c74e70fd>] __up_console_sem+0x4d/0x80
[    1.088010] softirqs last  enabled at (6571): [<c7429a94>] call_on_stack+0x14/0x60
[    1.088278] softirqs last disabled at (6614): [<c7429a94>] call_on_stack+0x14/0x60
[    1.088466] ---[ end trace 0000000000000000 ]---
[    1.089237] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[    1.089237] BUG: unable to handle page fault for address: d0810e2a
[    1.089237] #PF: supervisor instruction fetch in kernel mode
[    1.089237] #PF: error_code(0x0011) - permissions violation
[    1.089237] *pdpt = 0000000008d78001 *pde = 000000000eec6067 *pte = 800000000fe98063
[    1.089237] Oops: 0011 [#1] PREEMPT SMP PTI
[    1.089237] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.0.0-rc6-next-20220921 #1
[    1.089237] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[    1.089237] EIP: 0xd0810e2a
[    1.089237] Code: 75 0c ff 75 08 68 c1 45 81 d0 6a 40 e8 ef ce ff ff 83 c4 20 83 ec 0c 53 e8 d4 cf ff ff 83 c4 10 31 c0 8d 65 f4 5b 5e 5f 5d c3 <55> 89 e5 57 56 53 bb 02 00 00 80 83 ec 5c 8b 7d 08 85 ff 0f 84 ed
[    1.089237] EAX: d0810e2a EBX: 00200202 ECX: 00000049 EDX: 00000000
[    1.089237] ESI: c8a3df30 EDI: c84c5000 EBP: c8a3df20 ESP: c8a3def8
[    1.089237] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00200202
[    1.089237] CR0: 80050033 CR2: d0810e2a CR3: 08d7c000 CR4: 000006b0
[    1.089237] Call Trace:
[    1.089237]  ? virt_efi_set_variable_nonblocking+0x80/0xf0
[    1.089237]  ? virt_efi_reset_system+0xe0/0xe0
[    1.089237]  efi_delete_dummy_variable+0x55/0x70
[    1.089237]  efi_enter_virtual_mode+0x356/0x36e
[    1.089237]  start_kernel+0x57d/0x60f
[    1.089237]  ? set_intr_gate+0x42/0x55
[    1.089237]  i386_start_kernel+0x43/0x45
[    1.089237]  startup_32_smp+0x161/0x164
[    1.089237] Modules linked in:
[    1.089237] CR2: 00000000d0810e2a
[    1.089237] ---[ end trace 0000000000000000 ]---
[    1.089237] EIP: 0xd0810e2a

