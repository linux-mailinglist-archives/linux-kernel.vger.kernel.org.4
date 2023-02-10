Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC5691E98
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjBJLtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjBJLts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:49:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC90E1E9EC;
        Fri, 10 Feb 2023 03:49:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d8so4978941plr.10;
        Fri, 10 Feb 2023 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyZFUYRf8Y9uN14bVX242tJ4IyOegUrrPo0proWXkGw=;
        b=Z/p+8rNhaiu6pKZs//lCAYNeOnGDrNBA+rKp82ku0eQUhNl8rwWXZ5Sm7G4/L2QD9e
         fDmhgcdTGqE8DzfiScdMi9M8k4LpCBtCJfNHhk9GiQrZMAeRj/vNt8Cf9dJxVsj81TjH
         3wPSqVA0cPlgnqz0XxcQVbW8hpojlOkpdl2xnp9YXmGxWGv2MgnjpG5vCP2W8qGNpbI4
         /qyj/zTJBgtKY2SneGrqveclgnsvehV/ybDage2niS9QZuY0EUwLjbPmqPXNMfmFaG2E
         SfnLxoDLSQrj9aQnRpwBztrXq70xg4nX0MDF98I1EbKrLSNeTt0HXw/AW8/W1cZZYM9j
         UWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyZFUYRf8Y9uN14bVX242tJ4IyOegUrrPo0proWXkGw=;
        b=yeYtpyu0d0xSp2UzHfY4fY6BNhcQX1Mll6TxykyqjCnq5qjNmY6lNKgo2vlviAA4VK
         B4IxGMXUUXIlPXcS9DJfdrIenwnGOY/0qulNHm6mGQ358RyGQtHtD56wVVmZt0DatWZM
         5B37MW5dFiX+qE5oPqms1BPqaefDEDwRXZ4dqpur5D8yUFvGB143jqmKkyLuQggGU25S
         nkHnpydkTT/mZpzfmzeduKeHHkSyYdSb+Bmt3qHcXiFqRCch6D9G5hzV3arkyTflYoBV
         bsv0zs0rIV77g4dx4w/waiq8P3madlSQXz6KuLQn5u/SXpC1Cp/uxrdv4yiPgfbAShGC
         j1Mw==
X-Gm-Message-State: AO0yUKVTxVw4TrOjcHLhqcJPs6kamwbaAnO0zhyjGFqpCDppZxdFmM8b
        DuWMI6b7C221oxLIBlsz+d+9bbj1f1eTmw==
X-Google-Smtp-Source: AK7set9e2VqZSQse3l0gzM+Z3m6LAWw3pOHyfo2AynpZ6+qiodv2Aiedjdu6QTkMEzmNi3win3Y1mg==
X-Received: by 2002:a17:902:ec82:b0:196:56ae:ed1d with SMTP id x2-20020a170902ec8200b0019656aeed1dmr14738303plg.69.1676029786071;
        Fri, 10 Feb 2023 03:49:46 -0800 (PST)
Received: from [192.168.0.4] ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902dc8300b00198fe021f93sm1969765pld.77.2023.02.10.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:49:45 -0800 (PST)
Message-ID: <92176daf-671c-f136-5400-94c7711cc8c8@gmail.com>
Date:   Fri, 10 Feb 2023 20:49:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Segmentation fault + invalid opcode: 0000 [#1] SMP NOPTI at using
 ARIA cipher (kernel 6.2.0-rc7)
Content-Language: en-US
To:     "Erhard F." <erhard_f@mailbox.org>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, davem@davemloft.net
References: <20230210012623.535450d0@yea>
From:   Taehee Yoo <ap420073@gmail.com>
In-Reply-To: <20230210012623.535450d0@yea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/23 09:26, Erhard F. wrote:
 > Hello!

I Erhard.
Thank you so much for the report!

Herber sent the same report a few days ago.
So, I'm writing a patch for it and send it soon.
I will really appreciate it if you could test that patch.

 >
 > I wanted to give the new ARIA cipher a try on my AMD FX-8370 but got 
a segmentation fault as a result:
 >
 >   # cryptsetup benchmark -c aria-ctr-plain64
 > # Tests are approximate using memory only (no storage IO).
 > Segmentation fault
 >
 > Kernel 6.2.0-rc7 showed the use of an invalid opcode for this command:
 >
 > [...]
 > invalid opcode: 0000 [#1] SMP NOPTI
 > CPU: 4 PID: 5388 Comm: cryptsetup Tainted: G                T 
6.2.0-rc7-bdver2 #2
 > Hardware name: Gigabyte Technology Co., Ltd. To be filled by 
O.E.M./970-GAMING, BIOS F2 04/06/2016
 > RIP: 0010:__aria_aesni_avx_crypt_16way+0x225/0x6000 
[aria_aesni_avx_x86_64]
 > Code: c4 41 7a 7f 48 10 c4 41 7a 7f 50 20 c4 41 7a 7f 58 30 c4 41 7a 
7f 60 40 c4 41 7a 7f 68 50 c4 41 7a 7f 70 60 c4 41 7a 7f 78 70 <c4> c2 
79 78 41 0b c5 39 ef c0 c4 c2 79 78 41 0a c5 31 ef c8 c4 c2
 > RSP: 0018:ffffaf3f0df93b60 EFLAGS: 00010286
 > RAX: ffffaf3f0df93c38 RBX: ffffaf3f0df93c38 RCX: ffffaf3f0df93c38
 > RDX: ffffaf3f0df93c38 RSI: ffffaf3f0df93c38 RDI: ffff9a17a9e74c20
 > RBP: ffffaf3f0df93d70 R08: ffffaf3f0df93cb8 R09: ffff9a17a9e74c20
 > R10: ffff9a1776d51000 R11: ffff9a17c1286000 R12: fefefefefefefefe
 > R13: ffff9a17c1286000 R14: ffff9a1776d51100 R15: ffff9a1776d52000
 > FS:  00007f0a907020e0(0000) GS:ffff9a1a5ed00000(0000) 
knlGS:0000000000000000
 > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > CR2: 00007f0a9010e000 CR3: 0000000123e6c000 CR4: 00000000000406e0
 > Call Trace:
 >   <TASK>
 >   aria_aesni_avx_ctr_crypt_16way+0x19/0x110 [aria_aesni_avx_x86_64]
 >   aria_avx_ctr_encrypt+0x12e/0x2f3 [aria_aesni_avx_x86_64]
 >   skcipher_recvmsg+0x30c/0x3e0 [algif_skcipher]
 >   sock_read_iter+0x107/0x110
 >   vfs_read+0x2d6/0x300
 >   ksys_read+0xa1/0xe0
 >   do_syscall_64+0x5b/0x80
 >   ? do_syscall_64+0x67/0x80
 >   entry_SYSCALL_64_after_hwframe+0x4b/0xb5
 > RIP: 0033:0x7f0a90780230
 > Code: c3 8b 07 85 c0 75 24 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 
c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> e9 
ea 1f ff ff 48 31 ed 48 89 e7 48 8d 35 dd 7b 03 00 48 83 e4
 > RSP: 002b:00007ffccd0ae718 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
 > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0a90780230
 > RDX: 0000000000010000 RSI: 00007f0a900ff000 RDI: 0000000000000006
 > RBP: 00007f0a907020e0 R08: 0000000000000000 R09: 0000000000000000
 > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000010000
 > R13: 0000000000010000 R14: 00007f0a900ff000 R15: 00007ffccd0ae878
 >   </TASK>
 > Modules linked in: aria_aesni_avx_x86_64 aria_generic ctr snd_hrtimer 
snd_seq snd_seq_device fuse zram zsmalloc nfsd auth_rpcgss lockd grace 
sunrpc cfg80211 ccm algif_aead cbc des_generic libdes ecb cmac 
sha1_ssse3 sha1_generic md5 md4 bnep bluetooth jitterentropy_rng drbg 
ansi_cprng ecdh_generic ecc rfkill dm_crypt nhpoly1305_sse2 nhpoly1305 
chacha_generic chacha_x86_64 libchacha adiantum libpoly1305 
algif_skcipher joydev input_leds amdgpu mfd_core gpu_sched drm_buddy 
dm_mod hid_generic usbhid hid crc32_pclmul sha512_ssse3 sha512_generic 
snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio led_class 
radeon snd_hda_codec_hdmi pkcs8_key_parser video wmi snd_hda_intel 
i2c_algo_bit snd_intel_dspcfg drm_ttm_helper snd_hda_codec aesni_intel 
ttm it87 snd_hwdep sr_mod libaes ohci_pci hwmon_vid evdev crypto_simd 
cdrom cryptd fam15h_power xhci_pci drm_display_helper ohci_hcd ehci_pci 
snd_hda_core k10temp hwmon xhci_hcd ehci_hcd drm_kms_helper snd_pcm 
syscopyarea 8250 sysfillrect
 >   i2c_piix4 8250_base sysimgblt usbcore snd_timer serial_core 
usb_common drm snd drm_panel_orientation_quirks backlight soundcore 
acpi_cpufreq button processor efivarfs
 > ---[ end trace 0000000000000000 ]---
 > RIP: 0010:__aria_aesni_avx_crypt_16way+0x225/0x6000 
[aria_aesni_avx_x86_64]
 > Code: c4 41 7a 7f 48 10 c4 41 7a 7f 50 20 c4 41 7a 7f 58 30 c4 41 7a 
7f 60 40 c4 41 7a 7f 68 50 c4 41 7a 7f 70 60 c4 41 7a 7f 78 70 <c4> c2 
79 78 41 0b c5 39 ef c0 c4 c2 79 78 41 0a c5 31 ef c8 c4 c2
 > RSP: 0018:ffffaf3f0df93b60 EFLAGS: 00010286
 > RAX: ffffaf3f0df93c38 RBX: ffffaf3f0df93c38 RCX: ffffaf3f0df93c38
 > RDX: ffffaf3f0df93c38 RSI: ffffaf3f0df93c38 RDI: ffff9a17a9e74c20
 > RBP: ffffaf3f0df93d70 R08: ffffaf3f0df93cb8 R09: ffff9a17a9e74c20
 > R10: ffff9a1776d51000 R11: ffff9a17c1286000 R12: fefefefefefefefe
 > R13: ffff9a17c1286000 R14: ffff9a1776d51100 R15: ffff9a1776d52000
 > FS:  00007f0a907020e0(0000) GS:ffff9a1a5ed00000(0000) 
knlGS:0000000000000000
 > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 > CR2: 00007f0a9010e000 CR3: 0000000123e6c000 CR4: 00000000000406e0
 >
 > Some data about the cpu:
 >   # lscpu
 > Architecture:            x86_64
 >    CPU op-mode(s):        32-bit, 64-bit
 >    Address sizes:         48 bits physical, 48 bits virtual
 >    Byte Order:            Little Endian
 > CPU(s):                  8
 >    On-line CPU(s) list:   0-7
 > Vendor ID:               AuthenticAMD
 >    BIOS Vendor ID:        AMD
 >    Model name:            AMD FX-8370 Eight-Core Processor
 >      BIOS Model name:     AMD FX-8370 Eight-Core Processor 
     To Be Filled By O.E.M. CPU @ 4.
 >                           0GHz
 >      BIOS CPU family:     63
 >      CPU family:          21
 >      Model:               2
 >      Thread(s) per core:  2
 >      Core(s) per socket:  4
 >      Socket(s):           1
 >      Stepping:            0
 >      Frequency boost:     enabled
 >      CPU(s) scaling MHz:  60%
 >      CPU max MHz:         4000.0000
 >      CPU min MHz:         1400.0000
 >      BogoMIPS:            8040.11
 >      Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep 
mtrr pge mca cmov pat pse36 clflush
 >                            mmx fxsr sse sse2 ht syscall nx mmxext 
fxsr_opt pdpe1gb rdtscp lm constant_tsc
 >                            rep_good nopl nonstop_tsc cpuid 
extd_apicid aperfmperf pni pclmulqdq monitor s
 >                           sse3 fma cx16 sse4_1 sse4_2 popcnt aes 
xsave avx f16c lahf_lm cmp_legacy svm ex
 >                           tapic cr8_legacy abm sse4a misalignsse 
3dnowprefetch osvw ibs xop skinit wdt fm
 >                           a4 tce nodeid_msr tbm topoext perfctr_core 
perfctr_nb cpb hw_pstate ssbd ibpb v
 >                           mmcall bmi1 arat npt lbrv svm_lock 
nrip_save tsc_scale vmcb_clean flushbyasid d
 >                           ecodeassists pausefilter pfthreshold
 > Virtualization features:
 >    Virtualization:        AMD-V
 > Caches (sum of all):
 >    L1d:                   128 KiB (8 instances)
 >    L1i:                   256 KiB (4 instances)
 >    L2:                    8 MiB (4 instances)
 >    L3:                    8 MiB (1 instance)
 > Vulnerabilities:
 >    Itlb multihit:         Not affected
 >    L1tf:                  Not affected
 >    Mds:                   Not affected
 >    Meltdown:              Not affected
 >    Mmio stale data:       Not affected
 >    Retbleed:              Mitigation; untrained return thunk; SMT 
vulnerable
 >    Spec store bypass:     Mitigation; Speculative Store Bypass 
disabled via prctl
 >    Spectre v1:            Mitigation; usercopy/swapgs barriers and 
__user pointer sanitization
 >    Spectre v2:            Mitigation; Retpolines, IBPB conditional, 
STIBP disabled, RSB filling, PBRSB-eI
 >                           BRS Not affected
 >    Srbds:                 Not affected
 >    Tsx async abort:       Not affected
 >
 >
 > Could it be that this AVX implementation of ARIA requires AVX2 
actually? dmesg + custom kernel .config + aria-aesni-avx-x86_64.ko for 
my FX-8370 attached.
 >
 > Regards,
 > Erhard

Thank you so much,
Taehee Yoo
