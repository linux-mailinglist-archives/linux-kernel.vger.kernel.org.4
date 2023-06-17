Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86373410E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjFQMzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 08:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjFQMzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 08:55:18 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2104.outbound.protection.outlook.com [40.92.99.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623C1BC9;
        Sat, 17 Jun 2023 05:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD2xShfuhV2BQHjobR9KZEAiY5u41zAQ4EIPFlhlJ/EKVLDhBjER46H3mItBIu+KJ6msR9YYFWBP2PfHj8/nIjeEpOSRQV/l/Ii/FItEm7l4wpNco5GKzokPil7XSSxz9MCS9MV4oiroziJqhodb+nxDvhmGxnN7V43Xdu1KEXhbYjBv64who6LDplzXakrEqEzUKi+hFaGP8qWkUoo5N9jNQuStDe5PkBFmGK7S2Dsp25Mi+ZpzEGCdsUJe5yK/z6N12Ej+jK4YJ8gkXyB/6vT6zsMw/1dUPa5P0Xf5VusoRdv09X719vicQA32yR9whLcDy/l0PCCsQLHIqqOiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV1BP9OcwA74LrD2DU5tDuLMa2Q3Hm0CVsd3U8w/7/k=;
 b=ijkIvmSWYtsdQ759ozPTaBHIR7uPfEd7F20EDBnya9QKeuBrDuyTP2b7htSHATyz76U+Z0NyLamHySCUYUmWV0j9fWwS3LlH/HKGyZPtCX1jUbqoq5IHa+tzBK8obJqJrrnT/4iBFnmDMKICsa7yHV6BJKS1Nxw+CgmUL36PNtyMBgJmv8LpWDLQfUWQMExcNgMc41YzaGKhUoH0YQKmuP23DXMUV945Zs1yGpaOKbgshp9gMxU9r638eavyfbTeBR2uhNUqZZZY9Ejdln5kwdYm3bjc61L8/uIug+QyPVpjGhtHgB06dwjdcD9vRMVJv52LhiNEtysqLSCD0uWXlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV1BP9OcwA74LrD2DU5tDuLMa2Q3Hm0CVsd3U8w/7/k=;
 b=ovGOqLoLQzx73VhVLopj4tGtFKqYELz417DoxMLq/lYwguCEwllK4Zis5VFeybjkTEj7YwW0LrFNCY4bJVrsyfeFuvMufqD/T+omWGDXf1nPrNUyAnHt6i4TtYlcK1+CW6AGv3ojOyYRmInrOt/Nk4NUC7AE5bQ3nVtsBQwIbW1ZYs8kE0Od4Uga5KPqRQkZPc0Hhy+pZTa6YEnipazGpQ5t4zi7c+tA8HoHrgMO8CNLisTeg19OSKjlAJqVm6saycXZtamle6huKgaxStHRAefIIceyHwagJsYmludEDyJCN2f8rPkQFLT0b3WorM/U71Ui2jpNFs4zTBZfB1b8Gw==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by TY3P286MB3691.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.32; Sat, 17 Jun
 2023 12:55:11 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::ca7e:d73d:ba3f:64a6%5]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 12:55:11 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     sergio.paracuellos@gmail.com
Cc:     arinc.unal@arinc9.com, devicetree@vger.kernel.org,
        john@phrozen.org, krzysztof.kozlowski+dt@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, sboyd@kernel.org, tsbogend@alpha.franken.de
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
Date:   Sat, 17 Jun 2023 20:54:58 +0800
Message-ID: <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [P4BjHO16O5m1gUqPEvLlNCwaweHkLVS9]
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20230617125458.1617-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|TY3P286MB3691:EE_
X-MS-Office365-Filtering-Correlation-Id: 5389e610-d2c7-4f11-142f-08db6f3215da
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBtw0NySEeDzUUOh5uGbtfk5vdWm2Vv1OTr41qDdBBZT0tJ5ZeNznazi6Be43d6HM+hINQ4BdNE/AqYehLpgYTOS2xuUq4WCpBEoqi+tPZcw4myW3XSiigCP+WfCXHcEzcy5UKN2wMwhEvXHQiaUtYzKfu1jU4R7aXCzqJ70qGzsYcM6JBInzoDZRFyrM9Fgymja88Nj3aNJz7gOSeJR/OBIxQR7PaHfVdflL5Jf3i4QMCRAnROCUyyt1Ez0MckXkuLWcOJz+mRCtirzsF6vb8PGj5C6it3C6Xla8MA2tPkrMfv0dWB1QVqWyD8E53+4K1ISJPlNH7/izXViycvCWzE4uSLx9jM6ztZlw4NKH6fGVChtPXsLQNhObTpkk6mz4SsypTSDx2J1YTOYvZA8bu2p0pbcV3FU4hSJrDg4r/vKuk0gh938e+ADi1pLD8Xc4n09Uf9TOAGT3F2H910ocu1tUIHBLbau9vY6XdW0N79tZDCCJAqzaAmJ+EUlXOWeYYRYsKns1Vt7aueCLXg6YVFTP59MoEbbC8a0LGu2oIav8ZETs+G8JlXLINjXCFV331ZbyWcJp363lhU0xiiUrGH+gt0qjgJy0/cwxOyS5Fo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z60Wsta9Qa68tro2pDK3K4tynHXNNQE5YMVPJ5IME06eon1vFxuh6Aq2HY02?=
 =?us-ascii?Q?tzhmiMN81uHTWVPk8qcg9x2FPn0RMgZSyVnON3D8jvDcGzMvvziFkQILROF+?=
 =?us-ascii?Q?6tPjQ8yi5Lz9kE4KM7y0J5weQJ4OVGle8MnSjW8hCdC3hnL4zCrgTacIFqGa?=
 =?us-ascii?Q?4Hy3gbFfWpR5qgpQH6HcAdpenRmTW1Cd0sy+KyAXis3e3ck6csRKuK0D/N86?=
 =?us-ascii?Q?4NqDpo98pYlT63xOaA+zj3D0KTY4so0WPspf0Kf8NIrXIheWXf91e/uzkVPT?=
 =?us-ascii?Q?d2/g86AitISOMoUs6dQINM017yf6S+33iKDDoGNoWTVHHepvbxDm4xFfQbFL?=
 =?us-ascii?Q?sUkJPWtj+C+XlzjIiGlNVxax8kmJEt/8r7waII0yx1zvZGmZR1aNrrLHmzsj?=
 =?us-ascii?Q?Y5hzZjczz3zSqvWrEyCu3pDj3obfY3zFFMsLE2TvyTzTDpHX4Fn9jTXQKlUG?=
 =?us-ascii?Q?Wk1XMeMsXazOl1N5UFJGYXZwhFWPLfJ8majiBYScp1nuPBdvfr8s2X+YJPvi?=
 =?us-ascii?Q?39QMwcKba1CFiwGRA6zNIhvfgjUGaWJrEMhgJLEcVHc0eHBMhodLn4fvexLe?=
 =?us-ascii?Q?VYrYzhn3ZtyFU9UbQLhLbE5d1SfR0ESktQ6XzIMtfQFdWvYx7wGQG4Yp3Sdr?=
 =?us-ascii?Q?ZSaqKlHqq7AiwBVJ0aRSRzdcii2Ex1gcPpSp0zueIfD0Ruo1gkvrYhPEUjVF?=
 =?us-ascii?Q?44nWiZgTLG3abAEXwtGhq2aSkvvlL9J+sgc+JGxjs7DHy2MfQz7Exl73odZu?=
 =?us-ascii?Q?BkqsFi7eetmFBs72ECrWnfSfu5J44w54JR+uRQE/KUFOOv192wxdMnB62dAu?=
 =?us-ascii?Q?O7MYHcyP3+MXOR1Un7y97TAaOJlkRG13Q99FZO2FaWnXZuoibfXOtY+qIQPU?=
 =?us-ascii?Q?gRM+mbnPR+2oc8N30Pd/xMPg6a8VgwPHYOxiy4uGXAGATocx+KIi4NrDPn2q?=
 =?us-ascii?Q?PgdjIvGcYDl4z2ga15mIkuA7dMUYT+XaWi/gT9JMI631o3z9NGqNvLeXzQ5v?=
 =?us-ascii?Q?iNJULxKbxDou+HzTzLqXCTSx5aq//fo7ttizid/A2DAQk7zasU9nQo3GXyQU?=
 =?us-ascii?Q?+q9iqmjlzYL+QUV9iqafhlijgrdNVAAOzeS5LWuZjQfpKPRe0wmkiYpc1n7s?=
 =?us-ascii?Q?Qk3sqGh1BrJSXi/PVxVDuW8wKoWHLvFhzR8HMyBK9S85L8A7V+SPlmPcWNoQ?=
 =?us-ascii?Q?9cgd7oC55zeQnXzDpQU3fqXv4clDu4oY8hheBTooCc0VVTF9k7g20P3BNtQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5389e610-d2c7-4f11-142f-08db6f3215da
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 12:55:11.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3691
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio Paracuellos!

I found there are still some areas that need improvement.

>+
>+static unsigned long rt3883_bus_recalc_rate(struct clk_hw *hw,
>+					    unsigned long parent_rate)
>+{
>+	struct mtmips_clk *clk = to_mtmips_clk(hw);
>+	struct regmap *sysc = clk->priv->sysc;
>+	u32 ddr2;
>+	u32 t;
>+
>+	regmap_read(sysc, SYSC_REG_SYSTEM_CONFIG, &t);
>+	ddr2 = t & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
>+
>+	switch (parent_rate) {
>+	case 250000000:
>+		return (ddr2) ? 125000000 : 83000000;
>+	case 384000000:
>+		return (ddr2) ? 128000000 : 96000000;
>+	case 480000000:
>+		return (ddr2) ? 160000000 : 120000000;
>+	case 500000000:
>+		return (ddr2) ? 166000000 : 125000000;
>+	default:
>+		WARN_ON_ONCE(parent_rate == 0);

drivers/clk/ralink/clk-mtmips.c: In function 'rt3883_bus_recalc_rate':
drivers/clk/ralink/clk-mtmips.c:502:1: error: control reaches end of non-void function [-Werror=return-type]
  502 | }
      | ^

Build error here, need to return a value, `parent_rate / 4` should be okay.
It seems that the program will never run into this default case.

>+	}
>+}
>+


>+
>+static const struct of_device_id mtmips_clk_of_match[] = {
>+	{ .compatible = "ralink,rt2880-reset" },
>+	{ .compatible = "ralink,rt2880-sysc" },
>+	{ .compatible = "ralink,rt3050-sysc" },
>+	{ .compatible = "ralink,rt3050-sysc" },

There are two `ralink,rt3050-sysc`. I think the second one should be
`ralink,rt3052-sysc`.

>+	{ .compatible = "ralink,rt3352-sysc" },
>+	{ .compatible = "ralink,rt3883-sysc" },
>+	{ .compatible = "ralink,rt5350-sysc" },
>+	{ .compatible = "ralink,mt7620a-sysc" },
>+	{ .compatible = "ralink,mt7620-sysc" },
>+	{ .compatible = "ralink,mt7628-sysc" },
>+	{ .compatible = "ralink,mt7688-sysc" },
>+	{}
>+};
>+


> void __init plat_time_init(void)
> {
>+	struct of_phandle_args clkspec;
> 	struct clk *clk;
>+	int cpu_clk_idx;
> 
> 	ralink_of_remap();
> 
>-	ralink_clk_init();
>-	clk = clk_get_sys("cpu", NULL);
>+	cpu_clk_idx = clk_cpu_index();
>+	if (cpu_clk_idx == -1)
>+		panic("unable to get CPU clock index");
>+
>+	of_clk_init(NULL);
>+	clkspec.np = of_find_node_by_name(NULL, "sysc");

The node name should be "syscon" as the example node name in the
dt-bindings document is "syscon".

>+	clkspec.args_count = 1;
>+	clkspec.args[0] = cpu_clk_idx;
>+	clk = of_clk_get_from_provider(&clkspec);
> 	if (IS_ERR(clk))
> 		panic("unable to get CPU clock, err=%ld", PTR_ERR(clk));
> 	pr_info("CPU Clock: %ldMHz\n", clk_get_rate(clk) / 1000000);


It seems that the clock calculation logic of the mt7620 has changed.
The kernel got an incorrect clock frequency 3480MHz. The correct CPU
clock should be 580MHz = 3480MHz / 6.

I will test and report mt7628 later.

mt7620 dmesg:
[    0.000000] Linux version 5.15.117 (db@Aspire-V-Nitro) (mipsel-openwrt-linux-musl-gcc (OpenWrt GCC 12.3.0 r23471+7-816fcf88f6) 12.3.0, GNU ld (GNU Binutils) 2.40.0) #0 Sat Jun 17 08:41:01 2023
[    0.000000] Board has DDR2
[    0.000000] Analog PMU set to hw control
[    0.000000] Digital PMU set to hw control
[    0.000000] SoC Type: MediaTek MT7620A ver:2 eco:6
[    0.000000] printk: bootconsole [early0] enabled
[    0.000000] CPU0 revision is: 00019650 (MIPS 24KEc)
[    0.000000] MIPS: machine is Haier HW-L1W
[    0.000000] Initrd not found or empty - disabling initrd
[    0.000000] Primary instruction cache 64kB, VIPT, 4-way, linesize 32 bytes.
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000007ffffff]
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 32480
[    0.000000] Kernel command line: console=ttyS0,115200 rootfstype=squashfs,jffs2
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes, linear)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes, linear)
[    0.000000] Writing ErrCtl register=00064000
[    0.000000] Readback ErrCtl register=00064000
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 120992K/131072K available (5518K kernel code, 600K rwdata, 1192K rodata, 1192K init, 215K bss, 10080K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS: 256
[    0.000000] CPU Clock: 3480MHz
[    0.000000] clocksource: systick: mask: 0xffff max_cycles: 0xffff, max_idle_ns: 583261500 ns
[    0.000000] systick: enable autosleep mode
[    0.000000] systick: running - mult: 214748, shift: 32
[    0.000000] clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1098425544 ns
[    0.000000] sched_clock: 32 bits at 1740MHz, resolution 0ns, wraps every 1234186239ns
[    0.001354] Calibrating delay loop... 385.84 BogoMIPS (lpj=1929216)
[    0.012389] pid_max: default: 32768 minimum: 301
[    0.013357] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.014589] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.017429] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.019103] futex hash table entries: 256 (order: -1, 3072 bytes, linear)
[    0.020288] pinctrl core: initialized pinctrl subsystem
[    0.021415] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.105370] rt2880_gpio 10000600.gpio: registering 24 gpios
[    0.106328] rt2880_gpio 10000600.gpio: registering 24 irq handlers
[    0.107446] rt2880_gpio 10000688.gpio: registering 1 gpios
[    0.108381] rt2880_gpio 10000688.gpio: registering 1 irq handlers
[    0.109673] PCI host bridge to bus 0000:00
[    0.110372] pci_bus 0000:00: root bus resource [mem 0x20000000-0x2fffffff]
[    0.111528] pci_bus 0000:00: root bus resource [io  0x10160000-0x1016ffff]
[    0.112695] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    0.114046] pci 0000:00:00.0: [1814:0801] type 01 class 0x060400
[    0.115059] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x7fffffff]
[    0.116118] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x0000ffff]
[    0.117195] pci 0000:00:00.0: supports D1
[    0.117862] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    0.119156] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    0.120556] pci 0000:01:00.0: [14c3:7650] type 00 class 0x028000
[    0.121570] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.122658] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.123749] pci 0000:01:00.1: [14c3:8650] type 00 class 0x0d1100
[    0.124769] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x000fffff]
[    0.125844] pci 0000:01:00.1: supports D1
[    0.126513] pci 0000:01:00.1: PME# supported from D0 D1 D3hot D3cold
[    0.127897] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    0.129018] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 01
[    0.130138] pci 0000:00:00.0: BAR 0: no space for [mem size 0x80000000]
[    0.131255] pci 0000:00:00.0: BAR 0: failed to assign [mem size 0x80000000]
[    0.132434] pci 0000:00:00.0: BAR 8: assigned [mem 0x20000000-0x201fffff]
[    0.133587] pci 0000:00:00.0: BAR 1: assigned [mem 0x20200000-0x2020ffff]
[    0.134738] pci 0000:01:00.0: BAR 0: assigned [mem 0x20000000-0x200fffff]
[    0.135890] pci 0000:01:00.1: BAR 0: assigned [mem 0x20100000-0x201fffff]
[    0.137040] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.137882] pci 0000:00:00.0:   bridge window [mem 0x20000000-0x201fffff]
[    0.139123] clocksource: Switched to clocksource MIPS
[    0.140241] NET: Registered PF_INET protocol family
[    0.141106] IP idents hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.142473] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.143893] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.145199] TCP established hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.146499] TCP bind hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.147695] TCP: Hash tables configured (established 1024 bind 1024)
[    0.148803] UDP hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.149920] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes, linear)
[    0.151177] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.152149] PCI: CLS 0 bytes, default 32
[    0.152847] rt-timer 10000100.timer: failed get clock rate
[    0.153771] rt-timer: probe of 10000100.timer failed with error -2
[    0.155602] workingset: timestamp_bits=14 max_order=15 bucket_order=1
[    0.157808] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.158792] jffs2: version 2.2 (NAND) (SUMMARY) (LZMA) (RTIME) (CMODE_PRIORITY) (c) 2001-2006 Red Hat, Inc.
[    0.161032] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[    0.162284] of_serial 10000c00.uartlite: failed to get clock: -2
[    0.163300] of_serial: probe of 10000c00.uartlite failed with error -2
[    0.164624] spi-rt2880 10000b00.spi: unable to get SYS clock
[    0.165580] spi-rt2880: probe of 10000b00.spi failed with error -2
[    0.171098] gsw: setting port4 to ephy mode
[    0.171828] mtk_soc_eth 10100000.ethernet: generated random MAC address f6:6c:93:9a:c8:ca
[    0.173208] mtk_soc_eth 10100000.ethernet: mdio-bus disabled
[    0.174205] mtk_soc_eth 10100000.ethernet: loaded mt7620 driver
[    0.175329] mtk_soc_eth 10100000.ethernet eth0: mediatek frame engine at 0xb0100000, irq 5
[    0.176805] rt2880_wdt: probe of 10000120.watchdog failed with error -2
[    0.178187] NET: Registered PF_INET6 protocol family
[    0.179980] Segment Routing with IPv6
[    0.180607] In-situ OAM (IOAM) with IPv6
[    0.181290] NET: Registered PF_PACKET protocol family
[    0.182148] 8021q: 802.1Q VLAN Support v1.8
[    0.183347] Warning: unable to open an initial console.
[    0.184558] /dev/root: Can't open blockdev
[    0.185253] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
[    0.186516] Please append a correct "root=" boot option; here are the available partitions:
[    0.187934] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[    0.189335] Rebooting in 1 seconds..


Thanks,
    Shiji Yang
