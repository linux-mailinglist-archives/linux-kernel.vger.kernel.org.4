Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13C76082F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiJVAmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJVAmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:42:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E14A2A712
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666399367;
        bh=LRbt+c/FSxvONvU9DwCGOsVkT94Srir11plmrLILQTM=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=Q86R/6OA/ZOEb60ZCoLc8lNRlZgL+VobkKoctjbsXy+STDZqORZN8N7urW2frJCuS
         Kvk8NhOQAsSZaF0qwA59fO4zeYjGgfjLjm5/zx4khceEFqMutwZ626R/v3N4B9WKdO
         j0XLg44ESuBIlMidEb4ofQ1rMJ5wO0+0sbQJvihE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MeU4y-1pMTHG3nWO-00aUKo for
 <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 02:42:47 +0200
Message-ID: <ad74a60a-5c5a-fd48-5177-c6fd11d95e85@gmx.com>
Date:   Sat, 22 Oct 2022 08:42:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: High-resolution timer warning
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XyCIpQAgIca2ONev1JSQDXk2GoysN1dX2IsT0qnnXIJn2K6F31i
 4pdWpV60RSxt6guuNHGSR44xEWXgN0TUPteuNmADeICa4A38jBUsi7ydBzYbQ4Ixp7NYsl1
 sx4l9QF2vcLyqn0bv+POB59GOu1ItHs4+VaKSPZIDuF2uLfy0WLOoDKPbxeTgsz8v/xZd3r
 Cfi0rtwjsxWXsJdWaaFgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n1VAMQdOuQ0=:cLiX/bKygvUJGGfxkIoZwS
 HAH1TfmINNaacqMLw7DcBIGSBQfif75DLqvgDANM7I7J/nv1/AfPsCEAePU1SKA98xwJmjZkW
 C43wkFfqtY/8HfiwvlBwOdmJk66737zfN+lfQ1+m1skfwiY3JcuqJsljw+h88KqFbfnIZRC97
 ++dzumYhaPQhOWrOpKR/jWO9fWYD/nXLOMAPuENBituLkgjLs9A3OU3HXm85jJaD8oTYxxsbZ
 kzygs20HQ/HVoySLaO7CIbCczJTCn1cvM/i12uIHWlKcDUaF5xdQLQbe97kIR/u+E3Y7vbmW7
 T2olB2BeobDD0Mllo7qqv/JZqNzUBjqmXYWc58is5vZ2JLv5fxINQL3GZpWGcPEuLOxq9U4G5
 HbxCWmwSgM95YVOA2DCw8o25R/KRJyfwxzfD6qdFwfg/EpEB9OnzFAWEfTFPonDTBxzvNx3ZG
 2JH1bR/r62BcSly0hEh4UAeiCGeEpZ77yR/AMov4X0uAje0KVZgMAYmv2/kNpMP2mwm4MxVuN
 FQ8FScXC7dnq84wjyV1P+3RGY6qH88ES9Yh2Gg/U7FNn5vCpcuvRrcitABOSiwP6+GfLeLXaj
 Fxb3agnofcqn+jd5732+x83YjqzqFMuabLh5WA1dtbIwj2gNY+jG+p6NAoDr65rjvytQ7y18T
 wx2wBuMAGdWKK9jcHawubRpmw9pRbZL7xJYTBMf1Twi9WP369hdZWHYxSbGmf4wxeneSrWrU1
 DXv/y8euQ5UXZQbTSZ7Fxcrm7bfcOwnYPAXR82hsmJLjHCl5YzyOcx6Ky+RtdypJZYuWyf5FY
 YI6zQChRWnQwlBoyDmDahzBlodz9LKTXyi/+pNDAEuWn3O9/9w6ATYkkZ15Y5wjtAxu+6+T3c
 px85hynsyg/78gVYtgFt9/AxXmEdZ07x6Q0Vr3h7z7Ui/7N2L5lFmRBp3dkZUZ62rUaEMgzKU
 e0rbOXBGbL3tavIH4S46KKTj9/joZPQa3g6tNSy4yAMM09OKK1Uuo/of796bRQ+7TIfz89Lkg
 GV9JsMbGWCRTgMGaq3zT4kmTCSnQAySOgOPdbXb+o0HONwMUKvgtLgVZpsiFq3UUMz3TEQ8JP
 NwBT3fBfj2qX1dRfu/gq8dy9grx3yRhvuPhHd6GCeLYnqOfVqiUMB53EFqAw8+loYCbr3TCnn
 SvVT8S4H9nE/nozsCcMXSlgC7JAUJgSlHCuKfkqOU4vHC1pDdmaeYXWRJEGWVML0V4KnPgD/v
 dPWC9J9b0Fgv03UoJ6MtJ6CjE/AJNbhP8fw2C/K63hoX5N3Q3I8NyZREevAApznm2rF34WClC
 fhqwe1c6b77wfrsg9l2je0qlKzLFCZbo4pXwPzxHB5qX/S6bDoViNwDw+FQ29FeIUJDkWcaaY
 G4lm+kb9N5zijJ2cTgezEBtjdfU/XvoRtNoLpdG++R8ch91b37gS151JDhrqSl5dLmQACo2r/
 qMe3iKAA9uso0an/E2zUpKBEiKFHFSSGO/Wkrw4sb77Wl9xxJzM6BFNaLFSDqAylyBzngE1Hj
 TxylZsVCntfwM+zsH8opoA8ilLiQ+e7csR42VZdoT9Mbs
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got a hrtimer warning here:

[ 3782.069752] ------------[ cut here ]------------
[ 3782.069760] WARNING: CPU: 0 PID: 0 at kernel/time/hrtimer.c:1713
__hrtimer_run_queues+0x16d/0x2c0
[ 3782.069767] Modules linked in: netconsole rpcsec_gss_krb5 auth_rpcgss
[... skip modules ...]
[ 3782.069875]  pcc_cpufreq():1 [last unloaded: netconsole]
[ 3782.069882] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.0.2-arch1-1
#1 50c0f0880a1bf780734fcafd72b58c22e0d25b99
[ 3782.069887] Hardware name: Micro-Star International Co., Ltd.
MS-7A40/B450I GAMING PLUS AC (MS-7A40), BIOS A.G0 07/25/2022
[ 3782.069889] RIP: 0010:__hrtimer_run_queues+0x16d/0x2c0
[ 3782.069893] Code: 47 38 01 0f 85 46 ff ff ff 31 d2 4c 89 f6 4c 89 ff
e8 f7 fa ff ff 41 83 46 10 01 41 83 46 10 01 4c 39 7b 58 0f 84 39 ff ff
ff <0f> 0b e9 32 ff ff ff 65 8b 05 2d 73 ec 4a 89 c0 48 0f a3 05 2b b5
[ 3782.069897] RSP: 0018:ffffa9e640003f28 EFLAGS: 00010007
[ 3782.069900] RAX: 0000000000000001 RBX: ffff9c819ea24280 RCX:
ffffffffb74ae1c8
[ 3782.069902] RDX: ffffa9e64545bd19 RSI: ffff9c819ea242e0 RDI:
ffff9c819ea24800
[ 3782.069905] RBP: 0000000000000001 R08: 000003707b03c7ae R09:
7fffffffffffffff
[ 3782.070017] R10: 000003707ad0ead9 R11: 000000000000050a R12:
ffff9c819ea24280
[ 3782.070019] R13: 0000000000000006 R14: ffff9c819ea242c0 R15:
ffff9c819ea24800
[ 3782.070021] FS:  0000000000000000(0000) GS:ffff9c819ea00000(0000)
knlGS:0000000000000000
[ 3782.070024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3782.070026] CR2: 00007fde07380000 CR3: 00000001503ca000 CR4:
0000000000750ef0
[ 3782.070028] PKRU: 55555554
[ 3782.070030] Call Trace:
[ 3782.070033]  <IRQ>
[ 3782.070092]  hrtimer_interrupt+0xf8/0x210
[ 3782.070095]  __sysvec_apic_timer_interrupt+0x61/0x110
[ 3782.070099]  sysvec_apic_timer_interrupt+0x6d/0x90
[ 3782.070104]  </IRQ>
[ 3782.070106]  <TASK>
[ 3782.070108]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[ 3782.070111] RIP: 0010:cpuidle_enter_state+0xe2/0x420
[ 3782.070170] Code: 00 00 31 ff e8 6f 0c 7d ff 45 84 ff 74 16 9c 58 0f
1f 40 00 f6 c4 02 0f 85 25 03 00 00 31 ff e8 14 cb 83 ff fb 0f 1f 44 00
00 <45> 85 f6 0f 88 85 01 00 00 49 63 d6 48 8d 04 52 48 8d 04 82 49 8d
[ 3782.070172] RSP: 0018:ffffffffb6c03e40 EFLAGS: 00000246
[ 3782.070175] RAX: ffff9c819ea32d40 RBX: ffff9c7a82273400 RCX:
0000000000000000
[ 3782.070177] RDX: 0000000000000000 RSI: fffffffcf1e429ac RDI:
0000000000000000
[ 3782.070179] RBP: 0000000000000001 R08: 0000000000000002 R09:
00000000229837f7
[ 3782.070181] R10: 00000000000000bf R11: 0000000000000007 R12:
ffffffffb6d4b940
[ 3782.070183] R13: 0000037094ec80f3 R14: 0000000000000001 R15:
0000000000000000
[ 3782.070186]  cpuidle_enter+0x2d/0x40
[ 3782.070189]  do_idle+0x1ed/0x270
[ 3782.070193]  cpu_startup_entry+0x1d/0x20
[ 3782.070195]  rest_init+0xc8/0xd0
[ 3782.070252]  arch_call_rest_init+0xe/0x1c
[ 3782.070257]  start_kernel+0x97a/0x9a3
[ 3782.070260]  secondary_startup_64_no_verify+0xe5/0xeb
[ 3782.070264]  </TASK>
[ 3782.070266] ---[ end trace 0000000000000000 ]---

 From the timestamp, no other related messages around that warning.

The CPU is Ryzen 5900X, no OC or whatever, with 16Gx2 DDR4 3200 RAM.

Recently I'm experiencing a lot of random crash, system hangs, user
space app (mostly proton/wine games) crashs, and have already set up
netconsole to catch the dying message, but to my surprise, no more crash
yet but the above warning caught my eyes.

Is this a known problem related to the specific CPU?
And would it be related to the frequent crash I experienced recently?

Thanks,
Qu
