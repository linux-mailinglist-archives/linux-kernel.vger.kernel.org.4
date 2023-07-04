Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F5B747499
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjGDO6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGDO6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 10:58:04 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71CE7B;
        Tue,  4 Jul 2023 07:58:02 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so1791204241.1;
        Tue, 04 Jul 2023 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688482681; x=1691074681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ODX34hyqO/7r7NJj5q8DX0j6M0pSV7j2Y9cBKgIG6Q=;
        b=K3v2yMo6niiS9lolJ8DRceYZo8ofJ3UulSIrX2wEx5DsGzFOU0TQTFOoNVIxw2XRXT
         jUTtJWGVkg28ofKBweh4b9KLmnn6iT02zRwLDxZ4ia//uNycgBr8tt8BnFEX+D3oyKNz
         plaTbRepUwXgSMIGpNIjQMZFVVxZTr7XR4xbSjwhiJyUcnTchN2p0lXcYb7r/trEtk5Q
         DY1op0FqEiKHSw5ESj9sfunsmPngcz/dAQRLbK7BEl3cEz5YyGr37RBK7mStMd6P1hJg
         X2hMGpzF2zZjurPQiPh2OB5Wt/a+PG9f9xvlv8psKNeUxoMjE0SuuC5zW5de0JNlVOtl
         rYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688482681; x=1691074681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ODX34hyqO/7r7NJj5q8DX0j6M0pSV7j2Y9cBKgIG6Q=;
        b=Me+TV94251626qbFkQGaatIdBX4nEYYuiYZCZcXRPKV95DMsvihubGUGHxBeGqgjRg
         OgmrdR6OLHrADsQbggT/DbCYm8phzagnwO6//UVxQwt6Adf329j7Jw/1LuX1oyWWt9gT
         TXffeW1+WbkxVUCL2T4swlZRukQynP1xXEPprXC4twHimcemIW0WNMX8MLooBZN8piJw
         s7kXy7CQYSTNdgyH1Yb+loQZpTITPvipCwnW59qtNkZOozrgEoR0+xs+gsvpxNHJQlUV
         r5nyX3TibbOJfn2Jq9qHVFDSOUndWJdwxXO8hDEEiyOu2RNNG33/6zSq6/f7DJn4mSqx
         F0lQ==
X-Gm-Message-State: ABy/qLYmk1Ymkbi+2513gs/zYMyeS26EJQwrFEN8AcLnhd3pXj+kIoyj
        gYZs8/e+8AB6W3sQK4IBwxMc0uUgfQUaNUq7gw4ZjhIyBQlr3w==
X-Google-Smtp-Source: APBJJlEpLGT+lNSxjOq/bdnTJfTaIUMHyTwC4K2kM25fN3mk2JUEBEhKkq/46pJMD80fXGDrfUy8VTR5SzO46paZgXA=
X-Received: by 2002:a67:fa51:0:b0:444:eedd:1aec with SMTP id
 j17-20020a67fa51000000b00444eedd1aecmr2620291vsq.30.1688482681271; Tue, 04
 Jul 2023 07:58:01 -0700 (PDT)
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
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
 <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
 <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
 <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
 <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com> <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
In-Reply-To: <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Tue, 4 Jul 2023 16:57:49 +0200
Message-ID: <CAA85sZssQvnTYK4BZfH3_wSpOvwyE35rCLwLchCqLtu_wf_nzw@mail.gmail.com>
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

And I kept it running, to see if we could end up with the same bug as
last time and it seems we did but now with more info =3D)

cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
[ 2061.424044] __skb_pull(len=3D54)
[ 2061.427257] skb len=3D91 headroom=3D192 headlen=3D153 tailroom=3D0
mac=3D(192,14) net=3D(206,40) trans=3D246
shinfo(txflags=3D0 nr_frags=3D0 gso(size=3D0 type=3D0 segs=3D0))
csum(0x0 ip_summed=3D1 complete_sw=3D0 valid=3D1 level=3D0)
hash(0x75d99cb2 sw=3D0 l4=3D0) proto=3D0x86dd pkttype=3D2 iif=3D15
[ 2061.455894] dev name=3Dlocal-lan feat=3D0x00002003bfdd78e9
[ 2061.461179] skb linear:   00000000: 33 33 00 00 00 fb c8 7f 54 b1
7d f8 86 dd 60 05
[ 2061.468982] skb linear:   00000010: 1d 4c 00 25 11 ff fe 80 00 00
00 00 00 00 ca 7f
[ 2061.476788] skb linear:   00000020: 54 ff fe b1 7d f8 ff 02 00 00
00 00 00 00 00 00
[ 2061.484585] skb linear:   00000030: 00 00 00 00 00 fb 14 e9 14 e9
00 63 90 15 00 00
[ 2061.492382] skb linear:   00000040: 00 00 00 01 00 00 00 00 00 00
32 53 48 49 45 4c
[ 2061.500180] skb linear:   00000050: 44 2d 41 6e 64 72 6f 69 64 2d 54
[ 2061.506809] ------------[ cut here ]------------
[ 2061.506822] kernel BUG at include/linux/skbuff.h:2645!
[ 2061.512109] invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[ 2061.517979] CPU: 4 PID: 942 Comm: napi/eno2-87 Tainted: G    B   W
        6.4.1-dirty #375
[ 2061.526572] Hardware name: Supermicro Super Server/A2SDi-12C-HLN4F,
BIOS 1.7a 10/13/2022
[ 2061.534807] RIP: 0010:udpv6_queue_rcv_skb
(./include/linux/skbuff.h:2645 net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2061.539997] Code: 40 fd e9 f6 fb ff ff 89 73 70 48 c7 c7 80 77 e6
b5 44 89 c6 e8 3e 72 ef fc 31 d2 48 89 de 48 c7 c7 c0 77 e6 b5 e8 4d
e2 74 ff <0f> 0b 0f 0b e9 51 fd ff ff 0f 0b e9 1c fe ff ff 48 b8 00 00
00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 40 fd                rex std
   2: e9 f6 fb ff ff        jmp    0xfffffffffffffbfd
   7: 89 73 70              mov    %esi,0x70(%rbx)
   a: 48 c7 c7 80 77 e6 b5 mov    $0xffffffffb5e67780,%rdi
  11: 44 89 c6              mov    %r8d,%esi
  14: e8 3e 72 ef fc        call   0xfffffffffcef7257
  19: 31 d2                xor    %edx,%edx
  1b: 48 89 de              mov    %rbx,%rsi
  1e: 48 c7 c7 c0 77 e6 b5 mov    $0xffffffffb5e677c0,%rdi
  25: e8 4d e2 74 ff        call   0xffffffffff74e277
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: 0f 0b                ud2
  2e: e9 51 fd ff ff        jmp    0xfffffffffffffd84
  33: 0f 0b                ud2
  35: e9 1c fe ff ff        jmp    0xfffffffffffffe56
  3a: 48                    rex.W
  3b: b8 00 00 00 00        mov    $0x0,%eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 0f 0b                ud2
   4: e9 51 fd ff ff        jmp    0xfffffffffffffd5a
   9: 0f 0b                ud2
   b: e9 1c fe ff ff        jmp    0xfffffffffffffe2c
  10: 48                    rex.W
  11: b8 00 00 00 00        mov    $0x0,%eax
[ 2061.558949] RSP: 0018:ffff888112cd6ef0 EFLAGS: 00010286
[ 2061.564307] RAX: 0000000000000000 RBX: ffff88812623d040 RCX: ffffffffb31=
8313a
[ 2061.571567] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888112c=
d6ab8
[ 2061.578832] RBP: 0000000000000036 R08: 0000000000000001 R09: ffff888112c=
d6abf
[ 2061.586094] R10: ffffed102259ad57 R11: 000000000000005b R12: ffff88813ac=
9d080
[ 2061.593356] R13: dffffc0000000000 R14: ffff8881156cc0c0 R15: ffff88810c2=
87540
[ 2061.600619] FS:  0000000000000000(0000) GS:ffff8883ef400000(0000)
knlGS:0000000000000000
[ 2061.608861] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2061.614737] CR2: 00007ff4c106066c CR3: 000000011c2f8000 CR4: 00000000003=
526e0
[ 2061.621999] Call Trace:
[ 2061.624568]  <TASK>
[ 2061.626783] ? die (arch/x86/kernel/dumpstack.c:421
arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
[ 2061.629799] ? do_trap (arch/x86/kernel/traps.c:124
arch/x86/kernel/traps.c:165)
[ 2061.633326] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2061.637905] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2061.642479] ? handle_invalid_op (arch/x86/kernel/traps.c:88
arch/x86/kernel/traps.c:186 arch/x86/kernel/traps.c:297)
[ 2061.646708] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2061.651283] ? exc_invalid_op (arch/x86/kernel/traps.c:352)
[ 2061.655253] ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:568)
[ 2061.659571] ? llist_add_batch (lib/llist.c:33 (discriminator 14))
[ 2061.663713] ? udpv6_queue_rcv_skb (./include/linux/skbuff.h:2645
net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2061.668290] __udp6_lib_rcv (net/ipv6/udp.c:906 net/ipv6/udp.c:1013)
[ 2061.672433] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[ 2061.677006] ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:439
(discriminator 4))
[ 2061.681932] ip6_input_finish (./include/linux/rcupdate.h:805
net/ipv6/ip6_input.c:483)
[ 2061.685986] ip6_input (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:491)
[ 2061.689434] ? ip6_input_finish (net/ipv6/ip6_input.c:490)
[ 2061.693749] ? fib6_select_path (./include/net/nexthop.h:515
net/ipv6/route.c:435)
[ 2061.698067] ? ip6_protocol_deliver_rcu
(./include/linux/skbuff.h:4180 net/ipv6/ip6_input.c:480)
[ 2061.703256] ? ipv6_chk_mcast_addr (net/ipv6/mcast.c:1048)
[ 2061.707834] ip6_mc_input (net/ipv6/ip6_input.c:591)
[ 2061.711629] ? ip6_rcv_finish (net/ipv6/ip6_input.c:498)
[ 2061.715775] ipv6_rcv (./include/net/dst.h:468
net/ipv6/ip6_input.c:79 ./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/ipv6/ip6_input.c:309)
[ 2061.719222] ? ip6_input (net/ipv6/ip6_input.c:303)
[ 2061.722928] ? ipv6_mc_validate_checksum (net/ipv6/mcast_snoop.c:173)
[ 2061.728025] ? ipv6_list_rcv (./include/net/l3mdev.h:169
./include/net/l3mdev.h:190 net/ipv6/ip6_input.c:74)
[ 2061.732081] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:55)
[ 2061.736918] ? ip6_input (net/ipv6/ip6_input.c:303)
[ 2061.740627] __netif_receive_skb_one_core (net/core/dev.c:5486)
[ 2061.745812] ? __netif_receive_skb_list_core (net/core/dev.c:5486)
[ 2061.751260] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[ 2061.755144] ? br_forward_finish (./include/linux/netfilter.h:303
./include/linux/netfilter.h:297 net/bridge/br_forward.c:66)
[ 2061.759459] netif_receive_skb (net/core/dev.c:5693 net/core/dev.c:5752)
[ 2061.763687] ? __netif_receive_skb (net/core/dev.c:5747)
[ 2061.768265] ? br_multicast_set_startup_query_intvl
(net/bridge/br_multicast.c:5014)
[ 2061.774148] ? br_fdb_offloaded_set (net/bridge/br_forward.c:34)
[ 2061.778637] ? nf_hook_slow (./include/linux/netfilter.h:143
net/netfilter/core.c:626)
[ 2061.782521] br_pass_frame_up (net/bridge/br_input.c:30
./include/linux/netfilter.h:303 ./include/linux/netfilter.h:297
net/bridge/br_input.c:68)
[ 2061.786663] ? br_netif_receive_skb (net/bridge/br_input.c:34)
[ 2061.791153] ? br_multicast_flood (net/bridge/br_forward.c:126
net/bridge/br_forward.c:336)
[ 2061.795728] ? br_dev_queue_push_xmit (net/bridge/br_forward.c:64)
[ 2061.800566] br_handle_frame_finish (net/bridge/br_input.c:216)
[ 2061.805314] ? br_handle_local_finish (net/bridge/br_input.c:75)
[ 2061.809977] ? br_nf_post_routing
(net/bridge/br_netfilter_hooks.c:116
net/bridge/br_netfilter_hooks.c:837)
[ 2061.814553] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[ 2061.819733] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[ 2061.824916] ? br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[ 2061.829232] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1=
106)
[ 2061.834330] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[ 2061.839338] ? br_nf_pre_routing_finish (net/bridge/br_netfilter_hooks.c:=
481)
[ 2061.844522] br_handle_frame (net/bridge/br_input.c:298
net/bridge/br_input.c:416)
[ 2061.848742] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[ 2061.853757] ? reuseport_select_sock (net/core/sock_reuseport.c:573)
[ 2061.858508] ? br_handle_local_finish (net/bridge/br_input.c:75)
[ 2061.863170] ? packet_rcv (net/packet/af_packet.c:2231)
[ 2061.867045] __netif_receive_skb_core.constprop.0 (net/core/dev.c:5387)
[ 2061.873017] ? br_handle_frame_finish (net/bridge/br_input.c:321)
[ 2061.878026] ? udp6_lib_lookup2 (net/ipv6/udp.c:199)
[ 2061.882339] ? do_xdp_generic (net/core/dev.c:5281)
[ 2061.886484] ? __udp6_lib_lookup (net/ipv6/udp.c:276)
[ 2061.890889] __netif_receive_skb_list_core (net/core/dev.c:5570)
[ 2061.896165] ? ipv6_portaddr_hash.isra.0 (net/ipv4/inet_hashtables.c:300)
[ 2061.901260] ? udp_push_pending_frames (net/ipv4/udp.c:495)
[ 2061.906010] ? __napi_poll (net/core/dev.c:6498)
[ 2061.909805] ? napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[ 2061.914294] ? kthread (kernel/kthread.c:379)
[ 2061.917830] ? __netif_receive_skb_core.constprop.0 (net/core/dev.c:5546)
[ 2061.924065] ? recalibrate_cpu_khz (./arch/x86/include/asm/msr.h:215
arch/x86/kernel/tsc.c:1110)
[ 2061.928464] ? ktime_get_with_offset (kernel/time/timekeeping.c:292
(discriminator 3) kernel/time/timekeeping.c:388 (discriminator 3)
kernel/time/timekeeping.c:891 (discriminator 3))
[ 2061.933128] netif_receive_skb_list_internal (net/core/dev.c:5638
net/core/dev.c:5727)
[ 2061.938580] ? ipv6_gro_receive (net/ipv6/ip6_offload.c:281 (discriminato=
r 7))
[ 2061.942980] ? process_backlog (net/core/dev.c:5699)
[ 2061.947212] ? napi_gro_complete.constprop.0 (net/core/gro.c:321)
[ 2061.952662] ? napi_gro_flush (./arch/x86/include/asm/bitops.h:94
./include/asm-generic/bitops/instrumented-non-atomic.h:45
net/core/gro.c:346 net/core/gro.c:361)
[ 2061.956804] ? dev_gro_receive (./arch/x86/include/asm/bitops.h:228
(discriminator 8) ./arch/x86/include/asm/bitops.h:240 (discriminator
8) ./include/asm-generic/bitops/instrumented-non-atomic.h:142
(discriminator 8) net/core/gro.c:580 (discriminator 8))
[ 2061.961121] napi_complete_done (./include/linux/list.h:37
./include/net/gro.h:434 ./include/net/gro.h:429 net/core/dev.c:6067)
[ 2061.965437] ? napi_busy_loop (net/core/dev.c:6034)
[ 2061.969579] ixgbe_poll (drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:31=
91)
[ 2061.973379] ? ixgbe_xdp_ring_update_tail_locked
(drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:3141)
[ 2061.978998] ? common_interrupt (arch/x86/kernel/irq.c:240)
[ 2061.983140] ? asm_sysvec_call_function_single
(./arch/x86/include/asm/idtentry.h:653)
[ 2061.988596] __napi_poll (net/core/dev.c:6498)
[ 2061.992217] napi_threaded_poll (./include/linux/netpoll.h:89
net/core/dev.c:6640)
[ 2061.996534] ? __napi_poll (net/core/dev.c:6625)
[ 2062.000411] ? migrate_enable (kernel/sched/core.c:3045)
[ 2062.004557] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207
./arch/x86/include/asm/bitops.h:239
./include/asm-generic/bitops/instrumented-non-atomic.h:142
kernel/kthread.c:271)
[ 2062.008784] ? __napi_poll (net/core/dev.c:6625)
[ 2062.012658] kthread (kernel/kthread.c:379)
[ 2062.016014] ? kthread_complete_and_exit (kernel/kthread.c:336)
[ 2062.020935] ret_from_fork (arch/x86/entry/entry_64.S:314)
[ 2062.024640]  </TASK>
[ 2062.026950] Modules linked in: chaoskey
[ 2062.031016] ---[ end trace 0000000000000000 ]---
[ 2062.072482] pstore: backend (erst) writing error (-28)
[ 2062.077802] RIP: 0010:udpv6_queue_rcv_skb
(./include/linux/skbuff.h:2645 net/ipv6/udp.c:798 net/ipv6/udp.c:787)
[ 2062.083036] Code: 40 fd e9 f6 fb ff ff 89 73 70 48 c7 c7 80 77 e6
b5 44 89 c6 e8 3e 72 ef fc 31 d2 48 89 de 48 c7 c7 c0 77 e6 b5 e8 4d
e2 74 ff <0f> 0b 0f 0b e9 51 fd ff ff 0f 0b e9 1c fe ff ff 48 b8 00 00
00 00
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: 40 fd                rex std
   2: e9 f6 fb ff ff        jmp    0xfffffffffffffbfd
   7: 89 73 70              mov    %esi,0x70(%rbx)
   a: 48 c7 c7 80 77 e6 b5 mov    $0xffffffffb5e67780,%rdi
  11: 44 89 c6              mov    %r8d,%esi
  14: e8 3e 72 ef fc        call   0xfffffffffcef7257
  19: 31 d2                xor    %edx,%edx
  1b: 48 89 de              mov    %rbx,%rsi
  1e: 48 c7 c7 c0 77 e6 b5 mov    $0xffffffffb5e677c0,%rdi
  25: e8 4d e2 74 ff        call   0xffffffffff74e277
  2a:* 0f 0b                ud2    <-- trapping instruction
  2c: 0f 0b                ud2
  2e: e9 51 fd ff ff        jmp    0xfffffffffffffd84
  33: 0f 0b                ud2
  35: e9 1c fe ff ff        jmp    0xfffffffffffffe56
  3a: 48                    rex.W
  3b: b8 00 00 00 00        mov    $0x0,%eax

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 0f 0b                ud2
   2: 0f 0b                ud2
   4: e9 51 fd ff ff        jmp    0xfffffffffffffd5a
   9: 0f 0b                ud2
   b: e9 1c fe ff ff        jmp    0xfffffffffffffe2c
  10: 48                    rex.W
  11: b8 00 00 00 00        mov    $0x0,%eax
[ 2062.102033] RSP: 0018:ffff888112cd6ef0 EFLAGS: 00010286
[ 2062.107428] RAX: 0000000000000000 RBX: ffff88812623d040 RCX: ffffffffb31=
8313a
[ 2062.114722] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff888112c=
d6ab8
[ 2062.122033] RBP: 0000000000000036 R08: 0000000000000001 R09: ffff888112c=
d6abf
[ 2062.129329] R10: ffffed102259ad57 R11: 000000000000005b R12: ffff88813ac=
9d080
[ 2062.136629] R13: dffffc0000000000 R14: ffff8881156cc0c0 R15: ffff88810c2=
87540
[ 2062.143937] FS:  0000000000000000(0000) GS:ffff8883ef400000(0000)
knlGS:0000000000000000
[ 2062.152211] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2062.158120] CR2: 00007ff4c106066c CR3: 000000011c2f8000 CR4: 00000000003=
526e0
[ 2062.165415] Kernel panic - not syncing: Fatal exception in interrupt



On Tue, Jul 4, 2023 at 4:27=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com> =
wrote:
>
> More stacktraces.. =3D)
>

[--8<--]

>
> On Tue, Jul 4, 2023 at 4:06=E2=80=AFPM Ian Kumlien <ian.kumlien@gmail.com=
> wrote:
> >
> > On Tue, Jul 4, 2023 at 3:41=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> =
wrote:
> > >
> > > On Tue, 2023-07-04 at 15:23 +0200, Ian Kumlien wrote:
> > > > On Tue, Jul 4, 2023 at 2:54=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On Tue, 2023-07-04 at 13:36 +0200, Ian Kumlien wrote:
> > > > > > Propper bug this time:
> > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > >
> > > > > To be sure, is this with the last patch I shared? this one I mean=
:
> > > >
> > > > The current modifications I have, on top of v6.4.1, is:
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index cea28d30abb5..8552caa197f9 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -4272,6 +4272,11 @@ struct sk_buff *skb_segment_list(struct sk_b=
uff *skb,
> > > >
> > > >         skb_shinfo(skb)->frag_list =3D NULL;
> > > >
> > > > +       /* later code will clear the gso area in the shared info */
> > > > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > > > +       if (err)
> > > > +               goto err_linearize;
> > > > +
> > > >         while (list_skb) {
> > > >                 nskb =3D list_skb;
> > > >                 list_skb =3D list_skb->next;
> > > > @@ -4328,6 +4333,9 @@ struct sk_buff *skb_segment_list(struct sk_bu=
ff *skb,
> > > >
> > > >         skb->prev =3D tail;
> > > >
> > > > +       if (WARN_ON_ONCE(!skb->next))
> > > > +               goto err_linearize;
> > > > +
> > > >         if (skb_needs_linearize(skb, features) &&
> > > >             __skb_linearize(skb))
> > > >                 goto err_linearize;
> > > > ---
> > > >
> > > > > https://lore.kernel.org/netdev/92a4d42491a2c219192ae86fa04b579ea3=
676d8c.camel@redhat.com/
> > > > >
> > > > > Could you please additionally enable CONFIG_DEBUG_NET in your bui=
ld?
> > > >
> > > > Sure, will do
> > > >
> > > > > Could you please give a detailed description of your network topo=
logy
> > > > > and the running traffic?
> > > >
> > > > This machine has two "real interfaces" and two interfaces that runs=
 as
> > > > bridges for virtual machines
> > > > eno1 - real internal
> > > > eno2 - bridge - internal
> > > > eno3 - real external
> > > > eno4 - bridge - external
> > > >
> > > > The bridges are used by three virtual machines, two of which are
> > > > attached on both networks
> > > >
> > > > Traffic seemed to be video streaming, at least at first, now I don'=
t
> > > > really know. I do have a few smart devices so I assume there is
> > > > a bit of multicast traffic as well - but not really anything unusua=
l as such.
> > >
> > > In there any XDP program running on the host side? Possibly changing
> > > the packet hdr?
> >
> > Only systemd standard things, I haven't done anything and the normal
> > nftables fw doesn't do anything special
> >
> > > Thanks!
> > >
> > > /P
> > >
