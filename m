Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF569F3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBVLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjBVLwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:52:51 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC75269E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:52:50 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id i34so3963719eda.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvzSaAWrnrrS1hPTWp4NSK46Betzu0fGamYg/2tkhxo=;
        b=bgwF9DewAXxDa4KnG2JpCOJkuQIZ9ZM3KrYvZgSXhDGciK96b6CiyxyD8cBGxlY4IB
         ej6Hte53t61xVJDDpvOC0xYBBvuPj6PlUbgBP8FSqk39IM/IzMBjqV8KgpYjKHTlT9hb
         J4oYqYpLl744YjqydvmbAt668oXJI9CJfuE2UFKkX4ghpbVGNr5zG7T64fSxZhMJeXhV
         +h1SMks4Vd4cvdbzrJBfypl0z+m2Hz/pMXTrua1O+Oc6Qx5I44Tq45rqx+nARYvsg48a
         D4LBmW4Ah1kfK+3INJIniGNDw80MMzWd00yHTarEwTcdRARy08WFhXIdZRAjuNR29BUS
         eumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VvzSaAWrnrrS1hPTWp4NSK46Betzu0fGamYg/2tkhxo=;
        b=kUUZUy/OfM6eDXVQQqcHGTj/ItdCtVP22wIXrTNFRRpXJbl0hxZao1QzBLWLwvPrPf
         ni5xkTutixIrqETx1wy5S/yNimzcSivb3qCjblbEOrUlLEvEUQMQdDV6XfmUro8W9LC0
         lBhIOwk/ZplWTMuoIqFbxxFs+b19EploxAKq/Tvklz3HEQxPKHGkKAa7uofLJp7I5ml9
         sMNGSL+NI0EqjKrolIQygOTbKXlc9ZFIPMxT91MRTykrkAZVtFP/1gAQ9HnuFhnj0ysB
         J+xjeqwPKO2exxn7dn3LVXS0Dx3W3VytejtScX3sm4b/yH7xECzLS80SfG+ifOEYcHm0
         Ylig==
X-Gm-Message-State: AO0yUKXqIZgg3MSmlJN0N71RDABE+eEBuPeCsumbN66j6Ijd6G9mu5/j
        0cac3Tux5Y95xAw//s4hdzycMgPumV0=
X-Google-Smtp-Source: AK7set9/eSTnmU5NH4YDoy+WP9BN1K48wHKkAb8ID3wUBmkDyaIw6pyyDlg43vO+QCT1e1G6fP0z7Q==
X-Received: by 2002:a17:906:2c52:b0:872:b17a:9b59 with SMTP id f18-20020a1709062c5200b00872b17a9b59mr15344496ejh.38.1677066768481;
        Wed, 22 Feb 2023 03:52:48 -0800 (PST)
Received: from [192.168.99.2] ([217.30.65.82])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709066c8c00b008d325e167f3sm3790050ejr.201.2023.02.22.03.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 03:52:48 -0800 (PST)
Message-ID: <92809acb-6fb8-2d15-fc8d-433b2751a0c4@gmail.com>
Date:   Wed, 22 Feb 2023 12:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     LKML <linux-kernel@vger.kernel.org>, tony.luck@intel.com
From:   =?UTF-8?Q?Martin_MOKREJ=c5=a0?= <mmokrejs@gmail.com>
Subject: linux-6.1.12: WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:47
 prefill_possible_map+0xff/0x145
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I updated a kernel from 5.15.74 to 6.1.12 on a guest running under KVM. I think enabled to set down the number of CPUs to the amount available during compile time but I just cannot find it in the .config. But now, it issues a warning with a kernel stacktrace.

   Would some friendly soul tell me which option causes that? I have 2 CPU core available inside the rented virtual machine.



[    0.021948] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.021958] TSC deadline timer available
[    0.021974] ------------[ cut here ]------------
[    0.021976] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:47 prefill_possible_map+0xff/0x145
[    0.021988] Modules linked in:
[    0.021992] CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.12 #1 3756ce620d8cac9610c90ecbab5f0cff2a1e72f5
[    0.021997] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc27 04/01/2014
[    0.021999] RIP: 0010:prefill_possible_map+0xff/0x145
[    0.022004] Code: 00 e8 d4 64 22 ff 83 3d df 67 c4 ff 00 75 16 39 dd 7e 12 89 ee 31 d2 48 c7 c7 50 4d f7 81 89 dd e8 b5 64 22 ff 83 fd 40 74 02 <0f> 0b b8 00 00 00 00 89 ea 2b 15 97 53 0f 00 89 ee 0f 48 d0 48 c7
[    0.022006] RSP: 0000:ffffffff82203ec0 EFLAGS: 00010083 ORIG_RAX: 0000000000000000
[    0.022010] RAX: 0000000000000001 RBX: 0000000000000040 RCX: 0000000000000001
[    0.022011] RDX: 0000000000000040 RSI: 0000000000000092 RDI: 0000000000000000
[    0.022013] RBP: 0000000000000001 R08: 80000000ffffe03d R09: 612072656d697420
[    0.022015] R10: 6d697420656e696c R11: 6461656420435354 R12: 0000000000000000
[    0.022017] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.022019] FS:  0000000000000000(0000) GS:ffffffff82695000(0000) knlGS:0000000000000000
[    0.022022] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.022024] CR2: ffff888002a01000 CR3: 000000000220a000 CR4: 00000000000606b0
[    0.022086] Call Trace:
[    0.022088]  <TASK>
[    0.022091]  ? setup_arch+0x850/0x8fc
[    0.022099]  ? start_kernel+0x64/0x662
[    0.022103]  ? secondary_startup_64_no_verify+0xcd/0xdb
[    0.022109]  </TASK>
[    0.022111] ---[ end trace 0000000000000000 ]---
[    0.022114] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.022132] [mem 0x80000000-0xfeffbfff] available for PCI devices
[    0.022136] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.028128] ------------[ cut here ]------------
[    0.028134] WARNING: CPU: 0 PID: 0 at include/linux/cpumask.h:47 setup_nr_cpu_ids+0x15/0x1c
[    0.028148] Modules linked in:
[    0.028152] CPU: 0 PID: 0 Comm: swapper Tainted: G        W          6.1.12 #1 3756ce620d8cac9610c90ecbab5f0cff2a1e72f5
[    0.028156] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc27 04/01/2014
[    0.028159] RIP: 0010:setup_nr_cpu_ids+0x15/0x1c
[    0.028164] Code: 00 00 00 74 05 e8 26 88 24 ff 31 c0 48 83 c4 18 e9 cb a7 52 ff 48 8b 05 0c 8a c8 ff 48 85 c0 74 09 48 0f bd c0 83 f8 3f 74 02 <0f> 0b e9 af a7 52 ff e8 60 c5 ff ff e8 b3 b2 ff ff 48 c7 c7 b8 44
[    0.028166] RSP: 0000:ffffffff82203f08 EFLAGS: 00010093 ORIG_RAX: 0000000000000000
[    0.028216] RAX: 0000000000000000 RBX: ffff88807ffd4940 RCX: 0000000000000000
[    0.028219] RDX: 0000000000000032 RSI: ffffffff827430c0 RDI: ffff88807ffd4900
[    0.028220] RBP: ffffffff827430c0 R08: ffff88807ffd4900 R09: 0000000000000032
[    0.028222] R10: 0000000000000032 R11: 000000007ffd4940 R12: 0000000000000032
[    0.028224] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    0.028226] FS:  0000000000000000(0000) GS:ffffffff82695000(0000) knlGS:0000000000000000
[    0.028228] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.028230] CR2: ffff888002a01000 CR3: 000000000220a000 CR4: 00000000000606b0
[    0.028236] Call Trace:
[    0.028240]  <TASK>
[    0.028241]  start_kernel+0x1e3/0x662
[    0.028249]  secondary_startup_64_no_verify+0xcd/0xdb
[    0.028256]  </TASK>
[    0.028257] ---[ end trace 0000000000000000 ]---
[    0.028260] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:64 nr_node_ids:1
[    0.030597] percpu: Embedded 44 pages/cpu s140904 r8192 d31128 u2097152
[    0.030612] pcpu-alloc: s140904 r8192 d31128 u2097152 alloc=1*2097152
[    0.030617] pcpu-alloc: [0] 0

I can provide the .config off the list.

Thank you,
Martin
