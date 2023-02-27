Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108896A3F69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjB0KWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjB0KWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:22:45 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E005CF742
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:22:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cq23so23709697edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 02:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8S3LguPW17QuJ9y7oNHXcA8eXMmuyMSxs+rw2usrIA8=;
        b=hhPX0VVm0DcYtBRb5dpIHPfZ/LuIAE9JEVWcH55xlIJmrjmhvYe/j0wmK9SkEhCpLY
         agyicyQIR2CLDqYjDhvHEyvGV5AwOR54D1pgp0L5Oe24BgPmdmqTl0ARa/ZGEt9DUMo+
         mTBu9YqCq248OHATwLh5fvslhh07bUAm6iJl7829OXtsPp8m5rOWVJjHGjKmaX23n/aF
         mtNHGnOOGWYsAkiUXF8FDCwzAkb72YykVQe75M4n8k8+j55UCmpk/tLuoMKczeSjXDci
         ZYvKLHGVTzWeMcPcUgw8VWl+Op/QLuvl+FpHqwOgvE2HrqmlcyVXMtcHyDvLHsJd3U40
         WKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8S3LguPW17QuJ9y7oNHXcA8eXMmuyMSxs+rw2usrIA8=;
        b=ZwERoIXTBWRWedh3iLx7rdDC2gQUp8O7Tp1FgUcYr1JwXehdz91hPESDscCT8NUH6f
         b4Y2dXcPzqfTBqv3IptSsgzuE0/0KfT2wzIO1Vq+6f/MPb1SlvEXRF/ImfJyjLYHB6eY
         wNViBegmCAGmn439dRQLs6/PI4/aLXcz903oFDg7t9dRXd0hRVRf7BEHNGNe7ut9zyvR
         nsi66MnQGpI5i8G6PJBg11ucDHtI1qhjHyQIxglMb3rd//jHdnZPMx4AP6V8WYFHmJ2E
         UGHbMTJhCYG/PJufI55swql32COGPq7L6H3QG/16EZmmtyNtThM70+mSskEcYALjg4hw
         qLJg==
X-Gm-Message-State: AO0yUKWu97UcvufmpkCkcG2Zkkr5ueA7o482jSd+8tRKenX3tU0LSrCA
        POPnSf0k2i11w62VKT491tA=
X-Google-Smtp-Source: AK7set81QyyPazmXOoc/6sx0uh9dWTW2xXj/82CtOvc0vqbAHhhhBjVSexpM9JHiVw5hWxva99ZsHw==
X-Received: by 2002:a17:906:4081:b0:878:72d0:2817 with SMTP id u1-20020a170906408100b0087872d02817mr32441205ejj.29.1677493362229;
        Mon, 27 Feb 2023 02:22:42 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
        by smtp.gmail.com with ESMTPSA id f2-20020a170906824200b008f0143dfa9dsm3082079ejx.33.2023.02.27.02.22.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 02:22:41 -0800 (PST)
Message-ID: <e2975d53-840c-a104-8b2d-c302f502c894@gmail.com>
Date:   Mon, 27 Feb 2023 11:22:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: amdgpu didn't start with pci=nocrs parameter, get error "Fatal
 error during GPU init"
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <CABXGCsMbqw2qzWSCDfp3cNrYVJ1oxLv8Aixfm_Dt91x1cvFX4w@mail.gmail.com>
 <a99e6def-68be-3f2b-4e01-ac26cdb80f49@gmail.com>
 <CABXGCsM7JPxtQm6B7vk+ZcXfphgQm=ArJZKiDUdbk9hujyRtmg@mail.gmail.com>
 <43016018-4d0a-94dc-ce93-b4bff2dce71c@gmail.com>
 <90b1c9f8-1674-e9ec-e6d8-2fa1967439b3@gmail.com>
 <CABXGCsN2NutEmi==JBDD5G2Bj=DJ6vm87_Cbubycz-WowUOh5w@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsN2NutEmi==JBDD5G2Bj=DJ6vm87_Cbubycz-WowUOh5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.02.23 um 17:21 schrieb Mikhail Gavrilov:
> On Fri, Feb 24, 2023 at 8:31 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Sorry I totally missed that you attached the full dmesg to your original
>> mail.
>>
>> Yeah, the driver did fail gracefully. But then X doesn't come up and
>> then gdm just dies.
> Are you sure that these messages should be present when the driver
> fails gracefully?

Unfortunately yes. We could clean that up a bit more so that you don't 
run into a BUG() assertion, but what essentially happens here is that we 
completely fail to talk to the hardware.

In this situation we can't even re-enable vesa or text console any more.

Regards,
Christian.

>
> turning off the locking correctness validator.
> CPU: 14 PID: 470 Comm: (udev-worker) Tainted: G             L
> -------  ---  6.3.0-0.rc0.20230222git5b7c4cabbb65.3.fc39.x86_64+debug
> #1
> Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY,
> BIOS G513QY.320 09/07/2022
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x57/0x90
>   register_lock_class+0x47d/0x490
>   __lock_acquire+0x74/0x21f0
>   ? lock_release+0x155/0x450
>   lock_acquire+0xd2/0x320
>   ? amdgpu_irq_disable_all+0x37/0xf0 [amdgpu]
>   ? lock_is_held_type+0xce/0x120
>   _raw_spin_lock_irqsave+0x4d/0xa0
>   ? amdgpu_irq_disable_all+0x37/0xf0 [amdgpu]
>   amdgpu_irq_disable_all+0x37/0xf0 [amdgpu]
>   amdgpu_device_fini_hw+0x43/0x2c0 [amdgpu]
>   amdgpu_driver_load_kms+0xe8/0x190 [amdgpu]
>   amdgpu_pci_probe+0x140/0x420 [amdgpu]
>   local_pci_probe+0x41/0x90
>   pci_device_probe+0xc3/0x230
>   really_probe+0x1b6/0x410
>   __driver_probe_device+0x78/0x170
>   driver_probe_device+0x1f/0x90
>   __driver_attach+0xd2/0x1c0
>   ? __pfx___driver_attach+0x10/0x10
>   bus_for_each_dev+0x8a/0xd0
>   bus_add_driver+0x141/0x230
>   driver_register+0x77/0x120
>   ? __pfx_init_module+0x10/0x10 [amdgpu]
>   do_one_initcall+0x6e/0x350
>   do_init_module+0x4a/0x220
>   __do_sys_init_module+0x192/0x1c0
>   do_syscall_64+0x5b/0x80
>   ? asm_exc_page_fault+0x22/0x30
>   ? lockdep_hardirqs_on+0x7d/0x100
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fd58cfcb1be
> Code: 48 8b 0d 4d 0c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 1a 0c 0c 00 f7 d8 64 89 01
> RSP: 002b:00007ffd1d1065d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> RAX: ffffffffffffffda RBX: 000055b0b5aa6d70 RCX: 00007fd58cfcb1be
> RDX: 000055b0b5a96670 RSI: 00000000016b6156 RDI: 00007fd589392010
> RBP: 00007ffd1d106690 R08: 000055b0b5a93bd0 R09: 00000000016b6ff0
> R10: 000055b5eea2c333 R11: 0000000000000246 R12: 000055b0b5a96670
> R13: 0000000000020000 R14: 000055b0b5a9c170 R15: 000055b0b5aa58a0
>   </TASK>
> amdgpu: probe of 0000:03:00.0 failed with error -12
> amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
> [drm] initializing kernel modesetting (RENOIR 0x1002:0x1638 0x1043:0x16C2 0xC4).
>
>
> list_add corruption. prev->next should be next (ffffffffc0940328), but
> was 0000000000000000. (prev=ffff8c9b734062b0).
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:30!
> invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 14 PID: 470 Comm: (udev-worker) Tainted: G             L
> -------  ---  6.3.0-0.rc0.20230222git5b7c4cabbb65.3.fc39.x86_64+debug
> #1
> Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY,
> BIOS G513QY.320 09/07/2022
> RIP: 0010:__list_add_valid+0x74/0x90
> Code: 8d ff 0f 0b 48 89 c1 48 c7 c7 a0 3d b3 99 e8 a3 ed 8d ff 0f 0b
> 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f8 3d b3 99 e8 8c ed 8d ff <0f> 0b
> 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 50 3e b3 99 e8 75 ed 8d
> RSP: 0018:ffffa50f81aafa00 EFLAGS: 00010246
> RAX: 0000000000000075 RBX: ffff8c9b734062b0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
> RBP: ffff8c9b734062b0 R08: 0000000000000000 R09: ffffa50f81aaf8a0
> R10: 0000000000000003 R11: ffff8caa1d2fffe8 R12: ffff8c9b7c0a5e48
> R13: 0000000000000000 R14: ffffffffc13a6d20 R15: 0000000000000000
> FS:  00007fd58c6a5940(0000) GS:ffff8ca9d9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055b0b5a955e0 CR3: 000000017e860000 CR4: 0000000000750ee0
> PKRU: 55555554
> Call Trace:
>   <TASK>
>   ttm_device_init+0x184/0x1c0 [ttm]
>   amdgpu_ttm_init+0xb8/0x610 [amdgpu]
>   ? _printk+0x60/0x80
>   gmc_v9_0_sw_init+0x4a3/0x7c0 [amdgpu]
>   amdgpu_device_init+0x14e5/0x2520 [amdgpu]
>   amdgpu_driver_load_kms+0x15/0x190 [amdgpu]
>   amdgpu_pci_probe+0x140/0x420 [amdgpu]
>   local_pci_probe+0x41/0x90
>   pci_device_probe+0xc3/0x230
>   really_probe+0x1b6/0x410
>   __driver_probe_device+0x78/0x170
>   driver_probe_device+0x1f/0x90
>   __driver_attach+0xd2/0x1c0
>   ? __pfx___driver_attach+0x10/0x10
>   bus_for_each_dev+0x8a/0xd0
>   bus_add_driver+0x141/0x230
>   driver_register+0x77/0x120
>   ? __pfx_init_module+0x10/0x10 [amdgpu]
>   do_one_initcall+0x6e/0x350
>   do_init_module+0x4a/0x220
>   __do_sys_init_module+0x192/0x1c0
>   do_syscall_64+0x5b/0x80
>   ? asm_exc_page_fault+0x22/0x30
>   ? lockdep_hardirqs_on+0x7d/0x100
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> RIP: 0033:0x7fd58cfcb1be
> Code: 48 8b 0d 4d 0c 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f
> 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 8b 0d 1a 0c 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd1d1065d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
> RAX: ffffffffffffffda RBX: 000055b0b5aa6d70 RCX: 00007fd58cfcb1be
> RDX: 000055b0b5a96670 RSI: 00000000016b6156 RDI: 00007fd589392010
> RBP: 00007ffd1d106690 R08: 000055b0b5a93bd0 R09: 00000000016b6ff0
> R10: 000055b5eea2c333 R11: 0000000000000246 R12: 000055b0b5a96670
> R13: 0000000000020000 R14: 000055b0b5a9c170 R15: 000055b0b5aa58a0
>   </TASK>
> Modules linked in: amdgpu(+) drm_ttm_helper hid_asus ttm asus_wmi
> iommu_v2 crct10dif_pclmul ledtrig_audio drm_buddy crc32_pclmul
> sparse_keymap gpu_sched crc32c_intel polyval_clmulni platform_profile
> hid_multitouch polyval_generic drm_display_helper nvme rfkill
> ucsi_acpi ghash_clmulni_intel nvme_core typec_ucsi serio_raw
> sp5100_tco ccp sha512_ssse3 r8169 cec typec nvme_common i2c_hid_acpi
> video i2c_hid wmi ip6_tables ip_tables fuse
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__list_add_valid+0x74/0x90
> Code: 8d ff 0f 0b 48 89 c1 48 c7 c7 a0 3d b3 99 e8 a3 ed 8d ff 0f 0b
> 48 89 d1 48 89 c6 4c 89 c2 48 c7 c7 f8 3d b3 99 e8 8c ed 8d ff <0f> 0b
> 48 89 f2 48 89 c1 48 89 fe 48 c7 c7 50 3e b3 99 e8 75 ed 8d
> RSP: 0018:ffffa50f81aafa00 EFLAGS: 00010246
> RAX: 0000000000000075 RBX: ffff8c9b734062b0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000027 RDI: 00000000ffffffff
> RBP: ffff8c9b734062b0 R08: 0000000000000000 R09: ffffa50f81aaf8a0
> R10: 0000000000000003 R11: ffff8caa1d2fffe8 R12: ffff8c9b7c0a5e48
> R13: 0000000000000000 R14: ffffffffc13a6d20 R15: 0000000000000000
> FS:  00007fd58c6a5940(0000) GS:ffff8ca9d9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055b0b5a955e0 CR3: 000000017e860000 CR4: 0000000000750ee0
> PKRU: 55555554
> (udev-worker) (470) used greatest stack depth: 12416 bytes left
>
> I thought that gracefully means switching to svga mode and showing the
> desktop with software rendering (exactly as it happens when I
> blacklist amdgpu driver). Currently the boot process stucking and the
> local console is unavailable.
>
>

