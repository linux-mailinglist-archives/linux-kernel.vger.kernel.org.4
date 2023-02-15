Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C2697592
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBOExG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 23:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBOExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:53:01 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2DDA2ED57
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 20:52:57 -0800 (PST)
Received: from loongson.cn (unknown [192.168.200.1])
        by gateway (Coremail) with SMTP id _____8DxF9kmZexj9M0AAA--.1996S3;
        Wed, 15 Feb 2023 12:52:54 +0800 (CST)
Received: from [0.0.0.0] (unknown [192.168.200.1])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axfb4kZexj1pozAA--.35077S3;
        Wed, 15 Feb 2023 12:52:54 +0800 (CST)
Subject: Re: "kernel ade access" oops on LoongArch
To:     Xi Ruoyao <xry111@xry111.site>
References: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
Cc:     loongarch@lists.linux.dev, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <2e902dfa-cb84-7ef0-6b50-02b16354a139@loongson.cn>
Date:   Wed, 15 Feb 2023 12:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1e6f4d35946e4e2e7c7f5dcc7b69d5e609de8184.camel@xry111.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axfb4kZexj1pozAA--.35077S3
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GFy8XF15Wry3uFy7JF1fWFg_yoW3Ww45pF
        yUXr4rGr48Jr1Yyr4UA3WUAr4UtanrZF47Jr15Jw1xCryxZr1DJr17JFW7ury3Jw15J3W7
        JryUKr1rKF4DG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bOxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
        CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2
        zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_WwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCF04k20xvE74AGY7Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
        JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWl
        kUUUUU=
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,LOTS_OF_MONEY,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao

On 02/14/2023 04:46 PM, Xi Ruoyao wrote:
> This is a "help wanted" message :(.
>
> I've recently run into some strange kernel oops testing Glibc for LoongArch.  A log looks like:
>
> [11569.195043] Kernel ade access[#1]:
> [11569.198441] CPU: 1 PID: 1132296 Comm: ld-linux-loonga Not tainted 6.2.0-rc8+ #61
> [11569.205792] Hardware name: Loongson Loongson-3A5000-HV-7A2000-1w-V0.1-EVB/Loongson-LS3A5000-7A2000-1w-EVB-V1.21, BIOS Loongson-UDK2018-V4.0.05383-beta10 1
> [11569.219536] $ 0   : 0000000000000000 90000000005e3448 90000001113a0000 90000001113a3ab0
> [11569.227505] $ 4   : 90000001113a3af8 1000000000cf16d0 5555555555555850 000000000000000c
> [11569.235475] $ 8   : 90000000009caa10 0000000000000000 00000000000002ca 000000000000008b
> [11569.243438] $12   : 0000000000000001 9000000000cf1258 ffffffffffffffff 00007ffffb93c000
> [11569.251402] $16   : 0000000000000000 0000000000000140 0000000000000000 0000000000000020
> [11569.259366] $20   : 90000001113a3ec8 9000000000a97ee0 00007ffffb93bfa0 1555555555555613
> [11569.267334] $24   : 1000000000cf16d0 000000000000000c 9000000000cf1258 90000000009caa10
> [11569.275303] $28   : 90000001113a3af8 0aaaaaaaaaaaab0a 00007ffffb93bde0 90000001113a3ec0
> [11569.283268] era   : 90000000009caa10 cmp_ex_search+0x0/0x28
> [11569.288814] ra    : 90000000005e3448 bsearch+0x58/0xa8
> [11569.293921] CSR crmd: 000000b0	
> [11569.293923] CSR prmd: 00000004	
> [11569.297037] CSR euen: 00000000	
> [11569.300152] CSR ecfg: 00071c1c	
> [11569.303266] CSR estat: 00480000	
> [11569.309587] ExcCode : 8 (SubCode 1)
> [11569.313049] BadVA : 1000000000cf16d0
> [11569.316596] PrId  : 0014c011 (Loongson-64bit)
> [11569.320923] Modules linked in: amdgpu nls_cp936 vfat fat input_leds drm_ttm_helper ttm video gpu_sched drm_buddy snd_hda_codec_generic drm_display_helper ledtrig_audio drm_kms_helper led_class snd_hda_intel sha256_generic snd_intel_dspcfg cfbfillrect libsha256 snd_hda_codec syscopyarea snd_hda_core hid_generic cfbimgblt cfg80211 snd_pcm sysfillrect usbhid sysimgblt snd_timer cfbcopyarea hid snd igb soundcore efivarfs
> [11569.357709] Process ld-linux-loonga (pid: 1132296, threadinfo=000000003cbd0caa, task=000000005bcd27a6)
> [11569.366977] Stack : 00007ffffb93bd60 0000000000000000 9000000180a36a40 0000000000000001
> [11569.374940]         90000001113a3bb0 00007ffffb93c000 9000000000224c94 90000000009cab2c
> [11569.382899]         0000000000000001 9000000000224c94 00007ffff3258000 900000000025a1b4
> [11569.390866]         90000001113a3bb0 900000000022f4cc 00007ffffb93c000 900000000022f74c
> [11569.398834]         9000000180a36a40 0000000000000001 0000000000000000 00007ffffb93c000
> [11569.406800]         90000001113a3bb0 900000000022f8f8 90000001113a3ec0 00007ffffb93bde0
> [11569.414768]         00007ffffb93bd60 0000000000000000 0000000000000000 00007fffff7c4600
> [11569.422734]         9000000182ebab70 9000000000d08000 0000000046505501 900000000022ee6c
> [11569.430698]         0000000000000000 9000000000224b84 90000001113a0000 90000001113a3cf0
> [11569.438661]         0000000000000000 00007ffffb93c0d0 0000000000000000 0000000000000040
> [11569.446627]         ...
> [11569.449058] Call Trace:
> [11569.449062] [<90000000009caa10>] cmp_ex_search+0x0/0x28
> [11569.456681] [<90000000005e3448>] bsearch+0x58/0xa8
> [11569.461443] [<90000000009cab2c>] search_extable+0x28/0x34
> [11569.466807] [<900000000025a1b4>] search_exception_tables+0x48/0x7c
> [11569.472953] [<900000000022f4cc>] fixup_exception+0x18/0xcc
> [11569.478410] [<900000000022f74c>] do_sigsegv+0x174/0x1b0
> [11569.483605] [<900000000022f8f8>] do_page_fault+0x170/0x344
> [11569.489058] [<900000000022ee6c>] tlb_do_page_fault_1+0x128/0x1c4
> [11569.495029] [<9000000000224b84>] handle_signal+0x634/0x884
> [11569.500487] [<9000000000225704>] arch_do_signal_or_restart+0xb4/0xe0
> [11569.506808] [<90000000002b5b30>] exit_to_user_mode_prepare+0xbc/0x100
> [11569.513214] [<9000000000a02628>] syscall_exit_to_user_mode+0x30/0x4c
> [11569.519533] [<90000000002214a4>] handle_syscall+0xc4/0x160
>
> [11569.526472] Code: 4c000020  02800404  4c000020 <240000ac> 26000084  0010b0a5  680014a4  00129484  00111004
>
> [11569.537704] ---[ end trace 0000000000000000 ]---
>
> "BadVA : 1000000000cf16d0" may suggest the highest bit of an address is
> somehow cleared.
>
> The issue is not deterministic, but it seems easily reproduced by:
>
> 1. Compile Glibc:
>
> ../glibc/configure --prefix=/usr                      \
>              --disable-werror                         \
>              --enable-kernel=5.19                     \
>              --enable-stack-protector=strong          \
>              --with-headers=/usr/include              \
>              libc_cv_slibdir=/usr/lib
> make -j4
>
> 2. Check Glibc:
>
> make check -j4

When I try to build glibc, it fails like below :( .

git clone https://sourceware.org/git/glibc.git
mkdir build_glibc
cd build_glibc
../glibc/configure --prefix=/usr --disable-werror --enable-kernel=5.19 
--enable-stack-protector=strong --with-headers=/usr/include 
libc_cv_slibdir=/usr/lib
make -j4

log:
/home/loongson/build_glibc/csu/crtn.o
In file included from ../include/stdlib.h:15,
                  from /home/loongson/build_glibc/cstdlib:79,
                  from /usr/include/c++/13.0.0/ext/string_conversions.h:41,
                  from /usr/include/c++/13.0.0/bits/basic_string.h:4040,
                  from /usr/include/c++/13.0.0/string:52,
                  from /usr/include/c++/13.0.0/bits/locale_classes.h:40,
                  from /usr/include/c++/13.0.0/bits/ios_base.h:41,
                  from /usr/include/c++/13.0.0/ios:42:
../stdlib/stdlib.h:141:8: error: ‘_Float32’ does not name a type
   141 | extern _Float32 strtof32 (const char *__restrict __nptr,
       |        ^~~~~~~~
../stdlib/stdlib.h:147:8: error: ‘_Float64’ does not name a type
   147 | extern _Float64 strtof64 (const char *__restrict __nptr,
       |        ^~~~~~~~
...
/usr/bin/ld: /home/loongson/build_glibc/libc.a(dl-reloc-static-pie.o): 
in function `_dl_relocate_static_pie':
/home/loongson/glibc/elf/dl-reloc-static-pie.c:44: undefined reference 
to `_DYNAMIC'
/usr/bin/ld: /home/loongson/glibc/elf/dl-reloc-static-pie.c:44: 
undefined reference to `_DYNAMIC'
/usr/bin/ld: /home/loongson/build_glibc/support/test-run-command: hidden 
symbol `_DYNAMIC' isn't defined
/usr/bin/ld: final link failed: bad value

Youling.
>
> 3. If the oops did not happen during the last step, run a specific test
> in a dead loop:
>
> while true; do make test t=malloc/tst-mallocfork3-malloc-check; done
>
> Then an oops would likely show up in several minutes.
>
> Though the oops is nondeterministic, I'm almost sure it's not a hardware
> stability issue because I'm getting exactly same stack traces for each
> oops message.  I cannot easily rule out the possibility about "the
> compiler miscompiles kernel code" though.
>
> I'm running 6.2-rc8 with the following patches from loongarch-next:
>
> ACPI: Define ACPI_MACHINE_WIDTH to 64 for LoongArch
> PCI: loongson: Improve the MRRS quirk for LS7A
> PCI: Add quirk for LS7A to avoid reboot failure
> irqchip/loongson-liointc: Save/restore int_edge/int_pol registers during S3/S4
> LoongArch: Add vector extensions support
> tools: Add LoongArch build infrastructure
> libbpf: Add LoongArch support to bpf_tracing.h
> selftests/seccomp: Add LoongArch selftesting support
> SH: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
> LoongArch: Add CPU HWMon platform driver
>
> Any idea to fix the issue or suggestion to debug it further?
>

