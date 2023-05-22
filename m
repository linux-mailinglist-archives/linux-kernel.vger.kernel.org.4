Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96070B8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjEVJVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbjEVJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:21:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F11BA8;
        Mon, 22 May 2023 02:21:29 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64d426e63baso2635941b3a.0;
        Mon, 22 May 2023 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684747289; x=1687339289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACoNmQvOBLI03cHbZFhao1SmDgf9m08H7ycQk19PbqY=;
        b=L2GDFTxrtJX+JmHcVxQt6FZS8HnPtjZ263mtmSvNEhDdqb7lU+5fylfFMiBPk8S1BH
         6jSn2WLDaNR+om8FmddVwxg+Ad9iucVaf/8Bc5ncmnBjMNWPaUDLtHTgoEkgnuI48Isl
         SKwyP4akQhKQUMViV4q8mLjaIPEbCbfH0G8kbGnpRBke53cpg73AZYV68UbekBDEAwjb
         R1FsAst8o7W5UvE12Q2cPVP7vzeERaBOEoS6Y5Dv6RFkiSEoVwpewXA4HLJZ8oExNhJx
         YODkyDj0QaL/chuKZ/cpTZgaO/LQ4dvd8cCwx+bwYAAp5OkEZZyWOAtPt/4LJ+pNAIRb
         kPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684747289; x=1687339289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACoNmQvOBLI03cHbZFhao1SmDgf9m08H7ycQk19PbqY=;
        b=lgOAuOzTv9yGvaEhiHyX0mpg5EzySv0QsTnZyGl6np/BSuDAkF4qAQvVioFRmIkd54
         fSpzARgOAM5Bp0gBB3dfF0zmNadW742fcf1DNtsERczE+2aedTJCypsdENExtoSQ6oLm
         5AlJK3SNFRHbs+HdKCIfRQDMFZLexNgxWqb22S1kWS91KZsMqPDmUtbae7NcLQzX6vnh
         Uy/Gx29+ajhp07OWa5AZ03DkecFBLuRDq5BcERqPX9pzISHQUE+9l9fiVyAiWxPj0f66
         fjz8m/vtb21MKOyfiZMFzDmtUrP1NWYCty8y8rzaEEl2pk8nnFVQVosoXCOYolgRPiaC
         3/Fw==
X-Gm-Message-State: AC+VfDw4sEymQfgSgFTgSgYQpqa7NZ3G4IoduTP/q3J+hk+h24Ll20KI
        c2AMvNQ6xm5CgJ11oBAZ1ddPX/GiHTKy90rUZxM=
X-Google-Smtp-Source: ACHHUZ5Khx/F+AeOswODP45PGC5ieM4yqrUUpkA7WcyvXeon4hMhEb8gPiDKAesPYklsbaWkDCJfcgh8b6hTf31oTM0=
X-Received: by 2002:a05:6a21:380e:b0:107:10b6:4c84 with SMTP id
 yi14-20020a056a21380e00b0010710b64c84mr8615394pzb.21.1684747288728; Mon, 22
 May 2023 02:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQoYRm3766SG7+VuwVzu_xH8aWihoKWMEp8xQGNgJ6oOtC9+g@mail.gmail.com>
 <CAAQoYRmXdMp7b2r+yCRUtGrbfQH-Cb8gMAVo7YscuQEM5kgajw@mail.gmail.com>
 <CAKR-sGdiLzZ7iVbLmz1uPwYoUXQZ2qGwmCBAq_-OKXfVT=Pj-A@mail.gmail.com>
 <d0543f48-6f0b-58e0-cc18-695a28c493fc@gmail.com> <CAKR-sGer0r0FxyOQQu7TxT0d2D981_1fQWxa_XghfyWKWSJVfQ@mail.gmail.com>
 <e16ae30a-f3ac-fbd9-b070-185997bcb89d@broadcom.com> <CAKR-sGd3Uxxquv6hdhZsmNP_sSfnOaW0JZLB590RsmRcqUx+Tg@mail.gmail.com>
 <20230522101526.56c90d88@xps-13>
In-Reply-To: <20230522101526.56c90d88@xps-13>
From:   liao jaime <jaimeliao.tw@gmail.com>
Date:   Mon, 22 May 2023 17:21:19 +0800
Message-ID: <CAAQoYRmc2ZxZ2q1QUmwwWg08DanPd9Xybk+ApHNvktxrDGcGdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: nand: Macronix: document new binding
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>
> Hi Jaime, =C3=81lvaro,
>
> noltari@gmail.com wrote on Wed, 17 May 2023 17:20:26 +0200:
>
> > Hi William,
> >
> > El mi=C3=A9, 17 may 2023 a las 7:30, William Zhang
> > (<william.zhang@broadcom.com>) escribi=C3=B3:
> > >
> > >
> > >
> > > On 05/16/2023 12:02 PM, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > > Sure,
> > > >
> > > > Here you go:
> > > > [    0.000000] Linux version 5.15.111 (noltari@atlantis)
> > > > (mips-openwrt-linux-musl-gcc (OpenWrt GCC 12.3.0 r0+22899-466be0612=
a)
> > > > 12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 SMP Tue May 16 14:33:20 20=
23
> > > > [    0.000000] CPU0 revision is: 0002a080 (Broadcom BMIPS4350)
> > > > [    0.000000] MIPS: machine is Sercomm H500-s vfes
> > > > [    0.000000] 128MB of RAM installed
> > > > [    0.000000] earlycon: bcm63xx_uart0 at MMIO 0x10000180 (options =
'115200n8')
> > > > [    0.000000] printk: bootconsole [bcm63xx_uart0] enabled
> > > > [    0.000000] Initrd not found or empty - disabling initrd
> > > > [    0.000000] Reserving 0KB of memory at 4194303KB for kdump
> > > > [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesiz=
e 16 bytes.
> > > > [    0.000000] Primary data cache 32kB, 2-way, VIPT, cache aliases,
> > > > linesize 16 bytes
> > > > [    0.000000] Zone ranges:
> > > > [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007fffff=
f]
> > > > [    0.000000] Movable zone start for each node
> > > > [    0.000000] Early memory node ranges
> > > > [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffff=
ff]
> > > > [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x00000=
00007ffffff]
> > > > [    0.000000] percpu: Embedded 11 pages/cpu s13328 r8192 d23536 u4=
5056
> > > > [    0.000000] Built 1 zonelists, mobility grouping on.  Total page=
s: 32480
> > > > [    0.000000] Kernel command line: earlycon
> > > > [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65=
536
> > > > bytes, linear)
> > > > [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 3276=
8
> > > > bytes, linear)
> > > > [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:=
off
> > > > [    0.000000] Memory: 108656K/131072K available (6902K kernel code=
,
> > > > 613K rwdata, 1404K rodata, 11872K init, 215K bss, 22416K reserved, =
0K
> > > > cma-reserved)
> > > > [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPU=
s=3D2, Nodes=3D1
> > > > [    0.000000] rcu: Hierarchical RCU implementation.
> > > > [    0.000000]  Tracing variant of Tasks RCU enabled.
> > > > [    0.000000] rcu: RCU calculated value of scheduler-enlistment de=
lay
> > > > is 10 jiffies.
> > > > [    0.000000] NR_IRQS: 256
> > > > [    0.000000] irq_bcm6345_l1: registered BCM6345 L1 intc (IRQs: 12=
8)
> > > > [    0.000000] irq_bcm6345_l1:   CPU0 (irq =3D 2)
> > > > [    0.000000] irq_bcm6345_l1:   CPU1 (irq =3D 3)
> > > > [    0.000000] brcm,bcm63268 detected @ 400 MHz
> > > > [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles:
> > > > 0xffffffff, max_idle_ns: 9556302233 ns
> > > > [    0.000002] sched_clock: 32 bits at 200MHz, resolution 5ns, wrap=
s
> > > > every 10737418237ns
> > > > [    0.008292] Calibrating delay loop... 398.13 BogoMIPS (lpj=3D199=
0656)
> > > > [    0.074683] pid_max: default: 32768 minimum: 301
> > > > [    0.081788] Mount-cache hash table entries: 1024 (order: 0, 4096
> > > > bytes, linear)
> > > > [    0.089319] Mountpoint-cache hash table entries: 1024 (order: 0,
> > > > 4096 bytes, linear)
> > > > [    0.106094] rcu: Hierarchical SRCU implementation.
> > > > [    0.112665] smp: Bringing up secondary CPUs ...
> > > > [    0.119348] SMP: Booting CPU1...
> > > > [    8.330979] Primary instruction cache 64kB, VIPT, 4-way, linesiz=
e 16 bytes.
> > > > [    8.331017] Primary data cache 32kB, 2-way, VIPT, cache aliases,
> > > > linesize 16 bytes
> > > > [    8.331294] CPU1 revision is: 0002a080 (Broadcom BMIPS4350)
> > > > [    0.182819] Synchronize counters for CPU 1:
> > > > [    0.203500] SMP: CPU1 is running
> > > > [    0.203512] done.
> > > > [    0.213401] smp: Brought up 1 node, 2 CPUs
> > > > [    0.228870] clocksource: jiffies: mask: 0xffffffff max_cycles:
> > > > 0xffffffff, max_idle_ns: 19112604462750000 ns
> > > > [    0.239058] futex hash table entries: 512 (order: 3, 32768 bytes=
, linear)
> > > > [    0.246439] pinctrl core: initialized pinctrl subsystem
> > > > [    0.254917] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> > > > [    0.312700] clocksource: Switched to clocksource MIPS
> > > > [    0.321061] NET: Registered PF_INET protocol family
> > > > [    0.326879] IP idents hash table entries: 2048 (order: 2, 16384
> > > > bytes, linear)
> > > > [    0.335972] tcp_listen_portaddr_hash hash table entries: 512
> > > > (order: 0, 6144 bytes, linear)
> > > > [    0.344721] Table-perturb hash table entries: 65536 (order: 6,
> > > > 262144 bytes, linear)
> > > > [    0.352721] TCP established hash table entries: 1024 (order: 0,
> > > > 4096 bytes, linear)
> > > > [    0.360622] TCP bind hash table entries: 1024 (order: 1, 8192 by=
tes, linear)
> > > > [    0.368005] TCP: Hash tables configured (established 1024 bind 1=
024)
> > > > [    0.375074] UDP hash table entries: 256 (order: 1, 8192 bytes, l=
inear)
> > > > [    0.381862] UDP-Lite hash table entries: 256 (order: 1, 8192 byt=
es, linear)
> > > > [    0.389762] NET: Registered PF_UNIX/PF_LOCAL protocol family
> > > > [    0.395748] PCI: CLS 0 bytes, default 16
> > > > [    0.403410] workingset: timestamp_bits=3D14 max_order=3D15 bucke=
t_order=3D1
> > > > [    0.426490] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> > > > [    0.432492] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME)
> > > > (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
> > > > [    0.459472] bcm63xx-power-controller 1000184c.power-controller:
> > > > registered 14 power domains
> > > > [    0.470267] 10000180.serial: ttyS0 at MMIO 0x10000180 (irq =3D 8=
,
> > > > base_baud =3D 1562500) is a bcm63xx_uart
> > > > [    0.479996] printk: console [ttyS0] enabled
> > > > [    0.479996] printk: console [ttyS0] enabled
> > > > [    0.488651] printk: bootconsole [bcm63xx_uart0] disabled
> > > > [    0.488651] printk: bootconsole [bcm63xx_uart0] disabled
> > > > [    0.533435] bcm2835-rng 10002880.rng: hwrng registered
> > > > [    0.606025] bcm6368_nand 10000200.nand: there is not valid maps =
for
> > > > state default
> > > > [    0.633977] nand: device found, Manufacturer ID: 0xc2, Chip ID: =
0xf1
> > > > [    0.640506] nand: Macronix MX30LF1G18AC
> > > > [    0.644551] nand: 128 MiB, SLC, erase size: 128 KiB, page size:
> > > > 2048, OOB size: 64
> > > > [    0.652359] bcm6368_nand 10000200.nand: detected 128MiB total,
> > > > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-4
> > > > [    0.703373] Bad block table not found for chip 0
> > > > [    0.732040] Bad block table not found for chip 0
> > > > [    0.736842] Scanning device for bad blocks
> > > > [    0.832678] CPU 0 Unable to handle kernel paging request at virt=
ual
> > > > address 00000014, epc =3D=3D 8009b300, ra =3D=3D 806cc650
> > > > [    0.843628] Oops[#1]:
> > > > [    0.845958] CPU: 0 PID: 88 Comm: hwrng Not tainted 5.15.111 #0
> > > > [    0.851959] $ 0   : 00000000 00000001 00000008 00000000
> > > > [    0.857358] $ 4   : 81808464 00000064 00000000 00000001
> > > > [    0.862753] $ 8   : 81810000 00001ff0 00001c00 815b8880
> > > > [    0.868146] $12   : 0000b79d 00000000 00000000 00009bb
> > > >
> > > > Please, tell me if you want me to add any debugging to the log.
> > > >
> > > > Best regards,
> > > > =C3=81lvaro.
> > > >
> > > > El mar, 16 may 2023 a las 20:58, Florian Fainelli
> > > > (<f.fainelli@gmail.com>) escribi=C3=B3:
> > > >>
> > > >> +William,
> > > >>
> > > >> On 5/16/23 11:55, =C3=81lvaro Fern=C3=A1ndez Rojas wrote:
> > > >>> Hi Jaime,
> > > >>>
> > > >>> I've reproduced the issue on a Comtrend VR-3032u (MX30LF1G08AA). =
After
> > > >>> forcing it to check block protection (it's not supported on that
> > > >>> device), the NAND controller stops reading/writing anything.
> > > >>>
> > > >>> @Florian is it possible that low level ops (GET_FEATURES/SET_FEAT=
URES)
> > > >>> aren't supported on BCM63268 NAND controllers and this is causing=
 the
> > > >>> issue?
> > > >>
> > > >> Yes, this looks like what we have seen as well even with newer NAN=
D
> > > >> controllers actually. Would it be possible to obtain a full log fr=
om
> > > >> either of you?
> > > >>
> > > >> William, is this something you have seen before as well?
> > > >>
> > > No, I haven't seen such issue before.  It is possible I didn't have t=
his
> > >   Macronix parts in my board. If I can find a board with Macronix par=
t,
> > > I will try it. But we don't use this feature and don't connect the PT
> > > pin in our reference board which means the PT feature is disabled in =
the
> > > nand part.
> > >
> > > Alvaro, Do you know if your 63268 board has PT pin connected or not?
> >
> > No, I don't know if PT pin is connected.
> > I would have to open the case and check, but judging from the
> > following image I would say it's not connected:
> > https://openwrt.org/_media/media/sercomm/h500s/h500s-nand.jpg
> >
> > > Can you check if the macronix's lock and unlock function being callin=
g
> > > before the hang?   Or is it just get/set feature function getting cal=
led
> > > to determine PT is supported?   The get/set feature function should w=
ork
> > > as they are used by other pathes
> >
> > No, the macronix's lock/unlock functions aren't called before the hang.
> > In fact, if I comment out the nand_get_features call and replace it
> > with ret =3D 1 it doesn't hang:
> > https://github.com/torvalds/linux/blob/f1fcbaa18b28dec10281551dfe6ed3a3=
ed80e3d6/drivers/mtd/nand/raw/nand_macronix.c#L229-L230
>
> This does not make any sense to me. Jaime, can you test with the exact
> same MX30LF1G18AC chip? I'm wondering whether the bug comes from the
> chip or the controller side.
Sure, I have test MX30LF1G18AC on Xilinx zynq-picozed and spi-mxic
host controller.
The test result is good.

>
> =C3=81lvaro, any chances you can try with a mainline kernel rather than
> OpenWRT's?
>
> Thanks,
> Miqu=C3=A8l

Thanks
Jaime
