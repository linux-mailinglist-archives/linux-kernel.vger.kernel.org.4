Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B44649A34
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiLLImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLLIlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:41:51 -0500
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2154.outbound.protection.outlook.com [40.92.63.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2336DFC6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:41:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U51/LL8Ea4ExdlHaV1XDe/xaW6G9TkQbMp7eiCtGKR4VNfpm3N0Xhjj5gzYS88TthcnVucjMWCEK5f8hOfyO1Ew80PwU7qIIc6VRJ0FSpfsNWjz/THKygr8ZHpziVP59IAQ+1jwUr82aKCcNd59/qFuN3cyX4frHHFkmpiSApxMDd4NwUP9Cu1j5mtbAyU3yX4cqt1ARCMgR+vnmBsmiPFa1twAy61Gfjpk/5gWKbRspPCB8xUN2SNYilGiyMo18WpwsI2K1e3tLCx+YKJc044QqikbDA4mkf20DvQU2MQN3oSNHsdSo7kSnghY7jCtmSJm4lZmInQujIpH6M4TLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+XO3Pl1p56KDk7rSelI+rKVEMnnz3nBlPgg2gGb/y0=;
 b=ZJcyX/BOcHxVLXh2mw5PDvjhSSQG+nEgLwUNofVE4BYORpXK0Oa6/EjvIh0Rmb/WuzyEhNTxmN/fsD/VpIATNlxybrXKV1zEcPrglY0QOzTKTbPkbpvQuIvhjlWv6CxOhXoVOpFPomyCKId4eRGgpW8i2xY48nCEIPfz8kbcINr1zv0/fZEE0klDI/sLYA3FYe1u0MvUmraCq+TQ0yz0DwJQNYdus0POu4XDWXzaHwgL8u13k9xy+vZoTD2YbWbv+icRqFYeXBViDVfUTn3Ml2f1Gb1ZpJ1IiafXJH/MCdlyktY1suNoocLFv53llAmJWdvW4wXVxOLXcHRzpGzO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+XO3Pl1p56KDk7rSelI+rKVEMnnz3nBlPgg2gGb/y0=;
 b=iH5twhuGcy5H9p2qW3M8Z3oIfoktwjfpdkYBO/QD2swNBkVnNLdS0sgGG+u22Byuv4SKdSEKqCzitCZBUk/OEy0u5JTc3JYy9TyjkH08PiepitJ+hXBrqC9OxV+T3LB/97wDW4/uyFvmnScwGjLLAqQ3ktFy+6I+tiBMr4N92MZFKrfOsBBjpnEJRyHI5ZUOkbsSFOEu6kSsd1zbK/WLe12thZ8sT7ylbYtwyxrPC7/dblcIrZtp8wjzuFehClr92439UEkeIzHQ2ut3Y8as1IpoLBSR3bimbFOM1/VkvK9QhSdbVs1/Cd3tRe2uETMb+ihxvG54dxHWOp5Y2Z7aiQ==
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b5::14)
 by MEAP282MB0407.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 08:41:44 +0000
Received: from SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::662f:de89:bedf:83ba]) by SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 ([fe80::662f:de89:bedf:83ba%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 08:41:44 +0000
Message-ID: <SY4P282MB3518614999070D8FD19D14DFC0E29@SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM>
Date:   Mon, 12 Dec 2022 16:41:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v10 0/4] Add kprobe and kretprobe support for LoongArch
Content-Language: en-US
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
From:   Hengqi Chen <chenhengqi@outlook.com>
In-Reply-To: <1670575981-14389-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [obsTrAtCKuRNoWOM/k3KERXkiICngVuT]
X-ClientProxiedBy: TY2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:404:56::19) To SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:1b5::14)
X-Microsoft-Original-Message-ID: <f0ee0a8c-4c60-955c-8548-bebc6adfdd52@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB3518:EE_|MEAP282MB0407:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4e179c-8c89-4c84-3e78-08dadc1cb187
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IVL3KVsiPYk5ftqSmTCVouR+vD81Cw54A73uf9+Mdq4DYf476GPeLY+cqL07rQGypQvunqd1K/rxQRtgvolbbmJkWfqWNEC3vuBAJH1QmtwmJDAzh3ajLiEEB+LsBMe28Aun7N+PZd0J0ZhqJRo7YvY71xyOhfl/6Boqgq7jrvkv7R1CbyGKg3mYqQHARxwPPbHv4Q/ZQXVR586eHUs1YK3zXdKX8sKoO3czNEWAjfp6dRd6qTTHWyJ3vkYta4eQYX0cr7Buz7mfrKQS0nw9vwkZ28DQBfmOkCmx1WPd3zAqOAhjpf6FZZUTRfIg3U5kGuqfrF0s1AOSa83/jk5HmEqILZMC4dBkuB5AUsUpP7vNIxz09aNeaomhw8k/UBZQS+Qnliql4CIDJyJQRCiQB25KADFOODmRmvOHAqxA3d4Krc40Hykn3EJRHjZDq5HlcJZFigwPN2tBgR77PUW45GQRp2umN93esW0QRDgsJwDUYrYj0e2S8VvwgfFtVuZQbvXTRZhwkjuyMjqO1vOWKd1khahI/Vl+wq5C26C50tMQJLEpSLtCS/fm0I9Dd9WIMsTXQ5RRqvfRkYzAdUUHm0Gvuw7j2mOHuJhHZII+IQ3620oOs64ogIEaMzulIo7QVTdFe8JsbIAKn1ibuuoVsg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2RVMnRRRDMyT0cxSWV5U0tLQ2RXTFpLUHNaK1BuSVc3NDdMWnZsaC9KZjNC?=
 =?utf-8?B?M3V6SHR6TStmelpGQlo4MURaSmdVZWdtK2VoZ3llbFlhWnpHWHN6SXF1eFcz?=
 =?utf-8?B?Q3I1WGhxQjNsTzNwRkd4UVJpNzV4UjhiQ3JUZ2hkYTVlTnY3bk9ZV2J4Z2JR?=
 =?utf-8?B?eGsrMDljVkV4cUlGQ3gzaG1SSHVUZHZWUjZpeFdPOXM4bVM4OUh4RnBzOEc4?=
 =?utf-8?B?OHF5UDdOSnROMlpqNWhlNjYrd0JqQndyQjdQeTM0bVJ2U2d2Vlp0eUhkOUJk?=
 =?utf-8?B?RHNFYys1UGJNRExEUHNIU29FZzJTc05rM1M3NUFLbXhvQ3lzWmE3akxuOGl3?=
 =?utf-8?B?aUtqT1NsNHhKTFFWdDdBS0ptbEpnTjFXRXdGeFErU010aHl6WjQ5RzVmbFU5?=
 =?utf-8?B?bTkxTTVoblJEeXhJVDA0QXBkK0FVb0JZSGc5byt5ZG8vTkhmZmxjTDI5S0Qr?=
 =?utf-8?B?WVNCSVY0UFpmOGExcHBQaDlYcllIb0p6TXhLb3hNSFNzOGlPWWF6MmVGNzAz?=
 =?utf-8?B?WWxkQjJaUEVaaGhBOHU1UDhlSlhDd2hzNFZ2NlZ4ay9JRyszbXg4VUhvMjFl?=
 =?utf-8?B?bW9oam1DQjB3R2FnTDZzTTNxb0kwdHhiOTdaM1VBQXhjRzkreE1IdUVDR1dE?=
 =?utf-8?B?enFPV2NtV1ZnRGFjM01XZThMY0g1MWN5VlU3enZXZXBFNnBuQURDNmhLbmZ1?=
 =?utf-8?B?U0NKYnNFQkkwbUw4N3RldXBHTkp2aVhkMmQ4UHl5Zmt6SDUxYWVNZUNkOUJ0?=
 =?utf-8?B?Z3pBdFhNOEJ5QURFZzJzUk9kWXQwY1ZJZFdyeEE4dWg5UTZERnk4VGNFR0pC?=
 =?utf-8?B?a0xhR1p0eTljR2paVUV3ODVidnBwcWd1Rkl5K3NoSnhoV1U0b1BERUN0WmVs?=
 =?utf-8?B?ckxSTktxaHJ3eGZKT1JwV2toNTJ0dFJqSXlSVUNvenU4MTVORkRZd3dnUHRK?=
 =?utf-8?B?Y2gydENJcTkrT1RXa0ZXcEJDYnA0QnczUlNMVU1KNFdKMURETDZqb2RtV0FL?=
 =?utf-8?B?ZTRoOENQM1hhbkJMUkJSV2x4TUwrU0hYZUs4bWliQmhpVno3Wi91bnFLM09m?=
 =?utf-8?B?U0tzZmVVRU1NZ3V0L3B2TVdYc3VCWTJ1a0cvWlUyWWpKaVRvdXdyOW9Udk51?=
 =?utf-8?B?VTlKVWM3MmQrZDRxczkrSFNQYzBKMXY5V2lkZ3FucGdmTEQwRGY3RGZqd2F1?=
 =?utf-8?B?eGlKNE1mOTVwRit6ajRrRkUrd0V4MlVwTVllcjR1UzFkbDZHcExWcWZ0cXIv?=
 =?utf-8?B?TC9ZR1NhUktGVlZkRlU2QlBRd0ZDdHBHY3JHeXcxNW1JY0JodE9TMzBwZG9W?=
 =?utf-8?B?ZXRteWN1dllNbGRqZUNvTXdzQnVtMWZ6SGlWOEJBdDc5WkUxdEJZTVRDZDdt?=
 =?utf-8?B?a241T3A3UlFqZVEyc25CK3NPY1A2dFRWMkxLbGZROGhsbG1QL3hVN0wrT3Ba?=
 =?utf-8?B?amg4aC9SZmRPaTd6bEQyL0xDNm4wd0h5SXFnQW1COGlOM0FpSXZpTDk2MEhq?=
 =?utf-8?B?b3Z2U1ZsN052V3EwangrTmtMV1pHN1AyeWo2U0lFdyt5M2hucGl1WU9WVm1G?=
 =?utf-8?B?NVV2YXBiU1lGTjVsWkd1NVZSUElYQWdIbk90Z0hZZmYvVStGblNYOGJGcDE4?=
 =?utf-8?B?cW9JaGdmb0gvQkN5amVvL0JTcXQ5U3NqSmkydnJzZTluU2ppQllPWk1SMjlN?=
 =?utf-8?B?M1ZYZVZrcDQ5TVMwQVlaRHVzWDY1blcyU05YZVBCdkdqQ3JLQ1k5c0tBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4e179c-8c89-4c84-3e78-08dadc1cb187
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB3518.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 08:41:44.2970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEAP282MB0407
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu:

I tested this patchset from BPF side, failed with EINVAL:

    $ cat /sys/kernel/tracing/error_log
    [  262.299093] trace_kprobe: error: Failed to register probe event
      Command: p:kprobes/libbpf_4609_inet_bind_0x0_0 inet_bind+0x0
                                                 ^
--
Hengqi

On 2022/12/9 16:52, Tiezhu Yang wrote:
> v10:
>   -- Remove sign_extend() based on the latest code
>   -- Rename insns_are_not_supported() to insns_not_supported()
>   -- Rename insns_are_not_simulated() to insns_not_simulated()
>   -- Set KPROBE_HIT_SSDONE if cur->post_handler is not NULL
>   -- Enable preemption for KPROBE_REENTER in kprobe_fault_handler()
> 
> v9:
>   -- Rename sign_extended() to sign_extend()
>   -- Modify kprobe_fault_handler() to handle all of kprobe_status
> 
> v8:
>   -- Put "regs->csr_prmd &= ~CSR_PRMD_PIE;" ahead to save one line
>   -- Add code comment of preempt_disable()
>   -- Put kprobe_page_fault() in __do_page_fault()
>   -- Modify the check condition of break insn in kprobe_breakpoint_handler()
> 
> v7:
>   -- Remove stop_machine_cpuslocked() related code
> 
> v6:
>   -- Add a new patch to redefine larch_insn_patch_text() with
>      stop_machine_cpuslocked()
>   -- Modify kprobe_breakpoint_handler() to consider the original
>      insn is break and return the correct value
>   -- Modify do_bp() to refresh bcode when original insn is break
> 
> v5:
>   -- Rebase on the latest code
>   -- Use stop_machine_cpuslocked() to modify insn to avoid CPU race
> 
> v4:
>   -- Remove kprobe_exceptions_notify() in kprobes.c
>   -- Call kprobe_breakpoint_handler() and kprobe_singlestep_handler()
>      in do_bp()
> 
> v3:
>   -- Rebase on the latest code
>   -- Check the alignment of PC in simu_branch() and simu_pc()
>   -- Add ibar in flush_insn_slot()
>   -- Rename kprobe_{pre,post}_handler() to {post_}kprobe_handler
>   -- Add preempt_disable() and preempt_enable_no_resched()
>   -- Remove r0 save/restore and do some minor changes
>      in kprobes_trampoline.S
>   -- Do not enable CONFIG_KPROBES by default
> 
> v2:
>   -- Split simu_branch() and simu_pc() into a single patch
>   -- Call kprobe_page_fault() in do_page_fault()
>   -- Add kprobes_trampoline.S for kretprobe
> 
> Tiezhu Yang (4):
>   LoongArch: Simulate branch and PC instructions
>   LoongArch: Add kprobe support
>   LoongArch: Add kretprobe support
>   samples/kprobes: Add LoongArch support
> 
>  arch/loongarch/Kconfig                     |   2 +
>  arch/loongarch/include/asm/inst.h          |  20 ++
>  arch/loongarch/include/asm/kprobes.h       |  59 +++++
>  arch/loongarch/include/asm/ptrace.h        |   1 +
>  arch/loongarch/kernel/Makefile             |   2 +
>  arch/loongarch/kernel/inst.c               | 123 ++++++++++
>  arch/loongarch/kernel/kprobes.c            | 364 +++++++++++++++++++++++++++++
>  arch/loongarch/kernel/kprobes_trampoline.S |  96 ++++++++
>  arch/loongarch/kernel/traps.c              |  13 +-
>  arch/loongarch/mm/fault.c                  |   3 +
>  samples/kprobes/kprobe_example.c           |   8 +
>  11 files changed, 687 insertions(+), 4 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/kprobes.h
>  create mode 100644 arch/loongarch/kernel/kprobes.c
>  create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
> 
