Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA25ED1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiI1AV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI1AVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:21:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C95D10E5E8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 17:21:26 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnmtpkzNj0_8iAA--.50977S3;
        Wed, 28 Sep 2022 08:20:57 +0800 (CST)
Subject: Re: [PATCH V2] irqchip: Make irqchip_init() usable on pure ACPI
 systems
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20220927124557.3246737-1-chenhuacai@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <01b9d198-929a-45ea-2e94-3d0956aee2b7@loongson.cn>
Date:   Wed, 28 Sep 2022 08:20:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20220927124557.3246737-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxnmtpkzNj0_8iAA--.50977S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xtr18ZFyDJry5tFyrWFg_yoW8Kw17pF
        yUXr10gr48Jr1UJr1UAF17Jr1DJw4DCF18Jr17Jr17Jw1UXr1DAr1UJr4UGFy5Aw45Jr1U
        Jr48tr1Dtr15Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6w1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
        87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
        ZFpf9x0JUTxRDUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/27/2022 08:45 PM, Huacai Chen wrote:
> Pure ACPI system (e.g., LoongArch) doesn't select OF and OF_IRQ, but it
> still need a non-empty irqchip_init(). So, change the IRQCHIP dependency
> from OF_IRQ to (OF_IRQ || ACPI_GENERIC_GSI), and then define an empty
> inline of_irq_init() in the !CONFIG_OF_IRQ case, so as to make the non-
> empty irqchip_init() be usable on pure ACPI systems.
>
> Without this patch we get such errors:
>
> [    0.000000] NR_IRQS: 576, nr_irqs: 576, preallocated irqs: 16
> [    0.000000] Kernel panic - not syncing: IPI IRQ mapping failed
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.0-rc6+ #2189
> [    0.000000] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.pre-beta8 08/18/2022
> [    0.000000] Stack : 0000000000000000 9000000000fa4388 900000000140c000 900000000140fb70
> [    0.000000]         0000000000000000 900000000140fb70 90000000012f4aa0 900000000140fa98
> [    0.000000]         900000000140fa0c 900000008140f9ff 0000000000000030 0000000000000005
> [    0.000000]         900000000578f708 0000000004750000 0000000000000000 00000000ffffdfff
> [    0.000000]         0000000000000000 0000000000000000 0000000000000030 000000000000002f
> [    0.000000]         900000000141f000 0000000004750000 9000000001427348 00000000000000b0
> [    0.000000]         90000000012f4aa0 0000000000000004 0000000000000000 9000000001020000
> [    0.000000]         9000000005781b80 9000000005781ba9 0000000000000000 9000000001315e30
> [    0.000000]         900000000129a3b0 9000000000222b64 0000000000000000 00000000000000b0
> [    0.000000]         0000000000000004 0000000000000000 0000000000070000 0000000000000800
> [    0.000000]         ...
> [    0.000000] Call Trace:
> [    0.000000] [<9000000000222b64>] show_stack+0x24/0x124
> [    0.000000] [<9000000000fa4388>] dump_stack_lvl+0x60/0x88
> [    0.000000] [<9000000000f9965c>] panic+0x130/0x2f8
> [    0.000000] [<9000000000fd4324>] init_IRQ+0xa8/0x240
> [    0.000000] [<9000000000fd0b38>] start_kernel+0x488/0x5f0
> [    0.000000] [<9000000000fb10c4>] kernel_entry+0xc4/0xc8
> [    0.000000]
> [    0.000000] ---[ end Kernel panic - not syncing: IPI IRQ mapping failed ]---
>

I am also experiencing the same problem with the latest kernel
on LoongArch, it works well with this patch.

Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>

