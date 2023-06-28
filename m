Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5474105A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF1Lrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjF1Lrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:47:39 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8CE2D58;
        Wed, 28 Jun 2023 04:47:37 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-443628ee79dso1222606137.1;
        Wed, 28 Jun 2023 04:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687952856; x=1690544856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTx6dc94v45Ci191SZrpBnP46s4McjqVM14Xcmp+cwA=;
        b=pBHZ6PqUk8o9PV83lzeFbnTOsp2kW0XqgInNP8Bwva2+COXL1WZ4Xg3NNvBizYJZOo
         IBBn5wRebQB8ckJDRQK+cdIki2gA2xCvcv37AV0uDVD+t6Zs/4tTC1lUw8V6lp60cUyQ
         gDkRXWKmLh1EAsjWYQlO9Vvmf7VyKtj5t0w2tU25fRyEiXZ1VGGd9stdXbzSoB0Y3FLm
         t0IkV1OeWd7NyBY1dPKvfmDuJtmmX4JK7ShJL4wKk5RPC26pOySj8rAQhbf0wF9PcfPy
         aS0FqsIBwgVcxzSAkBnPn2DObm49UiWBltOEs8O9zT5SMHu8iJPRKOahflfVXvVOg0Tl
         U12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687952856; x=1690544856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTx6dc94v45Ci191SZrpBnP46s4McjqVM14Xcmp+cwA=;
        b=OCcdmhxN3rk8llwi5sKF23fvNv5A60wJWc9/GSIIcwKO1CADd9E/4sxyzEgae6IZgH
         ilRWugaA1NYe9MJHgUFxwytU4fdXz5NwAE/eVmiyfZy464z4lf6kfVr85i3pUaaVqZe1
         2KfVUgxirBT6t29tE8M6XSAMzUu+r+qO9uWuYf8QkFgySYbLBVyOk6vvLTbrQ22SQndV
         OInfuc9XvfIRJAVamlpiE9oz4XztJE6HDxCxRNAJ1ojgfHuktGp7GaFmFTe8YG9kH3Fh
         Xjfdcpe71BKK8IeKuQ/3+7Xo6ic2K8TgMktcqSw24KxECWM9vbZD6468lNCZdMvLT96n
         66Qg==
X-Gm-Message-State: AC+VfDyEAyE5tJ0n6/6rRhm2QFaXDnX9yZCJC1SM0D3pJmsYoEpEkRqq
        obe8q9bk2oHtfT+T1uEbY4GsrVNDh5LtSxJTEuY=
X-Google-Smtp-Source: ACHHUZ4Bsud4xzdHL5UUZqC9ssBS5SLCGQ8rC4W6QQKwZA2T3g1I1MyE8OOTipwDRUkmxCFWUXXrjEKsNfK3EGOYZpw=
X-Received: by 2002:a67:ee4d:0:b0:440:ae17:f86b with SMTP id
 g13-20020a67ee4d000000b00440ae17f86bmr15120248vsp.12.1687952856502; Wed, 28
 Jun 2023 04:47:36 -0700 (PDT)
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
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com> <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
In-Reply-To: <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Jun 2023 13:47:24 +0200
Message-ID: <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 11:06=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> Hello,
>
> On Wed, 2023-06-28 at 09:37 +0200, Ian Kumlien wrote:
> > Been running all night but eventually it crashed again...
> >
> > [21753.055795] Out of memory: Killed process 970 (qemu-system-x86)
> > total-vm:4709488kB, anon-rss:2172652kB, file-rss:4608kB,
> > shmem-rss:0kB, UID:77 pgtables:4800kB oom_score_adj:0
> > [24249.061154] general protection fault, probably for non-canonical
> > address 0xb0746d4e6bee35e2: 0000 [#1] PREEMPT SMP NOPTI
> > [24249.072138] CPU: 0 PID: 893 Comm: napi/eno1-68 Tainted: G        W
> >         6.4.0-dirty #366
> > [24249.080670] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
> > BIOS 1.7a 10/13/2022
> > [24249.088852] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> > mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > [24249.094086] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> > 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> > 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
> > 89 17
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
> >    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4b=
db1
> >    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
> >   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x=
47e36001
> >   18: 47
> >   19: 9c                    pushf
> >   1a: 5e                    pop    %rsi
> >   1b: fa                    cli
> >   1c: 45 31 d2              xor    %r10d,%r10d
> >   1f: eb 2f                jmp    0x50
> >   21: 8b 45 28              mov    0x28(%rbp),%eax
> >   24: 48 01 d0              add    %rdx,%rax
> >   27: 48 89 c7              mov    %rax,%rdi
> >   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instructio=
n
> >   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> >   34: 48 0f cf              bswap  %rdi
> >   37: 48 31 f8              xor    %rdi,%rax
> >   3a: 48 89 01              mov    %rax,(%rcx)
> >   3d: 49 89 17              mov    %rdx,(%r15)
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 8b 00              mov    (%rax),%rax
> >    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> >    a: 48 0f cf              bswap  %rdi
> >    d: 48 31 f8              xor    %rdi,%rax
> >   10: 48 89 01              mov    %rax,(%rcx)
> >   13: 49 89 17              mov    %rdx,(%r15)
> > [24249.112951] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> > [24249.118275] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5=
a2fa31da0
> > [24249.125501] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4=
e6bee35e2
> > [24249.132730] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d5=
6ede0e67a
> > [24249.139958] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 0000000=
000000010
> > [24249.147187] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5=
a2fa2a818
> > [24249.154415] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> > knlGS:0000000000000000
> > [24249.162620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [24249.168471] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 0000000=
0003526f0
> > [24249.175717] Call Trace:
> > [24249.178268]  <TASK>
> > [24249.180476] ? die_addr (arch/x86/kernel/dumpstack.c:421
> > arch/x86/kernel/dumpstack.c:460)
> > [24249.183907] ? exc_general_protection (arch/x86/kernel/traps.c:783
> > arch/x86/kernel/traps.c:728)
> > [24249.188726] ? asm_exc_general_protection
> > (./arch/x86/include/asm/idtentry.h:564)
> > [24249.193720] ? kmem_cache_alloc_bulk (mm/slub.c:377 mm/slub.c:388
> > mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > [24249.198361] ? netif_receive_skb_list_internal (net/core/dev.c:5729)
> > [24249.203960] napi_skb_cache_get (net/core/skbuff.c:338)
> > [24249.208078] __napi_build_skb (net/core/skbuff.c:517)
> > [24249.211934] napi_build_skb (net/core/skbuff.c:541)
> > [24249.215616] ixgbe_poll
> > (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2165
> > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2361
> > drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
> > [24249.219305] __napi_poll (net/core/dev.c:6498)
> > [24249.222905] napi_threaded_poll (./include/linux/netpoll.h:89
> > net/core/dev.c:6640)
> > [24249.227197] ? __napi_poll (net/core/dev.c:6625)
> > [24249.231050] kthread (kernel/kthread.c:379)
> > [24249.234300] ? kthread_complete_and_exit (kernel/kthread.c:332)
> > [24249.239207] ret_from_fork (arch/x86/entry/entry_64.S:314)
> > [24249.242892]  </TASK>
> > [24249.245185] Modules linked in: chaoskey
> > [24249.249133] ---[ end trace 0000000000000000 ]---
> > [24249.270157] pstore: backend (erst) writing error (-28)
> > [24249.275408] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
> > mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
> > [24249.280660] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
> > 00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
> > 48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
> > 89 17
> > All code
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
> >    6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4b=
db1
> >    d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
> >   11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x=
47e36001
> >   18: 47
> >   19: 9c                    pushf
> >   1a: 5e                    pop    %rsi
> >   1b: fa                    cli
> >   1c: 45 31 d2              xor    %r10d,%r10d
> >   1f: eb 2f                jmp    0x50
> >   21: 8b 45 28              mov    0x28(%rbp),%eax
> >   24: 48 01 d0              add    %rdx,%rax
> >   27: 48 89 c7              mov    %rax,%rdi
> >   2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instructio=
n
> >   2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> >   34: 48 0f cf              bswap  %rdi
> >   37: 48 31 f8              xor    %rdi,%rax
> >   3a: 48 89 01              mov    %rax,(%rcx)
> >   3d: 49 89 17              mov    %rdx,(%r15)
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >    0: 48 8b 00              mov    (%rax),%rax
> >    3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
> >    a: 48 0f cf              bswap  %rdi
> >    d: 48 31 f8              xor    %rdi,%rax
> >   10: 48 89 01              mov    %rax,(%rcx)
> >   13: 49 89 17              mov    %rdx,(%r15)
> > [24249.299578] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
> > [24249.304917] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5=
a2fa31da0
> > [24249.312161] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4=
e6bee35e2
> > [24249.319407] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d5=
6ede0e67a
> > [24249.326651] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 0000000=
000000010
> > [24249.333896] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5=
a2fa2a818
> > [24249.341141] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
> > knlGS:0000000000000000
> > [24249.349356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [24249.355206] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 0000000=
0003526f0
> > [24249.362452] Kernel panic - not syncing: Fatal exception in interrupt
> > [24249.566854] Kernel Offset: 0x36e00000 from 0xffffffff81000000
> > (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> > [24249.594124] ---[ end Kernel panic - not syncing: Fatal exception in
> > interrupt ]---
> >
> > It's also odd that i get a OOM - it only seems to happen when i enable
> > rx-gro-list
>
> Unfortunately, not the result I was looking for. That leads to more
> questions then answer, I'm sorry.

I understand you...

> How long did the host keep going with rx-gro-list enabled?

Well, hours...

reboot   system boot  6.4.0-dirty      Wed Jun 28 04:20 - 13:39  (09:19)
reboot   system boot  6.4.0-dirty      Tue Jun 27 21:31 - 13:39  (16:08)

So, lets imagine a few seconds to login and enable everything

> Did you observe the WARN_ON() introduced by the tentative fix?

I could only see the console, so saw nothing...

> > - it's also odd because this machine always has ~8GB of
> > memory available
>
> It looks like there is a memory leak somewhere, and I don't think the
> tentative fixup introduced such issue.

I agree, it was there before...

> It looks like the above splat is due to a slab corruption, which in
> turn could be unrelated from the mentioned leak, but it could/should
> be related to rx-gro-list.

Agreed =3D)

> Could you please run the test with both kmemleak and kasan enabled?

Machine-slowdown-enabled^tm

> Additionally could you please disclose if you have non trivial
> netfilter and/or bridge filter and/or tc rules possibly modifying the
> incoming/egress packets?

I only have basic reject accept rules, some snat/dnat pairs, but i
don't see it ending up in "non trivial" ;)

> If kasan is not an option, could you please apply the debug the patch
> below? (on top of the previous one)

I actually did both, if it's unrelated we should know as well..

I hope i have something for you before tomorrow, else there will be a
bit of a break until next week

> Thanks!
>
> Paolo
> ---
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 6c5915efbc17..94adca27b205 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4295,6 +4295,8 @@ struct sk_buff *skb_segment_list(struct sk_buff *sk=
b,
>                 delta_len +=3D nskb->len;
>
>                 skb_push(nskb, -skb_network_offset(nskb) + offset);
> +               if (WARN_ON_ONCE(nskb->data - skb->head > skb->tail))
> +                       goto err_linearize;
>
>                 skb_release_head_state(nskb);
>                 len_diff =3D skb_network_header_len(nskb) - skb_network_h=
eader_len(skb);
> @@ -4302,6 +4304,11 @@ struct sk_buff *skb_segment_list(struct sk_buff *s=
kb,
>
>                 skb_headers_offset_update(nskb, skb_headroom(nskb) - skb_=
headroom(skb));
>                 nskb->transport_header +=3D len_diff;
> +               if (WARN_ON_ONCE(tnl_hlen > skb_headroom(nskb)))
> +                       goto err_linearize;
> +               if (WARN_ON_ONCE(skb_headroom(nskb) + offset > nskb->tail=
))
> +                       goto err_linearize;
> +
>                 skb_copy_from_linear_data_offset(skb, -tnl_hlen,
>                                                  nskb->data - tnl_hlen,
>                                                  offset + tnl_hlen);
>
>
