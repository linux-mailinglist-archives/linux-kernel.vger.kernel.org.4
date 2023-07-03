Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3574588D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjGCJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjGCJiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:38:02 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCAF91;
        Mon,  3 Jul 2023 02:37:58 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-440b9d60606so1351946137.1;
        Mon, 03 Jul 2023 02:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688377077; x=1690969077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9YR2GPtHPb6KdFfGQNhuyNc9t+8hNGyry+4/Vfo47o=;
        b=XaK6nygeGX1vA+Zi7wLBdleS1AO6K/V3iNiAOhcm41VXCvMdKa5uiNyKnhenS7PcSe
         8TEH3ezayiP7d7n3fealRh+B9OqwgaQzU834SK+mzm61C+T3z6YeCphFXtJxateroNl0
         noypHi68RTGFbWOg3WIvipu/SU/vA+eUkGUIkChgisU8AuAhokfsBNqdJDKJa7+8ftse
         guNaHHljuopYOyFFEaQJBXFGKWeb6itrfQ+0+ruWEwS4ybZoJt6zGQQEMHi9eQyzVgL7
         CkQZ3o750z8AA6lyLHBXCJp2WjUmLjUBtsMkvqLUof7hlHrnwruQylJ0msusbr+OgKJ+
         o/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377077; x=1690969077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9YR2GPtHPb6KdFfGQNhuyNc9t+8hNGyry+4/Vfo47o=;
        b=NlaCSRxXQEoXnpYKlYs8Z2XEVwM7C1vl9L6gafAvnVni4CvNI09pKrjH75uPOUlulx
         ka3vztxKASZe7DBxyshPYRUOQNGcsv3XgdutFEYtIfjLxqDL8pHa6930gqpNmz+raFyQ
         A5SThF8eS28kW+wUDM9Amm0YUs+vlKbDn5IWJctynYBtNYODmZlBcnJLLj6wLz22WHNy
         HfVS9mErFVMpZfj74DpDZrciGPi+4OAECv5xt1LsbzL4DV3ejWylflp+ZDy8B8YE7fxA
         UY5bvtZlAU4vuAgYZcO0oeaIlTwixfCUyIylQG2IYaczQfWTZM58xFIU107/MRZtMf3g
         Aslw==
X-Gm-Message-State: ABy/qLaHSPGg2Szm5vocf9c7YwvFtqXMANsnNM23Op9bYGRovBMVoAD8
        yeyXdwmtGHPdLVBB0tMlEIC0GNNR3DuiN7MRHrk=
X-Google-Smtp-Source: APBJJlETaLASX5DutDT+FovZIkLEcNP+/wQNZAiAUWJCj940DlqfZkfZHd5STQN1HxHTvpwrm/78UljS8Y9C5jiXsXQ=
X-Received: by 2002:a05:6102:50d:b0:437:e5ce:7e8f with SMTP id
 l13-20020a056102050d00b00437e5ce7e8fmr4487456vsa.4.1688377076541; Mon, 03 Jul
 2023 02:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com> <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
In-Reply-To: <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 3 Jul 2023 11:37:44 +0200
Message-ID: <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, got back, switched to 6.4.1 and reran with kmemleak and kasan

I got the splat from:
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cea28d30abb5..701c1b5cf532 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4328,6 +4328,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,

        skb->prev =3D tail;

+       if (WARN_ON_ONCE(!skb->next))
+               goto err_linearize;
+
        if (skb_needs_linearize(skb, features) &&
            __skb_linearize(skb))
                goto err_linearize;

I'm just happy i ran with dmesg -W since there was only minimal output
on the console:
[39914.833696] rcu: INFO: rcu_preempt self-detected stall on CPU
[39914.839598] rcu:     2-....: (20997 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D4687
[39914.849839] rcu:     (t=3D21017 jiffies g=3D18175157 q=3D45473 ncpus=3D1=
2)
[39977.862108] rcu: INFO: rcu_preempt self-detected stall on CPU
[39977.868002] rcu:     2-....: (84001 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D28434
[39977.878340] rcu:     (t=3D84047 jiffies g=3D18175157 q=3D263477 ncpus=3D=
12)
[40040.892521] rcu: INFO: rcu_preempt self-detected stall on CPU
[40040.898414] rcu:     2-....: (147006 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D53043
[40040.908831] rcu:     (t=3D147079 jiffies g=3D18175157 q=3D464422 ncpus=
=3D12)
[40065.080842] ixgbe 0000:06:00.1 eno2: Reset adapter

And in dmesg -W i got:
cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[39914.833696] rcu: INFO: rcu_preempt self-detected stall on CPU
[39914.839598] rcu: 2-....: (20997 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D4687
[39914.849839] rcu: (t=3D21017 jiffies g=3D18175157 q=3D45473 ncpus=3D12)
[39914.855892] CPU: 2 PID: 913 Comm: napi/eno2-84 Tainted: G        W
        6.4.1-dirty #372
[39914.855921] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[39914.855938] RIP: 0010:_raw_spin_unlock_irqrestore
(./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[39914.855980] Code: cc 66 0f 1f 84 00 00 00 00 00 55 48 89 f5 53 48
89 fb e8 03 72 88 fe c6 03 00 f7 c5 00 02 00 00 74 01 fb 65 ff 0d d8
27 d0 5c <74> 07 5b 5d c3 cc cc cc cc 0f 1f 44 00 00 5b 5d c3 cc cc cc
cc 66
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: cc                    int3
   1: 66 0f 1f 84 00 00 00 nopw   0x0(%rax,%rax,1)
   8: 00 00
   a: 55                    push   %rbp
   b: 48 89 f5              mov    %rsi,%rbp
   e: 53                    push   %rbx
   f: 48 89 fb              mov    %rdi,%rbx
  12: e8 03 72 88 fe        call   0xfffffffffe88721a
  17: c6 03 00              movb   $0x0,(%rbx)
  1a: f7 c5 00 02 00 00    test   $0x200,%ebp
  20: 74 01                je     0x23
  22: fb                    sti
  23: 65 ff 0d d8 27 d0 5c decl   %gs:0x5cd027d8(%rip)        # 0x5cd02802
  2a:* 74 07                je     0x33 <-- trapping instruction
  2c: 5b                    pop    %rbx
  2d: 5d                    pop    %rbp
  2e: c3                    ret
  2f: cc                    int3
  30: cc                    int3
  31: cc                    int3
  32: cc                    int3
  33: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
  38: 5b                    pop    %rbx
  39: 5d                    pop    %rbp
  3a: c3                    ret
  3b: cc                    int3
  3c: cc                    int3
  3d: cc                    int3
  3e: cc                    int3
  3f: 66                    data16

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 74 07                je     0x9
   2: 5b                    pop    %rbx
   3: 5d                    pop    %rbp
   4: c3                    ret
   5: cc                    int3
   6: cc                    int3
   7: cc                    int3
   8: cc                    int3
   9: 0f 1f 44 00 00        nopl   0x0(%rax,%rax,1)
   e: 5b                    pop    %rbx
   f: 5d                    pop    %rbp
  10: c3                    ret
  11: cc                    int3
  12: cc                    int3
  13: cc                    int3
  14: cc                    int3
  15: 66                    data16
[39914.856006] RSP: 0018:ffff888109f9e9d0 EFLAGS: 00000206
[39914.856034] RAX: 0000000000000004 RBX: ffffffffa55812e0 RCX: ffffffffa33=
34d1d
[39914.856054] RDX: 0000000000000000 RSI: 0000000000000246 RDI: ffffffffa55=
812e0
[39914.856073] RBP: 0000000000000246 R08: 0000000000000000 R09: 00000000000=
00003
[39914.856090] R10: fffffbfff4ab025c R11: 00000000000080fe R12: 00000000000=
00000
[39914.856108] R13: 0000000000082820 R14: 0000000000000240 R15: 00000000000=
00000
[39914.856126] FS:  0000000000000000(0000) GS:ffff8883ef700000(0000)
knlGS:0000000000000000
[39914.856147] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39914.856165] CR2: 00007f21303f298c CR3: 00000002ab8a6000 CR4: 00000000003=
526e0
[39914.856185] Call Trace:
[39914.856201]  <IRQ>
[39914.856218] ? rcu_dump_cpu_stacks (kernel/rcu/tree_stall.h:372)
[39914.856252] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:692
kernel/rcu/tree_stall.h:774 kernel/rcu/tree.c:3822
kernel/rcu/tree.c:2214)
[39914.856284] ? resched_curr (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
./include/linux/thread_info.h:118 ./include/linux/sched.h:2050
./include/linux/sched.h:2065 kernel/sched/core.c:1048)
[39914.856312] ? wake_q_add_safe (kernel/sched/core.c:1042)
[39914.856339] ? rcu_note_context_switch (kernel/rcu/tree.c:2193)
[39914.856370] ? clear_buddies (kernel/sched/fair.c:4922)
[39914.856393] ? run_posix_cpu_timers
(./include/linux/sched/deadline.h:15
./include/linux/sched/deadline.h:22
kernel/time/posix-cpu-timers.c:1155
kernel/time/posix-cpu-timers.c:1451)
[39914.856422] ? clear_posix_cputimers_work
(kernel/time/posix-cpu-timers.c:1435)
[39914.856451] ? cpuacct_account_field (./include/linux/cgroup.h:437
kernel/sched/cpuacct.c:39 kernel/sched/cpuacct.c:354)
[39914.856480] ? hrtimer_run_queues (kernel/time/hrtimer.c:1900)
[39914.856509] ? update_process_times
(./arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073)
[39914.856536] ? tick_sched_handle (kernel/time/tick-sched.c:255)
[39914.856566] ? tick_sched_timer (kernel/time/tick-sched.c:1497)
[39914.856596] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479)
[39914.856626] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1685
kernel/time/hrtimer.c:1749)
[39914.856653] ? netif_tx_stop_all_queues (net/core/dev.c:5992)
[39914.856688] ? enqueue_hrtimer (kernel/time/hrtimer.c:1719)
[39914.856714] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[39914.856746] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39914.856773] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39914.856800] ? ktime_get_update_offsets_now
(kernel/time/timekeeping.c:2323 (discriminator 3))
[39914.856831] ? hrtimer_interrupt (kernel/time/hrtimer.c:1814)
[39914.856863] ? __sysvec_apic_timer_interrupt
(./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./arch/x86/include/asm/trace/irq_vectors.h:41
arch/x86/kernel/apic/apic.c:1113)
[39914.856893] ? sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1106 (discriminator 14))
[39914.856919]  </IRQ>
[39914.856932]  <TASK>
[39914.856945] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39914.856983] ? _raw_spin_unlock_irqrestore
(./include/asm-generic/qspinlock.h:128 ./include/linux/spinlock.h:203
./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[39914.857017] ? _raw_spin_unlock_irqrestore
(./include/linux/spinlock_api_smp.h:152 kernel/locking/spinlock.c:194)
[39914.857050] kmem_cache_alloc_node (./include/linux/kmemleak.h:42
mm/slab.h:714 mm/slub.c:3451 mm/slub.c:3496)
[39914.857086] kmalloc_reserve (net/core/skbuff.c:571)
[39914.857118] __alloc_skb (net/core/skbuff.c:654)
[39914.857148] ? __napi_build_skb (net/core/skbuff.c:627)
[39914.857180] ? skb_segment (net/core/skbuff.c:4531)
[39914.857204] ? skb_segment (./include/linux/skbuff.h:2577
net/core/skbuff.c:4527)
[39914.857231] skb_segment (net/core/skbuff.c:4519)
[39914.857257] ? write_profile (kernel/stacktrace.c:83)
[39914.857296] ? pskb_extract (net/core/skbuff.c:4360)
[39914.857320] ? rt6_score_route (net/ipv6/route.c:713 (discriminator 1))
[39914.857346] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[39914.857379] __udp_gso_segment (net/ipv4/udp_offload.c:290)
[39914.857413] ? ip6_dst_destroy (net/ipv6/route.c:788)
[39914.857442] udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39914.857472] ? udp6_gro_complete (net/ipv6/udp_offload.c:20)
[39914.857498] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:53)
[39914.857528] ipv6_gso_segment (net/ipv6/ip6_offload.c:119
net/ipv6/ip6_offload.c:74)
[39914.857557] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:76)
[39914.857583] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c:254=
)
[39914.857612] ? fib6_select_path (net/ipv6/route.c:458)
[39914.857643] skb_mac_gso_segment (net/core/gro.c:141)
[39914.857673] ? skb_eth_gso_segment (net/core/gro.c:127)
[39914.857702] ? ipv6_skip_exthdr (net/ipv6/exthdrs_core.c:190)
[39914.857726] ? kasan_save_stack (mm/kasan/common.c:47)
[39914.857758] __skb_gso_segment (net/core/dev.c:3401 (discriminator 2))
[39914.857787] udpv6_queue_rcv_skb (./include/net/udp.h:492
net/ipv6/udp.c:796 net/ipv6/udp.c:787)
[39914.857816] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[39914.857846] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:437
(discriminator 4))
[39914.857884] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[39914.857913] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[39914.857941] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[39914.857970] ? ip6_route_del (net/ipv6/route.c:4013)
[39914.857998] ? ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
[39914.858028] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[39914.858055] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[39914.858086] ip6_mc_input (net/ipv6/ip6_input.c:591)
[39914.858116] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[39914.858151] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[39914.858179] ? ip6_input (net/ipv6/ip6_input.c:303)
[39914.858206] ? stack_trace_save (kernel/stacktrace.c:123)
[39914.858236] ? ipv6_list_rcv (net/ipv6/ip6_input.c:70)
[39914.858268] ? ip6_input (net/ipv6/ip6_input.c:303)
[39914.858294] __netif_receive_skb_one_core (net/core/dev.c:5486)
[39914.858326] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[39914.858358] ? br_nf_dev_queue_xmit (net/bridge/br_netfilter_hooks.c:820)
[39914.858387] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[39914.858417] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[39914.858447] ? __netif_receive_skb (net/core/dev.c:5747)
[39914.858476] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[39914.858507] ? br_nf_forward_ip (net/bridge/br_netfilter_hooks.c:647)
[39914.858533] ? nf_hook_slow (net/netfilter/core.c:625)
[39914.858562] ? br_handle_vlan (net/bridge/br_vlan.c:483)
[39914.858592] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[39914.858622] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[39914.858655] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[39914.858690] br_handle_frame_finish (net/bridge/br_input.c:216)
[39914.858724] ? br_handle_local_finish (net/bridge/br_input.c:75)
[39914.858755] ? br_cfm_config_fill_info (net/bridge/br_cfm_netlink.c:510)
[39914.858784] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[39914.858813] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[39914.858837] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:655
(discriminator 3))
[39914.858868] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[39914.858893] ? write_profile (kernel/stacktrace.c:83)
[39914.858924] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[39914.858953] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[39914.858983] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[39914.859013] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[39914.859042] ? br_handle_local_finish (net/bridge/br_input.c:75)
[39914.859072] ? packet_rcv (net/packet/af_packet.c:2231)
[39914.859100] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[39914.859131] ? virtio_net_hdr_to_skb.constprop.0 (drivers/net/tun.c:753)
[39914.859161] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[39914.859194] ? udp_lib_lport_inuse (net/ipv4/udp.c:152)
[39914.859224] ? do_xdp_generic (net/core/dev.c:5281)
[39914.859254] ? udp4_lib_lookup2 (net/ipv4/udp.c:449 (discriminator 9))
[39914.859286] ? __udp4_lib_lookup (net/ipv4/udp.c:531)
[39914.859317] __netif_receive_skb_list_core (net/core/dev.c:5570)
[39914.859351] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[39914.859382] ? udp_push_pending_frames (net/ipv4/udp.c:495)
[39914.859415] ? kmem_cache_alloc_bulk (mm/slub.c:4033)
[39914.859445] ? napi_skb_cache_get (net/core/skbuff.c:338)
[39914.859474] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39914.859503] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[39914.859538] ? process_backlog (net/core/dev.c:5699)
[39914.859565] ? udp4_gro_complete (net/ipv4/udp_offload.c:714)
[39914.859595] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:423)
[39914.859622] ? napi_gro_complete.constprop.0
(./include/net/gro.h:444 net/core/gro.c:328)
[39914.859653] ? napi_gro_flush (./arch/x86/include/asm/bitops.h:94
./include/asm-generic/bitops/instrumented-non-atomic.h:45
net/core/gro.c:346 net/core/gro.c:361)
[39914.859683] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[39914.859714] ? napi_busy_loop (net/core/dev.c:6034)
[39914.859746] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[39914.859785] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[39914.859815] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39914.859849] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39914.859887] __napi_poll (net/core/dev.c:6498)
[39914.859917] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[39914.859949] ? __napi_poll (net/core/dev.c:6625)
[39914.859976] ? migrate_enable (kernel/sched/core.c:3045)
[39914.860009] ? __napi_poll (net/core/dev.c:6625)
[39914.860037] kthread (kernel/kthread.c:379)
[39914.860064] ? kthread_complete_and_exit (kernel/kthread.c:332)
[39914.860095] ret_from_fork (arch/x86/entry/entry_64.S:314)
[39914.860126]  </TASK>
[39977.862108] rcu: INFO: rcu_preempt self-detected stall on CPU
[39977.868002] rcu: 2-....: (84001 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D28434
[39977.878340] rcu: (t=3D84047 jiffies g=3D18175157 q=3D263477 ncpus=3D12)
[39977.884486] CPU: 2 PID: 913 Comm: napi/eno2-84 Tainted: G        W
        6.4.1-dirty #372
[39977.884520] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[39977.884537] RIP: 0010:__orc_find (arch/x86/kernel/unwind_orc.c:52)
[39977.884577] Code: 00 00 00 41 57 89 d0 41 56 41 55 4c 8d 6c 87 fc
41 54 55 53 48 83 ec 08 48 89 34 24 85 d2 0f 84 81 00 00 00 49 89 fc
49 39 fd <0f> 82 8a 00 00 00 48 89 cb 48 89 fd 49 89 ff eb 0c 4d 8d 7e
04 4c
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 00 00                add    %al,(%rax)
   2: 00 41 57              add    %al,0x57(%rcx)
   5: 89 d0                mov    %edx,%eax
   7: 41 56                push   %r14
   9: 41 55                push   %r13
   b: 4c 8d 6c 87 fc        lea    -0x4(%rdi,%rax,4),%r13
  10: 41 54                push   %r12
  12: 55                    push   %rbp
  13: 53                    push   %rbx
  14: 48 83 ec 08          sub    $0x8,%rsp
  18: 48 89 34 24          mov    %rsi,(%rsp)
  1c: 85 d2                test   %edx,%edx
  1e: 0f 84 81 00 00 00    je     0xa5
  24: 49 89 fc              mov    %rdi,%r12
  27: 49 39 fd              cmp    %rdi,%r13
  2a:* 0f 82 8a 00 00 00    jb     0xba <-- trapping instruction
  30: 48 89 cb              mov    %rcx,%rbx
  33: 48 89 fd              mov    %rdi,%rbp
  36: 49 89 ff              mov    %rdi,%r15
  39: eb 0c                jmp    0x47
  3b: 4d 8d 7e 04          lea    0x4(%r14),%r15
  3f: 4c                    rex.WR

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 82 8a 00 00 00    jb     0x90
   6: 48 89 cb              mov    %rcx,%rbx
   9: 48 89 fd              mov    %rdi,%rbp
   c: 49 89 ff              mov    %rdi,%r15
   f: eb 0c                jmp    0x1d
  11: 4d 8d 7e 04          lea    0x4(%r14),%r15
  15: 4c                    rex.WR
[39977.884602] RSP: 0018:ffff888109f9e518 EFLAGS: 00000246
[39977.884631] RAX: 0000000000000001 RBX: ffff888109f9e5c8 RCX: ffffffffa31=
69519
[39977.884652] RDX: 0000000000000001 RSI: ffffffffa51081fa RDI: ffffffffa4c=
4a7a4
[39977.884671] RBP: 00000000000bbad1 R08: ffffffffa5108200 R09: ffffffffa50=
de9d7
[39977.884690] R10: 0000000000020001 R11: 00000000000080fe R12: ffffffffa4c=
4a7a4
[39977.884709] R13: ffffffffa4c4a7a4 R14: ffff888109f9e5fd R15: ffffffffa31=
69519
[39977.884729] FS:  0000000000000000(0000) GS:ffff8883ef700000(0000)
knlGS:0000000000000000
[39977.884750] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39977.884768] CR2: 00007f21303f298c CR3: 00000002ab8a6000 CR4: 00000000003=
526e0
[39977.884788] Call Trace:
[39977.884804]  <IRQ>
[39977.884821] ? rcu_dump_cpu_stacks (kernel/rcu/tree_stall.h:372)
[39977.884855] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:692
kernel/rcu/tree_stall.h:774 kernel/rcu/tree.c:3822
kernel/rcu/tree.c:2214)
[39977.884888] ? resched_curr (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
./include/linux/thread_info.h:118 ./include/linux/sched.h:2050
./include/linux/sched.h:2065 kernel/sched/core.c:1048)
[39977.884915] ? wake_q_add_safe (kernel/sched/core.c:1042)
[39977.884942] ? rcu_note_context_switch (kernel/rcu/tree.c:2193)
[39977.884972] ? clear_buddies (kernel/sched/fair.c:4922)
[39977.884995] ? run_posix_cpu_timers
(./include/linux/sched/deadline.h:15
./include/linux/sched/deadline.h:22
kernel/time/posix-cpu-timers.c:1155
kernel/time/posix-cpu-timers.c:1451)
[39977.885023] ? clear_posix_cputimers_work
(kernel/time/posix-cpu-timers.c:1435)
[39977.885052] ? cpuacct_account_field (./include/linux/cgroup.h:437
kernel/sched/cpuacct.c:39 kernel/sched/cpuacct.c:354)
[39977.885081] ? hrtimer_run_queues (kernel/time/hrtimer.c:1900)
[39977.885110] ? update_process_times
(./arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073)
[39977.885136] ? tick_sched_handle (kernel/time/tick-sched.c:255)
[39977.885166] ? tick_sched_timer (kernel/time/tick-sched.c:1497)
[39977.885195] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479)
[39977.885225] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1685
kernel/time/hrtimer.c:1749)
[39977.885251] ? netif_tx_stop_all_queues (net/core/dev.c:5992)
[39977.885286] ? enqueue_hrtimer (kernel/time/hrtimer.c:1719)
[39977.885311] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[39977.885344] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39977.885371] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39977.885397] ? ktime_get_update_offsets_now
(kernel/time/timekeeping.c:2323 (discriminator 3))
[39977.885428] ? hrtimer_interrupt (kernel/time/hrtimer.c:1814)
[39977.885459] ? __sysvec_apic_timer_interrupt
(./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./arch/x86/include/asm/trace/irq_vectors.h:41
arch/x86/kernel/apic/apic.c:1113)
[39977.885490] ? sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1106 (discriminator 14))
[39977.885515]  </IRQ>
[39977.885528]  <TASK>
[39977.885542] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39977.885575] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.885604] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.885632] ? __orc_find (arch/x86/kernel/unwind_orc.c:52)
[39977.885662] ? stack_access_ok
(./arch/x86/include/asm/stacktrace.h:60
arch/x86/kernel/unwind_orc.c:368)
[39977.885692] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.885717] unwind_next_frame (arch/x86/kernel/unwind_orc.c:195
arch/x86/kernel/unwind_orc.c:469)
[39977.885748] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.885775] ? write_profile (kernel/stacktrace.c:83)
[39977.885805] arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
[39977.885834] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.885862] stack_trace_save (kernel/stacktrace.c:123)
[39977.885892] ? filter_irq_stacks (kernel/stacktrace.c:114)
[39977.885923] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[39977.885949] kasan_save_stack (mm/kasan/common.c:46)
[39977.885980] ? kasan_save_stack (mm/kasan/common.c:46)
[39977.886008] ? kasan_set_track (mm/kasan/common.c:52)
[39977.886036] ? __kasan_slab_alloc (mm/kasan/common.c:328)
[39977.886065] ? kmem_cache_alloc (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475)
[39977.886092] ? __create_object (mm/kmemleak.c:458 mm/kmemleak.c:635)
[39977.886116] ? kmem_cache_alloc_node (./include/linux/kmemleak.h:42
mm/slab.h:714 mm/slub.c:3451 mm/slub.c:3496)
[39977.886144] ? kmalloc_reserve (net/core/skbuff.c:571)
[39977.886172] ? __alloc_skb (net/core/skbuff.c:654)
[39977.886199] ? skb_segment (net/core/skbuff.c:4519)
[39977.886223] ? __udp_gso_segment (net/ipv4/udp_offload.c:290)
[39977.886252] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.886279] ? kasan_save_stack (mm/kasan/common.c:47)
[39977.886308] ? kasan_save_stack (mm/kasan/common.c:46)
[39977.886337] ? kasan_set_track (mm/kasan/common.c:52)
[39977.886364] ? __kasan_slab_alloc (mm/kasan/common.c:328)
[39977.886393] ? kmem_cache_alloc_node (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3496)
[39977.886422] ? kmalloc_reserve (net/core/skbuff.c:571)
[39977.886449] ? __alloc_skb (net/core/skbuff.c:654)
[39977.886475] ? skb_segment (net/core/skbuff.c:4519)
[39977.886499] ? __udp_gso_segment (net/ipv4/udp_offload.c:290)
[39977.886527] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.886551] ? ipv6_gso_segment (net/ipv6/ip6_offload.c:119
net/ipv6/ip6_offload.c:74)
[39977.886576] ? skb_mac_gso_segment (net/core/gro.c:141)
[39977.886604] ? __skb_gso_segment (net/core/dev.c:3401 (discriminator 2))
[39977.886629] ? udpv6_queue_rcv_skb (./include/net/udp.h:492
net/ipv6/udp.c:796 net/ipv6/udp.c:787)
[39977.886654] ? __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[39977.886678] ? ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:437
(discriminator 4))
[39977.886707] ? ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[39977.886734] ? ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[39977.886760] ? ip6_mc_input (net/ipv6/ip6_input.c:591)
[39977.886786] ? ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[39977.886811] ? __netif_receive_skb_one_core (net/core/dev.c:5486)
[39977.886840] ? netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752=
)
[39977.886868] ? br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[39977.886896] ? br_handle_frame_finish (net/bridge/br_input.c:216)
[39977.886925] ? br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[39977.886953] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[39977.886983] ? __netif_receive_skb_list_core (net/core/dev.c:5570)
[39977.887013] ? netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[39977.887042] ? napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[39977.887070] ? ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:=
3191)
[39977.887097] ? __napi_poll (net/core/dev.c:6498)
[39977.887123] ? napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[39977.887151] ? kthread (kernel/kthread.c:379)
[39977.887177] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[39977.887200] ? _raw_write_lock_irq (kernel/locking/qspinlock.c:317)
[39977.887227] ? get_object (mm/kmemleak.c:608)
[39977.887249] kasan_set_track (mm/kasan/common.c:52)
[39977.887280] __kasan_slab_alloc (mm/kasan/common.c:328)
[39977.887312] kmem_cache_alloc (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475)
[39977.887344] __create_object (mm/kmemleak.c:458 mm/kmemleak.c:635)
[39977.887370] ? kasan_set_track (mm/kasan/common.c:52)
[39977.887401] kmem_cache_alloc_node (./include/linux/kmemleak.h:42
mm/slab.h:714 mm/slub.c:3451 mm/slub.c:3496)
[39977.887434] kmalloc_reserve (net/core/skbuff.c:571)
[39977.887465] __alloc_skb (net/core/skbuff.c:654)
[39977.887495] ? __napi_build_skb (net/core/skbuff.c:627)
[39977.887525] ? __copy_skb_header (./include/net/dst.h:289
./include/net/dst.h:297 net/core/skbuff.c:1338)
[39977.887556] ? __copy_skb_header (./include/net/dst.h:289
./include/net/dst.h:297 net/core/skbuff.c:1338)
[39977.887589] skb_segment (net/core/skbuff.c:4519)
[39977.887615] ? write_profile (kernel/stacktrace.c:83)
[39977.887654] ? pskb_extract (net/core/skbuff.c:4360)
[39977.887678] ? rt6_score_route (net/ipv6/route.c:713 (discriminator 1))
[39977.887704] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[39977.887736] __udp_gso_segment (net/ipv4/udp_offload.c:290)
[39977.887769] ? ip6_dst_destroy (net/ipv6/route.c:788)
[39977.887798] udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[39977.887827] ? udp6_gro_complete (net/ipv6/udp_offload.c:20)
[39977.887854] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:53)
[39977.887882] ipv6_gso_segment (net/ipv6/ip6_offload.c:119
net/ipv6/ip6_offload.c:74)
[39977.887912] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:76)
[39977.887938] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c:254=
)
[39977.887966] ? fib6_select_path (net/ipv6/route.c:458)
[39977.887997] skb_mac_gso_segment (net/core/gro.c:141)
[39977.888026] ? skb_eth_gso_segment (net/core/gro.c:127)
[39977.888054] ? ipv6_skip_exthdr (net/ipv6/exthdrs_core.c:190)
[39977.888078] ? kasan_save_stack (mm/kasan/common.c:47)
[39977.888110] __skb_gso_segment (net/core/dev.c:3401 (discriminator 2))
[39977.888139] udpv6_queue_rcv_skb (./include/net/udp.h:492
net/ipv6/udp.c:796 net/ipv6/udp.c:787)
[39977.888168] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[39977.888199] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:437
(discriminator 4))
[39977.888235] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[39977.888265] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[39977.888293] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[39977.888321] ? ip6_route_del (net/ipv6/route.c:4013)
[39977.888348] ? ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
[39977.888378] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[39977.888406] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[39977.888437] ip6_mc_input (net/ipv6/ip6_input.c:591)
[39977.888467] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[39977.888501] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[39977.888529] ? ip6_input (net/ipv6/ip6_input.c:303)
[39977.888556] ? stack_trace_save (kernel/stacktrace.c:123)
[39977.888585] ? ipv6_list_rcv (net/ipv6/ip6_input.c:70)
[39977.888617] ? ip6_input (net/ipv6/ip6_input.c:303)
[39977.888642] __netif_receive_skb_one_core (net/core/dev.c:5486)
[39977.888674] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[39977.888705] ? br_nf_dev_queue_xmit (net/bridge/br_netfilter_hooks.c:820)
[39977.888734] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[39977.888764] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[39977.888793] ? __netif_receive_skb (net/core/dev.c:5747)
[39977.888822] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[39977.888853] ? br_nf_forward_ip (net/bridge/br_netfilter_hooks.c:647)
[39977.888878] ? nf_hook_slow (net/netfilter/core.c:625)
[39977.888907] ? br_handle_vlan (net/bridge/br_vlan.c:483)
[39977.888936] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[39977.888967] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[39977.888999] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[39977.889033] br_handle_frame_finish (net/bridge/br_input.c:216)
[39977.889067] ? br_handle_local_finish (net/bridge/br_input.c:75)
[39977.889097] ? br_cfm_config_fill_info (net/bridge/br_cfm_netlink.c:510)
[39977.889126] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[39977.889154] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[39977.889178] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:655
(discriminator 3))
[39977.889209] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[39977.889234] ? write_profile (kernel/stacktrace.c:83)
[39977.889264] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[39977.889294] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[39977.889323] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[39977.889352] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[39977.889381] ? br_handle_local_finish (net/bridge/br_input.c:75)
[39977.889410] ? packet_rcv (net/packet/af_packet.c:2231)
[39977.889438] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[39977.889469] ? virtio_net_hdr_to_skb.constprop.0 (drivers/net/tun.c:753)
[39977.889498] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[39977.889530] ? udp_lib_lport_inuse (net/ipv4/udp.c:152)
[39977.889561] ? do_xdp_generic (net/core/dev.c:5281)
[39977.889591] ? udp4_lib_lookup2 (net/ipv4/udp.c:449 (discriminator 9))
[39977.889622] ? __udp4_lib_lookup (net/ipv4/udp.c:531)
[39977.889652] __netif_receive_skb_list_core (net/core/dev.c:5570)
[39977.889685] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[39977.889717] ? udp_push_pending_frames (net/ipv4/udp.c:495)
[39977.889749] ? kmem_cache_alloc_bulk (mm/slub.c:4033)
[39977.889778] ? napi_skb_cache_get (net/core/skbuff.c:338)
[39977.889807] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[39977.889836] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[39977.889870] ? process_backlog (net/core/dev.c:5699)
[39977.889898] ? udp4_gro_complete (net/ipv4/udp_offload.c:714)
[39977.889927] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:423)
[39977.889954] ? napi_gro_complete.constprop.0
(./include/net/gro.h:444 net/core/gro.c:328)
[39977.889985] ? napi_gro_flush (./arch/x86/include/asm/bitops.h:94
./include/asm-generic/bitops/instrumented-non-atomic.h:45
net/core/gro.c:346 net/core/gro.c:361)
[39977.890014] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[39977.890044] ? napi_busy_loop (net/core/dev.c:6034)
[39977.890076] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[39977.890115] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[39977.890145] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39977.890180] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[39977.890216] __napi_poll (net/core/dev.c:6498)
[39977.890246] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[39977.890278] ? __napi_poll (net/core/dev.c:6625)
[39977.890304] ? migrate_enable (kernel/sched/core.c:3045)
[39977.890337] ? __napi_poll (net/core/dev.c:6625)
[39977.890364] kthread (kernel/kthread.c:379)
[39977.890391] ? kthread_complete_and_exit (kernel/kthread.c:332)
[39977.890422] ret_from_fork (arch/x86/entry/entry_64.S:314)
[39977.890453]  </TASK>
[40040.892521] rcu: INFO: rcu_preempt self-detected stall on CPU
[40040.898414] rcu: 2-....: (147006 ticks this GP)
idle=3Ddd64/1/0x4000000000000000 softirq=3D4633489/4633489 fqs=3D53043
[40040.908831] rcu: (t=3D147079 jiffies g=3D18175157 q=3D464422 ncpus=3D12)
[40040.915056] CPU: 2 PID: 913 Comm: napi/eno2-84 Tainted: G        W
        6.4.1-dirty #372
[40040.915084] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[40040.915101] RIP: 0010:__asan_load4 (mm/kasan/generic.c:172
mm/kasan/generic.c:258)
[40040.915134] Code: 00 00 be 02 00 00 00 e9 ba f4 ff ff 40 38 f0 7e
ec c3 cc cc cc cc 48 c1 e8 03 80 3c 10 00 75 ef c3 cc cc cc cc 90 48
8b 34 24 <48> 83 ff fb 77 52 48 b8 ff ff ff ff ff 7f ff ff 48 39 f8 73
43 48
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 00 00                add    %al,(%rax)
   2: be 02 00 00 00        mov    $0x2,%esi
   7: e9 ba f4 ff ff        jmp    0xfffffffffffff4c6
   c: 40 38 f0              cmp    %sil,%al
   f: 7e ec                jle    0xfffffffffffffffd
  11: c3                    ret
  12: cc                    int3
  13: cc                    int3
  14: cc                    int3
  15: cc                    int3
  16: 48 c1 e8 03          shr    $0x3,%rax
  1a: 80 3c 10 00          cmpb   $0x0,(%rax,%rdx,1)
  1e: 75 ef                jne    0xf
  20: c3                    ret
  21: cc                    int3
  22: cc                    int3
  23: cc                    int3
  24: cc                    int3
  25: 90                    nop
  26: 48 8b 34 24          mov    (%rsp),%rsi
  2a:* 48 83 ff fb          cmp    $0xfffffffffffffffb,%rdi <--
trapping instruction
  2e: 77 52                ja     0x82
  30: 48 b8 ff ff ff ff ff movabs $0xffff7fffffffffff,%rax
  37: 7f ff ff
  3a: 48 39 f8              cmp    %rdi,%rax
  3d: 73 43                jae    0x82
  3f: 48                    rex.W

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 83 ff fb          cmp    $0xfffffffffffffffb,%rdi
   4: 77 52                ja     0x58
   6: 48 b8 ff ff ff ff ff movabs $0xffff7fffffffffff,%rax
   d: 7f ff ff
  10: 48 39 f8              cmp    %rdi,%rax
  13: 73 43                jae    0x58
  15: 48                    rex.W
[40040.915158] RSP: 0018:ffff888109f9e5e0 EFLAGS: 00000202
[40040.915186] RAX: 0000000000000001 RBX: ffff888109f9e600 RCX: ffffffffa17=
79901
[40040.915205] RDX: ffff888109f9ecd8 RSI: ffffffffa1778cea RDI: ffff888109f=
9e600
[40040.915225] RBP: ffff888109f9e688 R08: 0000000000000000 R09: ffffffffa50=
76637
[40040.915244] R10: fffffbfff4a0ecc6 R11: ffff8882794a12c0 R12: ffff888109f=
9e6b8
[40040.915263] R13: 0000000000000000 R14: ffff8881220a5000 R15: 00000000000=
00000
[40040.915281] FS:  0000000000000000(0000) GS:ffff8883ef700000(0000)
knlGS:0000000000000000
[40040.915302] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40040.915320] CR2: 00007f21303f298c CR3: 00000002ab8a6000 CR4: 00000000003=
526e0
[40040.915339] Call Trace:
[40040.915353]  <IRQ>
[40040.915370] ? rcu_dump_cpu_stacks (kernel/rcu/tree_stall.h:372)
[40040.915403] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:692
kernel/rcu/tree_stall.h:774 kernel/rcu/tree.c:3822
kernel/rcu/tree.c:2214)
[40040.915434] ? resched_curr (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
./include/linux/thread_info.h:118 ./include/linux/sched.h:2050
./include/linux/sched.h:2065 kernel/sched/core.c:1048)
[40040.915462] ? wake_q_add_safe (kernel/sched/core.c:1042)
[40040.915488] ? rcu_note_context_switch (kernel/rcu/tree.c:2193)
[40040.915519] ? clear_buddies (kernel/sched/fair.c:4922)
[40040.915542] ? run_posix_cpu_timers
(./include/linux/sched/deadline.h:15
./include/linux/sched/deadline.h:22
kernel/time/posix-cpu-timers.c:1155
kernel/time/posix-cpu-timers.c:1451)
[40040.915570] ? clear_posix_cputimers_work
(kernel/time/posix-cpu-timers.c:1435)
[40040.915599] ? cpuacct_account_field (./include/linux/cgroup.h:437
kernel/sched/cpuacct.c:39 kernel/sched/cpuacct.c:354)
[40040.915627] ? hrtimer_run_queues (kernel/time/hrtimer.c:1900)
[40040.915656] ? update_process_times
(./arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073)
[40040.915682] ? tick_sched_handle (kernel/time/tick-sched.c:255)
[40040.915711] ? tick_sched_timer (kernel/time/tick-sched.c:1497)
[40040.915739] ? tick_sched_do_timer (kernel/time/tick-sched.c:1479)
[40040.915769] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1685
kernel/time/hrtimer.c:1749)
[40040.915797] ? enqueue_hrtimer (kernel/time/hrtimer.c:1719)
[40040.915823] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[40040.915855] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[40040.915882] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[40040.915908] ? ktime_get_update_offsets_now
(kernel/time/timekeeping.c:2323 (discriminator 3))
[40040.915939] ? hrtimer_interrupt (kernel/time/hrtimer.c:1814)
[40040.915970] ? __sysvec_apic_timer_interrupt
(./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207
./arch/x86/include/asm/trace/irq_vectors.h:41
arch/x86/kernel/apic/apic.c:1113)
[40040.915999] ? sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1106 (discriminator 14))
[40040.916025]  </IRQ>
[40040.916038]  <TASK>
[40040.916051] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[40040.916087] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:628)
[40040.916117] ? unwind_get_return_address (arch/x86/kernel/unwind_orc.c:34=
1)
[40040.916149] ? __asan_load4 (mm/kasan/generic.c:172 mm/kasan/generic.c:25=
8)
[40040.916173] unwind_get_return_address (arch/x86/kernel/unwind_orc.c:341)
[40040.916204] ? write_profile (kernel/stacktrace.c:83)
[40040.916233] arch_stack_walk (arch/x86/kernel/stacktrace.c:26)
[40040.916260] ? __udp_gso_segment (net/ipv4/udp_offload.c:290)
[40040.916294] stack_trace_save (kernel/stacktrace.c:123)
[40040.916323] ? filter_irq_stacks (kernel/stacktrace.c:114)
[40040.916353] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[40040.916378] kasan_save_stack (mm/kasan/common.c:46)
[40040.916408] ? kasan_save_stack (mm/kasan/common.c:46)
[40040.916436] ? kasan_set_track (mm/kasan/common.c:52)
[40040.916463] ? __kasan_slab_alloc (mm/kasan/common.c:328)
[40040.916491] ? kmem_cache_alloc (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475)
[40040.916518] ? __create_object (mm/kmemleak.c:458 mm/kmemleak.c:635)
[40040.916542] ? kmem_cache_alloc_node (./include/linux/kmemleak.h:42
mm/slab.h:714 mm/slub.c:3451 mm/slub.c:3496)
[40040.916569] ? __alloc_skb (net/core/skbuff.c:644)
[40040.916597] ? skb_segment (net/core/skbuff.c:4519)
[40040.916621] ? __stack_depot_save (lib/stackdepot.c:379)
[40040.916653] ? kasan_save_stack (mm/kasan/common.c:47)
[40040.916681] ? kasan_save_stack (mm/kasan/common.c:46)
[40040.916709] ? kasan_set_track (mm/kasan/common.c:52)
[40040.916736] ? __kasan_slab_alloc (mm/kasan/common.c:328)
[40040.916765] ? kmem_cache_alloc_node (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3496)
[40040.916793] ? __alloc_skb (net/core/skbuff.c:644)
[40040.916820] ? skb_segment (net/core/skbuff.c:4519)
[40040.916843] ? __udp_gso_segment (net/ipv4/udp_offload.c:290)
[40040.916871] ? udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[40040.916895] ? ipv6_gso_segment (net/ipv6/ip6_offload.c:119
net/ipv6/ip6_offload.c:74)
[40040.916920] ? skb_mac_gso_segment (net/core/gro.c:141)
[40040.916948] ? _raw_spin_lock_irqsave
(./arch/x86/include/asm/atomic.h:202
./include/linux/atomic/atomic-instrumented.h:543
./include/asm-generic/qspinlock.h:111 ./include/linux/spinlock.h:186
./include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162)
[40040.916978] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[40040.917008] ? ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[40040.917035] ? netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752=
)
[40040.917062] ? br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[40040.917090] ? br_handle_frame_finish (net/bridge/br_input.c:216)
[40040.917119] ? br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[40040.917147] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[40040.917177] ? __netif_receive_skb_list_core (net/core/dev.c:5570)
[40040.917206] ? _raw_spin_unlock_irqrestore
(./include/asm-generic/qspinlock.h:128 ./include/linux/spinlock.h:203
./include/linux/spinlock_api_smp.h:150 kernel/locking/spinlock.c:194)
[40040.917237] ? __create_object (mm/kmemleak.c:458 mm/kmemleak.c:635)
[40040.917262] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[40040.917294] ? _raw_read_unlock_irqrestore (kernel/locking/spinlock.c:161=
)
[40040.917324] kasan_set_track (mm/kasan/common.c:52)
[40040.917353] __kasan_slab_alloc (mm/kasan/common.c:328)
[40040.917385] kmem_cache_alloc (mm/slab.h:711 mm/slub.c:3451
mm/slub.c:3459 mm/slub.c:3466 mm/slub.c:3475)
[40040.917417] __create_object (mm/kmemleak.c:458 mm/kmemleak.c:635)
[40040.917442] ? kasan_set_track (mm/kasan/common.c:52)
[40040.917472] kmem_cache_alloc_node (./include/linux/kmemleak.h:42
mm/slab.h:714 mm/slub.c:3451 mm/slub.c:3496)
[40040.917505] __alloc_skb (net/core/skbuff.c:644)
[40040.917535] ? __napi_build_skb (net/core/skbuff.c:627)
[40040.917566] ? skb_segment (./include/linux/skbuff.h:2791
net/core/skbuff.c:4539)
[40040.917593] skb_segment (net/core/skbuff.c:4519)
[40040.917619] ? write_profile (kernel/stacktrace.c:83)
[40040.917657] ? pskb_extract (net/core/skbuff.c:4360)
[40040.917680] ? rt6_score_route (net/ipv6/route.c:713 (discriminator 1))
[40040.917706] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[40040.917737] __udp_gso_segment (net/ipv4/udp_offload.c:290)
[40040.917769] ? ip6_dst_destroy (net/ipv6/route.c:788)
[40040.917798] udp6_ufo_fragment (net/ipv6/udp_offload.c:47)
[40040.917826] ? udp6_gro_complete (net/ipv6/udp_offload.c:20)
[40040.917852] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:53)
[40040.917881] ipv6_gso_segment (net/ipv6/ip6_offload.c:119
net/ipv6/ip6_offload.c:74)
[40040.917909] ? ipv6_gso_pull_exthdrs (net/ipv6/ip6_offload.c:76)
[40040.917935] ? nft_update_chain_stats (net/netfilter/nf_tables_core.c:254=
)
[40040.917963] ? fib6_select_path (net/ipv6/route.c:458)
[40040.917993] skb_mac_gso_segment (net/core/gro.c:141)
[40040.918021] ? skb_eth_gso_segment (net/core/gro.c:127)
[40040.918049] ? ipv6_skip_exthdr (net/ipv6/exthdrs_core.c:190)
[40040.918073] ? kasan_save_stack (mm/kasan/common.c:47)
[40040.918104] __skb_gso_segment (net/core/dev.c:3401 (discriminator 2))
[40040.918132] udpv6_queue_rcv_skb (./include/net/udp.h:492
net/ipv6/udp.c:796 net/ipv6/udp.c:787)
[40040.918161] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[40040.918191] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:437
(discriminator 4))
[40040.918227] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[40040.918256] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[40040.918283] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[40040.918312] ? ip6_route_del (net/ipv6/route.c:4013)
[40040.918338] ? ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
[40040.918368] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[40040.918394] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[40040.918424] ip6_mc_input (net/ipv6/ip6_input.c:591)
[40040.918454] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[40040.918487] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[40040.918515] ? ip6_input (net/ipv6/ip6_input.c:303)
[40040.918541] ? stack_trace_save (kernel/stacktrace.c:123)
[40040.918571] ? ipv6_list_rcv (net/ipv6/ip6_input.c:70)
[40040.918602] ? ip6_input (net/ipv6/ip6_input.c:303)
[40040.918627] __netif_receive_skb_one_core (net/core/dev.c:5486)
[40040.918658] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[40040.918688] ? br_nf_dev_queue_xmit (net/bridge/br_netfilter_hooks.c:820)
[40040.918717] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[40040.918746] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[40040.918775] ? __netif_receive_skb (net/core/dev.c:5747)
[40040.918803] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[40040.918834] ? br_nf_forward_ip (net/bridge/br_netfilter_hooks.c:647)
[40040.918859] ? nf_hook_slow (net/netfilter/core.c:625)
[40040.918887] ? br_handle_vlan (net/bridge/br_vlan.c:483)
[40040.918916] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[40040.918946] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[40040.918978] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[40040.919011] br_handle_frame_finish (net/bridge/br_input.c:216)
[40040.919044] ? br_handle_local_finish (net/bridge/br_input.c:75)
[40040.919074] ? br_cfm_config_fill_info (net/bridge/br_cfm_netlink.c:510)
[40040.919102] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[40040.919130] ? ret_from_fork (arch/x86/entry/entry_64.S:308)
[40040.919153] ? unwind_next_frame (arch/x86/kernel/unwind_orc.c:655
(discriminator 3))
[40040.919183] ? ret_from_fork (arch/x86/entry/entry_64.S:314)
[40040.919208] ? write_profile (kernel/stacktrace.c:83)
[40040.919238] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[40040.919266] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[40040.919295] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[40040.919324] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:382
kernel/rcu/tree_plugin.h:421)
[40040.919352] ? br_handle_local_finish (net/bridge/br_input.c:75)
[40040.919381] ? packet_rcv (net/packet/af_packet.c:2231)
[40040.919408] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[40040.919438] ? virtio_net_hdr_to_skb.constprop.0 (drivers/net/tun.c:753)
[40040.919467] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[40040.919498] ? udp_lib_lport_inuse (net/ipv4/udp.c:152)
[40040.919528] ? do_xdp_generic (net/core/dev.c:5281)
[40040.919557] ? udp4_lib_lookup2 (net/ipv4/udp.c:449 (discriminator 9))
[40040.919588] ? __udp4_lib_lookup (net/ipv4/udp.c:531)
[40040.919618] __netif_receive_skb_list_core (net/core/dev.c:5570)
[40040.919651] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[40040.919682] ? udp_push_pending_frames (net/ipv4/udp.c:495)
[40040.919714] ? kmem_cache_alloc_bulk (mm/slub.c:4033)
[40040.919743] ? napi_skb_cache_get (net/core/skbuff.c:338)
[40040.919772] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[40040.919801] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[40040.919834] ? process_backlog (net/core/dev.c:5699)
[40040.919861] ? udp4_gro_complete (net/ipv4/udp_offload.c:714)
[40040.919890] ? __rcu_read_unlock (kernel/rcu/tree_plugin.h:423)
[40040.919917] ? napi_gro_complete.constprop.0
(./include/net/gro.h:444 net/core/gro.c:328)
[40040.919948] ? napi_gro_flush (./arch/x86/include/asm/bitops.h:94
./include/asm-generic/bitops/instrumented-non-atomic.h:45
net/core/gro.c:346 net/core/gro.c:361)
[40040.919977] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[40040.920007] ? napi_busy_loop (net/core/dev.c:6034)
[40040.920039] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[40040.920077] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[40040.920107] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[40040.920140] ? asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[40040.920177] __napi_poll (net/core/dev.c:6498)
[40040.920206] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[40040.920238] ? __napi_poll (net/core/dev.c:6625)
[40040.920264] ? migrate_enable (kernel/sched/core.c:3045)
[40040.920296] ? __napi_poll (net/core/dev.c:6625)
[40040.920323] kthread (kernel/kthread.c:379)
[40040.920349] ? kthread_complete_and_exit (kernel/kthread.c:332)
[40040.920380] ret_from_fork (arch/x86/entry/entry_64.S:314)
[40040.920410]  </TASK>
[40065.078922] ------------[ cut here ]------------
[40065.078949] NETDEV WATCHDOG: eno2 (ixgbe): transmit queue 7 timed out 79=
60 ms
[40065.079126] WARNING: CPU: 8 PID: 0 at net/sched/sch_generic.c:525
dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3))
[40065.079165] Modules linked in: chaoskey
[40065.079200] CPU: 8 PID: 0 Comm: swapper/8 Tainted: G        W
   6.4.1-dirty #372
[40065.079227] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[40065.079244] RIP: 0010:dev_watchdog (net/sched/sch_generic.c:525
(discriminator 3))
[40065.079271] Code: 8b 3c 24 c6 05 07 e2 ad 01 01 4c 89 ff e8 59 60
f6 ff 45 89 f0 44 89 e9 4c 89 fe 48 89 c2 48 c7 c7 40 26 c1 a3 e8 71
97 a5 fe <0f> 0b e9 f5 fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 41 57 41
56 41
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 8b 3c 24              mov    (%rsp),%edi
   3: c6 05 07 e2 ad 01 01 movb   $0x1,0x1ade207(%rip)        # 0x1ade211
   a: 4c 89 ff              mov    %r15,%rdi
   d: e8 59 60 f6 ff        call   0xfffffffffff6606b
  12: 45 89 f0              mov    %r14d,%r8d
  15: 44 89 e9              mov    %r13d,%ecx
  18: 4c 89 fe              mov    %r15,%rsi
  1b: 48 89 c2              mov    %rax,%rdx
  1e: 48 c7 c7 40 26 c1 a3 mov    $0xffffffffa3c12640,%rdi
  25: e8 71 97 a5 fe        call   0xfffffffffea5979b
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: e9 f5 fe ff ff        jmp    0xffffffffffffff26
  31: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
  38: 00 00 00
  3b: 41 57                push   %r15
  3d: 41 56                push   %r14
  3f: 41                    rex.B

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: e9 f5 fe ff ff        jmp    0xfffffffffffffefc
   7: 66 2e 0f 1f 84 00 00 cs nopw 0x0(%rax,%rax,1)
   e: 00 00 00
  11: 41 57                push   %r15
  13: 41 56                push   %r14
  15: 41                    rex.B
[40065.079296] RSP: 0018:ffff8883efa09dc0 EFLAGS: 00010286
[40065.079322] RAX: 0000000000000000 RBX: ffff88810a0c8400 RCX: 00000000000=
00027
[40065.079341] RDX: 0000000000000027 RSI: ffffffffa1a0d41e RDI: ffff8883efa=
273c8
[40065.079361] RBP: ffff88810a0c83dc R08: 0000000000000001 R09: ffff8883efa=
273cb
[40065.079379] R10: ffffed107df44e79 R11: 0000000000000001 R12: 00000001025=
ea4e9
[40065.079398] R13: 0000000000000007 R14: 0000000000001f18 R15: ffff88810a0=
c8000
[40065.079416] FS:  0000000000000000(0000) GS:ffff8883efa00000(0000)
knlGS:0000000000000000
[40065.079437] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[40065.079455] CR2: 00007f21286b0ec8 CR3: 0000000105000000 CR4: 00000000003=
526e0
[40065.079474] Call Trace:
[40065.079490]  <IRQ>
[40065.079505] ? __warn (kernel/panic.c:673)
[40065.079533] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3=
))
[40065.079558] ? report_bug (lib/bug.c:180 lib/bug.c:219)
[40065.079588] ? handle_bug (arch/x86/kernel/traps.c:324)
[40065.079616] ? exc_invalid_op (arch/x86/kernel/traps.c:345 (discriminator=
 1))
[40065.079643] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[40065.079678] ? irq_work_claim (./arch/x86/include/asm/atomic.h:29
./arch/x86/include/asm/atomic.h:240
./include/linux/atomic/atomic-instrumented.h:407 kernel/irq_work.c:61)
[40065.079706] ? dev_watchdog (net/sched/sch_generic.c:525 (discriminator 3=
))
[40065.079733] ? qdisc_free_cb (net/sched/sch_generic.c:496)
[40065.079757] ? qdisc_free_cb (net/sched/sch_generic.c:496)
[40065.079780] call_timer_fn (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207 ./include/trace/events/timer.h:127
kernel/time/timer.c:1701)
[40065.079807] ? qdisc_free_cb (net/sched/sch_generic.c:496)
[40065.079831] __run_timers.part.0 (kernel/time/timer.c:1752
kernel/time/timer.c:2022)
[40065.079860] ? call_timer_fn (kernel/time/timer.c:1995)
[40065.079884] ? rebalance_domains (kernel/sched/fair.c:11239)
[40065.079946] ? __hrtimer_next_event_base (kernel/time/hrtimer.c:525)
[40065.079980] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[40065.080008] ? ktime_get (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:848 (discriminator 3))
[40065.080034] ? __sysvec_spurious_apic_interrupt
(./arch/x86/include/asm/barrier.h:99 arch/x86/kernel/apic/apic.c:488)
[40065.080067] run_timer_softirq (kernel/time/timer.c:2000
kernel/time/timer.c:2037)
[40065.080094] __do_softirq (./arch/x86/include/asm/jump_label.h:27
./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142
kernel/softirq.c:572)
[40065.080123] irq_exit_rcu (kernel/softirq.c:445 kernel/softirq.c:650
kernel/softirq.c:662)
[40065.080153] sysvec_apic_timer_interrupt
(arch/x86/kernel/apic/apic.c:1106 (discriminator 14))
[40065.080181]  </IRQ>
[40065.080195]  <TASK>
[40065.080208] asm_sysvec_apic_timer_interrupt
(./arch/x86/include/asm/idtentry.h:645)
[40065.080242] RIP: 0010:cpuidle_enter_state (drivers/cpuidle/cpuidle.c:291=
)
[40065.080268] Code: 48 83 3c 03 00 0f 84 28 01 00 00 83 ea 01 73 e4
48 83 c4 08 44 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc fb
45 85 e4 <0f> 89 6b ff ff ff 4b 8d 44 6d 00 48 c7 43 18 00 00 00 00 48
c1 e0
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 83 3c 03 00        cmpq   $0x0,(%rbx,%rax,1)
   5: 0f 84 28 01 00 00    je     0x133
   b: 83 ea 01              sub    $0x1,%edx
   e: 73 e4                jae    0xfffffffffffffff4
  10: 48 83 c4 08          add    $0x8,%rsp
  14: 44 89 e0              mov    %r12d,%eax
  17: 5b                    pop    %rbx
  18: 5d                    pop    %rbp
  19: 41 5c                pop    %r12
  1b: 41 5d                pop    %r13
  1d: 41 5e                pop    %r14
  1f: 41 5f                pop    %r15
  21: c3                    ret
  22: cc                    int3
  23: cc                    int3
  24: cc                    int3
  25: cc                    int3
  26: fb                    sti
  27: 45 85 e4              test   %r12d,%r12d
  2a:* 0f 89 6b ff ff ff    jns    0xffffffffffffff9b <-- trapping instruct=
ion
  30: 4b 8d 44 6d 00        lea    0x0(%r13,%r13,2),%rax
  35: 48 c7 43 18 00 00 00 movq   $0x0,0x18(%rbx)
  3c: 00
  3d: 48                    rex.W
  3e: c1                    .byte 0xc1
  3f: e0                    .byte 0xe0

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 89 6b ff ff ff    jns    0xffffffffffffff71
   6: 4b 8d 44 6d 00        lea    0x0(%r13,%r13,2),%rax
   b: 48 c7 43 18 00 00 00 movq   $0x0,0x18(%rbx)
  12: 00
  13: 48                    rex.W
  14: c1                    .byte 0xc1
  15: e0                    .byte 0xe0
[40065.080292] RSP: 0018:ffff888100bffe18 EFLAGS: 00000202
[40065.080318] RAX: 0000000000000000 RBX: ffffe8ffffc00000 RCX: ffffffffa18=
f0680
[40065.080337] RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff8883efa=
38928
[40065.080356] RBP: ffffffffa44d78e0 R08: 0000000000000000 R09: 00000000400=
00000
[40065.080374] R10: ffffed107df46834 R11: 0000000000000000 R12: 00000000000=
00002
[40065.080392] R13: 0000000000000002 R14: 0000247060cbd11a R15: 00000000000=
00000
[40065.080414] ? sched_idle_set_state (kernel/sched/sched.h:2341
kernel/sched/idle.c:19)
[40065.080450] ? cpuidle_enter_state (drivers/cpuidle/cpuidle.c:288)
[40065.080477] cpuidle_enter (drivers/cpuidle/cpuidle.c:390)
[40065.080506] do_idle (kernel/sched/idle.c:219 kernel/sched/idle.c:282)
[40065.080535] ? arch_cpu_idle_exit+0x30/0x30
[40065.080564] ? schedule_idle (./arch/x86/include/asm/bitops.h:207
(discriminator 1) ./arch/x86/include/asm/bitops.h:239 (discriminator
1) ./include/linux/thread_info.h:184 (discriminator 1)
./include/linux/sched.h:2244 (discriminator 1)
kernel/sched/core.c:6774 (discriminator 1))
[40065.080590] ? finish_task_switch.isra.0 (kernel/sched/core.c:4965
kernel/sched/core.c:5211)
[40065.080620] cpu_startup_entry (kernel/sched/idle.c:378 (discriminator 1)=
)
[40065.080649] start_secondary (arch/x86/kernel/smpboot.c:288)
[40065.080677] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:37=
0)
[40065.080710]  </TASK>
[40065.080724] ---[ end trace 0000000000000000 ]---
[40065.080765] ixgbe 0000:06:00.1 eno2: initiating reset due to tx timeout
[40065.080842] ixgbe 0000:06:00.1 eno2: Reset adapter
[40065.085843] ixgbe 0000:06:00.1 eno2: NIC Link is Down

and then the machine rebooted...

On Thu, Jun 29, 2023 at 12:50=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
>
> On Wed, Jun 28, 2023 at 10:18=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.c=
om> wrote:
> >
> > On Wed, Jun 28, 2023 at 5:15=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2023-06-28 at 14:04 +0200, Ian Kumlien wrote:
> > > > So have some hits, would it be better without your warn on? ... Thi=
ngs
> > > > are a bit slow atm - lets just say that i noticed the stacktraces
> > > > because a stream stuttered =3D)
> > >
> > > Sorry, I screwed-up completely a newly added check.
> >
> > Thats ok
> >
> > > If you have Kasan enabled you can simply and more safely remove my 2n=
d
> > > patch. Kasan should be able to catch all the out-of-buffer scenarios
> > > such checks were intended to prevent.
> >
> > I thought I'd run without any of the patches, preparing for that now,
> > but i have to stop testing tomorrow and will continue on monday if i
> > don't catch anything
>
> So, KASAN caught the null pointer derefs, as expected, but it caught
> two of them which i didn't expect.
>
> Anyway, I'm off for the weekend so, I hope to be able to send
> something better on Monday, fyi
>
> > > Cheers,
> > >
> > > Paolo
> > >
