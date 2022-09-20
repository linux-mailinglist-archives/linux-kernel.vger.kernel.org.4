Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4545BED83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiITTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13BBB205E1;
        Tue, 20 Sep 2022 12:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C1C62CFF;
        Tue, 20 Sep 2022 19:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77534C43470;
        Tue, 20 Sep 2022 19:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663701639;
        bh=waKrsNI9eNSlhJKFS44JhYI9UGB9h0bpETQ6qzPBTz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLHzXm0o0nXpbNJT+U/Jic11be1zAKKRjJO4Xj98mUAodR0qTn2WmPM+5ZdCWInFY
         ceo4hfcNMOlBdWA1EvtXBdZDdWWJXOxNV3k8XnGrz/LlxPD+7/2vsLVc/CmlKQlouk
         vlLutOimmFUYqeF9WLBwQ1qtuuoEmYcY97ZybeyB/wH4g2/zblgdFRybylINAjP8OY
         GQNhZBNZPhuQL+ZyZQ8kQ7tNXJNssLEx5b81jwwXeMQjmyf9pinhUjFsDyepBYno9u
         Hy5SNpHGnw3vLsvSj8DaCnsDurgDTn7Ccif0CBBhev9dWDPFGjWTbOo7ob2Tr9ubn9
         1VfqAFEJzwbYQ==
Date:   Tue, 20 Sep 2022 20:20:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Atish Patra <atishp@rivosinc.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 00/10] Add support for Renesas RZ/Five SoC
Message-ID: <YyoSgGlkIB8GMog8@spud>
References: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920184904.90495-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Prabhakar,

On Tue, Sep 20, 2022 at 07:48:54PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> The RZ/Five microprocessor includes a RISC-V CPU Core (AX45MP Single)
> 1.0 GHz, 16-bit DDR3L/DDR4 interface. And it also has many interfaces such
> as Gbit-Ether, CAN, and USB 2.0, making it ideal for applications such as
> entry-class social infrastructure gateway control and industrial gateway
> control.
> 
> This patch series adds initial SoC DTSi support for Renesas RZ/Five
> (R9A07G043) SoC and updates the bindings for the same. Below is the list
> of IP blocks added in the initial SoC DTSI which can be used to boot via
> initramfs on RZ/Five SMARC EVK:
> - AX45MP CPU
> - CPG
> - PINCTRL
> - PLIC
> - SCIF0
> - SYSC

Ran into one complaint from dtbs_check:
arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c50200: '#phy-cells' is a required property
        From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml
arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dtb: usb-phy@11c70200: '#phy-cells' is a required property
        From schema: /home/conor/.local/lib/python3.10/site-packages/dtschema/schemas/phy/phy-provider.yaml

Other than that which should be a trivial fix the whole lot looks good
to me...
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> 
> Useful links:
> -------------
> [0] https://www.renesas.com/us/en/products/microcontrollers-microprocessors/rz-mpus/rzfive-risc-v-general-purpose-microprocessors-risc-v-cpu-core-andes-ax45mp-single-10-ghz-2ch-gigabit-ethernet
> [1] http://www.andestech.com/en/products-solutions/andescore-processors/riscv-ax45mp/
> 
> Patch series depends on the below (which are already in -next apart from the last one):
> --------------------------------------------------
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [1] https://patchwork.kernel.org/project/linux-renesas-soc/cover/20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> [2] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20220919104606.96553-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> v3 -> v4:
> -------
> * Rebased patches on -next
> * Included RB tags
> * Fixed review comments pointed by Conor and Geert
> 
> v3: https://lore.kernel.org/lkml/20220915181558.354737-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v2: https://lore.kernel.org/all/20220815151451.23293-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v1: https://lore.kernel.org/lkml/20220726180623.1668-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Below are the logs from RZ/Five SMARC EVK:
> ------------------------------------------
> / # uname -ra
> Linux (none) 6.0.0-rc6-next-20220920-00025-gc002c40ce550-dirty #136 SMP Tue Sep 20 13:47:31 BST 2022 riscv64 GNU/Linux
> / # cat /proc/cpuinfo 
> processor       : 0
> hart            : 0
> isa             : rv64imafdc
> mmu             : sv39
> uarch           : andestech,ax45mp
> mvendorid       : 0x31e
> marchid         : 0x8000000000008a45
> mimpid          : 0x500
> 
> / # for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/
> soc0/$i; done
> machine: Renesas SMARC EVK based on r9a07g043f01
> family: RZ/Five
> soc_id: r9a07g043
> revision: 0
> / # 
> / # cat /proc/interrupts 
>            CPU0       
>   1:          0  SiFive PLIC 412 Level     1004b800.serial:rx err
>   2:         33  SiFive PLIC 414 Level     1004b800.serial:rx full
>   3:        919  SiFive PLIC 415 Level     1004b800.serial:tx empty
>   4:          0  SiFive PLIC 413 Level     1004b800.serial:break
>   5:      44106  RISC-V INTC   5 Edge      riscv-timer
>   6:         62  SiFive PLIC 416 Level     1004b800.serial:rx ready
> IPI0:         0  Rescheduling interrupts
> IPI1:         0  Function call interrupts
> IPI2:         0  CPU stop interrupts
> IPI3:         0  IRQ work interrupts
> IPI4:         0  Timer broadcast interrupts
> / # 
> / # cat /proc/meminfo 
> MemTotal:         882308 kB
> MemFree:          861440 kB
> MemAvailable:     859188 kB
> Buffers:               0 kB
> Cached:             1796 kB
> SwapCached:            0 kB
> Active:                0 kB
> Inactive:             84 kB
> Active(anon):          0 kB
> Inactive(anon):       84 kB
> Active(file):          0 kB
> Inactive(file):        0 kB
> Unevictable:        1796 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           120 kB
> Mapped:             1200 kB
> Shmem:                 0 kB
> KReclaimable:       6732 kB
> Slab:              12088 kB
> SReclaimable:       6732 kB
> SUnreclaim:         5356 kB
> KernelStack:         636 kB
> PageTables:           32 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:      441152 kB
> Committed_AS:        592 kB
> VmallocTotal:   67108864 kB
> VmallocUsed:         840 kB
> VmallocChunk:          0 kB
> Percpu:               84 kB
> HugePages_Total:       0
> HugePages_Free:        0
> HugePages_Rsvd:        0
> HugePages_Surp:        0
> Hugepagesize:       2048 kB
> Hugetlb:               0 kB
> / # 
> 
> -------------------
> 
> 
> Lad Prabhakar (10):
>   dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
>   dt-bindings: riscv: Sort the CPU core list alphabetically
>   dt-bindings: riscv: Add Andes AX45MP core to the list
>   dt-bindings: soc: renesas: renesas.yaml: Document Renesas RZ/Five SoC
>   riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>   riscv: dts: renesas: Add initial devicetree for Renesas RZ/Five SoC
>   riscv: dts: r9a07g043: Add placeholder nodes
>   riscv: dts: renesas: Add minimal DTS for Renesas RZ/Five SMARC EVK
>   MAINTAINERS: Add entry for Renesas RISC-V architecture
>   riscv: configs: defconfig: Enable Renesas RZ/Five SoC
> 
>  .../devicetree/bindings/riscv/cpus.yaml       |  11 +-
>  .../{arm => soc/renesas}/renesas.yaml         |   5 +-
>  MAINTAINERS                                   |   4 +-
>  arch/riscv/Kconfig.socs                       |   5 +
>  arch/riscv/boot/dts/Makefile                  |   1 +
>  arch/riscv/boot/dts/renesas/Makefile          |   2 +
>  arch/riscv/boot/dts/renesas/r9a07g043.dtsi    | 270 ++++++++++++++++++
>  .../boot/dts/renesas/r9a07g043f01-smarc.dts   |  27 ++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  19 ++
>  arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi |  15 +
>  arch/riscv/configs/defconfig                  |   3 +
>  11 files changed, 353 insertions(+), 9 deletions(-)
>  rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (98%)
>  create mode 100644 arch/riscv/boot/dts/renesas/Makefile
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/r9a07g043f01-smarc.dts
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
>  create mode 100644 arch/riscv/boot/dts/renesas/rzfive-smarc.dtsi
> 
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
