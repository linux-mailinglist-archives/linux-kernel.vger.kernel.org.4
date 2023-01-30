Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B20D6818BE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbjA3SXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237225AbjA3SXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:23:18 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5053EFFD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:22:47 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 5so12553868plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RI22LbgqWNEv5UzlC1sMyx9FAhRay6n0zSuBGUPx4y8=;
        b=BhBgNdAagLBMY28KLLQVlINvG4nk9njtI1Kcv6Kc6G4unrUh5ZBfAiC7Lpl4kL/oid
         VDvBZKFG0hhODY3zyhSXF+XhlTt/EUH/jno/EQzcbiel2IIfdD7Yq9hcKEsrWGrtDDnl
         IhlcJ9kMY38C9J/f8hKOie7R4xXQGv3awE55RbchEXJ+fXxivwdh2Lt+l4vxKylTmKpy
         1xw/VH9Uf9Hcq3V19EydNCcS+rOdwktXHoEhUbTKFGn+IztCYGPJerQWAD1SVwl5L79F
         EkQTKchOFkt7NCdKqjqKE18wU5IctSbeX4yek5KhgtqVNj2sY4/3V9fmmLf7pNdCPHdi
         kXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RI22LbgqWNEv5UzlC1sMyx9FAhRay6n0zSuBGUPx4y8=;
        b=45rCyoo7BusxzIaOA8GFK0+TmYTc5MkxjHrhq9JO9xPfT6A50atGFRZvR0hhiPKaqv
         xAb7yezdlZp9jiSOf0m/KVJvGHe7VkDeLFP33fF8Md4cAcJ21q8AVPiKJqJl4bM9dMe+
         h0235quywel/F9vOyFenRAUB+i7CKEsef2cFRhE2ywRhN4VkRMB17H8ik3mZGPHaQ46l
         ln1Py7g/Bg67uXtebl2gih1N2wG7VNpGnVbNTbpW4BZkGQSF6Vgbmg2Xhv0PPo5nysIp
         dlZpc9b4jPr4yeXPO59KOpOsVAghVWWJNcvXoXda/VuZvpVM+ntFpLx+3aQhfBR9yBRj
         oCQA==
X-Gm-Message-State: AO0yUKVta4Oxuf9ZUhHQeOi2ibMKcVD5fbMjCqI7Z6mnyZFUUJUHlDBu
        ywW42s1zwMECV+vL5WUsPRbe3Q==
X-Google-Smtp-Source: AK7set/c3VAC3ZT2NOToGmYgKr82uNdFAR1hLwjGxiq3XJF5GQQbK6Orcm8br2dBNQTap/jO+cH1ag==
X-Received: by 2002:a05:6a20:c19a:b0:b8:4cc9:16d9 with SMTP id bg26-20020a056a20c19a00b000b84cc916d9mr18529672pzb.46.1675102954299;
        Mon, 30 Jan 2023 10:22:34 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:22:33 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 00/24] Add basic ACPI support for RISC-V
Date:   Mon, 30 Jan 2023 23:52:01 +0530
Message-Id: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables the basic ACPI infrastructure for RISC-V.
Supporting external interrupt controllers is in progress and hence it is
tested using polling based HVC SBI console and RAM disk.

The series depends on Anup's IPI improvement series.
https://github.com/avpatel/linux/commits/riscv_ipi_imp_v17

These changes are available at
https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17

Testing:
1) Build Qemu with ACPI support using below branch
https://github.com/vlsunil/qemu/tree/acpi_b1_us_review

2) Build EDK2 as per instructions in
https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support

3) Build Linux after enabling SBI HVC and SBI earlycon
CONFIG_RISCV_SBI_V01=y
CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
CONFIG_HVC_RISCV_SBI=y

4) Build buildroot.

Run with below command.
qemu-system-riscv64   -nographic \
-drive file=Build/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
-machine virt,acpi=on -smp 16 -m 2G \
-kernel arch/riscv/boot/Image \
-initrd buildroot/output/images/rootfs.cpio \
-append "root=/dev/ram ro console=hvc0 earlycon=sbi"

Jisheng Zhang (1):
  riscv: move sbi_init() earlier before jump_label_init()

Sunil V L (23):
  ACPICA: MADT: Add RISC-V INTC interrupt controller
  ACPICA: Add structure definitions for RISC-V RHCT
  RISC-V: ACPI: Add empty headers to enable ACPI core
  RISC-V: ACPI: Add basic functions to build ACPI core
  RISC-V: ACPI: Add PCI functions to build ACPI core
  RISC-V: ACPI: Enable ACPI build infrastructure
  ACPI: Enable ACPI_PROCESSOR for RISC-V
  ACPI: OSL: Make should_use_kmap() 0 for RISC-V.
  ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
  RISC-V: ACPI: irqchip/riscv-intc: Add ACPI support
  RISC-V: ACPI: smpboot: Create wrapper smp_setup()
  RISC-V: ACPI: smpboot: Add ACPI support in smp_setup()
  RISC-V: ACPI: smpboot: Add function to retrieve the hartid
  clocksource/timer-riscv: Refactor riscv_timer_init_dt()
  RISC-V: ACPI: clocksource/timer-riscv: Add ACPI support
  ACPI: RISC-V: drivers/acpi: Add RHCT related code
  RISC-V: ACPI: time.c: Add ACPI support for time_init()
  RISC-V: ACPI: cpufeature: Add ACPI support in riscv_fill_hwcap()
  RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
  RISC-V: ACPI: Add ACPI initialization in setup_arch()
  RISC-V: ACPI: Enable ACPI in defconfig
  MAINTAINERS: Add entry for drivers/acpi/riscv
  Documentation/kernel-parameters.txt: Add RISC-V for ACPI parameter

 .../admin-guide/kernel-parameters.txt         |   6 +-
 MAINTAINERS                                   |   7 +
 arch/riscv/Kconfig                            |   5 +
 arch/riscv/configs/defconfig                  |   4 +
 arch/riscv/include/asm/acenv.h                |  17 ++
 arch/riscv/include/asm/acpi.h                 |  87 +++++++++
 arch/riscv/include/asm/cpu.h                  |   9 +
 arch/riscv/kernel/Makefile                    |   3 +
 arch/riscv/kernel/acpi.c                      | 178 ++++++++++++++++++
 arch/riscv/kernel/cpu.c                       |  36 +++-
 arch/riscv/kernel/cpufeature.c                |  45 ++++-
 arch/riscv/kernel/pci.c                       | 173 +++++++++++++++++
 arch/riscv/kernel/setup.c                     |  21 ++-
 arch/riscv/kernel/smpboot.c                   |  99 +++++++++-
 arch/riscv/kernel/time.c                      |  25 ++-
 drivers/acpi/Kconfig                          |   2 +-
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/osl.c                            |   2 +-
 drivers/acpi/processor_core.c                 |  28 +++
 drivers/acpi/riscv/Makefile                   |   2 +
 drivers/acpi/riscv/rhct.c                     |  93 +++++++++
 drivers/clocksource/timer-riscv.c             |  88 ++++-----
 drivers/irqchip/irq-riscv-intc.c              |  79 ++++++--
 include/acpi/actbl2.h                         |  69 ++++++-
 24 files changed, 994 insertions(+), 86 deletions(-)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c
 create mode 100644 arch/riscv/kernel/pci.c
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

-- 
2.38.0

