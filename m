Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6CA734136
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjFQN0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQN0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:26:13 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580EC1;
        Sat, 17 Jun 2023 06:26:12 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39cf00a2ad2so1271168b6e.1;
        Sat, 17 Jun 2023 06:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687008371; x=1689600371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cEQwBbCq0ejXdRe1WDvtB5tnXU9oaL0Kp5wEO5rTdA=;
        b=hEc3/TxRCXGVuX6IQ81ZOBrRkbjBsvqoHfLLganGrgJtVM10qO4hvOTCyxJvy+pYm/
         DpIop/bbYjZYuWE+0jFW/lOTEIVb++Vj/v49yBFUtJjk55Ck61cw1g3uphy4GTnGb7ko
         elrPv68GUwnB/kGEx8R3RSPWx3fuTZheLgF+vcN2xDBfLNTQtwAptDhM2d67R2jgpPf7
         Zow9uqo5k3ulPhsjgOGEZvhKBkYElzM9y9YUuHaBu+UyiijFZkcVd2rBpDo+ilGc41ku
         G4+oTP3fWfBjIUy0RJL2eSUjsBq9eN6dw6cM3iJjGyzitqGR5CeUvz3KzZMTZNbD4sn3
         vSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687008371; x=1689600371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cEQwBbCq0ejXdRe1WDvtB5tnXU9oaL0Kp5wEO5rTdA=;
        b=lyE4CbZBHLt5M0hSdmP5xczBucrAQiNGODijc6xfWGpnsbWXHnyxUYbsfWmQh/sNiX
         CXH40vId6PpVdSgInKpbHgmLYiwMUycGWWy+hwKLnaWSVfWuQmUdz8V+dILTqRXjgjyd
         uWfoEqeB8QY2nJLUBTmZ1dDVy/j2y0z5eEh9WwMMWc3atPfnYS9cX6zzsz/DfoPwXjd2
         jzJqicnx2PI7TqrszlTwOnOVuPgATaRBHfJwvriReoe2ffPLoKKEDCaKscunF+jfYukS
         iljPxVh48VNo0WLJCHRQjOB7DQFgAEZ5bv7h8xLXSD8YUpwrpSIO0t7YLWMSZAD5rQ/s
         TEJg==
X-Gm-Message-State: AC+VfDw7LaaqMXWISxyynGZosY/wawktjwzhjF48RW3pH79LpP2xb41M
        R6gGGc43wtiibiV9QW8jVG+xF4jaXRNDVNW3a28=
X-Google-Smtp-Source: ACHHUZ4lgYDxDtxU1I2yjiFxD97PjXSn26RFYDysI6xIe7xTPJW0m7HKiq2hONSK99kmo+sni5TXkivdzj4XAqxcx4Q=
X-Received: by 2002:a05:6808:3009:b0:39d:f03e:71ca with SMTP id
 ay9-20020a056808300900b0039df03e71camr4622035oib.53.1687008371344; Sat, 17
 Jun 2023 06:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com> <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 15:26:00 +0200
Message-ID: <CAMhs-H8rt3-ffvjkNSORiNXQUVCUHCc7FNwYN7TOyQ0DxCe2fA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     arinc.unal@arinc9.com, devicetree@vger.kernel.org,
        john@phrozen.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tsbogend@alpha.franken.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiji Yang,

On Sat, Jun 17, 2023 at 2:55=E2=80=AFPM Shiji Yang <yangshiji66@outlook.com=
> wrote:
>
> Hi Sergio Paracuellos!
>
> I found there are still some areas that need improvement.

Awesome! I did not expect to get testing before this is added to the
tree .As I have mentioned I have only tested this with Ralink 5350 ALL
One board. So thanks for testing this so far!! It is really helpful.

>
> >+
> >+static unsigned long rt3883_bus_recalc_rate(struct clk_hw *hw,
> >+                                          unsigned long parent_rate)
> >+{
> >+      struct mtmips_clk *clk =3D to_mtmips_clk(hw);
> >+      struct regmap *sysc =3D clk->priv->sysc;
> >+      u32 ddr2;
> >+      u32 t;
> >+
> >+      regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
> >+      ddr2 =3D t & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
> >+
> >+      switch (parent_rate) {
> >+      case 250000000:
> >+              return (ddr2) ? 125000000 : 83000000;
> >+      case 384000000:
> >+              return (ddr2) ? 128000000 : 96000000;
> >+      case 480000000:
> >+              return (ddr2) ? 160000000 : 120000000;
> >+      case 500000000:
> >+              return (ddr2) ? 166000000 : 125000000;
> >+      default:
> >+              WARN_ON_ONCE(parent_rate =3D=3D 0);
>
> drivers/clk/ralink/clk-mtmips.c: In function 'rt3883_bus_recalc_rate':
> drivers/clk/ralink/clk-mtmips.c:502:1: error: control reaches end of non-=
void function [-Werror=3Dreturn-type]
>   502 | }
>       | ^
>
> Build error here, need to return a value, `parent_rate / 4` should be oka=
y.
> It seems that the program will never run into this default case.

Ouch, it was a BUG() call here before changing it to WARN_ON_ONCE so
yes a return is needed! Thanks!

>
> >+      }
> >+}
> >+
>
>
> >+
> >+static const struct of_device_id mtmips_clk_of_match[] =3D {
> >+      { .compatible =3D "ralink,rt2880-reset" },
> >+      { .compatible =3D "ralink,rt2880-sysc" },
> >+      { .compatible =3D "ralink,rt3050-sysc" },
> >+      { .compatible =3D "ralink,rt3050-sysc" },
>
> There are two `ralink,rt3050-sysc`. I think the second one should be
> `ralink,rt3052-sysc`.

True :)

>
> >+      { .compatible =3D "ralink,rt3352-sysc" },
> >+      { .compatible =3D "ralink,rt3883-sysc" },
> >+      { .compatible =3D "ralink,rt5350-sysc" },
> >+      { .compatible =3D "ralink,mt7620a-sysc" },
> >+      { .compatible =3D "ralink,mt7620-sysc" },
> >+      { .compatible =3D "ralink,mt7628-sysc" },
> >+      { .compatible =3D "ralink,mt7688-sysc" },
> >+      {}
> >+};
> >+
>
>
> > void __init plat_time_init(void)
> > {
> >+      struct of_phandle_args clkspec;
> >       struct clk *clk;
> >+      int cpu_clk_idx;
> >
> >       ralink_of_remap();
> >
> >-      ralink_clk_init();
> >-      clk =3D clk_get_sys("cpu", NULL);
> >+      cpu_clk_idx =3D clk_cpu_index();
> >+      if (cpu_clk_idx =3D=3D -1)
> >+              panic("unable to get CPU clock index");
> >+
> >+      of_clk_init(NULL);
> >+      clkspec.np =3D of_find_node_by_name(NULL, "sysc");
>
> The node name should be "syscon" as the example node name in the
> dt-bindings document is "syscon".

sysc is label to get this node since it is the one shared by all
different dtsi files.

>
> >+      clkspec.args_count =3D 1;
> >+      clkspec.args[0] =3D cpu_clk_idx;
> >+      clk =3D of_clk_get_from_provider(&clkspec);
> >       if (IS_ERR(clk))
> >               panic("unable to get CPU clock, err=3D%ld", PTR_ERR(clk))=
;
> >       pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);
>
>
> It seems that the clock calculation logic of the mt7620 has changed.
> The kernel got an incorrect clock frequency 3480MHz. The correct CPU
> clock should be 580MHz =3D 3480MHz / 6.

The only thing that changed a bit is the stuff with the CONFIG_USB
that I was told to change by Stephen. Can you check if that is the
problem with your bad cpu clock? Just comment the call
'mtmips_clk_regs_init' of the probe function.

>
> I will test and report mt7628 later.

Thanks!

>
> mt7620 dmesg:
> [    0.000000] Linux version 5.15.117 (db@Aspire-V-Nitro) (mipsel-openwrt=
-linux-musl-gcc (OpenWrt GCC 12.3.0 r23471+7-816fcf88f6) 12.3.0, GNU ld (GN=
U Binutils) 2.40.0) #0 Sat Jun 17 08:41:01 2023
> [    0.000000] Board has DDR2
> [    0.000000] Analog PMU set to hw control
> [    0.000000] Digital PMU set to hw control
> [    0.000000] SoC Type: MediaTek MT7620A ver:2 eco:6
> [    0.000000] printk: bootconsole [early0] enabled
> [    0.000000] CPU0 revision is: 00019650 (MIPS 24KEc)
> [    0.000000] MIPS: machine is Haier HW-L1W
> [    0.000000] Initrd not found or empty - disabling initrd
> [    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 b=
ytes.
> [    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize=
 32 bytes
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007f=
fffff]
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 324=
80
> [    0.000000] Kernel command line: console=3DttyS0,115200 rootfstype=3Ds=
quashfs,jffs2
> [    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 by=
tes, linear)
> [    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 byte=
s, linear)
> [    0.000000] Writing ErrCtl register=3D00064000
> [    0.000000] Readback ErrCtl register=3D00064000
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Memory: 120992K/131072K available (5518K kernel code, 600K=
 rwdata, 1192K rodata, 1192K init, 215K bss, 10080K reserved, 0K cma-reserv=
ed)
> [    0.000000] SLUB: HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
> [    0.000000] NR_IRQS: 256
> [    0.000000] CPU Clock: 3480MHz
> [    0.000000] clocksource: systick: mask: 0xffff max_cycles: 0xffff, max=
_idle_ns: 583261500 ns
> [    0.000000] systick: enable autosleep mode
> [    0.000000] systick: running - mult: 214748, shift: 32
> [    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 1098425544 ns
> [    0.000000] sched_clock: 32 bits at 1740MHz, resolution 0ns, wraps eve=
ry 1234186239ns
> [    0.001354] Calibrating delay loop... 385.84 BogoMIPS (lpj=3D1929216)
> [    0.012389] pid_max: default: 32768 minimum: 301
> [    0.013357] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes=
, linear)
> [    0.014589] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 =
bytes, linear)
> [    0.017429] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 19112604462750000 ns
> [    0.019103] futex hash table entries: 256 (order: -1, 3072 bytes, line=
ar)
> [    0.020288] pinctrl core: initialized pinctrl subsystem
> [    0.021415] NET: Registered PF_NETLINK/PF_ROUTE protocol family
> [    0.105370] rt2880_gpio 10000600.gpio: registering 24 gpios
> [    0.106328] rt2880_gpio 10000600.gpio: registering 24 irq handlers
> [    0.107446] rt2880_gpio 10000688.gpio: registering 1 gpios
> [    0.108381] rt2880_gpio 10000688.gpio: registering 1 irq handlers
> [    0.109673] PCI host bridge to bus 0000:00
> [    0.110372] pci_bus 0000:00: root bus resource [mem 0x20000000-0x2ffff=
fff]
> [    0.111528] pci_bus 0000:00: root bus resource [io  0x10160000-0x1016f=
fff]
> [    0.112695] pci_bus 0000:00: No busn resource found for root bus, will=
 use [bus 00-ff]
> [    0.114046] pci 0000:00:00.0: [1814:0801] type 01 class 0x060400
> [    0.115059] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
> [    0.116118] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
> [    0.117195] pci 0000:00:00.0: supports D1
> [    0.117862] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
> [    0.119156] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00=
]), reconfiguring
> [    0.120556] pci 0000:01:00.0: [14c3:7650] type 00 class 0x028000
> [    0.121570] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.122658] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> [    0.123749] pci 0000:01:00.1: [14c3:8650] type 00 class 0x0d1100
> [    0.124769] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x000fffff]
> [    0.125844] pci 0000:01:00.1: supports D1
> [    0.126513] pci 0000:01:00.1: PME# supported from D0 D1 D3hot D3cold
> [    0.127897] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 0=
1
> [    0.129018] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 0=
1
> [    0.130138] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000=
]
> [    0.131255] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x8000=
0000]
> [    0.132434] pci 0000:00:00.0: BAR 8: assigned [mem 0x20000000-0x201fff=
ff]
> [    0.133587] pci 0000:00:00.0: BAR 1: assigned [mem 0x20200000-0x2020ff=
ff]
> [    0.134738] pci 0000:01:00.0: BAR 0: assigned [mem 0x20000000-0x200fff=
ff]
> [    0.135890] pci 0000:01:00.1: BAR 0: assigned [mem 0x20100000-0x201fff=
ff]
> [    0.137040] pci 0000:00:00.0: PCI bridge to [bus 01]
> [    0.137882] pci 0000:00:00.0:   bridge window [mem 0x20000000-0x201fff=
ff]
> [    0.139123] clocksource: Switched to clocksource MIPS
> [    0.140241] NET: Registered PF_INET protocol family
> [    0.141106] IP idents hash table entries: 2048 (order: 2, 16384 bytes,=
 linear)
> [    0.142473] tcp_listen_portaddr_hash hash table entries: 512 (order: 0=
, 4096 bytes, linear)
> [    0.143893] Table-perturb hash table entries: 65536 (order: 6, 262144 =
bytes, linear)
> [    0.145199] TCP established hash table entries: 1024 (order: 0, 4096 b=
ytes, linear)
> [    0.146499] TCP bind hash table entries: 1024 (order: 0, 4096 bytes, l=
inear)
> [    0.147695] TCP: Hash tables configured (established 1024 bind 1024)
> [    0.148803] UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
> [    0.149920] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, li=
near)
> [    0.151177] NET: Registered PF_UNIX/PF_LOCAL protocol family
> [    0.152149] PCI: CLS 0 bytes, default 32
> [    0.152847] rt-timer 10000100.timer: failed get clock rate
> [    0.153771] rt-timer: probe of 10000100.timer failed with error -2
> [    0.155602] workingset: timestamp_bits=3D14 max_order=3D15 bucket_orde=
r=3D1
> [    0.157808] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    0.158792] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_=
PRIORITY) (c) 2001-2006 Red Hat, Inc.
> [    0.161032] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> [    0.162284] of_serial 10000c00.uartlite: failed to get clock: -2
> [    0.163300] of_serial: probe of 10000c00.uartlite failed with error -2
> [    0.164624] spi-rt2880 10000b00.spi: unable to get SYS clock
> [    0.165580] spi-rt2880: probe of 10000b00.spi failed with error -2
> [    0.171098] gsw: setting port4 to ephy mode
> [    0.171828] mtk_soc_eth 10100000.ethernet: generated random MAC addres=
s f6:6c:93:9a:c8:ca
> [    0.173208] mtk_soc_eth 10100000.ethernet: mdio-bus disabled
> [    0.174205] mtk_soc_eth 10100000.ethernet: loaded mt7620 driver
> [    0.175329] mtk_soc_eth 10100000.ethernet eth0: mediatek frame engine =
at 0xb0100000, irq 5
> [    0.176805] rt2880_wdt: probe of 10000120.watchdog failed with error -=
2
> [    0.178187] NET: Registered PF_INET6 protocol family
> [    0.179980] Segment Routing with IPv6
> [    0.180607] In-situ OAM (IOAM) with IPv6
> [    0.181290] NET: Registered PF_PACKET protocol family
> [    0.182148] 8021q: 802.1Q VLAN Support v1.8
> [    0.183347] Warning: unable to open an initial console.
> [    0.184558] /dev/root: Can't open blockdev
> [    0.185253] VFS: Cannot open root device "(null)" or unknown-block(0,0=
): error -6
> [    0.186516] Please append a correct "root=3D" boot option; here are th=
e available partitions:
> [    0.187934] Kernel panic - not syncing: VFS: Unable to mount root fs o=
n unknown-block(0,0)
> [    0.189335] Rebooting in 1 seconds..
>
>
> Thanks,
>     Shiji Yang

Best regards,
    Sergio Paracuellos
