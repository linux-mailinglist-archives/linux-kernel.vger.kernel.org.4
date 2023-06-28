Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D98740B12
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjF1IV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbjF1IOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:14:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA05AEC;
        Wed, 28 Jun 2023 01:10:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1095040276.1;
        Wed, 28 Jun 2023 01:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939814; x=1690531814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gthA2bxh1ALdjA679lX2ffhR0V7dWD46XCi2JVRa+TU=;
        b=g0v2B8nR1G3ilkdffZxyeQAU9O67cM3emPiKbDjFIkuNT//Oi2YxaphArEtIzYFFuC
         e3A6lbF5cFcim3rTnsnu9qt3MEzwEiIiHXjMUqqZPz4WHUZsFtYSNMON13dLxlU74htK
         /DvrpOEcIFz27FIM+u7/nvwZCL0B1Pch3R/xqVzsVDLJtX/ZvDh94iOoCFuhIYVOTlw0
         XEhYZu8FNVDKsTw9nAeWG6nSIQJxJx0GVMOSD4loBww4mnGSipFAem8Vas3tJW0vyd8A
         JzjWt3Uo89m8nmiCJnrPwq8N17IC+e+93Q87HlxlgGrZfQ/xchF2IawTqHnDYsNniXt+
         SoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939814; x=1690531814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gthA2bxh1ALdjA679lX2ffhR0V7dWD46XCi2JVRa+TU=;
        b=GOINBNxuX9orYyjyziEGWLL9as5s42pNPj1LHCB1pZu3SlI1Y0bGdLPapVRLR7RSc7
         Hfr4+m1DAuaZxge9EO9QeLxcnxGd/tSCoIZW2s3vjU6To8pIGNTOUkquAH40RDvSDJ1N
         b5ODK9HnHwFcY9fQzseA4NslKkdF9kcCxr/AsAT9xe2Kz8FgprInsfBQZ/nfq5OdYm8O
         0fI+2E3TJBt4FzmAkUGfmSjY7x0ImVHAetYPBRXVKaK7ttwKRoVLtgctfGGQwjiTYacj
         L7xXX5zF/TlcbfXXm01PDZYAA3KPn+do6kiLl7P8zzTfuevVZ54xA0JtqpybCjqy7MBO
         ltRg==
X-Gm-Message-State: ABy/qLY7gNuQk5lVT+k9Hp8wOeMtWTecJb6VsI0ScOTMuAbvvoj86wau
        RTujFPimKcymQfiW9zsisGqwKhyulardYdYOOKSpwm9uUiJprA==
X-Google-Smtp-Source: ACHHUZ4YZvDhIhtZL7GDSoSAH1UzpBI16bC9x8EZyLozwYw+xfsxgFK0IqAFovttCdoib63Lid7qoxBV5+NihfJu94I=
X-Received: by 2002:a05:6102:cd:b0:443:629b:efec with SMTP id
 u13-20020a05610200cd00b00443629befecmr187834vsp.14.1687937860974; Wed, 28 Jun
 2023 00:37:40 -0700 (PDT)
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
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com> <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
In-Reply-To: <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Wed, 28 Jun 2023 09:37:28 +0200
Message-ID: <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
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

Been running all night but eventually it crashed again...

[21753.055795] Out of memory: Killed process 970 (qemu-system-x86)
total-vm:4709488kB, anon-rss:2172652kB, file-rss:4608kB,
shmem-rss:0kB, UID:77 pgtables:4800kB oom_score_adj:0
[24249.061154] general protection fault, probably for non-canonical
address 0xb0746d4e6bee35e2: 0000 [#1] PREEMPT SMP NOPTI
[24249.072138] CPU: 0 PID: 893 Comm: napi/eno1-68 Tainted: G        W
        6.4.0-dirty #366
[24249.080670] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[24249.088852] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
[24249.094086] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
89 17
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
   6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4bdb1
   d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
  11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x47e3=
6001
  18: 47
  19: 9c                    pushf
  1a: 5e                    pop    %rsi
  1b: fa                    cli
  1c: 45 31 d2              xor    %r10d,%r10d
  1f: eb 2f                jmp    0x50
  21: 8b 45 28              mov    0x28(%rbp),%eax
  24: 48 01 d0              add    %rdx,%rax
  27: 48 89 c7              mov    %rax,%rdi
  2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
  2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
  34: 48 0f cf              bswap  %rdi
  37: 48 31 f8              xor    %rdi,%rax
  3a: 48 89 01              mov    %rax,(%rcx)
  3d: 49 89 17              mov    %rdx,(%r15)

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 8b 00              mov    (%rax),%rax
   3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
   a: 48 0f cf              bswap  %rdi
   d: 48 31 f8              xor    %rdi,%rax
  10: 48 89 01              mov    %rax,(%rcx)
  13: 49 89 17              mov    %rdx,(%r15)
[24249.112951] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
[24249.118275] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5a2fa=
31da0
[24249.125501] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4e6be=
e35e2
[24249.132730] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d56ede=
0e67a
[24249.139958] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 00000000000=
00010
[24249.147187] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5a2fa=
2a818
[24249.154415] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
knlGS:0000000000000000
[24249.162620] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24249.168471] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 00000000003=
526f0
[24249.175717] Call Trace:
[24249.178268]  <TASK>
[24249.180476] ? die_addr (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:460)
[24249.183907] ? exc_general_protection (arch/x86/kernel/traps.c:783
arch/x86/kernel/traps.c:728)
[24249.188726] ? asm_exc_general_protection
(./arch/x86/include/asm/idtentry.h:564)
[24249.193720] ? kmem_cache_alloc_bulk (mm/slub.c:377 mm/slub.c:388
mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
[24249.198361] ? netif_receive_skb_list_internal (net/core/dev.c:5729)
[24249.203960] napi_skb_cache_get (net/core/skbuff.c:338)
[24249.208078] __napi_build_skb (net/core/skbuff.c:517)
[24249.211934] napi_build_skb (net/core/skbuff.c:541)
[24249.215616] ixgbe_poll
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2165
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2361
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3178)
[24249.219305] __napi_poll (net/core/dev.c:6498)
[24249.222905] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[24249.227197] ? __napi_poll (net/core/dev.c:6625)
[24249.231050] kthread (kernel/kthread.c:379)
[24249.234300] ? kthread_complete_and_exit (kernel/kthread.c:332)
[24249.239207] ret_from_fork (arch/x86/entry/entry_64.S:314)
[24249.242892]  </TASK>
[24249.245185] Modules linked in: chaoskey
[24249.249133] ---[ end trace 0000000000000000 ]---
[24249.270157] pstore: backend (erst) writing error (-28)
[24249.275408] RIP: 0010:kmem_cache_alloc_bulk (mm/slub.c:377
mm/slub.c:388 mm/slub.c:395 mm/slub.c:3963 mm/slub.c:4026)
[24249.280660] Code: 0f 84 46 ff ff ff 65 ff 05 a4 bd e4 47 48 8b 4d
00 65 48 03 0d e8 5f e3 47 9c 5e fa 45 31 d2 eb 2f 8b 45 28 48 01 d0
48 89 c7 <48> 8b 00 48 33 85 b8 00 00 00 48 0f cf 48 31 f8 48 89 01 49
89 17
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 84 46 ff ff ff    je     0xffffffffffffff4c
   6: 65 ff 05 a4 bd e4 47 incl   %gs:0x47e4bda4(%rip)        # 0x47e4bdb1
   d: 48 8b 4d 00          mov    0x0(%rbp),%rcx
  11: 65 48 03 0d e8 5f e3 add    %gs:0x47e35fe8(%rip),%rcx        # 0x47e3=
6001
  18: 47
  19: 9c                    pushf
  1a: 5e                    pop    %rsi
  1b: fa                    cli
  1c: 45 31 d2              xor    %r10d,%r10d
  1f: eb 2f                jmp    0x50
  21: 8b 45 28              mov    0x28(%rbp),%eax
  24: 48 01 d0              add    %rdx,%rax
  27: 48 89 c7              mov    %rax,%rdi
  2a:* 48 8b 00              mov    (%rax),%rax <-- trapping instruction
  2d: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
  34: 48 0f cf              bswap  %rdi
  37: 48 31 f8              xor    %rdi,%rax
  3a: 48 89 01              mov    %rax,(%rcx)
  3d: 49 89 17              mov    %rdx,(%r15)

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 48 8b 00              mov    (%rax),%rax
   3: 48 33 85 b8 00 00 00 xor    0xb8(%rbp),%rax
   a: 48 0f cf              bswap  %rdi
   d: 48 31 f8              xor    %rdi,%rax
  10: 48 89 01              mov    %rax,(%rcx)
  13: 49 89 17              mov    %rdx,(%r15)
[24249.299578] RSP: 0018:ffff9fc303973d20 EFLAGS: 00010086
[24249.304917] RAX: b0746d4e6bee35e2 RBX: 0000000000000001 RCX: ffff8d5a2fa=
31da0
[24249.312161] RDX: b0746d4e6bee3572 RSI: 0000000000000286 RDI: b0746d4e6be=
e35e2
[24249.319407] RBP: ffff8d56c016d500 R08: 0000000000000400 R09: ffff8d56ede=
0e67a
[24249.326651] R10: 0000000000000001 R11: ffff8d56c59d88c0 R12: 00000000000=
00010
[24249.333896] R13: 0000000000000820 R14: ffff8d5a2fa2a810 R15: ffff8d5a2fa=
2a818
[24249.341141] FS:  0000000000000000(0000) GS:ffff8d5a2fa00000(0000)
knlGS:0000000000000000
[24249.349356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[24249.355206] CR2: 00007f0f3f7f8760 CR3: 0000000102466000 CR4: 00000000003=
526f0
[24249.362452] Kernel panic - not syncing: Fatal exception in interrupt
[24249.566854] Kernel Offset: 0x36e00000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[24249.594124] ---[ end Kernel panic - not syncing: Fatal exception in
interrupt ]---

It's also odd that i get a OOM - it only seems to happen when i enable
rx-gro-list - it's also odd because this machine always has ~8GB of
memory available

On Tue, Jun 27, 2023 at 2:31=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com>=
 wrote:
>
> On Tue, Jun 27, 2023 at 11:19=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On Mon, 2023-06-26 at 20:59 +0200, Ian Kumlien wrote:
> > > On Mon, Jun 26, 2023 at 8:20=E2=80=AFPM Ian Kumlien <ian.kumlien@gmai=
l.com> wrote:
> > > >
> > > > Nevermind, I think I found it, I will loop this thing until I have =
a
> > > > proper trace....
> > >
> > > Still some question marks, but much better
> >
> > Thanks!
> > >
> > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > [   62.624003] BUG: kernel NULL pointer dereference, address: 0000000=
0000000c0
> > > [   62.631083] #PF: supervisor read access in kernel mode
> > > [   62.636312] #PF: error_code(0x0000) - not-present page
> > > [   62.641541] PGD 0 P4D 0
> > > [   62.644174] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [   62.648629] CPU: 1 PID: 913 Comm: napi/eno2-79 Not tainted 6.4.0 #=
364
> > > [   62.655162] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F=
,
> > > BIOS 1.7a 10/13/2022
> > > [   62.663344] RIP: 0010:__udp_gso_segment
> > > (./include/linux/skbuff.h:2858 ./include/linux/udp.h:23
> > > net/ipv4/udp_offload.c:228 net/ipv4/udp_offload.c:261
> > > net/ipv4/udp_offload.c:277)
> >
> > So it's faulting here:
> >
> > static struct sk_buff *__udpv4_gso_segment_list_csum(struct sk_buff *se=
gs)
> > {
> >         struct sk_buff *seg;
> >         struct udphdr *uh, *uh2;
> >         struct iphdr *iph, *iph2;
> >
> >         seg =3D segs;
> >         uh =3D udp_hdr(seg);
> >         iph =3D ip_hdr(seg);
> >
> >         if ((udp_hdr(seg)->dest =3D=3D udp_hdr(seg->next)->dest) &&
> >         // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > The GSO segment has been assembled by skb_gro_receive_list()
> > I guess seg->next is NULL, which is somewhat unexpected as
> > napi_gro_complete() clears the gso_size when sending up the stack a
> > single frame.
> >
> > On the flip side, AFAICS, nothing prevents the stack from changing the
> > aggregated packet layout (e.g. pulling data and/or linearizing the
> > skb).
> >
> > In any case this looks more related to rx-gro-list then rx-udp-gro-
> > forwarding. I understand you have both feature enabled in your env?
> >
> > Side questions: do you have any non trivial nf/br filter rule?
> >
> > The following could possibly validate the above and avoid the issue,
> > but it's a bit papering over it. Could you please try it in your env?
>
> Will do as soon as i get home =3D)
>
> > Thanks!
> >
> > Paolo
> > ---
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6c5915efbc17..75531686bfdf 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4319,6 +4319,9 @@ struct sk_buff *skb_segment_list(struct sk_buff *=
skb,
> >
> >         skb->prev =3D tail;
> >
> > +       if (WARN_ON_ONCE(!skb->next))
> > +               goto err_linearize;
> > +
> >         if (skb_needs_linearize(skb, features) &&
> >             __skb_linearize(skb))
> >                 goto err_linearize;
> >
